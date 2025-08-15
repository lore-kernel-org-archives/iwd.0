Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D12C15B6
	for <iwd@lists.linux.dev>; Fri, 15 Aug 2025 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271577; cv=none; b=TfV1ksyyIXxFEm/bLsu2F124j/IAseLff8NTZnz2N/HGWKVlvLgk3LLn5Wf+tLywtgJ1DXc2ciIbuijlnVVbi7qLDJfTpwACw2cNLzbOhiJPiygdA+6dXb5DDTD+j2gP7KN8U7qQsAZnp2LfwG/+NJwJ8znoqgka4oIgGuEpY0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271577; c=relaxed/simple;
	bh=0/g3rLpfSNvHfwjSWC1jKGSb6nd0r7wmGjbVsVbFTJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eZ55LTFb4u7KqLuK1iCXaqphKJhvGvtSJZYjjt7Xc9FS/QTQNHctVSqxFmHs9W6dmLJWOl7H14e1rKnAqO6YVKe9tMtWr+sOCm8vl3R12iH7cth1sjqcTXlxGIyxGESpWw5R5qtjlY1XQQ/7HFOlWrvKf62f13rwrAmi50CpYk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfRwV8Lx; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfRwV8Lx"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b109bcba7eso20055061cf.2
        for <iwd@lists.linux.dev>; Fri, 15 Aug 2025 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755271574; x=1755876374; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dm2iUYhwLA8ESM4dGPrl6Ah1qpqA8bO86OGqFGPXlSg=;
        b=RfRwV8LxqpNE+uHmO3Y4FxU/TvmQU6dxjduMEvB+3qyB34nWwQ+fvAQIu1vFAoT89z
         xUeIPT541N73DPaossWvHQegJX7U+YhNWn7Ct8dfioUOftIMQzq6OnGyDcDnmxzdLL+l
         99wEvkc4EgKDmxMoY+FDgtieIrSn+zQNMS//pOpNWd8UsSZ4aG2XVAAAwcxaIpbKnNmC
         Uxh/d5PSbYcgvap6eXAieZS3Xgyo83TIHL1WTU87B5cD2Sh4CDMcTQgjxS99HQsSaFgw
         GRHthbEyrO7ousnM82tKTAqo88KpTPDmC5hzZL16VIpyzsaPZm+FMeZQy6ZleM/NJ/OE
         CYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755271575; x=1755876375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dm2iUYhwLA8ESM4dGPrl6Ah1qpqA8bO86OGqFGPXlSg=;
        b=jZNU8tn3e6sGLK6po8ohnzjVCC/33SW2Izy8J5EA2vqIqOc1BBudja6GW0AK2nFGnM
         tP6HPXGODBwVnQ/XMpULoUtfBs5m9NivXQemM0Dxsm61AvmFm5pXLQzkRv3/iPl5sX/L
         6KYh3sT9Lr5MKuIYjk1uZhtCQHsuQgJf6PreDV6nzcG3dxzUOZwhOoITuxWyMqwqJa/w
         phbg4u77Gz2gdPLAREIpMA2Sv0o8/aay1lAIeLIYFsVco0f7l+n6jXKm7lYJnFkkO7Kn
         RXJwfYHnuPOpKPNBK9KG7ryVtbuhkGD6wMP1gMegKhCt7i3dYMTsKIoVNYEHWsT12lCg
         +fjg==
X-Gm-Message-State: AOJu0YzvDm2NonYjVq7RtEXlY5DI8DPGBhd3X4lY7EIPeGE3uqMq2jE+
	fRlBOlmysESgPv4JMfL7PjXENqDW6rGQnSV7pdpsZWGFQAT2QONgRWslDBOIBg==
