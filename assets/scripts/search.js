/*
	Handles showing search results. It uses the JSON object found in the
	search_data.json file to match searches. The specification for said object
	follows.

	Every page has an index number, a link and a title. The search_data object
	holds three fields:
		- counts
		- links
		- titles
	
	Links and titles are arrays where the index corresponds so the index number
	of a page.

	The counts field is a dictionary, where a words are keys and the values are
	arrays holding numbers. Every two consecutive numbers in the array
	correspond to a page index number and how many times the word appears on
	that page. For example, a key-value pair of `"hello": [2, 3, 0, 1]`
	signifies that the word "hello" appears 3 times on page 2 and once on page
	0.
 */

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

		// Increment counts for every page
		for (let i = 0; i < counts.length; i += 2) {
			let index = counts[i]
			let count = counts[i + 1]

			top[index] = (top[index] || 0) + count // Increment
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


// Export function which will get called by search bar
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