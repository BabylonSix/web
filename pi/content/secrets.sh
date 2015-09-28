# Create Password + Server Info File
# serverport 22 is for SFTP
# serverhost defaulting to Media Temple
# remotepath defaulting to Media Temple
cat <<EOF >> ./secrets.json
{
	"servers": {
		"production": {

			"username":    "your-username",
			"password":    "your-password",

			"serverport":  22,

			"serverhost":  "s209445.gridserver.com",

			"remotepath":  "./domains/YourDomainName.com/html"
		}
	}
}

EOF
