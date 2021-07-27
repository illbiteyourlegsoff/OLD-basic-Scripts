#!/bin/bash


***************************************************
*
*
*
*This Script Prompts user for AD Shortname and then adds it to the Computers JSS Record	
*
*
*
*
*
*
********************************************************


usrnm="$(osascript -e 'Tell application "System Events" to display dialog "Please Input Username" default answer "username"' -e 'text returned of result' 2>/dev/null)"

sudo jamf recon -endUsername $usrnm
