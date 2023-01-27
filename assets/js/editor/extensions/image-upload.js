import {Plugin, PluginKey, Selection} from "prosemirror-state"
import {Image} from "@tiptap/extension-image"

/**
 * Plugin for the tiptap editor that adds images to the editor
 * @see https://github.com/scrumpy/tiptap/blob/0f17abeee6df1a8b40c6c96413a158918ec45d34/packages/tiptap-extensions/src/nodes/Image.js
 * This class overwrites the default `image`. You need to make sure to **not** use the original class.
 */
const ImageUpload = Image.extend({
  addProseMirrorPlugins() {
    const {uploader} = this.options
    return [
      new Plugin({
        props: {
          handleDOMEvents: {
            paste(view, event) {
              const items = (event.clipboardData || event.originalEvent.clipboardData).items
              if (!uploader) {
                return
              }
              Array.from(items).forEach(async item => {
                const {schema} = view.state
                const image = item.getAsFile()
                // Return here, otherwise copying texts won't possible anymore
                if (!image) {
                  return
                }
                event.preventDefault()
                const imageSrc = await uploader(image)
                const node = schema.nodes.image.create({
                  src: imageSrc,
                })
                const transaction = view.state.tr.replaceSelectionWith(node)
                view.dispatch(transaction)
              })
            },
            drop(view, event) {
              const hasFiles = event.dataTransfer.files.length > 0
              if (!hasFiles) {
                return
              }
              event.preventDefault()
              const images = event.dataTransfer.files
              const {schema} = view.state
              const coordinates = view.posAtCoords({
                left: event.clientX,
                top: event.clientY,
              })
              images.forEach(async image => {
                if (!uploader) {
                  return
                }
                const imageSrc = await uploader(image)
                if (imageSrc) {
                  const node = schema.nodes.image.create({
                    src: imageSrc,
                  })
                  const transaction = view.state.tr.insert(coordinates.pos, node)
                  view.dispatch(transaction)
                }
              })
            },
          },
        },
      }),
    ]
  },
})

export default ImageUpload
