Content-Type: multipart/mixed; boundary="===============5862298347719374025=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/4] wiphy: make wiphy work queue reentrancy safe
Date: Mon, 22 Nov 2021 12:44:25 -0800
Message-ID: <20211122204425.3567479-4-prestwoj@gmail.com>
In-Reply-To: 20211122204425.3567479-1-prestwoj@gmail.com

--===============5862298347719374025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now both the do_work and destroy callback can safely insert new
work items without causing problems.
---
 src/wiphy.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 58ed0a87..339e13ca 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -118,6 +118,7 @@ struct wiphy {
 	char regdom_country[2];
 	/* Work queue for this radio */
 	struct l_queue *work;
+	bool work_in_callback;
 =

 	bool support_scheduled_scan:1;
 	bool support_rekey_offload:1;
@@ -1924,14 +1925,19 @@ static void wiphy_radio_work_next(struct wiphy *wip=
hy)
 	work->priority =3D INT_MIN;
 =

 	l_debug("Starting work item %u", work->id);
+
+	wiphy->work_in_callback =3D true;
 	done =3D work->ops->do_work(work);
+	wiphy->work_in_callback =3D false;
 =

 	if (done) {
 		work->id =3D 0;
 =

 		l_queue_remove(wiphy->work, work);
 =

+		wiphy->work_in_callback =3D true;
 		destroy_work(work);
+		wiphy->work_in_callback =3D false;
 =

 		wiphy_radio_work_next(wiphy);
 	}
@@ -1961,7 +1967,7 @@ uint32_t wiphy_radio_work_insert(struct wiphy *wiphy,
 =

 	l_queue_insert(wiphy->work, item, insert_by_priority, NULL);
 =

-	if (l_queue_length(wiphy->work) =3D=3D 1)
+	if (l_queue_length(wiphy->work) =3D=3D 1 && !wiphy->work_in_callback)
 		wiphy_radio_work_next(wiphy);
 =

 	return item->id;
@@ -1999,7 +2005,9 @@ void wiphy_radio_work_done(struct wiphy *wiphy, uint3=
2_t id)
 =

 	item->id =3D 0;
 =

+	wiphy->work_in_callback =3D true;
 	destroy_work(item);
+	wiphy->work_in_callback =3D false;
 =

 	if (next)
 		wiphy_radio_work_next(wiphy);
-- =

2.31.1

--===============5862298347719374025==--

