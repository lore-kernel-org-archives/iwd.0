Content-Type: multipart/mixed; boundary="===============1911181061219001591=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 09/11] doc: Update AP settings in iwd.ap(5) and iwd.config(5)
Date: Mon, 10 May 2021 10:58:04 +0200
Message-ID: <20210510085806.174213-9-andrew.zaborowski@intel.com>
In-Reply-To: <20210510085806.174213-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1911181061219001591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.ap.rst     | 31 ++++++++++++++++++++++++-------
 src/iwd.config.rst | 29 ++++++++++++++++++++++++++---
 2 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/src/iwd.ap.rst b/src/iwd.ap.rst
index 51622509..5fa23179 100644
--- a/src/iwd.ap.rst
+++ b/src/iwd.ap.rst
@@ -104,14 +104,31 @@ is desired, the group header line must still be prese=
nt:
    :widths: 20 80
 =

    * - Address
-     - Local IP address
+     - Local IP address or a comma-separated list of prefix-notation addre=
sses
 =

        Optional local address pool for the access point and the DHCP serve=
r.
-       If provided this addresss will be set on the AP interface and any o=
ther
-       DHCP server options will be derived from it, unless they are overri=
dden
-       by other settings below.  If *Address* is not provided and no IP
-       address is set on the interface prior to calling `StartProfile`,  t=
he IP
-       pool defined by the global ``[General].APRanges`` setting will be u=
sed.
+       If a single address is provided this address will be set on the AP
+       interface and any other DHCP server options will be derived from it
+       if not overridden by other settings below.
+
+       If a list of addresses and prefix lengths is specified (in the
+       `<IP>/<prefix-len>` format), a single subnet address will be select=
ed
+       from the available space each time this profile is started.  The su=
bnet
+       size is based on the ``[IPv4].Netmask`` setting.
+
+       If *Address* is not provided and no IP address is set on the
+       interface prior to calling `StartProfile` the value of the main.conf
+       ``[IPv4].APAddressPool`` setting will be inherited, which in turn
+       defaults to 192.168.0.0/16.
+
+       For example, if ``[IPv4].Netmask`` is set to 255.255.255.0 and this
+       setting, or the global *APAddressPool* fallback, is set to
+       ``192.168.0.0/16, 10.0.0.0/22``, IWD will select one of the 256 sub=
nets
+       with addresses in the 192.168.<0-255>.0/24 range or one of the 4 su=
bnets
+       with addresses in the 10.0.<0-3>.0/24 range, allowing 270 possible
+       subnets.  Defining an address pool larger than the desired subnet g=
ives
+       IWD a chance to avoid conflicts if other interfaces on the system u=
se
+       dynamically assigned addresses.
 =

    * - Gateway
      - IP Address of gateway
@@ -122,7 +139,7 @@ is desired, the group header line must still be present:
    * - Netmask
      - Local netmask of the AP
 =

-       This will be generated from ``[IPv4].Address`` if not provided.
+       Defaults to a 28-bit netmask if not provided.
 =

    * - DNSList
      - List of DNS servers as a comma-separated IP address list
diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 478bd616..190c3fbd 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -67,8 +67,8 @@ The group ``[General]`` contains general settings.
        obtain the dynamic addresses from the network through the built-in
        DHCP client.
 =

-       This also enables DHCP server when in AP mode when either
-       [General].APRanges is set or an AP profile is being used.
+       This also enables network configuration and the DHCP server when in=
 AP
+       mode and the AP profile being activated does not override it.
 =

        The network configuration feature is disabled by default.  See
        ``[Network]`` settings for additional settings related to network
@@ -175,7 +175,7 @@ The group ``[General]`` contains general settings.
        then setting ``DisableANQP`` to ``false`` is recommended.
 =

 Network
----------
+-------
 =

 The group ``[Network]`` contains network configuration related settings.
 =

@@ -312,6 +312,29 @@ No modification from defaults is normally required.
        prevent **iwd** from roaming properly, but can be useful for networ=
ks
        operating under extremely low rssi levels where roaming isn't possi=
ble.
 =

+IPv4
+----
+
+The group ``[IPv4]`` contains settings related to IPv4 network configurati=
on.
+
+.. list-table::
+   :header-rows: 0
+   :stub-columns: 0
+   :widths: 20 80
+   :align: left
+
+   * - APAddressPool
+     - Values: comma-separated list of prefix-notation IP strings
+
+       Defines the space of IPs used for the Access Point-mode subnet addr=
esses
+       and the DHCP server.  Defaults to 192.168.0.0/16.  The prefix length
+       decides the size of the pool from which an address is selected but =
the
+       actual subnet size (netmask) is based on the AP profile being activ=
ated
+       and defaults to 28 bits.  The AP profile's ``[IPv4].Address`` setti=
ng
+       overrides the global value set here.  Setting a too small address s=
pace
+       will limit the number of access points that can be running
+       simultaneously on different interfaces.
+
 SEE ALSO
 =3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

2.27.0

--===============1911181061219001591==--

