Content-Type: multipart/mixed; boundary="===============5584939964947939502=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] monitor: fix integer comparison error (clang)
Date: Fri, 10 Jun 2022 12:27:26 -0700
Message-ID: <20220610192726.421340-1-prestwoj@gmail.com>

--===============5584939964947939502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Though the documentation for NLMSG_OK uses an int type for the length
the actual check is based on nlmsghdr->nlmsg_len which is a 32 bit
unsigned integer. Clang was complaining about one call in nlmon.c
because nlmsg_len was int type. Every other usage in nlmon.c uses
a uint32_t, so use that both for consistency and to fix the warning.

monitor/nlmon.c:7998:29: error: comparison of integers of different
		signs: '__u32' (aka 'unsigned int') and 'int'
		[-Werror,-Wsign-compare]
        for (nlmsg =3D iov.iov_base; NLMSG_OK(nlmsg, nlmsg_len);
                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/linux/netlink.h:100:24: note: expanded from macro 'NLMSG_OK'
                           (nlh)->nlmsg_len <=3D (len))
---
 monitor/nlmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index fe967922..34c5eed6 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -7944,7 +7944,7 @@ static bool nlmon_receive(struct l_io *io, void *user=
_data)
 	unsigned char buf[8192];
 	unsigned char control[32];
 	ssize_t bytes_read;
-	int nlmsg_len;
+	uint32_t nlmsg_len;
 	int fd;
 =

 	fd =3D l_io_get_fd(io);
-- =

2.34.1

--===============5584939964947939502==--

