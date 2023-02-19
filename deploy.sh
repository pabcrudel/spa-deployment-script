#!/bin/bash
#
# Script to automate the deploy of vue projects on github pages
#
# --------------------------------------------------------------------
# Author: Pablo Cru
# GitHub: https://github.com/pabcrudel
# --------------------------------------------------------------------

set -e

# Build
npm run build

# Save the latest commit hash as a string
git_log=$(git log)
commit_hash=$(echo $git_log | awk '{print $2}')

# Get GitHub Repository URL
repo_url=$(git remote show origin | grep Push | awk '{print $3}')

# Navigate into the build output directory
cd dist

git init
git add -A
git commit --allow-empty -m "Deploy (commit: $commit_hash)"

branch=$(git rev-parse --abbrev-ref $(git symbolic-ref HEAD))

git push -f $repo_url $branch:gh-pages -v