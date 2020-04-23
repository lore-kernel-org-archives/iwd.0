Content-Type: multipart/mixed; boundary="===============4469792111004600772=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 07/19] wiphy: Track regulatory domain changes
Date: Thu, 23 Apr 2020 18:24:35 +0200
Message-ID: <20200423162447.15750-7-andrew.zaborowski@intel.com>
In-Reply-To: <20200423162447.15750-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4469792111004600772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a new wiphy is added query its regulatory domain and listen for
nl80211 regulatory notifications to be able to provide current
regulatory country code through the new wiphy_get_reg_domain_country().
---
 src/wiphy.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/wiphy.h |   1 +
 2 files changed, 119 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 8abf1b0f..139474d2 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -52,6 +52,7 @@
 #include "src/common.h"
 #include "src/watchlist.h"
 #include "src/nl80211util.h"
+#include "src/nl80211cmd.h"
 =

 #define EXT_CAP_LEN 10
 =

@@ -60,6 +61,7 @@ static struct l_hwdb *hwdb;
 static char **whitelist_filter;
 static char **blacklist_filter;
 static int mac_randomize_bytes =3D 6;
+static char regdom_country[2];
 =

 struct wiphy {
 	uint32_t id;
@@ -81,6 +83,8 @@ struct wiphy {
 	uint8_t *iftype_extended_capabilities[NUM_NL80211_IFTYPES];
 	uint8_t *supported_rates[NUM_NL80211_BANDS];
 	uint8_t rm_enabled_capabilities[7]; /* 5 size max + header */
+	struct l_genl_family *nl80211;
+	char regdom_country[2];
 =

 	bool support_scheduled_scan:1;
 	bool support_rekey_offload:1;
@@ -227,6 +231,7 @@ static void wiphy_free(void *data)
 	l_free(wiphy->model_str);
 	l_free(wiphy->vendor_str);
 	l_free(wiphy->driver_str);
+	l_genl_family_free(wiphy->nl80211);
 	l_free(wiphy);
 }
 =

@@ -562,6 +567,18 @@ const uint8_t *wiphy_get_supported_rates(struct wiphy =
*wiphy, unsigned int band,
 	return wiphy->supported_rates[band];
 }
 =

+void wiphy_get_reg_domain_country(struct wiphy *wiphy, char *out)
+{
+	char *country =3D wiphy->regdom_country;
+
+	if (!country[0])
+		/* Wiphy uses the global regulatory domain */
+		country =3D regdom_country;
+
+	out[0] =3D country[0];
+	out[1] =3D country[1];
+}
+
 uint32_t wiphy_state_watch_add(struct wiphy *wiphy,
 				wiphy_state_watch_func_t func,
 				void *user_data, wiphy_destroy_func_t destroy)
@@ -1046,9 +1063,11 @@ static void wiphy_register(struct wiphy *wiphy)
 struct wiphy *wiphy_create(uint32_t wiphy_id, const char *name)
 {
 	struct wiphy *wiphy;
+	struct l_genl *genl =3D iwd_get_genl();
 =

 	wiphy =3D wiphy_new(wiphy_id);
 	l_strlcpy(wiphy->name, name, sizeof(wiphy->name));
+	wiphy->nl80211 =3D l_genl_family_new(genl, NL80211_GENL_NAME);
 	l_queue_push_head(wiphy_list, wiphy);
 =

 	if (!wiphy_is_managed(name))
@@ -1138,6 +1157,70 @@ static void wiphy_setup_rm_enabled_capabilities(stru=
ct wiphy *wiphy)
 	 */
 }
 =

+static void wiphy_update_reg_domain(struct wiphy *wiphy, bool global,
+					struct l_genl_msg *msg)
+{
+	char *out_country;
+
+	if (global)
+		/*
+		 * Leave @wiphy->regdom_country as all zeros to mean that it
+		 * uses the global @regdom_country, i.e. is not self-managed.
+		 *
+		 * Even if we're called because we queried a new wiphy's
+		 * reg domain, use the value we received here to update our
+		 * global @regdom_country in case this is the first opportunity
+		 * we have to update it -- possibly because this is the first
+		 * wiphy created (that is not self-managed anyway) and we
+		 * haven't received any REG_CHANGE events yet.
+		 */
+		out_country =3D regdom_country;
+	else
+		out_country =3D wiphy->regdom_country;
+
+	/*
+	 * Write the new country code or XX if the reg domain is not a
+	 * country domain.
+	 */
+	if (nl80211_parse_attrs(msg, NL80211_ATTR_REG_ALPHA2, out_country,
+				NL80211_ATTR_UNSPEC) < 0)
+		out_country[0] =3D out_country[1] =3D 'X';
+
+	l_debug("New reg domain country code for %s is %c%c",
+		global ? "(global)" : wiphy->name,
+		out_country[0], out_country[1]);
+}
+
+static void wiphy_get_reg_cb(struct l_genl_msg *msg, void *user_data)
+{
+	struct wiphy *wiphy =3D user_data;
+	uint32_t tmp;
+	bool global;
+
+	/*
+	 * NL80211_CMD_GET_REG contains an NL80211_ATTR_WIPHY iff the wiphy
+	 * uses a self-managed regulatory domain.
+	 */
+	global =3D nl80211_parse_attrs(msg, NL80211_ATTR_WIPHY, &tmp,
+				NL80211_ATTR_UNSPEC) < 0;
+
+	wiphy_update_reg_domain(wiphy, global, msg);
+}
+
+static void wiphy_get_reg_domain(struct wiphy *wiphy)
+{
+	struct l_genl_msg *msg;
+
+	msg =3D l_genl_msg_new(NL80211_CMD_GET_REG);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4, &wiphy->id);
+
+	if (!l_genl_family_send(wiphy->nl80211, msg, wiphy_get_reg_cb, wiphy,
+				NULL)) {
+		l_error("Error sending NL80211_CMD_GET_REG for %s", wiphy->name);
+		l_genl_msg_unref(msg);
+	}
+}
+
 void wiphy_create_complete(struct wiphy *wiphy)
 {
 	wiphy_register(wiphy);
@@ -1152,6 +1235,7 @@ void wiphy_create_complete(struct wiphy *wiphy)
 =

 	wiphy_set_station_capability_bits(wiphy);
 	wiphy_setup_rm_enabled_capabilities(wiphy);
+	wiphy_get_reg_domain(wiphy);
 =

 	wiphy_print_basic_info(wiphy);
 }
