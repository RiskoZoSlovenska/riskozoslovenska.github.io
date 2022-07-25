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

const CANVAS_ID = "fragments-canvas"
const DUMMY_ID = "dummy-fragment"
const ACTIVE_ATTRIBUTE = "data-active"
const UNFOCUS_EVENT = "mouseleave"

const FRAGMENT_CHANCE = 0.25

let canvas = document.getElementById(CANVAS_ID)
let dummyFragment = document.getElementById(DUMMY_ID)
let fragments = Array.from(canvas.children).filter(fragment => fragment !== dummyFragment)

let currentFragment = null



function onMouseLeave(event) {
	let fragment = event.target

	// Unbind, deactivate, invoke next fragment
	fragment.removeEventListener(UNFOCUS_EVENT, onMouseLeave)
	fragment.removeAttribute(ACTIVE_ATTRIBUTE)

	nextFragment()
}


function getRandomFragment() {
	if (Math.random() >= FRAGMENT_CHANCE) {
		return dummyFragment;
	}

	let fragment
	do {
		fragment = fragments[Math.floor(Math.random() * fragments.length)] // Random fragment
	} while (fragment == currentFragment) // Don't allow same fragment as previous

	return fragment
}

function getFragmentVertices(fragment, x, y) {
	let left = x ?? (parseFloat(fragment.style.left) || 0)
	let top = y ?? (parseFloat(fragment.style.top) || 0)
	let right = left + fragment.offsetWidth
	let bottom = top + fragment.offsetHeight

	return {
		left: left,
		top: top,
		right: right,
		bottom: bottom,
	}
}

function doFragmentsIntersect(fragment1, fragment2, fragment1X, fragment1Y) {
	if (!fragment1 || !fragment2) {
		return false
	}

	let vertices1 = getFragmentVertices(fragment1, fragment1X, fragment1Y)
	let vertices2 = getFragmentVertices(fragment2)

	// https://stackoverflow.com/a/306332
	return !(
		   vertices1.right <= vertices2.left
		|| vertices1.left >= vertices2.right
		|| vertices1.bottom <= vertices2.top
		|| vertices1.top >= vertices2.bottom
	)
}

function getRandomFragmentPosition(fragment) {
	let attempt = 0
	let x, y
	do {
		x = Math.random() * (canvas.clientWidth - fragment.offsetWidth)
		y = Math.random() * (canvas.clientHeight - fragment.offsetHeight)
		attempt += 1
	} while (attempt <= 5 && doFragmentsIntersect(fragment, currentFragment, x, y))

	return {
		x: x,
		y: y,
	}
}



function positionFragment(fragment) {
	let position = getRandomFragmentPosition(fragment)
	fragment.style.left = position.x + "px"
	fragment.style.top = position.y + "px"

	console.log("Fragment positioned")
}

function repositionCurrentFragment() {
	if (!currentFragment) {
		throw "No current fragment!"
	}

	positionFragment(currentFragment)
}


function readyFragment(fragment) {
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
nextFragment()