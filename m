Content-Type: multipart/mixed; boundary="===============8649836763072399231=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] wsc: Clear the pin copy in wsc_generate_pin
Date: Fri, 03 Apr 2020 18:45:11 +0200
Message-ID: <20200403164512.19008-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8649836763072399231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/wsc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/wsc.c b/src/wsc.c
index e9ebe5f5..ba58b6d4 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -1137,6 +1137,7 @@ static struct l_dbus_message *wsc_generate_pin(struct=
 l_dbus *dbus,
 =

 	reply =3D l_dbus_message_new_method_return(message);
 	l_dbus_message_set_arguments(reply, "s", pin);
+	explicit_bzero(pin, 9);
 =

 	return reply;
 }
-- =

2.20.1

--===============8649836763072399231==--

