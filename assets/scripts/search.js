const MAX_RESULTS = 5

let searchData = undefined;
fetch("/search_data.json")
	.then(res => res.json())
	.then(json => {
		searchData = json
		console.log("Search data loaded!")
	})

let resultTemplate = undefined;
fetch("/assets/search-result-template.html")
	.then(res => res.text())
	.then(text => {
		let parser = new DOMParser()
		let document = parser.parseFromString(text, "text/html")

		resultTemplate = document.body.firstChild
		console.log("Result template loaded!", resultTemplate)
	})



function cleanQuery(query) {
	let raw = query.match(/\w+/g)
	return [...new Set(raw)] // Remove duplicates (https://stackoverflow.com/a/9229821)
}

function getSearchResults(query) {
	if (!searchData) {
		return null;
	}

	let top = {}

	for (word of query) {
		const counts = searchData.counts[word]
		if (!counts) { continue }

		for (let i = 0; i < counts.length; i += 2) {
			let index = counts[i]
			let count = counts[i + 1]

			top[index] = (top[index] || 0) + count
		}
	}

	let objects = Object.keys(top)
		.map(key => {
			return {
				index: key,
				title: searchData.titles[key],
				link: searchData.links[key],
				matches: top[key],
			}
		})
		.sort((first, second) => {
			return second.matches - first.matches
		})
		.slice(0, MAX_RESULTS)

	return objects
}

function createSearchResultNode(resultData) {
	let node = resultTemplate.cloneNode(true)
	node.getElementsByTagName("h1")[0].textContent = resultData.title
	node.getElementsByTagName("p")[0].textContent = "Matches: " + resultData.matches
	node.setAttribute("onclick", "location.href='" + resultData.link + "'")

	return node
}


function clearResults() {
	const nodes = document.getElementsByClassName("search-result")

	for (let i = nodes.length - 1; i >= 0; i--) { // Iter backwards since we're removing elements
		nodes[i].remove()
	}
}

function putResults(results, container) {
	clearResults()

	for (let resultData of results) {
		let node = createSearchResultNode(resultData)
		container.appendChild(node)
	}

	console.log("Updated search")
}


function updateSearch(event) {
	let searchBox = event.target
	let resultsContainer = searchBox.nextElementSibling

	if (document.activeElement == searchBox) {
		let rawQuery = searchBox.value
		let query = cleanQuery(rawQuery)
		let results = getSearchResults(query)
		if (!results) { return }

		putResults(results, resultsContainer)
	} else {
		clearResults()
	}
}