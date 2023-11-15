Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423BF28EC
	for <iwd@lists.linux.dev>; Wed, 15 Nov 2023 00:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FitahZQH"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1f06931e4f7so3928168fac.1
        for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 16:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700006798; x=1700611598; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIeB21Yn2AOV7ZKs1uuikdot7pFXqPWZ9PNzJx6bmA4=;
        b=FitahZQHWZyfG+GO8SJxtGkdDWvs0NzW2hoxeT5lCRxdQ+M9L4qEU6qkpnuKOyCDy0
         z3XjBTeHy+Wi2pVIN5KLVTZkcNQRHI/shUv8e/AjQnU/9hGUVEmBxaD+h3JDnXAXWIn8
         2pcz29r53Q7+lqesRs4AfEahcWNzJwTNAsUuY6XI4WShPoHIWaybYNb7m3ZyPEdKNaXi
         +iNf0WY4y0YK2udGQCEz5HjOkgJiBQnuGrtPC1thsMBl3xJTeh7Kc+hJ9UIZky6RWJxW
         grI9hpT/05SXneGwE/hEspfFbRY9uTcM94cs414wCUKYQ07K6u+4Q1BLcBTqE7b3HhCu
         DUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700006798; x=1700611598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIeB21Yn2AOV7ZKs1uuikdot7pFXqPWZ9PNzJx6bmA4=;
        b=oFdNTFyjTAXB0TifBrJ3tG2r2M8ARvXz03hKmZKslZOgHApB8ch5sugGCoylwaSpGP
         tX7BIyl7exoOHkpVsl0cec16lNWbEDwqtX6Fg3uJjFewcBFsQi7ujXvuVhcVao5AdPeh
         FDP0bOWjhzMreduHht4lQLMwv8Cx74vWosBUqfruu9DFLVsBbC+RkU42xaiEFmGt3Q7O
         IKCkQIN4Xpsc4OSRhqYMCfXQtQo9BEgG7pBIhTPW6DhkRJpGbsBVwKySEPZf/wwM5rEy
         aJcsSfnqMtIYdFBoZVNuOFbLCufKIIxxr9raEMvIFVbGx2NZpaR4rKTdNPMrWBgswBIm
         CLyg==
X-Gm-Message-State: AOJu0YzLtv97xS80RqmQUZzOzIIqXhrDYXo+qAHl2mFg/n/4UO5Ltxa9
	bykhk8C11oOQH57gZRpUD2JvCQD9HU0=
X-Google-Smtp-Source: AGHT+IH5jHlt0iBAxFrx5LIBQW4iP/BhAkETgVdH8+z4NS792ZiT8qQxEYUG8TB9ppGjNzK3vfnbkw==
X-Received: by 2002:a05:6871:2304:b0:1e9:9c34:af67 with SMTP id sf4-20020a056871230400b001e99c34af67mr13211042oab.18.1700006798492;
        Tue, 14 Nov 2023 16:06:38 -0800 (PST)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id pi5-20020a056871d10500b001e578de89cesm1607468oac.37.2023.11.14.16.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 16:06:37 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/3] netdev: Simplify netdev_auth_cb error logic
Date: Tue, 14 Nov 2023 18:05:32 -0600
Message-ID: <20231115000547.1139157-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115000547.1139157-1-denkenz@gmail.com>
References: <20231115000547.1139157-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/netdev.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 4a418b60abcf..327be768d3d9 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3240,25 +3240,22 @@ static void netdev_auth_cb(struct l_genl_msg *msg, void *user_data)
 
 	l_debug("Error during auth: %d", err);
 
-	if (!netdev->auth_cmd || err != -ENOENT) {
-		netdev_connect_failed(netdev,
-					NETDEV_RESULT_AUTHENTICATION_FAILED,
-					MMPDU_STATUS_CODE_UNSPECIFIED);
-		return;
-	}
+	if (!netdev->auth_cmd || err != -ENOENT)
+		goto failed;
 
 	/* Kernel can't find the BSS in its cache, scan and retry */
 	scan_msg = scan_build_trigger_scan_bss(netdev->index, netdev->wiphy,
 						netdev->frequency,
 						hs->ssid, hs->ssid_len);
 
-	if (!l_genl_family_send(nl80211, scan_msg,
-					netdev_scan_cb, netdev, NULL)) {
-		l_genl_msg_unref(scan_msg);
-		netdev_connect_failed(netdev,
-					NETDEV_RESULT_AUTHENTICATION_FAILED,
+	if (l_genl_family_send(nl80211, scan_msg,
+					netdev_scan_cb, netdev, NULL) > 0)
+		return;
+
+	l_genl_msg_unref(scan_msg);
+failed:
+	netdev_connect_failed(netdev, NETDEV_RESULT_AUTHENTICATION_FAILED,
 					MMPDU_STATUS_CODE_UNSPECIFIED);
-	}
 }
 
 static void netdev_new_scan_results_event(struct l_genl_msg *msg,
-- 
2.42.0

