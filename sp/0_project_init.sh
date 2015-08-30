function pi() {
# Create Project Folder
md ./$1

# Create Directory Structure
d build
d src/jade
d src/stylus
d src/js
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
		meta(http-equiv='X-UA-Compatible' content='IE=edge')
		meta(name='viewport' content='width=device-width, initial-scale=1')
		meta(name='description' content='This is the information that appears in the google description for your page')
		title
		link(rel='stylesheet', href='css/style.css')
		script(src='js/app.js')

	body
		h1 Success!
EOF




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




cat <<EOF >> ./src/js/app.js
EOF




# Files and Folders git should ignore
f .gitignore
cat <<EOF >> ./.gitignore
*/DS_Store
node_modules/
build/
production/
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
var findAffected = require('gulp-jade-find-affected');
var minifyHTML   = require('gulp-minify-html');

// Stylus
var stylus       = require('gulp-stylus');
var axis         = require('axis');
var rupture      = require('rupture');     // media queries
var typo         = require('typographic'); // typography
var lost         = require('lost');        // grids
var minifyCSS    = require('gulp-csso');

// Post CSS
var autoprefixer = require('gulp-autoprefixer');
var postcss      = require('gulp-postcss');
var sourcemaps   = require('gulp-sourcemaps');
var combineMQ    = require('gulp-combine-mq');

// Catch Errors
var plumber      = require('gulp-plumber');

// Sitemaps
var sitemap      = require('gulp-sitemap');




//
// Source and Destination Files
//

// src files
var src = {
	jade:      ['./src/jade/*.jade', '!./src/jade/layout/**/*.jade'],
	jadeAll:    './src/jade/**/*.jade',
	stylus:     './src/stylus/style.styl',
	stylusAll:  './src/stylus/**/*.styl',
	js:         './src/js/*.js'
};


// build directories
var build = {
	html: './build/',
	css:  './build/css/',
	js:   './build/js/'
};

// sitemap site url
var siteURL = {
	siteUrl: 'http://www.plumbingflow.com'
}




//
// Gulp Build Tasks
//

// Jade >> HTML
gulp.task('jade', function() {
	stream = gulp.src(src.jade)
		.pipe(plumber())
		.pipe(findAffected())
		.pipe(jade({pretty: true}))
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
    .pipe(combineMQ({
        beautify: true
    }))
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

	gulp.watch( src.jadeAll,   [ 'jade'   ]);
	gulp.watch( src.stylusAll, [ 'stylus' ]);
	gulp.watch( src.js,        [ 'js'     ]);

});




//
// Gulp Production Tasks
//

// production directories
var pro = {
	html: 'production/',
	css:  'production/css/',
	js:   'production/js/'
};


// Jade >> HTML
gulp.task('pro_jade', function() {
	stream = gulp.src(src.jade)
		.pipe(plumber())
		.pipe(jade())
		.pipe(minifyHTML({
			conditionals: true
		}))
		.pipe(gulp.dest(pro.html))
		.pipe(reload({stream: true}));

	return stream;
});


// Stylus >> CSS
gulp.task('pro_stylus', function() {
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
    .pipe(combineMQ())
    .pipe(autoprefixer())
    .pipe(minifyCSS({
    	structureMinimization: true
  	}))
		.pipe(gulp.dest(pro.css))
		.pipe(reload({stream: true}));

	return stream;
});

// Scripts >> JS
gulp.task('pro_js', function() {
	stream = gulp.src(src.js)
		.pipe(plumber())
		.pipe(gulp.dest(pro.js))
		.pipe(reload({stream: true}));

	return stream;
})


// Sitemap
gulp.task('sitemap', function () {
  gulp.src('./production/**/*.html')
    .pipe(sitemap(siteURL))
    .pipe(gulp.dest('./production'));
});


// Production Build Task
gulp.task( 'pro', ['pro_jade', 'pro_stylus', 'pro_js', 'sitemap'], function() {});

EOF



# Initiate NPM
npm init
npmd gulp axis browser-sync gulp-autoprefixer gulp-csscss gulp-csso gulp-jade gulp-jade-find-affected gulp-minify-html gulp-plumber gulp-postcss gulp-sitemap gulp-sourcemaps gulp-stylus lost rupture typographic gulp-combine-mq



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