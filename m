Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8F263C7
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 18:54:09 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id l6so2563224pjj.0
        for <iwd@lists.linux.dev>; Thu, 03 Nov 2022 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kxvQ43U5ZXUtSxVa6bDBu6cQMjBlOCIiQQ5lh36Ug1k=;
        b=LwtzfeW1IUlrJbnkbycUnn4qMp5ULtlZa09+vcMonOEcccDuP+kH5+PUdHFneJRNox
         zggU/DcmBoHAHYod3jGTf3FBhWj51CEOQb+tCJ1AFVamSQ8Sekaa3XMcyAg2IQrmi1Rz
         tH/wg9Naf2HIIomMgyVZEF3hwPJq14WuMXaBJP9hSRg9gw5YdHcTX/Zp2WXNqibDfgW1
         S0Dx6euw6STh6jsTTaMlPqMs6taQwWyiSO6xtgX9CiU0jEKcMzjYmmH4BfiIbvgO4z4H
         +e749lv6ipgh7lgllto88fkTX6gBRHbBKNci4ceC29BDUNFWQP2BKoVhq78MTVvxBdt+
         CITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxvQ43U5ZXUtSxVa6bDBu6cQMjBlOCIiQQ5lh36Ug1k=;
        b=sHF1DlBzRU+aVQXX2eLvowNvXSA2t6A+9m5vurKGPXMfQ2Y4NStpJgdXUl0D+fDrj3
         7WSWBR24xVJnw612T+933DpflTCFrnPo006D+MV9VbJ5pU8poiQzotrV/nW8FfjPjnVC
         906mLWpVIpym7XhQ7p+ZGPh0fRPaMqZDysMvgNwsGd5bs/ysKMPzGX2Bj/0FLv1anqih
         5rk+iYJpdNRxv5lh0uJcP2aRaNEPSJiUWuc5Fggwfluz+fH55eHNipdZcpev/OSugQks
         KfThPOmplMZ2+FZTy4KKJ+88ex1wyb53Cmglq8LQ6Ghg8uoWj/VSE1Js7Ce88xHcMnGo
         MUMg==
X-Gm-Message-State: ACrzQf3tj2yVyr+l6kqZ/15ka2+hOQwlC1xQ4upTEq72bPwklPmlQ9Mx
	svsal2gHMfZiHcAG+CjoJ0szJhI444w=
X-Google-Smtp-Source: AMsMyM5FnArp3X7OwZtTn1Iajw7c/cH3NATCv49YTqDcnumuGWVPpF7bB7ZKfHguvZSVFSVCdBJhjg==
X-Received: by 2002:a17:90b:3b4a:b0:213:589d:d300 with SMTP id ot10-20020a17090b3b4a00b00213589dd300mr32585122pjb.139.1667501648781;
        Thu, 03 Nov 2022 11:54:08 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id ij5-20020a170902ab4500b00186c37270f6sm1038705plb.24.2022.11.03.11.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:54:08 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] netconfig: add global MulticastDNS option
Date: Thu,  3 Nov 2022 11:54:06 -0700
Message-Id: <20221103185406.385939-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds the MulticastDNS option globally to main.conf. If set all
network connections (when netconfig is enabled) will set mDNS
support into the resolver. Note that an individual network profile
can still override the global value if it sets MulticastDNS.
---
 src/netconfig.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

v2: (version 2 from earlier attached patch)
 * Added better logging to say if it was a global or profile
   value that was invalid.

diff --git a/src/netconfig.c b/src/netconfig.c
index e6779d7c..6e82add3 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -56,6 +56,7 @@
  */
 static uint32_t ROUTE_PRIORITY_OFFSET;
 static bool ipv6_enabled;
+static char *mdns_global;
 
 static void do_debug(const char *str, void *user_data)
 {
@@ -396,19 +397,36 @@ send_hostname:
 	}
 
 mdns:
-	if (l_settings_has_key(active_settings, "Network", "MulticastDNS") &&
-			!(mdns = l_settings_get_string(active_settings,
-							"Network",
-							"MulticastDNS"))) {
-		l_error("netconfig: Can't load Network.MulticastDNS");
-		success = false;
+	/* If the networks has this set take that over the global */
+	if (l_settings_has_key(active_settings, "Network", "MulticastDNS")) {
+		mdns = l_settings_get_string(active_settings, "Network",
+							"MulticastDNS");
+		if (!mdns) {
+			l_error("netconfig: Can't load Network.MulticastDNS");
+			success = false;
+		}
+
+		if (mdns && !L_IN_STRSET(mdns, "true", "false", "resolve")) {
+			l_error("netconfig: Bad profile Network.MulticastDNS "
+				"value '%s'", mdns);
+			success = false;
+		}
+
+		if (!success)
+			goto check_config;
 	}
 
-	if (mdns && !L_IN_STRSET(mdns, "true", "false", "resolve")) {
-		l_error("netconfig: Bad Network.MulticastDNS value '%s'", mdns);
-		success = false;
+	if (!mdns && mdns_global) {
+		mdns = l_strdup(mdns_global);
+
+		if (!L_IN_STRSET(mdns, "true", "false", "resolve")) {
+			l_error("netconfig: Bad global Network.MulticastDNS "
+				"value '%s'", mdns);
+			success = false;
+		}
 	}
 
+check_config:
 	if (!l_netconfig_check_config(netconfig->nc)) {
 		l_error("netconfig: Invalid configuration");
 		success = false;
@@ -753,11 +771,15 @@ static int netconfig_init(void)
 					&ipv6_enabled))
 		ipv6_enabled = false;
 
+	mdns_global = l_settings_get_string(iwd_get_config(), "Network",
+						"MulticastDNS");
+
 	return 0;
 }
 
 static void netconfig_exit(void)
 {
+	l_free(mdns_global);
 }
 
 IWD_MODULE(netconfig, netconfig_init, netconfig_exit)
-- 
2.34.3

