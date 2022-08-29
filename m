Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31945C80
	for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 17:36:13 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id m16so11074867wru.9
        for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 10:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=hzMPDc19jTnqYsToQ6LR13UurvQ3Ly7led/rV25ZcV4=;
        b=i1ZnJAVQnKUowiQWvGxdXetVhL3tYYZGFUrH7f14qE/AQ8iJsAReHUdf2EIHymozmn
         sq0eX5U0BE+4yBffi9A5SlRHACI/FAWyq5d3RGtS3NuyLc96CMhS5RkKnOIQ0AunYePB
         6MtA7h3/dyOGilfrSYxDEEvizypaR2sAauqoWg67BBXRrrBb/wuhwBI4llYM7yhKU+zB
         TJvDrQj6/ti0lWP/x6NXEalRs+K50/NSUkper0vy37voZrpTIo7g2NWQUDHy2mpNP9ou
         lsI+lZEbA6IuWu3WlGDPv2Sjz51gbBubPpzIGEtA5aYz3XT5xQzPTPCr5B4CK12SpTVe
         YHUQ==
X-Gm-Message-State: ACgBeo2QBa5MXiSz/IUFw34bUyvRJcWWUopEjJXsRf/0zJ4jq7rgBEDM
	TZtY60pMe+FHe+/PZpokzs2DxGElzmDvBQ==
X-Google-Smtp-Source: AA6agR4/obbEqebGdrTj+Ps5idgWRQ6wD9+1bkr9BO9mvZV+640etgXU86oMJny5p8H/+O9HOhRCYw==
X-Received: by 2002:adf:d1c1:0:b0:220:5ec3:fb62 with SMTP id b1-20020adfd1c1000000b002205ec3fb62mr6855310wrd.69.1661794572012;
        Mon, 29 Aug 2022 10:36:12 -0700 (PDT)
Received: from iss.ger.corp.intel.com ([82.213.228.103])
        by smtp.gmail.com with ESMTPSA id q3-20020a1ce903000000b003a61306d79dsm9830551wmc.41.2022.08.29.10.36.11
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 10:36:11 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 07/10] netconfig: Handle l_netconfig events
Date: Mon, 29 Aug 2022 19:35:58 +0200
Message-Id: <20220829173601.1963953-7-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220829173601.1963953-1-andrew.zaborowski@intel.com>
References: <20220829173601.1963953-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add netconfig_event_handler() that responds to events emitted by
the l_netconfig object by calling netconfig_commit, tracking whether
we're connected for either address family and emitting
NETCONFIG_EVENT_CONNECTED or NETCONFIG_EVENT_FAILED as necessary.

NETCONFIG_EVENT_FAILED is a new event as until now failures would cause
the netconfig state machine to stop but no event emitted so that
station.c could take action.  As before, these events are only
emitted based on the IPv4 configuration state, not IPv6.
---
 src/netconfig-commit.c | 26 ++++++++++++++++++++++
 src/netconfig.c        | 49 +++++++++++++++++++++++++++++++++++++++---
 src/netconfig.h        |  2 ++
 3 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/src/netconfig-commit.c b/src/netconfig-commit.c
