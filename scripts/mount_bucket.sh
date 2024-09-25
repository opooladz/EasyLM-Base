#!/bin/bash

gcloud auth application-default login
mkdir "$HOME/bucket"
gcsfuse jsg-bucket  --implicit-dirs "$HOME/bucket"
