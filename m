Content-Type: multipart/mixed; boundary="===============1827159940782796755=="
MIME-Version: 1.0
From: Will Dietz <w@wdtz.org>
Subject: [PATCH] Don't pass NULL as src to memcpy, even when zero len.
Date: Mon, 28 Oct 2019 14:42:01 -0500
Message-ID: <20191028194201.12372-1-w@wdtz.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1827159940782796755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Skip the memcpy when len =3D 0, definitely don't ignore attempt
to copy X bytes from NULL where X !=3D 0 :).
---
 monitor/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/main.c b/monitor/main.c
index 020dba86..41692cd1 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -176,7 +176,8 @@ static size_t rta_add(void *rta_buf, unsigned short typ=
e, uint16_t len,
 =

 	rta->rta_len =3D rta_len;
 	rta->rta_type =3D type;
-	memcpy(RTA_DATA(rta), data, len);
+	if (len)
+		memcpy(RTA_DATA(rta), data, len);
 =

 	return RTA_SPACE(len);
 }
-- =

2.24.0-rc1

--===============1827159940782796755==--

