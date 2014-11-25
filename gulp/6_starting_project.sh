function web.gulp {
# 1. Project Structure
d $1                  # create directy user defines
cd $1                 # go into that directory
gp.structure          # create an empty web project

# 2. Starter Content
gp.starterFiles       # starter index, style, script
gp.starterContent     # starter index.jade content
gp.starterStyle       # starter style.styl content
gp.googleAnalytics		
# 3. GulpJS Setup
gp.SetupFiles         # create package.json and gulpfile.js
gp.SetupPackageJSON   
gp.SetupGulpfileJS    # gulp workflow setup here
gp.SetupGulpfileCOFFEE
gp.GitIgnore          # tell git what to ignore

# 4. NPM Package Import
gp.InstallPlugins     # install gulp plugins

# 5. Extras
gp.SublimeProject $1  # pipe name into the ST3 Project
gp.firstGitCommit $1  # start version control
ot $1.sublime-project # Open project in sublime
gulp                  # Run Gulp
}

alias w.g='web.gulp'