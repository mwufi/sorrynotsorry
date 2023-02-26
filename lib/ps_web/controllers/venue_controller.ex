defmodule PsWeb.VenueController do
  use PsWeb, :controller

  alias Ps.Venues
  alias Ps.Venues.Venue

  def index(conn, _params) do
    venues = Venues.list_venues()
    render(conn, :index, venues: venues)
  end

  def new(conn, _params) do
    changeset = Venues.change_venue(%Venue{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"venue" => venue_params}) do
    case Venues.create_venue(venue_params) do
      {:ok, venue} ->
        conn
        |> put_flash(:info, "Venue created successfully.")
        |> redirect(to: ~p"/venues/#{venue}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    venue = Venues.get_venue!(id)
    render(conn, :show, venue: venue)
  end

  def edit(conn, %{"id" => id}) do
    venue = Venues.get_venue!(id)
    changeset = Venues.change_venue(venue)
    render(conn, :edit, venue: venue, changeset: changeset)
  end

  def update(conn, %{"id" => id, "venue" => venue_params}) do
    venue = Venues.get_venue!(id)

    case Venues.update_venue(venue, venue_params) do
      {:ok, venue} ->
        conn
        |> put_flash(:info, "Venue updated successfully.")
        |> redirect(to: ~p"/venues/#{venue}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, venue: venue, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    venue = Venues.get_venue!(id)
    {:ok, _venue} = Venues.delete_venue(venue)

    conn
    |> put_flash(:info, "Venue deleted successfully.")
    |> redirect(to: ~p"/venues")
  end
end
