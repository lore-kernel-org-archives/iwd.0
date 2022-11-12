Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E42F7E
	for <iwd@lists.linux.dev>; Sat, 12 Nov 2022 01:19:45 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso4081868wms.4
        for <iwd@lists.linux.dev>; Fri, 11 Nov 2022 17:19:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KhdoMmNszTCcVaPuaWbUtzJwutIP3uNGVizKACpHes=;
        b=H5FD0DLadNkJ62+V+2kfK1ZqsfN61yIt8JnNG8dvYikXdXq/D0E/Jotz8mkzTfgTDv
         m4kErbkEP9nbCT8jaF/1fh5tf8SiVZWy81M2nHGvbenlr5NdBUrkrwcl8sHXL5UgJOL4
         zOc8RvVlYfTIPhm6z3jM4MRmCA9P5GClba2mZWcmxUwkrMm1ARxyFCLqMpVKFfCHv/tg
         66LXl0wX7EGFofl0aJpOHaJCDgKL0ZZ21jdKGfvjp4VFS6qb6tiRJZpt5Av5NecD8y8R
         but3EPWCvM3zT4gBH6t+62IT+WKHrTAq13IXukbunAQzd/T9G1Sv6qLjLNEgHqmDLNqo
         fcLQ==
X-Gm-Message-State: ANoB5pkBkcpFzH/Jm06dF2mp53ICkur9VYoGcl8sq+EAqONSPWKW3+H8
	sxLaap4aby92/IH8r7jVfsEihTYybxE=
X-Google-Smtp-Source: AA0mqf40w37FVOWmx90gqMQGLYTXQgM6sdV2BOkTqDhXvODb1xwzkvLFRMS3M5nJ2WyTFo1leRvJJQ==
X-Received: by 2002:a05:600c:228c:b0:3b4:ff86:25af with SMTP id 12-20020a05600c228c00b003b4ff8625afmr2663745wmf.68.1668215982762;
        Fri, 11 Nov 2022 17:19:42 -0800 (PST)
Received: from localhost.localdomain ([82.213.230.158])
        by smtp.gmail.com with ESMTPSA id bi14-20020a05600c3d8e00b003b95ed78275sm4437734wmb.20.2022.11.11.17.19.41
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 17:19:41 -0800 (PST)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 3/3] eap-tls: Add session caching
Date: Sat, 12 Nov 2022 02:19:29 +0100
Message-Id: <20221112011929.785388-3-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221112011929.785388-1-andrew.zaborowski@intel.com>
References: <20221112011929.785388-1-andrew.zaborowski@intel.com>
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

