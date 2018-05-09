#!/bin/sh

# Config git user defaults
REPO_PATH=$(git rev-parse --show-toplevel);
if [ -f ${REPO_PATH}/.secret_env ]; then
	source ${REPO_PATH}/.secret_env
	git config --global core.commentChar $GIT_COMMENT;
	git config --global user.email $USER_EMAIL;
	git config --global user.name "${USER_NAME}";
	git config --global credential.helper store
fi
if [ -z $WORKSPACE ]; then
	echo "setting workspace to $PWD"
	WORKSPACE=$PWD
else
	echo "Workspace set to $WORKSPACE"
fi

if [ ! -z "$(env | grep REPOSITORY_ )" ]; then
	echo -e "${CYAN}Getting repos from repos.txt${NC}"
	repos=($(echo $(cat repos.txt)))

	# Cheching for ssh keys
	if [ -f $HOME/.ssh/id_rsa ]; then
		GIT_PROTOCOL='git@github.com:';
	else
		GIT_PROTOCOL='https://github.com/';
	fi
	# TO-DO: refactoring this to env var will be more flexible. Example at DulceReleaseGenerator
	cd $WORKSPACE && \
	repos=($(env | grep REPOSITORY_ | cut -f 2 -d '='))
	for CURRENT_REPOSITORY in ${repos[@]}; do
		echo "Repo:::: $CURRENT_REPOSITORY ::::"
		ORIGIN=$(echo $CURRENT_REPOSITORY | cut -f 1 -d '/')
		CURRENT_REPOSITORY=$(echo $CURRENT_REPOSITORY | cut -f 2 -d '/')
		echo -e "${LIGHT_PURPLE}Checking for repository $CURRENT_REPOSITORY...${NC}"
		if [ ! -d "$CURRENT_REPOSITORY" ]; then
			echo -e "${ORANGE}Cloning repository...${NC}"
			git clone https://github.com/$ORIGIN/$CURRENT_REPOSITORY.git  --branch master --single-branch
			if [ ! -d "$CURRENT_REPOSITORY" ]; then
				echo -e "${RED}Failed to clone repository...${NC}"
				exit 1
			fi
		fi
		cd $CURRENT_REPOSITORY && \
		git config credential.helper store
		git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
		cd $WORKSPACE
	done
else
	echo "No repository set in env variable..."
	exit 1
fi
