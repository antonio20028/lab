#! /bin/bash
project=$1
touch role-definition.yaml

echo "title: "Role Editor"
description: "Edit access for App Versions"
stage: "ALPHA"
includedPermissions:
- appengine.versions.create
- appengine.versions.delete" > role-definition.yaml

gcloud iam roles create editor --project $project \
--file role-definition.yaml

gcloud iam roles create viewer --project $project \
--title "Role Viewer" --description "Custom role description." \
--permissions compute.instances.get,compute.instances.list --stage ALPHA


touch new-role-definition.yaml

echo "description: Edit access for App Versions
etag: 
includedPermissions:
- appengine.versions.create
- appengine.versions.delete
- storage.buckets.get
- storage.buckets.list
name: projects/$1/roles/editor
stage: ALPHA
title: Role Editor" > new-role-definition.yaml

gcloud iam roles update editor --project $project \
--file new-role-definition.yaml


gcloud iam roles update viewer --project $project \
--add-permissions storage.buckets.get,storage.buckets.list


gcloud iam roles update viewer --project $project \
--stage DISABLED

gcloud iam roles delete viewer --project $project

gcloud iam roles undelete viewer --project $project
