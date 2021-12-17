Content-Type: multipart/mixed; boundary="===============7854080433333011449=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v5 1/4] dpp-util: add DPP attribute building APIs
Date: Fri, 17 Dec 2021 11:14:48 -0800
Message-ID: <20211217191451.179444-1-prestwoj@gmail.com>

--===============7854080433333011449==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dpp-util.c | 143 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/dpp-util.h |  10 ++++
 src/dpp.c      |  10 ----
 3 files changed, 153 insertions(+), 10 deletions(-)

v5:
 * Moved these APIs into dpp-util instead of dpp.c so they can be
   unit tested
 * Changed so the caller supplies ad0/ad1. This takes the burden off
   these utilities to sort out what type of frame, and any quirks of
   how AAD is supposed to be used (see comments in authentication
   and configuration patches)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index f41127c7..f281f346 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -238,6 +238,149 @@ bool dpp_attr_iter_next(struct dpp_attr_iter *iter,
 	return true;
 }
 =

+size_t dpp_append_attr(uint8_t *to, enum dpp_attribute_type type,
+				void *attr, size_t attr_len)
+{
+	l_put_le16(type, to);
+	l_put_le16(attr_len, to + 2);
+	memcpy(to + 4, attr, attr_len);
+
+	return attr_len + 4;
+}
+
+/*
+ * The use of ad0/ad1 differs with different protocol frame types, which i=
s why
+ * this is left up to the caller to pass the correct AD bytes. The usage is
+ * defined in:
+ *
+ * 6.3.1.4 Protocol Conventions (for authentication)
+ * 6.4.1 Overview (for configuration)
+ *
+ */
+uint8_t *dpp_unwrap_attr(const void *ad0, size_t ad0_len, const void *ad1,
+				size_t ad1_len, const void *key, size_t key_len,
+				const void *wrapped, size_t wrapped_len,
+				size_t *unwrapped_len)
+{
+	struct iovec ad[2];
+	uint8_t *unwrapped;
+	size_t ad_size =3D 0;
+
+	if (ad0) {
+		ad[ad_size].iov_base =3D (void *) ad0;
+		ad[ad_size].iov_len =3D ad0_len;
+		ad_size++;
+	}
+
+	if (ad1) {
+		ad[ad_size].iov_base =3D (void *) ad1;
+		ad[ad_size].iov_len =3D ad1_len;
+		ad_size++;
+	}
+
+	unwrapped =3D l_malloc(wrapped_len - 16);
+
+	if (!aes_siv_decrypt(key, key_len, wrapped, wrapped_len, ad, 2,
+				unwrapped)) {
+		l_free(unwrapped);
+		return NULL;
+	}
+
+	*unwrapped_len =3D wrapped_len - 16;
+
+	return unwrapped;
+}
+
+/*
+ * Encrypt DPP attributes encapsulated in DPP wrapped data.
+ *
+ * ad0/ad0_len - frame specific AD0 component
+ * ad1/ad0_len - frame specific AD1 component
+ * to - buffer to encrypt data.
+ * to_len - size of 'to'
+ * key - key used to encrypt
+ * key_len - size of 'key'
+ * num_attrs - number of attributes listed (type, length, data triplets)
+ * ... - List of attributes, Type, Length, and data
+ */
+size_t dpp_append_wrapped_data(const void *ad0, size_t ad0_len,
+				const void *ad1, size_t ad1_len,
+				uint8_t *to, size_t to_len,
+				const void *key, size_t key_len,
+				size_t num_attrs, ...)
+{
+	size_t i;
+	size_t attrs_len =3D 0;
+	_auto_(l_free) uint8_t *plaintext =3D NULL;
+	uint8_t *ptr;
+	struct iovec ad[2];
+	size_t ad_size =3D 0;
+	va_list va;
+
+	va_start(va, num_attrs);
+
+	/* Count up total attributes length */
+	for (i =3D 0; i < num_attrs; i++) {
+		va_arg(va, enum dpp_attribute_type);
+		attrs_len +=3D va_arg(va, size_t) + 4;
+		va_arg(va, void*);
+	}
+
+	if (to_len < attrs_len + 4 + 16)
+		return false;
+
+	plaintext =3D l_malloc(attrs_len);
+
+	ptr =3D plaintext;
+
+	va_end(va);
+
+	va_start(va, num_attrs);
+
+	/* Build up plaintext attributes */
+	for (i =3D 0; i < num_attrs; i++) {
+		enum dpp_attribute_type type =3D va_arg(va,
+						enum dpp_attribute_type);
+		size_t l =3D va_arg(va, size_t);
+		void *p =3D va_arg(va, void *);
+
+		l_put_le16(type, ptr);
+		ptr +=3D 2;
+		l_put_le16(l, ptr);
+		ptr +=3D 2;
+		memcpy(ptr, p, l);
+		ptr +=3D l;
+	}
+
+	va_end(va);
+
+	ptr =3D to;
+
+	l_put_le16(DPP_ATTR_WRAPPED_DATA, ptr);
+	ptr +=3D 2;
+	l_put_le16(attrs_len + 16, ptr);
+	ptr +=3D 2;
+
+	if (ad0) {
+		ad[ad_size].iov_base =3D (void *) ad0;
+		ad[ad_size].iov_len =3D ad0_len;
+		ad_size++;
+	}
+
+	if (ad1) {
+		ad[ad_size].iov_base =3D (void *) ad1;
+		ad[ad_size].iov_len =3D ad1_len;
+		ad_size++;
+	}
+
+	if (!aes_siv_encrypt(key, key_len, plaintext, attrs_len,
+				ad, ad_size, ptr))
+		return 0;
+
+	return attrs_len + 4 + 16;
+}
+
+
 /*
  * EasyConnect 2.0 Table 3. Key and Nonce Length Dependency on Prime Length
  */
