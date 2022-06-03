const PENDING_ATTRIB = "data-warning-accept-pending"

function onWarningAccept() { // Exported function invoked by the button
	if (!document.body) {
		throw "Body hasn't loaded in yet... somehow??"
	}

	document.body.removeAttribute(PENDING_ATTRIB)
	console.log("Accept button clicked")
}

console.log("Warning manager loaded successfully")