# Starter Content
cat <<EOF >> ./src/jade/index.jade
doctype html

html(lang='en')
	head
		meta(charset='utf-8')
		meta(http-equiv='X-UA-Compatible' content='IE=edge')
		meta(name='viewport' content='width=device-width, initial-scale=1')
		meta(name='description' content='This is the information that appears in the google description for your page')
		title
		link(rel='stylesheet', href='css/style.css')
		script(src='js/app.js')

	body
		h1 Success!
EOF
