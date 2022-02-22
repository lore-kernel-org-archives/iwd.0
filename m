Content-Type: multipart/mixed; boundary="===============7173476930837281047=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 7/7] doc: document access point scanning
Date: Tue, 22 Feb 2022 14:57:18 -0800
Message-ID: <20220222225718.2485794-7-prestwoj@gmail.com>
In-Reply-To: 20220222225718.2485794-1-prestwoj@gmail.com

--===============7173476930837281047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/access-point-api.txt | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/doc/access-point-api.txt b/doc/access-point-api.txt
index 68ba23c5..3f712cee 100644
--- a/doc/access-point-api.txt
+++ b/doc/access-point-api.txt
@@ -37,6 +37,29 @@ Methods		void Start(string ssid, string psk)
 						net.connman.iwd.AlreadyExists
 						net.connman.iwd.NotFound
 =

+		void Scan()
+
+			Schedule a network scan.
+
+			Possible errors:	net.connman.iwd.NotAvailable
+						net.connman.iwd.NotSupported
+						net.connman.iwd.Busy
+						net.connman.iwd.Failed
+
+		array(dict) GetOrderedNetworks()
+
+			Gets the list of networks found after scanning sorted
+			based on signal strength. Each item in the array is a
+			dictionary containing the network Name, SignalStrength,
+			and Security.
+
+			This list will expire similarly to station, and since
+			access points do not do periodic scans the list may
+			become empty after some time and requires scanning
+			again.
+
+			Possible errors:	net.connman.iwd.NotAvailable
+
 Properties	boolean Started [readonly]
 =

 			Reflects whether an access point has been started.
@@ -45,3 +68,7 @@ Properties	boolean Started [readonly]
 =

 			The SSID being broadcast for a started AP (omitted if
 			AP has not been started)
+
+		boolean Scanning [readonly]
+
+			Reflects whether the access point is scanning.
-- =

2.34.1

--===============7173476930837281047==--

