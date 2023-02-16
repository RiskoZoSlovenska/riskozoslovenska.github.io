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

const BUTTON_CONTAINER = document.getElementById("hangman-button-container")
const WORD = document.getElementById("hangman-word")
const END_BAR = document.getElementById("game-end-bar")
const END_BAR_HEADING = document.getElementById("game-end-bar-heading")
const END_BAR_REMARK = document.getElementById("game-end-bar-remark")
const NEXT_ROUND_BUTTON = document.getElementById("game-end-bar-next-button")

const IMAGE_PARTS = document.getElementById("hangman-svg-parts").children

const LOADING_CLASS = "loading"
const VISIBLE_IMAGE_PART_CLASS = "visible-hangman-part"
const CLICKED_CORRECT_CLASS = "clicked-correct"
const CLICKED_INCORRECT_CLASS = "clicked-incorrect"
const NOT_GUESSED_LETTER_CLASS = "not-guessed-letter"

const QUEUE_LOW_THRESHOLD = 5 // Remember to change the fetch number in the below url as well
const WORDS_FETCH_URL = "https://random-word-api.herokuapp.com/word?number=10"


let playing = false
let curWord = null
let wordQueue = []
let visibleLetters = {}
let numWrong = 0



function getRandomElement(arr) {
	return arr[Math.floor(Math.random() * arr.length)]
}

function removeAllChildren(element) {
	element.textContent = null // Remove text first (which should remove a fair amount of elements)

	while (element.firstChild) { // ...and then remove everything else that's left
		element.lastChild.remove()
	}
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
		.then(res => res.ok ? res.json() : Promise.reject(res.status + " " + res.statusText))
		.then(words => {
			let filtered = words
				.map(word => word.toUpperCase())
				.filter(isWordValid)

			console.log("Successfully fetched " + filtered.length + " words.")
			wordQueue = wordQueue.concat(filtered)
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
		const button = document.createElement("button")
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

		button.classList.remove(CLICKED_CORRECT_CLASS)
		button.classList.remove(CLICKED_INCORRECT_CLASS)
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

	const lost = (numWrong >= IMAGE_PARTS.length)
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
	bindButtonToKeystroke(NEXT_ROUND_BUTTON, "Enter")
}
main()

}