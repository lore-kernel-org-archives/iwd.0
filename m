Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3365393
	for <iwd@lists.linux.dev>; Fri,  1 Dec 2023 04:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsghTnmz"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-58d08497aa1so1010814eaf.0
        for <iwd@lists.linux.dev>; Thu, 30 Nov 2023 20:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701403274; x=1702008074; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+8N2Pg3MbO0Hi4W4LqvqhLAAc8XlJ2BzmXyJu8JYgU=;
        b=IsghTnmzD8SpNChgVMBUj1xYtogplHgqlnSG5cP8EyTTVKKNSA2J3YTm3NROFLHadV
         IU3DkzKcPulCpJ1PiX4zSvQ7jcI9GV+0MydRYL4ZF5DYXvASrIXOW4Cc5+C1zWCXbnRm
         I6qpJw73BQrUmRKI/i2zMsOE/TiTerrZ12HoK9QuJwWkToQcho75mzj3wJzPl6SOQcXk
         vmE2hEyKgTiPqunS59E3Ho5P162geeMQgdCOeisYK0W7S6UW0EYKk/rYF+KNlP10QPPL
         06dlOsNRx68HbnHWyil0MvF6/YSNEgI5cmmxiU8Btusd6dBWq/aoVvoHLWimkK8NQfja
         524Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701403274; x=1702008074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+8N2Pg3MbO0Hi4W4LqvqhLAAc8XlJ2BzmXyJu8JYgU=;
        b=Mj8Nf+P8Ttl1Q53MS2zkSkkcMammirrun32GbpdgPuaSmYb7KLv+9wVL+z1OClITvf
         2OhVqoqLgKwf6tiUBv9TxBXaR6dK280Sk3cmxVpgbPqVH8UZi2qbxCMHKcfkWTr/a5oZ
         A3t0jgeOwLhQw3JPcXfgEEfGFT0fJJzwt4R6HgYZTjI7gOVrMfNzQGPXeZ8O+3H08GTE
         RV/D/6arRLv36IQAbJF68IG6zd0KnfwhqViq1skTpdSK1VVfhEupeNniooCAhMWKsOV2
         XnJEgivdN2EfJANzwRkNfUoCIpaH+bItdGY72HUZ2vo3qKBQN55hhShd8n3w6e5MZUUi
         6WQw==
X-Gm-Message-State: AOJu0YxoT+ifxDN1Rg+s0y36/c+AL5+U8yuPAyFvZHCGZL1uuN3G99gb
	mw79nVqA9ntMEHNzASIpmxDQXY4uBVM=
X-Google-Smtp-Source: AGHT+IH1e9QNPQm/uctaJpCfiMpCPK9mqX9rDafBXBPoEIDIrtDWEvDuXCeU1uKwslbpw8vLU3KBYw==
X-Received: by 2002:a05:6820:502:b0:58d:6c99:fddb with SMTP id m2-20020a056820050200b0058d6c99fddbmr2158898ooj.8.1701403274059;
        Thu, 30 Nov 2023 20:01:14 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id o3-20020a4ad143000000b0058ab906ae38sm404005oor.2.2023.11.30.20.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 20:01:13 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 7/7] netdev: Remove vendor_ies from netdev_connect signature
Date: Thu, 30 Nov 2023 22:00:07 -0600
Message-ID: <20231201040020.161143-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201040020.161143-1-denkenz@gmail.com>
References: <20231201040020.161143-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vendor IEs are now passed in the handshake_state object instead.
---
 src/netdev.c  | 27 ++++++---------------------
 src/netdev.h  |  2 --
 src/p2p.c     |  2 +-
 src/station.c |  2 +-
 src/wsc.c     |  2 +-
 5 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index eb408447224c..f2e887b4d70b 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2450,9 +2450,7 @@ static void netdev_driver_connected(struct netdev *netdev)
 
 static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
 						struct handshake_state *hs,
