Content-Type: multipart/mixed; boundary="===============3264243989086070016=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/4] diagnostic: add diagnostic_akm_suite_to_security
Date: Mon, 29 Mar 2021 10:33:08 -0700
Message-ID: <20210329173310.706671-2-prestwoj@gmail.com>
In-Reply-To: <20210329173310.706671-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3264243989086070016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Converts ie_rsn_akm_suite values (and WPA1 hint) into a more
human readable security string such as:

WPA2-Personal, WPA3-Personal, WPA2-Personal + FT etc.
---
 src/diagnostic.c | 41 +++++++++++++++++++++++++++++++++++++++++
 src/diagnostic.h |  5 +++++
 2 files changed, 46 insertions(+)

v3:
 * Added wpa1 hint
 * Moved this from ie.c into diagnostic.c

diff --git a/src/diagnostic.c b/src/diagnostic.c
index d690cf3a..a7d9c52c 100644
--- a/src/diagnostic.c
+++ b/src/diagnostic.c
@@ -28,6 +28,7 @@
 =

 #include "src/diagnostic.h"
 #include "src/dbus.h"
+#include "src/ie.h"
 =

 /*
  * Appends values from diagnostic_station_info into a DBus dictionary. This
@@ -111,3 +112,43 @@ bool diagnostic_info_to_dict(const struct diagnostic_s=
tation_info *info,
 =

 	return true;
 }
+
+const char *diagnostic_akm_suite_to_security(enum ie_rsn_akm_suite akm,
+						bool wpa)
+{
+	switch (akm) {
+	case IE_RSN_AKM_SUITE_8021X:
+	case IE_RSN_AKM_SUITE_8021X_SHA256:
+		return "WPA2-Enterprise";
+	case IE_RSN_AKM_SUITE_PSK:
+	case IE_RSN_AKM_SUITE_PSK_SHA256:
+		if (wpa)
+			return "WPA1-Personal";
+
+		return "WPA2-Personal";
+	case IE_RSN_AKM_SUITE_FT_OVER_8021X:
+	case IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384:
+		return "WPA2-Enterprise + FT";
+	case IE_RSN_AKM_SUITE_FT_USING_PSK:
+		if (wpa)
+			return "WPA1-Personal + FT";
+
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
diff --git a/src/diagnostic.h b/src/diagnostic.h
index dab45c0b..fd965839 100644
--- a/src/diagnostic.h
+++ b/src/diagnostic.h
@@ -20,6 +20,8 @@
  *
  */
 =

+enum ie_rsn_akm_suite;
+
 enum diagnostic_mcs_type {
 	DIAGNOSTIC_MCS_TYPE_NONE,
 	DIAGNOSTIC_MCS_TYPE_HT,
@@ -52,3 +54,6 @@ struct diagnostic_station_info {
 =

 bool diagnostic_info_to_dict(const struct diagnostic_station_info *info,
 				struct l_dbus_message_builder *builder);
+
+const char *diagnostic_akm_suite_to_security(enum ie_rsn_akm_suite suite,
+						bool wpa);
-- =

2.26.2

--===============3264243989086070016==--

