Content-Type: multipart/mixed; boundary="===============4676452169833349379=="
MIME-Version: 1.0
From: Rosen Penev <rosenp@gmail.com>
Subject: [PATCH 3/3] nlmon: make len parameter a size_t
Date: Thu, 09 Apr 2020 17:38:31 -0700
Message-ID: <20200410003831.258910-3-rosenp@gmail.com>
In-Reply-To: <20200410003831.258910-1-rosenp@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4676452169833349379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes a sign comparison warning. Found with -Wsign-compare
---
 monitor/nlmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index df628c2c..e54ae2e9 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -7171,7 +7171,7 @@ static bool nlmon_receive(struct l_io *io, void *user=
_data)
 	unsigned char buf[8192];
 	unsigned char control[32];
 	ssize_t bytes_read;
-	int nlmsg_len;
+	size_t nlmsg_len;
 	int fd;
 =

 	fd =3D l_io_get_fd(io);
-- =

2.25.1

--===============4676452169833349379==--

