Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E46113D897
	for <iwd@lists.linux.dev>; Mon, 27 Jan 2025 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994809; cv=none; b=dfgWPLnsonViWQg2WGx6QcWP6EflCgLnbYs7wqFLMyoP8NlkhXzlWWytCJZ4CW+xZwY0zE1WoT1fH5yrwlSfVlnvO0gCciBmU309LrWHF9aXuPTCWde2//HbUGuYvXWxtG5lTiDzoyBS+Im3CNqRAIatgs/VjoOFZiCL6N4O2EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994809; c=relaxed/simple;
	bh=z2Aqm3Dd1NfNvq3vj9KADVe868EmXdAxAlGuOhuwCa8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t7mxOqBNenYneNRZiR6NLs+BaOv23DJGftwJf8FAO85oUnjO2OvrZRkjxSpTvg/wjcT/Ri1ofjbO05C6cnpUx0uZI+J5ofniSuIqhLAa6ZBdxKmYFai/kkhDq/cZUX3XADb/9XFX3OlcTyzVvgTvhMzpdA2JxiOH7ERuALPHJEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONAjuD9X; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONAjuD9X"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-216634dd574so55125385ad.2
        for <iwd@lists.linux.dev>; Mon, 27 Jan 2025 08:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737994807; x=1738599607; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ylqFRUCpY2d7T2XWHwIg5wSnmq0BjNvbYOxne/duyQ=;
        b=ONAjuD9X+JxO/wXQVpuE5KyDjFgCBTmR1iB+mujILm71EqQAlsDbUaQy+5bBnOOD/r
         Sd5HC1q5SkjIWs28I60ufbVcN9kfSjb0gOQ4UvhHvs2W3lsMexwbuVGzv5ijoutJbOnx
         wlzW4l5dJMY6MZGwbbi1UNQa3h/nNrUKCEo2yB8BoapDIXh/Echfsh1PQJ1oJN/J4BSW
         0SnJA0hoXHT8YwV9TFL8Z8ZZY0VtIspUUOduaF9S1XtCuHyLsit8ZZqEmG8RYQHTf1qF
         wVSgQ9V/0aSESq+aGsvBWoEQxmA1p9loDRKGTi2Llx9dkjUQFKqZS1CAPGOsPdtPvepr
         cHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737994807; x=1738599607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ylqFRUCpY2d7T2XWHwIg5wSnmq0BjNvbYOxne/duyQ=;
        b=AKhgH21NVWOYVRI2CsG0CPyXeP4X/JPm0KYrVY3rfVx54haldv8KQRcyi3oIX20Cba
         mIl1ikhpGsj5AaORg2IzQmeFOFcpe8kGPt7x0unLNQxH8OWSnIJwbGua9WVbYpgTCFzn
         Tj4nsm27E0BxzdFgOBttXBpWG0gT4G/+E9G2rQoptMBpr+DjoRcpgVQp1xfPrVlLxDfn
         RXkYPU52eapOmPd85r+LN7USEw4zbxADKcVGtNsYsbckdnSXOebljMssKcf7azwxVd4P
         Z2BWGjjPCKDBaojy51/05DGZipjP9tN2m2DnZcQt4AsGOjCtat/gxDYuE1PP2vQ8GIhc
         7UCA==
X-Gm-Message-State: AOJu0Yyyx+OQ2PDsL35o+T+enk/PBKW23V9T52RSSJGC2OwfQ0Qzn1zt
	xc3AkHyste/PZpzE5N+IrGX9u1Xkq8PMjQdrBacFI6ZQO/ddkP0Eo3kkTA==
X-Gm-Gg: ASbGnctyhQ0YEq+5wRJy6GZZy5Hu/lrockJ2DlA/9WLhknNgrrdxscHu1tzCIReu1si
	aPbJppkzDHBEqy3M4ZQ2c+EXSJATDLeqhlPYHSNIFMpO8gVqLgv8H6AbJm+AI2eXXPFCHQVQY3p
	XNYzSM9zr7sF3st5KonXSB4X2JbSCBR9XDAqSeYAzMzbC3As97bJ1E0pYbcBoE3CmEho/s9F2Lh
	a57jHohCZ6hs3tqQk1ZvAn2+eg76MaqF88wumN27ni5yI/rNmEcAgD4ytn3EgTBRSNMh6djOVCU
	nCoVl8Lp6M/HXGg=
X-Google-Smtp-Source: AGHT+IGv4VgZuPbiX7MXmbCLzYViffd9gYzojiF+jo+NIpmk837zAuwQ6ekPsgiuKD12X1TzS5SvLg==
X-Received: by 2002:a05:6a20:72aa:b0:1e1:e2d9:44d9 with SMTP id adf61e73a8af0-1eb2158bf4fmr61611064637.27.1737994806939;
        Mon, 27 Jan 2025 08:20:06 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6b52f9sm7313081b3a.72.2025.01.27.08.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 08:20:06 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC] netdev: Don't use external auth with PMKSA
Date: Mon, 27 Jan 2025 08:19:59 -0800
Message-Id: <20250127161959.37878-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on user reports the driver seems to get confused when external
auth is used along with including a PMKID.
---
 src/netdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 2a6d94fc..addddff9 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2499,7 +2499,9 @@ static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
 	case CONNECTION_TYPE_SOFTMAC:
 		break;
 	case CONNECTION_TYPE_FULLMAC:
-		l_genl_msg_append_attr(msg,
+		/* If we have a PMKSA for SAE we won't be doing external auth */
+		if (IE_AKM_IS_SAE(hs->akm_suite) && !hs->have_pmksa)
+			l_genl_msg_append_attr(msg,
 				NL80211_ATTR_EXTERNAL_AUTH_SUPPORT, 0, NULL);
 		break;
 	case CONNECTION_TYPE_SAE_OFFLOAD:
-- 
2.34.1

