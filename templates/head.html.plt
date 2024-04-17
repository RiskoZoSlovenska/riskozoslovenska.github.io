# local root = env.root or "."
#
<title>$(env.name)</title>
<link rel="icon" type="image/svg" href="$(root)/assets/images/icon.svg">

# if env.desc then
	<meta name="description" content="$(env.desc)">
# end
<meta name="theme-color" content="#ff3232">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">

<link rel="stylesheet" href="$(root)/assets/styles/style.css">

<script src="$(root)/assets/scripts/search.js" defer></script>
<script src="$(root)/assets/scripts/sidebar-extra.js" async></script>
