<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
	$(head{ name = "Hangman", desc = "A friendly game of hangman." })
	<script src="./assets/scripts/hangman.js" defer></script>
</head>

<body>
	$(sidebar{})

	<main class="padded-main">
		<h1 class="mb-0">Hangman</h1>
		<div class="h1-splash" title="Or, well, as friendly as it gets.">A friendly game of Hangman</div>

# 		function word(title)
		<div class="hangman-word loading
			text-[clamp(2.25em,8vw,3.75em)] -mx-2 font-mono tracking-widest text-center break-words
			[&_>_.not-guessed]:text-incorrect
			[&.loading]:font-sans [&.loading]:tracking-normal
		" title="$(title)">Waiting for JS...</div>
# 		end
#
# 		word("Staring at it ain’t gonna solve it, buddy.")

		<div class="flex flex-col mx-auto mt-8 xs:max-w-[70vw] md:flex-row text-center">
			<svg class="fill-gray-100 w-full max-w-[35vmin] mx-auto mb-4
				" viewBox="0 0 100 110" xmlns="http://www.w3.org/2000/svg">
				<!-- Gallow --> <path d="M 15 0  H 80  V 17.5  H 70  V 10  H 25  V 100  H 40  V 110  H 0  V 100  H 15  Z" />

				<g id="hangman-svg-parts" class="
					*:fill-opacity-0 [&>.shown]:fill-opacity-100
					*:transition-[fill-opacity] *:duration-300 *:ease-linear
				">
					<!-- Head      --> <circle cx="75" cy="30" r="12.5" />
					<!-- Body      --> <rect x="72.6" y="42.24745" width="5" height="40.075" />
					<!-- Left Arm  --> <polygon points="73.96447, 47.24745   77.50000, 50.78298   59.82233, 68.46065   56.28680, 64.92512" />
					<!-- Left Leg  --> <polygon points="72.50000, 78.78680   76.03553, 82.32233   58.35786, 100.0000   54.82233, 96.46447" />
					<!-- Right Arm --> <polygon points="76.03553, 47.24745   93.71320, 64.92512   90.17767, 68.46065   72.50000, 50.78298" />
					<!-- Right Leg --> <polygon points="77.50000, 78.78680   95.17767, 96.46447   91.64214, 100.0000   73.96447, 82.32233" />
					<!-- Left Eye  --> <path class="fill-gray-800" d="M68.5,25  l2,2  l2,-2  l1,1  l-2,2  l2,2  l-1,1  l-2,-2  l-2,2  l-1,-1  l2,-2  l-2,-2" />
					<!-- Right Eye --> <path class="fill-gray-800" d="M77.5,25  l2,2  l2,-2  l1,1  l-2,2  l2,2  l-1,1  l-2,-2  l-2,2  l-1,-1  l2,-2  l-2,-2" />
				</g>
			</svg>

			<div id="hangman-button-container" class="flex-1"><!-- Smash. Click. Press. -->
				<template id="button-template">
					<button tabindex="-1" class="
						text-base md:text-xl p-2 md:p-3 m-1.5 rounded-lg font-medium bg-gray-700
						data-[clicked=correct]:bg-correct data-[clicked=incorrect]:bg-incorrect
						transition-all duration-400 hofoac-highlight
					" data-clicked="none"></button>
				</template>
			</div>
		</div>
		<div id="end-overlay" class="
			fixed left-0 top-0 w-full h-full bg-gray-900 opacity-0 pointer-events-none z-20 overflow-auto
			transition-opacity duration-700 ease-[ease]
			data-[is-playing=false]:opacity-[98%] data-[is-playing=false]:pointer-events-auto
			p-10 pt-7 pb-15 sm:pt-10 sm:pb-20 flex flex-col items-center text-center
		" data-is-playing="true">
			<div class="flex-none w-full">
				<h2 id="end-overlay-title" class="mb-4 text-lg sm:text-xl">You won!</h2>
				<div>The word was: <!-- Must be in div to be centered--></div>
# 				word("Damn, get over it already.")
				<ul class="inline-list text-xs sm:text-base">
					<li><span id="stats-hits"    class="text-correct    ">?</span>&nbsp;hits</li>
					<li><span id="stats-misses"  class="text-incorrect  ">?</span>&nbsp;misses</li>
					<li><span id="stats-seconds" class="text-accent-blue">?</span>&nbsp;seconds</li>
				</ul>
			</div>
			<div class="flex-1 flex flex-col justify-center pt-5 pb-2 max-w-2xl">
				<h3 id="definitions-title" class="text-sm sm:text-base">Definitions found for <b></b>:</h3>
				<ul id="hangman-word-definitions-list" class="table border-spacing-3">
					<template id="definition-template">
						<li class="table-row text-left text-sm sm:text-base">
							<span class="table-cell text-right font-bold w-1/4 pr-5"></span>
						</li>
					</template>
				</ul>
			</div>
			<button class="flex-none text-xl bg-gray-700 rounded-lg p-3"
				id="end-overlay-button" tabindex="-1">Play Again</button>
		</div>

		<div class="mt-32 text-2xs md:text-xs text-gray-400 brightness-50">
			<p>
				This game is (unofficially) powered by
				<a href="https://random-word-api.herokuapp.com/">https://random-word-api.herokuapp.com/</a>
				and as such I cannot <em>guarantee</em> that:
			</p>
			<ol class="list-disc ml-10 mt-1 mb-4">
				<li>the difficulty is reasonable,</li>
				<li>the provided words are real English words,</li>
				<li>or that provided words will be family-friendly (even though they should be).</li>
			</ol>
			<p>
				Definitions are fetched from the <a href="https://dictionaryapi.dev/">Free Dictionary API</a>
				or from <a href="https://en.wiktionary.org/">Wiktionary</a> and as such may be subject to the
				terms of the <a href="https://creativecommons.org/licenses/by-sa/3.0/">CC BY-SA 3.0 License</a>.
			</p>
		</div>
	</main>
</body>
</html>
