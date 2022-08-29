Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4574699
	for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 17:36:11 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id i188-20020a1c3bc5000000b003a7b6ae4eb2so3596864wma.4
        for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 10:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=bWgDuzr1E0y/XP+5VBRXCSVYEWrKFox+H+VE5tzcWlg=;
        b=O6fhQPrxduexHymR9nJbph69WIwHpTnMdt/4aLq6RvG6drMqLVzLlMlbP+RTLiEHc/
         sJGCRgaGvlziK6DIsT/CwD1ivuAW8GbqgPn53rTV5meQ6+oSrWmuIeIeM0Yq5FNQhTyp
         0nPl0u4bN3AMvcvD5M7Qzqzuw5SIzgROOTKnXT9W/mUftcL2YAnS3JzdO02SXFtkQJOE
         Rq8ElCGEWKyRa3XT5POF1ZZ0gZHCwwgowNlYqwaFrbCXjZsGadERUq4NHn4kJalIXsf+
         jBHoazGpBtIr5+tXeCMzFgIAcXRfeVUo8EZdlJs4fs+pFkR/oCPdnOoSL/l6D59qvu0t
         5/Uw==
X-Gm-Message-State: ACgBeo3LSTi1rX/LTEEfq+g3LOEf2Kv3w3PREuVixYzMGS9IEeosmoZP
	Xrbm0TyOAMjlu3HirqPlf+VKr4w6XCbpqQ==
X-Google-Smtp-Source: AA6agR6rJWkG9Egj6fD3J1dgRQPNU/pl8A8QK8UITPA9+TNKXDePrH2gtdQ5ufB7sNfcKcap7epQVA==
X-Received: by 2002:a05:600c:5114:b0:3a6:1ab9:5b3d with SMTP id o20-20020a05600c511400b003a61ab95b3dmr7191111wms.93.1661794569734;
        Mon, 29 Aug 2022 10:36:09 -0700 (PDT)
Received: from iss.ger.corp.intel.com ([82.213.228.103])
        by smtp.gmail.com with ESMTPSA id q3-20020a1ce903000000b003a61306d79dsm9830551wmc.41.2022.08.29.10.36.08
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 10:36:09 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 04/10] netconfig: Clean up netconfig_get_static{4,6}_address
Date: Mon, 29 Aug 2022 19:35:55 +0200
Message-Id: <20220829173601.1963953-4-andrew.zaborowski@intel.com>
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

 * make the error handling simpler,
 * make error messages more consistent,
 * validate address families,
 * for IPv4 skip l_rtnl_address_set_noprefixroute()
   as l_netconfig will do this internally as needed.
 * for IPv6 set the default prefix length to 64 as that's going to be
   used for the local prefix route's prefix length and is a more
   practical value.
---
 src/netconfig.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 98764346..13960c53 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -145,7 +145,7 @@ static void netconfig_set_neighbor_entry_cb(int error,
 static struct l_rtnl_address *netconfig_get_static4_address(
 				const struct l_settings *active_settings)
 {
-	struct l_rtnl_address *ifaddr = NULL;
+	_auto_(l_rtnl_address_free) struct l_rtnl_address *ifaddr = NULL;
 	L_AUTO_FREE_VAR(char *, ip) = NULL;
 	L_AUTO_FREE_VAR(char *, netmask) = NULL;
 	struct in_addr in_addr;
@@ -153,13 +153,22 @@ static struct l_rtnl_address *netconfig_get_static4_address(
 	uint32_t prefix_len;
 
 	ip = l_settings_get_string(active_settings, "IPv4", "Address");
-	if (!ip)
+	if (unlikely(!ip)) {
+		l_error("netconfig: Can't load IPv4.Address");
 		return NULL;
+	}
+
+	if (l_settings_has_key(active_settings, "IPv4", "Netmask") &&
+			!(netmask = l_settings_get_string(active_settings,
+								"IPv4",
+								"Netmask"))) {
+		l_error("netconfig: Can't load IPv4.Netmask");
+		return NULL;
+	}
 
-	netmask = l_settings_get_string(active_settings, "IPv4", "Netmask");
 	if (netmask) {
 		if (inet_pton(AF_INET, netmask, &in_addr) != 1) {
-			l_error("netconfig: Can't parse IPv4 Netmask");
+			l_error("netconfig: Can't parse IPv4.Netmask");
 			return NULL;
 		}
 
@@ -167,14 +176,14 @@ static struct l_rtnl_address *netconfig_get_static4_address(
 
 		if (ntohl(in_addr.s_addr) !=
 				util_netmask_from_prefix(prefix_len)) {
-			l_error("netconfig: Invalid IPv4 Netmask");
+			l_error("netconfig: Invalid IPv4.Netmask");
 			return NULL;
 		}
 	} else
 		prefix_len = 24;
 
 	ifaddr = l_rtnl_address_new(ip, prefix_len);
-	if (!ifaddr) {
+	if (!ifaddr || l_rtnl_address_get_family(ifaddr) != AF_INET) {
 		l_error("netconfig: Unable to parse IPv4.Address");
 		return NULL;
 	}
@@ -182,12 +191,10 @@ static struct l_rtnl_address *netconfig_get_static4_address(
 	broadcast = l_settings_get_string(active_settings, "IPv4", "Broadcast");
 	if (broadcast && !l_rtnl_address_set_broadcast(ifaddr, broadcast)) {
 		l_error("netconfig: Unable to parse IPv4.Broadcast");
-		l_rtnl_address_free(ifaddr);
 		return NULL;
 	}
 
-	l_rtnl_address_set_noprefixroute(ifaddr, true);
-	return ifaddr;
+	return l_steal_ptr(ifaddr);
 }
 
 static struct l_rtnl_address *netconfig_get_static6_address(
@@ -196,12 +203,14 @@ static struct l_rtnl_address *netconfig_get_static6_address(
 	L_AUTO_FREE_VAR(char *, ip);
 	char *p;
 	char *endp;
-	struct l_rtnl_address *ret;
-	uint32_t prefix_len = 128;
+	_auto_(l_rtnl_address_free) struct l_rtnl_address *ret = NULL;
+	uint32_t prefix_len = 64;
 
 	ip = l_settings_get_string(active_settings, "IPv6", "Address");
-	if (!ip)
+	if (unlikely(!ip)) {
+		l_error("netconfig: Can't load IPv6.Address");
 		return NULL;
+	}
 
 	p = strrchr(ip, '/');
 	if (!p)
@@ -222,11 +231,13 @@ static struct l_rtnl_address *netconfig_get_static6_address(
 
 no_prefix_len:
 	ret = l_rtnl_address_new(ip, prefix_len);
-	if (!ret)
-		l_error("netconfig: Invalid IPv6 address %s is "
-				"provided in network configuration file.", ip);
+	if (!ret || l_rtnl_address_get_family(ret) != AF_INET6) {
+		l_error("netconfig: Invalid IPv6 address %s provided in "
+			"network configuration file.", ip);
+		return NULL;
+	}
 
-	return ret;
+	return l_steal_ptr(ret);
 }
 
 static void netconfig_gateway_to_arp(struct netconfig *netconfig)
-- 
2.34.1

