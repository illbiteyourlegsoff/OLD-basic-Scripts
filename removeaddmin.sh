#!/bin/bash

########Demotes logged in user out of admin group, Needs to be ran in JSS

sudo dscl . delete /Groups/admin GroupMembership $3
