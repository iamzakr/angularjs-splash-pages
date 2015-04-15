#!/usr/bin/env bash

set -e

git config --global user.email "simon@polkaspots.com"
git config --global user.name "Simon Morley"

echo "Host heroku.com" >> ~/.ssh/config
echo "   StrictHostKeyChecking no" >> ~/.ssh/config
echo "   CheckHostIP no" >> ~/.ssh/config;
echo "   UserKnownHostsFile=/dev/null" >> ~/.ssh/config;

if [[ $TRAVIS_PULL_REQUEST == "false" && ($TRAVIS_BRANCH == "master" || $TRAVIS_BRANCH == "staging") ]]
  then
    gem install heroku
    heroku keys:clear
    rm -rf /home/travis/.ssh/id_rsa
    echo yes | heroku keys:add
    grunt build
    echo yes | grunt buildcontrol:heroku
    heroku keys:clear
fi
if [[ $TRAVIS_PULL_REQUEST == "false" ]]
  then
    echo $TRAVIS_BRANCH
fi
echo
echo "...done."
