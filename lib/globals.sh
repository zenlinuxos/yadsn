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

data_dir() {
	echo "$YADSN_DATA"
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
