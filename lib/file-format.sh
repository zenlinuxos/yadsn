# Files use a CSV-like format with one entry per line and tab separators.

create_file() {
	touch "$1"
}

export_text() {
	# Because we want each record in one line, the standard CSV file
	# format does not fit.
	echo "$1" | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/<NEWLINE>/g' \
			  | sed 's/"/""/g'
}

import_text() {
	echo "$1" | sed 's/<NEWLINE>/\n/g' \
			  | sed 's/""/"/g'
}

append_file() {
	file="$1"
	shift
	line=
	for field in "$@"; do
		line="${line},\"$(export_text "$field")\""
	done
	# Remove first comma character and append to file
	echo "$line" | sed 's/^,//' >> "$file"
}
