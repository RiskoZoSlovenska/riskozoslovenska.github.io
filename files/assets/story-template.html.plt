<!DOCTYPE html>
<!-- $generatedAt$ -->
<html lang="en" dir="ltr">
<head>
	$(head{ name = "$title$", desc = nil, root = ".." })
	$if(description)$<meta name="description" content="$description$">$endif$
</head>

<body data-unsearchable>
	$(sidebar{ root = ".." })

	<main class="article-main">
		<h1 class="mb-0">$title$</h1>
		<div class="h1-splash">
			<details title="$generatedAt$">
				<summary>$version$</summary>
				<div class="ml-5 mb-3">
					Created at: $if(created-at)$<time>$created-at$</time>$else$[UNKNOWN]$endif$<br>
					Updated at: $if(updated-at)$<time>$updated-at$</time>$else$[UNKNOWN]$endif$<br>
					Contributors: $if(contributors)$$for(contributors)$$contributors$$sep$, $endfor$$else$None$endif$
				</div>
			</details>

			$if(warnings)$
			<details>
				<summary>Content Warnings</summary>
				<ul class="list-disc list-inside ml-5">
					$for(warnings)$
					<li>$warnings$</li>
					$endfor$
				</ul>
			</details>
			$endif$
		</div>

# 		function authorsNote(noteName)
		$if($(noteName))$
		<section class="text-gray-400 mb-10 text-sm">
			<h2 class="italic m-0 text-sm">Author’s Note:</h2>
			$$(noteName)$
		</section>
		$endif$
# 		end
#
# 		authorsNote("note-before")

		<div class="container-for-external relative">
			$if(warnings.hasMajorWarning)$
			<div class="absolute h-full w-full text-center py-16 px-14 bg-gray-700 rounded transition-opacity duration-300
			data-accepted:opacity-0 data-accepted:pointer-events-none">
				<p class="text-gray-300 mb-14">This one may be a bit heavy.</p>
				<button class="bg-[#363636] p-1.5 text-accent-red font-bold hofoac-highlight" onclick="javascript:event.target.parentElement.dataset.accepted = true">
					I’ve seen the warnings. Lemme read!
				</button>
			</div>
			$endif$

			$body$
		</div>

# 		authorsNote("note-after")
	</main>
</body>
</html>
