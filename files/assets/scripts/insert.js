"use strict";
{

const ROOT = new URL("../../..", document.currentScript.src)
const INSERTS_DIR = new URL("assets/inserts/", ROOT)
const ROOT_PLACEHOLDER = "{{ROOT}}"

for (let element of document.querySelectorAll("*[id$='-insert']")) {
	let template = element.id.match(/^(\w+)\-insert$/)?.[1]
	if (!template) {
		console.warn("Invalid insert template: " + element.id)
		continue
	}

	let path = new URL(template + ".html", INSERTS_DIR)
	console.log("Fetching " + path)
	fetch(path)
		.then(res => res.ok ? res : Promise.reject(res.status + " " + res.statusText))
		.then(res => res.text())
		.then(rawHtml => {
			element.outerHTML = rawHtml.replaceAll(ROOT_PLACEHOLDER, ROOT.href)
			console.log("Inserted " + path)
		})
		.catch(err => console.error("Inserting template failed: " + err))
}

}
