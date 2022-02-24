Content-Type: multipart/mixed; boundary="===============8091802263524645811=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 1/7] scan: add scan_bss_get_security
Date: Thu, 24 Feb 2022 09:04:54 -0800
Message-ID: <20220224170500.2779425-1-prestwoj@gmail.com>

--===============8091802263524645811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was already implemented in station but with no dependency on
that module at all. AP will need this for a scanning API so its
being moved into scan.c.
---
 src/scan.c | 17 +++++++++++++++++
 src/scan.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index 1ab6420b..7c510df8 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1680,6 +1680,23 @@ int scan_bss_get_rsn_info(const struct scan_bss *bss=
, struct ie_rsn_info *info)
 	return 0;
 }
 =

+int scan_bss_get_security(const struct scan_bss *bss, enum security *secur=
ity)
+{
+	int ret;
+	struct ie_rsn_info info;
+
+	ret =3D scan_bss_get_rsn_info(bss, &info);
+	if (ret < 0) {
+		if (ret !=3D -ENOENT)
+			return ret;
+
+		*security =3D security_determine(bss->capability, NULL);
+	} else
+		*security =3D security_determine(bss->capability, &info);
+
+	return 0;
+}
+
 int scan_bss_rank_compare(const void *a, const void *b, void *user_data)
 {
 	const struct scan_bss *new_bss =3D a, *bss =3D b;
diff --git a/src/scan.h b/src/scan.h
index 81cb9e46..2c401df6 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -28,6 +28,7 @@ struct p2p_probe_req;
 struct p2p_beacon;
 struct mmpdu_header;
 struct wiphy;
+enum security;
 =

 enum scan_state {
 	SCAN_STATE_NOT_RUNNING,
@@ -161,6 +162,7 @@ void scan_bss_free(struct scan_bss *bss);
 int scan_bss_rank_compare(const void *a, const void *b, void *user);
 =

 int scan_bss_get_rsn_info(const struct scan_bss *bss, struct ie_rsn_info *=
info);
+int scan_bss_get_security(const struct scan_bss *bss, enum security *secur=
ity);
 =

 struct scan_bss *scan_bss_new_from_probe_req(const struct mmpdu_header *mp=
du,
 						const uint8_t *body,
-- =

2.34.1

--===============8091802263524645811==--

