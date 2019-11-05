DUNDB="$DUNBASE/db/repos.db"

sqlite_binary() {
	ls /usr/bin/sqlite* | head -n 1
}

db_initialize() {
	if [  ! -f "$DUNDB" ]; then
		printf "Initializing database..."
		$(sqlite_binary) $DUNDB 'CREATE TABLE repos(reponame text, folder text, port text, status text);'
		printf "done\n"
	fi
}

db_repo_name_add() {
	REPONAME="$1"
	REPOFOLDER="$2"
	REPOPORT="$3"

	$(sqlite_binary) $DUNDB "INSERT INTO repos VALUES ('"$REPONAME"','"$REPOFOLDER"','"$REPOPORT"','"DOWN"');"
}

db_repo_name_del() {
	REPONAME="$1"

	$(sqlite_binary) $DUNDB "DELETE FROM repos WHERE reponame='"$REPONAME"';"
}

db_repo_name_exist() {
	REPONAME="$1"

	RESULT="$($(sqlite_binary) $DUNDB "SELECT * FROM repos WHERE reponame='"$REPONAME"';")"

	echo ${#RESULT}
}

db_repo_name_list() {
	$(sqlite_binary) $DUNDB 'SELECT * FROM repos' | awk 'BEGIN { FS="|"; printf "%-25s %-70s %-12s %-8s\n","RepoName","RepoFolder","RepoPort","Status" } { printf "%-25s %-70s %-12s %-8s\n",$1, $2, $3, $4 }'

}


