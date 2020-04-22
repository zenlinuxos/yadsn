# sn (social-network)

sn (social-network) is a Git-based decentralized social network written in shell. It should run on any POSIX shells.

## Installation

## Usage
```
sn [-n network] command [arguments]

Options:

	-n: network name where the command will apply.
		Default: If there's only one network, that will be used.
				 Otherwise, the variable 'default_network' in
				 your config file will be used.

where 'command' can be:

create <name> - create a new social network named 'name'

```

## TODO

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

### Network creation and join

- what if I create a sn and then join another with the same name?
	- sn create name (check only ascii chars, force one argument, try mkdir fail if not)
	- sn join name
		- if it already exists, just add it as remote and try to pull changes rebasing
- what if I create a sn and then join another with a different name?
- It's a must to be able to work locally, without a connection. This means you have to be able to create a local network (aka, git repository).

### log

Requirements:
- One per line
- Date should be printed in local time
- A way to refer to each message, in order to view it fully, should be provided.

### Config file

network_name_username=...
network_name_signing_key=...

### Message file structure
We could use Git's own message facilities, but then it wouldn't be easy to edit your own messages... which in fact could be a interesting feature, though. I think it makes sense that you can edit your messages easily...

	# Print UTC time in ISO-8601 format
	$ date -uIs		# run at 16:19 (I'm UTC+2)
	2020-04-22T14:19:17+00:00
	$ date --rfc-3339=seconds

```
[2020-03-12T12:34:53+02:00] La primera linea

[2020-03-12T12:34:53+02:00] La primera linea (siempre una linea en blanco entre mensajes)
Puede haber mas lineas

por supuesto...

[2020-03-12T12:34:53+02:00] y eso es todo, no tengo nada m'as que decir.
```

## Ideas
- each user could post to its own file (no conflicts with other users, just append)
- post id = commit id? alternative postid per user
- **sn reply**
- **sn log** should probably limit the size shown, and refer to sn show if you want to see the whole message... probably using git log, filtering and selectiing what data to show.
- sign each message... or the username file, to verify you're the only one who can write in the username file.
- **sn edit**: a command to edit one of your messages.
