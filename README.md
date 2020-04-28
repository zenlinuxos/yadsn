# sn (social-network)

sn (social-network) is a Git-based decentralized social network written in shell. It should run on any POSIX shells.

## Installation

## Quick tutorial
TODO

## Usage


## Configuration
network_name_username=...
network_name_signing_key=...


## Software design

### File format
All network-related files follow the CSV standard defined in RFC... except for newlines, which are translated to <NEWLINE> in the files and converted back when shown to the user.

### Repository organization
- Each user file could be seen as a user log, where all it's actions appear, including likes, replies, etc. This allows to easily sign it, back it up, etc. Although, because we're using Git, this log is implicitly available... We could have a different file for each type of data.
```
network/
	user1/
		posts
		replies
		likes
		follows
```
- repository organization
	- one repo per social network or one repo for all social networks?
		- it's clearly one repo pero social network...
		- this means there must be a way to know on what sn the command applies... sn -s social-network-name (if only one, use that by default).
- what should make do by default?

### Username
- Username? Same as configured in git? username in the social network you're writing to? (I guess any centralized repository requires some kind of authentication)
	- Username = $USER
- Username duplicates? what if you join a social network and there's someone with your name?
	- we could use the e-mail as id, but that's not privacy-friendly.
	- we could ask the user for its name when creating a social network and
	  then the username would be `username@social-network-name`
	- when you join a network, if there's already a username there, ask the user for another name.
	- if pushing changes and there's a conflict in the username file, this means someone else has posted a message...  (SIGNING)
- [Usernames in LDAP GitHub integration](https://help.github.com/en/enterprise/2.16/admin/user-management/using-ldap#username-considerations-with-ldap)
	- Restricted to alphanumeric and dashes.
- [What characters should I use or not use in usernames on Linux?](https://serverfault.com/questions/73084/what-characters-should-i-use-or-not-use-in-usernames-on-linux)
	- POSIX.1-2008: [a-zA-Z0-9._-]
- Scuttlebutt uses cryptography to resolve the problem of a global name by using your public key as your id. The name is just an alias to your key, and so it's not unique.

### Network creation and join
- what if I create a sn and then join another with the same name?
	- sn create name (check only ascii chars, force one argument, try mkdir fail if not)
	- sn join name
		- if it already exists, just add it as remote and try to pull changes rebasing
- what if I create a sn and then join another with a different name?
- It's a must to be able to work locally, without a connection. This means you have to be able to create a local network (aka, git repository).

## TODO
- create: prompt user for what username they would like to use in this network
	- this would be solved if we used key-based identification
- push: changes to remote social network
- push:pre-push validations to mantain network data integrity
	- force pull if remote has changed
	- allow changes only in the last lines of files
	- one commit per line changed
- pull: retrieve changes from remote social network
- add test-performance using a data generator
	- `get_likes` using grep -r | grep vs current find solution
- add github ci support
	- one example: https://github.com/avaris/pelican/actions/runs/90560727

## Future improvements
- `log`: default to a given number of days to show (eg. 7 days)
- `log`: option to use default pager
- `show`: allow relative message id (-1 = latest message, etc.)
- use colors in the terminal
- each user could post to its own file (no conflicts with other users, just append)
- post id = commit id? alternative postid per user
- **sn reply**: reply to message (also allowing relative id)
- **sn log** should probably limit the size shown, and refer to sn show if you want to see the whole message... probably using git log, filtering and selectiing what data to show.
- sign each message... or the username file, to verify you're the only one who can write in the username file.
- **sn edit**: a command to edit one of your messages.
- **sn delete**: a command to delete one of your messages.
- **sn merge**: merge two networks.
