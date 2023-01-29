defmodule PsWeb.PageHTML do
  use PsWeb, :html

  embed_templates("page_html/*")

  def nav_menu(assigns) do
    ~H"""
    <div class="LEFT-MENU flex-0 w-64 p-2 sticky top-0 max-h-screen">
      <a class="px-4 p-3 flex items-center gap-4 rounded-full hover:bg-gray-700 hover:text-gray-50 hover:cursor-pointer">
        <Heroicons.home class="h-6 w-6 stroke-current" />
        <div class="text-lg font-bold">Home</div>
      </a>
      <a class="px-4 p-3 flex items-center gap-4 rounded-full hover:bg-gray-700 hover:text-gray-50 hover:cursor-pointer">
        <Heroicons.chat_bubble_oval_left_ellipsis class="h-6 w-6 stroke-current" />
        <div class="text-lg">Messages</div>
      </a>
      <a class="px-4 p-3 flex items-center gap-4 rounded-full hover:bg-gray-700 hover:text-gray-50 hover:cursor-pointer">
        <Heroicons.magnifying_glass class="h-6 w-6 stroke-current" />
        <div class="text-lg">Search</div>
      </a>
      <a class="px-4 p-3 flex items-center gap-4 rounded-full hover:bg-gray-700 hover:text-gray-50 hover:cursor-pointer">
        <Heroicons.globe_asia_australia class="h-6 w-6 stroke-current" />
        <div class="text-lg">Explore</div>
      </a>
      <a class="px-4 p-3 flex items-center gap-4 rounded-full hover:bg-gray-700 hover:text-gray-50 hover:cursor-pointer">
        <Heroicons.heart class="h-6 w-6 stroke-current" />
        <div class="text-lg">Favorites</div>
      </a>
      <a class="px-4 p-3 flex items-center gap-4 rounded-full hover:bg-gray-700 hover:text-gray-50 hover:cursor-pointer">
        <Heroicons.paper_airplane class="h-6 w-6 stroke-current" />
        <div class="text-lg">Create</div>
      </a>
    </div>
    """
  end

  def posts(assigns) do
    # random images from the internet
    images = [
      "https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      "https://thumbs.dreamstime.com/b/beautiful-rain-forest-ang-ka-nature-trail-doi-inthanon-national-park-thailand-36703721.jpg",
      "https://1.bp.blogspot.com/-kK7Fxm7U9o0/YN0bSIwSLvI/AAAAAAAACFk/aF4EI7XU_ashruTzTIpifBfNzb4thUivACLcBGAsYHQ/s1280/222.jpg",
      "https://media.gettyimages.com/id/1297349747/photo/hot-air-balloons-flying-over-the-botan-canyon-in-turkey.jpg?s=612x612&w=gi&k=20&c=Uo_yzYm9UJu6GpKilOLGrCbiSjyMB5DsvZTYpybYxj4="
    ]

    posts =
      1..100
      |> Enum.map(fn _ ->
        %{
          text: "so glad to be here!",
          image: Enum.random(images)
        }
      end)

    ~H"""
    <%= for post <- posts do %>
      <.post image={post.image} text={post.text} />
    <% end %>
    """
  end

  def post(assigns) do
    ~H"""
    <div class="bg-white rounded overflow-hidden">
      <div class="post-header bg-white h-12 p-3">
        here's a post
      </div>
      <img class="w-full" src={@image}/>
      <div class="COMMENTS p-3">
        <.comment text={@text} />
        <a class="text-gray-400 text-sm mt-3 cursor-pointer hover:text-purple-400">View more...</a>
        <div class="text-gray-400 text-sm mt-3">1 hour ago</div>
      </div>
    </div>
    """
  end

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
end
