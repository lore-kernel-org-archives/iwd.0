Content-Type: multipart/mixed; boundary="===============1439303921114365879=="
MIME-Version: 1.0
From: salahaldeen.altous at leica-camera.com
To: iwd at lists.01.org
Subject: iwd can start in AP mode
Date: Mon, 08 Nov 2021 04:35:18 +0000
Message-ID: <20211108043518.2830.53187@ml01.vlan13.01.org>

--===============1439303921114365879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>From e8357b81a20f44d3473f652ef233b6598f72273f Mon Sep 17 00:00:00 2001
From: Salahaldeen Altous <salahaldeen.altous(a)leica-camera.com>
Date: Mon, 8 Nov 2021 05:16:26 +0100
Subject: [PATCH] iwd can start in AP mode

By default iwd starts in station mode.  This can be changed by setting the
Mode parameter to ap in the main.conf General section. Example
[General]
Mode=3Dap
---
 src/manager.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/manager.c b/src/manager.c
index 558b71b0..a1078713 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -197,6 +197,8 @@ static void manager_create_interfaces(struct wiphy_setu=
p_state *state)
 	char ifname[10];
 	uint32_t iftype;
 	unsigned cmd_id;
+	const char *mode_str;
+	const struct l_settings *config =3D iwd_get_config();
 =

 	if (state->aborted)
 		return;
@@ -223,6 +225,11 @@ static void manager_create_interfaces(struct wiphy_set=
up_state *state)
 	snprintf(ifname, sizeof(ifname), "wlan%i", (int) state->id);
 	l_debug("creating %s", ifname);
 	iftype =3D NL80211_IFTYPE_STATION;
+	mode_str =3D l_settings_get_value(config, "General", "Mode");
+	if (mode_str) {
+		if (!strcmp(mode_str, "ap"))
+			iftype =3D NL80211_IFTYPE_AP;
+	}
 =

 	msg =3D l_genl_msg_new(NL80211_CMD_NEW_INTERFACE);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4, &state->id);
-- =

2.25.1
--===============1439303921114365879==--

