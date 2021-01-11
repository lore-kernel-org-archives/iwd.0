Content-Type: multipart/mixed; boundary="===============3124809721289439467=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/8] doc: diagnostic DBus interface definition
Date: Mon, 11 Jan 2021 09:12:32 -0800
Message-ID: <20210111171239.472372-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3124809721289439467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/diagnostics.txt | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 doc/diagnostics.txt

diff --git a/doc/diagnostics.txt b/doc/diagnostics.txt
new file mode 100644
index 00000000..2354d316
--- /dev/null
+++ b/doc/diagnostics.txt
@@ -0,0 +1,36 @@
+Station diagnostic hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		net.connman.iwd
+Interface	net.connman.iwd.StationDiagnostic
+Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
+
+Methods		dict GetDiagnostics()
+
+			Get all diagnostic information for this interface. The
+			diagnostics are contained in a single dictionary. Values
+			here are generally low level and not meant for general
+			purpose applications which could get by with the
+			existing Station interface or values which are volatile
+			and change too frequently to be represented as
+			properties. The values in the dictionary may come and
+			go depending on the state of IWD.
+
+			Below is a list of possible diagnostic dictionary
+			values:
+
+			ConnectedBss - MAC address of currently connected BSS.
+
+			RSSI -	The RSSI of the currently connected BSS.
+
+			RxRate - Receive rate in 100kbit/s
+
+			RxMCS - Receiving MCS index
+
+			TxRate - Transmission rate in 100kbit/s
+
+			TxMCS - Transmitting MCS index
+
+			Possible errors: net.connman.iwd.Busy
+					 net.connman.iwd.Failed
+					 net.connman.iwd.NotConnected
-- =

2.26.2

--===============3124809721289439467==--

