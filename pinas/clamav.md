## Setup ClamAV (Antimalware)

OMV6 GUI:  

System>Plugins>Search>```openmediavault-clamav```>Install 

Storage>Shared Folders
* Name: ``quarantine``
* File system: /dev/sd?1
* Relative path: quarantine/
* Permissions: Administrators: read/write, Others: read/write, Others: read-only
* Comment:

Services>Antivirus>Settings
* Enabled: :white_check_mark:
* Database checks: 1
* Quarantine: ``quarantine``
* Log clean file: :x:
* Scan Portable Executable: :white_check_mark:
* Scan OLE2: :white_check_mark:
* Scan HTML: :white_check_mark:
* Scan PDF: :white_check_mark:
* Scan ELF: :white_check_mark:
* Scan archives: :white_check_mark:
* Detect broken executables: :x:
* Detect PUA: :x:
* Algorithmic detection: :white_check_mark:
* Follow diretory symlinks: :x:
* Follow file symlinks: :x:

Services>Antivirus>Scheduled Scans
* Enabled: :white_check_mark:
* Shared folder: ``[Shared Folder]``
* Minute: 0
* Hour: 2
* Day of the month: *
* Month: *
* Day of week: Sunday
* Infected files: Move to quarantine
* Multiscan: :x:
* Verbose: :x:
* Send email: :white_check_mark:

_Repeat for all `Shared Folders` to scan_
