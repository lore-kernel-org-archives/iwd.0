Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F221829A0
	for <iwd@lists.linux.dev>; Thu, 16 Jun 2022 00:02:42 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id m16-20020a7bca50000000b0039c8a224c95so15845wml.2
        for <iwd@lists.linux.dev>; Wed, 15 Jun 2022 17:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8D2nmdzMJrBSrgVyQQtDZV0hCeQKevElCAaw6IG/wKQ=;
        b=ZMni95/VFH8cZ3j3FR65hAmGK6HkJIJ0oYqLb6bIV13mwWHkgkKAo9Xhnki+r3L6PA
         k7luiNaGS8oYH81W/t53vzH1/SKny4WTCBHlRZRwIzHcjSDuEJ2vsHaioRF3iggtKOP6
         ZUMoLojucer1hHsp/7bzd8HsEDavPuh9tUAW09tN3+XKEUaUSx9ZwD/jkmmHmVozPCmE
         29XtqCdwRXtfMACR/NzmeyGlrpW5apVQXNfch4HXTihJyubhnczA+aQagmu8JbCqp3oC
         c0+9HafqImvYlIn7nhBjWZf+I/9qc7ZXZ4iTG91Ui+pfPhf9UpMNGIEZLRSSpuV4TmfE
         HZiQ==
X-Gm-Message-State: AJIora8g3paCwoN9m/X3+1w1yGuG5pHIY1cWXM1X+Xsxpk2jSjgllF4+
	Dx1c2tO5C6mcNOo+kaSSed6mCEh8uMc=
X-Google-Smtp-Source: AGRyM1tMT9eHuK3qgYEHGilyPVxRqPqVt7qOhMrbySoLK/RB0GeF3bDbgT4Qoulyj5ePfylTNyGNdg==
X-Received: by 2002:a7b:c389:0:b0:39c:49fe:25df with SMTP id s9-20020a7bc389000000b0039c49fe25dfmr1981588wmj.164.1655337760918;
        Wed, 15 Jun 2022 17:02:40 -0700 (PDT)
Received: from iss.Home ([82.213.231.20])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm337452wrb.45.2022.06.15.17.02.39
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:02:40 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 03/15] station: Move netconfig_reset() to common path
Date: Thu, 16 Jun 2022 02:02:19 +0200
Message-Id: <20220616000231.1966008-3-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid repetition, call netconfig_reset in
station_reset_connection_state.
---
 src/station.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/src/station.c b/src/station.c
index 7c88f266..e5972269 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1623,6 +1623,9 @@ static void station_reset_connection_state(struct station *station)
 
 	station_roam_state_clear(station);
 
+	if (station->netconfig)
+		netconfig_reset(station->netconfig);
+
 	/* Refresh the ordered network list */
 	network_rank_update(station->connected_network, false);
 	l_queue_remove(station->networks_sorted, station->connected_network);
@@ -1655,9 +1658,6 @@ static void station_disassociated(struct station *station)
 {
 	l_debug("%u", netdev_get_ifindex(station->netdev));
 
-	if (station->netconfig)
-		netconfig_reset(station->netconfig);
-
 	station_reset_connection_state(station);
 
 	station_enter_state(station, STATION_STATE_DISCONNECTED);
@@ -3096,9 +3096,6 @@ static void station_disconnect_onconnect(struct station *station,
 		return;
 	}
 
-	if (station->netconfig)
-		netconfig_reset(station->netconfig);
-
 	station_reset_connection_state(station);
 
 	station_enter_state(station, STATION_STATE_DISCONNECTING);
@@ -3402,9 +3399,6 @@ int station_disconnect(struct station *station)
 	if (!station->connected_bss)
 		return -ENOTCONN;
 
-	if (station->netconfig)
-		netconfig_reset(station->netconfig);
-
 	/*
 	 * If the disconnect somehow fails we won't know if we're still
 	 * connected so we may as well indicate now that we're no longer
-- 
2.34.1

