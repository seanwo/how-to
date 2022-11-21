## Setup MergerFS

A way to merge drive space together into a pool.

source: https://github.com/trapexit/mergerfs  

CLI:

On each data drive that will be in the pool:
```console
cd /srv/dev-disk-by-uuid-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/
sudo mkdir mergerfs-pool1
```

OMV6 GUI:

System>Plugins>Search>openmediavault-mergerfs>Install

Storage>mergerfs>Create
* Name: mergerfs-pool1
* Filesystems:
* Shared folders:
* Paths:
  * /srv/dev-disk-by-uuid-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx1/mergerfs-pool1/ [data drive 1]
  * ...
  * /srv/dev-disk-by-uuid-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx2/mergerfs-pool1/ [data drive n]
* Create policy: Existing path - most free space
* Minimum free space: 4
* Unit: Gigabytes
* Options: defaults,allow_other,cache.files=partial,use_ino,dropcacheonclose=true
