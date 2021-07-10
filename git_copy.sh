#!bin/bash

REMOTE_DIR="../${PWD##*/}_admin/"

echo 'Starting...'
expected_args=1
e_badargs=65
home_dir=$PWD/
current_time=$(date "+%Y.%m.%d-%H.%M.%S")

#####################################################
echo "           Remote Directory is '$REMOTE_DIR' Is it correct? 'Y'es" 
echo "           Change Path press 'C'" 
echo ""
read -p "Are you sure? " -n 1 -r
if [[ ! $REPLY =~ [CcYy]$ ]]
then
   exit 1
else 
	if [[ $REPLY =~ [Cc]$ ]]
	then
	echo ""
	echo "Enter Remote Dir path such as \"public_html\""
	read REMOTE_DIR
	REMOTE_DIR="../${PWD##*/}_$(basename -- $REMOTE_DIR)/"
	fi
fi



#####################################################
if [ $# -lt $expected_args ]
then
    echo "Error: you should use command $0 from_tag [to_tag]"
    exit $e_badargs
fi

cd $home_dir
to_tag="HEAD@{0}"
if [ ! -z "$2" ]
then
	to_tag="$2"
fi

from_tag="$1"
if [ -z $from_tag ]
then
	echo "Error no from tag"
	exit
fi
echo ""
echo "Will copy changed files from $from_tag to $to_tag"

# get the from commit via tag name
from_tag=`git rev-list $from_tag|head -n 1`

# get the lastest commit via tag name
to_tag=`git rev-list $to_tag|head -n 1`

############################################ Copy Process ####################### 

# get list file delete
IFS=$'\n'
for file_change in `git diff --name-only --diff-filter=D $from_tag $to_tag`
do
	echo "Remove $REMOTE_DIR$file_change ..."

    # remove file
	rm -f $REMOTE_DIR$file_change
done

# get list file changed
count_file=0
IFS=$'\n'
for file_change in `git diff --name-only --diff-filter=d $from_tag $to_tag`
do
	echo "Put $REMOTE_DIR$file_change ..."
	count_file=$((count_file+1))
    # call ftp script to push file via curl
	# bash $home_dir/deploy/ftp.sh $file_change $REMOTE_DIR$file_change

    # Create Directory
	dir=$(dirname "$file_change")

	mkdir -p $REMOTE_DIR$dir
    # copy file
	# TODO: ignore Vendor, composer.js, .env
	cp $file_change $REMOTE_DIR$file_change
done

# if [ $count_file -gt 0 ]
# then

#     # call set tag script to push file
# 	bash $home_dir/deploy/ftp.sh $file_change $REMOTE_DIR$file_change
# fi

echo "DONE $count_file!!!"
