<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
	$(head{ name = "SVG Editor", desc = "Experimental." })
	<link rel="stylesheet" href="./assets/styles/ace-theme.css">

	<script src="https://cdn.jsdelivr.net/npm/ace-builds@1.15.2/src-min-noconflict/ace.js"></script>
	<script src="./assets/scripts/svg-editor.js" defer></script>
</head>

<body>
	<div id="sidebar-insert"></div>

	<main class="padded-main w-full">
		<h1 class="mb-0">SVG Editor</h1>
		<div class="h1-splash">Nothing too complicated</div>

		<div class="flex flex-col md:flex-row items-stretch gap-5 mb-5">
			<div class="relative grow-[1.5] basis-0">
				<div id="ace-editor" data-custom-scroll class="h-full min-h-[12.5rem] rounded"></div>
			</div>

			<div class="relative grow basis-0">
				<div>
					<span id="coords-label" class="font-mono">--.-, --.-</span>
					<span id="selected-label" class="text-gray-400 ml-4"></span>
				</div>
				<div id="svg-canvas" class="
					w-full md:max-h-[60vh] aspect-square
					[&>svg]:max-w-full [&>svg]:max-h-full [&>svg]:bg-gray-900
					[&_.selected]:brightness-150 [&_.selected]:[outline:1px_solid_theme(colors.accent-blue)]
				"></div>
			</div>
			<template id="svg-error-template">
				<div class="h-full flex items-center text-center text-accent-red text-2xl font-bold"></div>
			</template>
			<template id="mouse-cross-template">
				<div class="fixed pointer-events-none bg-gray-100"></div>
			</template>
		</div>

		<div class="brightness-50">
			Click to select/deselect, space to stash/restore selection. Arrow
			keys move selection by <input id="step-box" class="w-[2.6em] text-center" type="text" value="1">
			unit(s). Ctrl/Shift increases/decreases movement amount while held.
		</div>
	</main>
</body>
</html>
