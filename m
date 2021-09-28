Content-Type: multipart/mixed; boundary="===============6219611342648437471=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/9] netdev: set result/status for deauth path
Date: Tue, 28 Sep 2021 14:27:38 -0700
Message-ID: <20210928212744.717276-3-prestwoj@gmail.com>
In-Reply-To: 20210928212744.717276-1-prestwoj@gmail.com

--===============6219611342648437471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the deauth path was triggered IWD would deauth but end up
calling the connect callback with whatever result netdev had
set, e.g. 'NETDEV_RESULT_OK'. This, of course, caused station
some confusion.
---
 src/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 38598259..bedc8377 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2621,6 +2621,8 @@ error:
 	return;
 =

 deauth:
+	netdev->result =3D NETDEV_RESULT_ASSOCIATION_FAILED;
+	netdev->last_code =3D MMPDU_STATUS_CODE_UNSPECIFIED;
 	msg =3D netdev_build_cmd_deauthenticate(netdev,
 						MMPDU_REASON_CODE_UNSPECIFIED);
 	netdev->disconnect_cmd_id =3D l_genl_family_send(nl80211,
-- =

2.31.1

--===============6219611342648437471==--

