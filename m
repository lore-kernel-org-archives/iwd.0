Content-Type: multipart/mixed; boundary="===============5318720900274024312=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] anqp: return the request ID rather than true
Date: Mon, 08 Nov 2021 09:24:37 -0800
Message-ID: <20211108172437.989966-1-prestwoj@gmail.com>

--===============5318720900274024312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/anqp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/anqp.c b/src/anqp.c
index a3c46635..8febdf91 100644
--- a/src/anqp.c
+++ b/src/anqp.c
@@ -256,7 +256,7 @@ uint32_t anqp_request(uint64_t wdev_id, const uint8_t *=
addr,
 				&anqp_frame_prefix, anqp_response_frame_event,
 				NULL);
 =

-	return true;
+	return request->id;
 }
 =

 void anqp_cancel(uint32_t id)
-- =

2.31.1

--===============5318720900274024312==--

