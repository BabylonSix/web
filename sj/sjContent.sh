sjContent() {
# sj content wrapper function


sjContent.gitignore() {
# create .gitignore file
# we will ignore all generated files, eg: html, css, etc…
cat <<EOF >> .gitignore
.DS_Store
*.html
*.css
EOF
}



sjContent.index() {
# Populate index.pug with starter content
cat <<EOF >> index.pug
doctype html

html(lang='en')
  head
    link(rel='stylesheet' href='css/style.css')

  body
    .web-page
      include ./webpage.pug

    script(src='js/library.js')
    script(src='js/grid.js')
EOF

cat <<EOF >> webpage.pug
h1 Starter Webpage
EOF
}



sjContent.style() {
# Populate style.styl with starter content
cat <<EOF >> css/style.styl
*
  box-sizing: border-box


EOF
}



sjContent.library() {
# Populate library.js with starter content
cat <<EOF >> js/library.js
function log(...x) {
	console.log(...x)
}

function table(...x) {
	console.table(...x)
}

function dir(...x) {
	console.dir(...x)
}

function w(...x) {
	document.writeln(...x)
}

// group multiple code examples
function example ( exName, ...exCode ) {

  // example name + newline
  let example = [exName + '\n']
    // combine with all formated example code
    .concat( exCode.map( (x) => \`    \${JSON.stringify(x)}\n \` ))
    // combine all arrays separated by a newline
    .join('\n')
    // add a few newlines after ex function to
    // seperate visually from next log statement
    .concat(['\n\n'])

  log(example)
}
EOF
}


}