eap_{get,set}_peer_id() API is added for eapol to set the identifier of
the authenticator (or the supplicant if we're the authenticator, if
there's ever a use case for that.)  In this case that's the network's
SSID for simplicity encoded using storage_get_network_file_path.
Unfortunately this makes eapol.o depend on storage.o + common.o hence
those files are added to two unit tests that weren't linking storage.o
until now.

eap-tls-common.c can't call storage_tls_session_cache_{get,sync}()
directly because it's linked into ead and some other unit tests without
storage.o, so station.c sets pointers to the get & sync functions using
the new eap_tls_set_session_cache_ops().
---
 Makefile.am          |  9 ++++++---
 src/eap-tls-common.c | 28 ++++++++++++++++++++++++++++
 src/eap-tls-common.h |  6 ++++++
 src/eap.c            | 13 +++++++++++++
 src/eap.h            |  3 +++
 src/eapol.c          | 11 +++++++++++
 src/station.c        |  6 ++++++
 7 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index d5f31a2d..b9632772 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -427,7 +427,6 @@ unit_test_eap_sim_SOURCES = unit/test-eap-sim.c \
 		src/crypto.h src/crypto.c src/simutil.h src/simutil.c \
 		src/ie.h src/ie.c \
 		src/watchlist.h src/watchlist.c \
-		src/eapol.h src/eapol.c \
 		src/eapolutil.h src/eapolutil.c \
 		src/handshake.h src/handshake.c \
 		src/eap.h src/eap.c src/eap-private.h \
@@ -497,7 +496,9 @@ unit_test_eapol_SOURCES = unit/test-eapol.c \
 				src/eap-tls-common.h src/eap-tls-common.c \
 				src/erp.h src/erp.c \
 				src/band.h src/band.c \
-				src/mschaputil.h src/mschaputil.c
+				src/mschaputil.h src/mschaputil.c \
+				src/common.h src/common.c \
+				src/storage.h src/storage.c
 unit_test_eapol_LDADD = $(ell_ldadd)
 unit_test_eapol_DEPENDENCIES = $(ell_dependencies) \
 				unit/cert-server.pem \
@@ -525,7 +526,9 @@ unit_test_wsc_SOURCES = unit/test-wsc.c src/wscutil.h src/wscutil.c \
 				src/util.h src/util.c \
 				src/erp.h src/erp.c \
 				src/band.h src/band.c \
-				src/eap-wsc.h src/eap-wsc.c
+				src/eap-wsc.h src/eap-wsc.c \
+				src/common.h src/common.c \
+				src/storage.h src/storage.c
 unit_test_wsc_LDADD = $(ell_ldadd)
 
 unit_test_eap_mschapv2_SOURCES = src/eap-mschapv2.h src/eap-mschapv2.c \
diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index acc5b387..90198d6c 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -28,6 +28,7 @@
 #include <errno.h>
 #include <ell/ell.h>
 
+#include "ell/useful.h"
 #include "src/missing.h"
 #include "src/eap.h"
 #include "src/eap-private.h"
@@ -123,6 +124,9 @@ struct eap_tls_state {
 	void *variant_data;
 };
 
+static eap_tls_session_cache_get_func_t eap_tls_session_cache_get;
+static eap_tls_session_cache_sync_func_t eap_tls_session_cache_sync;
+
 static void __eap_tls_common_state_reset(struct eap_tls_state *eap_tls)
 {
 	eap_tls->version_negotiated = EAP_TLS_VERSION_NOT_NEGOTIATED;
@@ -571,9 +575,18 @@ static int eap_tls_handle_fragmented_request(struct eap_state *eap,
 	return r;
 }
 
+static void eap_tls_session_cache_update(void *user_data)
+{
+	if (L_WARN_ON(!eap_tls_session_cache_sync))
+		return;
+
+	eap_tls_session_cache_sync();
+}
+
 static bool eap_tls_tunnel_init(struct eap_state *eap)
 {
 	struct eap_tls_state *eap_tls = eap_get_data(eap);
+	_auto_(l_free) char *cache_group_name = NULL;
 
 	if (eap_tls->tunnel)
 		goto start;
@@ -633,6 +646,14 @@ static bool eap_tls_tunnel_init(struct eap_state *eap)
 	if (eap_tls->domain_mask)
 		l_tls_set_domain_mask(eap_tls->tunnel, eap_tls->domain_mask);
 
+	if (!eap_tls_session_cache_get)
+		goto start;
+
+	cache_group_name = l_strdup_printf("EAP-%s", eap_get_peer_id(eap));
+	l_tls_set_session_cache(eap_tls->tunnel, eap_tls_session_cache_get(),
+				cache_group_name, 24 * 3600 * L_USEC_PER_SEC, 0,
+				eap_tls_session_cache_update, NULL);
+
 start:
 	if (!l_tls_start(eap_tls->tunnel)) {
 		l_error("%s: Failed to start the TLS client",
@@ -1085,3 +1106,10 @@ void eap_tls_common_tunnel_close(struct eap_state *eap)
 
 	l_tls_close(eap_tls->tunnel);
 }
+
+void eap_tls_set_session_cache_ops(eap_tls_session_cache_get_func_t get,
+					eap_tls_session_cache_sync_func_t sync)
+{
+	eap_tls_session_cache_get = get;
+	eap_tls_session_cache_sync = sync;
+}
diff --git a/src/eap-tls-common.h b/src/eap-tls-common.h
index 174770c0..6c39ff3d 100644
--- a/src/eap-tls-common.h
+++ b/src/eap-tls-common.h
@@ -20,6 +20,9 @@
  *
  */
 
+typedef struct l_settings *(*eap_tls_session_cache_get_func_t)(void);
+typedef void (*eap_tls_session_cache_sync_func_t)(void);
+
 enum eap_tls_version {
 	EAP_TLS_VERSION_0               = 0x00,
 	EAP_TLS_VERSION_1               = 0x01,
@@ -81,3 +84,6 @@ bool eap_tls_common_tunnel_prf_get_bytes(struct eap_state *eap,
 void eap_tls_common_tunnel_send(struct eap_state *eap, const uint8_t *data,
 							size_t data_len);
 void eap_tls_common_tunnel_close(struct eap_state *eap);
+
+void eap_tls_set_session_cache_ops(eap_tls_session_cache_get_func_t get,
+					eap_tls_session_cache_sync_func_t sync);
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
index 4a1abd28..54ce253b 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -44,6 +44,8 @@
 #include "src/erp.h"
 #include "src/iwd.h"
 #include "src/band.h"
+#include "src/common.h"
+#include "src/storage.h"
 
 static struct l_queue *state_machines;
 static struct l_queue *preauths;
@@ -2770,6 +2772,9 @@ void eapol_register(struct eapol_sm *sm)
 bool eapol_start(struct eapol_sm *sm)
 {
 	if (sm->handshake->settings_8021x) {
+		char ssid[sm->handshake->ssid_len + 1];
+		_auto_(l_free) char *network_id = NULL;
+
 		sm->eap = eap_new(eapol_eap_msg_cb, eapol_eap_complete_cb, sm);
 
 		if (!sm->eap)
@@ -2785,6 +2790,12 @@ bool eapol_start(struct eapol_sm *sm)
 
 		eap_set_key_material_func(sm->eap, eapol_eap_results_cb);
 		eap_set_event_func(sm->eap, eapol_eap_event_cb);
+
+		memcpy(ssid, sm->handshake->ssid, sm->handshake->ssid_len);
+		ssid[sm->handshake->ssid_len] = 0;
+		network_id =
+			storage_get_network_file_path(SECURITY_8021X, ssid);
+		eap_set_peer_id(sm->eap, network_id);
 	}
 
 	sm->started = true;
diff --git a/src/station.c b/src/station.c
index eab16eff..ebd3831b 100644
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
 
+	eap_tls_set_session_cache_ops(storage_tls_session_cache_get,
+					storage_tls_session_cache_sync);
+
 	return 0;
 }
 
-- 
2.34.1

