
create_file() {
	touch "$1"
}

export_text() {
	echo "$1" | sed -e 's/\n/\n/g' -e 's/\t/\t\g'
}

# appends the given arguments to a file (given in arg1) and the last arg will
# be treated specially (tabs, newlines will be modified)
append_file() {
	file=$1
	message=$2
	echo "$message" >> "$file"
}
