Content-Type: multipart/mixed; boundary="===============7693090293597933358=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 01/13] wiphy: change wiphy_control_port_capable -> enabled
Date: Thu, 07 Oct 2021 13:49:45 -0700
Message-ID: <20211007204957.3745985-1-prestwoj@gmail.com>

--===============7693090293597933358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move the reading of ControlPortOverNL80211 into wiphy itself and
renamed wiphy_control_port_capable to wiphy_control_port_enabled.
This makes things easier for any modules interested in control
port support since they will only have to check this one API rather
than read the settings and check capability.
---
 src/netdev.c |  7 +------
 src/wiphy.c  | 16 +++++++++++++---
 src/wiphy.h  |  2 +-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index fbf3b067..de155da1 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -203,7 +203,6 @@ static struct l_netlink *rtnl =3D NULL;
 static struct l_genl_family *nl80211;
 static struct l_queue *netdev_list;
 static struct watchlist netdev_watches;
-static bool pae_over_nl80211;
 static bool mac_per_ssid;
 =

 static unsigned int iov_ie_append(struct iovec *iov,
@@ -6096,7 +6095,7 @@ struct netdev *netdev_create_from_genl(struct l_genl_=
msg *msg,
 		return NULL;
 	}
 =

-	if (!pae_over_nl80211 || !wiphy_control_port_capable(wiphy)) {
+	if (!wiphy_control_port_enabled(wiphy)) {
 		pae_io =3D pae_open(ifindex);
 		if (!pae_io) {
 			l_error("Unable to open PAE interface");
@@ -6233,10 +6232,6 @@ static int netdev_init(void)
 					&LOW_SIGNAL_THRESHOLD_5GHZ))
 		LOW_SIGNAL_THRESHOLD_5GHZ =3D -76;
 =

-	if (!l_settings_get_bool(settings, "General", "ControlPortOverNL80211",
-					&pae_over_nl80211))
-		pae_over_nl80211 =3D true;
-
 	rand_addr_str =3D l_settings_get_value(settings, "General",
 						"AddressRandomization");
 	if (rand_addr_str && !strcmp(rand_addr_str, "network"))
diff --git a/src/wiphy.c b/src/wiphy.c
index 84d2a152..1a333aad 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -555,8 +555,11 @@ bool wiphy_uses_default_if(struct wiphy *wiphy)
 	return false;
 }
 =

-bool wiphy_control_port_capable(struct wiphy *wiphy)
+bool wiphy_control_port_enabled(struct wiphy *wiphy)
 {
+	const struct l_settings *settings =3D iwd_get_config();
+	bool enabled;
+
 	if (wiphy->driver_info &&
 			wiphy->driver_info->flags & FORCE_PAE) {
 		l_info("Not using Control Port due to driver quirks: %s",
@@ -564,8 +567,15 @@ bool wiphy_control_port_capable(struct wiphy *wiphy)
 		return false;
 	}
 =

-	return wiphy_has_ext_feature(wiphy,
-			NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211);
+	if (!wiphy_has_ext_feature(wiphy,
+			NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211))
+		return false;
+
+	if (!l_settings_get_bool(settings, "General",
+					"ControlPortOverNL80211", &enabled))
+		enabled =3D true;
+
+	return enabled;
 }
 =

 const uint8_t *wiphy_get_permanent_address(struct wiphy *wiphy)
diff --git a/src/wiphy.h b/src/wiphy.h
index d6487074..f7b6e1c4 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -102,7 +102,7 @@ bool wiphy_supports_firmware_roam(struct wiphy *wiphy);
 const char *wiphy_get_driver(struct wiphy *wiphy);
 const char *wiphy_get_name(struct wiphy *wiphy);
 bool wiphy_uses_default_if(struct wiphy *wiphy);
-bool wiphy_control_port_capable(struct wiphy *wiphy);
+bool wiphy_control_port_enabled(struct wiphy *wiphy);
 const uint8_t *wiphy_get_permanent_address(struct wiphy *wiphy);
 const uint8_t *wiphy_get_extended_capabilities(struct wiphy *wiphy,
 							uint32_t iftype);
-- =

2.31.1

--===============7693090293597933358==--

