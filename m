Content-Type: multipart/mixed; boundary="===============3135866012064227357=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v5 1/9] dpp-util: add URI parsing
Date: Tue, 22 Feb 2022 13:30:08 -0800
Message-ID: <20220222213016.2429382-1-prestwoj@gmail.com>

--===============3135866012064227357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Parses K (key), M (mac), C (class/channels), and V (version) tokens
into a new structure dpp_uri_info. H/I are not parsed since there
currently isn't any use for them.
---
 src/dpp-util.c | 253 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/dpp-util.h |  13 +++
 2 files changed, 266 insertions(+)

v5:
 * Added several checks to the strtoul calls to handle hopefully all
   invalid inputs that strtoul still accepts.

diff --git a/src/dpp-util.c b/src/dpp-util.c
index 5199d0ae..01122e6b 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -866,3 +866,256 @@ struct l_ecc_point *dpp_point_from_asn1(const uint8_t=
 *asn1, size_t len)
 	return l_ecc_point_from_data(curve, key_data[1],
 					key_data + 2, elen - 2);
 }
+
+/*
+ * Advances 'p' to the next character 'sep' plus one. strchr can be truste=
d to
+ * find the next character, but we do need to check that the next characte=
r + 1
+ * isn't the NULL terminator, i.e. that data actually exists past this poi=
nt.
+ */
+#define TOKEN_NEXT(p, sep) \
+({ \
+	const char *_next =3D strchr((p), (sep)); \
+	if (_next) { \
+		if (*(_next + 1) =3D=3D '\0') \
+			_next =3D NULL; \
+		else \
+			_next++; \
+	} \
+	_next; \
+})
+
+/*
+ * Finds the length of the current token (characters until next 'sep'). If=
 no
+ * 'sep' is found zero is returned.
+ */
+#define TOKEN_LEN(p, sep) \
+({ \
+	const char *_next =3D strchr((p), (sep)); \
+	if (!_next) \
+		_next =3D (p); \
+	(_next - (p)); \
+})
+
+/*
+ * Ensures 'p' points to something resembling a single character followed =
by
+ * ':' followed by at least one non-null byte of data. This allows the par=
se
+ * loop to safely advance the pointer to each tokens data (pos + 2)
+ */
+#define TOKEN_OK(p) \
+	((p) && (p)[0] !=3D '\0' && (p)[1] =3D=3D ':' && (p)[2] !=3D '\0') \
+
+static struct scan_freq_set *dpp_parse_class_and_channel(const char *token,
+							unsigned int len)
+{
+	const char *pos =3D token;
+	char *end;
+	struct scan_freq_set *freqs =3D scan_freq_set_new();
+
+	/* Checking for <operclass>/<channel>,<operclass>/<channel>,... */
+	for (; pos && pos < token + len; pos =3D TOKEN_NEXT(pos, ',')) {
+		unsigned long r;
+		uint8_t channel;
+		uint8_t oper_class;
+		uint32_t freq;
+
+		/* strtoul accepts minus and plus signs before value */
+		if (*pos =3D=3D '-' || *pos =3D=3D '+')
+			goto free_set;
+
+		/* to check uint8_t overflow */
+		r =3D oper_class =3D strtoul(pos, &end, 10);
+
+		if (errno =3D=3D ERANGE || errno =3D=3D EINVAL)
+			goto free_set;
+		/*
+		 * Did strtoul not advance pointer, not reach the next
+		 * token, or overflow?
+		 */
+		if (end =3D=3D pos || *end !=3D '/' || r !=3D oper_class)
+			goto free_set;
+
+		pos =3D end + 1;
+
+		if (*pos =3D=3D '-' || *pos =3D=3D '+')
+			goto free_set;
+
+		r =3D channel =3D strtoul(pos, &end, 10);
+
+		if (errno =3D=3D ERANGE || errno =3D=3D EINVAL)
+			goto free_set;
+		/*
+		 * Same verification as above, but also checks either for
+		 * another pair (,) or end of this token (;)
+		 */
+		if (end =3D=3D pos || (*end !=3D ',' && *end !=3D ';') || r !=3D channel)
+			goto free_set;
+
+		freq =3D oci_to_frequency(oper_class, channel);
+		if (!freq)
+			goto free_set;
+
+		scan_freq_set_add(freqs, freq);
+	}
+
+	if (token + len !=3D end)
+		goto free_set;
+
+	if (scan_freq_set_isempty(freqs)) {
+free_set:
+		scan_freq_set_free(freqs);
+		return NULL;
+	}
+
+	return freqs;
+}
+
+static int dpp_parse_mac(const char *str, unsigned int len, uint8_t *mac_o=
ut)
+{
+	uint8_t mac[6];
+	unsigned int i;
+
+	if (len !=3D 12)
+		return -EINVAL;
+
+	for (i =3D 0; i < 12; i +=3D 2) {
+		if (!l_ascii_isxdigit(str[i]))
+			return -EINVAL;
+
+		if (!l_ascii_isxdigit(str[i + 1]))
+			return -EINVAL;
+	}
+
+	if (sscanf(str, "%2hhx%2hhx%2hhx%2hhx%2hhx%2hhx",
+			&mac[0], &mac[1], &mac[2],
+			&mac[3], &mac[4], &mac[5]) !=3D 6)
+		return -EINVAL;
+
+	if (!util_is_valid_sta_address(mac))
+		return -EINVAL;
+
+	memcpy(mac_out, mac, 6);
+
+	return 0;
+}
+
+static int dpp_parse_version(const char *str, unsigned int len,
+				uint8_t *version_out)
+{
+	char *end;
+	uint8_t version;
+
+	if (len !=3D 1)
+		return -EINVAL;
+
+	version =3D strtol(str, &end, 10);
+
+	if (version !=3D 1 && version !=3D 2)
+		return -EINVAL;
+
+	*version_out =3D version;
+
+	return 0;
+}
+
+static struct l_ecc_point *dpp_parse_key(const char *str, unsigned int len)
+{
+	_auto_(l_free) uint8_t *decoded =3D NULL;
+	size_t decoded_len;
+
+	decoded =3D l_base64_decode(str, len, &decoded_len);
+	if (!decoded)
+		return NULL;
+
+	return dpp_point_from_asn1(decoded, decoded_len);
+}
+
+/*
+ * Parse a bootstrapping URI. This parses the tokens defined in the Easy C=
onnect
+ * spec, and verifies they are the correct syntax. Some values have extra
+ * verification:
+ *  - The bootstrapping key is base64 decoded and converted to an l_ecc_po=
int
+ *  - The operating class and channels are checked against the OCI table.
+ *  - The version is checked to be either 1 or 2, as defined by the spec.
+ *  - The MAC is verified to be a valid station address.
+ */
+struct dpp_uri_info *dpp_parse_uri(const char *uri)
+{
+	struct dpp_uri_info *info;
+	const char *pos =3D uri;
+	const char *end =3D uri + strlen(uri) - 1;
+	int ret =3D 0;
+
+	if (!l_str_has_prefix(pos, "DPP:"))
+		return NULL;
+
+	info =3D l_new(struct dpp_uri_info, 1);
+
+	pos +=3D 4;
+
+	/* EasyConnect 5.2.1 - Bootstrapping information format */
+	for (; TOKEN_OK(pos); pos =3D TOKEN_NEXT(pos, ';')) {
+		unsigned int len =3D TOKEN_LEN(pos + 2, ';');
+
+		if (!len)
+			goto free_info;
+
+		switch (*pos) {
+		case 'C':
+			info->freqs =3D dpp_parse_class_and_channel(pos + 2, len);
+			if (!info->freqs)
+				goto free_info;
+			break;
+		case 'M':
+			ret =3D dpp_parse_mac(pos + 2, len, info->mac);
+			if (ret < 0)
+				goto free_info;
+			break;
+		case 'V':
+			ret =3D dpp_parse_version(pos + 2, len, &info->version);
+			if (ret < 0)
+				goto free_info;
+			break;
+		case 'K':
+			info->boot_public =3D dpp_parse_key(pos + 2, len);
+			if (!info->boot_public)
+				goto free_info;
+			break;
+		case 'H':
+		case 'I':
+			break;
+		default:
+			goto free_info;
+		}
+	}
+
+	/* Extra data found after last token */
+	if (pos !=3D end)
+		goto free_info;
+
+	/* The public bootstrapping key is the only required token */
+	if (!info->boot_public)
+		goto free_info;
+
+	return info;
+
+free_info:
+	dpp_free_uri_info(info);
+	return NULL;
+}
+
+void dpp_free_uri_info(struct dpp_uri_info *info)
+{
+	if (info->freqs)
+		scan_freq_set_free(info->freqs);
+
+	if (info->boot_public)
+		l_ecc_point_free(info->boot_public);
+
+	if (info->information)
+		l_free(info->information);
+
+	if (info->host)
+		l_free(info->host);
+
+	l_free(info);
+}
diff --git a/src/dpp-util.h b/src/dpp-util.h
index 82535ff8..a3ddd452 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -22,6 +22,16 @@
 struct l_ecc_point;
 struct l_ecc_scalar;
 enum ie_rsn_akm_suite;
+struct scan_freq_set;
+
+struct dpp_uri_info {
+	struct scan_freq_set *freqs;
+	struct l_ecc_point *boot_public;
+	uint8_t mac[6];
+	char *information;
+	uint8_t version;
+	char *host;
+};
 =

 enum dpp_frame_type {
 	DPP_FRAME_AUTHENTICATION_REQUEST	=3D 0,
@@ -168,3 +178,6 @@ bool dpp_derive_ke(const uint8_t *i_nonce, const uint8_=
t *r_nonce,
 =

 uint8_t *dpp_point_to_asn1(const struct l_ecc_point *p, size_t *len_out);
 struct l_ecc_point *dpp_point_from_asn1(const uint8_t *asn1, size_t len);
+
+struct dpp_uri_info *dpp_parse_uri(const char *uri);
+void dpp_free_uri_info(struct dpp_uri_info *info);
-- =

2.34.1

--===============3135866012064227357==--

