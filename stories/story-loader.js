const MAIN = document.getElementsByTagName("main")[0]

const ASIDED_HEADER_CLASS = "asided-header"
const VER_LABEL_ID = "version-label"

const CONVERTER = new showdown.Converter({
	noHeaderId: true,
	strikethrough: true,
})



function getVersionNode(markdown) {
	let matches = markdown.match(/\<\!\-+\s*v?(\d+\.\d+\.\d+)\s*\-+\>/)

	let versionNode = document.createElement("aside")
	versionNode.id = VER_LABEL_ID
	versionNode.textContent = matches ? matches[1] : "[VERSION UNKNOWN]"
	
	return versionNode
}



console.log("Fetching story...")

fetch("story.md")
	.then(data => data.text())
	.then(markdown => {
		MAIN.innerHTML = CONVERTER.makeHtml(markdown)
		console.log("Story inserted")

		let heading = MAIN.getElementsByTagName("h1")[0]
		if (!heading) { throw "Story does not have main heading" }

		heading.classList.add(ASIDED_HEADER_CLASS)
		heading.insertAdjacentElement("afterend", getVersionNode(markdown))

		console.log("Version aside inserted")
	})
