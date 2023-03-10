defmodule PsWeb.Twitter.Tweet do
  use Phoenix.LiveComponent
  import PsWeb.ProfileComponents

  def big(assigns) do
    ~H"""
    <div class="relative flex justify-end grow">
      <div class="bg-white rounded overflow-hidden w-full max-w-[540px]">
        <div class="md:hidden select-none">
          <.big_header profile={@tweet.profile} />
        </div>
        <div class="hidden md:block select-none">
          <div class="absolute top-4 left-6 h-full z-20">
            <div class="top-[2em]">
              <div class="flex items-center h-12 w-12">
                <img
                  src={@tweet.profile.avatar_url}
                  class="h-full w-full rounded-full"
                />
              </div>
            </div>
          </div>
          <.small_header profile={@tweet.profile} show_picture={false}/>
        </div>
        <div class="text-gray-700 text-xl my-4 px-5 whitespace-pre-wrap"><%= @tweet.content |> String.trim() %></div>
        <div class="FOOTER p-4">
          <%!-- <.comment text={@comment} />
          <a class="text-gray-400 text-sm mt-3 cursor-pointer hover:text-purple-400">View more...</a>
          <div class="text-gray-400 text-sm mt-3">1 hour ago</div> --%>
          <%!-- <div class="spacer mb-6" /> --%>
          <div class="flex">
            <a class="left font-medium text-gray-500"><%= @tweet.likes_count %> likes</a>
            <div class="ml-auto flex gap-2">
              <button phx-click="like" phx-value-id={@tweet.id}>
                <Heroicons.heart class="w-6 h-6" />
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
  def c(assigns) do
    ~H"""
    <div class="relative flex justify-end grow">
      <div class="bg-white rounded overflow-hidden w-full max-w-[540px]">
        <div class="md:hidden select-none">
          <.big_header profile={@tweet.profile} />
        </div>
        <div class="hidden md:block select-none">
          <div class="absolute top-4 left-6 h-full z-20">
            <div class="top-[2em]">
              <div class="flex items-center h-12 w-12">
                <img
                  src={@tweet.profile.avatar_url}
                  class="h-full w-full rounded-full"
                />
              </div>
            </div>
          </div>
          <.small_header profile={@tweet.profile} show_picture={false}/>
        </div>

        <%= if assigns[:navigate] do %>
        <.link navigate={@navigate}>
          <div class="text-gray-700 my-4 px-5 whitespace-pre-wrap"><%= @tweet.content |> String.trim() %></div>
        </.link>
        <% else %>
          <div class="text-gray-700 my-4 px-5 whitespace-pre-wrap"><%= @tweet.content |> String.trim() %></div>
        <% end %>
        <div class="FOOTER p-4">
          <%!-- <.comment text={@comment} />
          <a class="text-gray-400 text-sm mt-3 cursor-pointer hover:text-purple-400">View more...</a>
          <div class="text-gray-400 text-sm mt-3">1 hour ago</div> --%>
          <%!-- <div class="spacer mb-6" /> --%>
          <div class="flex">
            <a class="left font-medium text-gray-500"><%= @tweet.likes_count %> likes</a>
            <div class="ml-auto flex gap-2">
              <button phx-click="like" phx-value-id={@tweet.id}>
                <Heroicons.heart class="w-6 h-6" />
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
