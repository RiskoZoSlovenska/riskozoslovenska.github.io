"use strict";
/*
	== The search_data.json format ==

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

	== Page ranking ==
	Currently, pages are ranked according to two aspects: How many word matches
	they contain and how close their title is to the query. Every metric has its
	own weight.

	The word matching is simple; every word in the query is checked for how many
	times it occurs in what page, and a sum of matches is kept for every page.

	The title matching is a bit more complex; a custom fuzzy matching algorithm
	is used (I don't actually know whether it corresponds to any formal
	algorithm) which measures how many letters are the same, what's the distance
	between them and how far from the beginning they first match. Each of these
	is then multiplied by a weight and summed.

	Scores below or equal to 0 are removed; the remaining are sorted in
	descending order and then the list is truncated and displayed.
 */
let ex_updateSearch
{

const MAX_RESULTS = 5
const TITLE_HITS_WEIGHT = 3
const TITLE_DIST_WEIGHT = -0.5
const TITLE_LENGTH_WEIGHT = -0.5
const TITLE_TOTAL_WEIGHT = 1
const WORD_MATCH_WEIGHT = 3

const SEARCH_RESULT_TITLE_CLASS = "search-result-title"
const SEARCH_RESULT_DESC_CLASS = "search-result-desc"

const ROOT = document.currentScript.src + "/" + "../../.."

let searchData = null
fetch(ROOT + "/" + "search_data.json")
	.then(res => res.ok ? res.json() : Promise.reject(res.status + " " + res.statusText))
	.then(json => {
		searchData = json
		console.log("Search data loaded!")
	})
	.catch(err => console.error("Search data error: " + err))

let resultTemplate = null
fetch(ROOT + "/" + "assets/search-result-template.html")
	.then(res => res.ok ? res.text() : Promise.reject(res.status + " " + res.statusText))
	.then(text => {
		let parser = new DOMParser()
		let document = parser.parseFromString(text, "text/html")

		resultTemplate = document.body.firstChild
		console.log("Result template loaded!", resultTemplate)
	})
	.catch(err => console.error("Search template error: " + err))



function subsequenceMatch(str, seq) {
	let strLen = str.length
	let seqLen = seq.length
	let strPos = 0
	let seqPos = 0
	let lastMatchPos = strPos
	let matches = 0
	let dist = 0
	let startPos = null
	let lastDist = dist

	while (seqPos < seqLen) {
		if (str.charAt(strPos) === seq.charAt(seqPos)) {
			// Characters equal; move to next seq char, increment matches, log this as last match, save dist
			seqPos = seqPos + 1
			matches = matches + 1

			lastMatchPos = strPos
			lastDist = dist

			startPos = startPos ?? strPos
		} else if (strPos > strLen) {
			// Didn't match; skip to next seq char, reset string index and dist to last
			seqPos = seqPos + 1

			strPos = lastMatchPos
			dist = lastDist
		} else if (matches > 0) {
			// Didn't match and didn't skip; increment distance if we have made at least one match
			dist = dist + 1
		}

		strPos = strPos + 1
	}

	return {
		misses: seq.length - matches,
		distance: lastDist,
		start: startPos ?? 0
	}
}

function assertHasSearchData() {
	if (!searchData) { throw "Search data hasn't loaded in yet!" }
}

function assertHasResultTemplate() {
	if (!resultTemplate) { throw "Result template hasn't loaded in yet!" }
}

function extractWordsFromQuery(query) {
	let raw = query.match(/[a-zA-Z0-9']+/g)?.map(word => word.replaceAll(/[^a-zA-Z0-9]+/g, ""))
	return [...new Set(raw)] // Remove duplicates (https://stackoverflow.com/a/9229821)
}



function buildBlankResults() {
	assertHasSearchData()

	return searchData.titles.map((title, index) => {
		return {
			index: index,
			title: title,
			link: searchData.links[index],
			score: 0,
			matches: null,
		}
	})
}

function scoreResultsByTitle(results, query) {
	for (let result of results) {
		let str = result.title.toLowerCase()
		let matchInfo = subsequenceMatch(str, query)

		result.score += (
			  (query.length - matchInfo.misses)       * TITLE_HITS_WEIGHT
			+ matchInfo.distance                      * TITLE_DIST_WEIGHT
			+ matchInfo.start                         * TITLE_DIST_WEIGHT
			+ -Math.min(str.length - query.length, 0) * TITLE_LENGTH_WEIGHT
		) * TITLE_TOTAL_WEIGHT
	}
}

function scoreResultsByWordMatches(results, queryWords) {
	assertHasSearchData()

	for (let word of queryWords) {
		const counts = searchData.counts[word]
		if (!counts) { continue }

		// Increment counts for every page
		for (let i = 0; i < counts.length; i += 2) {
			let index = counts[i]
			let count = counts[i + 1]

			let result = results[index]
			result.score += count * WORD_MATCH_WEIGHT
			result.matches = (result.matches ?? 0) + count // Safely increment
		}
	}
}

function finalizeResults(results) {
	return results
		.filter(result => result.score > 0)
		.sort((first, second) => second.score - first.score)
		.slice(0, MAX_RESULTS)
}


function createSearchResultNode(resultData) {
	let node = resultTemplate.cloneNode(true)
	node.getElementsByClassName(SEARCH_RESULT_TITLE_CLASS)[0].textContent = resultData.title
	node.getElementsByClassName(SEARCH_RESULT_DESC_CLASS)[0].textContent = 
		resultData.matches ?
		("Matches: " + resultData.matches) :
		("Score: "   + resultData.score)

	node.getElementsByTagName("a")[0].setAttribute("href", ROOT + "/" + resultData.link)

	return node
}

function putResults(results, container) {
	clearResults(container)
	assertHasResultTemplate()

	for (let resultData of results) {
		let node = createSearchResultNode(resultData)
		container.appendChild(node)
	}

	console.log("Updated search")
}


function clearResults(container) {
	while (container.firstChild) {
		container.lastChild.remove()
	}
}


// Export function which will get called by search bar
ex_updateSearch = function(event) {
	let searchBox = event.target
	let resultsContainer = searchBox.nextElementSibling

	let query = searchBox.value.toLowerCase()
	let queryWords = extractWordsFromQuery(query)

	let results = buildBlankResults()
	scoreResultsByTitle(results, query)
	scoreResultsByWordMatches(results, queryWords)

	putResults(finalizeResults(results), resultsContainer)
}

}
