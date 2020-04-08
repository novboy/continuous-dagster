#!/bin/bash

if [[ -n "$1" ]] && [[ $1 =~ bash  ]] ; then
    "${@}"
    exit $?
fi

touch /etc/crontab /etc/cron.*/*

service cron start

dagster schedule up

dagit -h 0.0.0.0 -p 3000
