Content-Type: multipart/mixed; boundary="===============6091408714766563928=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/2] wiphy: add wiphy_radio_work_is_running
Date: Mon, 05 Apr 2021 14:26:49 -0700
Message-ID: <20210405212650.1042486-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6091408714766563928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This provides a way to know if a work item is actually running
vs only been queued and waiting to run.
---
 src/wiphy.c | 7 +++++++
 src/wiphy.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 9cf0e07c..c371968e 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1615,6 +1615,13 @@ void wiphy_radio_work_done(struct wiphy *wiphy, uint=
32_t id)
 		wiphy_radio_work_next(wiphy);
 }
 =

+bool wiphy_radio_work_is_running(struct wiphy *wiphy, uint32_t id)
+{
+	struct wiphy_radio_work_item *item =3D l_queue_peek_head(wiphy->work);
+
+	return item->id =3D=3D id;
+}
+
 static int wiphy_init(void)
 {
 	struct l_genl *genl =3D iwd_get_genl();
diff --git a/src/wiphy.h b/src/wiphy.h
index 6c91220c..50fcb182 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -116,3 +116,4 @@ uint32_t wiphy_radio_work_insert(struct wiphy *wiphy,
 				int priority,
 				const struct wiphy_radio_work_item_ops *ops);
 void wiphy_radio_work_done(struct wiphy *wiphy, uint32_t id);
+bool wiphy_radio_work_is_running(struct wiphy *wiphy, uint32_t id);
-- =

2.26.2

--===============6091408714766563928==--

