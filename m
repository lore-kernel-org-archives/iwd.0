Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5D015A8
	for <iwd@lists.linux.dev>; Thu, 22 Dec 2022 02:42:13 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id y8so306269wrl.13
        for <iwd@lists.linux.dev>; Wed, 21 Dec 2022 18:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j8r8EoVDMn07xMqsm7z8L+dbQ1XpxvtGCkPPbEunO/4=;
        b=YLJRS7jZKxlAma4uFi/mNnqdJcKJg+C0RoF+mwDq+pPys32WlICE6PaUxKD0LATQE5
         3irxeMEAMmDRT1pwItTNDEFPaypSxrl4+P/YFXDhMCDPJEq7xv5wS3oyeEcyoMHdYgSJ
         QWMqLYNXg68Rd7qxMbHVtRz3yIjPjbnje6OWk/UK/iBl7hBTFw21B3aksTWjPfr34zDh
         HPvqYP5aCVqNCpZGY6G+b/A7Y+Zgh0fht1QuIRi/2x3RhC8+qsWxegra4Uc9kwih70nV
         +JPRczw49SsTWEv7TXhVBTbjo2DiSmkrVSoY/fZCEFeKu42on+nJ0HDU4FmeNMf++GXN
         xBug==
X-Gm-Message-State: AFqh2krIwKmb4B0bToAU9SZ//oAXFAFpAWNK0gAuHq9ueEm3irxoQ4TZ
	GrGMokifTbHWdWBeK/RbYOiCvSfkx2yVyg==
X-Google-Smtp-Source: AMrXdXtY35yNqC9MYu64E/MjgOQ8ik5QnDMjrP1Qsj+OK0RX4DaHtxEUBKzgtjAhDjFD5iW9uk0rWw==
X-Received: by 2002:a05:6000:70a:b0:263:542c:5918 with SMTP id bs10-20020a056000070a00b00263542c5918mr2720632wrb.38.1671676930947;
        Wed, 21 Dec 2022 18:42:10 -0800 (PST)
Received: from localhost.localdomain ([82.213.230.158])
        by smtp.gmail.com with ESMTPSA id p3-20020adfce03000000b00241bd177f89sm16267161wrn.14.2022.12.21.18.42.09
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 18:42:09 -0800 (PST)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH] netconfig: Don't load settings in netconfig_new
Date: Thu, 22 Dec 2022 03:41:43 +0100
Message-Id: <20221222024143.632455-1-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the l_netconfig_set_route_priority() and
l_netconfig_set_optimistic_dad_enabled() calls from netconfig_new, which
is called once for the l_netconfig object's lifetime, to
netconfig_load_settings, which is called before every connection attempt.
This is needed because we clean up the l_netconfig configuration by calling
l_netconfig_reset_config() at different points in connection setup and
teardown so we'd reset the route priority that we've set in netconfig_new,
back to 0 and never reload it.
---
 src/netconfig.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 6e82add3..d81f8b4c 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -413,7 +413,7 @@ mdns:
 		}
 
 		if (!success)
-			goto check_config;
+			goto route_priority;
 	}
 
 	if (!mdns && mdns_global) {
@@ -426,7 +426,10 @@ mdns:
 		}
 	}
 
-check_config:
+route_priority:
+	l_netconfig_set_route_priority(netconfig->nc, ROUTE_PRIORITY_OFFSET);
+	l_netconfig_set_optimistic_dad_enabled(netconfig->nc, true);
+
 	if (!l_netconfig_check_config(netconfig->nc)) {
 		l_error("netconfig: Invalid configuration");
 		success = false;
@@ -734,9 +737,6 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 		l_icmp6_client_set_debug(icmp6, do_debug, "[ICMPv6] ", NULL);
 	}
 
-	l_netconfig_set_route_priority(netconfig->nc, ROUTE_PRIORITY_OFFSET);
-	l_netconfig_set_optimistic_dad_enabled(netconfig->nc, true);
-
 	return netconfig;
 }
 
-- 
2.34.1

