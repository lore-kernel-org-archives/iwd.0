Content-Type: multipart/mixed; boundary="===============6332981876896231128=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH v2 1/2] netdev: preserve cur_rssi_low across reassociation
Date: Thu, 28 Jan 2021 13:24:30 +0000
Message-ID: <20210128132428.1402427-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6332981876896231128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix an issue with the recent changes to signal monitoring from commit
f456501b ("station: retry roaming unless notified of a high RSSI"):

    1. driver sends NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW
    2. netdev->cur_rssi_low changes from FALSE to TRUE
    3. netdev sends NETDEV_EVENT_RSSI_THRESHOLD_LOW to station
    4. on roam reassociation, cur_rssi_low is reset to FALSE
    5. station still assumes RSSI is low, periodically roams
       until netdev sends NETDEV_EVENT_RSSI_THRESHOLD_HIGH
    6. driver sends NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH
    7. netdev->cur_rssi_low doesn't change (still FALSE)
    8. netdev never sends NETDEV_EVENT_RSSI_THRESHOLD_HIGH
    9. station remains stuck in an infinite roaming loop

The commit in question introduced the logic in (5). Previously the
assumption in station was - like in netdev - that if the signal was
still low, the driver would send a duplicate LOW event after
reassociation. This change makes netdev follow the same new logic as
station, i.e. assume the same signal state (LOW/HIGH) until told
otherwise by the driver.
---
v1 -> v2:
- No changes to this patch, but added an autotest to the patch series to
  validate the fix
 src/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index a19270c0..630f61f5 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -659,6 +659,7 @@ static void netdev_connect_free(struct netdev *netdev)
 	netdev->in_ft =3D false;
 	netdev->ignore_connect_event =3D false;
 	netdev->expect_connect_failure =3D false;
+	netdev->cur_rssi_low =3D false;
 =

 	if (netdev->connect_cmd) {
 		l_genl_msg_unref(netdev->connect_cmd);
@@ -2810,7 +2811,6 @@ static int netdev_connect_common(struct netdev *netde=
v,
 	netdev->handshake =3D hs;
 	netdev->sm =3D sm;
 	netdev->frequency =3D bss->frequency;
-	netdev->cur_rssi_low =3D false; /* Gets updated on the 1st CQM event */
 	netdev->cur_rssi =3D bss->signal_strength / 100;
 	netdev_rssi_level_init(netdev);
 =

-- =

2.29.2
--===============6332981876896231128==--

