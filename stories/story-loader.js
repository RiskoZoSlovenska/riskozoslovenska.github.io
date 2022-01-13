const CONTAINER = document.getElementById("story-container")
const VER_LABEL = document.getElementById("version-label")

const CONVERTER = new showdown.Converter({
	noHeaderId: true,
	headerLevelStart: 3,
	strikethrough: true,
})



function getVersion(markdown) {
	let matches = markdown.match(/\<\!\-+\s*v?(\d+\.\d+\.\d+)\s*\-+\>/)
	
	return document.createTextNode(matches ? matches[1] : "0.0.0")
}



fetch(CONTAINER.dataset.story)
	.then(data => data.text())
	.then(markdown => {
		VER_LABEL.appendChild(getVersion(markdown))

		CONTAINER.innerHTML = CONVERTER.makeHtml(markdown)
	})
