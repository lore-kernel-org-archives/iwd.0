Content-Type: multipart/mixed; boundary="===============8403248381572948783=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/3] p2p: fix warning for uninitialized variable (clang)
Date: Fri, 10 Jun 2022 12:52:41 -0700
Message-ID: <20220610195242.455453-2-prestwoj@gmail.com>
In-Reply-To: 20220610195242.455453-1-prestwoj@gmail.com

--===============8403248381572948783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is actually a false positive only because
p2p_device_validate_conn_wfd bails out if the IE is NULL which
avoids using wfd_data_length. But its subtle and without inspecting
the code it does seem like the length could be used uninitialized.

src/p2p.c:940:7: error: variable 'wfd_data_len' is used uninitialized whene=
ver 'if' condition is false [-Werror,-Wsometimes-uninitialized]
                if (dev->conn_own_wfd)
                    ^~~~~~~~~~~~~~~~~
src/p2p.c:946:8: note: uninitialized use occurs here
                                                        wfd_data_len))
                                                        ^~~~~~~~~~~~
src/p2p.c:940:3: note: remove the 'if' if its condition is always true
                if (dev->conn_own_wfd)
                ^~~~~~~~~~~~~~~~~~~~~~
src/p2p.c:906:23: note: initialize the variable 'wfd_data_len' to silence t=
his warning
                ssize_t wfd_data_len;
                                    ^
                                     =3D 0
---
 src/p2p.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/p2p.c b/src/p2p.c
index ebd0f62b..a7207c30 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -903,7 +903,7 @@ static void p2p_group_event(enum ap_event_type type, co=
nst void *event_data,
 	{
 		const struct ap_event_station_added_data *data =3D event_data;
 		L_AUTO_FREE_VAR(uint8_t *, wfd_data) =3D NULL;
-		ssize_t wfd_data_len;
+		ssize_t wfd_data_len =3D 0;
 		struct p2p_association_req req_info;
 		int r;
 =

-- =

2.34.1

--===============8403248381572948783==--

