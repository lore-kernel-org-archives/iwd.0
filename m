Content-Type: multipart/mixed; boundary="===============2811689603354951580=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 7/7] doc: Update AP settings in iwd.ap and iwd.config(5)
Date: Thu, 25 Feb 2021 22:27:25 +0100
Message-ID: <20210225212725.656746-7-andrew.zaborowski@intel.com>
In-Reply-To: <20210225212725.656746-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2811689603354951580==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Update the AP-mode address logic documentation, change some of the
wording and add some references.
---
 src/iwd.ap.rst     | 70 +++++++++++++++++++++++++++++-----------------
 src/iwd.config.rst | 30 ++++++++++++--------
 2 files changed, 63 insertions(+), 37 deletions(-)

diff --git a/src/iwd.ap.rst b/src/iwd.ap.rst
index 52312855..57081702 100644
--- a/src/iwd.ap.rst
+++ b/src/iwd.ap.rst
@@ -3,7 +3,7 @@
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

 --------------------------------------
-Configuration of IWD access point
+Configuration of IWD access points
 --------------------------------------
 =

 :Author: James Prestwood <prestwoj@gmail.com>
@@ -25,19 +25,21 @@ Description of access point provisioning files.
 DESCRIPTION
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-An access point provisioning files define the configuration of an IWD acce=
ss
+An access point provisioning file defines the configuration of an IWD acce=
ss
 point. These files live in *$STATE_DIRECTORY*/ap (/var/lib/iwd/ap by defau=
lt).
+They are read when the `net.connman.iwd.AccessPoint.StartProfile(ssid)` DB=
us
+method is used.
 =

 FILE FORMAT
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-See *iwd.network* for details on the file format.
+See *iwd.network* for details on the settings file syntax.
 =

 SETTINGS
 =3D=3D=3D=3D=3D=3D=3D=3D
 =

 The settings are split into several categories.  Each category has a group
-associated with it and described in separate tables below.
+associated with it and is described in the corresponding table below.
 =

 Network Authentication Settings
 -------------------------------
@@ -54,13 +56,15 @@ configuration.
    * - Passphrase
      - 8..63 character string
 =

-       Passphrase to be used with this access point.
+       PSK Passphrase to be used with this access point.
 =

-DHCP Server Settings
---------------------
+IPv4 Network Configuration
+--------------------------
 =

-The group ``[IPv4]`` contains settings for IWD's built in DHCP server. All
-settings are optional.
+The group ``[IPv4]`` contains settings for IWD's built-in DHCP server. All
+settings are optional.  They're used if network configuration was enabled =
as
+described in ``iwd.config(5)``.  Omitting the ``[IPv4]`` group disables
+network configuration and the DHCP server for this access point.
 =

 .. list-table::
    :header-rows: 0
@@ -68,41 +72,57 @@ settings are optional.
    :widths: 20 80
 =

    * - Address
-     - IP Address of AP
-
-       Optional address for the DHCP server/access point. If provided this
-       address will be set on the AP interface and any other DHCP server o=
ptions
-       will be derived from this address, unless they are overriden inside=
 the
-       AP profile. If [IPv4].Address is not provided and no IP address is =
set
-       on the interface prior to calling StartProfile the IP pool will be =
used.
+     - Local IP address of the AP or a comma-separated list of prefix-nota=
tion
+       addresses
+
+       Optional local address for the access point and the DHCP server.  I=
f a
+       single address is provided this address will be set on the AP inter=
face
+       and any other DHCP server options will be derived from it, unless t=
hey
+       are overriden by other settings.  If a list of addresses and prefix
+       lengths is given (in the `<IP>/<prefix-len>` format), a single subn=
et
+       address will be selected from the available space each time this pr=
ofile
+       is started.  The subnet size will be based on the ``[IPv4].Netmask``
+       setting.  If ``[IPv4].Address`` is not provided and no IP address i=
s set
+       on the interface prior to calling `StartProfile` the IP pool define=
d by
+       the global ``[IPv4].APAddressPool`` setting will be used, which in =
turn
+       defaults to 192.168.0.0/16.
+       For example, if ``[IPv4].Netmask`` is set the 255.255.255.0 and this
+       setting, or the global ``APAddressPool`` fallback, is set to
+       ``192.168.0.0/16, 10.0.0.0/22``, IWD will select one of the 256 sub=
nets
+       with addresses in the 192.168.<0-255>.0/24 range or one of the 4 su=
bnets
+       with addresses in the 10.0.<0-3>.0/24 range, allowing 270 possible
+       subnets.  Defining an address pool larger than the subnet may be
+       desired if other interfaces on the system use dynamically assigned
+       addresses giving IWD a chance to avoid conflicts.
 =

    * - Gateway
      - IP Address of gateway
 =

