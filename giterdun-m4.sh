#!/bin/bash  

DUNBASE="MAKEDUNBASE"
WEBSERVER="lighttpd"

. $DUNBASE/include/init.inc.sh
. $DUNBASE/include/database.inc.sh
. $DUNBASE/include/repos.inc.sh

db_initialize

case "$1" in
	"start")
		if [ "$(db_repo_name_exist $2)" -gt 0 ]; then
			if [ "$(repo_name_running $2)" -gt 1 ]; then
				echo "Repo $2 already running"
			else
				repo_name_start $2
			fi
		else
			echo "Repo $2 not configured or specified"
		fi
		;;
	"stop")
		if [ "$(repo_name_running $2)" -gt 0 ]; then
			repo_name_stop $2
		else
			echo "Repo $2 not running or specified"
		fi
		;;
	"start-all")
		$0 list | grep -v '^RepoName' | while read line; do
			STATUS=$(echo $line | awk '{ print $4 }')
			REPONAME=$(echo $line | awk '{ print $1 }')
			if [ "$STATUS"=="DOWN" ]; then
				$0 start $REPONAME
			fi
		done
		;;
	"stop-all")
		$0 list | grep -v '^RepoName' | while read line; do
                        STATUS=$(echo $line | awk '{ print $4 }')
                        REPONAME=$(echo $line | awk '{ print $1 }')
                        if [ "$STATUS"=="UP" ]; then
                                $0 stop $REPONAME
                        fi
                done
                ;;
	"add")
		if [ "$(db_repo_name_exist $2)" -eq 0 ]; then
			if [ -n "$2" ] && [ -n "$3" ] && [ -n "$4" ]; then
				db_repo_name_add $2 $3 $4
			else
				echo "Please specify repo name, location, and port"
				usage
			fi
		else
			echo "Repo already exists or not specified"
			usage
		fi
		;;
	"del")
		if [ "$(db_repo_name_exist $2)" -gt 0 ]; then
			db_repo_name_del $2
		else
			echo "Repo does not exist or not specified"
		fi
		;;
	"list")
		db_repo_name_list
		;;
	"update")
		printf "Updating repository status..."
		repo_update_status
		printf "done\n"
		;;
	*)
		usage
		;;
esac
