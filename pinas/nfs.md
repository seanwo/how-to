## Setup NFS

Adding NFS sharing support to your NAS.

OMV6 GUI:

Services>NFS>Settings
* Enabled: :white_check_mark:

Services>NFS>Shares>Create
* Shared folder: ```share```
* Client: ```192.168.###.###/24```
* Prviledge: Read/Write
* Extra options: subtree_check,insecure,all_squash,anonuid=2001,anongid=100

Where uid=2001 is the mediauser and gid=100 is the users group.

_Repeat for each media shared folder_
