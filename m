Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB231D5CFF
	for <iwd@lists.linux.dev>; Tue,  5 Nov 2024 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730812267; cv=none; b=PASQ9SwUUnzxlN97DcZdqYTXROlxc+KmRNoE1Xj71b1U2AgcjDQk/wqP1aRmHch/XNjKa0mLEfu+J/27qMKdiYg2XlSY3SM2yU3HOF1Pr8E+WAxbJpGOMGd7kJV1o0c8KLkPqkXJMLweAQzfB3+AbTBNoTEaJe+XE59oza7hRVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730812267; c=relaxed/simple;
	bh=JLvT18ZQ88Ifehk+w8lIqtt/Gn+j/3HXWEN/FkkOAsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V2v8ulwLDw93RmYL9QPl/xBZ7/M1H4EM/DQ6SlT+jM8iyt8/Per1NH/aM8Wp2e29VI+kUtbIVw80Rb+SilG6rDsjgpcnjKxgITHMASNmhsvgAvT0hYc/MsG6jKid1Q2x/bt3BVU1buLjmU8JWuxcVDkJWLdow/XZQYI5obJ0ajY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=my4i7e9y; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="my4i7e9y"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e5fef69f2eso2884366b6e.3
        for <iwd@lists.linux.dev>; Tue, 05 Nov 2024 05:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730812264; x=1731417064; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mG93a93A0HeBWRUVLc4MEprXzPFPFUEYS5zRNy8Te/M=;
        b=my4i7e9yZNwaP580lAm6bKbVwfRNdzsKmduLXJoSw+PH7+iS/+bNsAPXJXNJb1yvHO
         Gvuz6x76CPQ/H3ygDeNXKum+NyEzlPPZMjuQUSxCxVCTdWXvTICfpTYqGv2L3Evr5QKO
         dsYRlP4pVFbMGR/JxTJOovuASNDxsE6Vevd63ruSmGPs6D0eN1Qm0iMN9oQVvH+2rAW2
         G3DYUMZaOofi1uqYYMI4ga2AjCXafyz0DYioZXkooWCJRc7JIQJFFs2Otp1v4U3HpEdH
         mLrTUU994JQvbat5gS2zVEh4TxUDd5IHhaid3y4RNzTH/2+sunweo6ntoUj6Wr99r3Np
         bAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730812264; x=1731417064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mG93a93A0HeBWRUVLc4MEprXzPFPFUEYS5zRNy8Te/M=;
        b=D0pIdBMWPnJYUpBPaYHgT4m+dn26BVOW6ahbE99C7eswlzjbaD2YXn1h99cVmZEZ1C
         duXlURYaRfdLVVLljsZy8D4+T9x7/ztxeip18Gd6lPmCgAvDBcE75xSNXqfwdVS1PvEu
         42W0qxtDj/kevko7ZrssencBujyHIvvL8b4E4zA9P/LX+r7KFaTJsr+WVfwn2acD05iE
         6gOlS3J8sKCkrPWY7MkRNVzasLK4zLDFG4XawuU0sN+D3LMnG2cmc41MnFFvS5ZrvlcO
         OO/94KHSRZkQ1vNIEiurnVzmY868r5gpJJUdwVDdQb9T8nOfIUd/7GohcWEnB5x1603s
         S8Vg==
X-Gm-Message-State: AOJu0YxHFNG2E6vNuO9lwr48gAiM76GFnpYjWlj7Wzge1CYKCZA+q83L
	vyMxbaft62e0yoNeBhHJx0Q8rEH+004tqbKvc9TWZEVnK82ZSungcQ5vSA==
X-Google-Smtp-Source: AGHT+IHEdmRpRvYVj9bpzES1v/9I1x37y2X8Vg0qVcPP5jPzp05NoZ1yl44dAnqDubsIvugxTs0aog==
X-Received: by 2002:a05:6808:220b:b0:3e6:28cc:fec0 with SMTP id 5614622812f47-3e66094f0afmr15263661b6e.43.1730812264219;
        Tue, 05 Nov 2024 05:11:04 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a0c199sm516059585a.64.2024.11.05.05.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 05:11:03 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: set a timeout for CMD_CONNECT based connections
Date: Tue,  5 Nov 2024 05:10:59 -0800
Message-Id: <20241105131059.1290437-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on a users report/logs it appears some drivers (brcmfmac in
this case) may have issues which cause them to never respond with
a CMD_CONNECT event, leaving IWD hung waiting indefinitely for
this.

