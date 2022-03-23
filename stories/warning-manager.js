const OVERLAY_ID = "warning-overlay"
const TAGS_LIST_ID = "story-warnings-list"
const ACCEPT_BUTTON_ID = "warning-accept-button"

const ACCEPTED_CLASS = "warning-accepted"

const WARN_DESCS = {
	gore: "Graphic descriptions of violence/injury",
}

const OVERLAY = document.getElementById(OVERLAY_ID)
const BODY = document.getElementsByTagName("body")[0]
const TAGS_CONTAINER = document.getElementById(TAGS_LIST_ID)
const ACCEPT_BUTTON = document.getElementById(ACCEPT_BUTTON_ID)



function setBodyIsScrollable(scrollable) {
	BODY.style.overflow = scrollable ? null : "hidden"
}

function addWarningString(str) {
	let itemNode = document.createElement("li")
	itemNode.appendChild(document.createTextNode(str))

	TAGS_CONTAINER.appendChild(itemNode)
}



// Parse warnings
let warnings = OVERLAY.dataset.warnings.match(/[^;]+/g)


// Make the body unscrollable
setBodyIsScrollable(false)


// Add warning tags
for (let warningName of warnings) {
	let str = WARN_DESCS[warningName]
	if (!str) { throw "invalid warning: " + warningName }

	addWarningString(str)
	console.log("Added warning: " + warningName)
}
console.log("Warnings added successfully")


// Bind button
ACCEPT_BUTTON.addEventListener("click", function () {
	console.log("Warning accept button clicked")
	OVERLAY.classList.add(ACCEPTED_CLASS)
	setBodyIsScrollable(true)
})
console.log("Warning accept button bound successfully")