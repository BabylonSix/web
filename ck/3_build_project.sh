##########################################################
# 
# Generate a regular web project						
# 
##########################################################

# Creates a project with CodeKit
function web.ck {
# 1 Project Structure
d $1	#create directy user defines
cd $1	#go into that directory
d.web	#create an empty web project


# 2 Project Content
web.ck.makeIndex
web.ck.makeStyle
web.ck.makeScript
web.getAssets  # get fixieJS
web.googleAnalytics


# Add Project to CodeKit
ck .

# Open project in sublime
ot .

}

alias w.c='web.ck'