Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE162C9C
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 22:51:43 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id q1so102800pgl.11
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 15:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeT2wjdacSrAI+WzryC6PfCCbE+OdWiuqpCt+53AIDE=;
        b=YeXTZsToxqBs1QHLpzIYy+s2dD+qYKss00gZJddkdIYGsvBrspJYNbmib2wp61kahU
         R+Kt4tpIqwpGtNyorGtXPOkR2K9/J18/i51D7ysJV45rDZ70vMxQaCEDfS03Gxkg4P9o
         X6WAjPmwmntbJXwbBXCgB5Gcl+RO0pQz5hygiDPwvvc9iuklPajM3jytFhfjSAFH7nwP
         d5YhHcVjRA2/c3dlBK/iGug+64RHMZPMW1ljpEWCbiFHwam+Tkyrstjvb3LgH3oJl0Bd
         8Hszc9d4pjg6d+jSf/yAy/7wV1jS9nVJIa7TaUtz1qXJKckAG2MYZdIZTEc1hDiNWaJm
         EUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeT2wjdacSrAI+WzryC6PfCCbE+OdWiuqpCt+53AIDE=;
        b=JDTD70zIfglpkyyFD3ZDoNbjaO8/jNmZCDlSc8Rtw21y55BBJzsjmCgNNLiVIXQewl
         37vAWXy89GZexMJ769aAz4l4tVdT7cH8FmWCmnh1edmXfA1r6RHznbcw17tND9uk99NK
         7Ci4AFzRdYNpz773htYef+SjgGnJNR3x8ZfY3v0+8dRqJSbNBEWFLOo8ajPwcPp0k9U6
         hnpaALKH9nKSEPWHtXPkzY/gBIeT5DfulCLoDzaT44xPYkIG8cyZeQOdcC8CBU9DChyl
         oSCNCQSpVImJn62Y/u/JJH/TJRW3gwPtZ1NpBGreb7o5aHbnqB/ff6TyqmtTb7onJr/w
         0GMg==
X-Gm-Message-State: ACrzQf2mUCj9kzUohDGtSNPSzYyYvcENhttRwasbHiwenbvMVM++P8A8
	t9c3KnpgBiJl/HU3Zs40+81JqLbLFs4=
X-Google-Smtp-Source: AMsMyM4Ai0RCXXic/grxSRzuqb90BpifWlBVMkSu/rr6WHA6iGDVvxcICZF14F/PCxk+HQM+ImIrOw==
X-Received: by 2002:a05:6a00:8cb:b0:52c:6962:2782 with SMTP id s11-20020a056a0008cb00b0052c69622782mr27098456pfu.81.1667429502231;
        Wed, 02 Nov 2022 15:51:42 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b00186b945c0d1sm8920377plh.2.2022.11.02.15.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:51:41 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 07/11] ap: update Frequency property on started
Date: Wed,  2 Nov 2022 15:51:12 -0700
Message-Id: <20221102225116.297129-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221102225116.297129-1-prestwoj@gmail.com>
References: <20221102225116.297129-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was forgotten when adding the property
---
 src/ap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index 33f2d1e4..9c82a545 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3709,6 +3709,9 @@ static void ap_if_event_func(enum ap_event_type type, const void *event_data,
 		l_dbus_property_changed(dbus_get_bus(),
 					netdev_get_path(ap_if->netdev),
 					IWD_AP_INTERFACE, "Name");
+		l_dbus_property_changed(dbus_get_bus(),
+					netdev_get_path(ap_if->netdev),
+					IWD_AP_INTERFACE, "Frequency");
 		l_dbus_property_changed(dbus_get_bus(),
 					netdev_get_path(ap_if->netdev),
 					IWD_AP_INTERFACE, "PairwiseCiphers");
-- 
2.34.3

