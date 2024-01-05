<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
	$(head{ name = "Home", desc = "Welcome to my little corner of the internet." })
	<script src="./assets/scripts/dots.js" defer></script>
</head>

<body>
	<div id="sidebar-insert"></div>

	<main class="w-full relative grid place-content-center text-center p-8">
		<canvas id="dots-canvas" class="absolute w-full h-full -z-10"></canvas>
		<h1 class="text-sm md:text-base mb-[calc(35vh-3rem)]">
			Hi there. I’m<br>
			<span class="text-[length:clamp(1rem,_8.5vw,_5rem)] leading-none"><b>RiskoZoSlovenska</b></span><br>
			and you’ve stumbled into my little corner of the internet.
		</h1>
		<ul class="xs:inline-list">
			<li>
				<a href="https://github.com/RiskoZoSlovenska">Programming</a>
			</li>
			<li class="before:block before:content-['―']" >
				<a href="./stories/">Creative Writing</a>
			</li>
		</ul>
	</main>
</body>
</html>
