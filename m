Content-Type: multipart/mixed; boundary="===============8913800046399080986=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 5/9] netdev: change netdev_get_oci to be used as a callback
Date: Mon, 27 Sep 2021 10:04:00 -0700
Message-ID: <20210927170404.1292107-5-prestwoj@gmail.com>
In-Reply-To: 20210927170404.1292107-1-prestwoj@gmail.com

--===============8913800046399080986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This can be reused to be called from ft.c
---
 src/netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index d69962d1..5a44895d 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2077,8 +2077,9 @@ done:
 	L_WARN_ON(!eapol_start(netdev->sm));
 }
 =

-static int netdev_get_oci(struct netdev *netdev)
+static int netdev_get_oci(void *user_data)
 {
+	struct netdev *netdev =3D user_data;
 	struct l_genl_msg *msg =3D
 			l_genl_msg_new_sized(NL80211_CMD_GET_INTERFACE, 64);
 =

-- =

2.31.1

--===============8913800046399080986==--

