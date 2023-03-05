{
let canvas = document.getElementById("dots-canvas")
let canvasContext = canvas.getContext("2d")

const FOV = 90
const FPS = 30

const ROT_DIST = 10
const ROT_HEIGHT = 5
const ROT_SPEED = 1.5 // Deg per sec

const MAX_HOR_DIST = 50
const MIN_HOR_DIST = 11
const MAX_VER_DIST = 50

const POINT_RATE = 50 // Points per second
const MAX_POINTS = 500

const MIN_SIZE = 0.2
const MAX_SIZE = 0.2

const COLOR = "#FF3232"
const ALT_COLOR = "#00AAFF"
const ALT_COLOR_CHANCE = 0.1
const COLOR_MAPPING_FUNC = (dist => 1 - dist**2) // Maps distance ([0, 1]) to alpha ([0, 1])
const EXTRA_RENDER_DIST = 10

const FADE_TIME = 3
const FADE_STEPS = 30
const MIN_LIFE_TIME = 30
const MAX_LIFE_TIME = 120

const LOOK_Y_RANGE = 5
const LOOK_Z_RANGE = 5
const LOOK_LERP_ALPHA = 0.025


let canvasWidth, canvasHeight, scaleFactor;
recalculateSize()
window.addEventListener("resize", () => {
	recalculateSize()
	renderPoints()
})

let cameras = []
let points = []

function recalculateSize() {
	canvasWidth = canvas.clientWidth
	canvasHeight = canvas.clientHeight

	let halfFovRadians = rad(FOV / 2)
	let planeWidth = Math.tan(halfFovRadians) * 2
	scaleFactor = canvasWidth / planeWidth * window.devicePixelRatio

	canvas.setAttribute("width", canvasWidth)
	canvas.setAttribute("height", canvasHeight)
}


// == Misc Math Functions == //
function rad(deg) {
	return deg * Math.PI / 180
}

function deg(rad) {
	return rad * 180 / Math.PI
}

function randomInRange(min, max) {
	return Math.random() * (max - min) + min
}

function getDist(x, y, z) {
	return Math.sqrt(x**2 + y**2 + z**2)
}

function lerp(a, b, alpha) {
	return a + alpha * (b - a);
}

function clamp(n, min, max) {
	return Math.min(Math.max(n, min), max)
}


//== Vector/CFrame Functions ==//
// Taken from https://stackoverflow.com/a/44446912 (modified)
function invertCFrame(inp) {
	let m = [
		[inp.right[0], inp.up[0], inp.back[0], inp.pos[0]],
		[inp.right[1], inp.up[1], inp.back[1], inp.pos[1]],
		[inp.right[2], inp.up[2], inp.back[2], inp.pos[2]],
		[0, 0, 0, 1],
	]

	let A2323 = m[2][2] * m[3][3] - m[2][3] * m[3][2]
	let A1323 = m[2][1] * m[3][3] - m[2][3] * m[3][1]
	let A1223 = m[2][1] * m[3][2] - m[2][2] * m[3][1]
	let A0323 = m[2][0] * m[3][3] - m[2][3] * m[3][0]
	let A0223 = m[2][0] * m[3][2] - m[2][2] * m[3][0]
	let A0123 = m[2][0] * m[3][1] - m[2][1] * m[3][0]
	let A2313 = m[1][2] * m[3][3] - m[1][3] * m[3][2]
	let A1313 = m[1][1] * m[3][3] - m[1][3] * m[3][1]
	let A1213 = m[1][1] * m[3][2] - m[1][2] * m[3][1]
	let A2312 = m[1][2] * m[2][3] - m[1][3] * m[2][2]
	let A1312 = m[1][1] * m[2][3] - m[1][3] * m[2][1]
	let A1212 = m[1][1] * m[2][2] - m[1][2] * m[2][1]
	let A0313 = m[1][0] * m[3][3] - m[1][3] * m[3][0]
	let A0213 = m[1][0] * m[3][2] - m[1][2] * m[3][0]
	let A0312 = m[1][0] * m[2][3] - m[1][3] * m[2][0]
	let A0212 = m[1][0] * m[2][2] - m[1][2] * m[2][0]
	let A0113 = m[1][0] * m[3][1] - m[1][1] * m[3][0]
	let A0112 = m[1][0] * m[2][1] - m[1][1] * m[2][0]

	let det = m[0][0] * (m[1][1] * A2323 - m[1][2] * A1323 + m[1][3] * A1223)
		- m[0][1] * (m[1][0] * A2323 - m[1][2] * A0323 + m[1][3] * A0223)
		+ m[0][2] * (m[1][0] * A1323 - m[1][1] * A0323 + m[1][3] * A0123)
		- m[0][3] * (m[1][0] * A1223 - m[1][1] * A0223 + m[1][2] * A0123)
	det = 1 / det

	return {
		right: [
			det * (m[1][1] * A2323 - m[1][2] * A1323 + m[1][3] * A1223),
			det * - (m[1][0] * A2323 - m[1][2] * A0323 + m[1][3] * A0223),
			det * (m[1][0] * A1323 - m[1][1] * A0323 + m[1][3] * A0123),
		],
		up: [
			det * - (m[0][1] * A2323 - m[0][2] * A1323 + m[0][3] * A1223),
			det * (m[0][0] * A2323 - m[0][2] * A0323 + m[0][3] * A0223),
			det * - (m[0][0] * A1323 - m[0][1] * A0323 + m[0][3] * A0123),
		],
		back: [
			det * (m[0][1] * A2313 - m[0][2] * A1313 + m[0][3] * A1213),
			det * - (m[0][0] * A2313 - m[0][2] * A0313 + m[0][3] * A0213),
			det * (m[0][0] * A1313 - m[0][1] * A0313 + m[0][3] * A0113),
		],
		pos: [
			det * - (m[0][1] * A2312 - m[0][2] * A1312 + m[0][3] * A1212),
			det * (m[0][0] * A2312 - m[0][2] * A0312 + m[0][3] * A0212),
			det * - (m[0][0] * A1312 - m[0][1] * A0312 + m[0][3] * A0112),
		],
	}
}

function pointToWorldSpace(point, cframe) {
	return [
		// Multiply right, up, back by point[0], [1] and [2] respectively and then sum (including pos)
		// Inlining it like this is necessary for performance
		cframe.pos[0] + cframe.right[0] * point[0] + cframe.up[0] * point[1] + cframe.back[0] * point[2],
		cframe.pos[1] + cframe.right[1] * point[0] + cframe.up[1] * point[1] + cframe.back[1] * point[2],
		cframe.pos[2] + cframe.right[2] * point[0] + cframe.up[2] * point[1] + cframe.back[2] * point[2],
		point[3], // Size mult
		point[4], // Size
		point[5], // Color
	]
}

function orientationToCFrame(xRot, yRot, zRot, pos) {
	let sinX = Math.sin(rad(xRot))
	let sinY = Math.sin(rad(yRot))
	let sinZ = Math.sin(rad(zRot))
	let cosX = Math.cos(rad(xRot))
	let cosY = Math.cos(rad(yRot))
	let cosZ = Math.cos(rad(zRot))

	return {
		// Copy-pasted from https://en.wikipedia.org/wiki/Rotation_matrix#General_rotations
		right: [cosX * cosY, cosX * sinY * sinZ - sinX * cosZ, cosX * sinY * cosZ + sinX * sinZ],
		up: [sinX * cosY, sinX * sinY * sinZ + cosX * cosZ, sinX * sinY * cosZ - cosX * sinZ],
		back: [-sinY, cosY * sinZ, cosY * cosZ],
		// right: [cosY * cosZ,   sinX * sinY * cosZ - cosX * sinZ,   cosX * sinY * cosZ + sinX * sinZ],
		// up:    [cosY * sinZ,   sinX * sinY * sinZ + cosX * cosZ,   cosX * sinY * sinZ - sinX * cosZ],
		// back:  [-sinY,         sinX * cosY,                        cosX * cosY                     ],
		pos: Array.from(pos),
	}
}


//== Rendering Functions ==//
function clearAllPoints() {
	canvasContext.clearRect(0, 0, canvasWidth, canvasHeight)
}

function renderPoints() {
	clearAllPoints()

	for (let point of points) {
		// Remember the cameras are already inverted, so we're actually doing pointToObjectSpace
		let [x, y, z, rNow, rFin, c] = cameras.reduce(pointToWorldSpace, point)
		if (z <= 0) {
			continue // Don't render points behind the camera
		}

		let scale = 1 / z * scaleFactor

		let screenX = x * scale
		let screenY = y * scale
		let screenR = (rNow * rFin) * scale

		let canvasX =  screenX + (canvasWidth / 2)
		let canvasY = -screenY + (canvasHeight / 2)
		let canvasR = screenR

		if (
			   canvasX < -canvasR
			|| canvasX > canvasWidth + canvasR
			|| canvasY < -canvasR
			|| canvasY > canvasHeight + canvasR
		) {
			continue // Don't render points off-screen
		}

		let dist = getDist(x, y, z)
		let normalizedDist = (dist - MIN_HOR_DIST) / (MAX_HOR_DIST - MIN_HOR_DIST + ROT_DIST + EXTRA_RENDER_DIST)
		let alpha = COLOR_MAPPING_FUNC(normalizedDist)

		canvasContext.beginPath()
		canvasContext.fillStyle = c
		canvasContext.globalAlpha = clamp(alpha, 0, 1)
		canvasContext.arc(canvasX, canvasY, canvasR, 0, rad(360))
		canvasContext.fill()
	}
}


function newRandomPoint() {
	let x = randomInRange(-MAX_HOR_DIST, MAX_HOR_DIST)
	let y = randomInRange(-MAX_VER_DIST, MAX_VER_DIST)
	let z = randomInRange(-MAX_HOR_DIST, MAX_HOR_DIST)

	let dist = getDist(x, 0, z)
	if (dist < MIN_HOR_DIST || dist > MAX_HOR_DIST) {
		return newRandomPoint() // Retry
	}

	return [
		x, y, z,
		0, randomInRange(MIN_SIZE, MAX_SIZE),
		Math.random() < ALT_COLOR_CHANCE ? ALT_COLOR : COLOR,
	]
}

let mouseX = 0, mouseY = 0
document.addEventListener("mousemove", event => {
	mouseX = event.clientX
	mouseY = event.clientY
})



// == Rendering Loop == //

let cameraRotZ = deg(Math.atan2(ROT_HEIGHT, ROT_DIST))
let lookCamera = invertCFrame(orientationToCFrame(0, 0, -cameraRotZ, [0, 0, 0]))

let curLookY = 0
let curLookZ = 0

setInterval(() => {
	if (Document.hidden) { return }

	let angle = (performance.now() / 1000 * ROT_SPEED) % 360

	let cameraPosX = -Math.cos(rad(angle)) * ROT_DIST
	let cameraPosY = ROT_HEIGHT
	let cameraPosZ = -Math.sin(rad(angle)) * ROT_DIST

	let cameraRotY = angle - 90
	let camera = invertCFrame(orientationToCFrame(0, cameraRotY, 0, [cameraPosX, cameraPosY, cameraPosZ]))

	let screenWidth = document.documentElement.clientWidth
	let screenHeight = document.documentElement.clientHeight

	let newLookY = (1 - mouseX / screenWidth * 2) * LOOK_Y_RANGE
	let newLookZ = (1 - mouseY / screenHeight * 2) * LOOK_Z_RANGE

	curLookY = lerp(curLookY, newLookY, LOOK_LERP_ALPHA)
	curLookZ = lerp(curLookZ, newLookZ, LOOK_LERP_ALPHA)

	let lookOffset = invertCFrame(orientationToCFrame(0, curLookY, curLookZ, [0, 0, 0]))

	cameras = [camera, lookCamera, lookOffset]

	renderPoints()
}, 1/FPS * 1000)


// == Point Animation Loop == //

let fadingIn = []
let fadingOut = []

if (FADE_TIME >= MIN_LIFE_TIME) {
	throw "fade time must be smaller than life time"
}

// Creation loop
setInterval(() => {
	if (points.length >= MAX_POINTS) { return }

	let point = newRandomPoint()
	points.push(point)
	fadingIn.push(point)

	setTimeout(() => {
		fadingOut.push(point)
	}, randomInRange(MIN_LIFE_TIME, MAX_LIFE_TIME) * 1000);

}, 1/POINT_RATE * 1000)

// Fading loop
let fadeStep = 1 / FADE_STEPS
setInterval(() => {
	for (let i = fadingIn.length - 1; i >= 0; i--) {
		let point = fadingIn[i]

		point[3] += fadeStep

		if (point[3] >= 1) { // Point is faded in
			fadingIn.splice(i, 1)
		}
	}

	for (let i = fadingOut.length - 1; i >= 0; i--) {
		let point = fadingOut[i]
		
		point[3] -= fadeStep * 1.01 // Fade out slightly faster to avoid getting stuck if fading both in and out (rare)

		if (point[3] <= 0) { // Point has been faded out
			fadingOut.splice(i, 1)
			points.splice(points.indexOf(point), 1)
		}
	}
}, FADE_TIME / FADE_STEPS * 1000)


console.log("Dots initialized")
}