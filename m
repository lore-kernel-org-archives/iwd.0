Content-Type: multipart/mixed; boundary="===============5147771585573239069=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/4] dpp-util: add URI generation API
Date: Mon, 06 Dec 2021 13:03:54 -0800
Message-ID: <20211206210356.1204046-2-prestwoj@gmail.com>
In-Reply-To: 20211206210356.1204046-1-prestwoj@gmail.com

--===============5147771585573239069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dpp-util.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/dpp-util.h |  4 ++++
 2 files changed, 64 insertions(+)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index 8482b1ff..ca641311 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -33,6 +33,66 @@
 #include "src/dpp-util.h"
 #include "src/util.h"
 #include "src/crypto.h"
+#include "src/scan.h"
+
+static void append_freqs(struct l_string *uri, const uint32_t *freqs, size=
_t len)
+{
+	size_t i;
+	enum band_freq band;
+
+	l_string_append_printf(uri, "C:");
+
+	for (i =3D 0; i < len; i++) {
+		uint8_t oper_class;
+		uint8_t channel =3D band_freq_to_channel(freqs[i], &band);
+
+		/* For now use global operating classes */
+		if (band =3D=3D BAND_FREQ_2_4_GHZ)
+			oper_class =3D 81;
+		else
+			oper_class =3D 115;
+
+		l_string_append_printf(uri, "%u/%u", oper_class, channel);
+
+		if (i !=3D len - 1)
+			l_string_append_c(uri, ',');
+	}
+
+	l_string_append_c(uri, ';');
+}
+
+char *dpp_generate_uri(const uint8_t *asn1, size_t asn1_len, uint8_t versi=
on,
+			const uint8_t *mac, const uint32_t *freqs,
+			size_t freqs_len, const char *info, const char *host)
+{
+	struct l_string *uri =3D l_string_new(256);
+	char *base64;
+
+	base64 =3D l_base64_encode(asn1, asn1_len, 0);
+
+	l_string_append_printf(uri, "DPP:K:%s;", base64);
+	l_free(base64);
+
+	if (mac)
+		l_string_append_printf(uri, "M:%02x%02x%02x%02x%02x%02x;",
+					MAC_STR(mac));
+
+	if (freqs)
+		append_freqs(uri, freqs, freqs_len);
+
+	if (info)
+		l_string_append_printf(uri, "I:%s;", info);
+
+	if (host)
+		l_string_append_printf(uri, "H:%s;", host);
+
+	if (version)
+		l_string_append_printf(uri, "V:%u;", version);
+
+	l_string_append_c(uri, ';');
+
+	return l_string_unwrap(uri);
+}
 =

 /*
  * EasyConnect 2.0 Table 3. Key and Nonce Length Dependency on Prime Length
diff --git a/src/dpp-util.h b/src/dpp-util.h
index 92fc38e3..971c0ce4 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -22,6 +22,10 @@
 struct l_ecc_point;
 struct l_ecc_scalar;
 =

+char *dpp_generate_uri(const uint8_t *asn1, size_t asn1_len, uint8_t versi=
on,
+			const uint8_t *mac, const uint32_t *freqs,
+			size_t freqs_len, const char *info, const char *host);
+
 size_t dpp_nonce_len_from_key_len(size_t len);
 =

 bool dpp_hash(enum l_checksum_type type, uint8_t *out, unsigned int num, .=
..);
-- =

2.31.1

--===============5147771585573239069==--

