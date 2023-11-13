Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF79522EE1
	for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYupAM1j"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-675b844adc7so27444556d6.0
        for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 09:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699898046; x=1700502846; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dINIBTWCK8O656hXGWZUpI4caiHQQa5+aoX/2ie34dc=;
        b=PYupAM1joD+4jQ+jTvyFaSSQjtPqUXJlsXlk9Cpg1mrX/ruj+BUvlbjAJBeDjFDWdn
         I0nbUYpNHtOobXBQQvf17s80PELPAEvlrrFhDvvajw9APG51l2J4MSDyzxd3btDQf1Ua
         oEp/cP+LxfUUGrY++q0bPypkhRPoQkVGiVN7qqTOJs++prJub1vxk0zywVieu0bo0wdP
         PjFMdQ96utiDgWHGS5/NM5YOjqMZ69xQ/5d1EEyQIp3RLXdXAgFuZSYmm1TnWbwIMbPD
         3sYUi064GG/51bqK3C/EByWZqD6Fxoi6AS2rraz+akzQ2dieuTmobPDSTpof3WIWzGPR
         Efgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699898046; x=1700502846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dINIBTWCK8O656hXGWZUpI4caiHQQa5+aoX/2ie34dc=;
        b=ism2T4Sl/UGQkzMpdOvZVC+ocstuVhC83bbJB/4D5qFsV4eGJBsGxgO4ASBq+j5kwK
         wKgjmwKdEHKYpuiu0WLF57t3f3GTsKWlPG5ByVBkjsQUjuu7lXx/XumXN6TNuQRpdGGM
         uVmFguMqrGmGC1B3FJzIKfeQOdCaJ8lh1rPhkZbPanuT6oWHSLkBsAms+b9Zfw3mSok3
         Pxk2n8grVwwEuvGexs1vLMi2PTi/bz2C3MYjB+eJGKQ3wrsL+NA1eK9gt8Q4ynTJqLYU
         5szUiNS7FmPqgR5r/zTtaMdzlUDsLu985Dfg1yXDztVGi9ta7f5LZiflsKrrwaZahbo4
         IODw==
X-Gm-Message-State: AOJu0YzKAHOe5Lj4ng7nvxa4547ZcUrs42kpASNPCyVuHzBM6Gb4fMtZ
	Xq0jk+mIas02zb7BBK6aHDnihRRXj08=
X-Google-Smtp-Source: AGHT+IEyjpq82zd4pZvLcGpGtbMu4RcQN4/F5zUe3i1z5xFhRMgK/MVlG8OF/oyGapJ1JqVM5gRp3w==
X-Received: by 2002:a05:6214:2304:b0:66d:6311:f91f with SMTP id gc4-20020a056214230400b0066d6311f91fmr9044446qvb.45.1699898046379;
        Mon, 13 Nov 2023 09:54:06 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id n11-20020a05620a294b00b007756c0853a5sm2010975qkp.58.2023.11.13.09.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 09:54:06 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/4] dpp: add station watch to DPP
Date: Mon, 13 Nov 2023 09:53:59 -0800
Message-Id: <20231113175401.343239-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231113175401.343239-1-prestwoj@gmail.com>
References: <20231113175401.343239-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DPP (both DPP and PKEX) run the risk of odd behavior if station
decides to change state. DPP is completely unaware of this and
best case would just result in a protocol failure, worst case
duplicate calls to __station_connect_network.

Add a station watch and stop DPP if station changes state during
the protocol.
---
 src/dpp.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

v3:
 * Allow autoconnect states while enrolling. Its probably unlikely
   that a state change would happen but going between DISCONNECTED,
   AUTOCONNECT_QUICK, and AUTOCONNECT_FULL won't cause any issues
   while enrolling.

