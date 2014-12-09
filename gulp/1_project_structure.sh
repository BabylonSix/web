function gp.structure {
# build structure
d build
d build/dev
d build/pro

#developer strucuture
d build/dev/_css
d build/dev/_img
d build/dev/_js

#production strucuture
d build/pro/_css
d build/pro/_img
d build/pro/_js

# src structure
d src
d src/_jade
d src/_jade/_components
d src/_jade/_layout
d src/_jade/_pages
d src/_jade/_settings
d src/_stylus
d src/_js
d src/_coffee
d src/_assets
d src/_assets/png
d src/_assets/jpg
d src/_assets/svg
}


function gp.starterFiles {
# create empty starter files
f src/_jade/index.jade
f src/_jade/_components/banners.jade
f src/_jade/_components/forms.jade
f src/_jade/_components/gallery.jade
f src/_jade/_components/media.jade
f src/_jade/_components/nav.jade
f src/_jade/_components/posts.jade
f src/_jade/_layout/base.jade
f src/_jade/_layout/htmlHead.jade
f src/_jade/_layout/htmlBody.jade
f src/_jade/_layout/siteHeader.jade
f src/_jade/_layout/siteBody.jade
f src/_jade/_layout/siteFooter.jade
f src/_jade/_settings/config.jade
f src/_js/script.js
f src/_stylus/style.styl
}