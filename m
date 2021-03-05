Content-Type: multipart/mixed; boundary="===============5832748583662206373=="
MIME-Version: 1.0
From: Jonathan Liu <net147@gmail.com>
Subject: [PATCH] client: add missing bracket for "ap <wlan> show"
Date: Fri, 05 Mar 2021 22:51:25 +1100
Message-ID: <20210305115125.678039-1-net147@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5832748583662206373==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes: 9659c936cd1f ("client: implement "ap <wlan> show"")
---
 client/ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/ap.c b/client/ap.c
index b0386c60..0f14e9b8 100644
--- a/client/ap.c
+++ b/client/ap.c
@@ -310,7 +310,7 @@ static const struct command ap_commands[] =3D {
 		"Start an access point based on a disk profile" },
 	{ "<wlan>", "stop", NULL,   cmd_stop, "Stop a started access\n"
 		"\t\t\t\t\t\t    point" },
-	{ "<wlan", "show", NULL, cmd_show, "Show AP info", false },
+	{ "<wlan>", "show", NULL, cmd_show, "Show AP info", false },
 	{ }
 };
 =

-- =

2.30.1

--===============5832748583662206373==--

