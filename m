Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BAB322E
	for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 13:56:25 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id bs21so3968702wrb.4
        for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 05:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fT0BBDMItAM4rvenq+WBmMAoq/PI0H/P9JS64FW5VJ4=;
        b=dFHZXHzN1ZGw9f5x7IwlhoQlWQqzV3bn/Fr7snu5Z+XzrpTi7rsL2Ul5RA0hWWcP8h
         N79wn9ChXJMrT+KftIDTethWD+p124FOB1Q9sAPMJfYu/9inSoHySFu1h0FlEvJpezbw
         3Xkr1LH/YfzpY5jTeE2FInpnLoRBd4lfUy6FcuR1KBTmCoXZy8GY0GWwSCJoTL543mbs
         z3LQGBGWBU4E4q4xjg5fnRHQT+1ejYVQp/RkJvNNUtWsDmGUYQb39lE3Y/ESsXc9C3Yz
         DIz0/RzNnqyDBiw2Ubn9C/McaUuMCGWn93v7M7mOOMdSpYDPoCn+aSalZDatCFvr1tTy
         /GuQ==
X-Gm-Message-State: ANoB5pnUu1IkTT5Sfhy3c5a6NMjrDkXEIijx4AFx1K5HozhUQ7q5QZE5
	U8FzDAg6OxmAb5J2qfqC7hSAJtSCR58=
X-Google-Smtp-Source: AA0mqf50WJckTk4W+KMZxadQlikv72Tl33wW1gXm4wCwh/m5T+AZAXzn8E7BiZ64uTC5AjC2FhkPEA==
X-Received: by 2002:a5d:6088:0:b0:22e:5149:441d with SMTP id w8-20020a5d6088000000b0022e5149441dmr1540310wrt.661.1668693382934;
        Thu, 17 Nov 2022 05:56:22 -0800 (PST)
Received: from localhost.localdomain ([82.213.230.158])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d6885000000b002366b17ca8bsm1142632wru.108.2022.11.17.05.56.21
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 05:56:21 -0800 (PST)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 2/3] eap-tls: Add session caching
Date: Thu, 17 Nov 2022 14:56:09 +0100
Message-Id: <20221117135610.1162965-2-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117135610.1162965-1-andrew.zaborowski@intel.com>
References: <20221117135610.1162965-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use l_tls_set_session_cache() to enable session cache/resume in the
TLS-based EAP methods.  Sessions for all 802.1x networks are stored in
one l_settings object.

