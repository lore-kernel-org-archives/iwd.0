Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E192C1C36
	for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 17:58:43 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so2225296wmb.2
        for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 10:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDSptWY6xPMULkBE/+56G5d7fxbxyUyHeDL8z4jzk3Y=;
        b=O8i14JuVAhzfYXI3LxU5PbBqzIUQ0wuxDyEDm7/+An5xKdfli6bUOZe9SGTteHexCP
         Szl0q26ap3AjbrgzOJN2ic3CPRhrZam+362oBYXJDSiU/AGkV1h2tzjA9umfqK5p5nSO
         H/Eog6Qrp0qFU8Jlibo5Rjnkvd0cqJtfgdNjjMMaHrnqk27MBRlUQ9NKhUV9iYu0CI0E
         bNTLivNtBmKftBoyNLr4XfrVzF3BBh92PvgrkQgE4LjdhNFjBq5bvEIQKjZErIBWf0tA
         HcWUB5adVIKuOlFOdHyTvtjPr1wlZnUUf/1Vxr1WftuC0TsxnYSXrTma2niGkfk6/3jH
         XEug==
X-Gm-Message-State: ACrzQf3dQBGiTKrBM82raL2IV6LSeAqAM0/zvbfWH0oWL3DBq1ptmvf0
	BcKx9BZ3kGzAwznBQ4J/4HjdphIkfHU=
X-Google-Smtp-Source: AMsMyM7CMGHcLFTrHNJ5Ydr6UMeCNUMRSmYY5REHmknUSMo9vUMHnDe7i0rrdmzmgFqjZfphoF+rSw==
X-Received: by 2002:a1c:770f:0:b0:3c8:33ba:150f with SMTP id t15-20020a1c770f000000b003c833ba150fmr3391014wmi.194.1666807121479;
        Wed, 26 Oct 2022 10:58:41 -0700 (PDT)
Received: from localhost.localdomain ([82.213.230.158])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c304500b003a84375d0d1sm2309679wmh.44.2022.10.26.10.58.39
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 10:58:40 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH] netconfig: Avoid generating events after netconfig_reset
Date: Wed, 26 Oct 2022 19:58:28 +0200
Message-Id: <20221026175828.2435994-2-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221026175828.2435994-1-andrew.zaborowski@intel.com>
References: <20221026175828.2435994-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to l_netconfig track whether IWD's netconfig is active (from
the moment of netconfig_configure() till netconfig_reset()) using a
"started" flag and avoid handling or emitting any events after "started"
is cleared.

This fixes an occasional issue with the Netconfig Agent backend where
station would reset netconfig, netconfig would issue DBus calls to clear
addresses and routes, station would go into DISCONNECTING, perhaps
finish and go into DISCONNECTED and after a while the DBus calls would
come back with an error which would cause a NETCONFIG_EVENT_FAILED
causing station to call netdev_disconnct() for a second time and
transition to and get stuck in DISCONNECTING.
---
 src/netconfig-commit.c |  3 +++
 src/netconfig.c        | 15 +++++++++++++++
 src/netconfig.h        |  1 +
 3 files changed, 19 insertions(+)

diff --git a/src/netconfig-commit.c b/src/netconfig-commit.c
index 0e7c3961..27832b75 100644
--- a/src/netconfig-commit.c
+++ b/src/netconfig-commit.c
@@ -400,6 +400,9 @@ static void netconfig_agent_receive_reply(struct l_dbus_message *reply,
 
 	data->pending_id[INDEX_FOR_AF(cd->family)] = 0;
 
+	if (!cd->netconfig->started)
+		return;
+
 	if (l_dbus_message_get_error(reply, &error, &text)) {
 		success = false;
 		l_error("netconfig agent call returned %s(\"%s\")",
diff --git a/src/netconfig.c b/src/netconfig.c
index c7cc6b1b..e6779d7c 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -507,6 +507,9 @@ static bool netconfig_load_fils_settings(struct netconfig *netconfig,
 bool netconfig_configure(struct netconfig *netconfig,
 				netconfig_notify_func_t notify, void *user_data)
 {
+	if (netconfig->started)
+		return false;
+
 	netconfig->notify = notify;
 	netconfig->user_data = user_data;
 
@@ -521,11 +524,15 @@ bool netconfig_configure(struct netconfig *netconfig,
 	if (unlikely(!l_netconfig_start(netconfig->nc)))
 		return false;
 
+	netconfig->started = true;
 	return true;
 }
 
 bool netconfig_reconfigure(struct netconfig *netconfig, bool set_arp_gw)
 {
+	if (!netconfig->started)
+		return false;
+
 	/*
 	 * Starting with kernel 4.20, ARP cache is flushed when the netdev
 	 * detects NO CARRIER.  This can result in unnecessarily long delays
@@ -558,6 +565,10 @@ bool netconfig_reconfigure(struct netconfig *netconfig, bool set_arp_gw)
 
 bool netconfig_reset(struct netconfig *netconfig)
 {
+	if (!netconfig->started)
+		return false;
+
+	netconfig->started = false;
 	l_netconfig_unconfigure(netconfig->nc);
 	l_netconfig_stop(netconfig->nc);
 
@@ -620,6 +631,10 @@ static void netconfig_event_handler(struct l_netconfig *nc, uint8_t family,
 {
 	struct netconfig *netconfig = user_data;
 
+	/* Once stopped, only commit a final L_NETCONFIG_EVENT_UNCONFIGURE */
+	if (!netconfig->started && event != L_NETCONFIG_EVENT_UNCONFIGURE)
+		return;
+
 	l_debug("l_netconfig event %d", event);
 
 	netconfig_commit(netconfig, family, event);
diff --git a/src/netconfig.h b/src/netconfig.h
index f04899ad..a7921571 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -43,6 +43,7 @@ struct netconfig {
 	bool static_config[2];
 	bool gateway_overridden[2];
 	bool dns_overridden[2];
+	bool started;
 	bool connected[2];
 	char **dns_list;
 	char **domains;
-- 
2.34.1

