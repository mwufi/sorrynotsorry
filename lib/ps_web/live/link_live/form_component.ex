defmodule PsWeb.LinkLive.FormComponent do
  use PsWeb, :live_component

  alias Ps.Links

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage link records in your database.</:subtitle>
      </.header>

      <.simple_form
        :let={f}
        for={@changeset}
        id="link-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={{f, :name}} type="text" label="Name" />
        <.input field={{f, :href}} type="text" label="Href" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Link</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{link: link} = assigns, socket) do
    changeset = Links.change_link(link)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"link" => link_params}, socket) do
    changeset =
      socket.assigns.link
      |> Links.change_link(link_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"link" => link_params}, socket) do
    save_link(socket, socket.assigns.action, link_params)
  end

  defp save_link(socket, :edit, link_params) do
    case Links.update_link(socket.assigns.link, link_params) do
      {:ok, _link} ->
        {:noreply,
         socket
         |> put_flash(:info, "Link updated successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_link(socket, :new, link_params) do
    case Links.create_link(link_params) do
      {:ok, _link} ->
        {:noreply,
         socket
         |> put_flash(:info, "Link created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
