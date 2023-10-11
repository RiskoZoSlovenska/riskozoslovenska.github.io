/*
	Plays the fragments "game". One fragment at a time is chosen from the pool
	of fragments (the empty "dummy" fragment has a very high chance of being
	chosen). The chosen fragment is then unhidden and randomly placed on the
	canvas (hopefully so that it does overflow nor intersect a previous
	fragment). The program then waits till the user hovers over and out of the
	fragment, then hides it and places the next one.

	The dummy fragment is the only fragment which can be used twice or more in a
	row because it's not visible and thus doesn't look ugly when it teleports
	away even when "opaque".
*/
{

const CANVAS_ID = "fragments-canvas"
const DUMMY_ID = "dummy-fragment"
const ACTIVE_ATTRIBUTE = "data-active"
const UNFOCUS_EVENT = "mouseleave"
const DEVTOOLS_EVENT = "custom_devtools-changed"

const FRAGMENT_CHANCE = 0.15
const REMOVE_DELAY = 1000

let canvas = document.getElementById(CANVAS_ID)
let dummyFragment = document.getElementById(DUMMY_ID)
let fragments = Array.from(canvas.children).filter(fragment => fragment !== dummyFragment)

if (fragments.length < 2) {
	throw "requires at least two fragments"
} else {
	fragments.forEach(fragment => fragment.remove())
}

let currentFragment = null



function onMouseLeave(event) {
	let fragment = event.target

	// Unbind, deactivate, invoke next fragment
	fragment.removeEventListener(UNFOCUS_EVENT, onMouseLeave)
	fragment.removeAttribute(ACTIVE_ATTRIBUTE)
	setTimeout(() => (fragment !== currentFragment) && fragment.remove(), REMOVE_DELAY)

	nextFragment()
}


function getRandomFragment() {
	if (Math.random() >= FRAGMENT_CHANCE) {
		return dummyFragment;
	}

	console.log("Choosing real fragment")

	let fragment
	do {
		fragment = fragments[Math.floor(Math.random() * fragments.length)] // Random fragment
	} while (fragment == currentFragment) // Don't allow same fragment as previous

	return fragment
}

function positionFragment(fragment) {
	let rect = fragment.getBoundingClientRect()
	let x = Math.floor(Math.random() * (canvas.clientWidth - rect.width))
	let y = Math.floor(Math.random() * (canvas.clientHeight - rect.height))

	fragment.style.transform = `translate(${x}px, ${y}px)` // top and left are buggy with SVGs in Firefox

	console.log("Fragment positioned at " + x + "x" + y)
}

function repositionCurrentFragment() {
	if (!currentFragment) {
		throw "No current fragment!"
	}

	positionFragment(currentFragment)
}


function readyFragment(fragment) {
	canvas.appendChild(fragment)

	positionFragment(fragment)

	fragment.setAttribute(ACTIVE_ATTRIBUTE, true)
	fragment.addEventListener(UNFOCUS_EVENT, onMouseLeave)
}

function nextFragment() {
	let fragment = getRandomFragment()
	readyFragment(fragment)
	currentFragment = fragment
}


window.addEventListener("resize", repositionCurrentFragment)
document.addEventListener(DEVTOOLS_EVENT, event => {
	if (!currentFragment) { return }

	if (event.detail) {
		currentFragment.remove()
	} else {
		canvas.appendChild(currentFragment)
	}
})
nextFragment()

}