Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CE41E6DFC
	for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514557; cv=none; b=ipEcNggpFn8rYZhGqQXJ/ZasX/GsFKBFpjoQut63wTyaV/EMnqeWL6QdcYle8pFs2FmpBvp9hf7NSFmSygz+5dcmEJd+tjBlYgNWVp3Ac3Se6ca2kbXSeeaYIT1tbnQ5TQYX+9jAaqLrCtNWFKaPWGgk6tjR6vAJKLTN8ipsZB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514557; c=relaxed/simple;
	bh=zSVYF9l/Ta+jiHdLZZFCc7ShXdxzsNGTpeoacApvsuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L49Unr4E8XlT4iy33KxJABrt4OCD9Z5PGi37cfa828JelVHUlulXqHuaKA1bE6SguNiyBnlHSuTi+DbrjSh4WzaskcHX+hgyuh8+a+acqz/uCM4C0CYS1K23kb3ouNxHlag8iHIJomANDIQ09hhRBC4WovI3GWa825AQ2X5t3jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhDpAbxw; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhDpAbxw"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbd1ae26a6so27935776d6.1
        for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 05:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729514554; x=1730119354; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p0TNcHPu/qjDPiDPqm+Ndqr3W8h2jWCENfx7iK+20iE=;
        b=lhDpAbxwecayoAZs03AIyf73npLoKAaCOw/0z+6fRssUmV2PqbV+TMq78AQtykKhVz
         Qc+essZk7x7VBaZ3uTLiSvKvLo2H5Rz6Bx+IcpBNppNI33kfmts5XxDxsT3O25JuELGM
         Ia22MCW43nOWQKaODuFXthB7xddubMkyGGf5rMyvLdQjbnTv5UOK6y1Ssknvqol1tddD
         NF3WVW3ChaQlZfFhAhWGI9vZF5rEO/tfZWpKdB5FhZuJw1a+03alIVl93c4mlNgEZOsk
         Au0LqfkCk6pFhaKZxy9GehSLzqE+RGA0ndgZWTvUj/gqQs9LmsvW6BOljngXoxS6ZTbY
         A9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514554; x=1730119354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0TNcHPu/qjDPiDPqm+Ndqr3W8h2jWCENfx7iK+20iE=;
        b=Z6Fq2L/Hfdjagy3C6zMuX+v29YIxQW4osIGmohVLowSZHOfLehG1eAhCehUploQ3W3
         Y4WJ1VjFyJy9tqQ1Q+UYZQT3SxQLQAZRFuDhX0d29lvS6lsEZakXnUXTHgOVFlZAXNVS
         P6ThqaJep4KD3PvgmCVYImyW3T+VVujeaMnZU70KFO69Ss7vScBNwAR+PYZSQYZyAzWw
         cZJumwB2bR1KJDsZ3G9VODNyVK3R2nuf67Va0NPJO3y4Vx/F/oR2sFHMLASOBevRYWa4
         1AT32mZ8EkhAbXXkiYIShHyRZl1ybeagQSNVEU7toNFMajP1S33DZ+tMkGkQEdBRPYJP
         3aWQ==
X-Gm-Message-State: AOJu0YxwOFYA7IyJqeE3oxMXimbZ8B3GFFOu7hQ1qZSyLjddKK7iTebX
	GMtouMjEP1vUij4IVbOAwoEIZ7WbLO5leyDEoy5ej9R0U8TnPMj/QLateQ==
X-Google-Smtp-Source: AGHT+IFQmykAu5PW3eYJ34nqrGhfZMnUMDv6bubk1J4HbBMm37X11afMX4doG1o7wITp7dXwY/HcEQ==
X-Received: by 2002:a05:6214:2f87:b0:6cb:ffd6:3ed8 with SMTP id 6a1803df08f44-6cde14bdef5mr171746286d6.10.1729514554292;
        Mon, 21 Oct 2024 05:42:34 -0700 (PDT)
