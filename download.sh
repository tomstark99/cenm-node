#!/bin/bash

download () {
	curl --progress-bar -u $1:$2 -O https://software.r3.com/artifactory/r3-corda-releases/com/r3/corda/corda/$3/corda-$3.jar || echo "Corda version ${3} not found."
	curl --progress-bar -u $1:$2 -O https://software.r3.com/artifactory/r3-corda-releases/com/r3/corda/corda-shell/$3/corda-shell-$3.jar || echo "Corda shell version ${3} not found."
	mv ./corda-shell-$3.jar ./drivers/
}

print_usage () {
cat << EOL
Dowload your Corda jar with:
  ./dowload.sh -u <first>.<last>@r3.com -p <api_key> -v <corda_version>
EOL
}

USERNAME=
PASSWORD=
VERSION=

while getopts 'u:p:v:' flag
do
	case "${flag}" in
		u)
            USERNAME=${OPTARG};;
		p) 
			PASSWORD=${OPTARG};;
		v)
			VERSION=${OPTARG};;
		*)
			print_usage
			exit;;
	esac
done

if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ] || [ -z "$VERSION" ]; then
	print_usage
	exit
fi

echo "Downloading Corda v${VERSION}"

download "$USERNAME" "$PASSWORD" "$VERSION"
