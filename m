Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809FA197552
	for <iwd@lists.linux.dev>; Thu, 19 Dec 2024 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734632229; cv=none; b=c5CLlLnOtgpdZSJwn5GLolq+yKfBLnYvO7PuqnXt/Ejql55lTEBhE6bLJgNyBUAIc+OMe4HnZTUxoKOvepzxDoJqyHiFeFu16PH6hNseM3Ie8an5jsXmBTOdBeIttL1PxM4KJfc0Xle3yFCtPGjluUieACiuJqCI2M+bgLVi6QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734632229; c=relaxed/simple;
	bh=Xb1cDVkKchRyLc4kN2vSD4zjqzv2vSK1a+kFO7xMU0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fiWu+5R0QAEDcLWWJp3wDXFRdOwi6XVqAwYS/kVzzT8mKZHTNmUtwkE5gLKE0x95FlibjzOZIl0xrGaXbJL0VZhF7t8iZoJu7F1VBqCo/BJhhSyRlJhHC0eSxKalclkbCGOU9V8sqeR4nghJUp98B1FTCbEe/eWrgxMJBN5EJx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1PphN6/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1PphN6/"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-725ef0397aeso940139b3a.2
        for <iwd@lists.linux.dev>; Thu, 19 Dec 2024 10:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734632227; x=1735237027; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LhpMRelEOfLyTll9+dX6KoNZeXL5ktX2ictm17c9YFQ=;
        b=g1PphN6/LYvW9xr3wQ4lJ6SFDr5YEtV22yP6iHgLsIJQIAWIkKkPkJ1EcrA+zmaJ2C
         XTPVem5D1vTQMYCvzAU40dW7iSAHVjWJ8KX6Zf4E6LS5+Bts9Kc9cCzS8kQgt1j4CsC+
         j/3jFosahe32Su0+jDIxHgX9NHTlKNcwhZMlseQGygJN5IHT8Ym9hinxArVFkhxWiSAi
         KrtV2L2p6t5i0KaHUhEIDBZLB2Z98aMkvXOwxSYLy5WXfTncHH8GrYMCqyXpxOjxr0U2
         M1xdCqbuBKddlWeCcMH/4YmX925a00YEerixcjRt2lcRfJhUf/kKf+ThTCJBuSLbI9bp
         9BuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734632227; x=1735237027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhpMRelEOfLyTll9+dX6KoNZeXL5ktX2ictm17c9YFQ=;
        b=lmOey0YzrTnD/KMM1G9DnlNTcOyi8a7mrnIl4gMAUWVg5rR/5lY0kjd6gXMQzhnyUL
         Rf2HRSE72jLBJ89IIsEYWPjFcLMhhNdXgLuoSfnNBQO7pzpMJ27sm1KFbzUkGeOilzLn
         3dDfkf9e0SGIGVe9z9rpLAghGoIlbemoZa2xwCFIojyURaXCbhh5oz7HSn1+EcTiDR2Q
         RUF+fjG1CvOSOWR+F2eyBbTA5Nje6wAJeDmClTPpiZZIZl8SQJMNotrSusBguwB6xj3F
         JsTbSC0MlFERQ3wqsKDe7gVx+SPG2iDbjAs6NwLTegb9OSHjWg5Zanm+YVEP2ZXoTXOv
         EjOQ==
X-Gm-Message-State: AOJu0YyMTcDmJFG7EwsfKwrmUvDgxJJeyqV/Eeh723JPxFTFzNjX9Lty
	384KRppe+zZI/hlyQ69+6zkPK7y4dV/ceQ8D+qpva5U0wW/HlH3ckjhcuQ==
X-Gm-Gg: ASbGncuk+ZWiQZWYXQtSv+gS3qD3w09z3O8czBd5p/t+BMC09BJEuvEDLAbAqzwwgT2
	9MADyew+wUrfQhzQqre5f7euA12JvNULjI1f7T36Uy0fzh9NCckDPxPWHtAFRu11DpTJy67ulyV
	oJzDRihoYDMj7QJXBx4XkdSMi4MHY5rG1gnEzi2L0lmc+KXLy1qTZKgZ8WPvhxoFUFNdO6i9kjk
	xjrIBNQWDvBZrbFPEdzMAGoZobw2Nu916OfYivQJcdrVAJtqxGijwL9r7QSG9VEXMI=
X-Google-Smtp-Source: AGHT+IEE+3wN/YfEtbuQm2dbUQnTR9OQJvuSsJwkNxWhklCdI323UsUUZ8ejRZlvewzjvwlY7GwGPw==
X-Received: by 2002:a05:6a00:4487:b0:725:ef4b:de21 with SMTP id d2e1a72fcca58-72abb5bd717mr797636b3a.20.1734632227324;
        Thu, 19 Dec 2024 10:17:07 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad84ee4csm1610428b3a.82.2024.12.19.10.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 10:17:06 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: destroy auth-proto after external auth
Date: Thu, 19 Dec 2024 10:17:01 -0800
Message-Id: <20241219181701.164349-1-prestwoj@gmail.com>
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
after signaling that external auth has completed.
---
 src/netdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 02496c92..2a6d94fc 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3483,6 +3483,13 @@ static void netdev_external_auth_sae_tx_associate(void *user_data)
 
 	netdev_send_external_auth(netdev, MMPDU_STATUS_CODE_SUCCESS);
 	netdev_ensure_eapol_registered(netdev);
+
+	/*
+	 * Free the auth proto now. With external auth there is no associate
+	 * event which is where this normally gets cleaned up.
+	 */
+	auth_proto_free(netdev->ap);
+	netdev->ap = NULL;
 }
 
 struct rtnl_data {
-- 
2.34.1

