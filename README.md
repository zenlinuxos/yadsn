# sn (social-network)

sn (social-network) is a Git-based decentralized social network written in shell. It should run on any POSIX shells.

## Installation

## Usage

```
sn create <name> - create a new social network named 'name'
```

## TODO
- Username? Same as configured in git?
- Username duplicates? what if you join a social network and there's someone with your name?
	- we could use the e-mail as id, but that's not privacy-friendly.
	- we could ask the user for its name when creating a social network and
	  then the username would be `username@social-network-name`
- repository organization
	- one repo per social network or one repo for all social networks?
		- it's clearly one repo pero social network...
		- this means there must be a way to know on what sn the command applies... sn -s social-network-name (if only one, use that by default).
- what if I create a sn and then join another with the same name?
	- sn create name (check only ascii chars, force one argument, try mkdir fail if not)
	- sn join name
		- if it already exists, just add it as remote and try to pull changes rebasing

## Ideas
- each user could post to its own file (no conflicts with other users, just append)
- post id = commit id
- sn reply
