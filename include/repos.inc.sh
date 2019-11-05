repo_name_start() {
	REPONAME="$1"
	REPOFOLDER=$($(sqlite_binary) $DUNDB "SELECT folder FROM repos WHERE reponame='"$REPONAME"';")
	REPOPORT=$($(sqlite_binary) $DUNDB "SELECT port FROM repos WHERE reponame='"$REPONAME"';")

	printf "Starting repo $REPONAME"

	progressdot_start 0.2
	
	pushd . 2>&1 > /dev/null

	cd $REPOFOLDER
	git instaweb --httpd=$WEBSERVER --port=$REPOPORT 2>&1 > /dev/null
	
	popd 2>&1 > /dev/null

	
	$(sqlite_binary) $DUNDB "UPDATE repos SET status='UP' WHERE reponame='"$REPONAME"';"
	
	progressdot_stop

	printf "done\n"
}

repo_name_stop() {
	REPONAME="$1"
	REPOFOLDER=$($(sqlite_binary) $DUNDB "SELECT folder FROM repos WHERE reponame='"$REPONAME"';")
	
	printf "Stopping repo $REPONAME"

	progressdot_start 0.1

	pushd . 2>&1 > /dev/null
	
	cd $REPOFOLDER
	git instaweb --stop

	popd 2>&1 > /dev/null

	$(sqlite_binary) $DUNDB "UPDATE repos SET status='DOWN' WHERE reponame='"$REPONAME"';"

	progressdot_stop

	printf "done\n"
		
}

repo_name_running() {
	REPONAME="$1"

	RESULT="$(ps -ef | grep $WEBSERVER | grep $REPONAME)"

	echo ${#RESULT}
}

repo_update_status() {
	$(sqlite_binary) $DUNDB "SELECT * FROM repos" | while read line; do
		REPONAME=$(echo $line | awk 'BEGIN { FS="|" } { print $1 }')
		if [ -z "$(ps -ef | grep $WEBSERVER | grep $REPONAME)" ]; then
			$(sqlite_binary) $DUNDB "UPDATE repos SET status='DOWN' WHERE reponame='"$REPONAME"';"
		else
			$(sqlite_binary) $DUNDB "UPDATE repos SET status='UP' WHERE reponame='"$REPONAME"';"
		fi
	done
}