Received: from LOCLAP699.localdomain ([72.46.116.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce00999ab0sm17006586d6.93.2024.10.21.05.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:42:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] frame-xchg: add multicast RX flag argument
Date: Mon, 21 Oct 2024 05:42:26 -0700
Message-Id: <20241021124228.145516-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DPP optionally uses the multicast RX flag for frame registrations but
since frame-xchg did not support that, it used its own registration
internally. To avoid code re-use within DPP add a flag to
frame_watch_add in order to allow DPP to utilize frame-xchg.
---
 src/ap.c         | 12 ++++++------
 src/dpp.c        |  4 ++--
 src/frame-xchg.c |  7 ++++++-
 src/frame-xchg.h |  1 +
 src/netdev.c     | 14 +++++++-------
 src/p2p.c        |  5 +++--
 src/rrm.c        |  2 +-
 src/station.c    |  2 +-
 8 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 6650f0af..562e00c8 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3914,34 +3914,34 @@ struct ap_state *ap_start(struct netdev *netdev, struct l_settings *config,
 
 	if (!frame_watch_add(wdev_id, 0, 0x0000 |
 			(MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_REQUEST << 4),
-			NULL, 0, ap_assoc_req_cb, ap, NULL))
+			NULL, 0, false, ap_assoc_req_cb, ap, NULL))
 		goto error;
 
 	if (!frame_watch_add(wdev_id, 0, 0x0000 |
 			(MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_REQUEST << 4),
-			NULL, 0, ap_reassoc_req_cb, ap, NULL))
+			NULL, 0, false, ap_reassoc_req_cb, ap, NULL))
 		goto error;
 
 	if (!wiphy_supports_probe_resp_offload(wiphy)) {
 		if (!frame_watch_add(wdev_id, 0, 0x0000 |
 				(MPDU_MANAGEMENT_SUBTYPE_PROBE_REQUEST << 4),
-				NULL, 0, ap_probe_req_cb, ap, NULL))
+				NULL, 0, false, ap_probe_req_cb, ap, NULL))
 			goto error;
 	}
 
 	if (!frame_watch_add(wdev_id, 0, 0x0000 |
 				(MPDU_MANAGEMENT_SUBTYPE_DISASSOCIATION << 4),
-				NULL, 0, ap_disassoc_cb, ap, NULL))
+				NULL, 0, false, ap_disassoc_cb, ap, NULL))
 		goto error;
 
 	if (!frame_watch_add(wdev_id, 0, 0x0000 |
 				(MPDU_MANAGEMENT_SUBTYPE_AUTHENTICATION << 4),
-				NULL, 0, ap_auth_cb, ap, NULL))
+				NULL, 0, false, ap_auth_cb, ap, NULL))
 		goto error;
 
 	if (!frame_watch_add(wdev_id, 0, 0x0000 |
 				(MPDU_MANAGEMENT_SUBTYPE_DEAUTHENTICATION << 4),
-				NULL, 0, ap_deauth_cb, ap, NULL))
+				NULL, 0, false, ap_deauth_cb, ap, NULL))
 		goto error;
 
 	ap->mlme_watch = l_genl_family_register(ap->nl80211, "mlme",
diff --git a/src/dpp.c b/src/dpp.c
index 03e2a7a6..004b431d 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -3861,11 +3861,11 @@ static void dpp_create(struct netdev *netdev)
 
 	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0,
 				dpp_conf_response_prefix,
-				sizeof(dpp_conf_response_prefix),
+				sizeof(dpp_conf_response_prefix), false,
 				dpp_handle_config_response_frame, dpp, NULL);
 	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0,
 				dpp_conf_request_prefix,
