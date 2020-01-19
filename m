Content-Type: multipart/mixed; boundary="===============0259763404170528764=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] monitor: Add message length check to nlmon_receice
Date: Sun, 19 Jan 2020 17:31:11 +0100
Message-ID: <20200119163111.31753-1-wagi@monom.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0259763404170528764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The NLMSG_NEXT macro calculates the next nlmsg and updates the len
field:

  #define NLMSG_NEXT(nlh,len)	 ((len) -=3D NLMSG_ALIGN((nlh)->nlmsg_len), \
				  (struct nlmsghdr*)(((char*)(nlh)) + NLMSG_ALIGN((nlh)->nlmsg_len)))

That means nlmsg_len needs to be an multiple of NLMSG_ALIGNTO to avoid
an underflow in len. But there are message which do not have a valid
lenght:

  Breakpoint 1, nlmon_receive (io=3D0x4da210, user_data=3D0x4d4cc0) at moni=
tor/nlmon.c:6947
  6947                            printf("malformed packet\n");
  (gdb) bt
  #0  nlmon_receive (io=3D0x4da210, user_data=3D0x4d4cc0) at monitor/nlmon.=
c:6947
  #1  0x0000000000439a91 in io_callback (fd=3D7, events=3D1, user_data=3D0x=
4da210) at ell/io.c:126
  #2  0x0000000000438861 in l_main_iterate (timeout=3D-1) at ell/main.c:473
  #3  0x0000000000438968 in l_main_run () at ell/main.c:520
  #4  0x0000000000438c80 in l_main_run_with_signal (callback=3D0x4038e6 <si=
gnal_handler>, user_data=3D0x0) at ell/main.c:642
  #5  0x0000000000403cc9 in main (argc=3D3, argv=3D0x7fffffffec28) at monit=
or/main.c:806
  (gdb) p nlmsg->nlmsg_len
  $5 =3D 17

By adding an lenght check after each processed message garantees that
we do not underflow. The downside is that as soon an invalid length is
spotted the processing stops.
---
 monitor/nlmon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 6b0afef8a497..5498e9fa0f23 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -6941,6 +6941,11 @@ static bool nlmon_receive(struct l_io *io, void *use=
r_data)
 			nlmon_message(nlmon, tv, tp, nlmsg);
 			break;
 		}
+
+		if (nlmsg->nlmsg_len & (NLMSG_ALIGNTO-1)) {
+			printf("malformed packet\n");
+			break;
+		}
 	}
 =

 	return true;
-- =

2.24.1
--===============0259763404170528764==--

