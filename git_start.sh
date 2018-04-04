#!/bin/sh

# Config git user defaults
REPO_PATH=$(git rev-parse --show-toplevel);
source REPO_PATH/.secret_env
git config --local core.commentChar $GIT_COMMENT;
git config --global user.email $USER_EMAIL;
git config --global user.name "${USER_NAME}";


# Cheching for ssh keys
if [ -f $HOME/.ssh/id_rsa ]; then
	GIT_PROTOCOL='git@github.com:';
else
	GIT_PROTOCOL='https://github.com/';
fi

cd $WORKSPACE && \
git clone ${GIT_PROTOCOL}interlegis/sapl.git --branch master --single-branch;
git clone ${GIT_PROTOCOL}fga-gpp-mds/agr-react-native.git --branch master --single-branch;
git clone ${GIT_PROTOCOL}fga-gpp-mds/agr-gic-api.git --branch master --single-branch;