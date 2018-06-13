sjContent() {
# sj content wrapper function



sjContent.sj() {
# store project name
cat <<EOF >> .sj
${PROJECT}
EOF
}



sjContent.gitignore() {
# create .gitignore file
# we will ignore all generated files, eg: html, css, etc…
cat <<EOF >> .gitignore
# mac spotlight files
.DS_Store


# build folder
build/


# all html and css files
*.html
*.css
*.css.map


# stylus color functions
class-generator.styl
material-color.styl
hsb.styl
EOF
}



sjContent.index() {
# Populate index.pug with starter content
cat <<EOF >> src/pug/index.pug
doctype html

html(lang='en')
  head
    link(rel='stylesheet' href='css/library.css')
    link(rel='stylesheet' href='css/${PROJECT}.css')

  body
    .web-page
      include ./webpage.pug

    script(src='js/library.js')
    script(src='js/${PROJECT}.js')
EOF

cat <<EOF >> src/pug/webpage.pug
.box
  h1 Starter Webpage
EOF
}



sjContent.jsLibrary() {
# Populate library.js with starter content
cat <<EOF >> src/js/library.js
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



sjContent.cssLibrary() {
# Populate style.styl with starter content
cat <<EOF >> src/styles/library.styl
@import 'colors/material-color'
@import 'colors/hsb'

*, *::before, *::after
  box-sizing border-box
  margin 0

.web-page
  display grid
  height 100vh
  place-content center

.box
  min-width 800px
  min-height 600px
  padding 25px
  background-color silver
  border-radius 6px

EOF

cat <<EOF >> src/styles/$PROJECT.styl
@import 'colors/material-color'
@import 'colors/hsb'
EOF

cat <<EOF >> src/styles/colors/hsb.styl
hsb(\$h-hsb, \$s-hsb, \$b-hsb, \$a = 1)
  if \$b-hsb == 0
    return hsla(0, 0, 0, \$a)
  else
    \$l-hsl = (\$b-hsb / 2) * (2 - (\$s-hsb / 100))
    \$s-hsl = (\$b-hsb * \$s-hsb) / (\$l-hsl < 50 ? \$l-hsl * 2 : 200 - \$l-hsl * 2)
    return hsla(\$h-hsb, \$s-hsl, \$l-hsl, \$a)
EOF

cat <<EOF >> src/styles/colors/mixins/class-generator.styl
material-color-class(name, property = color) {
  // If you want to do just one particular color
  if name != 'all' {
    list = lookup('clr-' + name + '-list');

    for clr, var in list {
      if clr == 'base' {
        .{name} {
          {property}: var;
        }
      }
      else {
        .{name}-{clr} {
          {property}: var;
        }
      }
    }
  }

  //If you wanted to do all the colors
  else {
    for clrl, varl in clr-list-all {
      for clr, var in varl {
        if clr == 'base' {
          .{clrl} {
            {property}: var;
          }
        }
        else {
          .{clrl}-{clr} {
            {property}: var;
          }
        }
      }
    }
  }
}

EOF

cat <<EOF >> src/styles/colors/material-color.styl
// ==========================================================================
//
// Name:        UI Color Palette
// Description: The color palette of material design.
// Version:     2.3.1
//
// Author:      Denis Malinochkin
// Git:         https://github.com/mrmlnc/material-color
//
// twitter:     @mrmlnc
//
// ==========================================================================


//
// List of base colors
//

// clr-red
// clr-pink
// clr-purple
// clr-deep-purple
// clr-indigo
// clr-blue
// clr-light-blue
// clr-cyan
// clr-teal
// clr-green
// clr-light-green
// clr-lime
// clr-yellow
// clr-amber
// clr-orange
// clr-deep-orange
// clr-brown
// clr-grey
// clr-blue-grey
// clr-black
// clr-white


//
// Red
//

clr-red-list = {
  'base': #f44336,
  '50':   #ffebee,
  '100':  #ffcdd2,
  '200':  #ef9a9a,
  '300':  #e57373,
  '400':  #ef5350,
  '500':  #f44336,
  '600':  #e53935,
  '700':  #d32f2f,
  '800':  #c62828,
  '900':  #b71c1c,
  'a100': #ff8a80,
  'a200': #ff5252,
  'a400': #ff1744,
  'a700': #d50000
}

clr-red =      clr-red-list[base]

clr-red-50  =  clr-red-list['50']
clr-red-100 =  clr-red-list['100']
clr-red-200 =  clr-red-list['200']
clr-red-300 =  clr-red-list['300']
clr-red-400 =  clr-red-list['400']
clr-red-500 =  clr-red-list['500']
clr-red-600 =  clr-red-list['600']
clr-red-700 =  clr-red-list['700']
clr-red-800 =  clr-red-list['800']
clr-red-900 =  clr-red-list['900']
clr-red-a100 = clr-red-list['a100']
clr-red-a200 = clr-red-list['a200']
clr-red-a400 = clr-red-list['a400']
clr-red-a700 = clr-red-list['a700']


//
// Pink
//

clr-pink-list = {
  'base': #e91e63,
  '50':   #fce4ec,
  '100':  #f8bbd0,
  '200':  #f48fb1,
  '300':  #f06292,
  '400':  #ec407a,
  '500':  #e91e63,
  '600':  #d81b60,
  '700':  #c2185b,
  '800':  #ad1457,
  '900':  #880e4f,
  'a100': #ff80ab,
  'a200': #ff4081,
  'a400': #f50057,
  'a700': #c51162
}

clr-pink =      clr-pink-list[base]

clr-pink-50 =   clr-pink-list['50']
clr-pink-100 =  clr-pink-list['100']
clr-pink-200 =  clr-pink-list['200']
clr-pink-300 =  clr-pink-list['300']
clr-pink-400 =  clr-pink-list['400']
clr-pink-500 =  clr-pink-list['500']
clr-pink-600 =  clr-pink-list['600']
clr-pink-700 =  clr-pink-list['700']
clr-pink-800 =  clr-pink-list['800']
clr-pink-900 =  clr-pink-list['900']
clr-pink-a100 = clr-pink-list['a100']
clr-pink-a200 = clr-pink-list['a200']
clr-pink-a400 = clr-pink-list['a400']
clr-pink-a700 = clr-pink-list['a700']


//
// Purple
//

clr-purple-list = {
  'base': #9c27b0,
  '50':   #f3e5f5,
  '100':  #e1bee7,
  '200':  #ce93d8,
  '300':  #ba68c8,
  '400':  #ab47bc,
  '500':  #9c27b0,
  '600':  #8e24aa,
  '700':  #7b1fa2,
  '800':  #6a1b9a,
  '900':  #4a148c,
  'a100': #ea80fc,
  'a200': #e040fb,
  'a400': #d500f9,
  'a700': #aa00ff
}

clr-purple =      clr-purple-list[base]

clr-purple-50 =   clr-purple-list['50']
clr-purple-100 =  clr-purple-list['100']
clr-purple-200 =  clr-purple-list['200']
clr-purple-300 =  clr-purple-list['300']
clr-purple-400 =  clr-purple-list['400']
clr-purple-500 =  clr-purple-list['500']
clr-purple-600 =  clr-purple-list['600']
clr-purple-700 =  clr-purple-list['700']
clr-purple-800 =  clr-purple-list['800']
clr-purple-900 =  clr-purple-list['900']
clr-purple-a100 = clr-purple-list['a100']
clr-purple-a200 = clr-purple-list['a200']
clr-purple-a400 = clr-purple-list['a400']
clr-purple-a700 = clr-purple-list['a700']


//
// Deep purple
//

clr-deep-purple-list = {
  'base': #673ab7,
  '50':   #ede7f6,
  '100':  #d1c4e9,
  '200':  #b39ddb,
  '300':  #9575cd,
  '400':  #7e57c2,
  '500':  #673ab7,
  '600':  #5e35b1,
  '700':  #512da8,
  '800':  #4527a0,
  '900':  #311b92,
  'a100': #b388ff,
  'a200': #7c4dff,
  'a400': #651fff,
  'a700': #6200ea
}

clr-deep-purple =      clr-deep-purple-list[base]

clr-deep-purple-50 =   clr-deep-purple-list['50']
clr-deep-purple-100 =  clr-deep-purple-list['100']
clr-deep-purple-200 =  clr-deep-purple-list['200']
clr-deep-purple-300 =  clr-deep-purple-list['300']
clr-deep-purple-400 =  clr-deep-purple-list['400']
clr-deep-purple-500 =  clr-deep-purple-list['500']
clr-deep-purple-600 =  clr-deep-purple-list['600']
clr-deep-purple-700 =  clr-deep-purple-list['700']
clr-deep-purple-800 =  clr-deep-purple-list['800']
clr-deep-purple-900 =  clr-deep-purple-list['900']
clr-deep-purple-a100 = clr-deep-purple-list['a100']
clr-deep-purple-a200 = clr-deep-purple-list['a200']
clr-deep-purple-a400 = clr-deep-purple-list['a400']
clr-deep-purple-a700 = clr-deep-purple-list['a700']


//
// Indigo
//

clr-indigo-list = {
  'base': #3f51b5,
  '50':   #e8eaf6,
  '100':  #c5cae9,
  '200':  #9fa8da,
  '300':  #7986cb,
  '400':  #5c6bc0,
  '500':  #3f51b5,
  '600':  #3949ab,
  '700':  #303f9f,
  '800':  #283593,
  '900':  #1a237e,
  'a100': #8c9eff,
  'a200': #536dfe,
  'a400': #3d5afe,
  'a700': #304ffe
}

clr-indigo =      clr-indigo-list[base]

clr-indigo-50 =   clr-indigo-list['50']
clr-indigo-100 =  clr-indigo-list['100']
clr-indigo-200 =  clr-indigo-list['200']
clr-indigo-300 =  clr-indigo-list['300']
clr-indigo-400 =  clr-indigo-list['400']
clr-indigo-500 =  clr-indigo-list['500']
clr-indigo-600 =  clr-indigo-list['600']
clr-indigo-700 =  clr-indigo-list['700']
clr-indigo-800 =  clr-indigo-list['800']
clr-indigo-900 =  clr-indigo-list['900']
clr-indigo-a100 = clr-indigo-list['a100']
clr-indigo-a200 = clr-indigo-list['a200']
clr-indigo-a400 = clr-indigo-list['a400']
clr-indigo-a700 = clr-indigo-list['a700']


//
// Blue
//

clr-blue-list = {
  'base': #2196f3,
  '50':   #e3f2fd,
  '100':  #bbdefb,
  '200':  #90caf9,
  '300':  #64b5f6,
  '400':  #42a5f5,
  '500':  #2196f3,
  '600':  #1e88e5,
  '700':  #1976d2,
  '800':  #1565c0,
  '900':  #0d47a1,
  'a100': #82b1ff,
  'a200': #448aff,
  'a400': #2979ff,
  'a700': #2962ff
}

clr-blue =      clr-blue-list[base]

clr-blue-50 =   clr-blue-list['50']
clr-blue-100 =  clr-blue-list['100']
clr-blue-200 =  clr-blue-list['200']
clr-blue-300 =  clr-blue-list['300']
clr-blue-400 =  clr-blue-list['400']
clr-blue-500 =  clr-blue-list['500']
clr-blue-600 =  clr-blue-list['600']
clr-blue-700 =  clr-blue-list['700']
clr-blue-800 =  clr-blue-list['800']
clr-blue-900 =  clr-blue-list['900']
clr-blue-a100 = clr-blue-list['a100']
clr-blue-a200 = clr-blue-list['a200']
clr-blue-a400 = clr-blue-list['a400']
clr-blue-a700 = clr-blue-list['a700']


//
// Light Blue
//

clr-light-blue-list = {
  'base': #03a9f4,
  '50':   #e1f5fe,
  '100':  #b3e5fc,
  '200':  #81d4fa,
  '300':  #4fc3f7,
  '400':  #29b6f6,
  '500':  #03a9f4,
  '600':  #039be5,
  '700':  #0288d1,
  '800':  #0277bd,
  '900':  #01579b,
  'a100': #80d8ff,
  'a200': #40c4ff,
  'a400': #00b0ff,
  'a700': #0091ea
}

clr-light-blue =      clr-light-blue-list[base]

clr-light-blue-50 =   clr-light-blue-list['50']
clr-light-blue-100 =  clr-light-blue-list['100']
clr-light-blue-200 =  clr-light-blue-list['200']
clr-light-blue-300 =  clr-light-blue-list['300']
clr-light-blue-400 =  clr-light-blue-list['400']
clr-light-blue-500 =  clr-light-blue-list['500']
clr-light-blue-600 =  clr-light-blue-list['600']
clr-light-blue-700 =  clr-light-blue-list['700']
clr-light-blue-800 =  clr-light-blue-list['800']
clr-light-blue-900 =  clr-light-blue-list['900']
clr-light-blue-a100 = clr-light-blue-list['a100']
clr-light-blue-a200 = clr-light-blue-list['a200']
clr-light-blue-a400 = clr-light-blue-list['a400']
clr-light-blue-a700 = clr-light-blue-list['a700']


//
// Cyan
//

clr-cyan-list = {
  'base': #00bcd4,
  '50':   #e0f7fa,
  '100':  #b2ebf2,
  '200':  #80deea,
  '300':  #4dd0e1,
  '400':  #26c6da,
  '500':  #00bcd4,
  '600':  #00acc1,
  '700':  #0097a7,
  '800':  #00838f,
  '900':  #006064,
  'a100': #84ffff,
  'a200': #18ffff,
  'a400': #00e5ff,
  'a700': #00b8d4
}

clr-cyan =      clr-cyan-list[base]

clr-cyan-50 =   clr-cyan-list['50']
clr-cyan-100 =  clr-cyan-list['100']
clr-cyan-200 =  clr-cyan-list['200']
clr-cyan-300 =  clr-cyan-list['300']
clr-cyan-400 =  clr-cyan-list['400']
clr-cyan-500 =  clr-cyan-list['500']
clr-cyan-600 =  clr-cyan-list['600']
clr-cyan-700 =  clr-cyan-list['700']
clr-cyan-800 =  clr-cyan-list['800']
clr-cyan-900 =  clr-cyan-list['900']
clr-cyan-a100 = clr-cyan-list['a100']
clr-cyan-a200 = clr-cyan-list['a200']
clr-cyan-a400 = clr-cyan-list['a400']
clr-cyan-a700 = clr-cyan-list['a700']


//
// Teal
//

clr-teal-list = {
  'base': #009688,
  '50':   #e0f2f1,
  '100':  #b2dfdb,
  '200':  #80cbc4,
  '300':  #4db6ac,
  '400':  #26a69a,
  '500':  #009688,
  '600':  #00897b,
  '700':  #00796b,
  '800':  #00695c,
  '900':  #004d40,
  'a100': #a7ffeb,
  'a200': #64ffda,
  'a400': #1de9b6,
  'a700': #00bfa5
}

clr-teal =      clr-teal-list[base]

clr-teal-50 =   clr-teal-list['50']
clr-teal-100 =  clr-teal-list['100']
clr-teal-200 =  clr-teal-list['200']
clr-teal-300 =  clr-teal-list['300']
clr-teal-400 =  clr-teal-list['400']
clr-teal-500 =  clr-teal-list['500']
clr-teal-600 =  clr-teal-list['600']
clr-teal-700 =  clr-teal-list['700']
clr-teal-800 =  clr-teal-list['800']
clr-teal-900 =  clr-teal-list['900']
clr-teal-a100 = clr-teal-list['a100']
clr-teal-a200 = clr-teal-list['a200']
clr-teal-a400 = clr-teal-list['a400']
clr-teal-a700 = clr-teal-list['a700']


//
// Green
//

clr-green-list = {
  'base': #4caf50,
  '50':   #e8f5e9,
  '100':  #c8e6c9,
  '200':  #a5d6a7,
  '300':  #81c784,
  '400':  #66bb6a,
  '500':  #4caf50,
  '600':  #43a047,
  '700':  #388e3c,
  '800':  #2e7d32,
  '900':  #1b5e20,
  'a100': #b9f6ca,
  'a200': #69f0ae,
  'a400': #00e676,
  'a700': #00c853
}

clr-green =      clr-green-list[base]

clr-green-50 =   clr-green-list['50']
clr-green-100 =  clr-green-list['100']
clr-green-200 =  clr-green-list['200']
clr-green-300 =  clr-green-list['300']
clr-green-400 =  clr-green-list['400']
clr-green-500 =  clr-green-list['500']
clr-green-600 =  clr-green-list['600']
clr-green-700 =  clr-green-list['700']
clr-green-800 =  clr-green-list['800']
clr-green-900 =  clr-green-list['900']
clr-green-a100 = clr-green-list['a100']
clr-green-a200 = clr-green-list['a200']
clr-green-a400 = clr-green-list['a400']
clr-green-a700 = clr-green-list['a700']


//
// Light green
//

clr-light-green-list = {
  'base': #8bc34a,
  '50':   #f1f8e9,
  '100':  #dcedc8,
  '200':  #c5e1a5,
  '300':  #aed581,
  '400':  #9ccc65,
  '500':  #8bc34a,
  '600':  #7cb342,
  '700':  #689f38,
  '800':  #558b2f,
  '900':  #33691e,
  'a100': #ccff90,
  'a200': #b2ff59,
  'a400': #76ff03,
  'a700': #64dd17
}

clr-light-green =      clr-light-green-list[base]

clr-light-green-50 =   clr-light-green-list['50']
clr-light-green-100 =  clr-light-green-list['100']
clr-light-green-200 =  clr-light-green-list['200']
clr-light-green-300 =  clr-light-green-list['300']
clr-light-green-400 =  clr-light-green-list['400']
clr-light-green-500 =  clr-light-green-list['500']
clr-light-green-600 =  clr-light-green-list['600']
clr-light-green-700 =  clr-light-green-list['700']
clr-light-green-800 =  clr-light-green-list['800']
clr-light-green-900 =  clr-light-green-list['900']
clr-light-green-a100 = clr-light-green-list['a100']
clr-light-green-a200 = clr-light-green-list['a200']
clr-light-green-a400 = clr-light-green-list['a400']
clr-light-green-a700 = clr-light-green-list['a700']


//
// Lime
//

clr-lime-list = {
  'base': #cddc39,
  '50':   #f9fbe7,
  '100':  #f0f4c3,
  '200':  #e6ee9c,
  '300':  #dce775,
  '400':  #d4e157,
  '500':  #cddc39,
  '600':  #c0ca33,
  '700':  #afb42b,
  '800':  #9e9d24,
  '900':  #827717,
  'a100': #f4ff81,
  'a200': #eeff41,
  'a400': #c6ff00,
  'a700': #aeea00
}

clr-lime =      clr-lime-list[base]

clr-lime-50 =   clr-lime-list['50']
clr-lime-100 =  clr-lime-list['100']
clr-lime-200 =  clr-lime-list['200']
clr-lime-300 =  clr-lime-list['300']
clr-lime-400 =  clr-lime-list['400']
clr-lime-500 =  clr-lime-list['500']
clr-lime-600 =  clr-lime-list['600']
clr-lime-700 =  clr-lime-list['700']
clr-lime-800 =  clr-lime-list['800']
clr-lime-900 =  clr-lime-list['900']
clr-lime-a100 = clr-lime-list['a100']
clr-lime-a200 = clr-lime-list['a200']
clr-lime-a400 = clr-lime-list['a400']
clr-lime-a700 = clr-lime-list['a700']


//
// Yellow
//

clr-yellow-list = {
  'base': #ffeb3b,
  '50':   #fffde7,
  '100':  #fff9c4,
  '200':  #fff59d,
  '300':  #fff176,
  '400':  #ffee58,
  '500':  #ffeb3b,
  '600':  #fdd835,
  '700':  #fbc02d,
  '800':  #f9a825,
  '900':  #f57f17,
  'a100': #ffff8d,
  'a200': #ffff00,
  'a400': #ffea00,
  'a700': #ffd600
}

clr-yellow =      clr-yellow-list[base]

clr-yellow-50 =   clr-yellow-list['50']
clr-yellow-100 =  clr-yellow-list['100']
clr-yellow-200 =  clr-yellow-list['200']
clr-yellow-300 =  clr-yellow-list['300']
clr-yellow-400 =  clr-yellow-list['400']
clr-yellow-500 =  clr-yellow-list['500']
clr-yellow-600 =  clr-yellow-list['600']
clr-yellow-700 =  clr-yellow-list['700']
clr-yellow-800 =  clr-yellow-list['800']
clr-yellow-900 =  clr-yellow-list['900']
clr-yellow-a100 = clr-yellow-list['a100']
clr-yellow-a200 = clr-yellow-list['a200']
clr-yellow-a400 = clr-yellow-list['a400']
clr-yellow-a700 = clr-yellow-list['a700']


//
// amber
//

clr-amber-list = {
  'base': #ffc107,
  '50':   #fff8e1,
  '100':  #ffecb3,
  '200':  #ffe082,
  '300':  #ffd54f,
  '400':  #ffca28,
  '500':  #ffc107,
  '600':  #ffb300,
  '700':  #ffa000,
  '800':  #ff8f00,
  '900':  #ff6f00,
  'a100': #ffe57f,
  'a200': #ffd740,
  'a400': #ffc400,
  'a700': #ffab00
}

clr-amber =      clr-amber-list[base]

clr-amber-50 =   clr-amber-list['50']
clr-amber-100 =  clr-amber-list['100']
clr-amber-200 =  clr-amber-list['200']
clr-amber-300 =  clr-amber-list['300']
clr-amber-400 =  clr-amber-list['400']
clr-amber-500 =  clr-amber-list['500']
clr-amber-600 =  clr-amber-list['600']
clr-amber-700 =  clr-amber-list['700']
clr-amber-800 =  clr-amber-list['800']
clr-amber-900 =  clr-amber-list['900']
clr-amber-a100 = clr-amber-list['a100']
clr-amber-a200 = clr-amber-list['a200']
clr-amber-a400 = clr-amber-list['a400']
clr-amber-a700 = clr-amber-list['a700']


//
// Orange
//

clr-orange-list = {
  'base': #ff9800,
  '50':   #fff3e0,
  '100':  #ffe0b2,
  '200':  #ffcc80,
  '300':  #ffb74d,
  '400':  #ffa726,
  '500':  #ff9800,
  '600':  #fb8c00,
  '700':  #f57c00,
  '800':  #ef6c00,
  '900':  #e65100,
  'a100': #ffd180,
  'a200': #ffab40,
  'a400': #ff9100,
  'a700': #ff6d00
}

clr-orange =      clr-orange-list[base]

clr-orange-50 =   clr-orange-list['50']
clr-orange-100 =  clr-orange-list['100']
clr-orange-200 =  clr-orange-list['200']
clr-orange-300 =  clr-orange-list['300']
clr-orange-400 =  clr-orange-list['400']
clr-orange-500 =  clr-orange-list['500']
clr-orange-600 =  clr-orange-list['600']
clr-orange-700 =  clr-orange-list['700']
clr-orange-800 =  clr-orange-list['800']
clr-orange-900 =  clr-orange-list['900']
clr-orange-a100 = clr-orange-list['a100']
clr-orange-a200 = clr-orange-list['a200']
clr-orange-a400 = clr-orange-list['a400']
clr-orange-a700 = clr-orange-list['a700']


//
// Deep orangle
//

clr-deep-orange-list = {
  'base': #ff5722,
  '50':   #fbe9e7,
  '100':  #ffccbc,
  '200':  #ffab91,
  '300':  #ff8a65,
  '400':  #ff7043,
  '500':  #ff5722,
  '600':  #f4511e,
  '700':  #e64a19,
  '800':  #d84315,
  '900':  #bf360c,
  'a100': #ff9e80,
  'a200': #ff6e40,
  'a400': #ff3d00,
  'a700': #dd2c00
}

clr-deep-orange =      clr-deep-orange-list[base]

clr-deep-orange-50 =   clr-deep-orange-list['50']
clr-deep-orange-100 =  clr-deep-orange-list['100']
clr-deep-orange-200 =  clr-deep-orange-list['200']
clr-deep-orange-300 =  clr-deep-orange-list['300']
clr-deep-orange-400 =  clr-deep-orange-list['400']
clr-deep-orange-500 =  clr-deep-orange-list['500']
clr-deep-orange-600 =  clr-deep-orange-list['600']
clr-deep-orange-700 =  clr-deep-orange-list['700']
clr-deep-orange-800 =  clr-deep-orange-list['800']
clr-deep-orange-900 =  clr-deep-orange-list['900']
clr-deep-orange-a100 = clr-deep-orange-list['a100']
clr-deep-orange-a200 = clr-deep-orange-list['a200']
clr-deep-orange-a400 = clr-deep-orange-list['a400']
clr-deep-orange-a700 = clr-deep-orange-list['a700']


//
// Brown
//

clr-brown-list = {
  'base': #795548,
  '50':   #efebe9,
  '100':  #d7ccc8,
  '200':  #bcaaa4,
  '300':  #a1887f,
  '400':  #8d6e63,
  '500':  #795548,
  '600':  #6d4c41,
  '700':  #5d4037,
  '800':  #4e342e,
  '900':  #3e2723,
}

clr-brown =     clr-brown-list[base]

clr-brown-50 =  clr-brown-list['50']
clr-brown-100 = clr-brown-list['100']
clr-brown-200 = clr-brown-list['200']
clr-brown-300 = clr-brown-list['300']
clr-brown-400 = clr-brown-list['400']
clr-brown-500 = clr-brown-list['500']
clr-brown-600 = clr-brown-list['600']
clr-brown-700 = clr-brown-list['700']
clr-brown-800 = clr-brown-list['800']
clr-brown-900 = clr-brown-list['900']


//
// Grey
//

clr-grey-list = {
  'base': #9e9e9e,
  '50':   #fafafa,
  '100':  #f5f5f5,
  '200':  #eeeeee,
  '300':  #e0e0e0,
  '400':  #bdbdbd,
  '500':  #9e9e9e,
  '600':  #757575,
  '700':  #616161,
  '800':  #424242,
  '900':  #212121,
}

clr-grey =     clr-grey-list[base]

clr-grey-50 =  clr-grey-list['50']
clr-grey-100 = clr-grey-list['100']
clr-grey-200 = clr-grey-list['200']
clr-grey-300 = clr-grey-list['300']
clr-grey-400 = clr-grey-list['400']
clr-grey-500 = clr-grey-list['500']
clr-grey-600 = clr-grey-list['600']
clr-grey-700 = clr-grey-list['700']
clr-grey-800 = clr-grey-list['800']
clr-grey-900 = clr-grey-list['900']


//
// Blue grey
//

clr-blue-grey-list = {
  'base': #607d8b,
  '50':   #eceff1,
  '100':  #cfd8dc,
  '200':  #b0bec5,
  '300':  #90a4ae,
  '400':  #78909c,
  '500':  #607d8b,
  '600':  #546e7a,
  '700':  #455a64,
  '800':  #37474f,
  '900':  #263238,
}

clr-blue-grey =     clr-blue-grey-list[base]

clr-blue-grey-50 =  clr-blue-grey-list['50']
clr-blue-grey-100 = clr-blue-grey-list['100']
clr-blue-grey-200 = clr-blue-grey-list['200']
clr-blue-grey-300 = clr-blue-grey-list['300']
clr-blue-grey-400 = clr-blue-grey-list['400']
clr-blue-grey-500 = clr-blue-grey-list['500']
clr-blue-grey-600 = clr-blue-grey-list['600']
clr-blue-grey-700 = clr-blue-grey-list['700']
clr-blue-grey-800 = clr-blue-grey-list['800']
clr-blue-grey-900 = clr-blue-grey-list['900']


//
// Black
//

clr-black-list = {
  'base': #000
}

clr-black = clr-black-list[base]


//
// White
//

clr-white-list = {
  'base': #fff
}

clr-white = clr-white-list[base]


//
// List for all Colors for looping
//

clr-list-all = {
  'red':         clr-red-list,
  'pink':        clr-pink-list,
  'purple':      clr-purple-list,
  'deep-purple': clr-deep-purple-list,
  'indigo':      clr-indigo-list,
  'blue':        clr-blue-list,
  'light-blue':  clr-light-blue-list,
  'cyan':        clr-cyan-list,
  'teal':        clr-teal-list,
  'green':       clr-green-list,
  'light-green': clr-light-green-list,
  'lime':        clr-lime-list,
  'yellow':      clr-yellow-list,
  'amber':       clr-amber-list,
  'orange':      clr-orange-list,
  'deep-orange': clr-deep-orange-list,
  'brown':       clr-brown-list,
  'grey':        clr-grey-list,
  'blue-grey':   clr-blue-grey-list,
  'black':       clr-black-list,
  'white':       clr-white-list
}


//
// Typography
//

clr-ui-display-4 = clr-grey-600
clr-ui-display-3 = clr-grey-600
clr-ui-display-2 = clr-grey-600
clr-ui-display-1 = clr-grey-600
clr-ui-headline =  clr-grey-900
clr-ui-title =     clr-grey-900
clr-ui-subhead-1 = clr-grey-900
clr-ui-body-2 =    clr-grey-900
clr-ui-body-1 =    clr-grey-900
clr-ui-caption =   clr-grey-600
clr-ui-menu =      clr-grey-900
clr-ui-button =    clr-grey-900

EOF
}
}
