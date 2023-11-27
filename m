Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE891FD2
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 02:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzIdZ9+0"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1fa48ad4e99so310722fac.3
        for <iwd@lists.linux.dev>; Sun, 26 Nov 2023 18:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701053651; x=1701658451; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWYMheTM/ZJX7EY/T+aPkHmPK3FmlL40bmmZ7iRpg9Q=;
        b=AzIdZ9+037fnyT8C6Pn8tSeNdaEB5IZbWPq58hJVi2VAWRJKdRZOYeC5Yhs7XPri7R
         bp/SPGxlwK0HJH1oIqbcrO3stWP9o2S4WoHoYCdpkQG1/WVPr6iGC5HoxI7PJVGuQvLM
         yPVt5Kyvf+Y0ZSUK/MOfV8hdHfUpuBEmel8KWvPwM8fTP4qsd3LnVNoJ4UxZNazu6odu
         Pf3d+vDSDPPY184tdGfHzpaMbU4T/ssKvUSUj462JBENqgFgzFAdw0S2PjqegvyVuykT
         yesMk/ijcaWJGV0ZHefRLc3tqeTj0LzSxPjKBqUpC+5cOSvVauV6ViUD+tekmHM01d8u
         VC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701053651; x=1701658451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWYMheTM/ZJX7EY/T+aPkHmPK3FmlL40bmmZ7iRpg9Q=;
        b=QkzstqwD4uZciNDlj3qpDG4j8bGR5GzkQRF0Z8yGKBN8nSq1t3xNKgPwYE/QLmVw0Z
         H+EHJ8vMRXeNXz8j2vSNfuEw/o5pfwQQ3uK7PwLr3AUt8WArb79nE+wtDqdcWylxk8gy
         kJUf5ELQy+xc2dlhRnphjm5xpzpH2F4qncmKtTZgLJ1QBscyFyuNvJ/AgdLcLNtvmWq3
         6SLbU4RMD5S/PthJVZadu5VCotDghPZMG4aExJfOu/ihikMxkekvRLoh+1b1i5FacM8M
         j1kzvhYiEYf7V6BNlHRZNDc9XTgbqdtU2X1rJ8mKLBRlkgtb+GorWHscrgBUjFdOe0i2
         UT6g==
X-Gm-Message-State: AOJu0Yz1DCrpxPOiIjhz4YtoUgB52yZPLfHrqZoQYLQn0GbmbGl3iL4I
	6dk5ishaKoYGtmrYs9tVbvThAZRhMxM=
X-Google-Smtp-Source: AGHT+IF6ALdEMXBYoeJ7CIdHufJywPi/IufSa7Prm6dEraQzJwnXm0HtasGrF4WkX325yQQF9bOmpQ==
X-Received: by 2002:a05:6870:6b8c:b0:1fa:56f:42cd with SMTP id ms12-20020a0568706b8c00b001fa056f42cdmr12523931oab.25.1701053650941;
        Sun, 26 Nov 2023 18:54:10 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id ti3-20020a056871890300b001f9e3731545sm1818846oab.11.2023.11.26.18.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 18:54:10 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/6] netdev: Do not leak l_genl_msg on error
Date: Sun, 26 Nov 2023 20:53:01 -0600
Message-ID: <20231127025320.1310543-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127025320.1310543-1-denkenz@gmail.com>
References: <20231127025320.1310543-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In netdev_retry_owe, if l_gen_family_send fails, the connect_cmd is
never freed or reset.  Fix that.

While here, use a stack variable instead of netdev member, since the use
of such a member is unnecessary and confusing.
---
 src/netdev.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index e7b502b1c3ba..03f9a77324db 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2561,10 +2561,12 @@ static void netdev_cmd_connect_cb(struct l_genl_msg *msg, void *user_data)
 
 static bool netdev_retry_owe(struct netdev *netdev)
 {
+	struct l_genl_msg *connect_cmd;
+
 	if (!owe_next_group(netdev->owe_sm))
 		return false;
 
-	netdev->connect_cmd = netdev_build_cmd_connect(netdev,
+	connect_cmd = netdev_build_cmd_connect(netdev,
 					netdev->handshake, NULL, NULL, 0);
 
 	netdev->connect_cmd_id = l_genl_family_send(nl80211,
@@ -2572,12 +2574,11 @@ static bool netdev_retry_owe(struct netdev *netdev)
 						netdev_cmd_connect_cb, netdev,
 						NULL);
 
-	if (!netdev->connect_cmd_id)
-		return false;
-
-	netdev->connect_cmd = NULL;
+	if (netdev->connect_cmd_id > 0)
+		return true;
 
-	return true;
+	l_genl_msg_unref(connect_cmd);
+	return false;
 }
 
 static void netdev_connect_event(struct l_genl_msg *msg, struct netdev *netdev)
-- 
2.42.0

