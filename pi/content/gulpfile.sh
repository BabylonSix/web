# Create Gulp Setup
cat <<EOF >> ./gulpfile.js
//
// Gulp Plugins
//

// Load Gulp
const gulp         = require('gulp');

// Jade
const jade         = require('gulp-jade');
const findAffected = require('gulp-jade-find-affected');
const minifyHTML   = require('gulp-minify-html');

// Sitemaps
const sitemap      = require('gulp-sitemap');

// Stylus
const stylus       = require('gulp-stylus');
const axis         = require('axis');
const rupture      = require('rupture');     // media queries
const typo         = require('typographic'); // typography
const lost         = require('lost');        // grids
const minifyCSS    = require('gulp-csso');

// Post CSS
const postcss      = require('gulp-postcss');
const autoprefixer = require('autoprefixer');
const rucksack     = require('rucksack-css');

const sourcemaps   = require('gulp-sourcemaps');
const combineMQ    = require('gulp-combine-mq');

// JS ES6
const babel        = require('gulp-babel');

// Image Compression
const svgo         = require('imagemin-svgo');

// Browser Sync
const browserSync  = require('browser-sync').create();
const reload       = browserSync.reload;

/// Utilities
const plumber      = require('gulp-plumber'); // Catch Errors
const runSequence  = require('run-sequence');

// Compression
const zopfli       = require('gulp-zopfli'); // gzips files
// add the following line to your .htaccess so that
// apache could serve up pre-compressed content:
// Options FollowSymLinks MultiViews

// Deployment
const ftp          = require('vinyl-ftp');
const secrets      = require('./secrets.json'); // password



//
// Source and Destination Files
//


// src files
const src = {
	//code assets
	jade:      ['./src/jade/**/*.jade', '!./src/jade/views/**/*.jade'],
	jadeAll:    './src/jade/**/*.jade',
	stylus:     './src/stylus/style.styl',
	stylusAll:  './src/stylus/**/*.styl',
	js:         './src/js/*.js',

	// image assets
	svg:        './src/assets/svg/**/*.svg',
	jpeg:      ['./src/assets/jpg/**/*.jpg', './src/assets/jpg/**/*.jpeg'],
	png:        './src/assets/png/**/*.png'
};


// build directories
const build = {
	html: './build/',
	css:  './build/css/',
	js:   './build/js/',
	img:  './build/img/'
};

// sitemap site url
const siteURL = {
	siteUrl: 'http://www.plumbingflow.com'
};




//
// Gulp Tasks
//


// Jade >> HTML
gulp.task('jade', () => {
	return gulp.src(src.jade)
		.pipe(plumber())
		.pipe(findAffected())
		.pipe(jade({pretty: true}))
		.pipe(gulp.dest(build.html))
		.pipe(reload({stream: true}));
});


// Stylus >> CSS
gulp.task('stylus', () => {
	return gulp.src(src.stylus)
		.pipe(plumber())
		.pipe(sourcemaps.init())
		.pipe(stylus({
			errors: true,
			use: [axis(), rupture(), typo()]
		}))
		.pipe(postcss([
			lost(),
			rucksack(),
			autoprefixer({ browsers: ['last 2 versions', '> 5%'] })
		]))
		.pipe(combineMQ({
			beautify: true
		}))
		.pipe(sourcemaps.write('./sourcemaps/'))
		.pipe(gulp.dest(build.css))
		.pipe(reload({stream: true}));
});


// Scripts >> JS
gulp.task('js', () => {
	return gulp.src(src.js)
		.pipe(plumber())
		.pipe(babel({
			presets: ['es2015']
		}))
		.pipe(gulp.dest(build.js))
		.pipe(reload({stream: true}));
});


// SVG Pipe
gulp.task('svg', () => {
	return gulp.src(src.svg)
		.pipe(plumber())
		.pipe(gulp.dest(build.img));
});

