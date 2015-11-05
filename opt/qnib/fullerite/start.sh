#!/bin/bash

source /opt/qnib/consul/etc/bash_functions.sh

wait_for_srv carbon

fullerite -c /etc/fullerite/fullerite.conf

