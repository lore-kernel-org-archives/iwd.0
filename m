Content-Type: multipart/mixed; boundary="===============0466650392044453776=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 1/6] wiphy: define work priorities in one place
Date: Tue, 11 Jan 2022 09:45:09 -0800
Message-ID: <20220111174514.1074967-1-prestwoj@gmail.com>

--===============0466650392044453776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Work priority was never explicitly defined anywhere, and a module
using wiphy_radio_work APIs needed to ensure it was not inserting
at a priority that would interfere with other work.

Now all the types of work have been defined with their own priority
and future priorities can easily be added before, after, or in
between existing priorities.
---
 src/wiphy.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/wiphy.h b/src/wiphy.h
index 592eba70..fee5d41f 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -45,6 +45,12 @@ struct wiphy_radio_work_item {
 	const struct wiphy_radio_work_item_ops *ops;
 };
 =

+#define WIPHY_WORK_PRIORITY_FRAME		0
+#define WIPHY_WORK_PRIORITY_OFFCHANNEL		0
+#define WIPHY_WORK_PRIORITY_CONNECT		1
+#define WIPHY_WORK_PRIORITY_SCAN		2
+#define WIPHY_WORK_PRIORITY_PERIODIC_SCAN	3
+
 enum wiphy_state_watch_event {
 	WIPHY_STATE_WATCH_EVENT_POWERED,
 	WIPHY_STATE_WATCH_EVENT_RFKILLED,
-- =

2.31.1

--===============0466650392044453776==--

