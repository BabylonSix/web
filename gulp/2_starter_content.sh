function gp.starterContent {
# index.jade content
cat <<EOF >> src/_jade/index.jade
//- Template Path + siteConfig
extends _layout/base

append config
	//- -var page = { title: "", description: "", keywords: "" }

block site-header

append site-body

append site-footer
EOF


# config.jade content
cat <<EOF >> src/_jade/_settings/config.jade
//- Set to true to load script to page.
- var jQuery = false
- var jQueryMobile = false
- var jQueryUI = false
- var modernizr = false
- var threeJS = false
- var webfonts = false


//- Global Site Config
block site
	//- For Google Analytics: change UA-XXXXX-X to be your site's ID. (only loaded if actual site ID is included)
	-var site = {name: "siteName", googleID: "UA-XXXXX-X"}



//- Per Page Config
//- description and keywords meta tags only added if non-default content is provided.
block pageInfo
	-var page = {title: "pageTitle", description: "Page Description Info… (limit to 200 characters)", keywords: "Page Keywords… (limit to 1000 characters)"}
EOF


# layout.jade content
cat <<EOF >> src/_jade/_layout/base.jade
<!DOCTYPE html>
<!--[if lt IE 7]><html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en-US"><![endif]-->
<!--[if IE 7]><html class="no-js lt-ie9 lt-ie8" lang="en-US"><![endif]-->
<!--[if IE 8]><html class="no-js lt-ie9" lang="en-US"><![endif]-->
<!--[if gt IE 8]><!--><html class="no-js" lang="en-US"><!--<![endif]-->


//- 
	defaults (stored in variables) that can be
	changed on a page by page basis (using append config)
block config
	include ../_settings/config


//- default site head
include htmlHead


//- default site body
include htmlBody


</html>
EOF


# htmlHead.jade content
cat <<EOF >> src/_jade/_layout/htmlHead.jade
meta(charset="utf-8")
meta(http-equiv="X-UA-Compatible" content="IE=edge")
//- #{variable} => Google 'jade interpolation'
title: block title
	| #{site.name} | #{page.title}

meta(name="viewport" content="width=device-width, initial-scale=1")

if (page.description && page.description != "Page Description Info… (limit to 200 characters)")
	meta(name="description" content="#{page.description}")
if (page.keywords && page.keywords != "Page Keywords… (limit to 1000 characters)")
	meta(name="keywords" content="#{page.keywords}")
block meta

//- Place favicon.ico and apple-touch-icon.png in the root directory

link(rel="stylesheet" href="_css/style.css")
block styles

if (modernizr)
	script(src="js/vendor/modernizr-2.6.2.min.js")

if (webfonts)
	script(src="//ajax.googleapis.com/ajax/libs/webfont/1.5.6/webfont.js")
EOF


# htmlBody.jade content
cat <<EOF >> src/_jade/_layout/htmlBody.jade
<!--[if lt IE 7]>
p.browsehappy You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.
<![endif]-->


//- .wrap- provides full viewport background
//- #site- is to provide the section boundary size-wise
//- #site- can be used with media-queries for responsive resizing of boundary
.wrap-header: header#site-header
	include siteHeader


.wrap-body: main#site-body
	include siteBody


.wrap-footer: footer#site-footer
	include siteFooter


//- Site Scripts
if (jQuery || jQueryMobile || jQueryUI)
	script(src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js")
	script.
		window.jQuery || document.write('<script src="js/vendor/jquery-2.1.1.min.js"><\/script>')


if (jQueryMobile)
	script(src="//ajax.googleapis.com/ajax/libs/jquerymobile/1.4.3/jquery.mobile.min.js")


if (jQueryUI)
	script(src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js")


if (threeJS)
	script(src="//ajax.googleapis.com/ajax/libs/threejs/r69/three.min.js")


//- Google Analytics: change UA-XXXXX-X to be your site's ID.
//- This will load, but only if you include an actual ID
if (site.googleID && site.googleID != 'UA-XXXXX-X')
	script.
		(function(b,o,i,l,e,r){b.GoogleAnalyticsObject=l;b[l]||(b[l]=
		function(){(b[l].q=b[l].q||[]).push(arguments)});b[l].l=+new Date;
		e=o.createElement(i);r=o.getElementsByTagName(i)[0];
		e.src='//www.google-analytics.com/analytics.js';
		r.parentNode.insertBefore(e,r)}(window,document,'script','ga'));
		ga('create','#{site.googleID}');ga('send','pageview');


//- Add scripts here
block scripts


script(src="_js/script.js")
EOF


# siteHeader.jade content
cat <<EOF >> src/_jade/_layout/siteHeader.jade
block site-header
	//- default site header
	.logo
	nav
	.call-to-action
EOF


# siteBody.jade content
cat <<EOF >> src/_jade/_layout/siteBody.jade
block site-body
	//- default site body
EOF


# siteFooter.jade content
cat <<EOF >> src/_jade/_layout/siteFooter.jade
block site-footer
	//- default site footer
EOF
}



function gp.starterStyle {
# style.styl Content
cat <<EOF >> src/_stylus/style.styl
@import 'axis'
@import 'rupture'
@import 'typographic'

// Grid systems (use one), see https://github.com/corysimmons for descriptions
// @import 'jeet' // stylus plugin for grids (> IE 7) 
@import 'elf' // stylus plugin for grids (> IE 9)
// @import 'dragon' // elf => but with one mixin call

*
	padding: 0
	margin: 0
	border: 0
	box-sizing: border-box
	max-width: 100%

// edit() // for debugging jeet
debug() // for debugging elf

EOF
}



function gp.googleAnalytics {
cat <<EOF >> src/_js/analytics.js
// Google Analytics: change UA-XXXXX-X to be your site's ID.
var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
	(function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
g.src=('https:'==location.protocol?'//ssl':'//www')+'.google-analytics.com/ga.js';
s.parentNode.insertBefore(g,s)}(document,'script'));
EOF
}