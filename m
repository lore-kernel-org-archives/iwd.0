Content-Type: multipart/mixed; boundary="===============0912872635441408493=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] doc: Add net.connman.iwd.IPv{4,6}Configuration API doc
Date: Wed, 08 Sep 2021 23:44:39 +0200
Message-ID: <20210908214440.358243-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0912872635441408493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/ip-configuration-api.txt | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 doc/ip-configuration-api.txt

diff --git a/doc/ip-configuration-api.txt b/doc/ip-configuration-api.txt
new file mode 100644
index 00000000..58a522de
--- /dev/null
+++ b/doc/ip-configuration-api.txt
@@ -0,0 +1,47 @@
+IP Configuration hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+
+Service		net.connman.iwd
+Interface	net.connman.iwd.IPv4Configuration [Experimental]
+Interface	net.connman.iwd.IPv6Configuration [Experimental]
+Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
+Object path	/net/connman/iwd/{phy0,phy1,...}/p2p_peers/{aa_bb_cc_dd_ee_ff}
+
+The interfaces net.connman.iwd.IPv4Configuration and
+net.connman.iwd.IPv6Configuration currently have the same sets of methods,
+signals and properties.  In station mode, when network configuration is
+enabled there may be one or both interfaces present on a device object in
+connected state depending on if IPv4 and IPv6 addresses have both been
+configured.  In P2P mode only net.connman.iwd.IPv4Configuration is used.
+
+Properties	string Method [readonly]
+
+			Indicates whether the local address was set
+			statically (value "static") or obtained automatically
+			such as through DHCP (value "auto").  Even when the
+			address was obtained from the remote end some
+			configuration bits, such as DNS addresses, may have
+			been overridden locally.
+
+		string Address [readonly]
+
+			Holds the local IP address.
+
+		byte PrefixLength [readonly]
+
+			Holds the prefix-length of the local subnet.  For
+			IPv4 this maps to the netmask.
+
+		string Gateway [readonly, optional]
+
+			Holds the gateway address for the subnet if one
+			exists.
+
+		array(string) DomainNameServers [readonly, optional]
+
+			Holds the list of domain name server addresses
+			configured if any.
+
+		array(string) DomainNames [readonly, optional]
+
+			Holds the network's local domain names if any exist.
-- =

2.30.2

--===============0912872635441408493==--

