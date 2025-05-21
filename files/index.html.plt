<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
	$(head{ name = "Home", desc = "Welcome to my little corner of the internet." })
	<script src="./assets/scripts/dots.js" defer></script>
</head>

<body>
	$(sidebar{})

	<main class="w-full relative grid place-content-center text-center p-8">
		<canvas id="dots-canvas" class="absolute w-full h-full -z-10" aria-hidden="true"></canvas>
		<h1 class="text-sm md:text-base mb-[calc(35vh-3rem)]">
			Hi there. I’m<br>
			<span class="text-[clamp(1rem,8.5vw,5rem)] leading-none"><b>RiskoZS</b></span><br>
			and you’ve stumbled into my little corner of the internet.
		</h1>
		<ul class="xs:inline-list">
			<li>
				<a href="https://github.com/RiskoZoSlovenska">Programming</a>
			</li>
		</ul>
	</main>
</body>
</html>
