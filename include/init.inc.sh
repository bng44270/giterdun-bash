progressdot_start() {
	[[ -z "$1" ]] && DELAY="0.5" || DELAY="$1"
	while true; do
		printf "."
		sleep $DELAY
	done &
}

progressdot_stop() {
	PROGRESSPID=$(jobs -l | grep 'while true; do' | awk '{ print $2 }')

	disown
	kill $PROGRESSPID
}


usage() {
	echo "usage:"
	echo "       giterdun.sh <start | stop> <repo-name>"
	echo "       giterdun.sh <start-all | stop-all>"
	echo "       giterdun.sh add <repo-name> <repo-folder> <repo-port>"
	echo "       giterdun.sh del <repo-name>"
	echo "       giterdun.sh list"
	echo "       giterdun.sh update"
}
