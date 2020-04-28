data_dir() {
	echo "$SN_DATA"
}

config_file() {
	echo "$(data_dir)/config"
}

posts_file() {
	echo posts
}

likes_file() {
	echo likes
}

network_dir() {
	echo "$(data_dir)/$1"
}
