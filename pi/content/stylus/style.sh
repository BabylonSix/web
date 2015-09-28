cat <<EOF >> ./src/stylus/style.styl
@charset "utf-8";
@import 'typographic'

blue = hsl(194, 28%, 70%)
black = hsl(200, 7%, 9%)

html
	box-sizing: border-box
	background: black

*, *:before, *:after
	box-sizing: inherit

h1, h2, h3, h4, h5, h6, p
	color: blue

EOF
