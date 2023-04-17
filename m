Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293CA29B0
	for <iwd@lists.linux.dev>; Mon, 17 Apr 2023 18:55:04 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id fy11so1757751qtb.12
        for <iwd@lists.linux.dev>; Mon, 17 Apr 2023 11:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681757703; x=1684349703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/SqCLgIGI0Zp500hnhFpI2+sXE39r/wn28s+l0PZR0=;
        b=aY6GO99rIKWeQzat3UjtxFmV7V7y7bk2yFLxB/AybTGzDvJoyEjhLmywajy551EAdO
         hFZH81QwNfJSVwMHqoWaEihSJm/fZbN7aBSkZM2yIux0pT1r40yxPGCcILpfJwrzUyVx
         bJGBNVFLWdpWWXAJ1HvCNgr31nK74NFqdGlprtcXZzIeeqCeOxJ4IRU1enSbOM/bmbM1
         DUxNLH6aIo4hatVeF/gSBiPxF+OevQoWUPAKckJjq6CHPvbyho+IzLQYL4ZzHLtcbFcX
         9sz6H9TNlTbu57c5r2ZJcaGf3ceszcucg50UQ7+pl+g7+FJu3KG2ECfJEkwgvkFLfHF0
         +BVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681757703; x=1684349703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/SqCLgIGI0Zp500hnhFpI2+sXE39r/wn28s+l0PZR0=;
        b=RJl9jUaRWTTCAJveUhKe5Ts7Vfysl7Wt+6MeKr6VwtpHsVk2atS9WGBruc81j5+P0v
         3qHaujcLBt6U93i+7/xoLPHTE30h5zEmGzfi+xEcXxiha1JJWINYvnWAwvdsns5XWnmt
         kjTkUWipBbCFM9MJk+LRsZgj0wtAXG3BlFSamrX//px57hJxk/uvr0Mg5CQpBUesca1E
         D+D+5fh8KkbJH2cG5zGZLPZYcq6TsjKI8oL44K8Cs2s30EgL425DuLs7dPe7O/SHCSA7
         tEzFIl6ztwk8fe0UnpBRNiq5WaP5SFh/Cbpn0pXsrnFHYb6jDHkxQTGilTIzTitKkFAb
         l/Yg==
X-Gm-Message-State: AAQBX9fUzKB2oQb9CRb1azObbM0GD3PWWn+17bJhGfI1jEzZtZa3b8hL
	O5+54pltP+IQCaqCR3+lsg1bucfqNqU=
X-Google-Smtp-Source: AKy350Yx4/szd56iPImowJ0I5sPUb5U1i9RzyYbZqWSukwZAJmtTquHIDtBkH5kXuKfmBXtWUDriug==
X-Received: by 2002:a05:622a:164e:b0:3e4:eb8f:8a7b with SMTP id y14-20020a05622a164e00b003e4eb8f8a7bmr29749809qtj.29.1681757702910;
        Mon, 17 Apr 2023 11:55:02 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id m8-20020a05620a220800b007468b183a65sm3393300qkh.30.2023.04.17.11.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 11:55:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: delay roam until fully connected
Date: Mon, 17 Apr 2023 11:54:57 -0700
Message-Id: <20230417185457.1000642-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If DHCP/netconfig takes a long time to finish IWD could end up trying
to roam to another BSS. This could happen if the signal strength is
below the set threshold while connecting. Once authenticated to the
AP IWD would get a CQM event and start a roam timer. If DHCP did not
finish before that timer IWD would start a roam. IWD would not handle
this well since a roam doesn't trigger DHCP to start and likely the
network infrustructure would be very confused.

To fix this continue to delay the roam attempt until IWD reaches the
connected state.
---
 src/station.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/station.c b/src/station.c
index dfc23e24..18c37f9c 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2786,6 +2786,22 @@ static void station_roam_trigger_cb(struct l_timeout *timeout, void *user_data)
 	if (station_cannot_roam(station))
 		return;
 
+	/*
+	 * This is unlikely, but can still happen when network configuration is
+	 * enabled and DHCP is slow. If IWD connects to a BSS under the low RSSI
+	 * threshold it will immediately get a CQM event once connected (as far
+	 * as the kernel is concerned, NOT IWD's connected state). This starts
+	 * a 5 second timer and if DHCP has not completed by then IWD will
+	 * roam. Since this would likely confused the APs and IWD its best to
+	 * let DHCP complete i.e. wait until we are in a connected state.
+	 */
+	if (station->state != STATION_STATE_CONNECTED) {
+		l_debug("Tried to roam in unconnected state, will try "
+			"again in 5 seconds");
+		station_roam_timeout_rearm(station, 5);
+		return;
+	}
+
 	station_start_roam(station);
 }
 
-- 
2.25.1

