function pi() {
# Create Project Folder
md ./$1

# Create Directory Structure
d build
d src/jade
d src/stylus
d src/scripts
d src/assets/img
d src/assets/svg

# Create Empty Starter Files
f src/jade/index.jade
f src/stylus/style.styl




# Starter Content
cat <<EOF >> ./src/jade/index.jade
doctype html

html(lang='en')
	head
		meta(charset='utf-8')
		title
		link(rel='stylesheet', href='css/style.css')
		script(src='js/app.js')

	body
		h1 Success!
EOF




cat <<EOF >> ./src/stylus/style.styl
@import 'typographic'

html
	background: hsl(200, 7%, 9%)

h1
	color: hsl(194, 28%, 70%)
EOF




cat <<EOF >> ./src/scripts/app.js
EOF




# Files and Folders git should ignore
f .gitignore
cat <<EOF >> ./.gitignore
*/DS_Store
node_modules/
build/
EOF



# Create Readme File
f readme.md
cat <<EOF >> ./readme.md
# Web Project Readme
EOF



# Create Gulp Setup
f gulpfile.js
cat <<EOF >> ./gulpfile.js
//
// Gulp Plugins
//

// Load Gulp
var gulp         = require('gulp');

// Browser Sync
var browserSync  = require('browser-sync').create();
var reload       = browserSync.reload;

// Jade
var jade         = require('gulp-jade');

// Stylus
var stylus       = require('gulp-stylus');
var axis         = require('axis');
var rupture      = require('rupture');     // media queries
var typo         = require('typographic'); // typography
var lost         = require('lost');        // grids

// Post CSS
var autoprefixer = require('gulp-autoprefixer');
var postcss      = require('gulp-postcss');
var sourcemaps   = require('gulp-sourcemaps');

// Catch Errors
var plumber      = require('gulp-plumber');




//
// Source and Destination Files
//

// src files
var src = {
	jade:   './src/jade/*.jade',
	stylus: './src/stylus/*.styl',
	js: './src/scripts/*.js'
};


// dest directories
var build = {
	html: 'build/',
	css:  'build/css/',
	js:   'build/js/'
};




//
// Gulp Tasks
//

// Jade >> HTML
gulp.task('jade', function() {
	stream = gulp.src(src.jade)
		.pipe(plumber())
		.pipe(jade())
		.pipe(gulp.dest(build.html))
		.pipe(reload({stream: true}));

	return stream;
});


// Stylus >> CSS
gulp.task('stylus', function() {
	stream = gulp.src(src.stylus)
		.pipe(plumber())
		.pipe(sourcemaps.init())
		.pipe(stylus({
			errors: true,
			use: [axis(), rupture(),typo()]
		}))
		.pipe(postcss([
      lost()
    ]))
    .pipe(autoprefixer())
    .pipe(sourcemaps.write('./sourcemaps/'))
		.pipe(gulp.dest(build.css))
		.pipe(reload({stream: true}));

	return stream;
});


// Scripts >> JS
gulp.task('js', function() {
	stream = gulp.src(src.js)
		.pipe(plumber())
		.pipe(gulp.dest(build.js))
		.pipe(reload({stream: true}));

	return stream;
})


// Browser Sync
gulp.task( 'default', ['jade', 'stylus', 'js'], function() {

	browserSync.init({
		server: 'build/'
	});

	gulp.watch( src.jade,   ['jade'] );
	gulp.watch( src.stylus, ['stylus'] );
	gulp.watch( src.js,     ['js'] );

});

EOF



# Initiate NPM
npm init
npmd gulp browser-sync gulp-jade gulp-stylus axis rupture typographic lost gulp-postcss gulp-sourcemaps gulp-autoprefixer gulp-plumber



# Initiate git
git init
ga . # git add
gc -m 'first commit' # first commit
gl



# open project in text editor
ot .



# Start Serving Project
gulp

}