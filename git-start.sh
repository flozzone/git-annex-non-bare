#!/bin/bash

#
# Prevents the user to delete annexed data
#

# for dropkey and fail
if $(echo ${SSH_ORIGINAL_COMMAND} | grep -q dropkey) ; then
	echo 1>&2 "Deleting data from annexed files is not allowed on this server dude."
	exit 1
fi

eval "${SSH_ORIGINAL_COMMAND}"
