## Setup SnapRAID

SnapRAID is a backup program for disk arrays. It stores parity information of your data and it recovers from up to six disk failures.  
SnapRAID is mainly targeted for a home media center, with a lot of big files that rarely change.

source: http://www.snapraid.it/manual  
source: https://forum.openmediavault.org/index.php?thread/5553-snapraid-plugin-guide/  
source: https://forum.openmediavault.org/index.php?thread/41290-omv6-mergerfs-how-to-properly-use-mergerfs-to-pool-drives/

OMV6 GUI:

System>Plugins>Search>openmediavault-snapraid>Install

Services>SnapRAID>Drives>Create

Your largest drive needs to be the parity drive.

* Drive: /dev/sd?#
* Name: parity
* Content: :x:
* Data: :x:
* Parity: :white_check_mark:

Services>SnapRAID>Drives>Create

All other drives can be data drives.

* Drive: /dev/sd?#
* Name: parity
* Content: :white_check_mark:
* Data: :white_check_mark:
* Parity: :x:

_Repeat for all data drives_

Services>SnapRAID>Drives>Tools>Sync

This intializes the SnapRAID.

Services>SnapRAID>Settings>Scheduled Diff

* Enabled: :white_check_mark:
* Time of execution: Certain date
* Minute: 5
* Hour: 5
* Day of month: *
* Month: *
* Day of week: *
* Send command output via email: :white_check_mark:
