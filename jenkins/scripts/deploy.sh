#!/usr/bin/env sh

set -x
docker run -t -d -u 1000:1000 -v C:/Users/Shanice/Documents/GitHub/jenkins-php-selenium-test/src:/var/jenkins_home/workspace/jenkins-php-selenium-test@2 -w /var/jenkins_home/workspace/jenkins-php-selenium-test@2 -v /var/lib/docker/volumes/jenkins-docker-certs/_data:/certs/client:ro -v /run/desktop/mnt/host/c/Users/Shanice:/home -e DOCKER_HOST=tcp://docker:2376 -e DOCKER_CERT_PATH=/certs/client -e DOCKER_TLS_VERIFY=1 -e JAVA_OPTS=-Dhudson.plugins.git.GitSCM.ALLOW_LOCAL_CHECKOUT=true -e PATH=/opt/java/openjdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin -e LANG=C.UTF-8 -e JENKINS_HOME=/var/jenkins_home -e JENKINS_SLAVE_AGENT_PORT=50000 -e REF=/usr/share/jenkins/ref -e JENKINS_VERSION=2.414.3 -e JENKINS_UC=https://updates.jenkins.io -e JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental -e JENKINS_INCREMENTALS_REPO_MIRROR=https://repo.jenkins-ci.org/incrementals -e COPY_REFERENCE_FILE_LOG=/var/jenkins_home/copy_reference_file.log -e JAVA_HOME=/opt/java/openjdk --name my-jenkins-container myjenkins-blueocean:2.414.3-1

sleep 1
set +x

echo 'Now...'
echo 'Visit http://localhost to see your PHP application in action.'
