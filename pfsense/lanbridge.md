## Setup a LAN Bridge

source: [https://eengstrom.github.io/musings/configure-pfsense-bridge-over-multiple-nics-as-lan](https://eengstrom.github.io/musings/configure-pfsense-bridge-over-multiple-nics-as-lan).  
source: [https://www.youtube.com/watch?v=bz45r_4BREw](https://www.youtube.com/watch?v=bz45r_4BREw).  

Follow the guides above to create a bridge ``BR0`` that constains interfaces ``LAN1``, ``LAN2``, and ``LAN3``.  

Basically, you need to connect to the router using ``LAN1``, establish the ``BR0`` bridge, add interfaces ``LAN2`` and ``LAN3`` to the bridge, configure the bridge, connect to an interface (``LAN2`` or ``LAN3``) on the bridge, and then bring interface ``LAN1`` into the bridge.
