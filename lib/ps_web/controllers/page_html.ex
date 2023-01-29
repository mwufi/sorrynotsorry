defmodule PsWeb.PageHTML do
  use PsWeb, :html

  embed_templates("page_html/*")

  def nav_menu(assigns) do
    ~H"""
    <div class="LEFT-MENU flex-0 w-64 p-2 sticky top-0 max-h-screen">
      <a href="/" class="px-4 p-3 flex items-center gap-4 rounded-full hover:bg-gray-700 hover:text-gray-50 hover:cursor-pointer">
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
      <a href="/profiles" class="px-4 p-3 flex items-center gap-4 rounded-full hover:bg-gray-700 hover:text-gray-50 hover:cursor-pointer">
        <Heroicons.globe_asia_australia class="h-6 w-6 stroke-current" />
        <div class="text-lg">Everyone</div>
      </a>
      <a href="/posts" class="px-4 p-3 flex items-center gap-4 rounded-full hover:bg-gray-700 hover:text-gray-50 hover:cursor-pointer">
        <Heroicons.heart class="h-6 w-6 stroke-current" />
        <div class="text-lg">Your Posts</div>
      </a>
      <a href="/editor" class="px-4 p-3 flex items-center gap-4 rounded-full hover:bg-gray-700 hover:text-gray-50 hover:cursor-pointer">
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

    text_posts = [
      "Idea for a play: A custody battle of a corpse. A man - estranged from his birth family and deeply loved by found family - has unfortunately died. His parents that threw him out to the street, siblings who encouraged it, and extended family who never sided with him and simply allowed it to happen, now want to bury him in a family grave, under a name he didn't use anymore, with the ceremonies of a religion he never truly followed. The people who actually knew and loved him are trying everything in their power to stop this.

      The deceased, himself, is there, watching this with popcorn. It's clear that no-one but the audience can see him. He can pause the action whenever he wants to monologue, and often stops the show to tell the audience the backstory of a claim, or what really happened when someone is blatantly lying. And one time, just to call his grandmother a bitch.

      He is mainly indifferent to the show, simply entertained, no longer personally touched by anything that happens in the mortal world, but once, with tears in his eyes, takes a time to monologue about how deeply he loved his wife - whom he could not legally marry, but called wife nonetheless. Once, when his own cousin questions her presence here, as she was \"nothing to the deceased\", the protagonist throws the rest of his popcorn in the air, as - being incorporeal - he can't throw it at his cousin.

     (most of it lands into the audience. better not be wearing anything expensive in there, and if the friend who brought you to see this play didn't warn you about this part, that's kind of a dick move from them.)

      In the end it turns out there is some legal way, some previously forgotten document, new evidence, that allows the dead man to be buried by loved ones, and not his legal family. Despite of the fact that he has spent the whole play insisting that the events of the mortal world no longer concern him at all, and that he doesn't care what the outcome of this will be, his spirit dissipates from sheer relief.

     It's deliberately left ambiguous where souls go when they're gone.
     ",
      "nothing has brought me more joy than seeing rian johnson say fuck you to the unflappable asshole bbc sherlock detective archetype and bringing back the righteous and unendingly kind columbo detective archetype "
    ]

    posts =
      1..100
      |> Enum.map(fn _ ->
        %{
          profile: %{
            avatar_url:
              "https://64.media.tumblr.com/366ca17098c950dc97847e6648eb5cad/3aa4f0cbad47e8d7-e7/s64x64u_c1/37bb852c2dda058e8cc29f2e6f29f22388f9764c.jpg",
            username: "blessyouhawkeye"
          },
          comment: "so glad to be here!",
          image: Enum.random(images)
        }
      end)

    assigns = Map.merge(assigns, %{posts: posts, text_posts: text_posts})

    ~H"""
    <%= for text_post <- @text_posts do %>
      <.post
        type="text_post"
        text={text_post}
        comment="wow"
        profile={@posts |> Enum.at(0) |> Map.get(:profile)}
      />
    <% end %>
    <%= for post <- @posts do %>
      <.post type="image_post" image={post.image} comment={post.comment} profile={post.profile} />
    <% end %>
    """
  end

  def post(%{type: "text_post"} = assigns) do
    ~H"""
    <div class="relative">
      <div class="bg-white rounded overflow-hidden">
        <.small_header profile={@profile}/>
        <div class="text-gray-700 my-4 px-5 whitespace-pre-wrap"><%= @text |> String.trim() %></div>
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

  def post(%{type: "image_post"} = assigns) do
    ~H"""
    <div class="relative">
      <div class="bg-white rounded overflow-hidden">
        <.small_header profile={@profile}/>
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
