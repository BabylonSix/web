function web.ck.makeIndex {
cat <<EOF >> index.jade
doctype html
html(lang="en")
	head
		meta(charset="utf-8")
		link(rel="stylesheet" href="_css/style.css")
		title

	body
		.wrapper
			header

			.body

			footer

		// Site Scripts
		script(src="_js/min/script-ck.js")
		
EOF
}


function web.ck.makeStyle {
cat <<EOF >> _stylus/style.styl
@import base
@import fluidity

EOF
}


function web.ck.makeScript {
cat <<EOF >> _js/script.js
// @codekit-prepend "_/js/fixie.js"
// @codekit-prepend "_/js/analytics.js"
EOF
}


function web.getAssets {
	# Get Fixie
	cd ./_js; wget https://raw.github.com/ryhan/fixie/master/fixie.js
	cd ..
}


function web.googleAnalytics {
cat <<EOF >> _js/analytics.js
// Google Analytics: change UA-XXXXX-X to be your site's ID.
var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
			(function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
g.src=('https:'==location.protocol?'//ssl':'//www')+'.google-analytics.com/ga.js';
s.parentNode.insertBefore(g,s)}(document,'script'));
EOF
}