/**
 * Funny meme script. Enables an overlay whenever devtools are opened. Spams
 * console, but only a little bit.
 */

const OVERLAY_ID = "cheating-overlay"
const OPEN_ATTRIB_NAME = "data-devtools-open"
const UPDATE_INTERVAL = 250 // Milliseconds

function update(isOpened) {
	let overlay = document.getElementById(OVERLAY_ID)
	if (!overlay) {
		throw "No overlay found!"
	}

	overlay.setAttribute(OPEN_ATTRIB_NAME, isOpened)
}


// https://stackoverflow.com/a/30638226
let isOpened = false
let object = /./;
object.toString = function() {
	isOpened = true
	return "Devtools is open"
};

setInterval(() => {
	update(isOpened)

	isOpened = false
	console.log(object);
}, UPDATE_INTERVAL)