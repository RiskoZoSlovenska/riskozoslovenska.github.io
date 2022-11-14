/*
	On mobile, clicking away from the sidebar may trigger buttons underneath the 
	darkener, which is bad UX. Using CSS to set pointer-events: auto on the
	darkener when it's active doesn't seem to work (even when specified as a 
	transition with a delay) so it has to be done manually.
*/

const DELAY = 0 // Strangely enough, a delay of 0 works (setTimeout() must still be used tho)
const DARKENER_ID = "sidebar-darkener"

let globalId = 0
let darkener = null


function setDarkenerPointerEvents(value) {
	if (!darkener) {
		darkener = document.getElementById(DARKENER_ID)
	}

	if (darkener) {
		darkener.style.pointerEvents = value
	}
}

function onSidebarMouseEnter() {
	setDarkenerPointerEvents("auto")
	globalId += 1
}

function onSidebarMouseLeave() {
	let curId = globalId

	setTimeout(() => {
		if (curId == globalId) { // Ensure an old timeout doesn't interfere
			setDarkenerPointerEvents(null)
		}
	}, DELAY)
}