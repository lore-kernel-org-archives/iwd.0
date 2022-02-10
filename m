Content-Type: multipart/mixed; boundary="===============0174368074920877621=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] manager: Refine filtered dumps
Date: Thu, 10 Feb 2022 16:17:02 -0600
Message-ID: <20220210221702.4791-1-denkenz@gmail.com>
In-Reply-To: CAMSdBrG=OGXZRMSjf-u41rAuTaxUdMw0sVMbNPX995B8sCiq_A@mail.gmail.com

--===============0174368074920877621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When we detect a new phy being added, we schedule a filtered dump of
WIPHYs and INTERFACES.  However, the processing of these dumps was
shared with the global dump of all WIPHYs and INTERFACEs which is
performed at startup.  This normally worked fine as long as a single phy
was created at a time.  However, if multiphy new phys were detected in
a short amount of time, the logic would get confused and try to process
phys that have not been probed yet.  Fix this by only processing the wiphy
and related interfaces when the filtered dump is performed, and not any
additional ones that might still be pending.
---
 src/manager.c | 85 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index 46e0e9065aec..970df0c5ace4 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -487,6 +487,19 @@ static void manager_interface_dump_callback(struct l_g=
enl_msg *msg,
 	manager_get_interface_cb(msg, state);
 }
 =

+static void manager_filtered_interface_dump_done(void *user_data)
+{
+	struct wiphy_setup_state *state =3D user_data;
+
+	l_debug("");
+
+	if (!manager_wiphy_check_setup_done(state))
+		return;
+
+	/* If we are here, there were no interfaces for this phy */
+	wiphy_setup_state_destroy(state);
+}
+
 static bool manager_check_create_interfaces(void *data, void *user_data)
 {
 	struct wiphy_setup_state *state =3D data;
@@ -501,6 +514,8 @@ static bool manager_check_create_interfaces(void *data,=
 void *user_data)
 =

 static void manager_interface_dump_done(void *user_data)
 {
+	l_debug("");
+
 	l_queue_foreach_remove(pending_wiphys,
 				manager_check_create_interfaces, NULL);
 }
@@ -552,43 +567,59 @@ static void manager_wiphy_filtered_dump_callback(stru=
ct l_genl_msg *msg,
 	wiphy_update_from_genl(state->wiphy, msg);
 }
 =

-static void manager_wiphy_dump_done(void *user_data)
+static void manager_filtered_wiphy_dump_done(void *user_data)
 {
-	const struct l_queue_entry *e;
+	struct wiphy_setup_state *state =3D user_data;
 =

-	for (e =3D l_queue_get_entries(pending_wiphys); e; e =3D e->next) {
-		struct wiphy_setup_state *state =3D e->data;
+	l_debug("");
 =

-		wiphy_create_complete(state->wiphy);
-		state->use_default =3D use_default;
+	wiphy_create_complete(state->wiphy);
+	state->use_default =3D use_default;
 =

-		/* If whitelist/blacklist were given only try to use existing
-		 * interfaces same as when the driver does not support
-		 * NEW_INTERFACE or DEL_INTERFACE, otherwise the interface
-		 * names will become meaningless after we've created our own
-		 * interface(s).  Optimally phy name white/blacklists should
-		 * be used.
-		 */
-		if (whitelist_filter || blacklist_filter)
-			state->use_default =3D true;
+	/*
+	 * If whitelist/blacklist were given only try to use existing
+	 * interfaces same as when the driver does not support
+	 * NEW_INTERFACE or DEL_INTERFACE, otherwise the interface
+	 * names will become meaningless after we've created our own
+	 * interface(s).  Optimally phy name white/blacklists should
+	 * be used.
+	 */
+	if (whitelist_filter || blacklist_filter)
+		state->use_default =3D true;
 =

-		if (!state->use_default)
-			state->use_default =3D
-				wiphy_uses_default_if(state->wiphy);
+	if (!state->use_default)
+		state->use_default =3D wiphy_uses_default_if(state->wiphy);
 =

-		if (state->use_default)
-			l_info("Wiphy %s will only use the default interface",
-				wiphy_get_name(state->wiphy));
-	}
+	if (state->use_default)
+		l_info("Wiphy %s will only use the default interface",
+			wiphy_get_name(state->wiphy));
+}
+
+static void manager_wiphy_dump_done(void *user_data)
+{
+	const struct l_queue_entry *e;
+
+	l_debug("");
+
+	for (e =3D l_queue_get_entries(pending_wiphys); e; e =3D e->next)
+		manager_filtered_wiphy_dump_done(e->data);
 }
 =

 static int manager_wiphy_filtered_dump(uint32_t wiphy_id,
-						l_genl_msg_func_t cb,
-						void *user_data)
+					l_genl_msg_func_t cb,
+					struct wiphy_setup_state *state)
 {
 	struct l_genl_msg *msg;
 	unsigned int wiphy_cmd_id;
 	unsigned int iface_cmd_id;
+	l_genl_destroy_func_t wiphy_done =3D manager_wiphy_dump_done;
+	l_genl_destroy_func_t interface_done =3D manager_interface_dump_done;
+
+	/* If state is provided, don't try to process other pending states */
+	if (state) {
+		wiphy_done =3D manager_filtered_wiphy_dump_done;
+		interface_done =3D manager_filtered_interface_dump_done;
+	}
 =

 	/*
 	 * Until fixed, a NEW_WIPHY event will not include all the information
@@ -599,8 +630,7 @@ static int manager_wiphy_filtered_dump(uint32_t wiphy_i=
d,
 	l_genl_msg_append_attr(msg, NL80211_ATTR_SPLIT_WIPHY_DUMP, 0, NULL);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4, &wiphy_id);
 =

-	wiphy_cmd_id =3D l_genl_family_dump(nl80211, msg, cb, user_data,
-						manager_wiphy_dump_done);
+	wiphy_cmd_id =3D l_genl_family_dump(nl80211, msg, cb, state, wiphy_done);
 	if (!wiphy_cmd_id) {
 		l_error("Could not dump wiphy %u", wiphy_id);
 		l_genl_msg_unref(msg);
@@ -625,8 +655,7 @@ static int manager_wiphy_filtered_dump(uint32_t wiphy_i=
d,
 =

 	iface_cmd_id =3D l_genl_family_dump(nl80211, msg,
 					manager_interface_dump_callback,
-					NULL, manager_interface_dump_done);
-
+					state, interface_done);
 	if (!iface_cmd_id) {
 		l_error("Could not dump interface for wiphy %u", wiphy_id);
 		l_genl_family_cancel(nl80211, wiphy_cmd_id);
-- =

2.32.0

--===============0174368074920877621==--

