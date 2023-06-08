/*
	A simple code-based SVG editor, using the Ace (https://ace.c9.io/) and the
	browser. Features:
	* Live preview
	* Show coordinates on hover
	* Move elements using the arrow keys

	Depends on the Ace editor.

	Side effects:
	* Clears any text selections when moving selected elements.
*/

{
const DEFAULT_SVG = `<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
	<rect fill="#252525" x="1" y="1" width="98" height="98"/>
	<circle fill="#ff3232" cx="50" cy="50" r="30"/>
</svg>`

// Testing <path>:
// <path fill="#ff3232" d="M0,1 10,10 L30,40 40,40 H3,15 V-10,10 C 10,10 40,110 90,90   100,80 50,120,90,10  S50,50 60,70  100,100 50,30 Q 0  100 10,  80  T50,15-30,20 L 30,80 A20,20,140,0,0, 40,80 ZZ"></path>

const EDITOR_ID = "ace-editor"
const CODE_BOX_ERROR_CLASS = "has-error"
const CROSS_CLASS = "mouse-cross"
const SELECTED_CLASS = "selected"

const COORD_PLACEHOLDER = "--.-"

const editorElement = document.getElementById(EDITOR_ID)
const stepBox = document.getElementById("step-box")
const canvas = document.getElementById("svg-canvas")
const coordsLabel = document.getElementById("coords-label")
const selectedLabel = document.getElementById("selected-label")

const PARSER = new DOMParser()
const SERIALIZER = new XMLSerializer()

let svg = null
let svgX = 0, svgY = 0
let crossesAreHidden = true
let step = 1
let selection = new Set()
let stashedSelection = []
let stashedSelectionDomainSize = 0

let horCross = document.createElement("div")
let verCross = document.createElement("div")

horCross.classList.add(CROSS_CLASS)
verCross.classList.add(CROSS_CLASS)
document.body.appendChild(verCross)
document.body.appendChild(horCross)

const editor = ace.edit(EDITOR_ID)
editor.setOptions({
	fontSize: 18,
	tabSize: 4,
	useSoftTabs: false,
	cursorStyle: "slim",
	scrollPastEnd: 0.25,
	autoScrollEditorIntoView: true,
	copyWithEmptySelection: true,
	showPrintMargin: false,
	theme: "ace/theme/chaos",
})
editor.session.setMode("ace/mode/svg")
editor.setValue(DEFAULT_SVG, DEFAULT_SVG.length)

// Randomize the input textarea name attribute to prevent Firefox from messing
// with it when duplicating pages. Random string code: https://stackoverflow.com/a/33146982
document.querySelector("textarea.ace_text-input")?.setAttribute("name", Math.random().toString(36).slice(-5))


let movers; {
	function roundSvgCoord(num) { // Round floating point errors
		return Math.round(num * 1e13) / 1e13
	}

	function addCoords(str, num) {
		return roundSvgCoord((parseFloat(str) || 0) + num)
	}

	function increaseAttrib(element, attrib, value) {
		return element.setAttribute(attrib, addCoords(element.getAttribute(attrib), value))
	}

	function hasSign(num) {
		return /^[-+]/.test(num.toString())
	}

	/**
	 * Takes a string containing numbers and calls a callback for every number,
	 * replacing the number in the string with the result of the callback.
	 * 
	 * The callback receives two arguments: the order of the number as an integer
	 * starting at 0, and the number itself as a string.
	 */
	function modifyNumbers(str, callback) {
		let i = -1

		return str.replaceAll(/([\s,]?)([-+]?[\d.]+)/g, (_, space, num) => {
			i += 1
			let newNum = callback(i, num)

			// Pad with space if sign was removed and there is no leading space
			if (space == "" && hasSign(num) && !hasSign(newNum)) {
				newNum = " " + newNum
			}

			return space + newNum
		})
	}

	const xYMover = (element, x, y) => {
		increaseAttrib(element, "x", x)
		increaseAttrib(element, "y", y)
	}

	const cxCyMover = (element, x, y) => {
		increaseAttrib(element, "cx", x)
		increaseAttrib(element, "cy", y)
	}

	const polypointsMover = (poly, x, y) => {
		poly.setAttribute("points", modifyNumbers(poly.getAttribute("points"), (i, num) => {
			return addCoords(num, i % 2 == 0 ? x : y)
		}))
	}

	const pathMover = (path, x, y) => {
		let d = path.getAttribute("d")
		let firstLetter = d.match(/^\s*([a-zA-Z])/)?.[1]
		if (firstLetter == "m") {
			d = d.replace("m", "M") // Should convert only first "m"
		} else if (firstLetter && firstLetter != "M") {
			d = "M0,0 " + d
		}

		path.setAttribute("d", d.replaceAll(/([a-zA-Z])[^a-zA-Z]*/g, (command, name) => {
			switch (name) {
				// Always increase by x
				case "H":
					return modifyNumbers(command, (_, num) => addCoords(num, x))

				// Always increase by y
				case "V":
					return modifyNumbers(command, (_, num) => addCoords(num, y))

				// Pairs of (x, y): Alternate increasing by x and y
				case "M":
				case "L":
				case "C":
				case "S":
				case "Q":
				case "T":
					return modifyNumbers(command, (i, num) => addCoords(num, i % 2 == 0 ? x : y))

				// Arcs: In each command, increase the 6th and 7th value
				case "A":
					return modifyNumbers(command, (i, num) => {
						switch (i % 7) {
							case 5:
								return addCoords(num, x)
							case 6:
								return addCoords(num, y)
							default:
								return num
						}
					})

				// Not a command we care about; return it unchanged
				default:
					return command
			}
		}))
	}

	movers = {
		use: xYMover,
		image: xYMover,
		text: xYMover,
		rect: xYMover,
		circle: cxCyMover,
		ellipse: cxCyMover,
		line: (line, x, y) => {
			increaseAttrib(line, "x1", x)
			increaseAttrib(line, "x2", x)
			increaseAttrib(line, "y1", y)
			increaseAttrib(line, "y2", y)
		},
		polygon: polypointsMover,
		polyline: polypointsMover,
		path: pathMover,
	}
}

function roundDisplayCoord(num) {
	return (Math.round(num * 10) / 10).toFixed(1)
}

function getNodesOrdered(element) {
	return Array.from(element.getElementsByTagName("*")) // https://stackoverflow.com/a/22732879
}


function selectElement(element) {
	selection.add(element)
	element.classList.add(SELECTED_CLASS)
}

function deselectElement(element) {
	selection.delete(element)
	element.classList.remove(SELECTED_CLASS)
	if (element.classList.length == 0) {
		element.removeAttribute("class")
	}	
}

/** Clears the current selection and stores it into the global `stashedSelection` variable */
function stashSelection() {
	let ordered = getNodesOrdered(svg)

	stashedSelection = []
	stashedSelectionDomainSize = ordered.length
	for (let selected of selection) {
		stashedSelection.push(ordered.indexOf(selected))
		deselectElement(selected)
	}
}

/** Takes the selection in the global `stashedSelection` variable and applies it if possible. */
function applyStashedSelection() {
	let ordered = getNodesOrdered(svg)

	if (ordered.length != stashedSelectionDomainSize) {
		return
	}

	for (let index of stashedSelection) {
		selectElement(ordered[index])
	}
}

function updateDisplay() {
	let newCoords = `${svgX == null ? COORD_PLACEHOLDER : svgX}, ${svgY == null ? COORD_PLACEHOLDER : svgY}`
	let newSelected = selection.size > 0 ? `(${selection.size} selected)` : ""

	// Changing textContent removes any text selection the user may have made, so update only when necessary
	if (coordsLabel.textContent != newCoords) {
		coordsLabel.textContent = newCoords
	}
	if (selectedLabel.textContent != newSelected) {
		selectedLabel.textContent = newSelected
	}
}

function setCrossesHidden(hidden) {
	if (crossesAreHidden == hidden) { // Mostly a performance optimization
		return
	}

	let display = hidden ? "none" : "block"
	verCross.style.display = display
	horCross.style.display = display

	crossesAreHidden = hidden
}

function setCrossPos(cross, x, y, width, height) {
	cross.style.left = x + "px"
	cross.style.top = y + "px"
	cross.style.width = width + "px"
	cross.style.height = height + "px"
}


function updateEditor() {
	if (!svg) {
		throw "attempt to update editor when no SVG"
	}

	// Must de-select and then re-select for serialization
	stashSelection()
	let serialized = SERIALIZER.serializeToString(svg)
	applyStashedSelection()

	editor.setValue(serialized, serialized.length)
}

function parseSvg(raw) {
	if (raw == "") {
		return [null, "Content is empty"]
	}

	let err = null

	// Parse
	let doc = PARSER.parseFromString(raw, "image/svg+xml")
	let errNode = doc.querySelector("parsererror")
	if (errNode) {
		err = err || errNode.textContent.replace(/\nLocation: [\s\S]*$/, "")
	}

	// Extract SVG (https://stackoverflow.com/a/67309255)
	let parsed = doc.getElementsByTagNameNS("http://www.w3.org/2000/svg", "svg").item(0)
	if (!parsed) {
		err = err || "Not an SVG!"
	}

	return [parsed, err]
}

function updateSvg() {
	if (svg) {
		stashSelection()
	}

	let err; [svg, err] = parseSvg(editor.getValue())

	// Handle errors
	if (err) {
		editorElement.classList.add(CODE_BOX_ERROR_CLASS)
	} else {
		editorElement.classList.remove(CODE_BOX_ERROR_CLASS)
	}

	// Replace SVG
	canvas.firstChild?.remove()
	if (svg) {
		canvas.appendChild(svg)
		applyStashedSelection()
	}
}


function moveSelection(xDir, yDir, mod) {
	let xMove = xDir * mod * step
	let yMove = yDir * mod * step

	console.log(`Moving selection: ${xMove}, ${yMove}`)

	for (let selected of selection) {
		movers[selected.tagName.toLowerCase()]?.(selected, xMove, yMove)
	}

	updateEditor()
}


function handleMouseMove(event) {
	svgX = null
	svgY = null

	if (!svg) {
		setCrossesHidden(true)
		updateDisplay()
		return
	}

	// Calculate pixel pos relative to SVG and make sure we're actually hovering over it
	let rect = svg.getBoundingClientRect()
	let canvasX = event.clientX - rect.x
	let canvasY = event.clientY - rect.y

	if (canvasX < 0 || canvasX > svg.clientWidth || canvasY < 0 || canvasY > svg.clientHeight) {
		setCrossesHidden(true)
		updateDisplay()
		return
	}

	// Calculate pos in SVG units and update UI
	let [svgOffsetX, svgOffsetY, svgWidth, svgHeight] = svg.getAttribute("viewBox").split(/[\D-]+/).map(parseFloat)

	svgX = roundDisplayCoord((canvasX / svg.clientWidth) * svgWidth + svgOffsetX)
	svgY = roundDisplayCoord((canvasY / svg.clientHeight) * svgHeight + svgOffsetY)

	setCrossPos(verCross, event.clientX, rect.y, 1, svg.clientHeight)
	setCrossPos(horCross, rect.x, event.clientY, svg.clientWidth, 1)
	setCrossesHidden(false)
	updateDisplay()
}

function handleClick(event) {
	let target = event.target
	if (!svg) {
		return
	} else if (svg.contains(target) && target != svg) { // https://htmldom.dev/check-if-an-element-is-a-descendant-of-another/
		!selection.has(target) ? selectElement(target) : deselectElement(target)
	} else if (target != svg && selection.size > 0) {
		stashSelection()
	}

	updateDisplay()
}

function handleKeypress(event) {
	if (editor.isFocused()) {
		return
	}

	if (event.code == "Space") {
		selection.size > 0 ? stashSelection() : applyStashedSelection()
		updateDisplay()
		return
	} 
	
	if (selection.size <= 0) {
		return
	}

	let mod = 1
	if (event.ctrlKey) {
		mod = 3
	} else if (event.shiftKey) {
		mod = 0.5
	}
	
	switch (event.code) {
		case "ArrowUp":
		case "ArrowDown":
		case "ArrowRight":
		case "ArrowLeft":
			event.preventDefault() // Don't scroll the page (https://stackoverflow.com/a/8916697)
			event.shiftKey && window.getSelection().empty() // Don't select text (https://stackoverflow.com/a/50709103)
	}

	switch (event.code) {
		case "ArrowUp":
			moveSelection(0, -1, mod)
			break
		case "ArrowDown":
			moveSelection(0, 1, mod)
			break
		case "ArrowRight":
			moveSelection(1, 0, mod)
			break
		case "ArrowLeft":
			moveSelection(-1, 0, mod)
			break
	}
}

function updateStep() {
	let value = parseFloat(stepBox.value)

	if (typeof(value) == "number" && value > 0) {
		step = value
		console.log("Step changed to " + value)
	} else {
		console.log("Invalid step value")
	}
}

editor.session.on("change", updateSvg)
document.addEventListener("mousemove", handleMouseMove)
document.addEventListener("click", handleClick)
document.addEventListener("keydown", handleKeypress)
document.addEventListener("scroll", _ => setCrossesHidden(true)) // Mouse doesn't update smoothly on touch devices
stepBox.addEventListener("change", updateStep)

updateSvg()
updateStep()

}