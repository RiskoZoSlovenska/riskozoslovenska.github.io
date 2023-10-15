<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
	$(head{ name = "About Me", desc = "Hello there!" })
</head>

<body>
	<div id="sidebar-insert"></div>

	<main class="article-main">
		<h1>About Me</h1>

		<figure class="mx-auto md:mx-10 md:mb-0 md:float-right">
			<img class="bg-gray-700" src="./assets/images/pfp.png" width="200" height="200" alt="My PFP">
			<figcaption>Art by Choir</figcaption>
		</figure>
		<p>
			Hi there; you seem to have found me.
		</p>
		<p>
			As you might already know, I'm <b>RiskoZoSlovenska</b>, but you can call me <b>Risko</b>.
			I'm a writer: I write both code and words, depending on what I'm feeling like at the moment. My favourite
			language is <a href="https://www.lua.org/">Lua</a>, but <a href="https://www.python.org/">Python</a> and
			<a href="https://en.wikipedia.org/wiki/English_language">English</a> are also fine.
			I'm afraid there's not much else to me than that at the moment, but feel free to check back in a couple of years.
		</p>
		<p>…</p>
		<p>
			Alright, alright, if you insist, I may as well indulge you with a bit of detail. What do you wanna know? I
			come from <a href="https://www.google.com/maps/place/Slovakia/">Slovakia</a> and I used to live in
			<a href="https://www.google.com/maps/place/Canada/">Canada</a>, but nowadays I take up
			residence in my own head. I'm a music addict (go check out <a href="https://www.youtube.com/channel/UCioNNjH3S7X8byCjPDEqZkA">Aviators</a>),
			a fan of the Ori and R&C franchises, a FOSS supporter (go use Linux NOW!) and an amateur hobbyist CADer. Oh,
			and also, if you're interested, you can go gawk at <a href="https://pcpartpicker.com/b/mGTCmG">my PC build</a>.
		</p>

		<h2>Get In Touch</h2>
		<ul class="flex justify-center flex-wrap gap-14 mb-14 px-5">
# 			for _, contact in ipairs({
# 				{"https://github.com/RiskoZoSlovenska", "github.svg", "The GitHub logo", "RiskoZoSlovenska"},
# 				{"https://discord.com/users/469641305669107713", "discord.svg", "The Discord logo", "riskozoslovenska"},
# 				{"mailto:riskozoslovenska@gmail.com", "mail.svg", "The Gmail logo", "riskozoslovenska<wbr>@gmail.com"},
# 				{"https://www.youtube.com/channel/UCWCC6wm037u-lSeF2yfFKbw", "youtube.png", "The YouTube logo", "RiskoZoSlovenska"},
# 				{"https://steamcommunity.com/profiles/76561199122286912", "steam.svg", "The Steam logo", "RiskoZoSlovenska"},
# 				{"https://open.spotify.com/user/4u4zs2216n18n40u46mail4cb?si=CitKmACMTwOQKFYN8pFIQg", "spotify.png", "The Spotify logo", "RiskoZoSlovenska"},
# 			}) do
			<li class="relative block group">
				<a href="$(contact[1])">
					<img class="w-14 h-14" src="./assets/images/$(contact[2])" alt="$(contact[3])">
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

		<h2>What about this website? What's it for?</h2>
		<p>
			Ah, glad you asked! (Or scrolled — same thing.)
		</p>
		<p>
			Honestly, hard to say. It's just a place on the web that I can call my own and where I can host
			things like stories, projects, docs (TBA), games and other stuff. I'm trying to balance being serious
			with being chill, so please excuse any tonal discrepancies you may come across.
		</p>
		<p>
			On a more technical side, I'm striving for something simple yet expressive with this site, with emphasis on
			comfortable reading and mobile support. If something doesn't work for you, stop using an old/obscure
			browser (and use Firefox instead!). If it still doesn't work, or if you have ideas for improvement, shoot me an email/DM or open an
			issue. Bonus points if you make it sound like an angry complaint to tech support :P
		</p>

		<h2>Credits</h2>
		<p>
			Either way, this site wouldn't be possible without a bunch of wonderful people and resources. I'd like to
			thank:
		</p>
		<ul class="list-disc ml-10">
			<li class="mb-5">
				<a href="https://blobs.ca/" class="text-[hsl(260,100%,75%)]">Blob</a> for:
				<ul class="list-[circle] ml-10">
					<li>inspiring me to make this site,</li>
					<li>letting me use her site as a <a href="https://github.com/Cobalium/cobalium.github.io/">reference</a>,</li>
					<li>putting up with my smooth-brain questions,</li>
					<li>and helping me out a bit with the site icon.</li>
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
			BTW, feel free to check out the 
			<a href="https://github.com/RiskoZoSlovenska/riskozoslovenska.github.io">source code</a>!
		</p>
	</main>
</body>
</html>
