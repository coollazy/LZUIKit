#! /bin/bash

BASEDIR=$(dirname $0)

cd $BASEDIR

pod lib lint --verbose --allow-warnings --fail-fast