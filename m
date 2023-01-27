Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488AF23A8
	for <iwd@lists.linux.dev>; Fri, 27 Jan 2023 12:31:53 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id m7so4825440wru.8
        for <iwd@lists.linux.dev>; Fri, 27 Jan 2023 04:31:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBKcInhzhWgNvBsCPeoQlhacGoaxH3tkuhYH3c7HItk=;
        b=k9x2xvJjJ4JpxY/u/UT10L8ZTx4ftjvRdGjF6fGJDBPNkmBN9jqGwkst9s2Hi9UK2y
         RqaRNl0DqGiAZOr2m3qbG2sUr4KrK0FUolqXa7x1TL/S+Gq5b4PotaxoRFgZ7ir8zWQW
         JYhiXbSkx2dMR8JJN4mSevJONxmwWeENo2YZPG5L1bIqab1++MYdsNW5L/yBcuj+sH0b
         OY1por/1wEpRTyTISps4nXuPlRUWljDreZfER3XgD+FTO8N4TLuaw49gFWCPheIfpJhT
         3+UcWg3P7dI+7ab+5Anr0J28aP6FkbnOT66cEey604l1TLYBuuo1R/q48WJvVRmLdd5X
         /upQ==
X-Gm-Message-State: AO0yUKXdvjEd392ib7gYW61aYoVRYiX2mXuFT8x8SSA7mJEypji3ES+H
	cPgLbo7+dWcB1VKsHqRixfcEoSCbzeY=
X-Google-Smtp-Source: AK7set9HtNcBsC3Zfgx6qYctJUFlrF4dDU3p6F/YCwXlXH28Es9HWhvldR7auowlpjQFYKBrEVOzew==
X-Received: by 2002:adf:b35e:0:b0:2bf:cab7:cc36 with SMTP id k30-20020adfb35e000000b002bfcab7cc36mr4166526wrd.23.1674822710868;
        Fri, 27 Jan 2023 04:31:50 -0800 (PST)
Received: from localhost.localdomain ([82.213.230.158])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb47000000b002ba2646fd30sm4472161wrs.36.2023.01.27.04.31.49
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 04:31:49 -0800 (PST)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 2/2] station: Add EnableEAPTLSCache bool setting
Date: Fri, 27 Jan 2023 13:31:37 +0100
Message-Id: <20230127123137.3274713-2-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127123137.3274713-1-andrew.zaborowski@intel.com>
References: <20230127123137.3274713-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Seeing that some authenticators can't seem to handle TLS session caching
properly, guard the EAP-TLS-based methods session caching support behind
a global [Network].EnableEAPTLSCache setting.  Defaults to false.

With the previous commit, authentication should succeed at least every
other attempt.  I'd also expect that EAP-TLS is not usually affected
because there's no phase2, unlike with EAP-PEAP/EAP-TTLS.
---
 src/station.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/station.c b/src/station.c
index 7f1a1e24..c92c0d96 100644
--- a/src/station.c
+++ b/src/station.c
@@ -5053,6 +5053,8 @@ static void station_known_networks_changed(enum known_networks_event event,
 
 static int station_init(void)
 {
+	bool eap_tls_cache;
+
 	station_list = l_queue_new();
 	netdev_watch = netdev_watch_add(station_netdev_watch, NULL, NULL);
 	l_dbus_register_interface(dbus_get_bus(), IWD_STATION_INTERFACE,
@@ -5103,6 +5105,11 @@ static int station_init(void)
 
 	watchlist_init(&event_watches, NULL);
 
+	if (!l_settings_get_bool(iwd_get_config(), "Network",
+				"EnableEAPTLSCache", &eap_tls_cache) ||
+			!eap_tls_cache)
+		return 0;
+
 	eap_tls_set_session_cache_ops(storage_eap_tls_cache_load,
 					storage_eap_tls_cache_sync);
 	known_networks_watch = known_networks_watch_add(
-- 
2.34.1

