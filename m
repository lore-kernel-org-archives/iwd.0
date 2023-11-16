Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73C9CA6B
	for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2eH6GCZ"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-41cc535cd5cso6078641cf.2
        for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 10:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700160309; x=1700765109; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkHB3BocsRCRIYN78GjMhPcogYaQuLRPMjm82svwRe8=;
        b=M2eH6GCZsWS9CXFJDl8GB88E4uTuxxA9cN9aRhYkUgaOuUHvuzB0FfDh77oMUbjAoO
         UUc0bVjPdmBf1hjlgYHhHcPpSpjxE/qS/Xama/a95A1IDCPYa7O5RFvgv/+xmlE5hZi5
         3t1DxIIEjAgpxKvs0SmlUUYqkcy81NcDBEp4y52fbVn+URHLd+79Gu8+/QF4i7bRZRVD
         Jd5/EnBeYryf8oEyNs0aHs6FqOOHA3LB/omGjiDHxJhPr5rOkieCP/RBCHY4cVNeLccu
         AtgA5XQqF/qOeddy2B36DwA44yh2dVpZnhghSK9W+9HxHPxmHzY1SWdsm/mbmNE8GHiB
         OelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700160309; x=1700765109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkHB3BocsRCRIYN78GjMhPcogYaQuLRPMjm82svwRe8=;
        b=OpHKsgwFhvLs7QSzDE8q6h07wKegR8itY2LEdT88KpEdgP3UBaglP6kyKr4qBKVGOE
         lbvm2lgAoOouOF7MTnkY8oZK96KbZNaca1pEona7sVlJiOtgFQ+wbT/vieICANW5xBZn
         7dEZhfY8gdFJ7I58wL3P0iEHSaxtNeiQibWZHiVhZ4KlVSd0IGBFlZQvpb7g/HlOOAbF
         s/v3ZGgYbA2iM1MDuAx5J+qPEeCllH/sB8Xv8idAFMoQKDioXeTqmB5J9LamT10WNAjw
         k0NKfx9930ws+YOjkbHgO8g6abh8LjUs8dYliGKFsf+fLC1iT9K7dj/J2e0reF3+EErD
         WWqw==
X-Gm-Message-State: AOJu0YxMuavZ1Q762seVOMRf6RNfesQHCSS00yHOKpfkPBi6J2nV6BWV
	mQFT9ocOgEerJa17oyj/xBJY3Wk4RtY=
X-Google-Smtp-Source: AGHT+IF+0+QKdKrjmnSe3DBphtiFpFa1ZvaVWUdl4fB5nNTcrZOw1BfP1d0dunjDr2ZPxy/CzaAMUw==
X-Received: by 2002:ac8:7c44:0:b0:410:9111:4a0b with SMTP id o4-20020ac87c44000000b0041091114a0bmr11333247qtv.13.1700160308705;
        Thu, 16 Nov 2023 10:45:08 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id b7-20020ac84f07000000b004196d75d79csm4533261qte.46.2023.11.16.10.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:45:08 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/3] dpp: use the new config->ssid member
Date: Thu, 16 Nov 2023 10:44:58 -0800
Message-Id: <20231116184459.292601-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116184459.292601-1-prestwoj@gmail.com>
References: <20231116184459.292601-1-prestwoj@gmail.com>
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
index 18b2a7c6..b1f9c5ac 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -809,7 +809,6 @@ static void send_config_result(struct dpp_sm *dpp, const uint8_t *to)
 static void dpp_write_config(struct dpp_configuration *config,
 				struct network *network)
 {
-	char ssid[33];
 	_auto_(l_settings_free) struct l_settings *settings = NULL;
 	_auto_(l_free) char *path;
 	_auto_(l_free) uint8_t *psk = NULL;
@@ -820,10 +819,7 @@ static void dpp_write_config(struct dpp_configuration *config,
 	else
 		settings = l_settings_new();
 
-	memcpy(ssid, config->ssid, config->ssid_len);
-	ssid[config->ssid_len] = '\0';
-
-	path = storage_get_network_file_path(SECURITY_PSK, ssid);
+	path = storage_get_network_file_path(SECURITY_PSK, config->ssid);
 
 	if (l_settings_load_from_file(settings, path)) {
 		/* Remove any existing Security keys */
@@ -846,9 +842,9 @@ static void dpp_write_config(struct dpp_configuration *config,
 			network_set_psk(network, psk);
 	}
 
-	l_debug("Storing credential for '%s(%s)'", ssid,
+	l_debug("Storing credential for '%s(%s)'", config->ssid,
 						security_to_str(SECURITY_PSK));
-	storage_network_sync(SECURITY_PSK, ssid, settings);
+	storage_network_sync(SECURITY_PSK, config->ssid, settings);
 }
 
 static void dpp_scan_triggered(int err, void *user_data)
@@ -937,8 +933,6 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
 	struct network *network = NULL;
 	struct scan_bss *bss = NULL;
-	char ssid[33];
-	size_t ssid_len;
 
 	if (dpp->state != DPP_STATE_CONFIGURING)
 		return;
@@ -1067,17 +1061,13 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
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
 
@@ -1089,19 +1079,22 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
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