diff --git a/src/dpp.c b/src/dpp.c
index 3a740916..06ae2929 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -100,6 +100,7 @@ struct dpp_sm {
 	char *uri;
 	uint8_t role;
 	int refcount;
+	uint32_t station_watch;
 
 	uint64_t wdev_id;
 
@@ -536,6 +537,8 @@ static void dpp_reset(struct dpp_sm *dpp)
 
 static void dpp_free(struct dpp_sm *dpp)
 {
+	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+
 	dpp_reset(dpp);
 
 	if (dpp->own_asn1) {
@@ -553,6 +556,13 @@ static void dpp_free(struct dpp_sm *dpp)
 		dpp->boot_private = NULL;
 	}
 
+	/*
+	 * Since this is called when the netdev goes down, station may already
+	 * be gone in which case the state watch will automatically go away.
+	 */
+	if (station)
+		station_remove_state_watch(station, dpp->station_watch);
+
 	l_free(dpp);
 }
 
@@ -3608,6 +3618,67 @@ static void dpp_frame_watch(struct dpp_sm *dpp, uint16_t frame_type,
 					L_UINT_TO_PTR(frame_type), NULL);
 }
 
+/*
+ * Station is unaware of DPP's state so we need to handle a few cases here so
+ * weird stuff doesn't happen:
+ *
+ *   - While configuring we should stay connected, a disconnection/roam should
+ *     stop DPP since it would fail regardless due to the hardware going idle
+ *     or changing channels since configurators assume all comms will be
+ *     on-channel.
+ *   - While enrolling we should stay disconnected. If station connects during
+ *     enrolling it would cause 2x calls to __station_connect_network after
+ *     DPP finishes.
+ *
+ * Other conditions shouldn't ever happen i.e. configuring and going into a
+ * connecting state or enrolling and going to a disconnected/roaming state.
+ */
+static void dpp_station_state_watch(enum station_state state, void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+
+	switch (state) {
+	case STATION_STATE_DISCONNECTED:
+	case STATION_STATE_DISCONNECTING:
+	case STATION_STATE_ROAMING:
+	case STATION_STATE_FT_ROAMING:
+	case STATION_STATE_FW_ROAMING:
+		if (L_WARN_ON(dpp->role == DPP_CAPABILITY_ENROLLEE))
+			dpp_reset(dpp);
+
+		if (dpp->role == DPP_CAPABILITY_CONFIGURATOR) {
+			l_debug("Disconnected while configuring, stopping DPP");
+			dpp_reset(dpp);
+		}
+
+		break;
+	case STATION_STATE_CONNECTING:
+	case STATION_STATE_CONNECTED:
+	case STATION_STATE_CONNECTING_AUTO:
+		if (L_WARN_ON(dpp->role == DPP_CAPABILITY_CONFIGURATOR))
+			dpp_reset(dpp);
+
+		if (dpp->role == DPP_CAPABILITY_ENROLLEE) {
+			l_debug("Connecting while enrolling, stopping DPP");
+			dpp_reset(dpp);
+		}
+
+		break;
+
+	/*
+	 * Autoconnect states are fine for enrollees. This makes it nicer for
+	 * the user since they don't need to explicity Disconnect() to disable
+	 * autoconnect, then re-enable it if DPP fails.
+	 */
+	case STATION_STATE_AUTOCONNECT_FULL:
+	case STATION_STATE_AUTOCONNECT_QUICK:
+		if (L_WARN_ON(dpp->role == DPP_CAPABILITY_CONFIGURATOR))
+			dpp_reset(dpp);
+
+		break;
+	}
+}
+
 static void dpp_create(struct netdev *netdev)
 {
 	struct l_dbus *dbus = dbus_get_bus();
@@ -3615,6 +3686,7 @@ static void dpp_create(struct netdev *netdev)
 	uint8_t dpp_conf_response_prefix[] = { 0x04, 0x0b };
 	uint8_t dpp_conf_request_prefix[] = { 0x04, 0x0a };
 	uint64_t wdev_id = netdev_get_wdev_id(netdev);
+	struct station *station = station_find(netdev_get_ifindex(netdev));
 
 	dpp->netdev = netdev;
 	dpp->state = DPP_STATE_NOTHING;
@@ -3660,6 +3732,9 @@ static void dpp_create(struct netdev *netdev)
 				sizeof(dpp_conf_request_prefix),
 				dpp_handle_config_request_frame, dpp, NULL);
 
+	dpp->station_watch = station_add_state_watch(station,
+					dpp_station_state_watch, dpp, NULL);
+
 	l_queue_push_tail(dpp_list, dpp);
 }
 
-- 
2.25.1

