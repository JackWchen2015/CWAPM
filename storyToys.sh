#!/bin/bash

cd $(dirname $0)

pod package CWAPM.podspec  --force --embedded
