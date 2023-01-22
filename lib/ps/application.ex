defmodule Ps.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PsWeb.Telemetry,
      # Start the Ecto repository
      Ps.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Ps.PubSub},
      # Start Finch
      {Finch, name: Ps.Finch},
      # Start the Endpoint (http/https)
      PsWeb.Endpoint
      # Start a worker by calling: Ps.Worker.start_link(arg)
      # {Ps.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ps.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