eap_{get,set}_peer_id() API is added for the upper layers to set the
identifier of the authenticator (or the supplicant if we're the
authenticator, if there's ever a use case for that.)

eap-tls-common.c can't call storage_eap_tls_cache_{load,sync}()
or known_networks_watch_add() (to handle known network removals) because
it's linked into some executables that don't have storage.o,
knownnetworks.o or common.o so an upper layer (station.c) will call
eap_tls_set_session_cache_ops() and eap_tls_forget_peer() as needed.
---
 src/eap-tls-common.c | 58 ++++++++++++++++++++++++++++++++++++++++++++
 src/eap-tls-common.h |  7 ++++++
 src/eap.c            | 13 ++++++++++
 src/eap.h            |  3 +++
 4 files changed, 81 insertions(+)

diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index acc5b387..9a4450e9 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -28,7 +28,9 @@
 #include <errno.h>
 #include <ell/ell.h>
 
+#include "ell/useful.h"
 #include "src/missing.h"
+#include "src/module.h"
 #include "src/eap.h"
 #include "src/eap-private.h"
 #include "src/eap-tls-common.h"
@@ -123,6 +125,10 @@ struct eap_tls_state {
 	void *variant_data;
 };
 
+static struct l_settings *eap_tls_session_cache;
+static eap_tls_session_cache_load_func_t eap_tls_session_cache_load;
+static eap_tls_session_cache_sync_func_t eap_tls_session_cache_sync;
+
 static void __eap_tls_common_state_reset(struct eap_tls_state *eap_tls)
 {
 	eap_tls->version_negotiated = EAP_TLS_VERSION_NOT_NEGOTIATED;
@@ -571,6 +577,15 @@ static int eap_tls_handle_fragmented_request(struct eap_state *eap,
 	return r;
 }
 
+static void eap_tls_session_cache_update(void *user_data)
+{
+	if (L_WARN_ON(!eap_tls_session_cache_sync) ||
+			L_WARN_ON(!eap_tls_session_cache))
+		return;
+
+	eap_tls_session_cache_sync(eap_tls_session_cache);
+}
+
 static bool eap_tls_tunnel_init(struct eap_state *eap)
 {
 	struct eap_tls_state *eap_tls = eap_get_data(eap);
@@ -633,6 +648,17 @@ static bool eap_tls_tunnel_init(struct eap_state *eap)
 	if (eap_tls->domain_mask)
 		l_tls_set_domain_mask(eap_tls->tunnel, eap_tls->domain_mask);
 
+	if (!eap_tls_session_cache_load)
+		goto start;
+
+	if (!eap_tls_session_cache)
+		eap_tls_session_cache = eap_tls_session_cache_load();
+
+	l_tls_set_session_cache(eap_tls->tunnel, eap_tls_session_cache,
+				eap_get_peer_id(eap),
+				24 * 3600 * L_USEC_PER_SEC, 0,
+				eap_tls_session_cache_update, NULL);
+
 start:
 	if (!l_tls_start(eap_tls->tunnel)) {
 		l_error("%s: Failed to start the TLS client",
@@ -1085,3 +1111,35 @@ void eap_tls_common_tunnel_close(struct eap_state *eap)
 
 	l_tls_close(eap_tls->tunnel);
 }
+
+void eap_tls_set_session_cache_ops(eap_tls_session_cache_load_func_t load,
+					eap_tls_session_cache_sync_func_t sync)
+{
+	eap_tls_session_cache_load = load;
+	eap_tls_session_cache_sync = sync;
+}
+
+void eap_tls_forget_peer(const char *peer_id)
+{
+	if (L_WARN_ON(!eap_tls_session_cache_sync))
+		return;
+
+	if (!eap_tls_session_cache)
+		eap_tls_session_cache = eap_tls_session_cache_load();
+
+	if (l_settings_remove_group(eap_tls_session_cache, peer_id))
+		eap_tls_session_cache_sync(eap_tls_session_cache);
+}
+
+static int eap_tls_common_init(void)
+{
+	return 0;
+}
+
+static void eap_tls_common_exit(void)
+{
+	l_settings_free(eap_tls_session_cache);
+	eap_tls_session_cache = NULL;
+}
+
+IWD_MODULE(eap_tls_common, eap_tls_common_init, eap_tls_common_exit);
diff --git a/src/eap-tls-common.h b/src/eap-tls-common.h
index 174770c0..25f668e2 100644
--- a/src/eap-tls-common.h
+++ b/src/eap-tls-common.h
@@ -20,6 +20,9 @@
  *
  */
 
+typedef struct l_settings *(*eap_tls_session_cache_load_func_t)(void);
+typedef void (*eap_tls_session_cache_sync_func_t)(const struct l_settings *);
+
 enum eap_tls_version {
 	EAP_TLS_VERSION_0               = 0x00,
 	EAP_TLS_VERSION_1               = 0x01,
@@ -81,3 +84,7 @@ bool eap_tls_common_tunnel_prf_get_bytes(struct eap_state *eap,
 void eap_tls_common_tunnel_send(struct eap_state *eap, const uint8_t *data,
 							size_t data_len);
 void eap_tls_common_tunnel_close(struct eap_state *eap);
+
+void eap_tls_set_session_cache_ops(eap_tls_session_cache_load_func_t load,
+					eap_tls_session_cache_sync_func_t sync);
+void eap_tls_forget_peer(const char *peer_id);
diff --git a/src/eap.c b/src/eap.c
index 6f523f2f..981b6388 100644
--- a/src/eap.c
+++ b/src/eap.c
@@ -59,6 +59,7 @@ struct eap_state {
 	char *identity;
 	char *identity_setting;
 	bool authenticator;
+	char *peer_id;
 
 	int last_id;
 	void *method_state;
@@ -154,6 +155,7 @@ void eap_free(struct eap_state *eap)
 
 	eap_free_common(eap);
 	l_timeout_remove(eap->complete_timeout);
+	eap_set_peer_id(eap, NULL);
 
 	l_free(eap);
 }
@@ -837,6 +839,17 @@ err:
 	return false;
 }
 
+void eap_set_peer_id(struct eap_state *eap, const char *id)
+{
+	l_free(eap->peer_id);
+	eap->peer_id = l_strdup(id);
+}
+
+const char *eap_get_peer_id(struct eap_state *eap)
+{
+	return eap->peer_id;
+}
+
 void eap_set_data(struct eap_state *eap, void *data)
 {
 	eap->method_state = data;
diff --git a/src/eap.h b/src/eap.h
index f1e867f5..702caf24 100644
--- a/src/eap.h
+++ b/src/eap.h
@@ -94,6 +94,9 @@ const char *eap_get_identity(struct eap_state *eap);
 
 void eap_rx_packet(struct eap_state *eap, const uint8_t *pkt, size_t len);
 
+void eap_set_peer_id(struct eap_state *eap, const char *id);
+const char *eap_get_peer_id(struct eap_state *eap);
+
 void __eap_set_config(struct l_settings *config);
 
 int eap_init(void);
-- 
2.34.1

