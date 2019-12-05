Content-Type: multipart/mixed; boundary="===============2097576726026773687=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 5/6] crypto: Add support for PRF+ SHA1
Date: Thu, 05 Dec 2019 13:13:53 -0800
Message-ID: <20191205211354.19075-5-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191205211354.19075-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2097576726026773687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The PRF+ algorithm is based Internet Key Exchange (IKEv2) Protocol:
	https://www.ietf.org/rfc/rfc4306.txt
---
 src/crypto.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/crypto.h |  3 +++
 2 files changed, 67 insertions(+)

diff --git a/src/crypto.c b/src/crypto.c
index 67a042be..c1fe83a2 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -581,6 +581,70 @@ bool prf_sha1(const void *key, size_t key_len,
 	return true;
 }
 =

+bool prf_plus_sha1(const void *key, size_t key_len,
+					const void *label, size_t label_len,
+					const void *seed, size_t seed_len,
+					void *output, size_t size)
+{
+	/*
+	 * PRF+ (K, S, LEN) =3D T1 | T2 | T3 | T4 | ... where:
+	 *
+	 * T1 =3D HMAC-SHA1 (K, S | LEN | 0x01 | 0x00 | 0x00)
+	 *
+	 * T2 =3D HMAC-SHA1 (K, T1 | S | LEN | 0x02 | 0x00 | 0x00)
+	 *
+	 * T3 =3D HMAC-SHA1 (K, T2 | S | LEN | 0x03 | 0x00 | 0x00)
+	 *
+	 * T4 =3D HMAC-SHA1 (K, T3 | S | LEN | 0x04 | 0x00 | 0x00)
+	 *
+	 * ...
+	 */
+
+	static const uint8_t SHA1_MAC_LEN =3D 20;
+	static const uint8_t nil_bytes[2] =3D { 0, 0 };
+	struct l_checksum *hmac;
+	uint8_t t[SHA1_MAC_LEN];
+	uint8_t counter;
+	struct iovec iov[5] =3D {
+		[0] =3D { .iov_base =3D (void *) t, .iov_len =3D 0 },
+		[1] =3D { .iov_base =3D (void *) label, .iov_len =3D label_len },
+		[2] =3D { .iov_base =3D (void *) seed, .iov_len =3D seed_len },
+		[3] =3D { .iov_base =3D &counter, .iov_len =3D 1 },
+		[4] =3D { .iov_base =3D (void *) nil_bytes, .iov_len =3D 2 },
+	};
+
+	hmac =3D l_checksum_new_hmac(L_CHECKSUM_SHA1, key, key_len);
+	if (!hmac)
+		return false;
+
+	/* PRF processes in 160-bit chunks (20 bytes) */
+	for (counter =3D 1;; counter++) {
+		size_t len;
+
+		if (size > SHA1_MAC_LEN)
+			len =3D SHA1_MAC_LEN;
+		else
+			len =3D size;
+
+		l_checksum_updatev(hmac, iov, 5);
+		l_checksum_get_digest(hmac, t, len);
+
+		memcpy(output, t, len);
+
+		size -=3D len;
+
+		if (!size)
+			break;
+
+		output +=3D len;
+		iov[0].iov_len =3D len;
+	}
+
+	l_checksum_free(hmac);
+
+	return true;
+}
+
 /* Defined in 802.11-2012, Section 11.6.1.7.2 Key derivation function (KDF=
) */
 bool kdf_sha256(const void *key, size_t key_len,
 		const void *prefix, size_t prefix_len,
diff --git a/src/crypto.h b/src/crypto.h
index 23ca2450..89e2402c 100644
--- a/src/crypto.h
+++ b/src/crypto.h
@@ -106,6 +106,9 @@ bool kdf_sha384(const void *key, size_t key_len,
 bool prf_sha1(const void *key, size_t key_len,
 		const void *prefix, size_t prefix_len,
 		const void *data, size_t data_len, void *output, size_t size);
+bool prf_plus_sha1(const void *key, size_t key_len,
+		const void *prefix, size_t prefix_len,
+		const void *data, size_t data_len, void *output, size_t size);
 bool hkdf_extract(enum l_checksum_type type, const uint8_t *key, size_t ke=
y_len,
 				uint8_t num_args, uint8_t *out, ...);
 =

-- =

2.13.6

--===============2097576726026773687==--

