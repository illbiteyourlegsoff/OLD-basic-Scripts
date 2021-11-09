
#!/bin/bash

##############
#Script for repartition disk to add a restore drive.

############################################################

#########How much free Gigs are needed
freegig="30"

#####size of recovery drive
revdr="16"

#############################################
#
#
#DO not Modify below this line
#
##########################################




#### tells Which disk is the HD on
devdsk=`diskutil info / | grep "Device Node" | awk '{ print $3 }'`
echo $devdsk


###### How many Gigs of Data free
frspce=`df -gH | grep "dev/" | awk '{ print $4 }' | cut -d "G" -f 1`
echo $frspce


########How big is the Hard drive
hdspce=`df -gH | grep "dev/" | awk '{ print $2 }' | cut -d "G" -f 1`
echo $hdspce

#### Equations to see if enough space and what size to make HD####################

##### making sure there is enough free space replace number with how many gigs it should have free
if [ "$frspce" -ge $freegig ]
then
echo "There is enough free space"
else  
  echo "not enough space"		###comment this out later now just for testing
  #####exit 0
fi                    

######the math to take away 15 GB for Restore Partition and variable for command to resize. the -1 is to make up for diff in actual GB size
newhd=`(expr $hdspce - $revdr - 1)`
echo $newhd
echo "test end"

######Resizing the HD this will resize the partition ##############################################################
sudo diskutil resizeVolume $devdsk $newhd"G" HFS+ "Restore" $revdr"G"
