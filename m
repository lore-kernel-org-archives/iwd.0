Content-Type: multipart/mixed; boundary="===============1241665108922634338=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] ie: add ie_akm_suite_to_string
Date: Wed, 24 Mar 2021 15:25:57 -0700
Message-ID: <20210324222559.577225-2-prestwoj@gmail.com>
In-Reply-To: <20210324222559.577225-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1241665108922634338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Converts ie_rsn_akm_suite values into strings
---
 src/ie.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 src/ie.h |  2 ++
 2 files changed, 48 insertions(+)

diff --git a/src/ie.c b/src/ie.c
index 46f7496e..b265b811 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -2636,3 +2636,49 @@ int ie_build_hs20_indication(uint8_t version, uint8_=
t *to)
 =

 	return 0;
 }
+
+const char *ie_akm_suite_to_string(enum ie_rsn_akm_suite akm)
+{
+	switch (akm) {
+	case IE_RSN_AKM_SUITE_8021X:
+		return "802.1x";
+	case IE_RSN_AKM_SUITE_PSK:
+		return "PSK";
+	case IE_RSN_AKM_SUITE_FT_OVER_8021X:
+		return "FT-802.1x";
+	case IE_RSN_AKM_SUITE_FT_USING_PSK:
+		return "FT-PSK";
+	case IE_RSN_AKM_SUITE_8021X_SHA256:
+		return "802.1x-SHA256";
+	case IE_RSN_AKM_SUITE_PSK_SHA256:
+		return "PSK-SHA256";
+	case IE_RSN_AKM_SUITE_TDLS:
+		return "TDLS";
+	case IE_RSN_AKM_SUITE_SAE_SHA256:
+		return "SAE";
+	case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
+		return "FT-SAE";
+	case IE_RSN_AKM_SUITE_AP_PEER_KEY_SHA256:
+		return "AP-PEER-KEY";
+	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA256:
+		return "802.1x-Suite-B";
+	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA384:
+		return "802.1x-Suite-B-SHA384";
+	case IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384:
+		return "FT-802.1x-SHA384";
+	case IE_RSN_AKM_SUITE_OWE:
+		return "OWE";
+	case IE_RSN_AKM_SUITE_FILS_SHA256:
+		return "FILS-SHA256";
+	case IE_RSN_AKM_SUITE_FILS_SHA384:
+		return "FILS-SHA256";
+	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
+		return "FT-FILS-SHA256";
+	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
+		return "FT-FILS-SHA384";
+	case IE_RSN_AKM_SUITE_OSEN:
+		return "OSEN";
+	}
+
+	return NULL;
+}
diff --git a/src/ie.h b/src/ie.h
index 995f0e4f..bed88de9 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -528,3 +528,5 @@ int ie_parse_hs20_indication_from_data(const uint8_t *d=
ata, size_t len,
 					uint8_t *version, uint16_t *pps_mo_id,
 					uint8_t *domain_id);
 int ie_build_hs20_indication(uint8_t version, uint8_t *to);
+
+const char *ie_akm_suite_to_string(enum ie_rsn_akm_suite suite);
-- =

2.26.2

--===============1241665108922634338==--

