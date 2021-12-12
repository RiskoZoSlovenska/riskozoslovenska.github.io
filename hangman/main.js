/*
	Original script by RiskoZoSlovenska, 2021-12-06

	Some pages I found helpful:
		https://chanind.github.io/javascript/svg/2019/01/13/manipulating-and-animating-svg-with-raw-javascript.html
		https://random-word-api.herokuapp.com/
		https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch
*/

const ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
const BACKUP_WORDS = [
	"TEST", "WEBSITE", "TEA", "CRINGE", "BASED", "EASY", "OBLITERATE", "VAPORIZE", "RANDOM", "BLOB", "BREAD",
	"POTATO", "MELANCHOLY", "JEFF", "TERRIBLY", "HYPERTEXT", "CAPITAL", "SPIRIT", "TREE", "SNAKE", "CHEESE",
	"MATCHA",
]
const SVG_OBJECTS = [ // {[name, {attribute: value, ...}], ...}
	// Gallow
	["path", {d: "M 15 0  H 80  V 17.5  H 70  V 10  H 25  V 100  H 40  V 110  H 0  V 100  H 15  Z"}],

	// Head
	["circle", {cx: "75", cy: "30", r: "12.5"}],

	// Torso
	["rect", {x: "72.6", y: "42.24745", width: "5", height: "40.075"}],

	// Left arm
	["path", {d: "M 73.96447 47.24745  L 77.5 50.78298      L 59.82233 68.46065  L 56.2868 64.92512   Z"}],

	// Left leg
	["path", {d: "M 72.5 78.7868       L 76.03553 82.32233  L 58.35786 100       L 54.82233 96.46447  Z"}],

	// Right arm
	["path", {d: "M 76.03553 47.24745  L 93.7132 64.92512   L 90.17767 68.46065  L 72.5 50.78298      Z"}],

	// Right leg
	["path", {d: "M 77.5 78.78680      L 95.17767 96.46447  L 91.64214 100       L 73.96447 82.32233  Z"}],
]

const BUTTON_CONTAINER = document.getElementById("button-container")
const WORD = document.getElementById("hangman-word")
const IMAGE = document.getElementById("hangman-svg")
const END_BAR = document.getElementById("game-end-bar")
const END_BAR_HEADING = document.getElementById("game-end-bar-heading")
const END_BAR_REMARK = document.getElementById("game-end-bar-remark")
const NEXT_ROUND_BUTTON = document.getElementById("next-round-button")

const IMAGE_COLOR = window.getComputedStyle(document.documentElement).getPropertyValue("--main-text-color")

const LOADING_CLASS = "loading"
const CLICKED_CORRECT_CLASS = "clicked-correct"
const CLICKED_INCORRECT_CLASS = "clicked-incorrect"
const NOT_GUESSED_LETTER_CLASS = "not-guessed-letter"

const EndState = { // Values should correspond to the data-game-state attribute values
	Won: "won",
	Lost: "lost",
}

const END_BAR_TEXTS = {
	[EndState.Won]: {
		titles: ["Yay you won!", "Victory is yours!", "Nice!", "Noice!"],
		remarks: ["ez?", "ez.", "nice.", "gg", "gg no re"],
		buttons: ["Next", "Rematch.", "Gimme another one", "MORE"],
	},
	[EndState.Lost]: {
		titles: ["You failed!", "You died!", "Nope!", "F"],
		remarks: [";-;", "F", "cri", "gonna cry?", "git gud"],
		buttons: ["Next", "Rematch.", "+1 life", "I don't give up", "Try again?"],
	}
}

const QUEUE_LOW_THRESHOLD = 5 // Remember to change the fetch number in the below url as well
const WORDS_FETCH_URL = "https://random-word-api.herokuapp.com/word?number=10&swear=0"


let playing = false
let curWord = null
let wordQueue = []
let visibleLetters = {}
let numWrong = 0



function getRandomElement(arr) {
	return arr[Math.floor(Math.random() * arr.length)]
}

function removeAllChildren(element) {
	while (element.firstChild) {
		element.lastChild.remove()
	}

	element.textContent = ""
}

