Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED7CEC0E
	for <iwd@lists.linux.dev>; Wed,  9 Nov 2022 17:04:57 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id z14so26728863wrn.7
        for <iwd@lists.linux.dev>; Wed, 09 Nov 2022 09:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjzn+1ATLEgp+mij1r18mL3bs8idol2w0+vDVeprfZ8=;
        b=HIvcB1ZRglQcwsCy4KtySU4D/nXjng2dbLhAI54jHdD6aAnyuKbIpfK8OA0/KGgRUr
         6DUEn5aUNXAfNrOIyCXrbwuBW8aINqfu7x6tG/DL+Td0JgKO5ZYj27CVjcgmijWR0MFg
         rlu4WQoY0fXthoLh02eJsUl+zEyCQnkKiTIqPGIZlUoVq/SDesK18m/nBVP1ra52MpwY
         DFputIvEXlPRbvVZIEKA2S/SKO+GAzTThr13tivHfQdmqCM0QT/lua4GVj7mEy5vcbJ/
         AeguxsZB6sZqZ842qgTJY2atdfQkScJbTVJlRMj6QUWsAHqmv6QhcO5+M7iIed4tsngN
         lWnw==
X-Gm-Message-State: ACrzQf0muHdNejK4PpOnouSFPWGD7yZ1J6FJ43UeTX9HPCR//dx5kThW
	iWO2zJTtalKR/SaT34uVGErzbSdc8MY=
X-Google-Smtp-Source: AMsMyM7R+TdLx5uAcImeHLYm4m6OyFC9ZFShAM1IrROopYKiqwrFFwnCdJZXiB3cr7raC7N7DTArHQ==
X-Received: by 2002:adf:e804:0:b0:236:657e:756e with SMTP id o4-20020adfe804000000b00236657e756emr39797796wrm.452.1668013494840;
        Wed, 09 Nov 2022 09:04:54 -0800 (PST)
Received: from localhost.localdomain ([82.213.230.158])
        by smtp.gmail.com with ESMTPSA id z19-20020a7bc7d3000000b003c6deb5c1edsm2089909wmk.45.2022.11.09.09.04.53
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:04:54 -0800 (PST)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 2/2] eap-tls: Add session caching
Date: Wed,  9 Nov 2022 18:04:38 +0100
Message-Id: <20221109170438.535300-2-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109170438.535300-1-andrew.zaborowski@intel.com>
References: <20221109170438.535300-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use l_tls_set_session_cache() to enable session cache/resume in the
TLS-based EAP methods.  Sessions for all 802.1x networks are stored in
one file, /var/lib/iwd/.tls-session-cache, indexed by the EAP method
name and authenticator's MAC/BSSID (handshake->aa) because that's
ultimately what identifies the authenticator which will usually be the
TLS server as also.  We may want to add the SSID to the index.  Multiple
BSSes and even multiple ESSes (SSIDs) may be backed by a single
authentication server but it's hard for us to know that.

