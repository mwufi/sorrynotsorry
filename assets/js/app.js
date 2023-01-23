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
  content: document.querySelector(".post-content").innerHTML,
  placeholder: "Write something …",
})

// save editor content
// const saveButton = document.querySelector("#save-button")

// saveButton.addEventListener("click")

window.updatePost = async id => {
  const SERVER_URL = `http://localhost:4000/api/posts/${id}`
  console.log(editor.getHTML())

  bodyObj = {
    id: id,
    post: {
      content: editor.getHTML(),
    },
  }

  await fetch(SERVER_URL, {
    method: "PATCH",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    body: JSON.stringify(bodyObj),
    credentials: "include",
  })
    .then(response => response.json())
    .then(json => {
      console.log(json)
      window.location.replace("http://localhost:4000/posts")
      alert("Successfully edited!")
    })
}

window.save = async () => {
  console.log(editor.getHTML())
  const SERVER_URL = `http://localhost:4000/api/posts`

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
}

console.log("end of script!")
