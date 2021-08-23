Content-Type: multipart/mixed; boundary="===============2450042481620719864=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] ie: add is_ie_default_sae_group_oui
Date: Mon, 23 Aug 2021 16:41:46 -0700
Message-ID: <20210823234149.610336-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2450042481620719864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Start an OUI list of vendors who have buggy SAE group negotiation
---
 src/ie.c | 25 +++++++++++++++++++++++++
 src/ie.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/src/ie.c b/src/ie.c
index a73d5bbc..3bf3b5f0 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -1363,6 +1363,31 @@ bool is_ie_wpa_ie(const uint8_t *data, uint8_t len)
 	return false;
 }
 =

+/*
+ * List of vendor OUIs which require the default SAE group to be used
+ */
+static uint8_t use_default_sae_group_ouis[][3] =3D {
+	{ 0xf4, 0xf5, 0xe8 },
+};
+
+bool is_ie_default_sae_group_oui(const void *data, uint16_t len)
+{
+	unsigned int i =3D 0;
+
+	if (len < 3)
+		return false;
+
+	while (i < L_ARRAY_SIZE(use_default_sae_group_ouis)) {
+		if (!memcmp(use_default_sae_group_ouis[i], data, 3))
+			return true;
+
+		i++;
+	}
+
+	return false;
+}
+
+
 int ie_parse_wpa(struct ie_tlv_iter *iter, struct ie_rsn_info *out_info)
 {
 	const uint8_t *data =3D iter->data;
diff --git a/src/ie.h b/src/ie.h
index 25b56302..7c4f987d 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -524,6 +524,8 @@ int ie_parse_wpa_from_data(const uint8_t *data, size_t =
len,
 						struct ie_rsn_info *info);
 bool is_ie_wfa_ie(const uint8_t *data, uint8_t len, uint8_t oi_type);
 bool is_ie_wpa_ie(const uint8_t *data, uint8_t len);
+bool is_ie_default_sae_group_oui(const void *data, uint16_t len);
+
 bool ie_build_wpa(const struct ie_rsn_info *info, uint8_t *to);
 =

 int ie_parse_bss_load(struct ie_tlv_iter *iter, uint16_t *out_sta_count,
-- =

2.31.1

--===============2450042481620719864==--

