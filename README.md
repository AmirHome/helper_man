# Helper Commands for deploy

## Installation
Append this function to ~/.bashrc

```sh
# Helper path 
function helper () {

    cmd=$1
    if [ -z $cmd ]
    then
	printf "docker_clean        | hard, soft, view consist Containers, Network, Volumes without Images\r\n"
	printf "git_ftp             | Upload modify files to remote dir\r\n"
	printf "git_copy            | Copy modify files to .._admin\r\n"
	printf "git_tag             | Git Tag from commit Id or Head\r\n"
	printf "php_ver             | Chean php version\r\n"
	printf "vhost               | Set vhost with name[.loc] on [/var/www/vhosts/]Path\r\n"

    else
    
    shift
    
    bash /home/amir/Dropbox/Helper/$cmd.sh "$@"
    fi
}


```

## Commands
For example

```sh
helper git_tag
```

| Comand | README |
| ------ | ------ |
|docker_clean        | hard, soft, view consist Containers, Network, Volumes without Images|
|git_copy            | Copy modify files to .._admin|
|git_tag             | Git Tag from commit Id or Head|
|php_ver             | Chean php version|
|vhost               | Set vhost with [.loc] on|

## License

MIT

**Free Software, Amir Hosseinzadeh!**

