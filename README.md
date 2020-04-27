# sn (social-network)

sn (social-network) is a Git-based decentralized social network written in shell. It should run on any POSIX shells.

## Installation

## Usage
```
sn [-n network] [-u username] command [arguments]

Options:

	-n: network name where the command will apply.
		Default: If there's only one network, that will be used.
				 Otherwise, the variable 'default_network' in
				 your config file will be used.
	-u: username
		Default: Defined per network in the config file.

where 'command' can be:

create - create a new local network
members - show all members in the network
post [<message>] - post a message to a network (default network: see -n)
log - show all messages ordered as a timeline (newest on top)

```
## TODO
- [ ] add a partial SHA256 id  to identify each message... so that we can refere to them even if lines change

### Options
- [ ] add -u to specify a given username to use in a command, default to the one in the config file or $USER if no other was provided.

### create
- [ ] prompt user for what username they would like to use in this network (default to current $USER value).

### log
- [ ] add option to use default pager

Requirements:
- One per line
- Date should be printed in local time
- A way to refer to each message, in order to view it fully, should be provided.

## Software design
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

### Network creation and join
- what if I create a sn and then join another with the same name?
	- sn create name (check only ascii chars, force one argument, try mkdir fail if not)
	- sn join name
		- if it already exists, just add it as remote and try to pull changes rebasing
- what if I create a sn and then join another with a different name?
- It's a must to be able to work locally, without a connection. This means you have to be able to create a local network (aka, git repository).

### Config file
network_name_username=...
network_name_signing_key=...

### File format
- We could use Git's own message facilities, but then it wouldn't be easy to edit your own messages... which in fact could be a interesting feature, though. I think it makes sense that you can edit your messages easily...
- Each user file could be seen as a user log, where all it's actions appear, including likes, replies, etc. This allows to easily sign it, back it up, etc. Although, because we're using Git, this log is implicitly available... We could have a different file for each type of data.
```
network/
	user1/
		posts
		replies
		likes
		follows
```
- Dates (Does it make sense that dates are in the text files? I mean, they're in Git too).
```
	# Print UTC time in ISO-8601 format
	$ date -uIs		# run at 16:19 (I'm UTC+2)
	2020-04-22T14:19:17+00:00
	$ date --rfc-3339=seconds

	$ git annotate
	6e3d7e74        (David Alfonso  2020-04-22 19:36:35 +0200
	1)[2020-04-22T19:36:35+02:00]Un mensaje de prueba super chulo
```
- Delete posts or replies with an empty line.

- Each line represents the id of the posts/reply? This seems too fragile to me, maybe an improvement would be to use a partial hash...

- posts candidate format (csv with \t as delimiter)
```
La primera linea y si hay mas pues implemente pongo \n que luego se traducen y listo. Si quisiera escribir \\n literal, pues simplemente hay que traducir antes y despues. Lo importante es que lo del principio es facilmente parseable.

La primera linea (siempre una linea en blanco entre mensajes)
```
- replies candidate format (use a kind of csv with \t delimiters)
```
reply-id	user-1	post-2	Una respuesta larga usando \n para multiples lineas, ya se que no va a haber nada mas aqui.
reply-id	user-2	post-4	Una respuesta corta.
```
- likes candidate format (one like per line, separate with \t)
```
user-2	post-4
user-1	post-1
```
- follows candidate format (one per line, only follows, not unfollows, that's in Git).
```
user-2
user-1
```
## Future improvements
- Artificial data generator
- Terminal video showing how the network works
- each user could post to its own file (no conflicts with other users, just append)
- post id = commit id? alternative postid per user
- **sn reply**
- **sn log** should probably limit the size shown, and refer to sn show if you want to see the whole message... probably using git log, filtering and selectiing what data to show.
- sign each message... or the username file, to verify you're the only one who can write in the username file.
- **sn edit**: a command to edit one of your messages.
- **sn merge**: merge two networks.
