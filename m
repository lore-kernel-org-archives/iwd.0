Content-Type: multipart/mixed; boundary="===============2504286975141875276=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 17/18] doc: Document Peer.ConnectedInterface and ConnectedIP
Date: Sat, 11 Jul 2020 03:00:52 +0200
Message-ID: <20200711010053.224223-17-andrew.zaborowski@intel.com>
In-Reply-To: <20200711010053.224223-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2504286975141875276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/p2p-peer-api.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/p2p-peer-api.txt b/doc/p2p-peer-api.txt
index f7315bc6..cc5b1918 100644
--- a/doc/p2p-peer-api.txt
+++ b/doc/p2p-peer-api.txt
@@ -125,3 +125,13 @@ Properties	string Name [readonly]
 			net.connman.iwd.SimpleConfiguration interface
 			on the same object -- see wsc-api.txt -- and
 			calls to Disconnect on this interface.
+
+		string ConnectedInterface [readonly, optional]
+
+			If connected, this property contains the name
+			of the network interface used for the
+			connection.
+
+		string ConnectedIP [readonly, optional]
+
+			The peer's IPv4 address if connected.
-- =

2.25.1

--===============2504286975141875276==--

