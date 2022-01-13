const INSERT_ID = "warning-insert"
const LIST_ID = "story-warnings-list"
const BUTTON_ID = "warning-accept-button"

const ACCEPTED_CLASS = "warning-accepted"

const WARN_STRINGS = {
	gore: "Graphic descriptions of violence/injury",
}

const OVERLAY = document.getElementById(INSERT_ID)



function addTag(str, tagList) {
	let itemNode = document.createElement("li")
	itemNode.appendChild(document.createTextNode(str))

	tagList.appendChild(itemNode)
}

function addTags(tagList) {
	for (let tag in OVERLAY.dataset) {
		let str = WARN_STRINGS[tag]

		if (str) {
			addTag(str, tagList)
		}
	}

	console.log("Tags successfully added")
}

function tryToAddTags() {
	let tagList = document.getElementById(LIST_ID)

	if (tagList) {
		addTags(tagList)
		return true
	}

	return false
}



function buttonClicked() {
	OVERLAY.classList.add(ACCEPTED_CLASS)
}

function bindButton(button) {
	button.addEventListener("click", buttonClicked)

	console.log("Button bound successfully")
}

function tryToBindButton() {
	let button = document.getElementById(BUTTON_ID)

	if (button) {
		bindButton(button)
		return true
	}

	return false
}



function tryTillSuccess(func) {
	if (func()) return // Worked already; we can return

	let obs = new MutationObserver((_, obs) => {
		if (func()) {
			obs.disconnect()
		}
	})

	obs.observe(OVERLAY, {
		childList: true,
	})
}



if (OVERLAY) {
	tryTillSuccess(tryToAddTags)
	tryTillSuccess(tryToBindButton)
}
