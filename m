Content-Type: multipart/mixed; boundary="===============8560254633606508896=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] simauth: check driver for NULL before canceling request
Date: Mon, 16 Nov 2020 14:22:18 -0800
Message-ID: <20201116222218.3486513-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8560254633606508896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the ofono modem got removed before it was fully initialized this
could cause a crash.
---
 src/simauth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/simauth.c b/src/simauth.c
index a0d56c76..01e252c3 100644
--- a/src/simauth.c
+++ b/src/simauth.c
@@ -99,7 +99,7 @@ static void destroy_provider(void *data)
 =

 void iwd_sim_auth_remove(struct iwd_sim_auth *auth)
 {
-	if (auth->driver->cancel_request)
+	if (auth->driver && auth->driver->cancel_request)
 		auth->driver->cancel_request(auth, auth->pending);
 =

 	WATCHLIST_NOTIFY_NO_ARGS(&auth->auth_watchers,
-- =

2.26.2

--===============8560254633606508896==--

