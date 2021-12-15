Content-Type: multipart/mixed; boundary="===============8973887726026590441=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/2] offchannel: always call destroy right away on cancel
Date: Wed, 15 Dec 2021 09:41:46 -0800
Message-ID: <20211215174146.2465846-2-prestwoj@gmail.com>
In-Reply-To: 20211215174146.2465846-1-prestwoj@gmail.com

--===============8973887726026590441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The main cancel code path was not calling destroy immediately which
was not consistent with other code paths/APIs.
---
 src/offchannel.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/src/offchannel.c b/src/offchannel.c
index ad35f4f6..4db3fcf2 100644
--- a/src/offchannel.c
+++ b/src/offchannel.c
@@ -208,20 +208,10 @@ void offchannel_cancel(uint64_t wdev_id, uint32_t id)
 			goto work_done;
 		}
 =

-		/*
-		 * Call destroy now to maintain consistency with any other
-		 * path leading to radio_work_done(). But set needs_cancel so
-		 * the ROC command can be canceled
-		 */
-		if (info->destroy)
-			info->destroy(info->error, info->user_data);
-
-		info->destroy =3D NULL;
-		info->started =3D NULL;
-		info->user_data =3D NULL;
+		/* Lets the ROC callback know it needs to cancel the request */
 		info->needs_cancel =3D true;
 =

-		return;
+		goto destroy;
 	}
 =

 	/*
@@ -239,6 +229,14 @@ void offchannel_cancel(uint64_t wdev_id, uint32_t id)
 	 */
 	offchannel_cancel_roc(info);
 =

+destroy:
+	if (info->destroy)
+		info->destroy(info->error, info->user_data);
+
+	info->destroy =3D NULL;
+	info->started =3D NULL;
+	info->user_data =3D NULL;
+
 	return;
 =

 work_done:
-- =

2.31.1

--===============8973887726026590441==--

