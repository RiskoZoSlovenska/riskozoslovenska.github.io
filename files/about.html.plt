<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
	$(head{ name = "About Me", desc = "Hello there!" })
</head>

<body>
	$(sidebar{})

	<main class="article-main">
		<h1>About Me</h1>

		<figure class="mx-auto md:mx-10 md:mb-0 md:float-right">
			<img class="bg-gray-700 rounded-md" width="200" height="200" src="./assets/images/pfp.png" alt="My PFP">
			<figcaption>Art by Choir</figcaption>
		</figure>
		<p>
			Hi there; you seem to have found me.
		</p>
		<p>
			As you might already know, I’m <b>RiskoZS</b>, but you can call me <b>Risko</b>.
			I write stuff sometimes. My favourite language is <a href="https://www.lua.org/">Lua</a>, but I also have some
			moderate experience with a bunch of other languages, including <a href="https://www.python.org/">Python</a>,
			<a href="https://en.wikipedia.org/wiki/English_language">English</a>, <a href="https://www.java.com/">Java</a> and
			(unfortunately) <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript">JavaScript</a>.
			I’m afraid there’s not much else to me than that at the moment, but feel free to check back in a couple of years.
		</p>

		<h2>Get In Touch</h2>
		<ul class="flex justify-center flex-wrap gap-14 mb-14 px-5">
# 			for _, contact in ipairs({
# 				{"https://github.com/RiskoZoSlovenska", "github.svg", "The GitHub logo", "RiskoZoSlovenska"},
# 				{"https://discord.com/users/469641305669107713", "discord.svg", "The Discord logo", "riskozoslovenska"},
# 				{"mailto:riskozoslovenska@gmail.com", "mail.svg", "The Gmail logo", "riskozoslovenska<wbr>@gmail.com"},
# 				{"https://www.youtube.com/channel/UCWCC6wm037u-lSeF2yfFKbw", "youtube.png", "The YouTube logo", "RiskoZoSlovenska"},
# 				{"https://steamcommunity.com/profiles/76561199122286912", "steam.svg", "The Steam logo", "RiskoZoSlovenska"},
# 				{"https://pcpartpicker.com/b/mGTCmG", "computer.svg", "An image of a computer", "<span class='whitespace-nowrap'>RZS-TANAR</span>"},
# 			}) do
			<li class="relative block group">
				<a href="$(contact[1])">
					<img class="w-14 h-14" width="56" src="./assets/images/$(contact[2])" alt="$(contact[3])">
				</a>
				<!-- https://stackoverflow.com/a/1777282 -->
				<div class="
					absolute left-[50%] -translate-x-[50%] max-w-min pt-2 text-center text-3xs text-gray-300
					transition-all duration-100 ease-out
					has-hover:w-max has-hover:text-sm has-hover:p-8 has-hover:pt-1
					has-hover:group-[&:not(:hover)]:translate-x-[-50%]
					has-hover:group-[&:not(:hover)]:translate-y-[-25%]
					has-hover:group-[&:not(:hover)]:text-3xs
					has-hover:group-[&:not(:hover)]:opacity-0
					has-hover:group-[&:not(:hover)]:pointer-events-none
				">$(contact[4])</div>
			</li>
# 			end
		</ul>

		<h2>What about this website? What’s it for?</h2>
		<p>
			Honestly, hard to say. It’s just a place on the web that I can call my own and where I can host things like stories,
			projects, docs (TBA), games and other stuff. I’m trying to balance being serious with being not-so-serious, so please excuse
			any tonal discrepancies you may come across.
		</p>
		<p>
			On a more technical side, I’m striving for something simple yet expressive with this site, with emphasis on
			comfortable reading and mobile support. If something doesn’t work for you, stop using an old/obscure browser (and use
			<a href="https://www.mozilla.org/en-CA/firefox/new/">Firefox</a> instead!). If it still doesn’t work, or if you have
			ideas for improvement, shoot me an <a href="mailto:riskozoslovenska@gmail.com">email</a>/<a href="https://discord.com/users/469641305669107713">DM</a>
			or <a href="https://github.com/RiskoZoSlovenska/riskozoslovenska.github.io/issues/new">open an issue</a>.
		</p>

		<h2>Credits</h2>
		<p>
			Either way, this site wouldn’t be possible without a bunch of wonderful people and resources. I’d like to thank:
		</p>
		<ul class="list-disc ml-10">
			<li class="mb-5">
				<a href="https://amyfae.cafe/" class="text-[hsl(260,100%,75%)]">Skyla</a> for:
				<ul class="list-[circle] ml-10">
					<li>inspiring me to make my own site,</li>
					<li>
						letting me use <a href="https://web.archive.org/web/20211224002714/https://blobs.ca/">her (old) site</a>
						as a reference,
					</li>
					<li>putting up with my smooth-brain questions,</li>
					<li>and helping me out with the site icon.</li>
				</ul>
			</li>
			<li class="mb-5">
				<a href="https://developer.mozilla.org/">MDN Web Docs</a>,
				<a href="https://stackoverflow.com/">Stack Overflow</a> and
				<a href="https://www.w3schools.com/">W3Schools</a> for answering
				all my inquiries about all this HTML, CSS and <span title="JS sucks ok">(ick) JS</span> magic.
			</li>
			<li class="mb-5" title="Hi Eti">
				<a href="https://etithespir.it/">EtiTheSpirit</a> for the idea of having
				<a href="https://etithespir.it/site-credits.xhtml">site credits</a>.
			</li>
			<li class="mb-5" title="Sorry for stealing this idea :P">
				<a href="https://pages.github.com/">GitHub Pages</a> for hosting this site.
			</li>
		</ul>
		<p>
			Feel free to check out the <a href="https://github.com/RiskoZoSlovenska/riskozoslovenska.github.io">source code</a>!
		</p>
	</main>
</body>
</html>
