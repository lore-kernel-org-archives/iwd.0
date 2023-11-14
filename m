Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF74175D
	for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKjmiPHE"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1ea98ad294cso2856744fac.3
        for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 09:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699982148; x=1700586948; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2BQm43xKw90Q/cNhuMtYsHcu6I5CUoj4vv8xUqZDtQ=;
        b=gKjmiPHE1cwCiv1UeavYifCZyShIc1E8EAzXcDO2Wz38ToXswizPYctiwS88BjEdE0
         gMJmUa5UdzTn7eXvkJY/O1F9YXF4aDBtSu4dGcqTLqvLw4JKAA0iRvarZdaeK6nrXEAd
         tGjNZhBdyNKZfLvufvdze4jgSwGbTTYpvwPhM0flRAUhNxU/SWCweNFn0Kx7a81FYz2w
         7pz80HxiF7Gv5UXUshlOhC/BsDhp6LmdmiOkEYM6NbyGbY7+CNycIDsOndTIyu2QpVX6
         tjGy2BDvoYuEuWTMlVKcMH+VJnGm6AWZdzBt/+ABnnk6XRNfKAkXiMzOJR8sYlZH/L/G
         sjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699982148; x=1700586948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2BQm43xKw90Q/cNhuMtYsHcu6I5CUoj4vv8xUqZDtQ=;
        b=n1zkvwBlP4Bw3ylkheTm6PuJXxiMmV8hDqP43tsH91cAGz/Uch7dJs1SXOAEFOeLhG
         CiN6W4jclnG+xH/h3CAzEmZWvAl3CXnSns316B2ucdevbG2zr3zNA2eYLD8cKKUrdbKg
         1t799FsKiNRsbs99PRIz/8YcEcT6DshQAP3E2qAIRLT/QUm+Ih35jTjp1Z6CP4BcdyBB
         VLFguAuAcLB1ttDbfuKe2rNOKGMIhqhepGNseXVt3CBZ6g4T4/PSMS/cBaQjVdV8f4+7
         b2nD1DzC4HcWVpMglwFzWx/YP6MFuXYOlxnwkVpBhqqPNYIIfDQmUgfw4HNQGsoCbYzV
         FQbQ==
X-Gm-Message-State: AOJu0YzfPQSmWL0+53yoRHTuiZFeXCax5b8K6JK5Wl23gwpIKBPxZIdx
	WA6sxmWyjC5zQBNgexnOH3AKQWtx87Q=
X-Google-Smtp-Source: AGHT+IHdxFMvRz0Q6zOrg7c1ZAhn27bd+GWPAMVmPqOqJCTWGv/d70FxFnKOQAbYue1h0etaNGc00A==
X-Received: by 2002:a05:6871:4308:b0:1f4:d069:cae9 with SMTP id lu8-20020a056871430800b001f4d069cae9mr10502996oab.32.1699982147455;
        Tue, 14 Nov 2023 09:15:47 -0800 (PST)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id o4-20020a05687072c400b001e9a253afa3sm1429647oak.49.2023.11.14.09.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 09:15:47 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 04/11] netdev: Don't unnecessarily call netdev_connect_failed
Date: Tue, 14 Nov 2023 11:14:27 -0600
Message-ID: <20231114171455.1108856-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114171455.1108856-1-denkenz@gmail.com>
References: <20231114171455.1108856-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev_begin_connection() already invokes netdev_connect_failed on
error.  Remove any calls to netdev_connect_failed in callers of
netdev_begin_connection().

Fixes: 4165d9414f54 ("netdev: use wiphy radio work queue for connections")
---
 src/netdev.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index ebb93a74d8aa..6792bb5601e2 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3605,19 +3605,16 @@ static void netdev_mac_change_failed(struct netdev *netdev, int error)
 		WATCHLIST_NOTIFY(&netdev_watches, netdev_watch_func_t,
 				netdev, NETDEV_WATCH_EVENT_DOWN);
 
-		goto failed;
-	} else {
-		/* If the interface is up we can still try and connect */
-		l_info("Failed to change the MAC, continuing with connection");
-		if (netdev_begin_connection(netdev) < 0)
-			goto failed;
-
+		netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
+				MMPDU_STATUS_CODE_UNSPECIFIED);
 		return;
 	}
 
-failed:
-	netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
-				MMPDU_STATUS_CODE_UNSPECIFIED);
+	/* If the interface is up we can still try and connect */
+	l_info("Failed to change the MAC, continuing with connection");
+
+	if (netdev_begin_connection(netdev) < 0)
+		l_error("netdev_begin_connection() error in mac_change_failed");
 }
 
 static void netdev_mac_destroy(void *user_data)
@@ -3649,14 +3646,9 @@ static void netdev_mac_power_up_cb(int error, uint16_t type,
 		return;
 	}
 
-	/*
-	 * Pick up where we left off in netdev_connect_commmon.
-	 */
-	if (netdev_begin_connection(netdev) < 0) {
-		l_error("Failed to connect after changing MAC");
-		netdev_connect_failed(netdev, NETDEV_RESULT_ASSOCIATION_FAILED,
-				MMPDU_STATUS_CODE_UNSPECIFIED);
-	}
+	/* Pick up where we left off in netdev_connect_commmon */
+	if (netdev_begin_connection(netdev) < 0)
+		l_error("netdev_begin_connection() error in mac_power_up_cb");
 }
 
 static void netdev_mac_power_down_cb(int error, uint16_t type,
@@ -3870,7 +3862,7 @@ static bool netdev_connection_work_ready(struct wiphy_radio_work_item *item)
 	}
 
 	if (netdev_begin_connection(netdev) < 0)
-		goto failed;
+		return true;
 
 	return false;
 
-- 
2.42.0

