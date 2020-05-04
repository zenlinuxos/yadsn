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

.PHONY: test linter all

TS_VERSION=2.0.3
TS_URL=https://github.com/thinkerbot/ts/archive/v$(TS_VERSION).tar.gz
TS_CMD=tests/ts


all: linter test

$(TS_CMD):
	@echo "Installing ts tool in bin/ts ..."
	@wget -q -O - $(TS_URL) | tar Ozxf - ts-$(TS_VERSION)/bin/ts > $(TS_CMD)
	@chmod +x $(TS_CMD)

test: $(TS_CMD)
	@echo "Running tests..."
	$(TS_CMD) tests/test-*

linter:
	@echo "Running linter..."
	@shellcheck -x -s sh tests/test-* yadsn
