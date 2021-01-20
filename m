Content-Type: multipart/mixed; boundary="===============4621471510652713395=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/8] doc: document AccessPointDiagnostic interface
Date: Wed, 20 Jan 2021 10:30:29 -0800
Message-ID: <20210120183036.477287-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4621471510652713395==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/access-point-diagnostics.txt | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 doc/access-point-diagnostics.txt

diff --git a/doc/access-point-diagnostics.txt b/doc/access-point-diagnostic=
s.txt
new file mode 100644
index 00000000..d28dd6a9
--- /dev/null
+++ b/doc/access-point-diagnostics.txt
@@ -0,0 +1,36 @@
+Access Point diagnostic hierarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
+Service		net.connman.iwd
+Interface	net.connman.iwd.AccessPointDiagnostic
+Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
+
+Methods		dict[] GetDiagnostics()
+
+			Get all diagnostic information for this access points
+			connected clients. This will return an array of
+			dictionaries, each corresponding to an individual
+			client. Below is a list of possible diagnostic
+			dictionary values:
+
+			Address - The station's MAC address
+
+			RSSI [optional] - The RSSI of the currently connected BSS.
+
+			RxMode [optional] -	The phy technology being used
+						(802.11n, 802.11ac or 802.11ax).
+
+			RxRate [optional] - Receive rate in 100kbit/s
+
+			RxMCS [optional] - Receiving MCS index
+
+			TxMode [optional] -	Same meaning as RxMode, just for
+						transmission.
+
+			TxRate [optional] - Transmission rate in 100kbit/s
+
+			TxMCS [optional] - Transmitting MCS index
+
+			Possible errors: net.connman.iwd.Failed
+					 net.connman.iwd.NotConnected
+					 net.connman.iwd.NotFound
-- =

2.26.2

--===============4621471510652713395==--

