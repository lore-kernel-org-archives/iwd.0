Content-Type: multipart/mixed; boundary="===============2953661596837364441=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] netdev: fix segfault due to roaming before connected
Date: Mon, 04 May 2020 14:30:55 -0700
Message-ID: <20200504213055.8330-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2953661596837364441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In this situation the kernel is sending a low RSSI event which netdev
picks up, but since we set netdev->connected so early the event is
forwarded to station before IWD has fully connected. Station then
tries to get a neighbor report, which may fail and cause a known
frequency scan. If this is a new network the frequency scan tries to
get any known frequencies in network_info which will be unset and
cause a segfault.

This can be avoided by only sending RSSI events when netdev->operational
is set rather than netdev->connected.
---
 src/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 69f9ab85..b3c3bf73 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -678,7 +678,7 @@ static void netdev_cqm_event_rssi_threshold(struct netd=
ev *netdev,
 {
 	int event;
 =

-	if (!netdev->connected)
+	if (!netdev->operational)
 		return;
 =

 	if (rssi_event !=3D NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW &&
-- =

2.21.1

--===============2953661596837364441==--

