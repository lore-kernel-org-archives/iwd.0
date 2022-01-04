Content-Type: multipart/mixed; boundary="===============1284289118199694861=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/6] auto-t: iwd.py: remove unused members
Date: Tue, 04 Jan 2022 10:18:53 -0800
Message-ID: <20220104181857.103331-2-prestwoj@gmail.com>
In-Reply-To: 20220104181857.103331-1-prestwoj@gmail.com

--===============1284289118199694861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/iwd.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 7f511187..34af1127 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -231,8 +231,6 @@ class StationDebug(IWDDBusAbstract):
     _iface_name =3D IWD_STATION_DEBUG_INTERFACE
 =

     def __init__(self, *args, **kwargs):
-        self._debug_props =3D None
-        self._debug_iface =3D None
         self._last_event =3D None
         self._last_event_data =3D []
 =

-- =

2.31.1

--===============1284289118199694861==--

