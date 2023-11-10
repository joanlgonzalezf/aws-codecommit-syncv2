#!/bin/sh

set -ue

RepositoryName="${INPUT_REPOSITORY_NAME}"
AwsRegion="${INPUT_AWS_REGION}"
Branch="${INPUT_BRANCH}"
CodeCommitUrl="https://git-codecommit.${AwsRegion}.amazonaws.com/v1/repos/${RepositoryName}"
git config --global --add safe.directory /github/workspace
git config --global credential.'https://git-codecommit.*.amazonaws.com'.helper !aws codecommit credential-helper $@
git config --global credential.UseHttpPath true
aws sts get-caller-identity --query "Account"
git pull origin ${Branch} --depth 50
#echo "hola mundo"
Directory="pwd"
chmod 777 -R ${Directory}
git remote add sync ${CodeCommitUrl}
git push sync ${Branch} --force
