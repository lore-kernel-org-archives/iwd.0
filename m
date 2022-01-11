Content-Type: multipart/mixed; boundary="===============8450125639257892074=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 5/6] offchannel: use work priorities rather than hard coding
Date: Tue, 11 Jan 2022 09:45:13 -0800
Message-ID: <20220111174514.1074967-5-prestwoj@gmail.com>
In-Reply-To: 20220111174514.1074967-1-prestwoj@gmail.com

--===============8450125639257892074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The offchannel priority was also changed to zero, which matches the
priority of frames. Currently there should be no interaction between
offchannel and connect (previous offchannel priority).
---
 src/offchannel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/offchannel.c b/src/offchannel.c
index e01f76c7..c6fed569 100644
--- a/src/offchannel.c
+++ b/src/offchannel.c
@@ -168,8 +168,9 @@ uint32_t offchannel_start(uint64_t wdev_id, uint32_t fr=
eq, uint32_t duration,
 	 */
 	info->error =3D -ECANCELED;
 =

-	return wiphy_radio_work_insert(wiphy_find_by_wdev(wdev_id),
-					&info->work, 1, &offchannel_work_ops);
+	return wiphy_radio_work_insert(wiphy_find_by_wdev(wdev_id), &info->work,
+					WIPHY_WORK_PRIORITY_OFFCHANNEL,
+					&offchannel_work_ops);
 }
 =

 void offchannel_cancel(uint64_t wdev_id, uint32_t id)
-- =

2.31.1

--===============8450125639257892074==--

