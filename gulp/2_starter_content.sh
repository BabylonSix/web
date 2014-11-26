function gp.starterFiles {
# create empty starter files
f src/_jade/index.jade
f src/_js/script.js
f src/_stylus/style.styl
}

function gp.starterContent {
# index.jade Content
cat <<EOF >> src/_jade/index.jade
doctype html
html(lang="en-US")
	head
		title
		meta(charset="utf-8")
		meta(name="viewport" content="user-scalable=0 initial-scale=1.0")
		link(rel="stylesheet" href="_css/style.css")

	body
		.site-header-wrapper
			header
				.logo
				nav
				.call-us

		.site-content-wrapper
			.content

		.site-footer-wrapper
			footer

		// Site Scripts
		script(src="_js/script.js")
EOF
}

function gp.starterStyle {
# style.styl Content
cat <<EOF >> src/_stylus/style.styl
@import 'axis'
@import 'rupture'
@import 'typographic'

// Grid systems (use one), see https://github.com/corysimmons for descriptions
// @import 'jeet' // stylus plugin for grids (> IE 7) 
@import 'elf' // stylus plugin for grids (> IE 9)
// @import 'dragon' // elf => but with one mixin call

*
	padding: 0
	margin: 0
	border: 0
	box-sizing: border-box
	max-width: 100%

edit()

EOF
}

function gp.googleAnalytics {
cat <<EOF >> src/_js/analytics.js
// Google Analytics: change UA-XXXXX-X to be your site's ID.
var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
	(function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
g.src=('https:'==location.protocol?'//ssl':'//www')+'.google-analytics.com/ga.js';
s.parentNode.insertBefore(g,s)}(document,'script'));
EOF
}