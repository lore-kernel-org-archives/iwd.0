Content-Type: multipart/mixed; boundary="===============0945580696019845489=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] ap: Clarify settings in iwd.ap(5)
Date: Thu, 18 Feb 2021 20:55:14 +0100
Message-ID: <20210218195515.503170-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0945580696019845489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change some of the wording and add some references, for example the phrase
IP pool was used but it wasn't clear what it referred to.
---
 src/iwd.ap.rst | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/src/iwd.ap.rst b/src/iwd.ap.rst
index 52312855..9240f25b 100644
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
+They are read when the net.connman.iwd.AccessPoint.StartProfile(ssid) DBus
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
@@ -54,13 +56,14 @@ configuration.
    * - Passphrase
      - 8..63 character string
 =

-       Passphrase to be used with this access point.
+       PSK Passphrase to be used with this access point.
 =

 DHCP Server Settings
 --------------------
 =

-The group ``[IPv4]`` contains settings for IWD's built in DHCP server. All
-settings are optional.
+The group ``[IPv4]`` contains settings for IWD's built-in DHCP server. All
+settings are optional.  They're used if network configuration was enabled =
as
+described in *iwd.config*(5).
 =

 .. list-table::
    :header-rows: 0
@@ -68,41 +71,43 @@ settings are optional.
    :widths: 20 80
 =

    * - Address
-     - IP Address of AP
+     - Local IP Address of the AP
 =

-       Optional address for the DHCP server/access point. If provided this
-       address will be set on the AP interface and any other DHCP server o=
ptions
-       will be derived from this address, unless they are overriden inside=
 the
-       AP profile. If [IPv4].Address is not provided and no IP address is =
set
-       on the interface prior to calling StartProfile the IP pool will be =
used.
+       Optional local address for the access point and the DHCP server. If
+       provided this address will be set on the AP interface and any other=
 DHCP
+       server options will be derived from this address, unless they are
+       overriden by other settings. If [IPv4].Address is not provided and =
no IP
+       address is set on the interface prior to calling StartProfile the IP
+       pool defined by the global [General].APRanges setting will be used.
 =

    * - Gateway
      - IP Address of gateway
 =

-       IP address of gateway. This will inherit from [IPv4].Address if not
-       provided.
+       IP address of the gateway to be advertised by DHCP. This will inher=
it
+       the value of [IPv4].Address if not provided.
 =

    * - Netmask
-     - Netmask of DHCP server
+     - Local netmask of the AP
 =

-       This will be generated from [IPv4].Address if not provided.
+       Defaults to a 24-bit netmask if not provided.
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
+     - Range of IPs to use for the DHCP server given as two addresses sepa=
rated
+       by a comma
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
-- =

2.27.0

--===============0945580696019845489==--

