Content-Type: multipart/mixed; boundary="===============7171843810853989941=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/3] doc: Add net.connman.iwd.NetworkConfiguration API doc
Date: Wed, 30 Jun 2021 21:06:33 +0200
Message-ID: <20210630190635.264095-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7171843810853989941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/network-configuration-api.txt | 52 +++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 doc/network-configuration-api.txt

diff --git a/doc/network-configuration-api.txt b/doc/network-configuration-=
api.txt
new file mode 100644
index 00000000..5c302a37
--- /dev/null
+++ b/doc/network-configuration-api.txt
@@ -0,0 +1,52 @@
+Network Configuration hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+
+Service		net.connman.iwd
+Interface	net.connman.iwd.NetworkConfiguration [Experimental]
+Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}/{ipv4,ipv6}
+Object path	/net/connman/iwd/{phy0,phy1,...}/p2p_peers/{aa_bb_cc_dd_ee_ff}
+
+Properties	object Device [readonly]
+
+			The object path of the station, access point or P2P
+			device that this network configuration is active on.
+
+			In station mode, when network configuration is
+			enabled there may be one or two objects using this
+			interface and active on the same device: two if both
+			IPv4 and IPv6 addresses have been configured.
+
+			In P2P mode, this interface always refers to IPv4
+			network configuration.
+
+		string Method [readonly]
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
+			Holds the gateway address for the IPv4 subnet if one
+			exists.
+
+		array(string) DomainNameServers [readonly, optional]
+
+			Holds the list of domain name servers configured if
+			any.
+
+		string DomainNames [readonly, optional]
+
+			Holds the network's local domain names if any exist.
-- =

2.30.2

--===============7171843810853989941==--

