Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D432562
	for <iwd@lists.linux.dev>; Tue, 20 Sep 2022 14:05:30 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id sb3so6388262ejb.9
        for <iwd@lists.linux.dev>; Tue, 20 Sep 2022 07:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KJ9Bt9qAxUP0WWIo9JqEWdY3rypdflORQWrqjkw6iN8=;
        b=UDLm+cup3nY1yk9JViMHhhKwM3eyWm5YNFjFZn1Bjm+ChnEhUPCU+a6aXadb2TAPY6
         +WtNhRfDj9jk86QpkvpkmKzb1ayrm281XZ1rn+PqwUY6lqOkw52yb45CBbLJxdH35gOb
         RIkprH2bwnjYdbh0exvk3mlDrVZkufs2phF0Lel++jdygm1fZg0H6dMHfzKKcw3MHJFe
         Oc4N+67+zvRrZwpuYcOC+SeYDIRrsAGgs5Q2iR4hiOf3iEV69J9D/tvQ1rQd6VppcJcB
         nRQCtxv+vpB9N0qWSHq39+9fPg5i2EtTazw0nsnYetX4vYxCTFMeZlyiziV6JtPzytEB
         Wb9Q==
X-Gm-Message-State: ACrzQf3Z5Piuyyhsi7JMQJNORXbZJK90ck3uP176U624UdAvz4EPFxNn
	gYD+YVfbGoZITPyNiqLCG1SwQ3txRhssrht1
X-Google-Smtp-Source: AMsMyM4Et/g75/bupsHCU1Uhd/YvgTUSxXea/EcrykKfO5M6KL0c/qiKvwXlFez7MOgynacpA5ZajQ==
X-Received: by 2002:a17:907:7b87:b0:781:83bd:cae5 with SMTP id ne7-20020a1709077b8700b0078183bdcae5mr5268520ejc.456.1663682728279;
        Tue, 20 Sep 2022 07:05:28 -0700 (PDT)
Received: from iss.ger.corp.intel.com ([82.213.228.103])
        by smtp.gmail.com with ESMTPSA id 8-20020a170906300800b0077d37a5d401sm947561ejz.33.2022.09.20.07.05.18
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:05:21 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 2/3] netconfig: Update l_netconfig API calls
Date: Tue, 20 Sep 2022 16:05:08 +0200
Message-Id: <20220920140509.3304422-2-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220920140509.3304422-1-andrew.zaborowski@intel.com>
References: <20220920140509.3304422-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since l_netconfig's DHCPv6 client instance no longer sets parameters on
the l_icmp6_client instance, call l_icmp6_client_set_nodelay() and
l_icmp6_client_set_debug() directly.  Also enable optimistic DAD to
speed up IPv6 setup if available.
---
 src/netconfig.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index feb7f87a..c7cc6b1b 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -659,6 +659,7 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 	const char *debug_level = NULL;
 	int dhcp_priority = L_LOG_INFO;
 	struct l_dhcp6_client *dhcp6;
+	struct l_icmp6_client *icmp6;
 
 	l_debug("Creating netconfig for interface: %d", ifindex);
 
@@ -691,12 +692,17 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 
 	dhcp6 = l_netconfig_get_dhcp6_client(netconfig->nc);
 	l_dhcp6_client_set_lla_randomized(dhcp6, true);
-	l_dhcp6_client_set_nodelay(dhcp6, true);
 
-	if (debug_level)
+	icmp6 = l_netconfig_get_icmp6_client(netconfig->nc);
+	l_icmp6_client_set_nodelay(icmp6, true);
+
+	if (debug_level) {
 		l_dhcp6_client_set_debug(dhcp6, do_debug, "[DHCPv6] ", NULL);
+		l_icmp6_client_set_debug(icmp6, do_debug, "[ICMPv6] ", NULL);
+	}
 
 	l_netconfig_set_route_priority(netconfig->nc, ROUTE_PRIORITY_OFFSET);
+	l_netconfig_set_optimistic_dad_enabled(netconfig->nc, true);
 
 	return netconfig;
 }
-- 
2.34.1

