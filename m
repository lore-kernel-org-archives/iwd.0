Content-Type: multipart/mixed; boundary="===============1150339861488324755=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 02/13] handshake: add flags/key index for extended key IDs
Date: Thu, 07 Oct 2021 13:49:46 -0700
Message-ID: <20211007204957.3745985-2-prestwoj@gmail.com>
In-Reply-To: 20211007204957.3745985-1-prestwoj@gmail.com

--===============1150339861488324755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ext_key_id_capable indicates the handshake has set the capability bit
in the RSN info. This will only be set if the AP also has the capability
set.

active_tk_index is the key index the AP chose in message 3. This is
now used for both legacy (always zero) and extended key IDs.
---
 src/handshake.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/handshake.h b/src/handshake.h
index 36ccc3a2..d57a3794 100644
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
@@ -138,6 +139,7 @@ struct handshake_state {
 	uint8_t gtk_rsc[6];
 	uint8_t proto_version : 2;
 	unsigned int gtk_index;
+	uint8_t active_tk_index;
 	struct erp_cache_entry *erp_cache;
 	bool support_ip_allocation : 1;
 	uint32_t client_ip_addr;
-- =

2.31.1

--===============1150339861488324755==--