diff --git a/src/dpp-util.h b/src/dpp-util.h
index 84404128..543cf9f8 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -122,6 +122,16 @@ void dpp_attr_iter_init(struct dpp_attr_iter *iter, co=
nst uint8_t *pdu,
 bool dpp_attr_iter_next(struct dpp_attr_iter *iter,
 			enum dpp_attribute_type *type, size_t *len,
 			const uint8_t **data);
+uint8_t *dpp_unwrap_attr(const void *ad0, size_t ad0_len, const void *ad1,
+				size_t ad1_len, const void *key, size_t key_len,
+				const void *wrapped, size_t wrapped_len,
+				size_t *unwrapped_len);
+size_t dpp_append_attr(uint8_t *to, enum dpp_attribute_type type,
+				void *attr, size_t attr_len);
+size_t dpp_append_wrapped_data(const void *ad0, size_t ad0_len, const void=
 *ad1,
+				size_t ad1_len, uint8_t *to, size_t to_len,
+				const void *key, size_t key_len,
+				size_t num_attrs, ...);
 =

 char *dpp_generate_uri(const uint8_t *asn1, size_t asn1_len, uint8_t versi=
on,
 			const uint8_t *mac, const uint32_t *freqs,
diff --git a/src/dpp.c b/src/dpp.c
index 0a42e321..d9666ead 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -143,16 +143,6 @@ static void dpp_send_frame(uint64_t wdev_id, struct io=
vec *iov, size_t iov_len,
 		l_error("Could not send CMD_FRAME");
 }
 =

-static size_t dpp_append_attr(uint8_t *to, enum dpp_attribute_type type,
-				void *attr, size_t attr_len)
-{
-	l_put_le16(type, to);
-	l_put_le16(attr_len, to + 2);
-	memcpy(to + 4, attr, attr_len);
-
-	return attr_len + 4;
-}
-
 static size_t dpp_build_header(const uint8_t *src, const uint8_t *dest,
 				enum dpp_frame_type type,
 				uint8_t buf[static 32])
-- =

2.31.1

--===============7854080433333011449==--

