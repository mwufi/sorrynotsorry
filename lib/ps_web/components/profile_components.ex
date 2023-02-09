defmodule PsWeb.ProfileComponents do
  use Phoenix.Component

  # Routes generation with the ~p sigil
  use Phoenix.VerifiedRoutes,
    endpoint: PsWeb.Endpoint,
    router: PsWeb.Router,
    statics: PsWeb.static_paths()

  @doc """
  A post component
  """
  attr(:padding, :string, default: "my-4 px-5")
  attr(:profile, Ps.Profiles.Profile, required: true)
  attr(:show_picture, :boolean, default: true)

  def small_header(assigns) do
    if assigns[:profile] do
      ~H"""
      <div class={"post-header #{assigns.padding} flex items-center"}>
        <%= if @show_picture do %>
          <img src={@profile.avatar_url} class="w-8 h-8 rounded mr-3" />
        <% end %>
        <.link href={~p"/#{@profile.username}"} class="font-bold text-gray-700 text-sm">
          <%= @profile.username %>
        </.link>
      </div>
      """
    else
      ~H"""
      <div class={"post-header #{assigns.padding} flex items-center"}>
        <img
          src="data:image/jpeg;base64,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"
          class="w-8 h-8 rounded"
        />
        <div class="font-bold text-gray-700 ml-3 text-sm">anonymous user</div>
      </div>
      """
    end
  end

  @doc """
  A nice yellow header for the top of the post
  """
  def big_header(assigns) do
    ~H"""
    <div class="top-0 left-0 right-0 bg-yellow-50 z-10">
      <div class="flex items-center gap-4 p-4">
        <img
          src={@profile.avatar_url}
          class="h-10 w-10 rounded-full"
        />
        <div class="flex-1">
          <div class="text-gray-700 font-bold"><%= @profile.username %></div>
          <div class="text-gray-400 text-sm">1 hour ago</div>
        </div>
        <div class="text-gray-400 text-sm">...</div>
      </div>
    </div>
    """
  end

  @doc """
  A helper component that allows you to a sticky profile pic
  to the left of the post
  """
  def sticky_header(assigns) do
    ~H"""
    <div class="absolute top-0 left-0 h-full z-20">
      <div class="sticky top-[2em]">
        <div class="flex items-center h-16 w-16">
          <img
            src={@profile.avatar_url}
            class="h-full w-full rounded"
          />
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Displays a text post, comments and all!
  """
  def post(%{type: "text_post"} = assigns) do
    ~H"""
    <div class="relative flex justify-end grow">
      <div class="bg-white rounded overflow-hidden w-full max-w-[540px]">
        <div class="md:hidden">
          <.big_header profile={@profile} />
        </div>
        <div class="hidden md:block">
          <.sticky_header profile={@profile} />
          <.small_header profile={@profile} show_picture={false}/>
        </div>
        <div class="text-gray-700 my-4 px-5 whitespace-pre-wrap"><%= @text |> String.trim() %></div>
        <div class="FOOTER p-4">
          <%!-- <.comment text={@comment} />
          <a class="text-gray-400 text-sm mt-3 cursor-pointer hover:text-purple-400">View more...</a>
          <div class="text-gray-400 text-sm mt-3">1 hour ago</div> --%>
          <%!-- <div class="spacer mb-6" /> --%>
          <.action_bar />
        </div>
      </div>
    </div>
    """
  end

  def post(%{type: "image_post"} = assigns) do
    ~H"""
    <div class="relative">
      <div class="bg-white rounded overflow-hidden">
        <.small_header profile={@profile} />
        <img class="w-full" src={@image} />
        <div class="FOOTER p-4">
          <.comment text={@comment} />
          <a class="text-gray-400 text-sm mt-3 cursor-pointer hover:text-purple-400">View more...</a>
          <div class="text-gray-400 text-sm mt-3">1 hour ago</div>
          <div class="spacer mb-6" />
          <.action_bar />
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Displays how many notes a post has and some action buttons
  """
  def action_bar(assigns) do
    ~H"""
    <div class="flex">
      <a class="left font-medium text-gray-500">12,523 notes</a>
      <div class="ml-auto flex gap-2">
        <Heroicons.ellipsis_horizontal class="w-6 h-6" />
        <Heroicons.arrow_path_rounded_square class="w-6 h-6" />
        <Heroicons.heart class="w-6 h-6" />
      </div>
    </div>
    """
  end

  @doc """
  Displays a comment
  """
  def comment(assigns) do
    ~H"""
    <div class="ONE-COMMENT">
      <span class="COMMENT-USER font-bold">
        <span class="COMMENT-USER-NAME">John Doe</span>
      </span>
      <span class="COMMENT-TEXT"><%= @text %></span>
    </div>
    """
  end

  @doc """
  On the sidebar, this is a profile you can follow
  """
  def profile_card(assigns) do
    ~H"""
    <div class="flex items-center gap-3 p-2 rounded hover:bg-gray-300">
      <.link navigate={~p"/#{@profile.username}"}>
      <img
        src={@profile.avatar_url}
        class="h-10 w-10 rounded"
      />
      </.link>
      <div class="flex-1">
        <.link navigate={~p"/#{@profile.username}"}>
        <div class="text-gray-700 font-bold"><%= @profile.username %></div>
        </.link>
        <div class="text-gray-400 text-sm">1 hour ago</div>
      </div>
      <div class="text-gray-400 text-sm">...</div>
    </div>
    """
  end
end
