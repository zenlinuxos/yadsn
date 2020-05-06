# yadsn (yet another distributed social network)
![CI](https://github.com/davidag/yadsn/workflows/CI/badge.svg) ![GitHub](https://img.shields.io/github/license/davidag/yadsn)

yadsn (yet another distributed social network) is a Git-based decentralized social network written in the shell command language. It should run on any POSIX shells. It is alpha-status software and so it should not be used with data that matters to you in any possible way.

It has the following features:

* Command-line application written in pure shell.
* It can be used without being connected to the Internet.
* Social networks as Git repositories.

## Installation

### For users

1. Supposing `~/bin` is in your `$PATH`, download the `yadsn` script on it using e.g. `wget`:
```
wget -O ~/bin/yadsn https://github.com/davidag/yadsn/raw/master/yadsn
chmod +x ~/bin/yadsn
```
2. Follow the quick tutorial or read all possible commands.

### For development

1. Clone this repository: `git clone https://github.com/davidag/yadsn.git`
2. Enter local copy: `cd yadsn`
3. Create feature branch: `git checkout -b my-feature`
4. Verify tests pass: `make`
5. Code your feature
6. Verify tests pass: `make`
7. Push feature branch and submit PR: `git push`

### Portability and testing

`yadsn` has been only tested on Linux, but it should work on any other *Nix-like system, possibly including Cygwin on Windows.

### Requirements

For users:

* `git` is required for basic operation.
* GNU programs: `find`, `grep`, `awk`, `sed`, `wc`, `xargs`, `mktemp`.

For yadsn development:

* `wget` is used to download the `ts` shell testing utility in the `test/` directory.
	* [ts](https://github.com/thinkerbot/ts) (test script), a test framework for testing shell scripts (POSIX-only).

## Quick tutorial
You can create a local network...
```
$ yadsn create team-network
```
...and post any messages you want using the `post` command:
```
$ yadsn post "I've found this interesting tool for command-line communication, it's called yadsn."
```
You could as well use your default editor
```
$ yadsn post
```
When you decide you want to share your network, you can associate a remote repository to it:
```
# Supposing you have created a Gitlab repository named team-network
$ yadsn remote git@gitlab.com:yourusername/team-network.git
```
Now push your changes:
```
# Using the -u flag is optional if you only have one network configured
$ yadsn -u team-network push
```
To see your timeline of messages you can pull and log:
```
$ yadsn pull
$ yadsn log
```
Other people who want to participate in this network could directly join to it:
```
# This automatically uses "team-network" as the local name
$ yadsn join git@gitlab.com:yourusername/team-network.git
```

## Usage

### Configuration

yadsn saves all network and configuration data in a directory defined in the `$YADSN_DATA` shell variable. By default, this directory corresponds to: `~/.yadsn`

yadsn uses a INI-like configuration file which resides in `$YADSN_DATA/config` and can contain the following variables:

* `networkname_username`: When a user creates or joins a network, a new entry of this type is added. The default username is `$USER`.

* `default_time_format`: Defines the time format to use when displaying dates. See `date` command for reference. Default value: "%b %d %R".

### Commands

```
Usage: yadsn [global-options] <command>

Global options

	-n network-name: If not provided, and there is only one network in the
		data directory, this is automatically selected. If there is more than
		one, the variable 'default_network' from the config file is used.

	-u username: The username to use when executing the command. If none is
		provided, the variable '<network-name>_username' from the config file is
		used (see -n for how <network-name> is selected).

Commands

	create <network-name>
		Create a new local network. -n does not apply, but -u can be used to
		define what username to use by default in that network.

	join <git-url> [<network-name>]
		Joins a remote network identified by a Git URL. If <network-name> is
		provided, it will be usually to identify the network locally.
		Otherwise, the network name is deduced from the URL.

	push
		Push locally made changes to the remote Git repository. This command
		is only valid if the network was created using the 'join' command.

	pull
		Pull remote changes into local network repository. It tries to rebase
		your changes on top of any other change in the remote repository. It
		fails in case of conflict.

	members
		Shows a list of users in the network.

	log
		Show posts, most recent first. Only the first line of each message is
		shown, with an ellipsis representing messages with more than one line.

	post [<message>]
		Post a message in a network. No quotation necessary. If no text is
		provided the default editor is used to input the message.

	show <message-id>
		Shows a message along all its associated information. The message id
		can be obtained with the 'log' command.

	like <message-id>
		Like a message. The message id can be obtained with the 'log' command.
```

## Software design

### Network repository

There is one Git repository per social network you have created or joined to. Each network has its own sub-directory in the `$YADSN_DATA` directory.

```
network/
	user1/
		posts
		replies
		likes
		follows
```

### File format

All network-related files follow the CSV standard defined in RFC... except for newlines, which are translated to <NEWLINE> in the files and converted back when printed in the terminal.

## TODO

- Cryptographic user identification and data signing
- Integrity checks on push
- Performance tests and optimizations
- Colored output
- Automatic conflict handling on pull
- Replies and follows
- Network merging
- Message deletion and edition

## License

Copyright (C) David Alfonso

All code is licensed under the GPL-3.0-or-later.
