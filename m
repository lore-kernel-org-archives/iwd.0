Content-Type: multipart/mixed; boundary="===============8545828381543633007=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 02/14] netconfig: Change public API
Date: Fri, 27 Sep 2019 17:12:21 -0700
Message-ID: <20190928001233.19217-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20190928001233.19217-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8545828381543633007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As a first step to enable the usage of netconfig in ead and
prospective transition to be a part of ell, the public API for
creation and destruction of the netconfig objects has been
renamed and changed. Instead of hiding the netconfig objects inside
of netconfig module, the object is now passed back to the caller.
The internal queue of netconfig objects remains untouched, due
to limitations in ell=E2=80=99s implementation of rtnl. After the proper
changes are done to ell, netconfig_list is expected to be removed
from netconfig module.
---
 src/netconfig.c | 34 ++++++++--------------------------
 src/netconfig.h |  6 ++++--
 src/station.c   |  7 +++++--
 3 files changed, 17 insertions(+), 30 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 25ac014a..2074689f 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -94,17 +94,6 @@ static void netconfig_free(void *data)
 	l_free(netconfig);
 }
 =

-static bool netconfig_match(const void *a, const void *b)
-{
-	const struct netconfig *netconfig =3D a;
-	uint32_t ifindex =3D L_PTR_TO_UINT(b);
-
-	if (netconfig->ifindex =3D=3D ifindex)
-		return true;
-
-	return false;
-}
-
 static struct netconfig *netconfig_find(uint32_t ifindex)
 {
 	const struct l_queue_entry *entry;
@@ -696,23 +685,23 @@ static void netconfig_station_state_changed(enum stat=
ion_state state,
 	netconfig->station_state =3D state;
 }
 =

-bool netconfig_ifindex_add(uint32_t ifindex)
+struct netconfig *netconfig_new(uint32_t ifindex)
 {
 	struct netconfig *netconfig;
 	struct station *station;
 =

 	if (!netconfig_list)
-		return false;
+		return NULL;
 =

 	l_debug("Starting netconfig for interface: %d", ifindex);
 =

 	netconfig =3D netconfig_find(ifindex);
 	if (netconfig)
-		return true;
+		return netconfig;
 =

 	station =3D station_find(ifindex);
 	if (!station)
-		return false;
+		return NULL;
 =

 	netconfig =3D l_new(struct netconfig, 1);
 	netconfig->ifindex =3D ifindex;
@@ -725,22 +714,17 @@ bool netconfig_ifindex_add(uint32_t ifindex)
 =

 	l_queue_push_tail(netconfig_list, netconfig);
 =

-	return true;
+	return netconfig;
 }
 =

-bool netconfig_ifindex_remove(uint32_t ifindex)
+void netconfig_destroy(struct netconfig *netconfig)
 {
-	struct netconfig *netconfig;
-
 	if (!netconfig_list)
-		return false;
+		return;
 =

 	l_debug();
 =

-	netconfig =3D l_queue_remove_if(netconfig_list, netconfig_match,
-							L_UINT_TO_PTR(ifindex));
-	if (!netconfig)
-		return false;
+	l_queue_remove(netconfig_list, netconfig);
 =

 	if (netconfig->station_state !=3D STATION_STATE_DISCONNECTED) {
 		netconfig_ipv4_select_and_uninstall(netconfig);
@@ -751,8 +735,6 @@ bool netconfig_ifindex_remove(uint32_t ifindex)
 	}
 =

 	netconfig_free(netconfig);
-
-	return true;
 }
 =

 static int netconfig_init(void)
diff --git a/src/netconfig.h b/src/netconfig.h
index 1df28cd9..fd344830 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -20,5 +20,7 @@
  *
  */
 =

-bool netconfig_ifindex_add(uint32_t ifindex);
-bool netconfig_ifindex_remove(uint32_t ifindex);
+struct netconfig;
+
+struct netconfig *netconfig_new(uint32_t ifindex);
+void netconfig_destroy(struct netconfig *netconfig);
diff --git a/src/station.c b/src/station.c
index a89c44d1..02c5260b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -88,6 +88,8 @@ struct station {
 =

 	struct l_queue *anqp_pending;
 =

+	struct netconfig *netconfig;
+
 	bool preparing_roam : 1;
 	bool signal_low : 1;
 	bool roam_no_orig_ap : 1;
@@ -3021,7 +3023,7 @@ static struct station *station_create(struct netdev *=
netdev)
 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
 					IWD_STATION_INTERFACE, station);
 =

-	netconfig_ifindex_add(netdev_get_ifindex(netdev));
+	station->netconfig =3D netconfig_new(netdev_get_ifindex(netdev));
 =

 	station->anqp_pending =3D l_queue_new();
 =

@@ -3038,7 +3040,8 @@ static void station_free(struct station *station)
 	if (station->connected_bss)
 		netdev_disconnect(station->netdev, NULL, NULL);
 =

-	netconfig_ifindex_remove(netdev_get_ifindex(station->netdev));
+	netconfig_destroy(station->netconfig);
+	station->netconfig =3D NULL;
 =

 	periodic_scan_stop(station);
 =

-- =

2.13.6

--===============8545828381543633007==--