-				sizeof(dpp_conf_request_prefix),
+				sizeof(dpp_conf_request_prefix), false,
 				dpp_handle_config_request_frame, dpp, NULL);
 
 	dpp->known_network_watch = known_networks_watch_add(
diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 158befd0..42d9a3ae 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -575,6 +575,7 @@ drop:
 
 bool frame_watch_add(uint64_t wdev_id, uint32_t group_id, uint16_t frame_type,
 			const uint8_t *prefix, size_t prefix_len,
+			bool multicast_rx,
 			frame_watch_cb_t handler, void *user_data,
 			frame_xchg_destroy_func_t destroy)
 {
@@ -614,6 +615,10 @@ bool frame_watch_add(uint64_t wdev_id, uint32_t group_id, uint16_t frame_type,
 	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_MATCH,
 				prefix_len, prefix);
 
+	if (multicast_rx)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_RECEIVE_MULTICAST,
+					0, NULL);
+
 	if (group->id == 0)
 		l_genl_family_send(nl80211, msg, frame_watch_register_cb,
 					L_UINT_TO_PTR(frame_type), NULL);
@@ -1194,7 +1199,7 @@ uint32_t frame_xchg_startv(uint64_t wdev_id, struct iovec *frame, uint32_t freq,
 		watch->prefix = prefix;
 		watch->cb = va_arg(resp_args, void *);
 		frame_watch_add(wdev_id, group_id, prefix->frame_type,
-				prefix->data, prefix->len,
+				prefix->data, prefix->len, false,
 				frame_xchg_resp_cb, fx, NULL);
 
 		if (!fx->rx_watches)
diff --git a/src/frame-xchg.h b/src/frame-xchg.h
index 9e250e3f..3f1e0e55 100644
--- a/src/frame-xchg.h
+++ b/src/frame-xchg.h
@@ -45,6 +45,7 @@ enum frame_xchg_group {
 
 bool frame_watch_add(uint64_t wdev_id, uint32_t group, uint16_t frame_type,
 			const uint8_t *prefix, size_t prefix_len,
+			bool multicast_rx,
 			frame_watch_cb_t handler, void *user_data,
 			frame_xchg_destroy_func_t destroy);
 bool frame_watch_group_remove(uint64_t wdev_id, uint32_t group);
diff --git a/src/netdev.c b/src/netdev.c
index 8379a598..2eebf457 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -5720,35 +5720,35 @@ static void netdev_add_station_frame_watches(struct netdev *netdev)
 
 	/* Subscribe to Management -> Action -> RM -> Neighbor Report frames */
 	frame_watch_add(wdev, 0, 0x00d0, action_neighbor_report_prefix,
-			sizeof(action_neighbor_report_prefix),
+			sizeof(action_neighbor_report_prefix), false,
 			netdev_neighbor_report_frame_event, netdev, NULL);
 
 	frame_watch_add(wdev, 0, 0x00d0, action_sa_query_resp_prefix,
-			sizeof(action_sa_query_resp_prefix),
+			sizeof(action_sa_query_resp_prefix), false,
 			netdev_sa_query_resp_frame_event, netdev, NULL);
 
 	frame_watch_add(wdev, 0, 0x00d0, action_sa_query_req_prefix,
-			sizeof(action_sa_query_req_prefix),
+			sizeof(action_sa_query_req_prefix), false,
 			netdev_sa_query_req_frame_event, netdev, NULL);
 
 	frame_watch_add(wdev, 0, 0x00d0, action_ft_response_prefix,
-			sizeof(action_ft_response_prefix),
+			sizeof(action_ft_response_prefix), false,
 			netdev_ft_response_frame_event, netdev, NULL);
 
 	frame_watch_add(wdev, 0, 0x00b0, auth_ft_response_prefix,
-			sizeof(auth_ft_response_prefix),
+			sizeof(auth_ft_response_prefix), false,
 			netdev_ft_auth_response_frame_event, netdev, NULL);
 
 	if (wiphy_supports_qos_set_map(netdev->wiphy))
 		frame_watch_add(wdev, 0, 0x00d0, action_qos_map_prefix,
-				sizeof(action_qos_map_prefix),
+				sizeof(action_qos_map_prefix), false,
 				netdev_qos_map_frame_event, netdev, NULL);
 
 	if (!wiphy_supports_cmds_auth_assoc(netdev->wiphy) &&
 			wiphy_has_feature(netdev->wiphy, NL80211_FEATURE_SAE))
 		frame_watch_add(wdev, 0, 0x00b0,
 				auth_sae_prefix, sizeof(auth_sae_prefix),
-				netdev_sae_external_auth_frame_event,
+				false, netdev_sae_external_auth_frame_event,
 				netdev, NULL);
 }
 
diff --git a/src/p2p.c b/src/p2p.c
index e8c7c5de..e55cb76a 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -4163,10 +4163,11 @@ static void p2p_device_discovery_start(struct p2p_device *dev)
 						L_ARRAY_SIZE(channels_social)];
 
 	frame_watch_add(dev->wdev_id, FRAME_GROUP_P2P_LISTEN, 0x0040,
-			(uint8_t *) "", 0, p2p_device_probe_cb, dev, NULL);
+			(uint8_t *) "", 0, false,
+			p2p_device_probe_cb, dev, NULL);
 	frame_watch_add(dev->wdev_id, FRAME_GROUP_P2P_LISTEN, 0x00d0,
 			p2p_frame_go_neg_req.data, p2p_frame_go_neg_req.len,
-			p2p_device_go_negotiation_req_cb, dev, NULL);
+			false, p2p_device_go_negotiation_req_cb, dev, NULL);
 
 	p2p_device_scan_start(dev);
 }
diff --git a/src/rrm.c b/src/rrm.c
index a11a6532..e5118a99 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -798,7 +798,7 @@ static void rrm_add_frame_watches(struct rrm_state *rrm)
 	l_debug("");
 
 	frame_watch_add(rrm->wdev_id, 0, frame_type, prefix, sizeof(prefix),
-					rrm_frame_watch_cb, rrm, NULL);
+					false, rrm_frame_watch_cb, rrm, NULL);
 }
 
 static struct rrm_state *rrm_new_state(struct netdev *netdev)
diff --git a/src/station.c b/src/station.c
index b7905c4f..cef6c66a 100644
--- a/src/station.c
+++ b/src/station.c
@@ -5698,7 +5698,7 @@ static void add_frame_watches(struct netdev *netdev)
 	 */
 	frame_watch_add(netdev_get_wdev_id(netdev), 0, 0x00d0,
 			action_ap_roam_prefix, sizeof(action_ap_roam_prefix),
-			ap_roam_frame_event,
+			false, ap_roam_frame_event,
 			L_UINT_TO_PTR(netdev_get_ifindex(netdev)), NULL);
 }
 
-- 
2.34.1

