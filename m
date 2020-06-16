Content-Type: multipart/mixed; boundary="===============8543242804945893063=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] plugins: ofono: remove newline from debug print
Date: Tue, 16 Jun 2020 09:04:21 -0700
Message-ID: <20200616160421.13220-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8543242804945893063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index 6f2acda0..186dac71 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -427,7 +427,7 @@ static void modem_destroy(void *data)
 		iwd_sim_auth_remove(modem->auth);
 	}
 =

-	l_debug("removing modem %s\n", modem->path);
+	l_debug("removing modem %s", modem->path);
 =

 	if (modem->apps_serial)
 		l_dbus_cancel(dbus, modem->apps_serial);
-- =

2.21.1

--===============8543242804945893063==--

