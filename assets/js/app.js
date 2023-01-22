// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", info => topbar.delayedShow(200))
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

let score = 0
window.foo = function () {
  console.log(`you clicked the button! score: ${++score}`)
}

import {Editor} from "@tiptap/core"
import StarterKit from "@tiptap/starter-kit"
import Highlight from "@tiptap/extension-highlight"
import Typography from "@tiptap/extension-typography"

const editor = new Editor({
  element: document.querySelector(".element"),
  extensions: [StarterKit, Highlight, Typography],
  content:
    "<p><strong>read a danmei novel that is not wuxia, xianxia, or xuanhuan</strong></p><p><em>how do aspects of worldbuilding differ across genres? what new aspects of culture, character, or language do you observe in a different genre setting? how much character or worldbuilding do you think is attributable to genre convention, and how much isn’t? what do you think readers find attractive about wuxia/xianxia/xuanhuan settings? what do you think readers find attractive about other genres?</em></p><p><strong>read a danmei novel set in modern day China</strong></p><p><em>how do the emotional and narrative stakes of novels change depending on time period? what were you surprised by? what similarities or resonances did you recognize between the text and your own life? how does the fabric of the setting in this novel differ from novels set in other time periods and settings? in what ways do class and power factor into character conflicts and relationships? how do these differ from the way class and power are addressed in historical novels? what is the role of tradition and history in this novel? do you find the text more realistic because it’s set in modern day? why or why not? how important do you think “realism” is to the text and the readers? why might this be? how important is “realism” to your reading experience? why might this be?</em></p><p></p>",
  placeholder: "Write something …",
})

// save editor content
const saveButton = document.querySelector("#save-button")
const SERVER_URL = "http://localhost:4000/api/posts"
saveButton.addEventListener("click", async () => {
  console.log(editor.getHTML())

  bodyObj = {
    post: {
      title: "test",
      subtitle: "test",
      content: editor.getHTML(),
      is_draft: false,
    },
  }

  const response = await fetch(SERVER_URL, {
    method: "POST",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    body: JSON.stringify(bodyObj),
    credentials: "include",
  })

  response.json().then(data => {
    console.log(data)
    window.location.replace("http://localhost:4000/posts")
  })
})

console.log("end of script!")
