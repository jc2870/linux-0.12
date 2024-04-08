#!/bin/bash

gecho() {
	echo -e "\e[32m $1 \e[0m"
}

setup() {
	docker > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		sudo mkdir /etc/docker/
		# setuo proxy
		cat > /etc/docker/daemon.json<< EOF
		{
		    "registry-mirrors": [
			"https://dockerproxy.com",
			"https://docker.m.daocloud.io",
			"https://docker.nju.edu.cn"
		    ]
	    	}
EOF
		# install docker
		curl -sSL https://get.docker.com/ | sudo sh
		gecho "install docker success"
		# docker pull docker image
		docker pull ultraji/ubuntu-xfce-novnc
		gecho "docker pull success"
	fi
}


run() {
	gecho "input http://localhost:6080 in web brower"
	gecho "passwd:123456"
	gecho "USAGE: cd /home/ubuntu/linux012/oslab && ./run.sh -m to compile && ./run.sh -g to debug"

	sleep 1

	sudo docker run -t -i -p 6080:6080 -v `pwd`:/home/ubuntu/linux012 ultraji/ubuntu-xfce-novnc
}

setup
run
