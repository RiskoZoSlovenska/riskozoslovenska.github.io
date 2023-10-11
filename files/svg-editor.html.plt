<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
	$(head{ name = "SVG Editor", desc = "Experimental." })
	<script src="https://cdn.jsdelivr.net/npm/ace-builds@1.15.2/src-min-noconflict/ace.js"></script>
	<script src="./assets/scripts/svg-editor.js" defer></script>
</head>

<body>
	<div id="sidebar-insert"></div>

	<main class="full-width-main">
		<h1 class="splashed-heading">SVG Editor</h1>
		<div>Nothing too complicated</div>

		<div id="editor-flex">
			<div id="editor-container">
				<div id="ace-editor" class="custom-scrollable"></div>
			</div>

			<div id="display-container">
				<div id="info-display">
					<span id="coords-label" class="monospace-override">--.-, --.-</span>
					<span id="selected-label" class="less-visible"></span>
				</div>
				<div id="svg-canvas" class="horizontal-centered"></div>
			</div>
		</div>
		
		<div class="less-visible">
			Click to select/deselect, space to stash/restore selection. Arrow
			keys move selection by <input id="step-box" type="text" value="1">
			unit(s). Ctrl/Shift increases/decreases movement amount while held.
		</div>
	</main>
</body>
</html>
