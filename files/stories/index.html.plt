<!DOCTYPE html>
<html lang="en" dir="ltr"><head>
	$(head{ name = "Stories", desc = "Just some words.", root = ".." })
</head>


<body>
	<div id="sidebar-insert"></div>

	<main>
		<h1>Stories.</h1>

		<p>
			Just some words. I'm not very good and I've written a solid chunk
			of these to cope with personal problems, so don't expect anything
			great.
		</p>

		<div id="story-list">
			<!-- $generatedAt$ -->
			$for(data)$
			<div title="Get reading!" class="story-list-item entire-link-target highlight-on-hover">
				<h2 class="story-list-item-title"><a href="$data.link$">$data.title$</a></h2>
				<div class="story-list-item-desc">
					$if(data.description)$$data.description$$else$<em>No description.</em>$endif$
				</div>
			</div>
			$endfor$
		</div>
	</main>
</body>
</html>
