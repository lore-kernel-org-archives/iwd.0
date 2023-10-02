Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305B2EAD4
	for <iwd@lists.linux.dev>; Mon,  2 Oct 2023 11:32:18 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-690d8c05784so13140528b3a.2
        for <iwd@lists.linux.dev>; Mon, 02 Oct 2023 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696246338; x=1696851138; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xX/iobfmey4exNB3kT6/Lf7fwyLVnqcq1DWTuZKDNvE=;
        b=VD0iGSLYSBAR/4lXft6LKZF6vNSWqOv6BV5t9u0ZBpqAQcUdBIgwJd2gtUQSV6b8Rt
         h2DeHKrjzbEhD5PkYH92h5VveYF2C9c/Lno0LJrBANdb07KmOC+Q4QfXY9H88g8PsQDh
         L0qt3jU66+glh2JW67IFDv59W7MIq4JZ86iQeJzkiJkT8z2ATx6aiJkIzuUBqU6LgBaB
         5ikofAb2D0CYvbPzb2wdV8LO1+B4MDDlZym5FJp3ly11CWQ+pcKQjiPhW2dQmpuPSDR/
         MjKFl4Wcx/bzVhR84nRH6cGZCBbe7py7eQkOvXXy7Bs3QQf57W/qeAFVdRIZZiOgiWqa
         JGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696246338; x=1696851138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xX/iobfmey4exNB3kT6/Lf7fwyLVnqcq1DWTuZKDNvE=;
        b=juTlMBmxk4sseoEnOS+goN1VtH2rFWjoheoaRDqNMgg7NOAw0fllDy6ijfLDhNxCsJ
         GqfQtPWm2dTPaRxJYEWsH/WURP6AKZfZDGAWtA6ECNgOCiZH8BIDCYZu0PJz5V54wX4J
         VgQ9cRWu1pfMOi3BiHT9OSJmxQRfloa7/tWkyfiYGu6mHyb5Mp9sxOWf5yath2DGDLe6
         q1wKBEf/QzN8GgrCSgB75TXcu+ztD7AjRT5i7s0DxtChNOseE6zjwrVk4P5mQ6Rx9vmA
         dCVkkraJ2p8eJtBXg1tyPgkijar9+5LdfQN+4OMO6HH8FXMBeldQbdgpWdWs12bOBesl
         +vvw==
X-Gm-Message-State: AOJu0YzueKXkqwe+LHPA/IYqyChbXAGeQMBK6V6EZqylvs+feEh5SzX6
	c1W1ifgPUbhtcTrNRBgdOOVf3kNKT8M=
X-Google-Smtp-Source: AGHT+IFt8P2aG8HJxyvlmthTz50Qa1Wy9a9YZRMbKYIbgfxXeL/gwKSf/Nqkdf90wSJ71/iRxPxzuA==
X-Received: by 2002:a05:6a20:5490:b0:161:5ea5:fc0b with SMTP id i16-20020a056a20549000b001615ea5fc0bmr11534243pzk.16.1696246338158;
        Mon, 02 Oct 2023 04:32:18 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id b124-20020a633482000000b00563df2ba23bsm18833212pga.50.2023.10.02.04.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 04:32:17 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: check disabled band configuration in station_init
Date: Mon,  2 Oct 2023 04:32:13 -0700
Message-Id: <20231002113213.3852482-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For IWD to work correctly either 2.4GHz or 5GHz bands must be enabled
(even for 6GHz to work). Check this and don't allow IWD to initialize
if both 2.4 and 5GHz is disabled.
---
 src/station.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/src/station.c b/src/station.c
index a34d8ce3..f24b9aca 100644
--- a/src/station.c
+++ b/src/station.c
@@ -5203,6 +5203,19 @@ static void station_known_networks_changed(enum known_networks_event event,
 
 static int station_init(void)
 {
+	if (scan_get_band_rank_modifier(BAND_FREQ_2_4_GHZ))
+		allowed_bands |= BAND_FREQ_2_4_GHZ;
+	if (scan_get_band_rank_modifier(BAND_FREQ_5_GHZ))
+		allowed_bands |= BAND_FREQ_5_GHZ;
+	if (scan_get_band_rank_modifier(BAND_FREQ_6_GHZ))
+		allowed_bands |= BAND_FREQ_6_GHZ;
+
+	if (!(allowed_bands & (BAND_FREQ_2_4_GHZ | BAND_FREQ_5_GHZ))) {
+		l_error("At least 2.4GHz and 5GHz bands must be enabled for "
+			"IWD to start, check [Rank].BandModifier* setting");
+		return -ENOTSUP;
+	}
+
 	station_list = l_queue_new();
 	netdev_watch = netdev_watch_add(station_netdev_watch, NULL, NULL);
 	l_dbus_register_interface(dbus_get_bus(), IWD_STATION_INTERFACE,
@@ -5259,13 +5272,6 @@ static int station_init(void)
 						station_known_networks_changed,
 						NULL, NULL);
 
-	if (scan_get_band_rank_modifier(BAND_FREQ_2_4_GHZ))
-		allowed_bands |= BAND_FREQ_2_4_GHZ;
-	if (scan_get_band_rank_modifier(BAND_FREQ_5_GHZ))
-		allowed_bands |= BAND_FREQ_5_GHZ;
-	if (scan_get_band_rank_modifier(BAND_FREQ_6_GHZ))
-		allowed_bands |= BAND_FREQ_6_GHZ;
-
 	return 0;
 }
 
-- 
2.25.1

