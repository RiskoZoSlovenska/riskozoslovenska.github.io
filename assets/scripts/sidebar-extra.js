/*
	This script provides functionality which enhances the sidebar on mobile.

	The first of these functions is showing the sidebar on right swipes. The
	sidebar is toggled via a class which is added or removed by when handling
	touch events.
	
	Additionally, this script also makes the darkener sink all input while the
	sidebar is active to prevent users from accidentally clicking on links when
	trying to collapse the sidebar.
*/
let onSidebarMouseEnter, onSidebarMouseLeave
{

const SHOW_MIN_SWIPE_LENGTH = 0.25 // Percentage of the screen width
const HIDE_MIN_SWIPE_LENGTH = 0.15
const TOUCH_EVENTS_DELAY = 200 // ms

const DARKENER_ID = "sidebar-darkener"
const SIDEBAR_ID = "sidebar"
const SWIPE_FOCUS_CLASS_NAME = "swipe-focus"


let globalId = 0
let touchStart = 0
let sidebar, darkener

function tryElements() {
	if (!darkener || !sidebar) {
		darkener = document.getElementById(DARKENER_ID)
		sidebar = document.getElementById(SIDEBAR_ID)
	}

	return darkener && sidebar
}

function sidebarShow(wasSwiped) {
	if (!tryElements()) {
		return
	}

	// Disable darkener touches
	globalId += 1
	darkener.style.pointerEvents = "auto"

	// Enable sidebar via swipe class
	if (wasSwiped) {
		sidebar.classList.add(SWIPE_FOCUS_CLASS_NAME)
	}
}

function sidebarHide() {
	if (!tryElements()) {
		return
	}

	// Enable darkener touches after a small delay
	let curId = globalId

	setTimeout(() => {
		if (curId == globalId) { // Ensure an old timeout doesn't interfere
			darkener.style.pointerEvents = null
		}
	}, TOUCH_EVENTS_DELAY)

	// Remove sidebar swipe class
	sidebar.classList.remove(SWIPE_FOCUS_CLASS_NAME)
}


// Handle swipes (https://stackoverflow.com/a/56663695)

document.addEventListener("touchstart", event => {
	touchStart = event.changedTouches[0].clientX
})

document.addEventListener("touchend", event => {
	if (!tryElements()) {
		return
	}

	let touchEnd = event.changedTouches[0].clientX
	let swipeLength = (touchEnd - touchStart) / window.innerWidth

	// Show sidebar on right swipe
	if (swipeLength >= SHOW_MIN_SWIPE_LENGTH) {
		console.log("Showing sidebar due to gesture")
		sidebarShow(true)

	// Hide sidebar on left swipe or press outside of it
	} else if (swipeLength <= -HIDE_MIN_SWIPE_LENGTH || touchEnd > sidebar.clientWidth) {
		console.log("Hiding sidebar due to gesture")
		sidebarHide()
	}
})

// These two functions get called by inline event attributes
onSidebarMouseEnter = function() {
	sidebarShow(false)
}

onSidebarMouseLeave = function() {
	sidebarHide()
}

}