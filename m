Content-Type: multipart/mixed; boundary="===============1443259168026581402=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/2] wsc: Check capability before adding .SimpleConfiguration
 interface
Date: Wed, 06 Nov 2019 17:16:24 -0500
Message-ID: <20191106221624.12072-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191106221624.12072-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1443259168026581402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/wiphy.c | 5 +++++
 src/wiphy.h | 1 +
 src/wsc.c   | 7 +++++++
 3 files changed, 13 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 4446abba..e9397187 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -369,6 +369,11 @@ uint16_t wiphy_get_max_scan_ie_len(struct wiphy *wiphy)
 	return wiphy->max_scan_ie_len;
 }
 =

+bool wiphy_is_scan_ie_supported(struct wiphy *wiphy)
+{
+	return wiphy->max_scan_ie_len ? true : false;
+}
+
 uint32_t wiphy_get_max_roc_duration(struct wiphy *wiphy)
 {
 	return wiphy->max_roc_duration;
diff --git a/src/wiphy.h b/src/wiphy.h
index 67eafe3c..7d378aa0 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -65,6 +65,7 @@ bool wiphy_has_feature(struct wiphy *wiphy, uint32_t feat=
ure);
 bool wiphy_has_ext_feature(struct wiphy *wiphy, uint32_t feature);
 uint8_t wiphy_get_max_num_ssids_per_scan(struct wiphy *wiphy);
 uint16_t wiphy_get_max_scan_ie_len(struct wiphy *wiphy);
+bool wiphy_is_scan_ie_supported(struct wiphy *wiphy);
 uint32_t wiphy_get_max_roc_duration(struct wiphy *wiphy);
 bool wiphy_supports_iftype(struct wiphy *wiphy, uint32_t iftype);
 const uint8_t *wiphy_get_supported_rates(struct wiphy *wiphy, unsigned int=
 band,
diff --git a/src/wsc.c b/src/wsc.c
index bac6e0cc..ed211834 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -1108,6 +1108,13 @@ static void wsc_add_interface(struct netdev *netdev)
 	struct l_dbus *dbus =3D dbus_get_bus();
 	struct wsc *wsc;
 =

+	if (!wiphy_is_scan_ie_supported(netdev_get_wiphy(netdev))) {
+		l_info("Simple Configuration isn't supported by ifindex %u",
+						netdev_get_ifindex(netdev));
+
+		return;
+	}
+
 	wsc =3D l_new(struct wsc, 1);
 	wsc->netdev =3D netdev;
 =

-- =

2.21.0

--===============1443259168026581402==--

