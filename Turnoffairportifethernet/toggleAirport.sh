#!/bin/sh

######old Script to Detect if had a wired IP ADDRESS, then would turn off Wireless
#### Was made for 10.5 and 10.6
##### Trey Howell
#####Below is the LaunchD to activate this script
##### the Script would go into path /Library/Scripts/toggleAirport.sh



#####<?xml version="1.0" encoding="UTF-8"?>
#####<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
#####<plist version="1.0">
#####<dict>
#####<key>Label</key>
#####<string>com.asb.toggleairport</string>
#####<key>OnDemand</key>
#####<true/>
#####<key>ProgramArguments</key>
#####<array>
#####<string>/Library/Scripts/toggleAirport.sh</string>
#####</array>
#####<key>WatchPaths</key>
#####<array>
#####<string>/Library/Preferences/SystemConfiguration</string>
#####</array>
#####</dict>
#####</plist>



if ifconfig en0 | grep '[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*'   ;
then /usr/sbin/networksetup -setairportpower en1 off
else
/usr/sbin/networksetup -setairportpower en1 on
fi

