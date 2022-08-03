Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E34A3A
	for <iwd@lists.linux.dev>; Wed,  3 Aug 2022 21:36:50 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so3496347pjf.5
        for <iwd@lists.linux.dev>; Wed, 03 Aug 2022 14:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NPrOgk+lRzRYHdkXs6iWMERE9YQ6TzQ0Sj+Y5N2MMv4=;
        b=OiftZTlBhFRYCdQPFYJteJlZMezwSDAoDZDHs1t49ytTAYiEWAtiZDtZ47yeJOP1Rm
         oFouG81/WbkwxCfZVO7enn9d9AHeH9xzlqqtuwsJf46hojKZjB04lSVr6Xot4LNTszyo
         bxJlS6AfAwliG9PyfGiSV5sqdwCPrOZPRaMKhILJIwpu2nPcHj6U1ZByA2on/ImVU0n1
         waqKEYL+FdGY9GJup6cYw2YpyAKDx3pWFN7yNMrP3nMCl4WDFjGVNbXlBSRxp8UYYa0e
         ZJeiI/Z3TSdBZAFUFTu4yvYSlXO1tHx5S/2Luwx88JpZk4Pjcpr0tep3EZZWMoAq8bvP
         bVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NPrOgk+lRzRYHdkXs6iWMERE9YQ6TzQ0Sj+Y5N2MMv4=;
        b=Wcz0jvikIY11ZnawdkxUr6rIUc11jRn6w2uGzSrI5XwrmKf9MGQeYDUgDa6hfluBSN
         g+Hp3tZ9a+lMcpT3asWrIM8H27OD9wKRtdvq3KV4Df77pmkdrQ42mHeiqfggFOJyi+/b
         igh8vrzE3KqITD2GqlyqUfe/Wh1eMWaWMpJ0vzydAYoyAq8TB1ooksRAwmO+saUX9nla
         xryja81DP9/2uHVZRf+7fxv5QR/C1gHZWEa/CmBscxAuSzdGJvbfo5zfGshuAdvdNxLy
         dNHsNDjhaih9c1Y3C5Pffmwz84777Gdq8urKLvPBriLYUr1m/bGppRPoJwolbQXt6IYz
         JABA==
X-Gm-Message-State: ACgBeo1/TD4ZrxY2HzvQ8gpoWRs0Gckf4EhC5/GbQsdZvY5I9sN+W+VI
	Qgl3GuKq/du2kwHfiN00TGcm1sptoc4=
X-Google-Smtp-Source: AA6agR4GiyRfmXjqh6L15EXoRI5QRnNHyqy5dk+npVQSMTKJrRQSMVBqfH1yzIFldXUR4g2puEi+6Q==
X-Received: by 2002:a17:902:cec4:b0:16d:7d8c:4be with SMTP id d4-20020a170902cec400b0016d7d8c04bemr27068896plg.139.1659562610096;
        Wed, 03 Aug 2022 14:36:50 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id b13-20020a65578d000000b00419fc2c27d8sm11527066pgr.43.2022.08.03.14.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:36:49 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 06/13] wiphy: add two regulatory domain state events
Date: Wed,  3 Aug 2022 14:36:37 -0700
Message-Id: <20220803213644.277534-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220803213644.277534-1-prestwoj@gmail.com>
References: <20220803213644.277534-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Events to indicate when a regulatory domain wiphy dump has
started and ended. This is important because certain actions
such as scanning need to be delayed until the dump has finished.
---
 src/device.c | 2 ++
 src/wiphy.h  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/src/device.c b/src/device.c
index 02da2cdc..d7eb6adb 100644
--- a/src/device.c
+++ b/src/device.c
@@ -282,6 +282,8 @@ static void device_wiphy_state_changed_event(struct wiphy *wiphy,
 			netdev_set_powered(device->netdev, true,
 							NULL, NULL, NULL);
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/src/wiphy.h b/src/wiphy.h
index 9a3b96f9..070c8aea 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -56,6 +56,8 @@ enum {
 enum wiphy_state_watch_event {
 	WIPHY_STATE_WATCH_EVENT_POWERED,
 	WIPHY_STATE_WATCH_EVENT_RFKILLED,
+	WIPHY_STATE_WATCH_EVENT_REGDOM_STARTED,
+	WIPHY_STATE_WATCH_EVENT_REGDOM_DONE,
 };
 
 typedef void (*wiphy_state_watch_func_t)(struct wiphy *wiphy,
-- 
2.34.3

