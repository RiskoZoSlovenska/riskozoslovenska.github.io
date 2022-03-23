const INSERTS_DIR = "/assets/inserts/"
const INSERTS = [
	"footer-insert",  "footer.html",
	"sidebar-insert", "sidebar.html",
]


for (let i = 0; i < INSERTS.length; i += 2) {
	let element = document.getElementById(INSERTS[i])
	if (!element) { continue }

	let path = INSERTS_DIR + INSERTS[i + 1]

	console.log("Fetching " + path)
	fetch(path)
		.then(res => res.text())
		.then(rawHtml => {
			element.innerHTML = rawHtml
			console.log("Inserted " + path)
		})
}