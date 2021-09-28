Content-Type: multipart/mixed; boundary="===============6456002161432055896=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 4/9] netdev: change netdev_get_oci to be used as a callback
Date: Tue, 28 Sep 2021 08:46:53 -0700
Message-ID: <20210928154658.2382597-4-prestwoj@gmail.com>
In-Reply-To: 20210928154658.2382597-1-prestwoj@gmail.com

--===============6456002161432055896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This can be reused to be called from ft.c
---
 src/netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index a931d78e..9a4eff0f 100644
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

--===============6456002161432055896==--

