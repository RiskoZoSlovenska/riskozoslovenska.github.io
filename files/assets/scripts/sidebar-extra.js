"use strict";
/*
	This script provides functionality which enhances the sidebar, mainly by
	managing the custom focus class.

	1. Shows and hides the sidebar on right swipes, given the swipes are long
	   enough any are not too vertical. Tries its best to ignore swipes which
	   are likely to cause horizontal scrolling, but certain elements (e.g. the
	   Ace editor) may need to be explicitly disabled by giving them the
	   `data-custom-scroll` attribute.

	2. Makes the darkener sink all touch events when the sidebar is enabled so
	   that mobile users don't accidentally click on links when trying to hide
	   the sidebar

	3. Opens the sidebar when the mouse cursor moves off the side of the screen
	   and holds it open until the cursor comes back. Calculation of whether the
	   cursor is off-screen is done depending on its current position and
	   velocity. Additionally, the following restrictions apply:
	   - The mouse move event was triggered by a mouse
	   - The previous move event was fired recently
	   - The mouse is not hovering over an element with the `data-sink-sidebar`
	     attribute
*/
let ex_onSidebarMouseEnter, ex_onSidebarMouseLeave
{

const SHOW_MIN_SWIPE_LENGTH = 0.25 // Percentage of the screen width
const HIDE_MIN_SWIPE_LENGTH = 0.15
const CANCEL_MIN_SWIPE_LENGTH = 0.15 // Same units as SHOW_MIN_SWIPE_LENGTH
const TOUCH_EVENTS_DELAY = 200 // ms
const LEFT_MARGIN_SIZE = 10 // clientX units
const MOVEMENT_EXPIRY_TIME = 100 // ms

const DARKENER_ID = "sidebar-darkener"
const SIDEBAR_ID = "sidebar"
const CUSTOM_FOCUS_CLASS = "custom-focus"

let globalId = 0
let touchStartX = 0, touchStartY = 0
let lastMouseX = 0
let lastMove = 0
let rightSwipeAllowed = true, leftSwipeAllowed = true
let looksOffscreen = false
let sidebar, darkener


function ensureElements() {
	if (!darkener || !sidebar) {
		darkener = document.getElementById(DARKENER_ID)
		sidebar = document.getElementById(SIDEBAR_ID)
	}

	return darkener && sidebar
}


function sidebarApplyShown() {
	if (!ensureElements()) { return }

	// Disable darkener touches
	globalId += 1
	darkener.style.pointerEvents = "auto"
}

function sidebarApplyHidden() {
	if (!ensureElements()) { return }

	// Apply small delay before re-enabling touches
	let curId = globalId
	setTimeout(() => {
		if (curId == globalId) { // Ensure an old timeout doesn't interfere
			darkener.style.pointerEvents = null
		}
	}, TOUCH_EVENTS_DELAY)
}

function setCustomFocus(focused) {
	if (!ensureElements()) { return }

	if (focused) {
		sidebar.classList.add(CUSTOM_FOCUS_CLASS)
		sidebarApplyShown()
	} else {
		sidebar.classList.remove(CUSTOM_FOCUS_CLASS)
		sidebarApplyHidden()
	}
}


// Handle swipes (https://stackoverflow.com/a/56663695)
document.addEventListener("touchstart", event => {
	let touch = event.changedTouches[0]

	touchStartX = touch.clientX
	touchStartY = touch.clientY

	rightSwipeAllowed = true
	leftSwipeAllowed = true

	// Disallow swiping right or left if the swiping motion is trying to scroll something
	let parent = touch.target
	while (parent) {
		// General idea by https://stackoverflow.com/a/36900407
		let overflow = window.getComputedStyle(parent)["overflow-x"]
		let scrollable = (overflow == "scroll" || overflow == "auto") && (parent.scrollWidth > parent.clientWidth)
		let customScrollable = parent.dataset.customScroll != undefined
		let isAtLeft = (parent.scrollLeft == 0)
		let isAtRight = (parent.scrollWidth - parent.clientWidth - parent.scrollLeft == 0)

		if (scrollable && !isAtLeft  || customScrollable) { rightSwipeAllowed = false }
		if (scrollable && !isAtRight || customScrollable) { leftSwipeAllowed  = false }

		if (!rightSwipeAllowed && !leftSwipeAllowed) {
			break
		}

		// Check all elements up the ancestry chain as well
		parent = parent.parentElement
	}
})

document.addEventListener("touchend", event => {
	if (!ensureElements()) { return }

	let touchEndX = event.changedTouches[0].clientX
	let touchEndY = event.changedTouches[0].clientY
	let swipeLength = (touchEndX - touchStartX) / Math.min(window.innerWidth, window.innerHeight)
	let swipeHeight = (touchEndY - touchStartY) / Math.min(window.innerWidth, window.innerHeight)
	let swipeDimensions = `${swipeLength.toFixed(2)} x ${swipeHeight.toFixed(2)} @ ${touchEndX}`

	if (Math.abs(swipeHeight) >= CANCEL_MIN_SWIPE_LENGTH) {
		console.log(`Gesture too vertical: ${swipeDimensions}: cancelling`)
		return
	}

	// Show sidebar on right swipe
	if (rightSwipeAllowed && swipeLength >= SHOW_MIN_SWIPE_LENGTH) {
		console.log(`Gesture wants to show sidebar: ${swipeDimensions}`)
		setCustomFocus(true)

	// Hide sidebar on left swipe or press outside of it
	} else if (leftSwipeAllowed && (swipeLength <= -HIDE_MIN_SWIPE_LENGTH || touchEndX > sidebar.clientWidth)) {
		console.log(`Gesture wants to hide sidebar: ${swipeDimensions}`)
		setCustomFocus(false)
	}
})

document.addEventListener("pointermove", (event) => {
	if (!ensureElements()) { return }

	if (event.pointerType != "mouse") {
		return
	} else if (event.target?.dataset && event.target.dataset.sinkSidebar != undefined) {
		return
	}

	let now = performance.now()
	let mouseX = event.clientX
	let velocity = mouseX - lastMouseX

	if (mouseX + velocity <= LEFT_MARGIN_SIZE) {
		console.log(`Cursor looks offscreen: ${mouseX} + ${velocity}`)

		if (now - lastMove <= MOVEMENT_EXPIRY_TIME) {
			looksOffscreen = true
			setCustomFocus(true)
		} else {
			console.log(`However, it took too long: ${now - lastMove}ms`)
		}
	} else if (looksOffscreen) {
		console.log(`Cursor is back: ${mouseX} + ${velocity}`)
		looksOffscreen = false
		setCustomFocus(false)
	}

	lastMouseX = mouseX
	lastMove = now
})


// These two functions get called by inline event attributes
ex_onSidebarMouseEnter = function() {
	sidebarApplyShown()
}

ex_onSidebarMouseLeave = function() {
	sidebarApplyHidden()
}

}
