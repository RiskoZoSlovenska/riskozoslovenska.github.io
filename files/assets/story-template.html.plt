<!DOCTYPE html>
<!-- $generatedAt$ -->
<html lang="en" dir="ltr">
<head>
	$(head{ name = "$title$", desc = nil, root = ".." })
	$if(description)$<meta name="description" content="$description$">$endif$
</head>


<body $if(warnings)$data-warning-accept-pending$endif$>
	<div id="sidebar-insert"></div>

	<main>
		<h1 class="splashed-heading">$title$</h1>
		<div>
			<details title="$generatedAt$">
				<summary>$version$</summary>
				<div>
					Created at: $if(created-at)$<time>$created-at$</time>$else$[UNKNOWN]$endif$<br>
					Updated at: $if(updated-at)$<time>$updated-at$</time>$else$[UNKNOWN]$endif$<br>
					Contributors: $if(contributors)$$for(contributors)$$contributors$$sep$, $endfor$$else$None$endif$
				</div>
			</details>
			
			$if(warnings)$
			<details>
				<summary>Content Warnings</summary>
				<ul class="compact-list">
					$for(warnings)$
					<li>$warnings$</li>
					$endfor$
				</ul>
			</details>
			$endif$
		</div>

		$if(note-before)$
		<section class="authors-note less-visible">
			<h2 class="authors-note-title">Author's Note:</h2>
			$note-before$
		</section>
		$endif$

		<div id="story-body-container" class="long-p-container">
			$if(warnings.hasMajorWarning)$
			<div id="warning-overlay">
				<p id="warning-overlay-text">This one may be a bit heavy.</p>
				<button id="warning-overlay-button" onclick="javascript:document.body.removeAttribute('data-warning-accept-pending')">
					I've read the warnings. Lemme read!
				</button>
			</div>
			$endif$
			
			$body$
		</div>

		$if(note-after)$
		<section class="authors-note less-visible">
			<h2 class="authors-note-title">Author's Note:</h2>
			$note-after$
		</section>
		$endif$
	</main>
</body>
</html>
