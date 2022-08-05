## Configure Email Notifications

source: [https://docs.netgate.com/pfsense/en/latest/config/advanced-notifications.html](https://docs.netgate.com/pfsense/en/latest/config/advanced-notifications.html)

**System>Advanced>Notifications>E-Mail**
* E-Mail server: ``smtp.sendgrid.net``
* SMTP Port of E-Mail server: ``587``
* Secure SMTP Connection: Enable SMTP over SSL/TLS: :x:
* Validate SSL/TLS: Validate the SSL/TLS certificate presented by the server: :white_check_mark:
* From e-mail address: ``[linked sendgrid email address]``
* Notification E-Mail address: ``[comma separated list]``
* Notification E-Mail auth username: ``apikey``
* Notification E-Mail auth password: ``[sendgrid apikey]``
* Notification E-Mail auth mechanism: ``PLAIN``
