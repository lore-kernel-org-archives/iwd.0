Content-Type: multipart/mixed; boundary="===============3920666980989229528=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/6] anqp: Only register for frames on station interfaces
Date: Wed, 20 Nov 2019 23:23:41 +0100
Message-ID: <20191120222346.7881-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3920666980989229528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Check the iftype before registering ANQP on new interface.

Not that the check here and in rrm.c (which already checks the iftype)
may need to be extended to run on NETDEV_WATCH_EVENT_UP because a device
could be created with a different iftype and then have the iftype changed
before powering up.
---
 src/anqp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/anqp.c b/src/anqp.c
index f3171456..6627bd81 100644
--- a/src/anqp.c
+++ b/src/anqp.c
@@ -374,7 +374,9 @@ static void anqp_netdev_watch(struct netdev *netdev,
 {
 	switch (event) {
 	case NETDEV_WATCH_EVENT_NEW:
-		anqp_register_frame(netdev_get_ifindex(netdev));
+		if (netdev_get_iftype(netdev) =3D=3D NETDEV_IFTYPE_STATION)
+			anqp_register_frame(netdev_get_ifindex(netdev));
+
 		return;
 	default:
 		break;
-- =

2.20.1

--===============3920666980989229528==--

