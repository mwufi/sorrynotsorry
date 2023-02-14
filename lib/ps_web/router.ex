defmodule PsWeb.Router do
  use PsWeb, :router

  import PsWeb.UserAuth

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {PsWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(:fetch_current_user)
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
    plug(:fetch_current_user)
  end

  scope "/", PsWeb do
    pipe_through(:browser)

    get("/", PageController, :home)
    get("/p/:permalink", PostController, :show_permalink)
    get("/test/:page", PageController, :plain_html)
    live("/live", PageLive, :other)

    get("/posts/new", PageController, :editor)
    resources("/posts", PostController, only: [:index, :show])

    live "/test_upload", TestLive.Index, :index

    # Profile links (temporary)
    live("/links", LinkLive.Index, :index)
    live("/links/new", LinkLive.Index, :new)
    live("/links/:id/edit", LinkLive.Index, :edit)

    live("/links/:id", LinkLive.Show, :show)
    live("/links/:id/show/edit", LinkLive.Show, :edit)

    # Show profiles
    live("/profiles", ProfileLive.Index, :index)
    live("/profiles/new", ProfileLive.Index, :new)
  end

  scope "/", PsWeb do
    pipe_through([:browser, :require_authenticated_user])

    # Tweets
    live("/tweets/new", TweetLive.Index, :new)
    live("/tweets/:id/edit", TweetLive.Index, :edit)
    live("/tweets/:id/show/edit", TweetLive.Show, :edit)

    resources("/posts", PostController, except: [:index, :new, :show])

    live("/:username/edit", ProfileLive.Index, :edit)
    live("/:username/show/edit", ProfileLive.Show, :edit)

    get("/:username/github", PageController, :github)
  end

  scope "/", PsWeb do
    pipe_through([:browser])

    # Tweets (temporary)
    live("/tweets", TweetLive.Index, :index)
    live("/tweets/:id", TweetLive.Show, :show)

    live("/:username", ProfileLive.Show, :show)
  end

  # Other scopes may use custom stacks.
  scope "/api", PsWeb do
    pipe_through(:api)

    post("/posts", PostApiController, :create)
    patch("/posts/:id", PostApiController, :update)
    get("/uploads/new", UploadApiController, :new)
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:ps, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through(:browser)

      live_dashboard("/dashboard", metrics: PsWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end

  ## Authentication routes

  scope "/", PsWeb do
    pipe_through([:browser, :redirect_if_user_is_authenticated])

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{PsWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live("/users/register", UserRegistrationLive, :new)
      live("/users/log_in", UserLoginLive, :new)
      live("/users/reset_password", UserForgotPasswordLive, :new)
      live("/users/reset_password/:token", UserResetPasswordLive, :edit)
    end

    post("/users/log_in", UserSessionController, :create)
  end

  scope "/", PsWeb do
    pipe_through([:browser, :require_authenticated_user])

    live_session :require_authenticated_user,
      on_mount: [{PsWeb.UserAuth, :ensure_authenticated}] do
      live("/users/settings", UserSettingsLive, :edit)
      live("/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email)
    end
  end

  scope "/", PsWeb do
    pipe_through([:browser])

    delete("/users/log_out", UserSessionController, :delete)

    live_session :current_user,
      on_mount: [{PsWeb.UserAuth, :mount_current_user}] do
      live("/users/confirm/:token", UserConfirmationLive, :edit)
      live("/users/confirm", UserConfirmationInstructionsLive, :new)
    end
  end
end
