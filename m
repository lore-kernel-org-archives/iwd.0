Content-Type: multipart/mixed; boundary="===============7472148426988845487=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/5] station: fix use-after-free on neighbor reports
Date: Thu, 23 Sep 2021 15:57:26 -0700
Message-ID: <20210923225728.556306-3-prestwoj@gmail.com>
In-Reply-To: 20210923225728.556306-1-prestwoj@gmail.com

--===============7472148426988845487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When netdev goes down so does station, but prior to netdev calling
the neighbor report callback. The way the logic was written station
is dereferenced prior to checking for any errors, causing a use
after free.

Since -ENODEV is used in this case check for that early before
accessing station.
---
 src/station.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/station.c b/src/station.c
index 4a41fe05..98fc3cf2 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1709,6 +1709,9 @@ static void station_early_neighbor_report_cb(struct n=
etdev *netdev, int err,
 {
 	struct station *station =3D user_data;
 =

+	if (err =3D=3D -ENODEV)
+		return;
+
 	l_debug("ifindex: %u, error: %d(%s)",
 			netdev_get_ifindex(station->netdev),
 			err, err < 0 ? strerror(-err) : "");
@@ -2281,6 +2284,9 @@ static void station_neighbor_report_cb(struct netdev =
*netdev, int err,
 	struct scan_freq_set *freq_set;
 	int r;
 =

+	if (err =3D=3D -ENODEV)
+		return;
+
 	l_debug("ifindex: %u, error: %d(%s)",
 			netdev_get_ifindex(station->netdev),
 			err, err < 0 ? strerror(-err) : "");
-- =

2.31.1

--===============7472148426988845487==--

