Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE3B39FE4
	for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYS7QKJ8"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-41cc44736f2so7027261cf.3
        for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 11:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700162135; x=1700766935; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJ59JXAT4S8TzjACMcbVJFVWJVTCoy1LWfuPZx0+EmQ=;
        b=iYS7QKJ8v8baL9ZYuJkVNBOvqMQR+zN21Y+FqBLQKSsGpSO3QuPhRlS6NTw1dcLVXR
         y5S0Twn12dWBs/hpa2uOhDJZNH0fX9diMUgSgRePScRimfuyOeuWA5s/Aj3h5bodF5KK
         /JUV66TUQ9zMORqD0aA7Mkw4KGMxnuEOkyLWFT5xXf/kqUZrzp0fZKROuqJI37MoI8AI
         39oNkesLYjjHMuRWDvX9KO68TxYm1nXUj/Q9xtVGMIAcLbzSu5q0pgF/EzRD8FIWT8fj
         H3AppxW4Z3m8rVgRvIL4b+mEIqILYiOH06wG0kbB4nrPf8PPvnMWR2acnOhitTj92sEW
         JFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700162135; x=1700766935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJ59JXAT4S8TzjACMcbVJFVWJVTCoy1LWfuPZx0+EmQ=;
        b=DXiiTBFmwz30f8wcBYKXjte3FO8cQ9aKuTMtdECTDEgGF6GpKEC7I655SzkEbXM3ZQ
         dJKKPzSizcM3s2m4jXnV7UQg4LFZQvsSF5KVxtFJVKnexwm3COTBpK9ncYxCcrk32UEX
         se5mrrTdOfIfghNulTTt9Xhic/BY6DupKGd5MK1FDSKBbmzITI3Da7Z/LEcvRLRU/VPJ
         Sqa2u2/Zgm/Jy41vFnxsZ90YvfNrrWmOi+G/FHApSpnt5iRWMRQi8RfNdyPczu63feS7
         mRlSt/aOvMZUzuKAsMiHSH7XCWi/QPV8PGCAD9/5EQuZX1O7jHlumXUmp2nJsy4CAmZV
         QFUA==
X-Gm-Message-State: AOJu0Yyft19+Kz/R9nBesoWpvUkk3qjJNjLN6tWhbeNHv2T2A70cGsdA
	n9vy3MxFlmT1j5hrW/D2LaP/Yi3aFx4=
X-Google-Smtp-Source: AGHT+IEBbAqdFSPxdPn3G+3lFrxtw3yochscYFXwFPRDeaACjy/QiaZz03ojCEHxD3iTLPOv5Kw6zw==
X-Received: by 2002:a05:622a:1315:b0:419:5767:af55 with SMTP id v21-20020a05622a131500b004195767af55mr11075956qtk.16.1700162135438;
        Thu, 16 Nov 2023 11:15:35 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c14-20020ac8660e000000b004198d026be6sm4376qtp.35.2023.11.16.11.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:15:34 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/3] dpp: use the new config->ssid member
Date: Thu, 16 Nov 2023 11:15:27 -0800
Message-Id: <20231116191528.364340-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116191528.364340-1-prestwoj@gmail.com>
References: <20231116191528.364340-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is now a NULL terminated string so it can be used directly.
---
 src/dpp.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 36d5d62e..907f3bf5 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -809,16 +809,12 @@ static void send_config_result(struct dpp_sm *dpp, const uint8_t *to)
 static void dpp_write_config(struct dpp_configuration *config,
 				struct network *network)
 {
-	char ssid[33];
 	_auto_(l_settings_free) struct l_settings *settings = l_settings_new();
 	_auto_(l_free) char *path;
 	_auto_(l_free) uint8_t *psk = NULL;
 	size_t psk_len;
 
-	memcpy(ssid, config->ssid, config->ssid_len);
-	ssid[config->ssid_len] = '\0';
-
-	path = storage_get_network_file_path(SECURITY_PSK, ssid);
+	path = storage_get_network_file_path(SECURITY_PSK, config->ssid);
 
 	if (l_settings_load_from_file(settings, path)) {
 		/* Remove any existing Security keys */
@@ -841,9 +837,9 @@ static void dpp_write_config(struct dpp_configuration *config,
 			network_set_psk(network, psk);
 	}
 
-	l_debug("Storing credential for '%s(%s)'", ssid,
+	l_debug("Storing credential for '%s(%s)'", config->ssid,
 						security_to_str(SECURITY_PSK));
-	storage_network_sync(SECURITY_PSK, ssid, settings);
+	storage_network_sync(SECURITY_PSK, config->ssid, settings);
 }
 
 static void dpp_scan_triggered(int err, void *user_data)
@@ -932,8 +928,6 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
 	struct network *network = NULL;
 	struct scan_bss *bss = NULL;
-	char ssid[33];
-	size_t ssid_len;
 
 	if (dpp->state != DPP_STATE_CONFIGURING)
 		return;
@@ -1062,17 +1056,13 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 	 * credentials out and be done
 	 */
 	if (station) {
-		memcpy(ssid, config->ssid, config->ssid_len);
-		ssid_len = config->ssid_len;
-		ssid[config->ssid_len] = '\0';
-
-		network = station_network_find(station, ssid, SECURITY_PSK);
+		network = station_network_find(station, config->ssid,
+						SECURITY_PSK);
 		if (network)
 			bss = network_bss_select(network, true);
 	}
 
 	dpp_write_config(config, network);
-	dpp_configuration_free(config);
 
 	send_config_result(dpp, dpp->peer_addr);
 
@@ -1084,19 +1074,22 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 	else if (station) {
 		struct scan_parameters params = {0};
 
-		params.ssid = (void *) ssid;
-		params.ssid_len = ssid_len;
+		params.ssid = (void *) config->ssid;
+		params.ssid_len = config->ssid_len;
 
-		l_debug("Scanning for %s", ssid);
+		l_debug("Scanning for %s", config->ssid);
 
 		dpp->connect_scan_id = scan_active_full(dpp->wdev_id, &params,
 						dpp_scan_triggered,
 						dpp_scan_results, dpp,
 						dpp_scan_destroy);
-		if (dpp->connect_scan_id)
+		if (dpp->connect_scan_id) {
+			dpp_configuration_free(config);
 			return;
+		}
 	}
 
+	dpp_configuration_free(config);
 	dpp_reset(dpp);
 }
 
-- 
2.34.1

