.PHONY: test

TS_VERSION=v2.0.3
TS_URL=https://github.com/thinkerbot/ts/archive/$(TS_VERSION).tar.gz
TS_CMD=bin/ts


$(TS_CMD):
	@echo "Installing ts tool in bin/ts ..."
	@wget -q -O - $(TS_URL) | tar Ozxf - ts-2.0.3/bin/ts > $(TS_CMD)
	@chmod +x $(TS_CMD)

test: $(TS_CMD)
	@echo "Running tests..."
	$(TS_CMD) tests/local-workflow
