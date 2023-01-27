// Registers the lite-youtube custom element
import "@justinribeiro/lite-youtube"

import {Node, mergeAttributes} from "@tiptap/core"
import {Plugin, PluginKey} from "prosemirror-state"

// Captures the YouTube ID as the first matching group.
// Vendored 2021-10-07 from https://github.com/micnews/youtube-url/blob/master/index.js
const youtubeRegExp =
  /^(?:(?:https?:)?\/\/)?(?:www\.)?(?:m\.)?(?:youtu(?:be)?\.com\/(?:v\/|embed\/|watch(?:\/|\?v=))|youtu\.be\/)((?:\w|-){11})(?:\S+)?$/
const youtubeExtractId = url => {
  const match = youtubeRegExp.exec(url.trim())
  return match ? match[1] : false
}

const videoPlayerStaticAttributes = {nocookie: true}

const VideoPlayerNode = Node.create({
  name: "videoPlayer",
  // defaultOptions: {
  //   HTMLAttributes: {},
  // },
  content: "",
  marks: "",
  group: "block",
  draggable: true,

  addAttributes() {
    return {
      videoid: {
        default: null,
      },
      provider: {
        default: "youtube",
      },
    }
  },
  parseHTML() {
    return [
      {
        tag: "figure",
        getAttrs: el => {
          const videoEl = el.querySelector("lite-youtube")
          if (!videoEl) return false
          const videoid = videoEl.getAttribute("videoid")
          if (!videoid) return false
          return {
            videoid,
            provider: "youtube",
          }
        },
      },
      {
        tag: "lite-youtube",
      },
    ]
  },
  renderHTML({HTMLAttributes}) {
    // Assuming HTMLAttributes.provider is "youtube" for now
    return [
      "figure",
      {class: "doc-video-player"},
      ["lite-youtube", mergeAttributes(videoPlayerStaticAttributes, this.options.HTMLAttributes, HTMLAttributes)],
      [
        "figcaption",
        [
          "a",
          {
            href: `https://youtu.be/${HTMLAttributes.videoid}`,
            target: "_blank",
            rel: "noreferrer noopener nofollow",
          },
          "Watch on YouTube",
        ],
      ],
    ]
  },
  addCommands() {
    return {
      insertVideoPlayer:
        options =>
        ({chain, editor}) => {
          const {url} = options
          const videoid = youtubeExtractId(url)
          if (videoid) {
            const {selection} = editor.state
            const pos = selection.$head

            return chain()
              .insertContentAt(pos.before(), [
                {
                  type: this.name,
                  attrs: {videoid, provider: "youtube"},
                },
              ])
              .run()
          }
          return false
        },
    }
  },

  addProseMirrorPlugins() {
    return [
      new Plugin({
        key: new PluginKey("handlePasteVideoURL"),
        props: {
          handlePaste: (view, _event, slice) => {
            // Only look at one-line paste content
            if (slice.content.childCount !== 1) return false

            const {state} = view
            const {selection} = state
            const {empty} = selection

            // Pass through if something is selected
            if (!empty) return false

            const pos = selection.$head
            const node = pos.node()

            // Only continue if pasting on empty line
            if (node.content.size > 0) return false

            let textContent = ""

            slice.content.forEach(node => {
              textContent += node.textContent
            })

            const videoid = youtubeExtractId(textContent)

            if (!videoid) return false

            this.editor
              .chain()
              .insertContentAt(pos.before(), [
                {
                  type: this.name,
                  attrs: {videoid, provider: "youtube"},
                },
              ])
              .run()

            return true
          },
        },
      }),
    ]
  },
})

export default VideoPlayerNode