eap_{get,set}_peer_id() API is added for eapol to set the identifier of
the authenticator (or the supplicant if we're the authenticator, if
there's ever a use case for that).

eap-tls-common.c can't call storage_tls_session_cache_{load,sync}()
directly because it's linked into ead and some unit tests without
storage.c, so station.c sets pointers to the load & sync functions using
the new eap_tls_set_session_cache_ops().
---
 src/eap-tls-common.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
 src/eap-tls-common.h |  6 +++++
 src/eap.c            | 13 +++++++++++
 src/eap.h            |  3 +++
 src/eapol.c          |  4 ++++
 src/station.c        |  6 +++++
 6 files changed, 84 insertions(+)

diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index acc5b387..232163af 100644
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
@@ -571,9 +577,15 @@ static int eap_tls_handle_fragmented_request(struct eap_state *eap,
 	return r;
 }
 
+static void eap_tls_session_cache_update(void *user_data)
+{
+	eap_tls_session_cache_sync(eap_tls_session_cache);
+}
+
 static bool eap_tls_tunnel_init(struct eap_state *eap)
 {
 	struct eap_tls_state *eap_tls = eap_get_data(eap);
+	_auto_(l_free) char *cache_group_name = NULL;
 
 	if (eap_tls->tunnel)
 		goto start;
@@ -633,6 +645,26 @@ static bool eap_tls_tunnel_init(struct eap_state *eap)
 	if (eap_tls->domain_mask)
 		l_tls_set_domain_mask(eap_tls->tunnel, eap_tls->domain_mask);
 
+	if (!eap_tls_session_cache_load)
+		goto start;
+
+	if (!eap_tls_session_cache) {
+		eap_tls_session_cache = eap_tls_session_cache_load();
+
+		if (!eap_tls_session_cache) {
+			eap_tls_session_cache = l_settings_new();
+			l_debug("No session cache loaded, starting with an "
+				"empty cache");
+		}
+	}
+
+	cache_group_name = l_strdup_printf("EAP-%s-%s",
+						eap_get_method_name(eap),
+						eap_get_peer_id(eap));
+	l_tls_set_session_cache(eap_tls->tunnel, eap_tls_session_cache,
+				cache_group_name, 24 * 3600 * L_USEC_PER_SEC, 0,
+				eap_tls_session_cache_update, NULL);
+
 start:
 	if (!l_tls_start(eap_tls->tunnel)) {
 		l_error("%s: Failed to start the TLS client",
@@ -1085,3 +1117,23 @@ void eap_tls_common_tunnel_close(struct eap_state *eap)
 
 	l_tls_close(eap_tls->tunnel);
 }
+
+void eap_tls_set_session_cache_ops(eap_tls_session_cache_load_func_t load,
+				eap_tls_session_cache_sync_func_t sync)
+{
+	eap_tls_session_cache_load = load;
+	eap_tls_session_cache_sync = sync;
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
index 174770c0..748c8d15 100644
--- a/src/eap-tls-common.h
+++ b/src/eap-tls-common.h
@@ -20,6 +20,9 @@
  *
  */
 
+typedef struct l_settings *(*eap_tls_session_cache_load_func_t)(void);
+typedef void (*eap_tls_session_cache_sync_func_t)(struct l_settings *);
+
 enum eap_tls_version {
 	EAP_TLS_VERSION_0               = 0x00,
 	EAP_TLS_VERSION_1               = 0x01,
@@ -81,3 +84,6 @@ bool eap_tls_common_tunnel_prf_get_bytes(struct eap_state *eap,
 void eap_tls_common_tunnel_send(struct eap_state *eap, const uint8_t *data,
 							size_t data_len);
 void eap_tls_common_tunnel_close(struct eap_state *eap);
+
+void eap_tls_set_session_cache_ops(eap_tls_session_cache_load_func_t load,
+				eap_tls_session_cache_sync_func_t sync);
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
diff --git a/src/eapol.c b/src/eapol.c
index 4a1abd28..8e599394 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -2770,6 +2770,9 @@ void eapol_register(struct eapol_sm *sm)
 bool eapol_start(struct eapol_sm *sm)
 {
 	if (sm->handshake->settings_8021x) {
+		const uint8_t *addr = sm->handshake->authenticator ?
+			sm->handshake->spa : sm->handshake->aa;
+
 		sm->eap = eap_new(eapol_eap_msg_cb, eapol_eap_complete_cb, sm);
 
 		if (!sm->eap)
@@ -2785,6 +2788,7 @@ bool eapol_start(struct eapol_sm *sm)
 
 		eap_set_key_material_func(sm->eap, eapol_eap_results_cb);
 		eap_set_event_func(sm->eap, eapol_eap_event_cb);
+		eap_set_peer_id(sm->eap, util_address_to_string(addr));
 	}
 
 	sm->started = true;
diff --git a/src/station.c b/src/station.c
index eab16eff..08d62870 100644
--- a/src/station.c
+++ b/src/station.c
@@ -60,6 +60,9 @@
 #include "src/sysfs.h"
 #include "src/band.h"
 #include "src/ft.h"
+#include "src/eap.h"
+#include "src/eap-tls-common.h"
+#include "src/storage.h"
 
 static struct l_queue *station_list;
 static uint32_t netdev_watch;
@@ -5139,6 +5142,9 @@ static int station_init(void)
 
 	watchlist_init(&event_watches, NULL);
 
+	eap_tls_set_session_cache_ops(storage_tls_session_cache_load,
+					storage_tls_session_cache_sync);
+
 	return 0;
 }
 
-- 
2.34.1