X-Gm-Gg: ASbGnct7vafwrmdiyO7Cc5nNnFOg2i0qMovdow8aBWnOcSBC6TdhRaqC0fIi3TkvpUl
	Z1RQHzmy6V8Ab/Id9Fd/DdCzTXuH/8pkeWrDT88/QatsovRl105Jgpz+AUje5BX9QAaRiakft20
	CbibeDqeXAzp/4MFG8oBQrBNJvLLyIKSxQUkVJdp9jUMDw4w4QtLG8kMW4iYKNphOI/t9MiZEfh
	3dmZA6jVg3NOOvkzyHKXepJIuG5I5ZnyliP09TNO/klYVeY8RxVbt2PvTbrRDd2Skk4M49uuuiz
	gAFgS4bbWmage+85X6DxxLrH3vi1xOfKFryMeVbIjxlA8/+6bsM0P02OJllMtIfkioBTyn6RYb+
	TJGs0TZhQEtzXj9vWi89zojf8gH2LDJbZzWkiEStieXA=
X-Google-Smtp-Source: AGHT+IHMyblHZYjY+28MG8s0k8G8QpnZcSByC0pNBFzfZKgjnFjbgsmV5df4pX8SAxVkh60Fwvfj1w==
X-Received: by 2002:a05:622a:1993:b0:4b0:a034:cab0 with SMTP id d75a77b69052e-4b11e0e85fcmr30812771cf.20.1755271574456;
        Fri, 15 Aug 2025 08:26:14 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de0d731sm10393851cf.40.2025.08.15.08.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:26:13 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] netdev: handle local CMD_ASSOCIATE failures (for FT)
Date: Fri, 15 Aug 2025 08:26:04 -0700
Message-Id: <20250815152604.175977-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815152604.175977-1-prestwoj@gmail.com>
References: <20250815152604.175977-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue surrounding this was described in detail in the previous
patch. The netdev piece simple and does two things:

1. Don't deauthenticate and fail the connection if the CMD_ASSOCIATE
   ACK comes back with a failure. A local rejection like this should
   not change the kernels internal state, so we can recover. In this
   case call the connect callback directly with a failure which
   station will handle.

2. Upon a successful CMD_ASSOCIATE ACK, signal
   NETDEV_EVENT_ASSOCIATING to let station know. This did require
   modifying the netdev_associate_event() to not duplicate event
   calls, specifically when FT is being used.
---
 src/netdev.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index ca8bfea0..e45423be 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2993,15 +2993,32 @@ static void netdev_cmd_ft_reassociate_cb(struct l_genl_msg *msg,
 						void *user_data)
 {
 	struct netdev *netdev = user_data;
+	int err = l_genl_msg_get_error(msg);
 
 	netdev->connect_cmd_id = 0;
 
-	if (l_genl_msg_get_error(msg) >= 0)
+	/*
+	 * If CMD_ASSOCIATE was accepted we're committed to association and
+	 * can no longer go back. Signal this to station so the state can
+	 * transition to ft-roaming.
+	 */
+	if (err >= 0) {
+		if (netdev->event_filter)
+			netdev->event_filter(netdev, NETDEV_EVENT_ASSOCIATING,
+						NULL, netdev->user_data);
 		return;
+	}
 
-	netdev_deauth_and_fail_connection(netdev,
-					NETDEV_RESULT_ASSOCIATION_FAILED,
-					MMPDU_STATUS_CODE_UNSPECIFIED);
+	l_debug("failed FT reassocaition (%d)", err);
+
+	/*
+	 * A failed ACK should not have changed the kernel's state. This means
+	 * we should still be connected to the current AP and can proceed to
+	 * trying more BSS's.
+	 */
+
+	netdev->connect_cb(netdev, NETDEV_RESULT_ASSOCIATION_FAILED, NULL,
+				netdev->user_data);
 }
 
 static bool kernel_will_retry_auth(uint16_t status_code,
@@ -3185,7 +3202,12 @@ static void netdev_associate_event(struct l_genl_msg *msg,
 	if (!netdev->connected || netdev->aborting)
 		return;
 
-	if (netdev->event_filter)
+	/*
+	 * For FT this event is sent in the CMD_ASSOCIATE ack to indicate
+	 * association was successfully started in the kernel, don't duplicate
+	 * and send here too.
+	 */
+	if (!netdev->in_ft && netdev->event_filter)
 		netdev->event_filter(netdev, NETDEV_EVENT_ASSOCIATING,
 					NULL, netdev->user_data);
 
-- 
2.34.1

