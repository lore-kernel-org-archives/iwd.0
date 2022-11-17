Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67502FAF
	for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 13:56:26 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id a14so3996920wru.5
        for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 05:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTwiBLJ3P7Kgl3k56usPrldnCs5dP9tAFKPaLaOL6/Q=;
        b=ObBr0o4azaRZbZ9+FUDFiYrPNzE93bazokILBEUxy44Z9GyfKMcrsAbX7/KcebGKaj
         Bv6adTVBKbCLAw11TxbsrpWtjw41TGM876DJaRc4E3hk2Tua/OsUOf0/LlqMjMOeyBK9
         u0G7WipT8h0D48cij6Z8nYwz6EaHdbfIeNo8ePM/bfp3TvsGzosnbATL83AZly9ZKVTx
         gCujE3T2Q05mHgXHgPoYLNGtDozGvr6QE7nlIkyaXgY2Ne+gkQ5WoHN8WlYDXJioqiaf
         fD9EmjuBWaLgj9wx+shIbMgcSL4vvioNx/LrSpzjRNOggtGiVW6ZQlu4nbI3utGQuQ3K
         LdBw==
X-Gm-Message-State: ANoB5pkDR3F8ORP1rbVNI6g2wVGJfrjb9BhKpOYrLTdegG2LU785dVXG
	K3QD/2cy/tNRN2k1nYCSppz9p7UjRlg=
X-Google-Smtp-Source: AA0mqf5N6P7hhUfop+gN+7Ht9/kp036w3RcvWrKIx0CLG9CEV5+3fMB6w5YPF/FoANsxRKZfF7IZfg==
X-Received: by 2002:a5d:5957:0:b0:22e:3e9:ba15 with SMTP id e23-20020a5d5957000000b0022e03e9ba15mr1490146wri.180.1668693384352;
        Thu, 17 Nov 2022 05:56:24 -0800 (PST)
Received: from localhost.localdomain ([82.213.230.158])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d6885000000b002366b17ca8bsm1142632wru.108.2022.11.17.05.56.23
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 05:56:23 -0800 (PST)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 3/3] station, eapol: Set up eap-tls-common for session caching
Date: Thu, 17 Nov 2022 14:56:10 +0100
Message-Id: <20221117135610.1162965-3-andrew.zaborowski@intel.com>
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

Use eap_set_peer_id() to set a string identifying the TLS server,
currently the hex-encoded SSID of the network, to be used as group name
and primary key in the session cache l_settings object.  Provide pointers
to storage_eap_tls_cache_{load,sync} to eap-tls-common.c using
eap_tls_set_session_cache_ops().  Listen to Known Network removed
signals and call eap_tls_forget_peer() to have any session related to
the network also dropped from the cache.
---
 src/eapol.c   |  6 ++++++
 src/station.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/src/eapol.c b/src/eapol.c
index 4a1abd28..4d4e201d 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -2770,6 +2770,8 @@ void eapol_register(struct eapol_sm *sm)
 bool eapol_start(struct eapol_sm *sm)
 {
 	if (sm->handshake->settings_8021x) {
+		_auto_(l_free) char *network_id = NULL;
+
 		sm->eap = eap_new(eapol_eap_msg_cb, eapol_eap_complete_cb, sm);
 
 		if (!sm->eap)
@@ -2785,6 +2787,10 @@ bool eapol_start(struct eapol_sm *sm)
 
 		eap_set_key_material_func(sm->eap, eapol_eap_results_cb);
 		eap_set_event_func(sm->eap, eapol_eap_event_cb);
+
+		network_id = l_util_hexstring(sm->handshake->ssid,
+						sm->handshake->ssid_len);
+		eap_set_peer_id(sm->eap, network_id);
 	}
 
 	sm->started = true;
diff --git a/src/station.c b/src/station.c
index eab16eff..4aab7828 100644
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
@@ -69,6 +72,7 @@ static bool anqp_disabled;
 static bool supports_arp_evict_nocarrier;
 static bool supports_ndisc_evict_nocarrier;
 static struct watchlist event_watches;
+static uint32_t known_networks_watch;
 
 struct station {
 	enum station_state state;
@@ -5087,6 +5091,22 @@ static void station_netdev_watch(struct netdev *netdev,
 	}
 }
 
+static void station_known_networks_changed(enum known_networks_event event,
+						const struct network_info *info,
+						void *user_data)
+{
+	_auto_(l_free) char *network_id = NULL;
+
+	if (event != KNOWN_NETWORKS_EVENT_REMOVED)
+		return;
+
+	if (info->type != SECURITY_8021X)
+		return;
+
+	network_id = l_util_hexstring(info->ssid, strlen(info->ssid));
+	eap_tls_forget_peer(network_id);
+}
+
 static int station_init(void)
 {
 	station_list = l_queue_new();
@@ -5139,6 +5159,12 @@ static int station_init(void)
 
 	watchlist_init(&event_watches, NULL);
 
+	eap_tls_set_session_cache_ops(storage_eap_tls_cache_load,
+					storage_eap_tls_cache_sync);
+	known_networks_watch = known_networks_watch_add(
+						station_known_networks_changed,
+						NULL, NULL);
+
 	return 0;
 }
 
@@ -5154,6 +5180,8 @@ static void station_exit(void)
 	l_queue_destroy(station_list, NULL);
 	station_list = NULL;
 	watchlist_destroy(&event_watches);
+	known_networks_watch_remove(known_networks_watch);
+	known_networks_watch = 0;
 }
 
 IWD_MODULE(station, station_init, station_exit)
-- 
2.34.1

