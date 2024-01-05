/** @type {import('tailwindcss').Config} */
const defaultTheme = require('tailwindcss/defaultTheme')
let plugin = require("tailwindcss/plugin")

module.exports = {
	content: [
		"./build/**/*.{html,html.plt,js}",
	],
	theme: {
		screens: { // https://tailwindcss.com/docs/screens#adding-smaller-breakpoints
			'xs': '475px',
			...defaultTheme.screens,
		},
		colors: {
			"black": "#000000",
			"gray": {
				900: "#171717",
				800: "#1e1e1e",
				700: "#252525",
				600: "#2d2d2d",
				500: "#3e3e3e",
				400: "#696969",
				300: "#8e8e8e",
				200: "#a5a5a5",
				100: "#d4d4d4",
			},
			"accent-red": "#ff3232",
			"accent-blue": "#00aaff",

			"correct": "#48ca48",
			"incorrect": "#ca4848",
		},
		fontSize: {
			"4xs": "0.6rem",
			"3xs": "0.7rem",
			"2xs": "0.8rem",
			"xs": "0.9rem",
			"sm": "1.05rem",
			"base": "1.25rem",
			"lg": "1.5rem",
			"xl": "2rem",
			"2xl": "2.5rem",
		},
		fontFamily: {
			"sans": ["Lato", "Calibri", "Roboto", "sans-serif"],
			"mono": ["Inconsolata", "Consolas", "ui-monospace"]
		},
		extend: {
			screens: {
				"has-hover": { "raw": "(hover: hover)" },
				"no-has-hover": { "raw": "(hover: none)" },
			},
			transitionDuration: {
				"400": "400ms",
			},
		},
	},
	plugins: [
		plugin(function ({ addVariant, matchVariant }) {
			addVariant("hofoac", "&:is(:hover, :focus-within, .custom-focus, :active)")
			matchVariant("peer-hofoac", // https://github.com/tailwindlabs/tailwindcss/issues/11384#issuecomment-1623765604
				(_, { modifier }) => {
					return modifier
						? `:merge(.peer\\/${modifier}):is(:hover, :focus-within, .custom-focus, :active) ~ &`
						: `:merge(.peer):is(:hover, :focus-within, .custom-focus, :active) ~ &`
				},
				{ values: { DEFAULT: null } }
			)
			addVariant("hofonoac", "&:is(:hover, :focus-within, .custom-focus):not(:active)")
		}),
	],
}