@@ -1338,6 +1422,36 @@ static void setup_wiphy_interface(struct l_dbus_inte=
rface *interface)
 					NULL);
 }
 =

+static void wiphy_reg_notify(struct l_genl_msg *msg, void *user_data)
+{
+	uint8_t cmd =3D l_genl_msg_get_command(msg);
+
+	l_debug("Notification of command %s(%u)",
+		nl80211cmd_to_string(cmd), cmd);
+
+	switch (cmd) {
+	case NL80211_CMD_REG_CHANGE:
+		wiphy_update_reg_domain(NULL, true, msg);
+		break;
+	case NL80211_CMD_WIPHY_REG_CHANGE:
+	{
+		uint32_t wiphy_id;
+		struct wiphy *wiphy;
+
+		if (nl80211_parse_attrs(msg, NL80211_ATTR_WIPHY, &wiphy_id,
+					NL80211_ATTR_UNSPEC) < 0)
+			break;
+
+		wiphy =3D wiphy_find(wiphy_id);
+		if (!wiphy)
+			break;
+
+		wiphy_update_reg_domain(wiphy, false, msg);
+		break;
+	}
+	}
+}
+
 static int wiphy_init(void)
 {
 	struct l_genl *genl =3D iwd_get_genl();
@@ -1388,6 +1502,10 @@ static int wiphy_init(void)
 				" value: %s", s);
 	}
 =

+	if (!l_genl_family_register(nl80211, NL80211_MULTICAST_GROUP_REG,
+					wiphy_reg_notify, NULL, NULL))
+		l_error("Registering for regulatory notifications failed");
+
 	return 0;
 }
 =

diff --git a/src/wiphy.h b/src/wiphy.h
index 4d2a4e8f..ed435517 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -80,6 +80,7 @@ const uint8_t *wiphy_get_permanent_address(struct wiphy *=
wiphy);
 const uint8_t *wiphy_get_extended_capabilities(struct wiphy *wiphy,
 							uint32_t iftype);
 const uint8_t *wiphy_get_rm_enabled_capabilities(struct wiphy *wiphy);
+void wiphy_get_reg_domain_country(struct wiphy *wiphy, char *out);
 =

 void wiphy_generate_random_address(struct wiphy *wiphy, uint8_t addr[stati=
c 6]);
 void wiphy_generate_address_from_ssid(struct wiphy *wiphy, const char *ssi=
d,
-- =

2.20.1

--===============4469792111004600772==--

