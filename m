Content-Type: multipart/mixed; boundary="===============1575409153843568994=="
MIME-Version: 1.0
From: Diederik de Haas <didi.debian at cknow.org>
To: iwd at lists.01.org
Subject: [PATCH] dpp: fix 2 spelling errors
Date: Fri, 14 Jan 2022 18:38:48 +0100
Message-ID: <20220114173847.11777-1-didi.debian@cknow.org>

--===============1575409153843568994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
Hopefully I did it correctly.

 src/dpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/dpp.c b/src/dpp.c
index f33b655b..78e8ffc5 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1254,7 +1254,7 @@ static void dpp_presence_announce(struct dpp_sm *dpp)
 	iov[1].iov_base =3D attrs;
 	iov[1].iov_len =3D ptr - attrs;
 =

-	l_debug("Sending presense annoucement on frequency %u and waiting %u",
+	l_debug("Sending presence announcement on frequency %u and waiting %u",
 		dpp->current_freq, dpp->dwell);
 =

 	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
-- =

2.34.1

--===============1575409153843568994==--

