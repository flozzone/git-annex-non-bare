#!/bin/bash

#
# Generates the authorized_keys out of the public keys that are stored within keydir.
#

authfile=/home/git/.ssh/authorized_keys

gitstart="command=\"~/git-annex-non-bare/git-start.sh\",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty"

echo "#################################################" > $authfile
echo "# This file is auto generated by update-users.sh." >> $authfile
echo "# Every manually change will be overwritten when called." >> $authfile
echo "#################################################" >> $authfile

while read file; do
	echo "$gitstart $(cat $file)" >> $authfile
done < <(find keydir -name *.pub)