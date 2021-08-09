Content-Type: multipart/mixed; boundary="===============9118629806607726874=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 4/4] test: update force-roam to use Debug interface
Date: Mon, 09 Aug 2021 10:42:59 -0700
Message-ID: <20210809174259.537399-4-prestwoj@gmail.com>
In-Reply-To: <20210809174259.537399-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9118629806607726874==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/force-roam | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/force-roam b/test/force-roam
index b590c84a..b45ad2e6 100755
--- a/test/force-roam
+++ b/test/force-roam
@@ -9,7 +9,7 @@ if (len(sys.argv) !=3D 3):
 =

 bus =3D dbus.SystemBus()
 device =3D dbus.Interface(bus.get_object("net.connman.iwd", sys.argv[1]),
-                                    "net.connman.iwd.StationDiagnostic")
+                                    "net.connman.iwd.StationDebug")
 =

 mac =3D sys.argv[2].replace(':', '')
 =

-- =

2.31.1

--===============9118629806607726874==--

