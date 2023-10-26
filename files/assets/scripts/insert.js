"use strict";
{

const ROOT = document.currentScript.src + "/" + "../../.."
const INSERTS_DIR = ROOT + "/" + "assets/inserts"
const ROOT_PLACEHOLDER = "{{ROOT}}"

for (let element of document.querySelectorAll("*[id$='-insert']")) {
	let template = element.id.match(/^(\w+)\-insert$/)?.[1]
	if (!template) {
		console.warn("Invalid insert template: " + element.id)
		continue
	}

	let path = INSERTS_DIR + "/" + template + ".html"

	console.log("Fetching " + path)
	fetch(path)
		.then(res => res.ok ? res : Promise.reject(res.status + " " + res.statusText))
		.then(res => res.text())
		.then(rawHtml => {
			element.outerHTML = rawHtml.replaceAll(ROOT_PLACEHOLDER, ROOT)
			console.log("Inserted " + path)
		})
		.catch(err => console.error("Inserting template failed: " + err))
}
}
