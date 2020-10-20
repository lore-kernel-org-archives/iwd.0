Content-Type: multipart/mixed; boundary="===============4025721449896881638=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 07/13] doc: update AP docs with new Start() arguments
Date: Tue, 20 Oct 2020 11:02:50 -0700
Message-ID: <20201020180256.1630120-7-prestwoj@gmail.com>
In-Reply-To: <20201020180256.1630120-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4025721449896881638==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The 'psk' argument has now been removed and replaced with a
dedicated provisioning file which should contain the psk.
---
 doc/access-point-api.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/doc/access-point-api.txt b/doc/access-point-api.txt
index 9ee06baa..7d504b90 100644
--- a/doc/access-point-api.txt
+++ b/doc/access-point-api.txt
@@ -5,15 +5,17 @@ Service		net.connman.iwd
 Interface	net.connman.iwd.AccessPoint [Experimental]
 Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
 =

-Methods		void Start(string ssid, string psk)
+Methods		void Start(string ssid)
 =

-			Start an access point called ssid with a passphrase
-			of psk.
+			Start an access point called ssid. A network
+			provisioning file must exist in /var/lib/iwd/ap/ who's
+			file name matches the ssid in the DBus message.
 =

 			Possible errors:	net.connman.iwd.Busy
 						net.connman.iwd.Failed
 						net.connman.iwd.InvalidArguments
 						net.connman.iwd.AlreadyExists
+						net.connman.iwd.NotFound
 =

 		void Stop()
 =

-- =

2.26.2

--===============4025721449896881638==--

