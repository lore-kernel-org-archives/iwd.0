Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F8D156CE
	for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TouUj4XX"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7789577b53fso96149485a.3
        for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 13:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698352028; x=1698956828; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVKSeH84kKGR8hiFCBX3rFqpp2wx2B4B0cMq81CHutE=;
        b=TouUj4XXA+tG/CSNeZjvn8s/z2HbxtoM3VLHWresceheI9FT6Y+q/FUsvv40STOBc0
         E9zPgVBU2sJtogrk13yrYznxeclXmrR+p8d2mbu5+Fv80pO2KatEuAMthkFYwpL48pF4
         7+5krPDUK62TeuLNB8O2pMsZ3ipNrTOKoA6BbDQqRQRMiEPVSdAL618+TZeeCoQIsjAS
         IDdIfopQLcEO019qILdGNBfYzPcKeJcEpT3hykQrsxHoosZK2W5dZnpUC9kU9FfZgIVO
         OM6y+kBAf7d48/z5mh7MJpYkAS+0HePCWPVeNb8geiO7jC+w7/PNyxn2Fj5Od96CtONC
         iJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698352028; x=1698956828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVKSeH84kKGR8hiFCBX3rFqpp2wx2B4B0cMq81CHutE=;
        b=ea9IAYpYdrYEhZ8uYwTny3/gaBT4ufgOol+8M58ckuNUYV/fQ8CB+LoAL5DCBxBvnO
         BeWMx1/kQcjDi/awKEs24DWct2fHNzGg63gN0qsBxsnaxutsvDLjBhjQZqJ5yg32GY77
         zzPhGqKR9II3LbDElBYRSA4t2HBFAJZgORGnBJSkx+aOIHcwCNKBxX9tTnbgFlWeQbDN
         EAhL4vV47GZUzASURoSP5tz/sbb5hJCEzDt4Eu/wBbgeoNBrYLQn3ZNbI0JWoYKvnK9W
         +RO4UxWdAWcVw+aX7HeI57gQKyT78HldhYEijCho2/G2kxJRe/ZSvG/MZCfq8Y4Hf0im
         81yg==
X-Gm-Message-State: AOJu0Yzm+YZNdhIXvidel8bBvGRmG2wh10+3avH2oPZ4pLjRJAvYBAHF
	lKLJjqZvoWTcScLDlVq1DM1P9jxA8JI=
X-Google-Smtp-Source: AGHT+IEFwHHhFFn6X62xTLfT6aRB//rfL8MN7n5s/dHbWx8SkRBKzuUBmX78zPxtkj4pBFx64Eqw/g==
X-Received: by 2002:a05:620a:6014:b0:778:8fee:e863 with SMTP id dw20-20020a05620a601400b007788feee863mr447295qkb.75.1698352028467;
        Thu, 26 Oct 2023 13:27:08 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id r4-20020a05620a298400b007742c2ad7dfsm7303qkp.73.2023.10.26.13.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:27:08 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 02/15] dpp: remove connect/scanning and resume periodic scans after DPP
Date: Thu, 26 Oct 2023 13:26:44 -0700
Message-Id: <20231026202657.183591-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026202657.183591-1-prestwoj@gmail.com>
References: <20231026202657.183591-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When DPP is started periodic scans are stopped but never started
again. This means if DPP fails IWD will never resume autoconnecting
without some intervention.

This also removes the internal scanning/connecting logic from DPP
which was done for two reasons. First its unknown how long the
DPP protocol took and its safest to explicitly scan to find the
target network/bss, and second the connect logic was flawed because
station will not transition into a CONNECTING state since
__station_connect_network shortcuts the state change. If DPP failed
station would never resume autoconnecting, and if the post-DPP
connection failed the state was set incorrectly so station would
also not resume autoconnecting.

