function gp.SetupFiles {
# create GulpJS Setup Files
f gulpfile.js
f package.json
}

function gp.SetupPackageJSON {
# package.json content
cat <<EOF >> package.json
{

}
EOF
}

function gp.SetupGulpfileJS {
# gulpfile.js content
cat <<EOF >> gulpfile.js
require('coffee-script/register');
// This bootstraps your Gulp's main file
require('./gulpfile.coffee');
EOF
}

function gp.SetupGulpfileCOFFEE {
# gulpfile.coffee content
cat <<EOF >> gulpfile.coffee
##
##
## Gulp Environment Setup
###############################################################################

##
## Required Libraries
##

gulp        = require 'gulp'                 # Loads gulp
gp          = do require 'gulp-load-plugins' # Loads all gulp plugins
browserSync = require 'browser-sync'         # Reloads and Syncs Browsers
marked      = require 'marked'               # For :markdown filter in jade
axis        = require 'axis'                 # stylus plugin for awesomeness
rupture     = require 'rupture'              # stylus plugin for media-queries
typo        = require 'typographic'          # stylus plugin for typography



##
## WebSite Variables
##

setup =
	## Sitemap URL (the name of your website should go here)
	siteUrl: 'http://www.websiteName.us'

	## HTML files UnCSS checks Before removing unused CSS
	## Change to array if more than one html file
	## example: ['index.html', 'about.html', etc…]
	
	unCSS_CheckFiles: 'index.html'



##
## Path Variables
##

paths =
	## source files
	srcStylus: 'src/_stylus/style.styl'
	srcJade:  ['src/_jade/**/*.jade',
						 '!src/_jade/_layout/**/*.jade',
						 '!src/_jade/_components/**/*.jade',
						 '!src/_jade/_settings/**/*.jade']
	srcJs:    ['src/_js/script.js', 'src/_js/**/*.js']
	srcCoffee: 'src/_coffee/**/*.coffee'
	srcPng:    'src/_assets/png/**/*.png'
	srcJpg:   ['src/_assets/jpg/**/*.jpg', 'src/_assets/jpg/**/*.jpeg']
	srcSvg:    'src/_assets/svg/**/*.svg'

	## destination files for development build
	devHtml:   'build/dev/'
	devCss:    'build/dev/_css/'
	devJs:     'build/dev/_js/'
	devImg:    'build/dev/_img/'

	## destination files for production build
	proHtml:   'build/pro/'
	proCss:    'build/pro/_css/'
	proJs:     'build/pro/_js/'
	proImg:    'build/pro/_img/'



##
##
## Developer Build Tasks
###############################################################################

##
## Jade to HTML Pipeline
##

gulp.task 'jade2html', ->
	# gets jade files
	gulp.src paths.srcJade
		# prevents gulp crashes caused by jade/stylus/coffeescript conversions
		.pipe gp.plumber()
		# converts jade => html
		.pipe gp.jade {pretty: false}
		# makes human readable HTML
		.pipe gp.prettify {indent_char: '\t', indent_size: 1}
		# outputs html files to directory specified in the Path variables
		.pipe gulp.dest paths.devHtml
		# reloads browser
		.pipe browserSync.reload {stream:true}



##
## Stylus to CSS Pipeline
##

gulp.task 'stylus2css', ->
	# gets stylus files
	gulp.src paths.srcStylus
		# prevents gulp crashes caused by jade/stylus/coffeescript conversions
		.pipe gp.plumber()
		# converts Stylus => CSS, shows any errors in terminal
		.pipe gp.stylus {errors: true, use: [axis(), rupture(),typo()]}
		# adds browser prefixes
		.pipe gp.autoprefixer 'last 12 version', '> 1%', 'ie 8', 'ie 7'
		# combine the media queries
		.pipe gp.combineMediaQueries()
		# makes human readable CSS
		.pipe gp.cssbeautify()
		# outputs css to file
		.pipe gulp.dest paths.devCss
		# reloads browser
		.pipe browserSync.reload {stream:true}



##
## CoffeeScript Pipeline
##

gulp.task 'coffee', =>
	return gulp.src [
		paths.srcCoffee
	]
		.pipe gp.plumber()
		# converts coffeeScript to css
		.pipe gp.coffee()
		.pipe gulp.dest 'src/_js/'



##
## Javascript Pipeline
##
# 'js' task waits for 'coffee' task to finish before running
gulp.task 'js', ['coffee'], -> 
	return gulp.src paths.srcJs
		# combines all javascript files into one 'script.js' file
		.pipe gp.concat 'script.js'
		# makes human readable JavaScript
		# ???? Add JS Beautify Step
		.pipe gulp.dest paths.devJs
		.pipe browserSync.reload {stream:true, once: true}



##
## IMG Pipeline
##

## SVG Pipeline
gulp.task 'svg', ->
	gulp.src paths.srcSvg
		# ???? Add SVG Processing Step
		.pipe gulp.dest paths.devHtml
		.pipe browserSync.reload {stream:true}

## PNG Pipeline
gulp.task 'png', ->
	gulp.src paths.srcPng
		.pipe gulp.dest paths.devImg
		.pipe browserSync.reload {stream:true}

## JPG Pipeline
gulp.task 'jpg', ->
	gulp.src paths.srcJpg
		.pipe gulp.dest paths.devImg
		.pipe browserSync.reload {stream:true}



##
## BrowserSync Task
##

## Start server using dev directory
gulp.task 'browser-sync', ->
	browserSync.init null,
		server:
			baseDir: './build/dev/' # server runs on this directory
		notify: false

## Reload all Browsers
gulp.task 'bs-reload', ->
		browserSync.reload()



##
## Watch file and rerun task on a file change
##

gulp.task 'watch', ->
	gulp.watch paths.srcJade,   ['jade2html' , 'bs-reload']
	gulp.watch paths.srcStylus, ['stylus2css', 'bs-reload']
	gulp.watch paths.srcCoffee, ['coffee'    , 'bs-reload']
	gulp.watch paths.srcJs,     ['js'        , 'bs-reload']
	gulp.watch paths.srcSvg,    ['svg'       , 'bs-reload']
	gulp.watch paths.srcPng,    ['png'       , 'bs-reload']
	gulp.watch paths.srcJpg,    ['jpg'       , 'bs-reload']



##
## DEFAULT TASK
##

gulp.task 'default', ['watch', 'jade2html', 'stylus2css', 'coffee', 'js', 'png', 'jpg', 'svg', 'browser-sync']



##
## Production Build Tasks
###############################################################################

##
## Jade to HTML Pipeline => Production Version
##

gulp.task 'pro.jade2html', ->
	gulp.src paths.srcJade
		.pipe gp.plumber()
		# converts Jade to HTML (minified)
		.pipe gp.jade {pretty: false}
		# removes comments and whitespace from HTML
		.pipe gp.cleanhtml()
		# .pipe gp.gzip {append: true}
		.pipe gulp.dest paths.proHtml



##
## Stylus to CSS Pipeline => Production Version
##

gulp.task 'pro.stylus2css', ->
	gulp.src paths.srcStylus
		.pipe gp.plumber()
		.pipe gp.stylus {errors: true, use: [axis(), rupture(),typo()]}
		.pipe gp.combineMediaQueries() # combine the media queries
		.pipe gp.autoprefixer 'last 12 version', '> 1%', 'ie 8', 'ie 7'
		# .pipe gp.gzip {append: true}
		.pipe gulp.dest paths.proCss



##
## CoffeeScript Pipeline => Production Version
##

gulp.task 'pro.coffee', =>
	return gulp.src [
		paths.srcCoffee
	]
		.pipe gp.plumber()
		.pipe gp.coffee()
		.pipe gulp.dest 'src/_js/'



##
## Javascript Pipeline => Production Version
##
# 'js' task waits for 'coffee' task to finish before running
gulp.task 'pro.js', ['pro.coffee'], -> 
	return gulp.src paths.srcJs
		# combines all javascript into one file
		.pipe gp.concat 'script.js'
		# removes all whitespaces and comments
		.pipe gp.uglify()
		# .pipe gp.gzip {append: true}
		.pipe gulp.dest paths.proJs
		.pipe browserSync.reload {stream:true, once: true}



##
## IMG Pipeline => Production Version
##

## SVG Pipeline
gulp.task 'pro.svg', ->
	gulp.src paths.srcSvg
		.pipe gp.imagemin(svgoPlugins: [
			{removeViewBox: false},
			{removeDesc: true},
			{removeUnknownsAndDefaults: true},
			{removeUnusedNS: true},
			{removeEmptyContainers: true},
			{collapseGroups: true},
			{removeEditorsNSData: true},
			{removeEmptyText: true},
			{removeHiddenElems: true},
			{removeNonInheritableGroupAttrs: true},
			{collapseGroups: true},
			{moveElemsAttrsToGroup: true}
			{moveGroupAttrsToElems: true},
			{sortAttrs: true}
		])
		# ???? Add SVG Processing Step
		.pipe gp.cleanhtml() # minify svg file
		.pipe gulp.dest paths.proHtml
		.pipe browserSync.reload {stream:true}

## PNG Pipeline
gulp.task 'pro.png', ->
	gulp.src paths.srcPng
		.pipe gp.imagemin()
		.pipe gulp.dest paths.proImg
		.pipe browserSync.reload {stream:true}

## JPG Pipeline
gulp.task 'pro.jpg', ->
	gulp.src paths.srcJpg
		.pipe gp.imagemin()
		.pipe gulp.dest paths.proImg
		.pipe browserSync.reload {stream:true}



##
## SiteMap Generator
##

gulp.task 'sitemap', ['pro.jade2html'], ->
	gulp.src 'build/pro/**/*.html', { read: true }
		.pipe gp.sitemap {
			# this URL gets prepended to all files (change as needed)
			siteUrl: setup.siteUrl
		}
		.pipe gulp.dest 'build/pro/'



##
## Production TASK
##

gulp.task 'pro', ['pro.jade2html', 'pro.stylus2css', 'pro.coffee', 'pro.js', 'pro.png', 'pro.jpg', 'pro.svg', 'sitemap']



EOF
}

function gp.GitIgnore {
cat <<EOF >> .gitignore
*/.DS_Store
build/
/node_modules
src/_assets/jpg
src/_assets/png
EOF
}
