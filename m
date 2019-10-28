Content-Type: multipart/mixed; boundary="===============1541955896519975843=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] auto-t: Update the base paths for iwd
Date: Mon, 28 Oct 2019 14:55:26 -0700
Message-ID: <20191028215526.3980-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1541955896519975843==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/iwd.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 35e5a693..abcdcbc1 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -36,8 +36,8 @@ IWD_AP_INTERFACE =3D              'net.connman.iwd.Access=
Point'
 IWD_ADHOC_INTERFACE =3D           'net.connman.iwd.AdHoc'
 IWD_STATION_INTERFACE =3D         'net.connman.iwd.Station'
 =

-IWD_AGENT_MANAGER_PATH =3D        '/'
-IWD_TOP_LEVEL_PATH =3D            '/'
+IWD_AGENT_MANAGER_PATH =3D        '/net/connman/iwd'
+IWD_TOP_LEVEL_PATH =3D            '/net/connman/iwd'
 =

 =

 dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
-- =

2.13.6

--===============1541955896519975843==--

