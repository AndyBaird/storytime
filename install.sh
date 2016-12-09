#!/bin/bash

repoFound=$(cat docker/config/service-name.txt)

if [ "$repoFound" == "node-express-base" ]; then

	echo "Repository name: "
	read repoName
	defaultPort=$(cat docker/config/webport.txt)
	echo "Current Port is $defaultPort. Enter port number:"
	read port

	echo "$repoName">docker/config/service-name.txt	
	echo "$port">docker/config/webport.txt
	touch docker/config/token.txt

	rm -rf .git/
	rm README.md
	echo "# $repoName " > README.md
	git init

	repoUrl="https://github.com/madwire-media/"
	repoUrl+=$repoName
	repoUrl+=".git"
	
	repoFound=$(cat docker/config/service-name.txt)
	echo "Repository found: $repoFound"
	echo "Repository url: $repoUrl"
	git add .
	git commit -m "Initial commit for $repoName repository."
	git remote add origin $repoUrl
	git remote -v
	git push -f origin master

else
	echo "New repository already installed.."
fi

