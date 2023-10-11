/*
	Script for code block functionality, such as highlighting and (in the
	future) line numbers and a "copy" button.

	Use as <script src=".../code-blocks.js" type="module">
*/
{

// Highlighting
let element = document.createElement("link")
element.rel = "stylesheet"
element.href = new URL(import.meta.url).pathname + "/" + "../../styles/hjs-theme.css"
document.head.appendChild(element)
console.log("Loaded code styles")

}

import hljs from "https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@11.7.0/build/es/highlight.min.js"
hljs.highlightAll()
console.log("Loaded highlighter")