Since IWD cannot control driver behavior its safest to set a timer
in userspace as a last resort in case this happens.
---
 src/netdev.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 2eebf457..8aeae633 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -70,6 +70,8 @@
 #define ENOTSUPP 524
 #endif
 
+#define NETDEV_CONNECT_TIMEOUT 5
+
 enum connection_type {
 	CONNECTION_TYPE_SOFTMAC,
 	CONNECTION_TYPE_FULLMAC,
@@ -140,6 +142,7 @@ struct netdev {
 	struct l_timeout *sa_query_timeout;
 	struct l_timeout *sa_query_delay;
 	struct l_timeout *group_handshake_timeout;
+	struct l_timeout *connect_timeout;
 	uint16_t sa_query_id;
 	int8_t rssi_levels[16];
 	uint8_t rssi_levels_num;
@@ -859,6 +862,11 @@ static void netdev_connect_free(struct netdev *netdev)
 		netdev->group_handshake_timeout = NULL;
 	}
 
+	if (netdev->connect_timeout) {
+		l_timeout_remove(netdev->connect_timeout);
+		netdev->connect_timeout = NULL;
+	}
+
 	netdev->associated = false;
 	netdev->operational = false;
 	netdev->connected = false;
@@ -2561,6 +2569,33 @@ static void netdev_cmd_connect_cb(struct l_genl_msg *msg, void *user_data)
 				MMPDU_STATUS_CODE_UNSPECIFIED);
 }
 
+static void netdev_connect_timeout(struct l_timeout *timeout, void *user_data)
+{
+	struct netdev *netdev = user_data;
+
+	l_timeout_remove(netdev->connect_timeout);
+	netdev->connect_timeout = NULL;
+
+	l_error("Kernel never sent CMD_CONNECT event! This is a bug, please "
+		"report upstream");
+
+	/*
+	 * Set this now in case the connect event does arrive in between the
+	 * deauth and actually cleaning up the connection members.
+	 */
+	netdev->connected = false;
+
+	/*
+	 * Since the lack of the connect event indicates a kernel/driver bug its
+	 * hard to say what state the kernel in. Its probably safest to deauth
+	 * here just in case the kernel is in some state between authentication
+	 * and association.
+	 */
+	netdev_deauth_and_fail_connection(netdev,
+					NETDEV_RESULT_ASSOCIATION_FAILED,
+					MMPDU_STATUS_CODE_UNSPECIFIED);
+}
+
 static bool netdev_retry_owe(struct netdev *netdev)
 {
 	struct l_genl_msg *connect_cmd;
@@ -2578,11 +2613,19 @@ static bool netdev_retry_owe(struct netdev *netdev)
 						netdev_cmd_connect_cb, netdev,
 						NULL);
 
-	if (netdev->connect_cmd_id > 0)
-		return true;
+	if (!netdev->connect_cmd_id) {
+		l_genl_msg_unref(connect_cmd);
+		return false;
+	}
 
-	l_genl_msg_unref(connect_cmd);
-	return false;
+	if (netdev->connect_timeout)
+		l_timeout_remove(netdev->connect_timeout);
+
+	netdev->connect_timeout = l_timeout_create(NETDEV_CONNECT_TIMEOUT,
+							netdev_connect_timeout,
+							netdev, NULL);
+
+	return true;
 }
 
 static void netdev_connect_event(struct l_genl_msg *msg, struct netdev *netdev)
@@ -2602,6 +2645,12 @@ static void netdev_connect_event(struct l_genl_msg *msg, struct netdev *netdev)
 
 	l_debug("");
 
+	/* Clear the timer as soon as we receive this event */
+	if (netdev->connect_timeout) {
+		l_timeout_remove(netdev->connect_timeout);
+		netdev->connect_timeout = NULL;
+	}
+
 	if (netdev->aborting)
 		return;
 
@@ -3491,6 +3540,11 @@ static int netdev_begin_connection(struct netdev *netdev)
 			goto failed;
 
 		netdev->connect_cmd = NULL;
+
+		netdev->connect_timeout = l_timeout_create(
+						NETDEV_CONNECT_TIMEOUT,
+						netdev_connect_timeout,
+						netdev, NULL);
 	}
 
 	/*
-- 
2.34.1

