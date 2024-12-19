Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A9C1FC7D1
	for <iwd@lists.linux.dev>; Thu, 19 Dec 2024 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734612290; cv=none; b=J2eJaxEeYUApCMHym0eZeFpzKqBCOw54X7p7+Yk+rEb/h0AEEj/pAQKZIFbH7PAVDf8wxfPn/Apg3Rs7pstVZzMRwoiSpqcyZnumQuns3cLxcJHvubHwW2sSqKi/WFUDNwA1nGiLs7TyhFfkFaG9atdioFZMzD8XSfSPJUctjcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734612290; c=relaxed/simple;
	bh=Jc7swo8FeuBzxI6e8y4q97YNi9WXrxm2pZVVsbQzBJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LFfnjqu3ZYib05X6Jrbgofqeng+5GOe0ELzwGGYItzK8AfRJjH57olXZEZxprg52YF1OPLvAGPBEtOt3rF9rMyBUnc9g7xSkzQLLG/ZPZ2a7VVukNbtOjdddBQuZSoCUpI1yN23qGenzearAD0VHH0R/3XMHJgauHZfBKTbI4YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5jyDeAu; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5jyDeAu"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-725abf74334so627979b3a.3
        for <iwd@lists.linux.dev>; Thu, 19 Dec 2024 04:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734612288; x=1735217088; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gf9/keIiFKYrc5F7oNlRnIbnn/GtBZs5K/6fZtui4n4=;
        b=A5jyDeAuMO9sI1fCP9X4dnJ4CLYUAh8PXVddYRCA/Xk0MLD+gOsExba3WvrVLQEPu3
         R8USnxAc/HN6F4j+2AO1IatBlQjhGuTebv3ywL8d/YTK3guxojk7d8r3twswLmRw3SzL
         Nxi34geDVD5+hef/e2tY6fiHdYMvfyRf6Q/fxz5IgZHEinGlhPTbVrzMcw0rAfrK+zFu
         x3HI2cztd1GYDQe08hBsKSqz8KqQ4RzPTVw0Tw0kUBGX2bN4F2bbPGXNBztZ/u54UgO5
         kfrmWd/EwyR5nF1eSyJUITAn3t/DCTMzLx8aSxCfqyQOZY06xJQgOUgIakZJDolVs8Ss
         STPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734612288; x=1735217088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gf9/keIiFKYrc5F7oNlRnIbnn/GtBZs5K/6fZtui4n4=;
        b=p0D5ktQhVj6e9B1AqfRMZxn2ejF0pd6pCtrpPtfqDvX0Qb+xVJ5S7s7oO0cQYJ0/q8
         qMEtisVeS5bh4XzJqXdYBUvN4u2f6Y7PAxO5yCi16gGKgv9VKOLtxhp6exH6w6cCYSUp
         1DY37JKbHsf+oN1HTQwPC3BiRm5zcSxZKw39uay4GfvKMSD5iDD1eMuSMZh19ThIINnl
         JvQf72u3ocIa3SlatQPlLtLWKj9c2cpckKeWZtuLEc684dARY8HI/K+CXjVnBuSgPq/m
         S+vHInlv2eKG7bHchvxGj5xLUPgThWj8MrQ9r3UoFE8e8UBuVDCIOffhUKtDfKneL7O8
         kvWQ==
X-Gm-Message-State: AOJu0Yz1fSdgd0MSaps0KUVbqGLMyjvBuwm4C544XTldyxvNhmE5n+ns
	R21fCU6FhyCdr/duZGl84eD12HWC7eyIQ3v16Cy4OtwHx1Z65Lkka4+JwA==
X-Gm-Gg: ASbGncvgbQA4l0Dnji41g4xwPBvudvczw2/UETus8hfRPu/2dQSnctWf4HKwtZ+6wcF
	JKENk9SozRPFqng5vNu0DhUdXX8kPUTxkNE+vNRmWGi65Co4/5stTyr/y28bYSxuO1Gv15Azz/s
	t8+mAlXOM1RLQ74y0XCCSRQWEBC8OMoKLxftF5fW/mmExdfyLOiFwxluy9h6adPZ9kF83IHPFKs
	Ycx2BuxiMhpsJFnENmCz4XFPklGi209E9EhGkDF8yhLfxyd382Wk71bLOsM5BGG6Bg=
X-Google-Smtp-Source: AGHT+IGir45I7Gc5BIxlBcGrRhrYGdylzAo8f3VeJFrk5bTjUHm0w8Le2U2W5HWiq4EibIHgP4G3jQ==
X-Received: by 2002:a05:6a00:44cb:b0:726:41e:b314 with SMTP id d2e1a72fcca58-72a8d2c3f2cmr10721587b3a.19.1734612287855;
        Thu, 19 Dec 2024 04:44:47 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad83475asm1186035b3a.57.2024.12.19.04.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 04:44:47 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC] netdev: destroy auth-proto in connect event, for ext auth
Date: Thu, 19 Dec 2024 04:44:42 -0800
Message-Id: <20241219124442.146136-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With external auth there is no associate event meaning the auth proto
never gets freed, which prevents eapol from starting inside the
OCI callback. Check for this specific case and free the auth proto
in the connect event.
---
 src/netdev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 02496c92..9deff699 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2615,6 +2615,8 @@ static void netdev_connect_event(struct l_genl_msg *msg, struct netdev *netdev)
 	struct handshake_state *hs = netdev->handshake;
 	bool timeout = false;
 	uint32_t timeout_reason = 0;
+	struct netdev_handshake_state *nhs = l_container_of(netdev->handshake,
+				struct netdev_handshake_state, super);
 
 	l_debug("");
 
@@ -2821,6 +2823,16 @@ process_resp_ies:
 
 	l_debug("Request / Response IEs parsed");
 
+	/*
+	 * This should only be the case for Fullmac/External auth. Here we don't
+	 * get an associate event, so we need to destroy the auth-proto now
+	 * so eapol gets started within the OCI callback
+	 */
+	if (netdev->ap && nhs->type == CONNECTION_TYPE_FULLMAC) {
+		auth_proto_free(netdev->ap);
+		netdev->ap = NULL;
+	}
+
 	if (netdev->sm) {
 		if (!hs->chandef) {
 			if (netdev_get_oci(netdev) < 0)
-- 
2.34.1