-						const uint8_t *prev_bssid,
-						const struct iovec *vendor_ies,
-						size_t num_vendor_ies)
+						const uint8_t *prev_bssid)
 {
 	struct netdev_handshake_state *nhs =
 		l_container_of(hs, struct netdev_handshake_state, super);
@@ -2529,12 +2527,6 @@ static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
 
 	mpdu_sort_ies(subtype, iov, c_iov);
 
-	if (vendor_ies && !L_WARN_ON(n_iov - c_iov < num_vendor_ies)) {
-		memcpy(iov + c_iov, vendor_ies,
-					sizeof(*vendor_ies) * num_vendor_ies);
-		c_iov += num_vendor_ies;
-	}
-
 	if (c_iov)
 		l_genl_msg_append_attrv(msg, NL80211_ATTR_IE, iov, c_iov);
 
@@ -2570,8 +2562,7 @@ static bool netdev_retry_owe(struct netdev *netdev)
 	if (!owe_next_group(netdev->owe_sm))
 		return false;
 
-	connect_cmd = netdev_build_cmd_connect(netdev,
-					netdev->handshake, NULL, NULL, 0);
+	connect_cmd = netdev_build_cmd_connect(netdev, netdev->handshake, NULL);
 
 	netdev->connect_cmd_id = l_genl_family_send(nl80211, connect_cmd,
 						netdev_cmd_connect_cb, netdev,
@@ -3807,8 +3798,6 @@ static void netdev_connect_common(struct netdev *netdev,
 					const struct scan_bss *bss,
 					const struct scan_bss *prev_bss,
 					struct handshake_state *hs,
-					const struct iovec *vendor_ies,
-					size_t num_vendor_ies,
 					netdev_event_func_t event_filter,
 					netdev_connect_cb_t cb, void *user_data)
 {
@@ -3866,8 +3855,7 @@ static void netdev_connect_common(struct netdev *netdev,
 		break;
 	default:
 build_cmd_connect:
-		cmd_connect = netdev_build_cmd_connect(netdev, hs, prev_bssid,
-						vendor_ies, num_vendor_ies);
+		cmd_connect = netdev_build_cmd_connect(netdev, hs, prev_bssid);
 
 		if (!is_offload(hs) && (is_rsn || hs->settings_8021x)) {
 			sm = eapol_sm_new(hs);
@@ -3900,8 +3888,6 @@ build_cmd_connect:
 
 int netdev_connect(struct netdev *netdev, const struct scan_bss *bss,
 				struct handshake_state *hs,
-				const struct iovec *vendor_ies,
-				size_t num_vendor_ies,
 				netdev_event_func_t event_filter,
 				netdev_connect_cb_t cb, void *user_data)
 {
@@ -3918,9 +3904,8 @@ int netdev_connect(struct netdev *netdev, const struct scan_bss *bss,
 	if (netdev_handshake_state_setup_connection_type(hs) < 0)
 		return -ENOTSUP;
 
-	netdev_connect_common(netdev, bss, NULL, hs, vendor_ies,
-					num_vendor_ies, event_filter, cb,
-					user_data);
+	netdev_connect_common(netdev, bss, NULL, hs,
+				event_filter, cb, user_data);
 
 	return 0;
 }
@@ -4025,7 +4010,7 @@ int netdev_reassociate(struct netdev *netdev, const struct scan_bss *target_bss,
 	netdev->connected = false;
 	netdev->in_reassoc = true;
 
-	netdev_connect_common(netdev, target_bss, orig_bss, hs, NULL, 0,
+	netdev_connect_common(netdev, target_bss, orig_bss, hs,
 					event_filter, cb, user_data);
 
 	if (netdev->ap)
diff --git a/src/netdev.h b/src/netdev.h
index f27130f14e56..03d1b6e94dd4 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -155,8 +155,6 @@ struct handshake_state *netdev_get_handshake(struct netdev *netdev);
 
 int netdev_connect(struct netdev *netdev, const struct scan_bss *bss,
 				struct handshake_state *hs,
-				const struct iovec *vendor_ies,
-				size_t num_vendor_ies,
 				netdev_event_func_t event_filter,
 				netdev_connect_cb_t cb, void *user_data);
 int netdev_disconnect(struct netdev *netdev,
diff --git a/src/p2p.c b/src/p2p.c
index e2d752776cb8..08fe8444fbb9 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1555,7 +1555,7 @@ static void p2p_try_connect_group(struct p2p_device *dev)
 	if (dev->conn_peer_capability.group_caps & P2P_GROUP_CAP_IP_ALLOCATION)
 		hs->support_ip_allocation = true;
 
-	r = netdev_connect(dev->conn_netdev, bss, hs, NULL, 0,
+	r = netdev_connect(dev->conn_netdev, bss, hs,
 				p2p_netdev_event, p2p_netdev_connect_cb, dev);
 	if (r < 0) {
 		l_error("netdev_connect error: %s (%i)", strerror(-r), -r);
diff --git a/src/station.c b/src/station.c
index 49cad135eaf0..48a595dcd340 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3453,7 +3453,7 @@ int __station_connect_network(struct station *station, struct network *network,
 	if (!hs)
 		return -ENOTSUP;
 
-	r = netdev_connect(station->netdev, bss, hs, NULL, 0,
+	r = netdev_connect(station->netdev, bss, hs,
 				station_netdev_event,
 				station_connect_cb, station);
 	if (r < 0) {
diff --git a/src/wsc.c b/src/wsc.c
index b063313ac6dc..cda877cf7e6d 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -384,7 +384,7 @@ static int wsc_enrollee_connect(struct wsc_enrollee *wsce, struct scan_bss *bss,
 
 	handshake_state_set_vendor_ies(hs, ie_iov, 1 + ies_num);
 
-	r = netdev_connect(wsce->netdev, bss, hs, NULL, 0,
+	r = netdev_connect(wsce->netdev, bss, hs,
 				wsc_enrollee_netdev_event,
 				wsc_enrollee_connect_cb, wsce);
 	l_free(ie_iov[0].iov_base);
-- 
2.43.0

