# Copyright (C) 2020 David Alfonso
#
# This file is part of yadsn.
#
# yadsn is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# yadsn is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with yadsn.  If not, see <https://www.gnu.org/licenses/>.

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

shorten_text() {
	echo "$1" | sed 's/<NEWLINE>.*$/.../g' \
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
