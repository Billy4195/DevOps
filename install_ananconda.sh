#!/bin/bash

GREEN="\033[0;31m"
GREEN="\033[0;32m"
NC="\033[0;0m"

function setup {
	echo -e "${GREEN}Set up environment for user '$1' ${NC}"
	sudo su - $1 -c "rsync /home/billy4195/create_env.sh ~/"
	sudo su - $1 -c "rsync /home/billy4195/Anaconda3-5.3.0-Linux-x86_64.sh ~/"
	echo -e "${GREEN}0. install anaconda${NC}"
	sudo su - $1 -c "bash Anaconda3-5.3.0-Linux-x86_64.sh -b"
	echo -e "${GREEN}Setup conda.sh into ~/.profile${NC}"
	if sudo su - $1 -c "grep -q '. ~/anaconda3/etc/profile.d/conda.sh' ~/.profile" 
	then
		: #already exists do nothing
	else
		sudo su - $1 -c "echo '. ~/anaconda3/etc/profile.d/conda.sh' >> ~/.profile"
	fi
	sudo su - $1 -c "source ~/.bashrc"
	sudo su - $1 -c "./create_env.sh test_env"
	sudo su - $1 -c "conda env remove -n test_env -y"
}

if [ -f $1 ]
then
	while read -r line
	do
		setup $line
	done <$1
else
	setup $1
fi

