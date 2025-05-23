# local root = env.root or "."
#
<nav id="sidebar" class="
	peer/sidebar fixed h-full w-min max-w-[85vw] z-40 bg-gray-800 border-r-accent-red
	border-r-(length:--sidebar-ribbon-size) translate-x-[calc(var(--sidebar-ribbon-size)-100%)] hofoac:translate-x-0
	transition-transform motion-reduce:transition-none ease-[ease] duration-500 hofoac:duration-300
" onmouseenter="ex_onSidebarMouseEnter(event)" onmouseleave="ex_onSidebarMouseLeave(event)"
>
	<!-- This wrapper div is required to make the sidebar scrollable -->
	<div class="h-full py-4 px-8 overflow-y-auto overscroll-contain">
		<!-- Specify SVG width attribute so it's not huge when CSS is disabled -->
		<svg width="18" class="fixed top-2 -right-2 fill-accent-red overflow-visible
			w-(--sidebar-icon-size) translate-x-[calc(var(--sidebar-icon-size)+var(--sidebar-ribbon-size))]
		" aria-hidden="true" viewBox="0 0 18 12" xmlns="http://www.w3.org/2000/svg">
			<path id="sidebar-grill-main" d="M0,0  h18  v2  h-18  v-2   z" />
			<use href="#sidebar-grill-main" y="5" />
			<use href="#sidebar-grill-main" y="10" />
		</svg>

		<h2 class="text-2xl font-bold">Navigation</h2>
		<search>
			<input
				class="peer/searchbar relative mt-4 w-full leading-none z-50"
				type="search"
				placeholder="Waiting for JS…"
			>
			<ul
				class="search-results-container h-0 z-40 scale-0 focus-within:scale-100 peer-focus-within/searchbar:scale-100"
				aria-live="polite"
			></ul>
		</search>
		<ul class="mt-5">
			<li class="mb-3 text-base"><a class="hofoac:underline" href="$(root)/">Home</a></li>
			<li class="mb-3 text-base"><a class="hofoac:underline" href="$(root)/about">About</a></li>
			<li class="mb-3 text-base"><a class="hofoac:underline" href="$(root)/fragments">Fragments</a></li>
			<li class="mb-3 text-base"><a class="hofoac:underline" href="$(root)/how-i-switched-to-linux">Switching to Linux</a></li>
			<li class="mb-3 text-base"><a class="hofoac:underline" href="$(root)/hangman">Hangman</a></li>
			<li class="mb-3 text-base"><a class="hofoac:underline" href="$(root)/svg-editor">SVG Editor</a></li>
			<li class="mb-3 text-base"><a class="hofoac:underline" href="$(root)/under-construction">Under Construction</a></li>
		</ul>
	</div>
</nav>

<div id="sidebar-darkener" aria-hidden="true" class="
	fixed h-full w-full opacity-0 bg-black z-30 pointer-events-none
	transition-opacity motion-reduce:transition-none ease-[ease] duration-500
	peer-hofoac/sidebar:opacity-50 peer-hofoac/sidebar:duration-300
"></div>