index 48ebe847..95b2a9d9 100644
--- a/src/netconfig-commit.c
+++ b/src/netconfig-commit.c
@@ -114,6 +114,32 @@ static void netconfig_commit_done(struct netconfig *netconfig, uint8_t family,
 					enum l_netconfig_event event,
 					bool success)
 {
+	bool connected = netconfig->connected[INDEX_FOR_AF(family)];
+
+	if (!success) {
+		netconfig->connected[INDEX_FOR_AF(family)] = false;
+
+		if (netconfig->notify && family == AF_INET)
+			netconfig->notify(NETCONFIG_EVENT_FAILED,
+						netconfig->user_data);
+		return;
+	}
+
+	switch (event) {
+	case L_NETCONFIG_EVENT_CONFIGURE:
+	case L_NETCONFIG_EVENT_UPDATE:
+		netconfig->connected[INDEX_FOR_AF(family)] = true;
+
+		if (family == AF_INET && !connected && netconfig->notify)
+			netconfig->notify(NETCONFIG_EVENT_CONNECTED,
+						netconfig->user_data);
+
+		break;
+
+	case L_NETCONFIG_EVENT_UNCONFIGURE:
+	case L_NETCONFIG_EVENT_FAILED:
+		break;
+	}
 }
 
 static void netconfig_set_neighbor_entry_cb(int error,
diff --git a/src/netconfig.c b/src/netconfig.c
index 5b7a21ee..91830416 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -414,9 +414,8 @@ bool netconfig_configure(struct netconfig *netconfig,
 	netconfig->notify = notify;
 	netconfig->user_data = user_data;
 
-	/* TODO */
-
-	resolve_set_mdns(netconfig->resolve, netconfig->mdns);
+	if (unlikely(!l_netconfig_start(netconfig->nc)))
+		return false;
 
 	return true;
 }
@@ -449,6 +448,9 @@ bool netconfig_reset(struct netconfig *netconfig)
 	l_netconfig_unconfigure(netconfig->nc);
 	l_netconfig_stop(netconfig->nc);
 
+	netconfig->connected[0] = false;
+	netconfig->connected[1] = false;
+
 	netconfig_free_settings(netconfig);
 	return true;
 }
@@ -499,6 +501,44 @@ void netconfig_handle_fils_ip_resp(struct netconfig *netconfig,
 	netconfig->fils_override = l_memdup(info, sizeof(*info));
 }
 
+static void netconfig_event_handler(struct l_netconfig *nc, uint8_t family,
+					enum l_netconfig_event event,
+					void *user_data)
+{
+	struct netconfig *netconfig = user_data;
+
+	l_debug("l_netconfig event %d", event);
+
+	netconfig_commit(netconfig, family, event);
+
+	switch (event) {
+	case L_NETCONFIG_EVENT_CONFIGURE:
+	case L_NETCONFIG_EVENT_UPDATE:
+		break;
+
+	case L_NETCONFIG_EVENT_UNCONFIGURE:
+		break;
+
+	case L_NETCONFIG_EVENT_FAILED:
+		netconfig->connected[INDEX_FOR_AF(family)] = false;
+
+		/*
+		 * l_netconfig might have emitted an UNCONFIGURE before this
+		 * but now it tells us it's given up on (re)establishing the
+		 * IP setup.
+		 */
+		if (family == AF_INET && netconfig->notify)
+			netconfig->notify(NETCONFIG_EVENT_FAILED,
+						netconfig->user_data);
+
+		break;
+
+	default:
+		l_error("netconfig: Received unsupported l_netconfig event: %d",
+			event);
+	}
+}
+
 struct netconfig *netconfig_new(uint32_t ifindex)
 {
 	struct netdev *netdev = netdev_find(ifindex);
@@ -530,6 +570,9 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 			dhcp_priority = L_LOG_DEBUG;
 	}
 
+	l_netconfig_set_event_handler(netconfig->nc, netconfig_event_handler,
+					netconfig, NULL);
+
 	l_dhcp_client_set_debug(l_netconfig_get_dhcp_client(netconfig->nc),
 				do_debug, "[DHCPv4] ", NULL, dhcp_priority);
 
diff --git a/src/netconfig.h b/src/netconfig.h
index 9f4f3b77..50085aa7 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -27,6 +27,7 @@ struct ie_fils_ip_addr_response_info;
 
 enum netconfig_event {
 	NETCONFIG_EVENT_CONNECTED,
+	NETCONFIG_EVENT_FAILED,
 };
 
 typedef void (*netconfig_notify_func_t)(enum netconfig_event event,
@@ -42,6 +43,7 @@ struct netconfig {
 	bool static_config[2];
 	bool gateway_overridden[2];
 	bool dns_overridden[2];
+	bool connected[2];
 
 	const struct l_settings *active_settings;
 
-- 
2.34.1

