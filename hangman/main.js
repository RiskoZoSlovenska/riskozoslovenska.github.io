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

const IMAGE_COLOR = window.getComputedStyle(document.documentElement).getPropertyValue("--main-text-color")
const LOADING_CLASS = "loading"
const CLICKED_CORRECT_CLASS = "clicked-correct"
const CLICKED_INCORRECT_CLASS = "clicked-incorrect"

const QUEUE_LOW_THRESHOLD = 5 // Remember to change the fetch number in the below url as well
const WORDS_FETCH_URL = "https://random-word-api.herokuapp.com/word?number=10&swear=0"


let curWord = null
let wordQueue = []
let visibleLetters = {}
let numWrong = 0



function removeAllChildren(element) {
	while (element.firstChild) {
		element.lastChild.remove()
	}
}

function wasClicked(button) {
	return button.classList.contains(CLICKED_CORRECT_CLASS) || button.classList.contains(CLICKED_INCORRECT_CLASS)
}


function filterWord(word) {
	// Filtering happens before so the word should be all uppercase already
	for (let i = 0; i < word.length; i++) {
		if (!ALPHA.includes(word[i])) {
			return false
		}
	}

	return word
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



function updateWord() {
	WORD.classList.remove(LOADING_CLASS) // Remove loading class if it's still present

	let asVisible = ""
	let isFullyVisible = true

	for (let i = 0; i < curWord.length; i++) {
		const letter = curWord[i]

		if (visibleLetters[letter]) {
			asVisible += letter
		} else {
			asVisible += "_"
			isFullyVisible = false
		}
	}

	WORD.textContent = asVisible
	return isFullyVisible
}




function clickedCorrect(button) {
	button.classList.add(CLICKED_CORRECT_CLASS)

	const letter = button.textContent
	visibleLetters[letter] = true;
	const won = updateWord()

	if (won) {
		console.log("Won!") // TODO
		nextRound()
	}
}

function clickedIncorrect(button) {
	button.classList.add(CLICKED_INCORRECT_CLASS)

	numWrong += 1
	advanceImage()
	const lost = (numWrong >= SVG_OBJECTS.length - 1)

	if (lost) {
		console.log("Lost!") // TODO
		nextRound()
	}
}

function onButtonClick(clickInfo) {
	if (curWord == null) return

	const button = clickInfo.target
	if (wasClicked(button)) return

	const letter = button.textContent
	if (curWord.includes(letter)) {
		clickedCorrect(button)
	} else {
		clickedIncorrect(button)
	}
}


function getRandomBackupWord() {
	return BACKUP_WORDS[Math.floor(Math.random() * BACKUP_WORDS.length)]
}

function fetchWords() {
	console.log("Fetching words...")

	fetch(WORDS_FETCH_URL)
		.then(data => data.json())
		.then(words =>
			wordQueue = wordQueue.concat(
				words
					.map(word => word.toUpperCase())
					.filter(filterWord)
			)
		)
}


function nextRound() {
	console.log("Starting round")

	resetButtons()

	numWrong = 0
	resetImage()
	advanceImage() // Show gallow

	curWord = (wordQueue.length == 0) ? getRandomBackupWord() : wordQueue.shift()
	if (wordQueue.length < QUEUE_LOW_THRESHOLD) {
		fetchWords()
	}
	visibleLetters = {}
	updateWord()
}


function main() {
	initButtons()
	nextRound()
}
main()