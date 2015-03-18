function sp

 {
	# Main Project Directory
	d _stylus 
	d _img 
	d _css 
	d _js


	# Create Project Files
	f index.jade
	f _stylus/style.styl
	f _js/script.js


# starter jade index file
cat <<EOF >> index.jade
doctype html

html(lang='en')
	head
		meta(charset='utf-8')
		link(rel='stylesheet' href='_css/style.css')

	body
		h1 Success!

		script(src='_js/script.js')
EOF

	
	# run simple project
	rsp
}

function rsp {
	# Open project in text editor
	ot ./

	#  reload browser on html and css changes
	browser-sync start --server --files "_css/**/*.css" --files "./**/*.html" --files "./_js/*.js" &

	# watch jade files in current directory
	jade -wP ./**/*.jade &

	# watch stylus files, output in the _css folder
	stylus -w ./_stylus/**/*.styl --out _css/
}