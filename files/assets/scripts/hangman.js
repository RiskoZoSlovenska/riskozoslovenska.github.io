"use strict";
/*
	Original script by RiskoZoSlovenska, 2021-12-06

	Some pages I found helpful:
		https://chanind.github.io/javascript/svg/2019/01/13/manipulating-and-animating-svg-with-raw-javascript.html
		https://random-word-api.herokuapp.com/
		https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch
*/
{

const EndState = { // Values should correspond to the data-game-state attribute values
	Won: "won",
	Lost: "lost",
}

const ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
const BACKUP_WORDS = [
	"TEST", "WEBSITE", "TEA", "CRINGE", "BASED", "EASY", "OBLITERATE", "VAPORIZE", "RANDOM", "BLOB", "BREAD",
	"POTATO", "MELANCHOLY", "JEFF", "TERRIBLY", "HYPERTEXT", "CAPITAL", "SPIRIT", "TREE", "SNAKE", "CHEESE",
	"MATCHA",
]
const END_BAR_TEXTS = {
	[EndState.Won]: {
		title: ["You won!", "Way to go!", "Nice!"],
		button: ["Next"],
	},
	[EndState.Lost]: {
		title: ["Oof...", "We'll get them next time", "F"],
		button: ["Try again?"],
	}
}

const BUTTON_CONTAINER = document.getElementById("hangman-button-container")
const BUTTON_TEMPLATE = document.getElementById("button-template").content.firstElementChild
const DEFINITION_TEMPLATE = document.getElementById("definition-template").content.firstElementChild
const HANGMAN_WORD_ELEMENTS = document.getElementsByClassName("hangman-word")
const END_OVERLAY = document.getElementById("end-overlay")
const END_OVERLAY_HEADING = document.getElementById("end-overlay-title")
const END_OVERLAY_DEFINITIONS_TITLE = document.getElementById("definitions-title")
const END_OVERLAY_DEFINITIONS_LIST = document.getElementById("hangman-word-definitions-list")
const NEXT_ROUND_BUTTON = document.getElementById("end-overlay-button")
const STATS_HITS = document.getElementById("stats-hits")
const STATS_MISSES = document.getElementById("stats-misses")
const STATS_SECONDS = document.getElementById("stats-seconds")

const IMAGE_PARTS = document.getElementById("hangman-svg-parts").children

const VISIBLE_IMAGE_PART_CLASS = "shown"
const NOT_GUESSED_LETTER_CLASS = "not-guessed"
const BUTTON_CLICK_STATE = {
	none: "none",
	correct: "correct",
	incorrect: "incorrect",
}

const QUEUE_LOW_THRESHOLD = 5 // Remember to change the fetch number in the below url as well
const WORDS_FETCH_URL = "https://random-word-api.herokuapp.com/word?number=10"

const FREE_DICTIONARY_QUERY_URL = "https://api.dictionaryapi.dev/api/v2/entries/en/"
const WIKTIONARY_QUERY_URL = "https://en.wiktionary.org/w/api.php?action=query&prop=extracts&format=json&origin=*&titles="
const KNOWN_PARTS_OF_SPEECH = [ "exclamation", "noun", "verb", "adverb", "adjective" ]
const MAX_DEFINITIONS = 3


let playing = false
let curWord = null
let wordQueue = []
let visibleLetters = {}
let numWrong = 0
let gameStart = null

let definitions = {}
let wordRedirections = {}



function elementIs(element, target) {
	return element.tagName.toLowerCase() == target
}

function getRandomItem(array) {
	return array[Math.floor(Math.random() * array.length)]
}

function removeAllChildren(element) {
	element.textContent = null // Remove text first (which should remove a fair amount of elements)

	while (element.firstChild) { // ...and then remove everything else that's left
		element.lastChild.remove()
	}
}

function iterAllSiblings(element, callback) {
	while (element) {
		let shouldExit = callback(element)
		if (shouldExit) {
			return element
		}

		element = element.nextElementSibling
	}

	return null
}

function toggleBodyScroll(enable) {
	document.body.style.overflow = enable ? null : "hidden"
}

function wasClicked(button) {
	return button.dataset.clicked != BUTTON_CLICK_STATE.none;
}

function isWordValid(word) {
	// Filtering happens before so the word should be all uppercase already
	for (let i = 0; i < word.length; i++) {
		if (!ALPHA.includes(word[i])) {
			return false
		}
	}

	return true
}

async function fetchWordDefinitionsFromFreeDictAPI(word) {
	let res = await fetch(FREE_DICTIONARY_QUERY_URL + word)
		.then(res => res.ok ? res.json() : Promise.reject(res.status + " " + res.statusText))
		.catch(_ => {})
	
	if (!res) {
		return null
	}

	let entry = res[0]
	return {
		source: "Free Dictionary API",
		word: entry.word,
		meanings: entry.meanings
			.splice(0, MAX_DEFINITIONS)
			.map(meaning => {
				return {
					part_of_speech: meaning.partOfSpeech,
					meaning: meaning.definitions[0].definition,
				}
			}),
	}
}

async function fetchWordDefinitionsFromWiktionary(word) {
	let res = await fetch(WIKTIONARY_QUERY_URL + word)
		.then(res => res.ok ? res.json() : Promise.reject(res.status + " " + res.statusText))
		.catch(_ => { })

	if (!res) {
		return null
	}

	let page = Object.values(res.query.pages)[0]
	let extractDoc = new DOMParser().parseFromString(page.extract, "text/html")

	let meanings = []
	iterAllSiblings(extractDoc.querySelector("#English")?.closest("h2")?.nextElementSibling, element => {
		// Skip over all non-h3s
		if (elementIs(element, "h2")) {
			return true
		} else if (!elementIs(element, "h3")) {
			return false
		}

		// At this point element is an h3
		let partOfSpeech = element.textContent.toLowerCase()
		if (KNOWN_PARTS_OF_SPEECH.indexOf(partOfSpeech) == -1) {
			return false
		}

		// Find first list sibling
		let list = iterAllSiblings(element, list => {
			return elementIs(list, "ol")
		})
		if (!list) {
			return false
		}

		// Extract meaning
		let meaningNode = list.querySelector(":scope > li:not([class*=\"empty\"])")
		if (!meaningNode) {
			console.warning("No definition found under heading in Wiktionary")
		} else {
			meanings.push({
				part_of_speech: partOfSpeech,
				node: meaningNode,
				meaning: meaningNode.textContent,
			})
		}

		if (meanings.length >= MAX_DEFINITIONS) {
			return true
		}
	})

	if (meanings.length == 0) {
		return null

	} else if (meanings.length == 1) {
		let node = meanings[0].node
		let mention = node.querySelector(".mention")
		let name = mention?.textContent
		let isLast = !mention?.nextElementSibling
		let isBeforeOf = /\s(of)\s+(\S+)\s*?$/.test(node.textContent) // https://stackoverflow.com/a/6603043

		if (mention && isLast && isBeforeOf && !wordRedirections[name]) {
			console.log("Redirecting Wiktionary definition")
			wordRedirections[name] = true
			return await fetchWordDefinitionsFromWiktionary(name)
		}
	}

	return {
		source: "Wiktionary",
		word: page.title,
		meanings: meanings,
	}
}

async function fetchWordDefinitions(word) {
	word = word.toLowerCase()

	let definition = await fetchWordDefinitionsFromFreeDictAPI(word)

	if (!definition) {
		definition = await fetchWordDefinitionsFromWiktionary(word)
	}

	if (definition) {
		definitions[word] = definition
		console.log(`Fetched word definition from ${definition.source}`)
	} else {
		console.log(`Failed to find definition`)
	}
}

function fetchWords() {
	console.log("Fetching words...")

	fetch(WORDS_FETCH_URL)
		.then(res => res.ok ? res.json() : Promise.reject(res.status + " " + res.statusText))
		.then(words => {
			let filtered = words
				.map(word => word.toUpperCase())
				.filter(isWordValid)

			console.log("Successfully fetched " + filtered.length + " words.")
			wordQueue = wordQueue.concat(filtered)
			filtered.forEach(fetchWordDefinitions)
		})
		.catch(err => console.error("Words fetch error: " + err))
}



function bindButtonToKeystroke(button, key) {
	document.addEventListener("keydown", event => {
		if (event.ctrlKey || event.shiftKey || event.altKey || event.metaKey || event.isComposing) {
			return
		} else if (event.key.toUpperCase() == key.toUpperCase()) {
			button.click()
		}
	})
}

function initButtons() {
	removeAllChildren(BUTTON_CONTAINER)

	for (const char of ALPHA) {
		const button = BUTTON_TEMPLATE.cloneNode(true)
		button.textContent = char
		button.addEventListener("click", onButtonClick)
		bindButtonToKeystroke(button, char)

		BUTTON_CONTAINER.appendChild(button)
	}
}

function resetButtons() {
	const buttons = BUTTON_CONTAINER.children

	for (let i = 0; i < buttons.length; i++) {
		const button = buttons[i]

		button.dataset.clicked = BUTTON_CLICK_STATE.none
	}
}



function resetImage() {
	for (let i = 0; i < IMAGE_PARTS.length; i++) { // https://stackoverflow.com/a/22754453
		IMAGE_PARTS[i].classList.remove(VISIBLE_IMAGE_PART_CLASS)
	}
}

function advanceImage() {
	IMAGE_PARTS[numWrong - 1].classList.add(VISIBLE_IMAGE_PART_CLASS) // Assumes numWrong - 1 points to the next part
}



function forEachLetterNodeOfWord(func) {
	for (let word of HANGMAN_WORD_ELEMENTS) {
		removeAllChildren(word)

		for (let i = 0; i < curWord.length; i++) {
			let letter = curWord[i]
			let letterNode = document.createTextNode(letter)
			let newNode = func(letterNode, visibleLetters[letter] == true)
			word.appendChild(newNode)
		}
	}
}

function wrapNotGuessedLetter(letterNode) {
	let span = document.createElement("span")
	span.classList.add(NOT_GUESSED_LETTER_CLASS)
	span.appendChild(letterNode)

	return span
}

function updateWord() {
	let isFullyVisible = true

	forEachLetterNodeOfWord((letterNode, isVisible) => {
		if (!isVisible) {
			isFullyVisible = false
		}

		return isVisible ? letterNode : document.createTextNode("_")
	})

	return isFullyVisible
}

function revealWord() {
	console.log("Word was " + curWord)

	forEachLetterNodeOfWord((letterNode, isVisible) => {
		return isVisible ? letterNode : wrapNotGuessedLetter(letterNode)
	})
}


function endRound(endState) {
	// Reveal word
	playing = false
	revealWord()

	// Enable overlay
	END_OVERLAY.dataset.endState = endState
	END_OVERLAY.dataset.isPlaying = false
	toggleBodyScroll(false)
	
	// Set overlay remarks
	let contentData = END_BAR_TEXTS[endState]
	END_OVERLAY_HEADING.textContent = getRandomItem(contentData.title)
	NEXT_ROUND_BUTTON.textContent = getRandomItem(contentData.button)

	// Set overlay stats
	STATS_HITS.textContent = Object.keys(visibleLetters).length // https://stackoverflow.com/a/14626707
	STATS_MISSES.textContent = numWrong
	STATS_SECONDS.textContent = Math.floor((performance.now() - gameStart) / 1000)
	gameStart = null

	// Set overlay definitions
	let definition = definitions[curWord.toLowerCase()]

	removeAllChildren(END_OVERLAY_DEFINITIONS_LIST)
	let word = definition?.word ?? curWord.toLowerCase()

	if (definition) {
		END_OVERLAY_DEFINITIONS_TITLE.innerHTML = `Definitions found for <b>${word}</b>:`

		for (let meaning of definition.meanings) {
			let node = DEFINITION_TEMPLATE.cloneNode(true)
			node.querySelector("span").textContent = meaning.part_of_speech
			node.appendChild(document.createTextNode(meaning.meaning))

			END_OVERLAY_DEFINITIONS_LIST.appendChild(node)
		}
	} else {
		END_OVERLAY_DEFINITIONS_TITLE.innerHTML = `No definitions found for <b>${word}</b>.`
	}
}

function startRound() {
	if (playing) return // Already playing
	console.log("Starting round")

	// Reset stuff
	resetButtons()

	numWrong = 0
	resetImage()

	// Pick word and fetch new ones
	if (wordQueue.length > 0) {
		curWord = wordQueue.shift()
	} else {
		curWord = getRandomItem(BACKUP_WORDS)
		fetchWordDefinitions(curWord)
	}

	if (wordQueue.length < QUEUE_LOW_THRESHOLD) {
		fetchWords()
	}

	// Update stuff
	visibleLetters = {}
	updateWord()

	END_OVERLAY.dataset.isPlaying = true
	toggleBodyScroll(true)
	playing = true
}



function clickedCorrect(button) {
	button.dataset.clicked = BUTTON_CLICK_STATE.correct

	const letter = button.textContent
	visibleLetters[letter] = true

	const won = updateWord()
	if (won) {
		console.log("Won!")
		endRound(EndState.Won)
	}
}

function clickedIncorrect(button) {
	button.dataset.clicked = BUTTON_CLICK_STATE.incorrect

	numWrong += 1
	advanceImage()

	const lost = (numWrong >= IMAGE_PARTS.length)
	if (lost) {
		console.log("Lost!")
		endRound(EndState.Lost)
	}
}

function onButtonClick(clickInfo) {
	if (!playing || curWord == null) { return }

	if (!gameStart) {
		gameStart = performance.now()
	}

	const button = clickInfo.target
	if (wasClicked(button)) return

	curWord.includes(button.textContent) ? clickedCorrect(button) : clickedIncorrect(button)
}


function main() {
	initButtons()
	startRound()
	NEXT_ROUND_BUTTON.addEventListener("click", startRound)
	bindButtonToKeystroke(NEXT_ROUND_BUTTON, "Enter")
}
main()

}
