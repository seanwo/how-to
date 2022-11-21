## Setup MergerFS

A way to merge drive space together into a pool.

source: https://github.com/trapexit/mergerfs  

OMV6 GUI:

Storage>File Systems>Mount
* File system: ```/dev/sd?1```
* Usage Warning Threshold: 85%
* Comment:

_Repeat for each data drive_

CLI:

```console
cd /srv/dev-disk-by-uuid-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/
sudo mkdir mergerfs-pool1
```
_Repeat for each data drive_

OMV6 GUI:

System>Plugins>Search>openmediavault-mergerfs>Install

Storage>mergerfs>Create
* Name: mergerfs-pool1
* Filesystems:
* Shared folders:
* Paths:
  * /srv/dev-disk-by-uuid-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx1/mergerfs-pool1/ (data drive 1)
  * ...
  * /srv/dev-disk-by-uuid-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxn/mergerfs-pool1/ (data drive n)
* Create policy: Existing path - most free space
* Minimum free space: 4
* Unit: Gigabytes
* Options: defaults,allow_other,cache.files=partial,use_ino,dropcacheonclose=true
