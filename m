Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C8A37D0B
	for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHrxczRq"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3ba46a19689so3806701b6e.3
        for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 10:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703009310; x=1703614110; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thvZKJ7fXvOT8jzlQycsItnR9D9ytuucdRNXiGG+QU4=;
        b=VHrxczRqcaCpyQIrqBM1lX2c546ftQAE4ruvDY6JZ5gYV9UGJsuLsgeYHrr3j2miOr
         E4vGAWB9kEBP0X2nTTnrZrR9DLMtKGj0+RR4XFipNZsadHzynYs3G0gbVLvtUuhTPEhC
         WXYVw/UOy+zMFhfxpRX2REh/9gFzUPwjpbEhsnGvbY+U5eApMIkSzxf2u0NYvjLR+tpu
         nv2s6pKGTN8KqVbRnQmLoxDssArcZk7Bn8cr8dQaBs5hNmU+pfK+9EOXLByFh/ZRR0Ta
         4af0usq6sOkU6UcZ/JhIecjQ+wiAW+iS18nTYfd13HeNw+N5b64uiNOK10Zwz4g80la5
         JaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009310; x=1703614110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thvZKJ7fXvOT8jzlQycsItnR9D9ytuucdRNXiGG+QU4=;
        b=NTcWa9rJ2CKZCcyOD69MAmK5pLjcR/8gdiGaqcBCHWqXsw7wyQrZeKNHuOml5Q+LGC
         VZQezZ/0Dzqd6/0qgQjnI4JbEIYRf/REZt4BX+BycqdLDHWKWs3zSsMCS7nN9GuFXIZ/
         1hpN1at8hBs68LgoVYZsgP30R+t6+QnmT/3SoKeVy0AUg7vvuri6fXPcVl2GvITvExSw
         PfzdnWIq46MRcgLBR8iqij/08ROjcHrhAXQ4Ng0ggpPvyskVGglis/eKPBc7HHT803Nd
         cWU0UHZTG4HzoBv6oXg89bjRDfEcXjSL6CCnmNLppYXn2vwZQUuZWckft9dxSCxur8dt
         kwuA==
X-Gm-Message-State: AOJu0Ywf5KHy1WSSpHr0AwrM6kXuLT5WNc0WIisep8rg72MpLUCAUYCY
	9fhLOLGeDMHjzWiOAXilV/wLHkrr7uQ=
X-Google-Smtp-Source: AGHT+IH+nUEsngJ/Eec2pJ1F5Ms2PHj0v0wq/l/nNLU7cuDQqJFa/FQxWk38Bg/mvVDVqCQXnb3k3A==
X-Received: by 2002:a05:6808:209b:b0:3b9:dd70:7666 with SMTP id s27-20020a056808209b00b003b9dd707666mr25200838oiw.45.1703009310159;
        Tue, 19 Dec 2023 10:08:30 -0800 (PST)
Received: from LOCLAP699.barrett-olive-branch.locus ([50.222.209.222])
        by smtp.gmail.com with ESMTPSA id z25-20020a056808049900b003ba322fa9a8sm2095130oid.43.2023.12.19.10.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:08:29 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/4] dpp: fix extra settings not being used when connecting
Date: Tue, 19 Dec 2023 10:08:24 -0800
Message-Id: <20231219180826.201540-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219180826.201540-1-prestwoj@gmail.com>
References: <20231219180826.201540-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before this change DPP was writing the credentials both to disk
and into the network object directly. This allowed the connection
to work fine but additional settings were not picked up due to
network_set_passphrase/psk loading the settings before they were
written.

Instead DPP can avoid setting the credentials to the network
object entirely and just write them to disk. Then, wait for
known networks to notify that the profile was either created
or updated then DPP can proceed to connecting. network_autoconnect()
will take care of loading the profile that DPP wrote and remove the
need for DPP to touch the network object at all.

One thing to note is that an idle callback is still needed from
within the known networks callback. This is because a new profile
requires network.c to set the network_info which is done in the
known networks callback. Rather than assume that network.c will be
called into before dpp.c an l_idle was added.
---
 src/dpp.c | 124 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 93 insertions(+), 31 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 1ff4b99e..af6574fb 100644
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
+			strerror(-ret));
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

