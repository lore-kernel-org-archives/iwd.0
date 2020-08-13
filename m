Content-Type: multipart/mixed; boundary="===============1876149281873512164=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 01/16] wscutil: Handle a deprecated network key format
Date: Thu, 13 Aug 2020 02:50:11 +0200
Message-ID: <20200813005026.294950-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1876149281873512164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement a note from the spec saying that implementations should handle
NUL-terminated Network Keys inside credentials structures.
---
 src/wscutil.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/src/wscutil.c b/src/wscutil.c
index 6b445ce4..a41702e8 100644
--- a/src/wscutil.c
+++ b/src/wscutil.c
@@ -362,13 +362,25 @@ static bool extract_network_key(struct wsc_attr_iter =
*iter, void *data)
 {
 	struct iovec *network_key =3D data;
 	unsigned int len;
+	const uint8_t *key;
 =

 	len =3D wsc_attr_iter_get_length(iter);
 	if (len > 64)
 		return false;
 =

+	/*
+	 * WSC 2.0.5, Section 12, Network Key:
+	 * "Some existing implementations based on v1.0h null-terminate the
+	 * passphrase value, i.e., add an extra 0x00 octet into the end of
+	 * the value. For backwards compatibility, implementations shall be
+	 * able to parse such a value"
+	 */
+	key =3D wsc_attr_iter_get_data(iter);
+	if (len && key[len - 1] =3D=3D 0x00)
+		len--;
+
 	network_key->iov_len =3D len;
-	network_key->iov_base =3D (void *) wsc_attr_iter_get_data(iter);
+	network_key->iov_base =3D (void *) key;
 =

 	return true;
 }
-- =

2.25.1

--===============1876149281873512164==--

