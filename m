Content-Type: multipart/mixed; boundary="===============0803263945794634884=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/7] wiphy: add wiphy_needs_offload
Date: Tue, 30 Mar 2021 09:13:02 -0700
Message-ID: <20210330161307.732965-2-prestwoj@gmail.com>
In-Reply-To: <20210330161307.732965-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0803263945794634884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This takes an AKM and returns true if that AKM requires offloading.
Today only SAE offload and PSK offload are checked. It is assumed
that wiphy_can_connect will be called before wiphy_needs_offload
as no AKM support is verified in this API.
---
 src/wiphy.c | 30 ++++++++++++++++++++++++++++++
 src/wiphy.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 35872577..d40c90ba 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -438,6 +438,36 @@ bool wiphy_can_connect(struct wiphy *wiphy, struct sca=
n_bss *bss)
 	return true;
 }
 =

+/*
+ * This should only be called *after* wiphy_can_connect has verified the B=
SS
+ * is connectable.
+ */
+bool wiphy_needs_offload(struct wiphy *wiphy, enum ie_rsn_akm_suite akm)
+{
+	if (IE_AKM_IS_SAE(akm)) {
+		bool offload =3D false;
+		/*
+		 * This should not fail, the compatibility should have been
+		 * checked already
+		 */
+		L_WARN_ON(wiphy_can_connect_sae(wiphy, &offload));
+
+		return offload;
+	} else if (akm =3D=3D IE_RSN_AKM_SUITE_FT_USING_PSK) {
+		if (wiphy->support_cmds_auth_assoc)
+			return false;
+
+		/*
+		 * Offload is the only way to do FT on this type of card.
+		 */
+		if (wiphy_has_ext_feature(wiphy,
+				NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK))
+			return true;
+	}
+
+	return false;
+}
+
 bool wiphy_supports_cmds_auth_assoc(struct wiphy *wiphy)
 {
 	return wiphy->support_cmds_auth_assoc;
diff --git a/src/wiphy.h b/src/wiphy.h
index 6c91220c..b0f68dd0 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -79,6 +79,7 @@ uint32_t wiphy_get_supported_bands(struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_supported_freqs(
 						const struct wiphy *wiphy);
 bool wiphy_can_connect(struct wiphy *wiphy, struct scan_bss *bss);
+bool wiphy_needs_offload(struct wiphy *wiphy, enum ie_rsn_akm_suite akm);
 bool wiphy_supports_cmds_auth_assoc(struct wiphy *wiphy);
 bool wiphy_can_randomize_mac_addr(struct wiphy *wiphy);
 bool wiphy_rrm_capable(struct wiphy *wiphy);
-- =

2.26.2

--===============0803263945794634884==--

