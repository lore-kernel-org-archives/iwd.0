Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BA567B73
	for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJSgR/ib"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-425b9acaf80so43676141cf.1
        for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 10:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702576887; x=1703181687; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WpzSlrY5qeXOCQjJdkbcB9WN7UzeI/7Hp5DBbcaUCk=;
        b=NJSgR/ibUfoJ7x3T5wT6NZo9TD/0uDSI5rs+lCjQmVexyxD5i0A+fTHxXPVFLxZzj9
         XI+CeJefL8rvNYJ2H7lMB+CORjXaniOnXohO1AsALaEfYROuMqPfTIKCL6qajAMs+RmP
         srXOQFzG/8gJHq4ZgYTmySd6xqZLcWsIM/HuZdZ8kA/yLDIngXiNP1ONq0erUZLRY3KY
         P1C147SQaEn6ErxVuFSKz9pI3L8T2zPkspmCA8UU8I4i0jevB2u0qpz6SUJLw6dBHImc
         ZLnad8qq6vPh+Cr8Fyuw7A38EvuLxp8HDI1LNbI5EHVcgI8BT1onO5rWQjTRAHBJSd6m
         Q/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702576887; x=1703181687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WpzSlrY5qeXOCQjJdkbcB9WN7UzeI/7Hp5DBbcaUCk=;
        b=mbWGruXevYU3MmEY1UwELO5ucKrmUF5Ws/k11Z4ZmPmSCssbAKlsZzPSofyAjrSq/l
         493+RMH6hxrhAGSWPJC8J0la8c2y3kLT7L4nYXuYp2eFMtG1+5abJKlKnzHRJx1HAVzI
         IKZfiLzfWmIkFKhv2omuFY6PQkc8+rHMClT0YyIbQ0coA2T0lTGknwbC0ewwiUpVni7B
         Iind0aAsdiZHZOvYLxU89Qr1tgDKKZxGwQJLuz4OigTLqO7Kav/4KA9I9ehwLMcsinh0
         5jeKBJoqW4CgPZUXK8qyAwCyH7G2edDvyz/EbiKiTX/YuDHyeyCTeC5tbqrW3tDl4ulS
         PkYA==
X-Gm-Message-State: AOJu0Yy0haquH0MN1IWc8VrljMMbRC3RmTr9oksBMIZ6JRP0vxQJpMDz
	ocVEPXT5O1AkbiTKLhiqmvM02vCvJuo=
X-Google-Smtp-Source: AGHT+IFzC47Trm4tu/YHftVrMOPgq/gcNEcHfHzeRNG8DPEfwLbNSO619eHCJKdgfhNSaCJ7hwNoUA==
X-Received: by 2002:a05:622a:16:b0:425:8663:a06d with SMTP id x22-20020a05622a001600b004258663a06dmr14931087qtw.64.1702576887426;
        Thu, 14 Dec 2023 10:01:27 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id o8-20020ac85548000000b004257bf9a394sm5949511qtr.14.2023.12.14.10.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:01:26 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/5] dpp: fix extra settings not being used when connecting
Date: Thu, 14 Dec 2023 10:01:08 -0800
Message-Id: <20231214180110.130991-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214180110.130991-1-prestwoj@gmail.com>
References: <20231214180110.130991-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After DPP completes all settings are written and synced to disk as
well as credentials set into the network object itself. The way
network/knownnetworks worked at the time did not actually re-load
these settings before the connection attempt was made which means
that extra settings not set into the network object were not used,
i.e. Hidden/Sendhostname. The connection itself always succeeded
because the network object was given the credentials directly via
setters.

Now network and knownnetworks support updating on the directory
watch callback and ADDED/UPDATED known network events. Take advantage
of this and if the network object already exists after DPP (from a
prior scan) wait unil known networks adds/updates the network and
issue the connection after that.
---
 src/dpp.c | 124 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 93 insertions(+), 31 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 1ff4b99e..dca40660 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -53,6 +53,7 @@
 #include "src/network.h"
 #include "src/handshake.h"
 #include "src/nl80211util.h"
+#include "src/knownnetworks.h"
 
 #define DPP_FRAME_MAX_RETRIES 5
 #define DPP_FRAME_RETRY_TIMEOUT 1
@@ -101,6 +102,7 @@ struct dpp_sm {
 	uint8_t role;
 	int refcount;
 	uint32_t station_watch;
+	uint32_t known_network_watch;
 
 	uint64_t wdev_id;
 
@@ -168,6 +170,8 @@ struct dpp_sm {
 
 	struct l_dbus_message *pending;
 
+	struct l_idle *connect_idle;
+
 	/* PKEX-specific values */
 	char *pkex_id;
 	char *pkex_key;
@@ -515,6 +519,11 @@ static void dpp_reset(struct dpp_sm *dpp)
 		dpp->pkex_scan_id = 0;
 	}
 
+	if (dpp->connect_idle) {
+		l_idle_remove(dpp->connect_idle);
+		dpp->connect_idle = NULL;
+	}
+
 	dpp->state = DPP_STATE_NOTHING;
 	dpp->new_freq = 0;
 	dpp->frame_retry = 0;
@@ -570,6 +579,8 @@ static void dpp_free(struct dpp_sm *dpp)
 	if (station)
 		station_remove_state_watch(station, dpp->station_watch);
 
+	known_networks_watch_remove(dpp->known_network_watch);
+
 	l_free(dpp);
 }
 
