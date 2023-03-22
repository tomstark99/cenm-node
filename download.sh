download () {
	wget --user $1 --password $2 https://software.r3.com/artifactory/corda-releases/net/corda/corda/$3/corda-$3.jar || echo "Corda version ${3} not found."
}

print_usage () {
cat << EOF
Dowload your corda jar with:

	./dowload.sh -u <first>.<last>@<company>.com -p <api_key> -v <corda_version>
EOF
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

download "$USERNAME" "$PASSWORD" "$VERSION"
