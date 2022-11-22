## Setup NFS

Adding NFS sharing support to your NAS.

This example sets up a NFS share called ```movies``` that will map all user ids to ```mediauser:users```

OMV6 GUI:

Services>NFS>Settings
* Enabled: :white_check_mark:

Services>NFS>Shares>Create
* Shared folder: ```movies```
* Client: 192.168.###.###/24
* Prviledge: Read/Write
* Extra options: subtree_check,insecure,all_squash,anonuid=2001,anongid=100

_where uid=2001 is the mediauser and gid=100 is the users group_
