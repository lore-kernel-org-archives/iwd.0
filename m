Content-Type: multipart/mixed; boundary="===============4134909001713135437=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/5] ie: add is_ie_default_sae_group_oui
Date: Wed, 25 Aug 2021 10:12:54 -0700
Message-ID: <20210825171258.764596-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4134909001713135437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Start an OUI list of vendors who have buggy SAE group negotiation
---
 src/ie.c | 26 ++++++++++++++++++++++++++
 src/ie.h |  2 ++
 2 files changed, 28 insertions(+)

v3
 * Changed to a for loop
 * Added length prefix to OUI match table

diff --git a/src/ie.c b/src/ie.c
index c03b16b4..6f487912 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -1364,6 +1364,32 @@ bool is_ie_wpa_ie(const uint8_t *data, uint8_t len)
 	return false;
 }
 =

+/*
+ * List of vendor OUIs (prefixed with a length byte) which require forcing
+ * the default SAE group.
+ */
+static const uint8_t use_default_sae_group_ouis[][5] =3D {
+	{ 0x04, 0xf4, 0xf5, 0xe8, 0x05 },
+};
+
+bool is_ie_default_sae_group_oui(const uint8_t *data, uint16_t len)
+{
+	unsigned int i;
+	const uint8_t *oui;
+
+	for (i =3D 0; i < L_ARRAY_SIZE(use_default_sae_group_ouis); i++) {
+		oui =3D use_default_sae_group_ouis[i];
+
+		if (len < oui[0])
+			continue;
+
+		if (!memcmp(oui + 1, data, oui[0]))
+			return true;
+	}
+
+	return false;
+}
+
 int ie_parse_wpa(struct ie_tlv_iter *iter, struct ie_rsn_info *out_info)
 {
 	const uint8_t *data =3D iter->data;
diff --git a/src/ie.h b/src/ie.h
index 05afce39..8d4ab3c1 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -551,6 +551,8 @@ int ie_parse_wpa_from_data(const uint8_t *data, size_t =
len,
 						struct ie_rsn_info *info);
 bool is_ie_wfa_ie(const uint8_t *data, uint8_t len, uint8_t oi_type);
 bool is_ie_wpa_ie(const uint8_t *data, uint8_t len);
+bool is_ie_default_sae_group_oui(const uint8_t *data, uint16_t len);
+
 bool ie_build_wpa(const struct ie_rsn_info *info, uint8_t *to);
 =

 int ie_parse_bss_load(struct ie_tlv_iter *iter, uint16_t *out_sta_count,
-- =

2.31.1

--===============4134909001713135437==--

