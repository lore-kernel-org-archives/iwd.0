Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4323A1B6
	for <iwd@lists.linux.dev>; Mon, 18 Dec 2023 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW3FVgCa"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-67f33cf014cso15354996d6.0
        for <iwd@lists.linux.dev>; Mon, 18 Dec 2023 06:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702908774; x=1703513574; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MBVDdlyHnnA0wXrMujX4B4p2w87HUn+cZPW+6YI8iRk=;
        b=DW3FVgCaF5tOzLP9wakuqpFbeMwI0ixebZ2P0RbZOaSbpEpirqPf0jv0fPMsf7c2G1
         SBT0AgIAiC2gIAukLfkwfPTPj9i73mh4Mvzgu6xs+U+kyXrbqzodJ1necC27Is74gUMW
         YT/yDMGJx+2XqH+b093Jp1U7I5V3L6Y3xJfWOOtSwm0E9ELIKuzO9XN0thAiPpMSUCp5
         CU+L9RqjrcSe4lNH8R0xRVTXxAZ7qU2HWs8JK+d0H5nMFTXGfGcLjXI6b0HfoeYxV7KW
         R/BPuGSUP/vsRBQpsTnX4+1ftJJb/PDih2Qh1UAvZyRLr6qvBkkER5d5a+fqypOC9tp7
         dT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702908774; x=1703513574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBVDdlyHnnA0wXrMujX4B4p2w87HUn+cZPW+6YI8iRk=;
        b=xSaaVPV3EM+aqw8R6Rd6kQozZ+cR37Eam4gWh63kS7FPpwcf00gqNpXRS7SAS5449J
         EmH8b4tK8zi9F7gGQVRsBYxEe10tyGgkONIpQb2PGxdf3BtBUSdv2U1bwL6y9JRH3vSd
         c8o2DDHh/UaSHhu1Mnn+hilRyDZErStxJyTm3gZDiaQ/u72ylF8juq2emCKCl2e2TJnw
         Rxvju3ZnkBtgjpsABaAKKF3vyDomg+O8TMbVN4K3cLDTKEPym3lMJgydz1u3G9fNJEjz
         7nNQMCqMvRd4XF3JAdAnCYx2BGNJ1qqXVY4O3nQI9lJawQRERBC7XzmtPGhraw61AVVV
         OJFA==
X-Gm-Message-State: AOJu0Yw4nayvMCAY18GovYC5got5CTosVHUBYOrsPKyC6TWs6Ups00SO
	wXcdFgjhr/zHQO7jLwR4FwoNXek0SHY=
X-Google-Smtp-Source: AGHT+IEl+S5IbdWwH1v/+n2pW2K1BWFddQjF+cmy4OofON6US1c9fLx5ynHV7YwzArP0TGz9kzFQ0A==
X-Received: by 2002:a05:6214:40c:b0:67a:a721:f32d with SMTP id z12-20020a056214040c00b0067aa721f32dmr22808571qvx.109.1702908773618;
        Mon, 18 Dec 2023 06:12:53 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id b2-20020a0cbf42000000b0067ec8702d1dsm7816355qvj.137.2023.12.18.06.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 06:12:53 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] knownnetworks: network: support updating known network settings
Date: Mon, 18 Dec 2023 06:12:47 -0800
Message-Id: <20231218141250.202157-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a known network is modified on disk the settings are not
reloaded by network. Only disconnecting/reconnecting to the network
would update the settings. This poses an issue to DPP since its
creating or updating a known network after configuration then trying
to connect. The connection itself works fine since the PSK/passphrase
is set to the network object directly, but any additional settings
are not updated.

To fix this add a new UPDATED known network event. This is then
handled from within network and all settings read from disk are
applied to the network object.
---
 src/knownnetworks.c |  4 ++++
 src/knownnetworks.h |  1 +
 src/network.c       | 27 ++++++++++++++++++++++++---
 3 files changed, 29 insertions(+), 3 deletions(-)

v2:
 * Instead of bothering with individual settings we can just use the
   new l_settings object. This would still prefer agent-obtained creds
   set into the network object but also honor any new settings written
   to the profile if there is an ongoing connection. This is a much
   simpler approach (unless I'm missing something). Only questionable
   piece is what to do with the Security group. I hesitate to skip it
   because its what we have on disk, but it could mean the network
   object isn't synced with its settings. But I'm not sure this is
   any different than what we have today, if a profile is modified
   during an ongoing connection its settings (including security)
   won't get updated until a disconnect/reconnect.

 * Remove frequency sync on UPDATED event

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index d4d50a6f..04ce74ec 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -468,6 +468,10 @@ void known_network_update(struct network_info *network,
 	known_network_set_autoconnect(network, new->is_autoconnectable);
 
 	memcpy(&network->config, new, sizeof(struct network_config));
+
+	WATCHLIST_NOTIFY(&known_network_watches,
+				known_networks_watch_func_t,
+				KNOWN_NETWORKS_EVENT_UPDATED, network);
 }
 
 bool known_networks_foreach(known_networks_foreach_func_t function,
diff --git a/src/knownnetworks.h b/src/knownnetworks.h
index 0a5c9e25..e8ffac0b 100644
--- a/src/knownnetworks.h
+++ b/src/knownnetworks.h
@@ -35,6 +35,7 @@ struct network_info;
 enum known_networks_event {
 	KNOWN_NETWORKS_EVENT_ADDED,
 	KNOWN_NETWORKS_EVENT_REMOVED,
+	KNOWN_NETWORKS_EVENT_UPDATED,
 };
 
 struct network_info_ops {
diff --git a/src/network.c b/src/network.c
index 3918ae08..f19482d8 100644
--- a/src/network.c
+++ b/src/network.c
@@ -2001,7 +2001,8 @@ static void network_update_hotspot(struct network *network, void *user_data)
 	match_hotspot_network(info, network);
 }
 
-static void match_known_network(struct station *station, void *user_data)
+static void match_known_network(struct station *station, void *user_data,
+				bool new)
 {
 	struct network_info *info = user_data;
 	struct network *network;
@@ -2011,7 +2012,14 @@ static void match_known_network(struct station *station, void *user_data)
 		if (!network)
 			return;
 
-		network_set_info(network, info);
+		if (new)
+			network_set_info(network, info);
+
+		if (network->settings)
+			l_settings_free(network->settings);
+
+		network->settings = network_info_open_settings(info);
+
 		return;
 	}
 
@@ -2019,17 +2027,30 @@ static void match_known_network(struct station *station, void *user_data)
 	station_network_foreach(station, network_update_hotspot, info);
 }
 
+static void add_known_network(struct station *station, void *user_data)
+{
+	match_known_network(station, (struct network_info *)user_data, true);
+}
+
+static void update_known_network(struct station *station, void *user_data)
+{
+	match_known_network(station, (struct network_info *)user_data, false);
+}
+
 static void known_networks_changed(enum known_networks_event event,
 					const struct network_info *info,
 					void *user_data)
 {
 	switch (event) {
 	case KNOWN_NETWORKS_EVENT_ADDED:
-		station_foreach(match_known_network, (void *) info);
+		station_foreach(add_known_network, (void *) info);
 
 		/* Syncs frequencies of newly known network */
 		known_network_frequency_sync((struct network_info *)info);
 		break;
+	case KNOWN_NETWORKS_EVENT_UPDATED:
+		station_foreach(update_known_network, (void *) info);
+		break;
 	case KNOWN_NETWORKS_EVENT_REMOVED:
 		station_foreach(emit_known_network_removed, (void *) info);
 		break;
-- 
2.34.1

