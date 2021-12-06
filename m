Content-Type: multipart/mixed; boundary="===============6396960845672544542=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 1/2] wiphy: update wiphy_radio_work_is_running to return int
Date: Mon, 06 Dec 2021 10:19:55 -0800
Message-ID: <20211206181956.1161332-1-prestwoj@gmail.com>

--===============6396960845672544542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This differentiates between pending, running, and non-existent:
1, 0, -ENOENT respectively
---
 src/wiphy.c | 10 +++++-----
 src/wiphy.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index bb1f9824..219a3695 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -2013,14 +2013,14 @@ void wiphy_radio_work_done(struct wiphy *wiphy, uin=
t32_t id)
 		wiphy_radio_work_next(wiphy);
 }
 =

-bool wiphy_radio_work_is_running(struct wiphy *wiphy, uint32_t id)
+int wiphy_radio_work_is_running(struct wiphy *wiphy, uint32_t id)
 {
-	struct wiphy_radio_work_item *item =3D l_queue_peek_head(wiphy->work);
-
+	struct wiphy_radio_work_item *item =3D l_queue_find(wiphy->work, match_id,
+							L_UINT_TO_PTR(id));
 	if (!item)
-		return false;
+		return -ENOENT;
 =

-	return item->id =3D=3D id;
+	return item =3D=3D l_queue_peek_head(wiphy->work) ? 0 : 1;
 }
 =

 static int wiphy_init(void)
diff --git a/src/wiphy.h b/src/wiphy.h
index 9f0d6d07..592eba70 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -130,4 +130,4 @@ uint32_t wiphy_radio_work_insert(struct wiphy *wiphy,
 				int priority,
 				const struct wiphy_radio_work_item_ops *ops);
 void wiphy_radio_work_done(struct wiphy *wiphy, uint32_t id);
-bool wiphy_radio_work_is_running(struct wiphy *wiphy, uint32_t id);
+int wiphy_radio_work_is_running(struct wiphy *wiphy, uint32_t id);
-- =

2.31.1

--===============6396960845672544542==--

