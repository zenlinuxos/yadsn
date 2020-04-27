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
	@shellcheck -x -s sh tests/test-* sn
