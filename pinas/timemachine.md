## Setup Apple Time Machine Support

source: https://dannyda.com/2020/01/02/how-to-create-apple-time-machine-in-open-media-vault-5-omv-5-with-shared-folder-smb-share-windows-share-shared-folder-cifs/

Adding Apple Time Machine support to your NAS.

OMV6 GUI:

Storage>File Systems>Mount
* File system: ```/dev/sd?1```
* Usage Warning Threshold: 85%
* Comment:

Storage>Shared Folders
* Name: timemachine
* File system: /dev/sd?1
* Relative path: timemachine/
* Permissions: Administrators: read/write, Others: read/write, Others: read-only
* Comment:

Storage>Shared Folders>```timemachine```>ACL
* Name: timemachine [on /dev/sd?1, timemachine/]
* User/Group permissions: none
* Onwer: tmuser Permissions: Read/Write/Execute
* Group: users Permissions: Read/Write/Execute
* Others: Read/Execute
* Replace: :white_check_mark:
* Recursive: :white_check_mark: (if you need to update a folder coming from another system) otherwise :x:

Storage>Shared Folders>```timemachine```>Privleges
* tmuser: Read/Write

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
* Shared Folder: ```timemachine```
* Comment:= Time Machine Backups
* Read-only: :x:
* Public: No
* Browsable: :white_check_mark:
* Time Machine support: :white_check_mark:
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
* Extra options:

### Global Quota

Set a universal quota to limit the size of each time machine backup (quota applies **per** time machine backup; this is **not** a quota for the sum of all backups):

```console
cd /srv/dev-disk-by-uuid-00000000-0000-0000-0000-000000000000/
sudo touch ./timemachine/.com.apple.timemachine.supported
sudo touch ./timemachine/.com.apple.TimeMachine.quota.plist
sudo chmod 644 ./timemachine/.com.apple.timemachine.supported
sudo chmod 644 ./timemachine/.com.apple.TimeMachine.quota.plist
sudo chown root:root ./timemachine/.com.apple.timemachine.supported
sudo chown root:root ./timemachine/.com.apple.TimeMachine.quota.plist
sudo vi ./timemachine/.com.apple.TimeMachine.quota.plist
```
```
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>GlobalQuota</key>
    <integer>100000000000</integer>
  </dict>
</plist>
```

_I set the quota at 1TB per Time Machine backup (for a max of 4 machines each with size 1TB SSDs in them) on a 4TB drive in the NAS._
