Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B05B5677B
	for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mullOZ8K"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ba2dc0f6b7so124284b6e.2
        for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 09:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702488365; x=1703093165; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+AzxstyjdTgwauON8U7WBzAIZNTEwIxtXNQec3PDBc=;
        b=mullOZ8KuG5pfFo0JEqr/R9Wjt1GySasCHWPqqTFkiHZdUv19qYT1ZEZeKfewXk5e3
         A2GJT+gc4OcNJOxqINz8Mg0C+oOcE24QkvNiihat/tI1pWUgierDz0hnka004VFrhOhd
         jugsRloCHm95757jTOO/lBPMGmC90HyuFu1bOldYQ11YWpWwWBdzSv9n6yqlySeHCfZs
         Vx1JqCy3glYmAzaskq69aOi4TzDwHBzd4xbSBVh9sXJm2XaZ+5a0SX76QnDsQqw5xpw5
         As/NL68+CYK2g/nipXKcDe1GPE+kcMj9hDmz3G8lEi7nPTUQob5yE2WcqObBoTSOaEVP
         MUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488365; x=1703093165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+AzxstyjdTgwauON8U7WBzAIZNTEwIxtXNQec3PDBc=;
        b=nZoE30Rq8O1HmXcQUfBfUmFbtu4L/oynpMlQq+cbNPja2RRo3P3aQcaI3n07LNhlou
         qn0BWhFtAmqJzLuCu6cjMgd1yCMMbCcCok56rKVj6SpLV9wWeRjPdGmiJxXapPmv45ul
         sVjESvjL/T4GDrpwU0AWqkesQo0jW302F/8wVYxAYaBW9S8zf5fo4nYK5hQd8Re6M9kF
         tDwtCdZyGlCSY5uGBC3n6siuVgZfTHImPoNDrobqJRenvsWa3lZ5OpOAPopWjqVBaal0
         zR88zPr4E7IO93L696JF/bJhOfvQ5LNWcULPOtZj8b0Y6tfri6/WiCvwaZXclARtZYpB
         pXvg==
X-Gm-Message-State: AOJu0Yytc31smEX9ojplPET2yVLBGK1hdqyP8jDMGcJiwjSM/wky07dt
	Z8B9IDKN7bZdstTcCAEvCvnjiLQrV4k=
X-Google-Smtp-Source: AGHT+IHvONMKNigkULiILrPwwgBLtabYdjI4diLHIhM+frGX/z9cRe4H/EYc0xKxwkP201QXkRDaSg==
X-Received: by 2002:a05:6808:21a6:b0:3b9:e87b:d963 with SMTP id be38-20020a05680821a600b003b9e87bd963mr11091154oib.85.1702488364812;
        Wed, 13 Dec 2023 09:26:04 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id hh12-20020a05622a618c00b00425f0ab0393sm556914qtb.17.2023.12.13.09.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:26:04 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 3/4] dpp: fix non-scan connect path in DPP
Date: Wed, 13 Dec 2023 09:25:45 -0800
Message-Id: <20231213172546.145998-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213172546.145998-1-prestwoj@gmail.com>
References: <20231213172546.145998-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When DPP completes it writes the network configuration to disk but
these changes aren't picked up by the network object until the
known networks dir watch. Currently the connection itself works
fine because the network object holds a copy of the passphrase/psk
but additional settings like Hidden/SendHostname are not updated
and not used for the connection through DPP.

In theory DPP could also watch for known networks events and wait
until the expected network is added but that is also fragile since
its not guaranteed that the DPP watch callback will happen _after_
the one in network (when the network_info) is set into the object.

Instead, DPP itself can handle the known network creation/update
itself. If a known network already exists update its config.
Otherwise create a new network_info object and set it into the
network object.
---
 src/dpp.c | 89 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 27 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 1ff4b99e..3b42541d 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -53,6 +53,7 @@
 #include "src/network.h"
 #include "src/handshake.h"
 #include "src/nl80211util.h"
+#include "src/knownnetworks.h"
 
 #define DPP_FRAME_MAX_RETRIES 5
 #define DPP_FRAME_RETRY_TIMEOUT 1
@@ -814,6 +815,8 @@ static void dpp_write_config(struct dpp_configuration *config,
 	_auto_(l_free) char *path;
 	_auto_(l_free) uint8_t *psk = NULL;
 	size_t psk_len;
+	struct network_config network_config;
+	struct network_info *info;
 
 	path = storage_get_network_file_path(SECURITY_PSK, config->ssid);
 
@@ -822,22 +825,13 @@ static void dpp_write_config(struct dpp_configuration *config,
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
 
@@ -847,6 +841,39 @@ static void dpp_write_config(struct dpp_configuration *config,
 	l_debug("Storing credential for '%s(%s)'", config->ssid,
 						security_to_str(SECURITY_PSK));
 	storage_network_sync(SECURITY_PSK, config->ssid, settings);
+
+	/*
+	 * The network has yet to be seen. Once a scan is issued station will
+	 * handle network creation and in turn the settings will be loaded from
+	 * disk.
+	 */
+	if (!network)
+		return;
+
+	/*
+	 * Otherwise we need to jump through some hoops in order to update an
+	 * existing network object with the new settings
+	 */
+	info = known_networks_find(config->ssid, SECURITY_PSK);
+
+	__network_config_parse(settings, path, &network_config);
+
+	if (info)
+		known_network_update(info, &network_config);
+	else {
+		info = l_new(struct network_info, 1);
+		__network_info_init(info, config->ssid, SECURITY_PSK, &network_config);
+		network_set_info(network, info);
+	}
+
+	if (config->passphrase)
+		network_set_passphrase(network, config->passphrase);
+	else if (config->psk) {
+		psk = l_util_from_hexstring(config->psk, &psk_len);
+
+		if (network)
+			network_set_psk(network, psk);
+	}
 }
 
 static void dpp_scan_triggered(int err, void *user_data)
@@ -856,14 +883,34 @@ static void dpp_scan_triggered(int err, void *user_data)
 		l_error("Failed to trigger DPP scan");
 }
 
+static void dpp_connect(struct dpp_sm *dpp, const char *ssid)
+{
+	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+	struct scan_bss *bss;
+	struct network *network;
+	int ret;
+
+	network = station_network_find(station, ssid, SECURITY_PSK);
+
+	dpp_reset(dpp);
+
+	if (!network) {
+		l_debug("Network was not found after scanning");
+		return;
+	}
+
+	bss = network_bss_select(network, true);
+	ret = network_autoconnect(network, bss);
+	if (ret < 0)
+		l_debug("Failed to connect after DPP (%d) %s", ret, strerror(ret));
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
@@ -880,18 +927,7 @@ static bool dpp_scan_results(int err, struct l_queue *bss_list,
 
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
+	dpp_connect(dpp, dpp->config->ssid);
 
 	return true;
 
@@ -1075,8 +1111,7 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 	offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
 
 	if (network && bss)
-		__station_connect_network(station, network, bss,
-						STATION_STATE_CONNECTING);
+		dpp_connect(dpp, config->ssid);
 	else if (station) {
 		struct scan_parameters params = {0};
 
-- 
2.34.1

