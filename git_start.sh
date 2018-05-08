#!/bin/sh

# Config git user defaults
REPO_PATH=$(git rev-parse --show-toplevel);
if [ -f ${REPO_PATH}/.secret_env ]; then

	source ${REPO_PATH}/.secret_env
	git config --local core.commentChar $GIT_COMMENT;
	git config --global user.email $USER_EMAIL;
	git config --global user.name "${USER_NAME}";


	# Cheching for ssh keys
	if [ -f $HOME/.ssh/id_rsa ]; then
		GIT_PROTOCOL='git@github.com:';
	else
		GIT_PROTOCOL='https://github.com/';
	fi
	# TO-DO: refactoring this to env var will be more flexible. Example at DulceReleaseGenerator
	cd $WORKSPACE && \
	git clone ${GIT_PROTOCOL}interlegis/sapl.git --branch master --single-branch;
	cd sapl;
	git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
	cd $WORKSPACE && \
	git clone ${GIT_PROTOCOL}fga-gpp-mds/2018.1-Dulce_App.git --branch master --single-branch;
	cd 2018.1-Dulce_App;
	git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
	cd $WORKSPACE && \
	git clone ${GIT_PROTOCOL}fga-gpp-mds/2018.1-Dulce_API.git --branch master --single-branch;
	cd 2018.1-Dulce_API;
	git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
	cd $WORKSPACE;
fi