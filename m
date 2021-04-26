Content-Type: multipart/mixed; boundary="===============8287399524453537159=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/3] doc: Clarify settings in iwd.ap(5)
Date: Tue, 27 Apr 2021 01:34:07 +0200
Message-ID: <20210426233408.775576-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210426233408.775576-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8287399524453537159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change some of the wording, add some references and more specific syntax
information (time units, IP list separator character, etc.)
---
 src/iwd.ap.rst | 61 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/src/iwd.ap.rst b/src/iwd.ap.rst
index 52312855..d4534120 100644
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
@@ -54,13 +56,23 @@ configuration.
    * - Passphrase
      - 8..63 character string
 =

-       Passphrase to be used with this access point.
+       WPA-PSK Passphrase to be used with this access point.
 =

-DHCP Server Settings
---------------------
+IPv4 Network Configuration
+--------------------------
 =

-The group ``[IPv4]`` contains settings for IWD's built in DHCP server. All
-settings are optional.
+The group ``[IPv4]`` contains settings for IWD's built-in DHCP server.  All
+settings are optional.  They're used if network configuration was enabled =
as
+described in ``iwd.config(5)``.  Omitting the ``[IPv4]`` group disables
+network configuration for this access point so if an all-defaults DHCP set=
up
+is desired, the group header line must still be present:
+
+.. code-block::
+
+   # Enable network configuration
+   [IPv4]
+
+   [other groups follow]
 =

 .. list-table::
    :header-rows: 0
@@ -68,41 +80,42 @@ settings are optional.
    :widths: 20 80
 =

    * - Address
-     - IP Address of AP
+     - Local IP address
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
+       Optional local address pool for the access point and the DHCP serve=
r.
+       If provided this addresss will be set on the AP interface and any o=
ther
+       DHCP server options will be derived from it, unless they are overri=
dden
+       by other settings below.  If *Address* is not provided and no IP
+       address is set on the interface prior to calling `StartProfile`,  t=
he IP
+       pool defined by the global ``[General].APRanges`` setting will be u=
sed.
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
+       This will be generated from ``[IPv4].Address`` if not provided.
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
+     - Range of IPs given as two addresses separated by a comma
 =

-       If not provided a default range will be chosen which is the DHCP se=
rver
-       address + 1 to 254.
+       From and to addresses of the range assigned to clients through DHCP.
+       If not provided the range from local address + 1 to .254 will be us=
ed.
 =

 SEE ALSO
 =3D=3D=3D=3D=3D=3D=3D=3D
-- =

2.27.0

--===============8287399524453537159==--

