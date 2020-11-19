Content-Type: multipart/mixed; boundary="===============4170931311630802129=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] doc: Update iwd.network.5 with changes from wiki
Date: Thu, 19 Nov 2020 21:32:05 +0100
Message-ID: <20201119203205.358679-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4170931311630802129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix the AlwaysRandomizeAddress setting name.

Add the stricter specification of the extension syntax.

Clarify that GTC and MD5 can't be used as outer EAP methods with wifi.
---
 src/iwd.network.rst | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index 08aea77b..cb3afc67 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -71,6 +71,25 @@ the group name and a ``]`` character.  Whitespace is all=
owed before the
 ``[`` and after the ``]``.  A group name consists of printable characters
 other than ``[`` and ``]``.
 =

+If a group name starts with the ``@`` sign, that group's content is handled
+by a parser extension instead and does not cause the previous non-extension
+group to end.  The initial ``@`` sign must be followed by a non-empty
+extension name, another ``@`` sign and a group name as defined above. The
+extension name consists of printable characters other than ``@``. No
+whitespace is allowed after the group header in this case.  The extension
+payload syntax and length are determined by the extension name.  Normal
+parsing rules defined in this section resume at the end of the payload and
+any settings after the end of the payload are handled as part of the previ=
ous
+non-extension group.
+
+Currently the only extension supported is named pem and allows embedding t=
he
+contents of a single RFC7468 PEM-formatted payload or a sequence of multip=
le
+PEM payloads.  The payload should start with the ``-----BEGIN`` string on a
+line following the group header line and end with an ``-----END`` line as
+specified in the RFC.  Newline characters before, between and after PEM
+payloads are included in the extension payload.  No other extra characters
+are allowed.
+
 NAMING
 =3D=3D=3D=3D=3D=3D
 =

@@ -114,15 +133,15 @@ The group ``[Settings]`` contains general settings.
 =

        If enabled, the MAC address will be fully randomized on each connec=
tion.
        This option is only used if [General].AddressRandomization is set to
-       'network'. See iwd.config. This value should not be used with
+       'network'. See iwd.config. This setting should not be used with
        [Settings].AddressOverride, if both are set AddressOverride will be=
 used.
    * - AddressOverride
      - MAC address string
 =

        Override the MAC address used for connecting to this network. This =
option
        is only used if [General].AddressRandomization is set to 'network'.=
 See
-       iwd.config. This value should not be used with
-       [Settings].FullAddressRandomization, if both are set AddressOverrid=
e will
+       iwd.config. This setting should not be used with
+       [Settings].AlwaysRandomizeAddress, if both are set AddressOverride =
will
        be used.
 =

 Network Authentication Settings
@@ -153,7 +172,12 @@ authentication configuration.
    * - EAP-Method
      - one of the following methods:
 =

-       AKA, AKA', GTC, MD5, MSCHAPV2, PEAP, PWD, SIM, TLS, TTLS
+       AKA, AKA', MSCHAPV2, PEAP, PWD, SIM, TLS, TTLS.
+
+       The following additional methods are allowed as TTLS/PEAP inner
+       methods:
+
+       GTC, MD5.
    * - EAP-Identity
      - string
 =

@@ -248,7 +272,7 @@ authentication configuration.
        provided.
 =

 Network Configuration Settings
--------------------------------
+------------------------------
 =

 The group ``[IPv4]`` contains settings for Internet Protocol version 4 (IP=
v4)
 network configuration with the static addresses.
@@ -343,7 +367,7 @@ directly. This allows IEEE 802.1x network provisioning =
using a single file
 without any references to certificates or keys on the system.
 =

 An embedded PEM can appear anywhere in the settings file using the followi=
ng
-format (this example the PEM is named 'my_ca_cert'):
+format (in this example the PEM is named 'my_ca_cert'):
 =

 .. code-block::
 =

@@ -352,7 +376,7 @@ format (this example the PEM is named 'my_ca_cert'):
   <PEM data>
   ----- END CERTIFICATE -----
 =

-After this special group tag its as simple as pasting in a PEM file includ=
ing
+After this special group tag it's as simple as pasting in a PEM file inclu=
ding
 the BEGIN/END tags. Now 'my_ca_cert' can be used to reference the certific=
ate
 elsewhere in the settings file by prefixing the value with 'embed:'
 =

-- =

2.25.1

--===============4170931311630802129==--