The downside of this is it takes slightly longer to connect after
DPP since IWD must scan, but the DPP logic is simplified and keeps
all connection logic in station.c where it belongs.
---
 src/dpp.c | 76 ++++++++++++++++++++-----------------------------------
 1 file changed, 27 insertions(+), 49 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index c93b9f1c..23b17d01 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -71,6 +71,7 @@ enum dpp_state {
 	DPP_STATE_PRESENCE,
 	DPP_STATE_AUTHENTICATING,
 	DPP_STATE_CONFIGURING,
+	DPP_STATE_SUCCESS,
 };
 
 enum dpp_capability {
@@ -137,7 +138,6 @@ struct dpp_sm {
 	struct l_timeout *timeout;
 
 	struct dpp_configuration *config;
-	uint32_t connect_scan_id;
 	uint64_t frame_cookie;
 	uint8_t frame_retry;
 	void *frame_pending;
@@ -149,6 +149,7 @@ struct dpp_sm {
 	bool mcast_support : 1;
 	bool roc_started : 1;
 	bool channel_switch : 1;
+	bool station_autoconnecting : 1;
 };
 
 static bool dpp_get_started(struct l_dbus *dbus,
@@ -270,6 +271,8 @@ static void dpp_free_auth_data(struct dpp_sm *dpp)
 
 static void dpp_reset(struct dpp_sm *dpp)
 {
+	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+
 	if (dpp->uri) {
 		l_free(dpp->uri);
 		dpp->uri = NULL;
@@ -295,11 +298,6 @@ static void dpp_reset(struct dpp_sm *dpp)
 		dpp->config = NULL;
 	}
 
-	if (dpp->connect_scan_id) {
-		scan_cancel(dpp->wdev_id, dpp->connect_scan_id);
-		dpp->connect_scan_id = 0;
-	}
-
 	if (dpp->peer_asn1) {
 		l_free(dpp->peer_asn1);
 		dpp->peer_asn1 = NULL;
@@ -315,7 +313,17 @@ static void dpp_reset(struct dpp_sm *dpp)
 		dpp->retry_timeout = NULL;
 	}
 
+	/*
+	 * Set station back to its original autoconnecting state if an
+	 * enrollee and DPP failed
+	 */
+	if (station && dpp->role == DPP_CAPABILITY_ENROLLEE &&
+			dpp->station_autoconnecting &&
+			dpp->state != DPP_STATE_SUCCESS)
+		station_set_autoconnect(station, true);
+
 	dpp->state = DPP_STATE_NOTHING;
+	dpp->role = 0;
 	dpp->new_freq = 0;
 	dpp->frame_retry = 0;
 	dpp->frame_cookie = 0;
@@ -629,36 +637,6 @@ static void dpp_write_config(struct dpp_configuration *config,
 	storage_network_sync(SECURITY_PSK, ssid, settings);
 }
 
-static void dpp_scan_triggered(int err, void *user_data)
-{
-	/* Not much can be done in this case */
-	if (err < 0)
-		l_error("Failed to trigger DPP scan");
-}
-
-static bool dpp_scan_results(int err, struct l_queue *bss_list,
-				const struct scan_freq_set *freqs,
-				void *userdata)
-{
-	struct dpp_sm *dpp = userdata;
-	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
-
-	if (err < 0)
-		return false;
-
-	station_set_scan_results(station, bss_list, freqs, true);
-
-	return true;
-}
-
-static void dpp_scan_destroy(void *userdata)
-{
-	struct dpp_sm *dpp = userdata;
-
-	dpp->connect_scan_id = 0;
-	dpp_reset(dpp);
-}
-
 static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 				const void *body, size_t body_len,
 				int rssi, void *user_data)
@@ -685,7 +663,6 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 	struct dpp_configuration *config;
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
 	struct network *network = NULL;
-	struct scan_bss *bss = NULL;
 	char ssid[33];
 
 	if (dpp->state != DPP_STATE_CONFIGURING)
@@ -819,8 +796,6 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 		ssid[config->ssid_len] = '\0';
 
 		network = station_network_find(station, ssid, SECURITY_PSK);
-		if (network)
-			bss = network_bss_select(network, true);
 	}
 
 	dpp_write_config(config, network);
@@ -830,16 +805,9 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 
 	offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
 
-	if (network && bss)
-		__station_connect_network(station, network, bss);
-	else if (station) {
-		dpp->connect_scan_id = scan_active(dpp->wdev_id, NULL, 0,
-						dpp_scan_triggered,
-						dpp_scan_results, dpp,
-						dpp_scan_destroy);
-		if (dpp->connect_scan_id)
-			return;
-	}
+	dpp->state = DPP_STATE_SUCCESS;
+
+	station_set_autoconnect(station, true);
 
 	dpp_reset(dpp);
 }
@@ -1579,6 +1547,7 @@ static void dpp_offchannel_timeout(int error, void *user_data)
 	case DPP_STATE_PRESENCE:
 		break;
 	case DPP_STATE_NOTHING:
+	case DPP_STATE_SUCCESS:
 		/* Protocol already terminated */
 		return;
 	case DPP_STATE_AUTHENTICATING:
@@ -2508,6 +2477,15 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 	dpp->state = DPP_STATE_PRESENCE;
 	dpp->role = DPP_CAPABILITY_ENROLLEE;
 
+	/*
+	 * If the DPP fails its probably best to continue with periodic scans
+	 * just in case there is an available network.
+	 */
+	if (station) {
+		dpp->station_autoconnecting = station_get_autoconnect(station);
+		station_set_autoconnect(station, false);
+	}
+
 	l_ecdh_generate_key_pair(dpp->curve, &dpp->proto_private,
 					&dpp->own_proto_public);
 
-- 
2.25.1

