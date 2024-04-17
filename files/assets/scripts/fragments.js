"use strict";






































// cheater.

































/*
	Plays the fragments "game". One piece of content at a time is chosen from
	the pool of fragments (the empty "dummy" content has a very high chance of
	being chosen). The fragment then receives the chosen content, is randomly
	placed somewhere on the canvas and is then activated (an "active" fragment
	is one that reveals itself when hovered). When it is hovered *off* of (after
	being hovered on), it is deactivated until it transitions to transparent and
	then is repositioned with new content.
*/
{

let CANVAS = document.getElementById("fragments-canvas")
let FRAGMENT = document.getElementById("fragment")

const ACTIVE_ATTRIBUTE = "data-active"
const LOADING_CLASS = "loading"
const DEVTOOLS_EVENT = "custom_devtools-changed"

const FRAGMENT_CHANCE = 0.15
const MOVE_DELAY = 550 // ms between mouseleave and reposition (lets the fragment fade out)
const ACTIVATE_DELAY = 100 // ms between repositioning and marking as active (prevents reposition firing mouseleave)

let FRAGMENTS = [
	"Fragments, twinkling like forgotten stars of the Abyss.",
	"The waking edge, where reality bleeds and dreams die.",
	"… demand to be put into hypnagogia immediately and indefinitely.",
	"All fear the Tearing, all run from the Tearing, for-",
	"Kept in line by the bloodied edge of failure.",
	"Walking with the dead makes you feel alive.",
	"Where was the part where [I] grew up?",
	"Is that the future so bright or the radiation sickness?",
	"The fire’s brighter than all of our futures, somehow.",
	"Eat the devil or there’s nothing you can do.",
	"[We] should be growing up, but instead [We]’re growing old.",
	"!",
	"Mayday. Mayday. Out.",
	"<em>Click.</em>",
	"ᓚᘏᗢ",
	`<svg class="fill-gray-100 box-content" height="90" viewBox="0 0 73 41" xmlns="http://www.w3.org/2000/svg">
		<path id="g-fragment-main" d="M0,13  l10,3  h3  v-12  a11,15 0,0,0 -13,-2  z" />
		<use href="#g-fragment-main" x="20" />
		<use href="#g-fragment-main" x="40" />
		<use href="#g-fragment-main" x="60" />
		<use href="#g-fragment-main" y="23" />
		<use href="#g-fragment-main" x="20" y="23" />
		<use href="#g-fragment-main" x="40" y="23" />
		<use href="#g-fragment-main" x="60" y="23" />
	</svg>`,
	`<svg class="fill-gray-100 box-content" height="24" viewBox="0 0 13339 6000" xmlns="http://www.w3.org/2000/svg" style="fill-rule:evenodd;text-rendering:geometricPrecision;image-rendering:optimizeQuality;clip-rule:evenodd;shape-rendering:geometricPrecision" >
		<path d="M6187 5200c-1998 0-2753-2124-2831-2595-79-472-169-711-503-770s-245 275-297 460c-52 186-497 1632-1113 1707-616 74-1068-482-1239-1113s-275-1966-148-2189c126-223 401-208 868-111 467 96 1098 341 1447 393s2018 237 2078 237c59 0 15 96 386 111 1380 55 2706 139 3361 1521l2664-542c374-76 1825-482 2085-571s378 15 386 163c7 148 37 557-89 1469-126 913-341 134-245-111s226-1281 115-1304c-589-3-2791 656-4871 1207 0 0 22 586-260 1068s-816 1024-1793 969zm-4462-4223c215 37 2056 379 2512 364-441 80-905 282-935 619-48-105-611-558-864-159-30-221-100-312-712-824z" />
		<path d="M2000 1500l2664-542c374-76 1825-482 2085-571s378 15 386 163c7 148 37 557-89 1469-126 913-341 134-245-111s226-1281 115-1304c-589-3-2791 656-4871 1207 0 0 22 586-260 1068z" />
	</svg>`,
]

if (FRAGMENTS.length < 2) {
	throw "requires at least two fragments"
}

let currentContent = ""
let devtoolsOpen = false


function getRandomFragmentContent() {
	if (Math.random() >= FRAGMENT_CHANCE) {
		return "";
	}

	console.log("Choosing real fragment")

	let content
	do {
		content = FRAGMENTS[Math.floor(Math.random() * FRAGMENTS.length)] // Random fragment
	} while (content == currentContent) // Don't allow same fragment as previous

	return content
}

function repositionFragment() {
	let rect = FRAGMENT.getBoundingClientRect()
	let x = Math.floor(Math.random() * (CANVAS.clientWidth - rect.width))
	let y = Math.floor(Math.random() * (CANVAS.clientHeight - rect.height))

	FRAGMENT.style.transform = `translate(${x}px, ${y}px)` // top and left are buggy with SVGs in Firefox
}

function newFragment() {
	console.log("New fragment")

	currentContent = getRandomFragmentContent()
	FRAGMENT.innerHTML = currentContent

	repositionFragment()

	setTimeout(() => {
		FRAGMENT.setAttribute(ACTIVE_ATTRIBUTE, true)
	}, ACTIVATE_DELAY);
}

function onMouseLeave() {
	if (!FRAGMENT.hasAttribute(ACTIVE_ATTRIBUTE) || devtoolsOpen) { return }

	console.log("Mouse left")
	FRAGMENT.removeAttribute(ACTIVE_ATTRIBUTE)
	setTimeout(newFragment, MOVE_DELAY)
}


CANVAS.classList.remove(LOADING_CLASS)

FRAGMENT.addEventListener("mouseleave", onMouseLeave)
window.addEventListener("resize", repositionFragment)
document.addEventListener(DEVTOOLS_EVENT, event => {
	devtoolsOpen = event.detail
	FRAGMENT.innerHTML = devtoolsOpen ? "" : currentContent
})
newFragment()

}
