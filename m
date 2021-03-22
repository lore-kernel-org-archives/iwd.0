Content-Type: multipart/mixed; boundary="===============5265610658831014801=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/6] wiphy: add getter for 'supports_cmds_auth_assoc'
Date: Mon, 22 Mar 2021 09:01:51 -0700
Message-ID: <20210322160156.392256-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5265610658831014801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/wiphy.c | 5 +++++
 src/wiphy.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 82e3ca87..e230b273 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -404,6 +404,11 @@ bool wiphy_can_connect(struct wiphy *wiphy, struct sca=
n_bss *bss)
 	return true;
 }
 =

+bool wiphy_supports_cmds_auth_assoc(struct wiphy *wiphy)
+{
+	return wiphy->support_cmds_auth_assoc;
+}
+
 bool wiphy_has_feature(struct wiphy *wiphy, uint32_t feature)
 {
 	return wiphy->feature_flags & feature;
diff --git a/src/wiphy.h b/src/wiphy.h
index 1fd71f0d..6c91220c 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -79,6 +79,7 @@ uint32_t wiphy_get_supported_bands(struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_supported_freqs(
 						const struct wiphy *wiphy);
 bool wiphy_can_connect(struct wiphy *wiphy, struct scan_bss *bss);
+bool wiphy_supports_cmds_auth_assoc(struct wiphy *wiphy);
 bool wiphy_can_randomize_mac_addr(struct wiphy *wiphy);
 bool wiphy_rrm_capable(struct wiphy *wiphy);
 bool wiphy_has_feature(struct wiphy *wiphy, uint32_t feature);
-- =

2.26.2

--===============5265610658831014801==--

