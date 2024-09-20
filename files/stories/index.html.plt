<!DOCTYPE html>
<html lang="en" dir="ltr"><head>
	$(head{ name = "Stories", desc = "Just some words.", root = ".." })
</head>

<body>
	$(sidebar{ root = ".." })

	<main class="article-main">
		<h1>Stories.</h1>

		<p class="leading-none">
			Just some words. I’m not very good and I’ve written a solid chunk
			of these to cope with personal problems, so don’t expect anything
			great.
		</p>

		<ul class="mt-8 md:mt-12 grid grid-cols-[repeat(auto-fit,minmax(max(20vw,12.5em),1fr))] gap-3">
			<!-- $generatedAt$ -->
			$for(data)$
			<li title="Get reading!" class="relative bg-gray-700 p-2.5 hofoac-highlight">
				<h2 class="text-sm md:text-base mb-1 leading-none">
					<a class="before:absolute before:w-full before:h-full before:top-0 before:left-0"
					href="$data.link$">$data.title$</a>
				</h2>
				<div class="text-2xs text-gray-300">
					$if(data.description)$$data.description$$else$<em>No description.</em>$endif$
				</div>
			</li>
			$endfor$
		</ul>
	</main>
</body>
</html>
