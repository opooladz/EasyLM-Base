#!/bin/bash

gcloud auth application-default login
mkdir "$HOME/bucket"
gcsfuse caltech-bucket  --implicit-dirs "$HOME/bucket"
