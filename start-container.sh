#!/bin/bash

# see https://github.com/jenkinsci/docker
docker run -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins-php/jenkins:1.0
