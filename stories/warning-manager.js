const INSERT_ID = "warning-insert"
const LIST_ID = "story-warnings-list"
const BUTTON_ID = "warning-accept-button"

const ACCEPTED_CLASS = "warning-accepted"

const WARN_STRINGS = {
	gore: "Graphic descriptions of violence/injury",
}

const BODY = document.getElementsByTagName("body")[0]
const OVERLAY = document.getElementById(INSERT_ID)



function setBodyIsScrollable(scrollable) {
	BODY.style.overflow = scrollable ? null : "hidden"
}



function addTag(str, tagList) {
	let itemNode = document.createElement("li")
	itemNode.appendChild(document.createTextNode(str))

	tagList.appendChild(itemNode)
}

function addTags(tagList) {
	let tags = OVERLAY.dataset.warnings.match(/[^;]+/g)

	for (let tag of tags) {
		let str = WARN_STRINGS[tag]

		if (str) {
			console.log("Adding tag: " + tag)
			addTag(str, tagList)
		} else {
			throw "invalid tag: " + tag
		}
	}

	console.log("Tags successfully added")
	return true
}



function buttonClicked() {
	OVERLAY.classList.add(ACCEPTED_CLASS)
	setBodyIsScrollable(true)
}

function bindButton(button) {
	button.addEventListener("click", buttonClicked)

	console.log("Button bound successfully")
	return true
}



function tryTillSuccess(func, id) {
	function tryOnce() {
		let element = document.getElementById(id)

		return element ? func(element) : false
	}


	if (tryOnce()) { return } // Worked already; we can return

	let observer = new MutationObserver((_, self) => {
		if (tryOnce()) {
			self.disconnect()
		}
	})

	observer.observe(OVERLAY, {
		childList: true,
	})
}



if (OVERLAY) {
	setBodyIsScrollable(false)

	tryTillSuccess(addTags,    LIST_ID)
	tryTillSuccess(bindButton, BUTTON_ID)
}