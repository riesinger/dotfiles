#!/bin/bash

echo "| iconName=utilities-terminal-symbolic"
echo "---"

serverlist="$(cat $HOME/.ssh/config | grep 'Host ' | sed -e 's/Host //')"
for host in $serverlist; do
	echo "$host | bash='source .zshrc >/dev/null 2>&1 && ssh $host' terminal=true"
done
