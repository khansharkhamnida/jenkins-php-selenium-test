#!/usr/bin/env sh

set -x
/var/jenkins_home/workspace/jenkins-php-selenium-test/src:/var/www/html/
sleep 1
set +x

echo 'Now...'
echo 'Visit http://localhost to see your PHP application in action.'
