Content-Type: multipart/mixed; boundary="===============1491962388132825110=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/2] ie: refactor parsing supported data rates
Date: Fri, 14 May 2021 12:22:52 -0700
Message-ID: <20210514192253.454140-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1491962388132825110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Both ext/supported rates IEs are obtained from scan results. These
IEs are passed to ie_tlv_init/ie_tlv_next, as well as direct length
checks (for supported rates at least, extended supported rates can
be as long as a single byte integer can hold, 1 - 255) which verifies
that the length in the IE matches the overall IE length that is
stored in scan_bss. Because of this, ie_parse_supported_rates_from_data
was doing double duty re-initializing a TLV iterator.

Intead, since we know the IE length is within bounds, the length/data
can simply be directly accessed out of the buffer. This avoids the need
for a wrapper function entirely.

The length parameters were also removed, since this is now obtained
directly from the IE.
---
 src/ie.c | 76 +++++++++++++++-----------------------------------------
 src/ie.h |  6 -----
 2 files changed, 20 insertions(+), 62 deletions(-)

v3:
 * Added back in len =3D=3D 0 check. This is NOT verified in scan.c, only
   the total length is sanity checked.

diff --git a/src/ie.c b/src/ie.c
index 0b471f1b..53636049 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -1662,10 +1662,9 @@ static const struct basic_rate_map rate_rssi_map[] =
=3D {
 	{ -65, 108 },
 };
 =

-static int ie_parse_supported_rates(struct ie_tlv_iter *supp_rates_iter,
-					struct ie_tlv_iter *ext_supp_rates_iter,
-					int32_t rssi,
-					uint64_t *data_rate)
+static int ie_parse_supported_rates_from_data(const uint8_t *supp_rates_ie,
+					const uint8_t *ext_supp_rates_ie,
+					int32_t rssi, uint64_t *data_rate)
 {
 	uint8_t max_rate =3D 0;
 	uint8_t highest =3D 0;
@@ -1673,11 +1672,6 @@ static int ie_parse_supported_rates(struct ie_tlv_it=
er *supp_rates_iter,
 	unsigned int len;
 	unsigned int i;
 =

-	len =3D ie_tlv_iter_get_length(supp_rates_iter);
-
-	if (len =3D=3D 0)
-		return -EINVAL;
-
 	/* Find highest rates possible with our RSSI */
 	for (i =3D 0; i < L_ARRAY_SIZE(rate_rssi_map); i++) {
 		const struct basic_rate_map *map =3D &rate_rssi_map[i];
@@ -1688,9 +1682,17 @@ static int ie_parse_supported_rates(struct ie_tlv_it=
er *supp_rates_iter,
 		max_rate =3D map->rate;
 	}
 =

-	if (supp_rates_iter) {
-		/* Find highest rate in Supported Rates IE */
-		rates =3D ie_tlv_iter_get_data(supp_rates_iter);
+	/*
+	 * Find highest rate in Supported Rates IE. These IEs have at least
+	 * been verfied that the length is within the buffer bounds (as has
+	 * ext_supp_rates_ie).
+	 */
+	if (supp_rates_ie) {
+		len =3D supp_rates_ie[1];
+		if (len =3D=3D 0)
+			return -EINVAL;
+
+		rates =3D supp_rates_ie + 2;
 =

 		for (i =3D 0; i < len; i++) {
 			uint8_t r =3D rates[i] & 0x7f;
@@ -1701,9 +1703,12 @@ static int ie_parse_supported_rates(struct ie_tlv_it=
er *supp_rates_iter,
 	}
 =

 	/* Find highest rate in Extended Supported Rates IE */
-	if (ext_supp_rates_iter) {
-		len =3D ie_tlv_iter_get_length(ext_supp_rates_iter);
-		rates =3D ie_tlv_iter_get_data(ext_supp_rates_iter);
+	if (ext_supp_rates_ie) {
+		len =3D ext_supp_rates_ie[1];
+		if (len =3D=3D 0)
+			return -EINVAL;
+
+		rates =3D ext_supp_rates_ie + 2;
 =

 		for (i =3D 0; i < len; i++) {
 			uint8_t r =3D rates[i] & 0x7f;
@@ -1721,45 +1726,6 @@ static int ie_parse_supported_rates(struct ie_tlv_it=
er *supp_rates_iter,
 	return 0;
 }
 =

-int ie_parse_supported_rates_from_data(const uint8_t *supp_rates_ie,
-					uint8_t supp_rates_len,
-					const uint8_t *ext_supp_rates_ie,
-					uint8_t ext_supp_rates_len,
-					int32_t rssi, uint64_t *data_rate)
-{
-	struct ie_tlv_iter supp_rates_iter;
-	struct ie_tlv_iter ext_supp_rates_iter;
-
-	if (supp_rates_ie) {
-		ie_tlv_iter_init(&supp_rates_iter, supp_rates_ie,
-					supp_rates_len);
-
-		if (!ie_tlv_iter_next(&supp_rates_iter))
-			return -EMSGSIZE;
-
-		if (ie_tlv_iter_get_tag(&supp_rates_iter) !=3D
-						IE_TYPE_SUPPORTED_RATES)
-			return -EPROTOTYPE;
-	}
-
-	if (ext_supp_rates_ie) {
-		ie_tlv_iter_init(&ext_supp_rates_iter, ext_supp_rates_ie,
-					ext_supp_rates_len);
-
-		if (!ie_tlv_iter_next(&ext_supp_rates_iter))
-			return -EMSGSIZE;
-
-		if (ie_tlv_iter_get_tag(&ext_supp_rates_iter) !=3D
-					IE_TYPE_EXTENDED_SUPPORTED_RATES)
-			return -EPROTOTYPE;
-	}
-
-	return ie_parse_supported_rates(
-			(supp_rates_ie) ? &supp_rates_iter : NULL,
-			(ext_supp_rates_ie) ? &ext_supp_rates_iter : NULL,
-			rssi, data_rate);
-}
-
 enum ht_vht_channel_width {
 	HT_VHT_CHANNEL_WIDTH_20MHZ =3D 0,
 	HT_VHT_CHANNEL_WIDTH_40MHZ,
@@ -2173,9 +2139,7 @@ int ie_parse_data_rates(const uint8_t *supp_rates_ie,
 =

 	if (supp_rates_ie || ext_supp_rates_ie) {
 		ret =3D ie_parse_supported_rates_from_data(supp_rates_ie,
-						IE_LEN(supp_rates_ie),
 						ext_supp_rates_ie,
-						IE_LEN(supp_rates_ie),
 						rssi, &rate);
 		if (ret =3D=3D 0)
 			goto done;
diff --git a/src/ie.h b/src/ie.h
index 538ca9a8..5f7fa199 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -484,12 +484,6 @@ int ie_parse_bss_load_from_data(const uint8_t *data, u=
int8_t len,
 				uint8_t *out_channel_utilization,
 				uint16_t *out_admission_capacity);
 =

-int ie_parse_supported_rates_from_data(const uint8_t *supp_rates_ie,
-					uint8_t supp_rates_len,
-					const uint8_t *ext_supp_rates_ie,
-					uint8_t ext_supp_rates_len,
-					int32_t rssi, uint64_t *data_rate);
-
 int ie_parse_data_rates(const uint8_t *supp_rates_ie,
 			const uint8_t *ext_supp_rates_ie,
 			const uint8_t *ht_ie,
-- =

2.31.1

--===============1491962388132825110==--

