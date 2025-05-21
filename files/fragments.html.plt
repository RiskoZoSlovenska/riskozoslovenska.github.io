<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
	$(head{ name = "Fragments", desc = "Twinkling like the forgotten stars of the Abyss." })
	<script src="./assets/scripts/cheating.js" defer></script>
	<script src="./assets/scripts/fragments.js" defer></script>
</head>

<body>
	$(cheating{})
	$(sidebar{})

	<main class="padded-main">
		<h1 class="mb-0" title="Not to be confused with Echoes — those don’t exist in this reality.">Fragments</h1>
		<div class="h1-splash" title="Better get searching.">The best things have to be found.</div>

		<div id="fragments-canvas" class="loading relative h-[85vh] overflow-hidden" data-unsearchable>
			<!-- No-JS label -->
			<div class="[:not(.loading)>&]:hidden w-full h-full grid place-content-center">Waiting for JS...</div>

# 			-- When hover is available, add a generous padding. Also specify
# 			-- a decent min-width/height so that it doesn't become extremely
# 			-- hard with no hover.
			<div id="fragment" class="
				absolute select-none
				opacity-0 transition-opacity duration-500
				data-active:hover:opacity-100 data-active:hover:select-auto
				max-w-[50vw] min-w-[35vw] min-h-[20vh]
				py-[6rem] px-[6ch] not-has-hover:p-0
				grid place-content-center
			"></div>
		</div>
	</main>
</body>
</html>
