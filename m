Content-Type: multipart/mixed; boundary="===============1254731262002385971=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 4/7] ie: add IE_AKM_IS_8021X
Date: Fri, 25 Feb 2022 15:32:48 -0800
Message-ID: <20220225233251.2958102-4-prestwoj@gmail.com>
In-Reply-To: 20220225233251.2958102-1-prestwoj@gmail.com

--===============1254731262002385971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ie.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/ie.h b/src/ie.h
index fac766d5..7786ea74 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -354,6 +354,12 @@ enum ie_rsn_akm_suite {
 		IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256 | \
 		IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384))
 =

+#define IE_AKM_IS_8021X(akm) \
+	(akm & (IE_RSN_AKM_SUITE_8021X | \
+		IE_RSN_AKM_SUITE_FT_OVER_8021X | \
+		IE_RSN_AKM_SUITE_8021X_SHA256 | \
+		IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384))
+
 #define IE_LEN(ie) \
 	((ie) ? (ie)[1] + 2 : 0)
 =

-- =

2.34.1

--===============1254731262002385971==--

