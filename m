Content-Type: multipart/mixed; boundary="===============2562626565710795662=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/4] ie: add ie_akm_suite_to_string
Date: Wed, 24 Mar 2021 16:05:36 -0700
Message-ID: <20210324230538.583325-2-prestwoj@gmail.com>
In-Reply-To: <20210324230538.583325-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2562626565710795662==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Converts ie_rsn_akm_suite values into strings
---
 src/ie.c | 33 +++++++++++++++++++++++++++++++++
 src/ie.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/src/ie.c b/src/ie.c
index 46f7496e..80c6e5e4 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -2636,3 +2636,36 @@ int ie_build_hs20_indication(uint8_t version, uint8_=
t *to)
 =

 	return 0;
 }
+
+const char *ie_akm_suite_to_string(enum ie_rsn_akm_suite akm)
+{
+	switch (akm) {
+	case IE_RSN_AKM_SUITE_8021X:
+	case IE_RSN_AKM_SUITE_8021X_SHA256:
+		return "WPA2-Enterprise";
+	case IE_RSN_AKM_SUITE_PSK:
+	case IE_RSN_AKM_SUITE_PSK_SHA256:
+		return "WPA2-Personal";
+	case IE_RSN_AKM_SUITE_FT_OVER_8021X:
+	case IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384:
+		return "WPA2-Enterprise + FT";
+	case IE_RSN_AKM_SUITE_FT_USING_PSK:
+		return "WPA2-Personal + FT";
+	case IE_RSN_AKM_SUITE_SAE_SHA256:
+		return "WPA3-Personal";
+	case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
+		return "WPA3-Personal + FT";
+	case IE_RSN_AKM_SUITE_OWE:
+		return "OWE";
+	case IE_RSN_AKM_SUITE_FILS_SHA256:
+	case IE_RSN_AKM_SUITE_FILS_SHA384:
+		return "FILS";
+	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
+	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
+		return "FILS + FT";
+	case IE_RSN_AKM_SUITE_OSEN:
+		return "OSEN";
+	default:
+		return NULL;
+	}
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

--===============2562626565710795662==--

