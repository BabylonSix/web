function gp.SublimeProject {
cat <<EOF >> $1.sublime-project
{
	"folders":
	[
		{
			"follow_symlinks": true,
			"path": ".",
			"folder_exclude_patterns": ["node_modules"],
			"file_exclude_patterns": [".gitignore", "*.sublime-project"]
		}
	]
}
EOF
}

function gp.firstGitCommit {
git init
git add .
git commit -m "$1 Created"
}