function wasClicked(button) {
	return button.classList.contains(CLICKED_CORRECT_CLASS) || button.classList.contains(CLICKED_INCORRECT_CLASS)
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



function fetchWords() {
	console.log("Fetching words...")

	fetch(WORDS_FETCH_URL)
		.then(data => data.json())
		.then(words => {
			let filtered = words
				.map(word => word.toUpperCase())
				.filter(isWordValid)

			console.log("Successfully fetched " + filtered.length)
			wordQueue = wordQueue.concat(filtered)
		})
}



function initButtons() {
	removeAllChildren(BUTTON_CONTAINER)

	for (const char of ALPHA) {
		const button = document.createElement("button")
		button.textContent = char
		button.addEventListener("click", onButtonClick)

		BUTTON_CONTAINER.appendChild(button)
	}
}

function resetButtons() {
	const buttons = BUTTON_CONTAINER.children

	for (let i = 0; i < buttons.length; i++) {
		const button = buttons[i]

		button.classList.remove(CLICKED_CORRECT_CLASS)
		button.classList.remove(CLICKED_INCORRECT_CLASS)
	}
}



function resetImage() {
	removeAllChildren(IMAGE)
}

function advanceImage() {
	const objectInfo = SVG_OBJECTS[numWrong] // Assumes that numWrong points to the next element

	const object = document.createElementNS("http://www.w3.org/2000/svg", objectInfo[0])

	// Attributes
	const attribs = objectInfo[1]
	for (const attrib in attribs) {
		object.setAttributeNS(null, attrib, attribs[attrib])
	}
	object.setAttributeNS(null, "fill", IMAGE_COLOR)

	IMAGE.appendChild(object)
}



function forEachLetterNodeOfWord(func) {
	removeAllChildren(WORD)

	for (let i = 0; i < curWord.length; i++) {
		let letter = curWord[i]
		let letterNode = document.createTextNode(letter)
		let newNode = func(letterNode, visibleLetters[letter] == true)
		WORD.appendChild(newNode)
	}
}

function wrapNotGuessedLetter(letterNode) {
	let span = document.createElement("span")
	span.classList.add(NOT_GUESSED_LETTER_CLASS)
	span.appendChild(letterNode)

	return span
}

function updateWord() {
	WORD.classList.remove(LOADING_CLASS) // Remove loading class if it's still present

	let isFullyVisible = true

	forEachLetterNodeOfWord((letterNode, isVisible) => {
		if (!isVisible) isFullyVisible = false

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
	END_BAR.dataset.endState = endState
	END_BAR.dataset.isPlaying = false
	playing = false
	revealWord()
	
	const contentData = END_BAR_TEXTS[endState]
	END_BAR_HEADING.textContent = getRandomElement(contentData.titles)
	END_BAR_REMARK.textContent = getRandomElement(contentData.remarks)
	NEXT_ROUND_BUTTON.textContent = getRandomElement(contentData.buttons)
}

function startRound() {
	if (playing) return // Already playing
	console.log("Starting round")

	resetButtons()

	numWrong = 0
	resetImage()
	advanceImage() // Show gallow

	curWord = (wordQueue.length == 0) ? getRandomElement(BACKUP_WORDS) : wordQueue.shift()
	if (wordQueue.length < QUEUE_LOW_THRESHOLD) {
		fetchWords()
	}
	visibleLetters = {}
	updateWord()

	END_BAR.dataset.isPlaying = true
	playing = true
}



function clickedCorrect(button) {
	button.classList.add(CLICKED_CORRECT_CLASS)

	const letter = button.textContent
	visibleLetters[letter] = true

	const won = updateWord()
	if (won) {
		console.log("Won!")
		endRound(EndState.Won)
	}
}

function clickedIncorrect(button) {
	button.classList.add(CLICKED_INCORRECT_CLASS)

	numWrong += 1
	advanceImage()

	const lost = (numWrong >= SVG_OBJECTS.length - 1)
	if (lost) {
		console.log("Lost!")
		endRound(EndState.Lost)
	}
}

function onButtonClick(clickInfo) {
	if (curWord == null) return
	if (!playing) return

	const button = clickInfo.target
	if (wasClicked(button)) return

	curWord.includes(button.textContent) ? clickedCorrect(button) : clickedIncorrect(button)
}


function main() {
	initButtons()
	startRound()
	NEXT_ROUND_BUTTON.addEventListener("click", startRound)
}
main()