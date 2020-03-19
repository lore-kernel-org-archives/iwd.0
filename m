Content-Type: multipart/mixed; boundary="===============2399588394707368568=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/9] wsc: Don't start connections until Cancel finishes
Date: Thu, 19 Mar 2020 22:12:13 +0100
Message-ID: <20200319211218.32083-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200319211218.32083-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2399588394707368568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Return busy from StartPin and PushButton if the Cancel method is still
running.
---
 src/wsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/wsc.c b/src/wsc.c
index 393e8d8d..e9ebe5f5 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -1111,7 +1111,7 @@ static struct l_dbus_message *wsc_push_button(struct =
l_dbus *dbus,
 	if (!l_dbus_message_get_arguments(message, ""))
 		return dbus_error_invalid_args(message);
 =

-	if (wsc->pending_connect)
+	if (wsc->pending_connect || wsc->pending_cancel)
 		return dbus_error_busy(message);
 =

 	wsc->pending_connect =3D l_dbus_message_ref(message);
@@ -1150,7 +1150,7 @@ static struct l_dbus_message *wsc_start_pin(struct l_=
dbus *dbus,
 =

 	l_debug("");
 =

-	if (wsc->pending_connect)
+	if (wsc->pending_connect || wsc->pending_cancel)
 		return dbus_error_busy(message);
 =

 	if (!l_dbus_message_get_arguments(message, "s", &pin))
-- =

2.20.1

--===============2399588394707368568==--