-       IP address of gateway. This will inherit from [IPv4].Address if not
-       provided.
+       IP address of the gateway to be advertised by DHCP. This will fall =
back
+       to the local IP address if not provided.
 =

    * - Netmask
-     - Netmask of DHCP server
+     - Local netmask of the AP
 =

-       This will be generated from [IPv4].Address if not provided.
+       Defaults to a 28-bit netmask if not provided.
 =

    * - DNSList
-     - List of DNS servers
+     - List of DNS servers as a comma-separated IP address list
 =

        A list of DNS servers which will be advertised by the DHCP server. =
If
        not provided no DNS servers will be sent by the DHCP server.
 =

    * - LeaseTime
-     - Time limit for DHCP leases
+     - Time limit for DHCP leases in seconds
 =

        Override the default lease time.
 =

    * - IPRange
-     - Range of IPs to use for the DHCP server
+     - Range of IPs for the DHCP server to use given as two addresses
+       separated by a comma
 =

-       If not provided a default range will be chosen which is the DHCP se=
rver
-       address + 1 to 254.
+       From and to addresses of the range assigned to clients by DHCP.  If=
 not
+       provided the range from local address + 1 to .254 will be used.
 =

 SEE ALSO
 =3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 478bd616..b694bc8d 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -67,23 +67,13 @@ The group ``[General]`` contains general settings.
        obtain the dynamic addresses from the network through the built-in
        DHCP client.
 =

-       This also enables DHCP server when in AP mode when either
-       [General].APRanges is set or an AP profile is being used.
+       This also enables network configuration and the DHCP server when in=
 AP
+       mode and the AP profile being activated does does not override it.
 =

        The network configuration feature is disabled by default.  See
        ``[Network]`` settings for additional settings related to network
        configuration.
 =

-   * - APRanges
-     - Values: <IP in prefix notation>
-
-       Sets the range of IP's used for DHCP server (AP mode). The IP shoul=
d be
-       in prefix notation e.g. 192.168.1.0/24. AP's which are started in a
-       profile-less configuration will use this pool of IP's to set the AP=
's
-       interface address as well as default DHCP server options. Each AP w=
ill
-       get a new subnet from the range and clients will be addressed in th=
at
-       subnet to avoid IP conflicts if multiple AP's are started.
-
    * - UseDefaultInterface
      - Values: true, **false**
 =

@@ -312,6 +302,22 @@ No modification from defaults is normally required.
        prevent **iwd** from roaming properly, but can be useful for networ=
ks
        operating under extremely low rssi levels where roaming isn't possi=
ble.
 =

+IPv4
+----
+
+The group ``[IPv4]`` contains settings related to IPv4 address configurati=
on.
+
+   * - APAddressPool
+     - Values: comma-separated list of prefix-notation IPv4 address strings
+
+       Defines the space of IPs used for the AP-mode subnet addresses and =
the
+       DHCP server.  Defaults to 192.168.0.0/16.  The prefix length defines
+       the space from which an address is selected but the actual subnet s=
ize
+       (netmask) is based on the AP profile being activated and defaults t=
o 28
+       bits.  The AP profile's [IPv4].Address setting overrides the global
+       value here.  Setting a too small address space will limit the numbe=
r of
+       access points that can be running simultaneously on different inter=
faces.
+
 SEE ALSO
 =3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

2.27.0

--===============2811689603354951580==--

