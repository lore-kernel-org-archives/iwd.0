Content-Type: multipart/mixed; boundary="===============8657114573674987128=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 07/18] test: Set WSC.PushButton call timeout to 120s
Date: Sat, 11 Jul 2020 03:00:42 +0200
Message-ID: <20200711010053.224223-7-andrew.zaborowski@intel.com>
In-Reply-To: <20200711010053.224223-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8657114573674987128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/connect-p2p | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/connect-p2p b/test/connect-p2p
index 76b242b9..89ea8ca7 100755
--- a/test/connect-p2p
+++ b/test/connect-p2p
@@ -64,7 +64,7 @@ def connect(path):
     print('Connecting to ' + peer_props['Name'])
     connecting =3D True
     try:
-        peer_wsc.PushButton()
+        peer_wsc.PushButton(timeout=3D120)
         print('New connection')
     except Exception as e:
         connecting =3D False
-- =

2.25.1

--===============8657114573674987128==--

