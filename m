Content-Type: multipart/mixed; boundary="===============3288569037505319226=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/2] offchannel: always use -ECANCELED for cancelation
Date: Thu, 16 Dec 2021 10:00:03 -0800
Message-ID: <20211216180003.38883-2-prestwoj@gmail.com>
In-Reply-To: 20211216180003.38883-1-prestwoj@gmail.com

--===============3288569037505319226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

info->error gets reset to zero on a successful ROC callback
which was getting used for cancelation.
---
 src/offchannel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/offchannel.c b/src/offchannel.c
index 4db3fcf2..e01f76c7 100644
--- a/src/offchannel.c
+++ b/src/offchannel.c
@@ -231,7 +231,7 @@ void offchannel_cancel(uint64_t wdev_id, uint32_t id)
 =

 destroy:
 	if (info->destroy)
-		info->destroy(info->error, info->user_data);
+		info->destroy(-ECANCELED, info->user_data);
 =

 	info->destroy =3D NULL;
 	info->started =3D NULL;
-- =

2.31.1

--===============3288569037505319226==--

