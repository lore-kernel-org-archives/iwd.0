Received: from mail.pappacoda.it (mail.pappacoda.it [128.116.175.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB9B6FA7
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 10:56:58 +0000 (UTC)
Received: from satellite.uninsubria.it (nat-wifi-ateneo-va-70.uninsubria.it [193.206.181.70])
	by mail.pappacoda.it (Postfix) with ESMTPSA id 4DFF63D4D1;
	Thu,  3 Nov 2022 11:56:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pappacoda.it;
	s=20211226; t=1667473015;
	bh=tInfHVqmBzNcGFdWS9RugA8WJPxBxON9ophXeV+Re2Y=;
	h=From:To:Cc:Subject:Date:From;
	b=SW4b3Hq0K37SDJDHTSmnBecIkEGExPbRWvNf5Zf+2Y261djwn8rJ6ithza3nLE+hC
	 PeZaF2zz6L04JQWab9w847suoGNhohQKDzIN0OBAckGLGOIBeTvYzLM2EMHtdy32lD
	 Jjp+umFmZQYPGcguCp0j+/jvBbYwr8DUkSox4XKvfRmDDDR+VQNNUopjX5cVJ9ia7y
	 pJ0D2T6BbmHzvjvWK0HgjN2qE7yRhR7yrxGy4ZkFLX+OCfBNb7T06ZqsL0AqT3bW+P
	 vwvGklIgpN090LYibCoKGq5ZQVF2R+scKwSr4nbWCfNvsur3dR5x+L8MpeCX8oYdxx
	 yhBVRVVWvaF8g==
From: Andrea Pappacoda <andrea@pappacoda.it>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] netconfig: add global MulticastDNS option
Date: Thu,  3 Nov 2022 11:56:38 +0100
Message-Id: <20221103105639.8289-1-andrea@pappacoda.it>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Prestwood <prestwoj@gmail.com>

Adds the MulticastDNS option globally to main.conf. If set all
network connections (when netconfig is enabled) will set mDNS
support into the resolver. Note that an individual network profile
can still override the global value if it sets MulticastDNS.
---
 src/netconfig.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index e6779d7c..8b798e0b 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -56,6 +56,7 @@
  */
 static uint32_t ROUTE_PRIORITY_OFFSET;
 static bool ipv6_enabled;
+static char *mdns_global;
 
 static void do_debug(const char *str, void *user_data)
 {
@@ -396,13 +397,16 @@ send_hostname:
 	}
 
 mdns:
-	if (l_settings_has_key(active_settings, "Network", "MulticastDNS") &&
-			!(mdns = l_settings_get_string(active_settings,
-							"Network",
-							"MulticastDNS"))) {
-		l_error("netconfig: Can't load Network.MulticastDNS");
-		success = false;
-	}
+	/* If the networks has this set take that over the global */
+	if (l_settings_has_key(active_settings, "Network", "MulticastDNS")) {
+		mdns = l_settings_get_string(active_settings, "Network",
+							"MulticastDNS");
+		if (!mdns) {
+			l_error("netconfig: Can't load Network.MulticastDNS");
+			success = false;
+		}
+	} else if (mdns_global)
+		mdns = l_strdup(mdns_global);
 
 	if (mdns && !L_IN_STRSET(mdns, "true", "false", "resolve")) {
 		l_error("netconfig: Bad Network.MulticastDNS value '%s'", mdns);
@@ -753,11 +757,15 @@ static int netconfig_init(void)
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
2.35.1

