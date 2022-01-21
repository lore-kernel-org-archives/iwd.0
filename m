Content-Type: multipart/mixed; boundary="===============8282434936059522878=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 1/3] ap: Don't defer ap_reset when ap_free called in event
Date: Fri, 21 Jan 2022 11:24:37 +0100
Message-ID: <20220121102439.267357-1-andrew.zaborowski@intel.com>

--===============8282434936059522878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Previously we added logic to defer doing anything in ap_free() to after
the AP event handler has returned so that ap_event() has a chance to
inform whoever called it that the ap_state has been freed.  But there's
also a chance that the event handler is destroying both the AP and the
netdev it runs on, so after the handler has returned we can't even use
netdev_get_wdev_id or netdev_get_ifindex.  The easiest solution seems to
be to call ap_reset() in ap_free() even if we're within an event handler
to ensure we no longer need any external objects.  Also make sure
ap_reset() can be called multiple times.

Another option would be to watch for NETDEV_WATCH_EVENT_DEL and remove
our reference to the netdev (because there's no need actually call
l_rtnl_ifaddr_delete or frame_watch_wdev_remove if the netdev was
destroyed -- frame_watch already tracks netdev removals), or to save
just the ifindex and the wdev id...
---
 src/ap.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 32e45865..6f3dfa60 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -207,16 +207,22 @@ static void ap_reset(struct ap_state *ap)
 		ap->authorized_macs_num =3D 0;
 	}
 =

-	if (ap->mlme_watch)
+	if (ap->mlme_watch) {
 		l_genl_family_unregister(ap->nl80211, ap->mlme_watch);
+		ap->mlme_watch =3D 0;
+	}
 =

 	frame_watch_wdev_remove(netdev_get_wdev_id(netdev));
 =

-	if (ap->start_stop_cmd_id)
+	if (ap->start_stop_cmd_id) {
 		l_genl_family_cancel(ap->nl80211, ap->start_stop_cmd_id);
+		ap->start_stop_cmd_id =3D 0;
+	}
 =

-	if (ap->rtnl_add_cmd)
+	if (ap->rtnl_add_cmd) {
 		l_netlink_cancel(rtnl, ap->rtnl_add_cmd);
+		ap->rtnl_add_cmd =3D 0;
+	}
 =

 	if (ap->rtnl_get_gateway4_mac_cmd) {
 		l_netlink_cancel(rtnl, ap->rtnl_get_gateway4_mac_cmd);
@@ -228,12 +234,12 @@ static void ap_reset(struct ap_state *ap)
 		ap->rtnl_get_dns4_mac_cmd =3D 0;
 	}
 =

-	l_queue_destroy(ap->sta_states, ap_sta_free);
+	l_queue_destroy(l_steal_ptr(ap->sta_states), ap_sta_free);
 =

 	if (ap->rates)
-		l_uintset_free(ap->rates);
+		l_uintset_free(l_steal_ptr(ap->rates));
 =

-	l_queue_destroy(ap->wsc_pbc_probes, l_free);
+	l_queue_destroy(l_steal_ptr(ap->wsc_pbc_probes), l_free);
 	l_timeout_remove(ap->wsc_pbc_timeout);
 =

 	ap->started =3D false;
@@ -258,7 +264,8 @@ static bool ap_event_done(struct ap_state *ap, bool pre=
v_in_event)
 	ap->in_event =3D prev_in_event;
 =

 	if (!prev_in_event && ap->free_pending) {
-		ap_free(ap);
+		l_genl_family_free(ap->nl80211);
+		l_free(ap);
 		return true;
 	}
 =

@@ -3386,12 +3393,13 @@ free_ap:
 /* Free @ap without a graceful shutdown */
 void ap_free(struct ap_state *ap)
 {
+	ap_reset(ap);
+
 	if (ap->in_event) {
 		ap->free_pending =3D true;
 		return;
 	}
 =

-	ap_reset(ap);
 	l_genl_family_free(ap->nl80211);
 	l_free(ap);
 }
-- =

2.32.0

--===============8282434936059522878==--

