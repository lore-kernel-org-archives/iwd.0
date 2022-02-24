Content-Type: multipart/mixed; boundary="===============0508990027305112697=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 7/7] doc: document access point scanning
Date: Thu, 24 Feb 2022 09:05:00 -0800
Message-ID: <20220224170500.2779425-7-prestwoj@gmail.com>
In-Reply-To: 20220224170500.2779425-1-prestwoj@gmail.com

--===============0508990027305112697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/access-point-api.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/doc/access-point-api.txt b/doc/access-point-api.txt
index 68ba23c5..3512da82 100644
--- a/doc/access-point-api.txt
+++ b/doc/access-point-api.txt
@@ -37,6 +37,24 @@ Methods		void Start(string ssid, string psk)
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
+			Possible errors:	net.connman.iwd.NotAvailable
+
 Properties	boolean Started [readonly]
 =

 			Reflects whether an access point has been started.
@@ -45,3 +63,7 @@ Properties	boolean Started [readonly]
 =

 			The SSID being broadcast for a started AP (omitted if
 			AP has not been started)
+
+		boolean Scanning [readonly]
+
+			Reflects whether the access point is scanning.
-- =

2.34.1

--===============0508990027305112697==--

