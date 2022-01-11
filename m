Content-Type: multipart/mixed; boundary="===============2886825791686079475=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/3] scan: fix double space
Date: Mon, 10 Jan 2022 16:15:17 -0800
Message-ID: <20220111001519.1013183-1-prestwoj@gmail.com>

--===============2886825791686079475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/scan.c b/src/scan.c
index 97b0a933..54159dfd 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1695,7 +1695,7 @@ static void scan_finished(struct scan_context *sc,
 	if (bss_list)
 		discover_hidden_network_bsses(sc, bss_list);
 =

-	if  (sr) {
+	if (sr) {
 		l_queue_remove(sc->requests, sr);
 		sc->started =3D false;
 		sc->work_started =3D false;
-- =

2.31.1

--===============2886825791686079475==--

