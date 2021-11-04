Content-Type: multipart/mixed; boundary="===============1735733355386292237=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/5] ie: parse DGAF Disable bit from HS20 indication element
Date: Thu, 04 Nov 2021 10:57:55 -0700
Message-ID: <20211104175758.532953-2-prestwoj@gmail.com>
In-Reply-To: 20211104175758.532953-1-prestwoj@gmail.com

--===============1735733355386292237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ie.c   | 11 ++++++++---
 src/ie.h   |  5 +++--
 src/scan.c |  3 ++-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/src/ie.c b/src/ie.c
index a5f3cbc2..8108c02a 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -2035,7 +2035,8 @@ int ie_build_roaming_consortium(const uint8_t *rc, si=
ze_t rc_len, uint8_t *to)
 }
 =

 int ie_parse_hs20_indication(struct ie_tlv_iter *iter, uint8_t *version_ou=
t,
-				uint16_t *pps_mo_id_out, uint8_t *domain_id_out)
+				uint16_t *pps_mo_id_out, uint8_t *domain_id_out,
+				bool *dgaf_disable_out)
 {
 	unsigned int len =3D ie_tlv_iter_get_length(iter);
 	const uint8_t *data =3D ie_tlv_iter_get_data(iter);
@@ -2060,6 +2061,9 @@ int ie_parse_hs20_indication(struct ie_tlv_iter *iter=
, uint8_t *version_out,
 	if (pps_mo_present && domain_id_present)
 		return -EPROTOTYPE;
 =

+	if (dgaf_disable_out)
+		*dgaf_disable_out =3D test_bit(&hs20_config, 0);
+
 	if (version_out)
 		*version_out =3D bit_field(hs20_config, 4, 4);
 =

@@ -2087,7 +2091,7 @@ int ie_parse_hs20_indication(struct ie_tlv_iter *iter=
, uint8_t *version_out,
 =

 int ie_parse_hs20_indication_from_data(const uint8_t *data, size_t len,
 					uint8_t *version, uint16_t *pps_mo_id,
-					uint8_t *domain_id)
+					uint8_t *domain_id, bool *dgaf_disable)
 {
 	struct ie_tlv_iter iter;
 =

@@ -2099,7 +2103,8 @@ int ie_parse_hs20_indication_from_data(const uint8_t =
*data, size_t len,
 	if (ie_tlv_iter_get_tag(&iter) !=3D IE_TYPE_VENDOR_SPECIFIC)
 		return -EPROTOTYPE;
 =

-	return ie_parse_hs20_indication(&iter, version, pps_mo_id, domain_id);
+	return ie_parse_hs20_indication(&iter, version, pps_mo_id, domain_id,
+						dgaf_disable);
 }
 =

 /*
diff --git a/src/ie.h b/src/ie.h
index b122524b..685350d6 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -616,10 +616,11 @@ int ie_parse_roaming_consortium_from_data(const uint8=
_t *data, size_t len,
 int ie_build_roaming_consortium(const uint8_t *rc, size_t rc_len, uint8_t =
*to);
 =

 int ie_parse_hs20_indication(struct ie_tlv_iter *iter, uint8_t *version,
-				uint16_t *pps_mo_id, uint8_t *domain_id);
+				uint16_t *pps_mo_id, uint8_t *domain_id,
+				bool *dgaf_disable);
 int ie_parse_hs20_indication_from_data(const uint8_t *data, size_t len,
 					uint8_t *version, uint16_t *pps_mo_id,
-					uint8_t *domain_id);
+					uint8_t *domain_id, bool *dgaf_disable);
 int ie_build_hs20_indication(uint8_t version, uint8_t *to);
 =

 enum ie_rsnx_capability {
diff --git a/src/scan.c b/src/scan.c
index 2a96943b..815cb3f2 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1071,7 +1071,8 @@ static void scan_parse_vendor_specific(struct scan_bs=
s *bss, const void *data,
 =

 	if (is_ie_wfa_ie(data, len, IE_WFA_OI_HS20_INDICATION)) {
 		if (ie_parse_hs20_indication_from_data(data - 2, len + 2,
-					&bss->hs20_version, NULL, NULL) < 0)
+					&bss->hs20_version, NULL, NULL,
+					NULL) < 0)
 			return;
 =

 		bss->hs20_capable =3D true;
-- =

2.31.1

--===============1735733355386292237==--