// JPEG Pipe
gulp.task('jpeg', () => {
	return gulp.src(src.jpeg)
		.pipe(plumber())
		.pipe(gulp.dest(build.img));
});

// PNG Pipe
gulp.task('png', () => {
	return gulp.src(src.png)
		.pipe(plumber())
		.pipe(gulp.dest(build.img));
});


// Browser Sync
gulp.task( 'default', ['jade', 'stylus', 'js', 'svg', 'jpeg', 'png'], () => {

	browserSync.init({
		server: 'build/'
	});

	gulp.watch( src.jadeAll,   [ 'jade'   ]);
	gulp.watch( src.stylusAll, [ 'stylus' ]);
	gulp.watch( src.js,        [ 'js'     ]);
	gulp.watch( src.svg,       [ 'svg'    ]);
	gulp.watch( src.jpeg,      [ 'jpeg'   ]);
	gulp.watch( src.png,       [ 'png'    ]);

});




//
// Production Gulp Tasks
//


// production directories
var pro = {
	html: 'production/',
	css:  'production/css/',
	js:   'production/js/',
	img:  'production/img/'
};


// Jade >> HTML
gulp.task('pro_jade', () => {
	return gulp.src(src.jade)
		.pipe(plumber())
		.pipe(jade())
		.pipe(minifyHTML({
			conditionals: true
		}))
		.pipe(zopfli())
		.pipe(gulp.dest(pro.html));
});


// Stylus >> CSS
gulp.task('pro_stylus', () => {
	return gulp.src(src.stylus)
		.pipe(plumber())
		.pipe(sourcemaps.init())
		.pipe(stylus({
			errors: true,
			use: [axis(), rupture(),typo()]
		}))
		.pipe(postcss([
			lost(),
			rucksack(),
			autoprefixer({ browsers: ['last 2 versions', '> 5%'] })
		]))
		.pipe(combineMQ())
		.pipe(minifyCSS({ structureMinimization: true }))
		.pipe(zopfli())
		.pipe(gulp.dest(pro.css));
});


// Scripts >> JS
gulp.task('pro_js', () => {
	return gulp.src(src.js)
		.pipe(plumber())
		.pipe(babel({
			presets: ['es2015']
		}))
		.pipe(zopfli())
		.pipe(gulp.dest(pro.js));
});



// SVG Optimization
gulp.task('pro_svg', () => {
	return gulp.src(src.svg)
		.pipe(plumber())
		.pipe(svgo()())
		.pipe(zopfli({ numiterations: 15 }))
		.pipe(gulp.dest(pro.img));
});

// JPEG Optimization
gulp.task('pro_jpeg', () => {
	return gulp.src(src.jpeg)
		.pipe(plumber())
		.pipe(gulp.dest(pro.img));
});

// PNG Optimization
gulp.task('pro_png', () => {
	return gulp.src(src.png)
		.pipe(plumber())
		.pipe(gulp.dest(pro.img));
});

// Sitemap
gulp.task('sitemap', function () {
	gulp.src('./production/**/*.html')
	.pipe(sitemap(siteURL))
	.pipe(gulp.dest(pro.html));
});


// Production Build Task
gulp.task( 'pro', ['pro_jade', 'pro_stylus', 'pro_js', 'pro_svg', 'pro_jpeg', 'pro_png', 'sitemap'], () => {});




// FTP Deploy Task
gulp.task( 'deploy', () => {

var connection = ftp.create( {
	host:     secrets.servers.production.serverhost,
	user:     secrets.servers.production.username,
	password: secrets.servers.production.password,
	parallel: 10
} );

var globs = [
	'production/**' // upload everything in the production folder
];

return gulp.src( globs, { base: './production/', buffer: false } )
	.pipe( connection.newer( secrets.servers.production.remotepath) )   // only upload newer files
	.pipe( connection.dest( secrets.servers.production.remotepath ) );

} );


// Production Build and Deploy
gulp.task( 'pd', () => {
	runSequence( 'pro', 'deploy' );
});

EOF
