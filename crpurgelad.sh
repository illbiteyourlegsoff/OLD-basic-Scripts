#!/bin/bash
####################################################################################################
#
# Copyright (c) 2015, JAMF Software, LLC.  All rights reserved.
#
#       Redistribution and use in source and binary forms, with or without
#       modification, are permitted provided that the following conditions are met:
#               * Redistributions of source code must retain the above copyright
#                 notice, this list of conditions and the following disclaimer.
#               * Redistributions in binary form must reproduce the above copyright
#                 notice, this list of conditions and the following disclaimer in the
#                 documentation and/or other materials provided with the distribution.
#               * Neither the name of the JAMF Software, LLC nor the
#                 names of its contributors may be used to endorse or promote products
#                 derived from this software without specific prior written permission.
#
#       THIS SOFTWARE IS PROVIDED BY JAMF SOFTWARE, LLC "AS IS" AND ANY
#       EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#       WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#       DISCLAIMED. IN NO EVENT SHALL JAMF SOFTWARE, LLC BE LIABLE FOR ANY
#       DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#       (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#       LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#       ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#       (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#       SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
####################################################################################################
#
#
#
# 
#     script making a launchd that purge RAM if RAM availability is below 3 GB <-- can be changed
#
#   Created by Trey Howell
#    Professional Services JAMF Software
########################################################################################################################################






#!/bin/bash

######makes sure path for executable is there
sudo mkdir -p /usr/local/sbin
sudo chown root:wheel /usr/local/sbin
sudo chmod -R 755 /usr/local/sbin


#######creates script to run
echo "#!/bin/bash


ramun=\`top -l 1 | grep PhysMem: | awk '{print $6}' | sed 's/M//'\`

if [ "\$ramun" -lt "3000" ]
then
sudo purge
else
exit 0
fi" > /usr/local/sbin/purgeRAM.sh

######changes permission of script
sudo chmod 755 /usr/local/sbin/purgeRAM.sh



####################### Creates a Launchd to run every hour and run script
echo "<?xml version="1.0" encoding="UTF-8"?> 
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"> 
<plist version="1.0"> 
<dict>
	<key>Disabled</key>
	<true/>
	<key>Label</key> 
	<string>com.JAMF.checkram</string> 
	<key>ProgramArguments</key> 
	<array> 
		<string>./usr/local/sbin/purgeRAM.sh</string>
	</array>
	<key>StartInterval</key>
	<integer>3600</integer> 
</dict> 
</plist>" > /Library/LaunchDaemons/com.JAMF.checkram.plist
#####

######changes permission of Launchd and activates
sudo chown root:wheel /Library/LaunchDaemons/com.JAMF.checkram.plist
sudo chmod 644 /Library/LaunchDaemons/com.JAMF.checkram.plist
sudo launchctl load -w /Library/LaunchDaemons/com.JAMF.checkram.plist



