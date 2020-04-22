# sn (social-network)

sn (social-network) is a Git-based decentralized social network written in shell. It should run on any POSIX shells.

## Installation

## Usage

```
sn create <name> - create a new social network named 'name'
```

## TODO
- Username? Same as configured in git? username in the social network you're writing to? (I guess any centralized repository requires some kind of authentication)
- Username duplicates? what if you join a social network and there's someone with your name?
	- we could use the e-mail as id, but that's not privacy-friendly.
	- we could ask the user for its name when creating a social network and
	  then the username would be `username@social-network-name`
- repository organization
	- one repo per social network or one repo for all social networks?
		- it's clearly one repo pero social network...
		- this means there must be a way to know on what sn the command applies... sn -s social-network-name (if only one, use that by default).
- what should make do by default?

### Network creation and join
- what if I create a sn and then join another with the same name?
	- sn create name (check only ascii chars, force one argument, try mkdir fail if not)
	- sn join name
		- if it already exists, just add it as remote and try to pull changes rebasing
- what if I create a sn and then join another with a different name?
- It's a must to be able to work locally, without a connection. This means you have to be able to create a local network (aka, git repository).

## Ideas
- each user could post to its own file (no conflicts with other users, just append)
- post id = commit id? alternative postid per user
- sn reply
- sn log should probably limit the size shown, and refer to sn show if you want to see the whole message... probably using git log, filtering and selectiing what data to show.
