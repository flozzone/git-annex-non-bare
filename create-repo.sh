#!/bin/bash

#
# Creates a repository and links the right git hooks for using git-annex-non-bare server
#

function usage() {
	echo 1>&2 "Usage: create-repo.sh REPO_NAME"
}

function blame() {
	echo 1>&2 "$1"
}

# check params
if [ -z "$1" ]; then
	blame "Specify a repository name."
	usage
	exit 1
fi

repo=$1
path="/home/git/${repo}.git"

# check if no special characters are used
if echo "$repo" | grep -q '[^a-zA-Z0-9\_\-]' ; then
	blame "Don't use any special characters in the repository name"
	usage
	exit 1
fi

# create repo directoy
if ! mkdir "$path" ; then
	blame "Could not create directory for the repository at $path"
	exit 1
fi

# cd into it
if ! pushd "$path" &>/dev/null ;then
	blame "Cannot change into repository folder"
	exit 1
fi

# git init
if ! git init ; then
	blame "Failed to initialize git."
	exit 1
fi

# git annex init
if ! git annex init "server" ; then
	blame "Failed to initialize git annex."
	exit 1
fi

# link hook scripts
if ! ln -s ~/git-annex-non-bare/post-receive .git/hooks/post-receive ; then
	blame "Failed to link post-receive hook."
	exit 1
fi

if ! ln -s ~/git-annex-non-bare/pre-receive .git/hooks/pre-receive ; then
	blame "Failed to link pre-receive hook."
	exit 1
fi

echo "You can now use your repository by running \"git clone git@HOST:${repo}.git\""

popd &>/dev/null

exit 0
