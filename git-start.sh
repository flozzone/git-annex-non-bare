#!/bin/bash

#
# Prevents the user to delete annexed data
#

# for dropkey and fail
if $(echo ${SSH_ORIGINAL_COMMAND} | grep -q "^git-annex-shell 'dropkey'.*") ; then
	echo 1>&2 ""
	echo 1>&2 "Deleting data from annexed files is not allowed on this server dude."
	echo 1>&2 ""
	exit 1
fi

eval "${SSH_ORIGINAL_COMMAND}"
