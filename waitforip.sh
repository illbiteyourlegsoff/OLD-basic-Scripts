#!/bin/bash
########
#
#this script waill wait for Device to get a ip
#
#########

ip=`ipconfig getifaddr en1`


until [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; do
sleep 5


######script can go here









done
