<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
	$(head{ name = "Fragments", desc = "Twinkling like the forgotten stars of the Abyss." })
	<script src="./assets/scripts/cheating.js" defer></script>
	<script src="./assets/scripts/fragments.js" defer></script>
</head>

<body>
	<div id="cheating-insert"></div>
	<div id="sidebar-insert"></div>

	<main class="padded-main">
		<h1 class="mb-0" title="Not to be confused with Echoes — those don’t exist in this reality.">Fragments</h1>
		<div class="h1-splash" title="Better get searching.">The best things have to be found.</div>






















			<!-- cheater. -->



















		<div id="fragments-canvas" class="relative h-[85vh] overflow-hidden" data-unsearchable>
# 			for i, text in ipairs {
# 				"", -- Dummy fragment
# 				"Fragments, twinkling like forgotten stars of the Abyss.",
# 				"The waking edge, where reality bleeds and dreams die.",
# 				"… demand to be put into hypnagogia immediately and indefinitely.",
# 				"All fear the Tearing, all run from the Tearing, for-",
# 				"Kept in line by the bloodied edge of failure.",
# 				"Walking with the dead makes you feel alive.",
# 				"Where was the part where [I] grew up?",
# 				"Is that the future so bright or the radiation sickness?",
# 				"The fire’s brighter than all of our futures, somehow.",
# 				"Eat the devil or there’s nothing you can do.",
# 				"[We] should be growing up, but instead [We]’re growing old.",
# 				"!",
# 				"Mayday. Mayday. Out.",
# 				"<em>Click.</em>",
# 				"ᓚᘏᗢ",
# 				[[<svg class="fill-gray-100 box-content" height="90" viewBox="0 0 73 41" xmlns="http://www.w3.org/2000/svg">
# 					<path id="g-fragment-main" d="M0,13  l10,3  h3  v-12  a11,15 0,0,0 -13,-2  z" />
# 					<use href="#g-fragment-main" x="20" />
# 					<use href="#g-fragment-main" x="40" />
# 					<use href="#g-fragment-main" x="60" />
# 					<use href="#g-fragment-main" y="23" />
# 					<use href="#g-fragment-main" x="20" y="23" />
# 					<use href="#g-fragment-main" x="40" y="23" />
# 					<use href="#g-fragment-main" x="60" y="23" />
# 				</svg>]],
# 				[[<svg class="fill-gray-100 box-content" height="24" viewBox="0 0 13339 6000" xmlns="http://www.w3.org/2000/svg" style="fill-rule:evenodd;text-rendering:geometricPrecision;image-rendering:optimizeQuality;clip-rule:evenodd;shape-rendering:geometricPrecision" >
# 					<!-- Base was taken from https://freesvg.org/1412279524 -->
# 					<path d="M6187 5200c-1998 0-2753-2124-2831-2595-79-472-169-711-503-770s-245 275-297 460c-52 186-497 1632-1113 1707-616 74-1068-482-1239-1113s-275-1966-148-2189c126-223 401-208 868-111 467 96 1098 341 1447 393s2018 237 2078 237c59 0 15 96 386 111 1380 55 2706 139 3361 1521l2664-542c374-76 1825-482 2085-571s378 15 386 163c7 148 37 557-89 1469-126 913-341 134-245-111s226-1281 115-1304c-589-3-2791 656-4871 1207 0 0 22 586-260 1068s-816 1024-1793 969zm-4462-4223c215 37 2056 379 2512 364-441 80-905 282-935 619-48-105-611-558-864-159-30-221-100-312-712-824z" />
# 					<path d="M2000 1500l2664-542c374-76 1825-482 2085-571s378 15 386 163c7 148 37 557-89 1469-126 913-341 134-245-111s226-1281 115-1304c-589-3-2791 656-4871 1207 0 0 22 586-260 1068z" />
# 				</svg>]],
# 			} do
# 
# 				-- When hover is available, add a generous padding. Also specify
# 				-- a decent min-width/height so that it doesn't become extremely
# 				-- hard with no hover.
# 				local id = (i == 1) and 'id="dummy-fragment"' or ''
				<div $(id) class="
					absolute select-none
					opacity-0 transition-opacity duration-500
					data-[active]:hover:opacity-100 data-[active]:hover:select-auto
					max-w-[50vw] min-w-[35vw] min-h-[20vh]
					py-[6rem] px-[6ch] no-has-hover:p-0
					grid place-content-center
				">$(text)</div>
# 			end
		</div>
	</main>
</body>
</html>
