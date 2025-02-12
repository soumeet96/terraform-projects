#!/bin/bash

git init
git remote add origin https://git-codecommit.us-east1.amazonaws.com/v1/repos/cicd-demo-repo
git add .
git commit -m "Initial commit"
git push -u origin main