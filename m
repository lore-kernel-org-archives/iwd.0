Content-Type: multipart/mixed; boundary="===============4193092546227228208=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 10/12] wired: update with new eap_init
Date: Fri, 11 Oct 2019 12:29:31 -0700
Message-ID: <20191011192933.13550-10-prestwoj@gmail.com>
In-Reply-To: <20191011192933.13550-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4193092546227228208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 wired/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wired/main.c b/wired/main.c
index 7e6d26dd..09dbb72d 100644
--- a/wired/main.c
+++ b/wired/main.c
@@ -46,7 +46,7 @@ static void dbus_ready(struct l_dbus *dbus, void *user_da=
ta)
 =

 	l_info("System ready");
 =

-	eap_init(0);
+	eap_init();
 	network_init();
 	ethdev_init(opts->interfaces, opts->nointerfaces);
 }
-- =

2.17.1

--===============4193092546227228208==--

