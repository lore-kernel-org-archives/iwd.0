Content-Type: multipart/mixed; boundary="===============6406697474763522018=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 03/12] handshake: add flags/key_index for extended key IDs
Date: Mon, 04 Oct 2021 09:48:53 -0700
Message-ID: <20211004164902.2274318-3-prestwoj@gmail.com>
In-Reply-To: 20211004164902.2274318-1-prestwoj@gmail.com

--===============6406697474763522018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ext_key_id_capable indicates the handshake has set the capability bit
in the RSN info. This will only be set if the AP also has the capability
set.

use_ext_key_id indicates if extended key ID procedure should be used.
This is required because an AP may not send the KDE (even with capabilities
set) meaning we fall back to the legacy zero key index.

ptk_index is the key index the AP chose for a given rekey.
---
 src/handshake.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/handshake.h b/src/handshake.h
index 36ccc3a2..e67e2c20 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -128,6 +128,7 @@ struct handshake_state {
 	bool support_fils : 1;
 	bool authenticator_ocvc : 1;
 	bool supplicant_ocvc : 1;
+	bool ext_key_id_capable : 1;
 	uint8_t ssid[32];
 	size_t ssid_len;
 	char *passphrase;
@@ -138,6 +139,8 @@ struct handshake_state {
 	uint8_t gtk_rsc[6];
 	uint8_t proto_version : 2;
 	unsigned int gtk_index;
+	bool use_ext_key_id : 1;
+	uint8_t ptk_index;
 	struct erp_cache_entry *erp_cache;
 	bool support_ip_allocation : 1;
 	uint32_t client_ip_addr;
-- =

2.31.1

--===============6406697474763522018==--

