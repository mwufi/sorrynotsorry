defmodule PsWeb.Twitter.Tweet do
  use Phoenix.LiveComponent
  import PsWeb.ProfileComponents

  def c(assigns) do
    ~H"""
    <div class="relative flex justify-end grow">
      <div class="bg-white rounded overflow-hidden w-full max-w-[540px]">
        <div class="md:hidden">
          <.big_header profile={@profile} />
        </div>
        <div class="hidden md:block">
          <div class="absolute top-4 left-6 h-full z-20">
            <div class="top-[2em]">
              <div class="flex items-center h-12 w-12">
                <img
                  src={@profile.avatar_url}
                  class="h-full w-full rounded-full"
                />
              </div>
            </div>
          </div>
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
end
