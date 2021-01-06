Content-Type: multipart/mixed; boundary="===============6913904840643196440=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 1/1] diagnostic: DBus interface definition
Date: Wed, 06 Jan 2021 12:23:55 -0800
Message-ID: <20210106202355.103284-2-prestwoj@gmail.com>
In-Reply-To: <20210106202355.103284-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6913904840643196440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/diagnostics.txt | 51 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 doc/diagnostics.txt

diff --git a/doc/diagnostics.txt b/doc/diagnostics.txt
new file mode 100644
index 00000000..2c2f5aa9
--- /dev/null
+++ b/doc/diagnostics.txt
@@ -0,0 +1,51 @@
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
+			Below is a list of possible diagnostic values:
+
+			ConnectedBss - MAC address of currently connected BSS.
+
+			RSSI -	The RSSI of the currently connected BSS.
+
+			RxRate - Receive rate in MBit/s
+
+			TxRate - Transmission rate in MBit/s
+
+			Others may include: channel, country code, security,
+			noise, phy mode, MCS index.
+
+RFC:	These are some ideas I was playing around with for auto-testing. They
+	are only useful as properties since autotests would rely on the
+	PropertiesChanged signal. These would give the autotest framework much
+	finer detail into whats going on, rather than only knowing if the
+	connection succeeded or failed.
+
+Properties	string ConnectionState [readonly]
+
+			The state of an ongoing connection attempt. This state
+			reflects the sub-states between the Station interface
+			states of "connecting" and "connected":
+
+			"authenticating", "associating", "handshaking",
+			"connected", "disconnected".
+
+		uint16 ConnectFailedReasonOrStatus [readonly]
+
+			The reason or status code returned from a failed
+			connection attempt. The 'ConnectionState' will indicate
+			if this value is a Reason code or Status code.
-- =

2.26.2

--===============6913904840643196440==--

