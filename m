Content-Type: multipart/mixed; boundary="===============0131481156527080698=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] util: add util_is_field_bit_set
Date: Thu, 07 Nov 2019 10:19:08 -0800
Message-ID: <20191107181909.29773-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0131481156527080698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This lets you easily check if a bit is set in a field of bytes. This was
added as a new API rather than modifiying util_is_bit_set since its still
useful to check if a bit is set in a single byte.

The drive here is that we have many places doing e.g.

if (util_bit_is_set(data[3], 4))
   ...

To check the 28th bit in a field (in this example). This makes the code
hard to read since you have to do math (3 * 8 + 4) to figure out what bit
is actually being checked in the overall field.
---
 src/util.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/util.h b/src/util.h
index dfd1c847..e1230714 100644
--- a/src/util.h
+++ b/src/util.h
@@ -54,6 +54,13 @@ static inline bool util_is_bit_set(const uint8_t oct, in=
t bit)
 	return oct & mask ? true : false;
 }
 =

+static inline bool util_is_field_bit_set(const uint8_t *field, int bit)
+{
+	uint8_t oct =3D field[bit / 8];
+
+	return util_is_bit_set(oct, bit % 8);
+}
+
 static inline bool util_mem_is_zero(const uint8_t *field, size_t size)
 {
 	size_t i;
-- =

2.17.1

--===============0131481156527080698==--

