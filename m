Content-Type: multipart/mixed; boundary="===============1832381759317346538=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 02/12] cleanup: Remove extra empty lines
Date: Wed, 18 Mar 2020 15:45:21 +0100
Message-ID: <20200318144531.30613-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200318144531.30613-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1832381759317346538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/eap-mschapv2.h | 1 -
 src/eap-pwd.c      | 1 -
 src/ie.c           | 1 -
 3 files changed, 3 deletions(-)

diff --git a/src/eap-mschapv2.h b/src/eap-mschapv2.h
index 6b090969..d1f4fd53 100644
--- a/src/eap-mschapv2.h
+++ b/src/eap-mschapv2.h
@@ -28,7 +28,6 @@
 #include <stdint.h>
 #include <stdbool.h>
 =

-
 bool mschapv2_get_asymmetric_start_key(const uint8_t master_key[static 16],
 				uint8_t *session_key, size_t session_len,
 				bool server, bool send);
diff --git a/src/eap-pwd.c b/src/eap-pwd.c
index 74d0997f..a77f21b9 100644
--- a/src/eap-pwd.c
+++ b/src/eap-pwd.c
@@ -435,7 +435,6 @@ error:
 	eap_method_error(eap);
 }
 =

-
 static void eap_pwd_handle_confirm(struct eap_state *eap,
 					const uint8_t *pkt, size_t len)
 {
diff --git a/src/ie.c b/src/ie.c
index 9b1127ce..f120c89e 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -2406,7 +2406,6 @@ int ie_parse_neighbor_report(struct ie_tlv_iter *iter,
 	return 0;
 }
 =

-
 int ie_parse_roaming_consortium(struct ie_tlv_iter *iter, size_t *num_anqp=
_out,
 				const uint8_t **oi1_out, size_t *oi1_len_out,
 				const uint8_t **oi2_out, size_t *oi2_len_out,
-- =

2.20.1

--===============1832381759317346538==--

