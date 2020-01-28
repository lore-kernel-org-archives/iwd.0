Content-Type: multipart/mixed; boundary="===============2918650184201107874=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] manager: Retry the interface setup if we get an EBUSY
Date: Tue, 28 Jan 2020 19:29:35 +0100
Message-ID: <20200128182935.3548-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2918650184201107874==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sometimes, at least with brcmfmac, the default interface apparently
takes a moment to get created after the NEW_WIPHY event.  We didn't
really consider this case in the NEW_WIPHY handler and we've got a race
condition.  It fixes the following bug for me:
https://bugs.archlinux.org/task/63912 -- tested by removing and
re-modprobing the brcmfmac module rather than rebooting.

To work around this wait for the NEW_INTERFACE event and then retry the
setup.  We still do the initial attempt directly after NEW_WIPHY to
handle cases like wiphys with no default interfaces and pre-existing
wiphys.
---
 src/manager.c | 70 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 20 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index a89bfc57..42d92c57 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -54,6 +54,7 @@ struct wiphy_setup_state {
 	struct wiphy *wiphy;
 	unsigned int pending_cmd_count;
 	bool aborted;
+	bool retry;
 =

 	/*
 	 * Data we may need if the driver does not seem to support interface
@@ -127,15 +128,29 @@ static void manager_new_interface_cb(struct l_genl_ms=
g *msg, void *user_data)
 	struct wiphy_setup_state *state =3D user_data;
 	uint8_t addr_buf[6];
 	uint8_t *addr =3D NULL;
+	int error;
 =

 	l_debug("");
 =

 	if (state->aborted)
 		return;
 =

-	if (l_genl_msg_get_error(msg) < 0) {
+	error =3D l_genl_msg_get_error(msg);
+	if (error < 0) {
 		l_error("NEW_INTERFACE failed: %s",
 			strerror(-l_genl_msg_get_error(msg)));
+
+		/*
+		 * If we receive an EBUSY most likely the wiphy is still
+		 * initilising, the default interface has not been created
+		 * yet and the wiphy needs some time.  Retry when we
+		 * receive a NEW_INTERFACE event.
+		 */
+		if (error =3D=3D -EBUSY) {
+			state->retry =3D true;
+			return;
+		}
+
 		/*
 		 * Nothing we can do to use this wiphy since by now we
 		 * will have successfully deleted any default interface
@@ -158,7 +173,9 @@ static void manager_new_interface_done(void *user_data)
 	struct wiphy_setup_state *state =3D user_data;
 =

 	state->pending_cmd_count--;
-	wiphy_setup_state_destroy(state);
+
+	if (!state->pending_cmd_count && !state->retry)
+		wiphy_setup_state_destroy(state);
 }
 =

 static void manager_create_interfaces(struct wiphy_setup_state *state)
@@ -218,18 +235,23 @@ static void manager_create_interfaces(struct wiphy_se=
tup_state *state)
 	state->pending_cmd_count++;
 }
 =

+static bool manager_wiphy_check_setup_done(struct wiphy_setup_state *state)
+{
+	if (state->pending_cmd_count || state->retry)
+		return false;
+
+	manager_create_interfaces(state);
+
+	return !state->pending_cmd_count && !state->retry;
+}
+
 static void manager_setup_cmd_done(void *user_data)
 {
 	struct wiphy_setup_state *state =3D user_data;
 =

 	state->pending_cmd_count--;
 =

-	if (state->pending_cmd_count)
-		return;
-
-	manager_create_interfaces(state);
-
-	if (!state->pending_cmd_count)
+	if (manager_wiphy_check_setup_done(state))
 		wiphy_setup_state_destroy(state);
 }
 =

@@ -280,7 +302,6 @@ static void manager_get_interface_cb(struct l_genl_msg =
*msg, void *user_data)
 		return;
 	}
 =

-
 	if (nl80211_parse_attrs(msg, NL80211_ATTR_IFINDEX, &ifindex,
 					NL80211_ATTR_IFNAME, &ifname,
 					NL80211_ATTR_UNSPEC) < 0)
@@ -476,15 +497,10 @@ static bool manager_check_create_interfaces(void *dat=
a, void *user_data)
 =

 	wiphy_create_complete(state->wiphy);
 =

-	if (state->pending_cmd_count)
-		return false;
-
-	/* If we are here, then there are no interfaces for this phy */
-	manager_create_interfaces(state);
-
-	if (state->pending_cmd_count)
+	if (!manager_wiphy_check_setup_done(state))
 		return false;
 =

+	/* If we are here, there were no interfaces for this phy */
 	wiphy_setup_state_free(state);
 	return true;
 }
@@ -561,6 +577,7 @@ static void manager_config_notify(struct l_genl_msg *ms=
g, void *user_data)
 {
 	uint8_t cmd;
 	struct netdev *netdev;
+	struct wiphy_setup_state *state;
 =

 	cmd =3D l_genl_msg_get_command(msg);
 =

@@ -578,11 +595,24 @@ static void manager_config_notify(struct l_genl_msg *=
msg, void *user_data)
 =

 	case NL80211_CMD_NEW_INTERFACE:
 		/*
-		 * TODO: Until NEW_WIPHY contains all required information we
-		 * are stuck always having to do a full dump. This specific
-		 * interface must also be dumped, and this is taken care of
-		 * in manager_new_wiphy_event.
+		 * Interfaces are normally dumped on the NEW_WIPHY events and
+		 * and we have nothing to do here.  But check if by any chance
+		 * we've queried this wiphy and it was still busy initialising,
+		 * in that case retry the setup now that an interface, likely
+		 * the initial default one, has been added.
 		 */
+		state =3D manager_find_pending(manager_parse_wiphy_id(msg));
+
+		if (state && state->retry) {
+			state->retry =3D false;
+			l_debug("Retrying setup of wiphy %u", state->id);
+
+			manager_get_interface_cb(msg, state);
+
+			if (manager_wiphy_check_setup_done(state))
+				wiphy_setup_state_destroy(state);
+		}
+
 		break;
 =

 	case NL80211_CMD_DEL_INTERFACE:
-- =

2.20.1

--===============2918650184201107874==--

