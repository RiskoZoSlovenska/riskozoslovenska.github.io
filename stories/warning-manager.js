function warningsAccepted() { // Exported function invoked by the button
	document.body.removeAttribute("data-warning-accept-pending")
	console.log("Accept button clicked")
}

console.log("Warning manager loaded successfully")