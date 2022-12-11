## Install Sensor Monitors

source: https://itsfoss.com/check-laptop-cpu-temperature-ubuntu/  
source: https://askubuntu.com/questions/15832/how-do-i-get-the-cpu-temperature
```console
sudo apt update
sudo apt install lm-sensors
sudo sensors-detect
```
Answer yes to all the questions and yes to add the modules to /etc/modules
```console
sudo service kmod start
sudo apt install psensor
psensor &
```
Configure psensor:

* psensor->Preferences->Startup, select "Launch on session startup" and "Hide Window on startup"
* psensor->Preferences->Providers, deselect "Enable support of udisk2" or it will prevent HDD spin down
* psensor->Sensor Preferences->CPU->Application Indicator->"Display sensor in the label (experimental)"
* psensor->Sensor Preferences->CPU Usage->Application Indicator->"Display sensor in the label (experimental)"
* psensor->Sensor Preferences->fan2->Application Indicator->"Display sensor in the label (experimental)"

Reboot for good measure and make sure the temperature and usage sensor shows up in the task bar after a few minutes.
