Content-Type: multipart/mixed; boundary="===============8503955795195987953=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 01/12] doc: Fix p2p method error names
Date: Wed, 18 Mar 2020 15:45:20 +0100
Message-ID: <20200318144531.30613-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8503955795195987953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/p2p-api.txt      | 2 +-
 doc/p2p-peer-api.txt | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/p2p-api.txt b/doc/p2p-api.txt
index cca0f39f..08ee8d92 100644
--- a/doc/p2p-api.txt
+++ b/doc/p2p-api.txt
@@ -40,7 +40,7 @@ Methods		array(on) GetPeers()
 			discovered peer devices to avoid keeping the Wi-Fi
 			adapter occupied unnecessarily.
 =

-			Possible errors: [service].Error.NotAvailable
+			Possible errors: [service].Error.NotFound
 =

 		void RegisterSignalLevelAgent(object path,
 						 array(int16) levels)
diff --git a/doc/p2p-peer-api.txt b/doc/p2p-peer-api.txt
index 2245b2e3..f52717aa 100644
--- a/doc/p2p-peer-api.txt
+++ b/doc/p2p-peer-api.txt
@@ -12,8 +12,8 @@ Methods		Disconnect()
 			the net.connman.iwd.SimpleConfiguration interface
 			on the same object -- see wsc-api.txt.
 =

-			Possible errors: [service].Failed
-					 [service].NotConnected
+			Possible errors: [service].Error.Failed
+					 [service].Error.NotConnected
 =

 Properties	string Name [readonly]
 =

-- =

2.20.1

--===============8503955795195987953==--

