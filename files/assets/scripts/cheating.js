"use strict";
/**
 * Funny meme script. Enables an overlay whenever devtools are opened. Likely
 * will break sometime soon.
 *
 * Heavily adapted from https://github.com/sindresorhus/devtools-detect
 * Permalink: https://github.com/sindresorhus/devtools-detect/blob/73719507f1ade1da63f64d3c72c487e3d2667aba/index.js
 */
{

const OVERLAY_ID = "cheating-overlay"
const OPEN_ATTRIB_NAME = "data-devtools-open"
const EVENT_NAME = "custom_devtools-changed"
const UPDATE_INTERVAL = 250 // Milliseconds
const THRESHOLD = 160; // idk


function update(isOpened) {
	console.log("Devtools were " + (isOpened ? "opened" : "closed"))

	document.dispatchEvent(new CustomEvent(EVENT_NAME, { detail: isOpened }))

	let overlay = document.getElementById(OVERLAY_ID)
	if (overlay) {
		overlay.setAttribute(OPEN_ATTRIB_NAME, isOpened)
	} else {
		throw "No overlay found!"
	}
}


let wasOpened = false
setInterval(() => {
	let widthThreshold = globalThis.outerWidth - globalThis.innerWidth > THRESHOLD;
	let heightThreshold = globalThis.outerHeight - globalThis.innerHeight > THRESHOLD;

	let isOpened =
		!(heightThreshold && widthThreshold)
		&& (globalThis?.Firebug?.chrome?.isInitialized || widthThreshold || heightThreshold)

	if (isOpened != wasOpened) {
		update(isOpened)
		wasOpened = isOpened
	}
}, UPDATE_INTERVAL)

}
