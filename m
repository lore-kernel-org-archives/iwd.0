Content-Type: multipart/mixed; boundary="===============4699790046292549662=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/4] test-runner: increase test timeout maximum
Date: Tue, 02 Nov 2021 12:57:52 -0700
Message-ID: <20211102195752.381604-4-prestwoj@gmail.com>
In-Reply-To: 20211102195752.381604-1-prestwoj@gmail.com

--===============4699790046292549662==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The OWE transition tests takes quite a while and sometimes hits the
maximum timeout.
---
 tools/test-runner | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner b/tools/test-runner
index d62f8b51..9ae33301 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -45,7 +45,7 @@ TIOCSTTY =3D 0x540E
 config =3D None
 intf_id =3D 0
 =

-TEST_MAX_TIMEOUT =3D 120
+TEST_MAX_TIMEOUT =3D 240
 =

 dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
 =

-- =

2.31.1

--===============4699790046292549662==--

