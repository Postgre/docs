#!/bin/bash

jps -lm | grep $1 | cut -d" " -f1 | xargs kill -9; rm ./$1/$1.persistence -rf ; ./run.sh $1
