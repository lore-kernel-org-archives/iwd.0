Content-Type: multipart/mixed; boundary="===============3232824088905735058=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/5] wscutil: Allow 0-length attributes in wsc_attr_builder
Date: Tue, 25 Aug 2020 00:34:22 +0200
Message-ID: <20200824223426.475779-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3232824088905735058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

wsc_attr_builder_start_attr and wsc_attr_builder_free look at
builder->curlen to see whether the TLV's length needs to be updated to
include the previous attribute.  If builder->curlen is 0
wsc_attr_builder_start_attr assumes there's no previous attribute and
starts writing at current builder->offset.  If the previous attribute
length was 0 curlen would stay at 0 and that attribute would get
overwritten with the new one.  To solve this add the 4 bytes of the T
and L to curlen as soon as a new attribute is started, and subtract
them when writing the L value.  The alternative would be to set a flag
to say whether an attribute was started.

The spec explicitly allows 0-length attributes in section 12:
"The variable length string attributes, e.g., Device Name, are encoded
without null-termination, i.e., no 0x00 octets added to the end of the
value. If the string is empty, the attribute length is set to zero."
---
 src/wscutil.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/src/wscutil.c b/src/wscutil.c
index a41702e8..d78a0354 100644
--- a/src/wscutil.c
+++ b/src/wscutil.c
@@ -1634,11 +1634,12 @@ static bool wsc_attr_builder_start_attr(struct wsc_=
attr_builder *builder,
 	/* Record previous attribute's length */
 	if (builder->curlen > 0) {
 		bytes =3D builder->buf + builder->offset;
-		l_put_be16(builder->curlen, bytes + 2);
-		builder->offset +=3D 4 + builder->curlen;
-		builder->curlen =3D 0;
+		l_put_be16(builder->curlen - 4, bytes + 2);
+		builder->offset +=3D builder->curlen;
 	}
 =

+	builder->curlen =3D 4;
+
 	if (builder->offset + 4 >=3D builder->capacity)
 		wsc_attr_builder_grow(builder);
 =

@@ -1650,10 +1651,10 @@ static bool wsc_attr_builder_start_attr(struct wsc_=
attr_builder *builder,
 =

 static bool wsc_attr_builder_put_u8(struct wsc_attr_builder *builder, uint=
8_t v)
 {
-	if (builder->offset + 4 + builder->curlen + 1 >=3D builder->capacity)
+	if (builder->offset + builder->curlen + 1 >=3D builder->capacity)
 		wsc_attr_builder_grow(builder);
 =

-	builder->buf[builder->offset + 4 + builder->curlen] =3D v;
+	builder->buf[builder->offset + builder->curlen] =3D v;
 	builder->curlen +=3D 1;
 =

 	return true;
@@ -1662,10 +1663,10 @@ static bool wsc_attr_builder_put_u8(struct wsc_attr=
_builder *builder, uint8_t v)
 static bool wsc_attr_builder_put_u16(struct wsc_attr_builder *builder,
 								uint16_t v)
 {
-	if (builder->offset + 4 + builder->curlen + 2 >=3D builder->capacity)
+	if (builder->offset + builder->curlen + 2 >=3D builder->capacity)
 		wsc_attr_builder_grow(builder);
 =

-	l_put_be16(v, builder->buf + builder->offset + 4 + builder->curlen);
+	l_put_be16(v, builder->buf + builder->offset + builder->curlen);
 	builder->curlen +=3D 2;
 =

 	return true;
@@ -1674,10 +1675,10 @@ static bool wsc_attr_builder_put_u16(struct wsc_att=
r_builder *builder,
 static bool wsc_attr_builder_put_u32(struct wsc_attr_builder *builder,
 								uint32_t v)
 {
-	if (builder->offset + 4 + builder->curlen + 4 >=3D builder->capacity)
+	if (builder->offset + builder->curlen + 4 >=3D builder->capacity)
 		wsc_attr_builder_grow(builder);
 =

-	l_put_be32(v, builder->buf + builder->offset + 4 + builder->curlen);
+	l_put_be32(v, builder->buf + builder->offset + builder->curlen);
 	builder->curlen +=3D 4;
 =

 	return true;
@@ -1686,12 +1687,10 @@ static bool wsc_attr_builder_put_u32(struct wsc_att=
r_builder *builder,
 static bool wsc_attr_builder_put_bytes(struct wsc_attr_builder *builder,
 					const void *bytes, size_t size)
 {
-	while (builder->offset + 4 + builder->curlen + size >=3D
-							builder->capacity)
+	while (builder->offset + builder->curlen + size >=3D builder->capacity)
 		wsc_attr_builder_grow(builder);
 =

-	memcpy(builder->buf + builder->offset + 4 + builder->curlen,
-								bytes, size);
+	memcpy(builder->buf + builder->offset + builder->curlen, bytes, size);
 	builder->curlen +=3D size;
 =

 	return true;
@@ -1700,10 +1699,10 @@ static bool wsc_attr_builder_put_bytes(struct wsc_a=
ttr_builder *builder,
 static bool wsc_attr_builder_put_oui(struct wsc_attr_builder *builder,
 							const uint8_t *oui)
 {
-	if (builder->offset + 4 + builder->curlen + 3 >=3D builder->capacity)
+	if (builder->offset + builder->curlen + 3 >=3D builder->capacity)
 		wsc_attr_builder_grow(builder);
 =

-	memcpy(builder->buf + builder->offset + 4 + builder->curlen, oui, 3);
+	memcpy(builder->buf + builder->offset + builder->curlen, oui, 3);
 	builder->curlen +=3D 3;
 =

 	return true;
@@ -1721,11 +1720,10 @@ static bool wsc_attr_builder_put_string(struct wsc_=
attr_builder *builder,
 		len =3D 1;
 	}
 =

-	if (builder->offset + 4 + builder->curlen + len >=3D builder->capacity)
+	if (builder->offset + builder->curlen + len >=3D builder->capacity)
 		wsc_attr_builder_grow(builder);
 =

-	memcpy(builder->buf + builder->offset + 4 + builder->curlen,
-								string, len);
+	memcpy(builder->buf + builder->offset + builder->curlen, string, len);
 	builder->curlen +=3D len;
 =

 	return true;
@@ -1753,8 +1751,8 @@ static uint8_t *wsc_attr_builder_free(struct wsc_attr=
_builder *builder,
 =

 	if (builder->curlen > 0) {
 		uint8_t *bytes =3D builder->buf + builder->offset;
-		l_put_be16(builder->curlen, bytes + 2);
-		builder->offset +=3D 4 + builder->curlen;
+		l_put_be16(builder->curlen - 4, bytes + 2);
+		builder->offset +=3D builder->curlen;
 		builder->curlen =3D 0;
 	}
 =

-- =

2.25.1

--===============3232824088905735058==--

