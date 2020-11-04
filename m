Content-Type: multipart/mixed; boundary="===============3857225499457448023=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] doc: document DHCP server options in AP profiles
Date: Wed, 04 Nov 2020 08:52:27 -0800
Message-ID: <20201104165227.2782516-4-prestwoj@gmail.com>
In-Reply-To: <20201104165227.2782516-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3857225499457448023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.ap.rst | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/src/iwd.ap.rst b/src/iwd.ap.rst
index 939bf99d..52312855 100644
--- a/src/iwd.ap.rst
+++ b/src/iwd.ap.rst
@@ -56,6 +56,54 @@ configuration.
 =

        Passphrase to be used with this access point.
 =

+DHCP Server Settings
+--------------------
+
+The group ``[IPv4]`` contains settings for IWD's built in DHCP server. All
+settings are optional.
+
+.. list-table::
+   :header-rows: 0
+   :stub-columns: 0
+   :widths: 20 80
+
+   * - Address
+     - IP Address of AP
+
+       Optional address for the DHCP server/access point. If provided this
+       address will be set on the AP interface and any other DHCP server o=
ptions
+       will be derived from this address, unless they are overriden inside=
 the
+       AP profile. If [IPv4].Address is not provided and no IP address is =
set
+       on the interface prior to calling StartProfile the IP pool will be =
used.
+
+   * - Gateway
+     - IP Address of gateway
+
+       IP address of gateway. This will inherit from [IPv4].Address if not
+       provided.
+
+   * - Netmask
+     - Netmask of DHCP server
+
+       This will be generated from [IPv4].Address if not provided.
+
+   * - DNSList
+     - List of DNS servers
+
+       A list of DNS servers which will be advertised by the DHCP server. =
If
+       not provided no DNS servers will be sent by the DHCP server.
+
+   * - LeaseTime
+     - Time limit for DHCP leases
+
+       Override the default lease time.
+
+   * - IPRange
+     - Range of IPs to use for the DHCP server
+
+       If not provided a default range will be chosen which is the DHCP se=
rver
+       address + 1 to 254.
+
 SEE ALSO
 =3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

2.26.2

--===============3857225499457448023==--

