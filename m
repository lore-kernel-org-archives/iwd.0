Content-Type: multipart/mixed; boundary="===============7874829757386724886=="
MIME-Version: 1.0
From: Rosen Penev <rosenp@gmail.com>
Subject: [PATCH] nlmon: fix -Wformat under musl 1.2.0
Date: Wed, 01 Apr 2020 19:16:50 -0700
Message-ID: <20200402021650.790030-1-rosenp@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7874829757386724886==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

musl 1.2.0 uses 64-bit time, even under 32-bit OSes. Cast to int64_t
and use the proper macro.
---
 monitor/nlmon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 0aeaea31..1f269ff0 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -216,8 +216,9 @@ static void print_packet(const struct timeval *tv, char=
 ident,
 				ts_pos +=3D n;
 		}
 =

-		n =3D sprintf(ts_str + ts_pos, " %lu.%06lu",
-					tv->tv_sec - time_offset, tv->tv_usec);
+		n =3D sprintf(ts_str + ts_pos, " %" PRId64 ".%06" PRId64,
+					(int64_t)tv->tv_sec - time_offset,
+					(int64_t)tv->tv_usec);
 		if (n > 0) {
 			ts_pos +=3D n;
 			ts_len +=3D n;
-- =

2.25.1

--===============7874829757386724886==--