@@ -812,8 +823,6 @@ static void dpp_write_config(struct dpp_configuration *config,
 {
 	_auto_(l_settings_free) struct l_settings *settings = l_settings_new();
 	_auto_(l_free) char *path;
-	_auto_(l_free) uint8_t *psk = NULL;
-	size_t psk_len;
 
 	path = storage_get_network_file_path(SECURITY_PSK, config->ssid);
 
@@ -822,22 +831,13 @@ static void dpp_write_config(struct dpp_configuration *config,
 		l_settings_remove_group(settings, "Security");
 	}
 
-	if (config->passphrase) {
+	if (config->passphrase)
 		l_settings_set_string(settings, "Security", "Passphrase",
 				config->passphrase);
-		if (network)
-			network_set_passphrase(network, config->passphrase);
-
-	} else if (config->psk) {
+	else if (config->psk)
 		l_settings_set_string(settings, "Security", "PreSharedKey",
 				config->psk);
 
-		psk = l_util_from_hexstring(config->psk, &psk_len);
-
-		if (network)
-			network_set_psk(network, psk);
-	}
-
 	if (config->send_hostname)
 		l_settings_set_bool(settings, "IPv4", "SendHostname", true);
 
@@ -856,14 +856,39 @@ static void dpp_scan_triggered(int err, void *user_data)
 		l_error("Failed to trigger DPP scan");
 }
 
+static void dpp_start_connect(struct l_idle *idle, void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+	struct scan_bss *bss;
+	struct network *network;
+	int ret;
+
+	network = station_network_find(station, dpp->config->ssid,
+					SECURITY_PSK);
+
+	dpp_reset(dpp);
+
+	if (!network) {
+		l_debug("Network was not found!");
+		return;
+	}
+
+	l_debug("connecting to %s from DPP", network_get_ssid(network));
+
+	bss = network_bss_select(network, true);
+	ret = network_autoconnect(network, bss);
+	if (ret < 0)
+		l_warn("failed to connect after DPP (%d) %s", ret,
+			strerror(ret));
+}
+
 static bool dpp_scan_results(int err, struct l_queue *bss_list,
 				const struct scan_freq_set *freqs,
 				void *userdata)
 {
 	struct dpp_sm *dpp = userdata;
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
-	struct scan_bss *bss;
-	struct network *network;
 
 	if (err < 0)
 		goto reset;
@@ -880,18 +905,7 @@ static bool dpp_scan_results(int err, struct l_queue *bss_list,
 
 	station_set_scan_results(station, bss_list, freqs, false);
 
-	network = station_network_find(station, dpp->config->ssid,
-					SECURITY_PSK);
-
-	dpp_reset(dpp);
-
-	if (!network) {
-		l_debug("Network was not found after scanning");
-		return true;
-	}
-
-	bss = network_bss_select(network, true);
-	network_autoconnect(network, bss);
+	dpp_start_connect(NULL, dpp);
 
 	return true;
 
@@ -907,6 +921,51 @@ static void dpp_scan_destroy(void *userdata)
 	dpp_reset(dpp);
 }
 
+static void dpp_known_network_watch(enum known_networks_event event,
+					const struct network_info *info,
+					void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+
+	/*
+	 * Check the following
+	 *  - DPP is enrolling
+	 *  - DPP finished (dpp->config is set)
+	 *  - This is for the network DPP just configured
+	 *  - DPP isn't already trying to connect (e.g. if the profile was
+	 *    immediately modified after DPP synced it).
+	 *  - DPP didn't start a scan for the network.
+	 */
+	if (dpp->role != DPP_CAPABILITY_ENROLLEE)
+		return;
+	if (!dpp->config)
+		return;
+	if (strcmp(info->ssid, dpp->config->ssid))
+		return;
+	if (dpp->connect_idle)
+		return;
+	if (dpp->connect_scan_id)
+		return;
+
+	switch (event) {
+	case KNOWN_NETWORKS_EVENT_ADDED:
+	case KNOWN_NETWORKS_EVENT_UPDATED:
+		/*
+		 * network.c takes care of updating the settings for the
+		 * network. This callback just tells us to begin the connection.
+		 * We do have use an idle here because there is no strict
+		 * guarantee of ordering between known network events, e.g. DPP
+		 * could have been called into prior to network and the network
+		 * object isn't updated yet.
+		 */
+		dpp->connect_idle = l_idle_create(dpp_start_connect, dpp, NULL);
+		break;
+	case KNOWN_NETWORKS_EVENT_REMOVED:
+		l_warn("profile was removed before DPP could connect");
+		break;
+	}
+}
+
 static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 				const void *body, size_t body_len,
 				int rssi, void *user_data)
@@ -1074,10 +1133,11 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 
 	offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
 
-	if (network && bss)
-		__station_connect_network(station, network, bss,
-						STATION_STATE_CONNECTING);
-	else if (station) {
+	if (network && bss) {
+		l_debug("delaying connect until settings are synced");
+		dpp->config = config;
+		return;
+	} else if (station) {
 		struct scan_parameters params = {0};
 
 		params.ssid = (void *) config->ssid;
@@ -3780,6 +3840,8 @@ static void dpp_create(struct netdev *netdev)
 
 	dpp->station_watch = station_add_state_watch(station,
 					dpp_station_state_watch, dpp, NULL);
+	dpp->known_network_watch = known_networks_watch_add(
+					dpp_known_network_watch, dpp, NULL);
 
 	l_queue_push_tail(dpp_list, dpp);
 }
-- 
2.34.1

