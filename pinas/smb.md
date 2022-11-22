## Setup Windows SMB

Adding Windows SMB sharing support to your NAS.

This example sets up a SMB share called ```movies``` that is accessible by the ```mediauser``` account.

OMV6 GUI:

Services>SMB/CIFS/Settings
* Enabled: :white_check_mark:
* Workgroup: WORKGROUP
* Description: %h server
* Time server: :x:

Services>SMB/CIFS/Settings>Home directories
* Enabled: :x:
* Browsable: :white_check_mark:
* Enable recycle bin: :x:

Services>SMB/CIFS/Settings>WINS
* Enable WINS server :x:

Services>SMB/CIFS/Settings>Advanced settings
* Use sendfile: :white_check_mark:
* Asynchronous I/O: :white_check_mark:
* Extra options: min receivefile size = 16384
* Extra options: getwd cache = yes

Services>SMB>CIFS>Shares>Create
* Enabled: :white_check_mark:
* Shared Folder: ```share```
* Comment:
* Public: No
* Read-only: :x:
* Browsable: :white_check_mark:
* Time Machine support: :x:
* Inherit ACLS: :x:
* Inherit permissions: :x:
* Enable recycle bin: :x:
* Maximum files size: Unrestricted
* Retention time: 0
* Hide dot files: :white_check_mark:
* Extended attributes: :x:
* Store DOS attributes: :x:
* Hosts allow:
* Hosts deny:
* Audit file operations: :x:
* Extra options: vfs objects = 

The ```vfs objects =``` extra option is only needed if you have a time machine share enabled.  
This is workaround for a bug between the intergration of MacOS and OMV.  

_Repeat media shared folder_
