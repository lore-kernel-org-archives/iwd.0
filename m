Content-Type: multipart/mixed; boundary="===============7467809554746192858=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/6] wiphy: parse NL80211_ATTR_ROAM_SUPPORT flag
Date: Wed, 10 Mar 2021 12:27:45 -0800
Message-ID: <20210310202746.28475-5-prestwoj@gmail.com>
In-Reply-To: <20210310202746.28475-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7467809554746192858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This tells us if the hardware is going to automatically
roam. We need this to know if station roaming logic should
be disabled.
---
 src/wiphy.c | 9 +++++++++
 src/wiphy.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 3adc5669..d9c26bd3 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -95,6 +95,7 @@ struct wiphy {
 	bool support_adhoc_rsn:1;
 	bool support_qos_set_map:1;
 	bool support_cmds_auth_assoc:1;
+	bool support_fw_roam:1;
 	bool soft_rfkill : 1;
 	bool hard_rfkill : 1;
 	bool offchannel_tx_ok : 1;
@@ -461,6 +462,11 @@ bool wiphy_supports_qos_set_map(struct wiphy *wiphy)
 	return wiphy->support_qos_set_map;
 }
 =

+bool wiphy_supports_fw_roam(struct wiphy *wiphy)
+{
+	return wiphy->support_fw_roam;
+}
+
 const char *wiphy_get_driver(struct wiphy *wiphy)
 {
 	return wiphy->driver_str;
@@ -989,6 +995,9 @@ static void wiphy_parse_attributes(struct wiphy *wiphy,
 			else
 				wiphy->max_roc_duration =3D *((uint32_t *) data);
 			break;
+		case NL80211_ATTR_ROAM_SUPPORT:
+			wiphy->support_fw_roam =3D true;
+			break;
 		}
 	}
 }
diff --git a/src/wiphy.h b/src/wiphy.h
index 50c8c936..e214ea70 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -92,6 +92,7 @@ const uint8_t *wiphy_get_supported_rates(struct wiphy *wi=
phy, unsigned int band,
 bool wiphy_supports_adhoc_rsn(struct wiphy *wiphy);
 bool wiphy_can_offchannel_tx(struct wiphy *wiphy);
 bool wiphy_supports_qos_set_map(struct wiphy *wiphy);
+bool wiphy_supports_fw_roam(struct wiphy *wiphy);
 const char *wiphy_get_driver(struct wiphy *wiphy);
 const char *wiphy_get_name(struct wiphy *wiphy);
 const uint8_t *wiphy_get_permanent_address(struct wiphy *wiphy);
-- =

2.26.2

--===============7467809554746192858==--

