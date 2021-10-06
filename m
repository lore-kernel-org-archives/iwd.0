Content-Type: multipart/mixed; boundary="===============0618321594476295532=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 2/2] doc: Document the p2p.Peer.Address property
Date: Wed, 06 Oct 2021 22:52:14 +0200
Message-ID: <20211006205214.227476-2-andrew.zaborowski@intel.com>
In-Reply-To: 20211006205214.227476-1-andrew.zaborowski@intel.com

--===============0618321594476295532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/p2p-peer-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/p2p-peer-api.txt b/doc/p2p-peer-api.txt
index cc5b1918..a4c120d1 100644
--- a/doc/p2p-peer-api.txt
+++ b/doc/p2p-peer-api.txt
@@ -19,6 +19,11 @@ Properties	string Name [readonly]
 =

 			P2P Peer's display name
 =

+		string Address [readonly]
+
+			The peer's unique Device Address in the xx:xx:xx:xx:xx:xx
+			format.
+
 		string DeviceCategory [readonly]
 =

 			The category part of the peer's declared
-- =

2.30.2

--===============0618321594476295532==--

