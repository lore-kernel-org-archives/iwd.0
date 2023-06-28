Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFEF1094D
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 20:20:40 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7659924cd9bso14583985a.1
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 13:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687983639; x=1690575639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5fgcfEBuTalvon00iPLb5lYbeZ3/uquFPKvE+ppM/M=;
        b=YmvRnEYRvrJTOtohO58m7j4qOVFBbNFVfY+e7j/dRM4xiKfzGVpwE7P9Ua2VZDZp60
         luz9DAr1dRpv3zdvGUSF2X8Geqzjcqu2H6W3rfLdkx3KGbKjy2zecEupvArwpLuAsdT/
         BbA9j1RwdgUZXAQMm+jGKOk1QFpYWCmFFh5g4MNoT93z2pxSOVwJYlQfpNlWn93YyNZ/
         CAciiYMJYgzhenPfnNnAJHdxPL5rzKgL+uUxkHMIgBI+h3g10EOSM/eSoDfrq8ElNc6m
         h79vUomXubI7eU4CJCBDPUoo1cSQoV0R/xWhVMz8BvDGlWxzKy+jZIsvoLCTyGtd9Yyw
         PLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687983639; x=1690575639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5fgcfEBuTalvon00iPLb5lYbeZ3/uquFPKvE+ppM/M=;
        b=cWsjxn9w9a7pELaqX1zvKEfK+uGziK1T3/X5r4snp6JJFUxKF9G9Qt3/xUf82gTa/J
         p3L2G5E0S7rD7pZ1csdEDROPUTw8EsnvY9GmhvkSxLZHHXK7YU4Ka7d0fD5dya+V1aKP
         J6S8eQ1z6V1ycoPx4C3HZWOSjeAPCLibP9SEsW9ss7xmGhINOtHayFCiOD24Kesv38yY
         1phyhqQzjp1wZsI6R5DC57z3thfZ3p3MvCxut+8Cskcdv3Tp0BesljK7oGKbX/8L+2St
         lsXCFxU45xRahrN+tQaTY3PE73NHXUxe5kA7nf1BFcSajSA09QzgQPFsRxf493oX7TL1
         y6/Q==
X-Gm-Message-State: AC+VfDz+IZCPcVi9hxsTmwWiswgDjnC38dFfGraZJlYnPwjt/n/x4Cfu
	gpY5odOaZG23ef36sRluEXUVyMHi4BQ=
X-Google-Smtp-Source: ACHHUZ7odYIbZShJBVFL/JSvT03quTIZe6m4MVCqAqnlBJm42eA3124B/Uz6xWEi+d0n1omqfYr4vw==
X-Received: by 2002:a05:620a:4549:b0:763:b4d7:51c1 with SMTP id u9-20020a05620a454900b00763b4d751c1mr39147253qkp.50.1687983639312;
        Wed, 28 Jun 2023 13:20:39 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id i4-20020a05620a144400b0076728319575sm672557qkl.27.2023.06.28.13.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:20:39 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] hwsim: add ADD/DEL_MAC_ADDR events
Date: Wed, 28 Jun 2023 13:20:31 -0700
Message-Id: <20230628202033.2320994-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230628202033.2320994-1-prestwoj@gmail.com>
References: <20230628202033.2320994-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These events are important to support both moving radios to other
namespaces, and to allow scan address randomization to work.
---
 tools/hwsim.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index 47352ad4..ecee0a0a 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -62,6 +62,8 @@ enum {
 	HWSIM_CMD_NEW_RADIO,
 	HWSIM_CMD_DEL_RADIO,
 	HWSIM_CMD_GET_RADIO,
+	HWSIM_CMD_ADD_MAC_ADDR,
+	HWSIM_CMD_DEL_MAC_ADDR,
 	__HWSIM_CMD_MAX,
 };
 #define HWSIM_CMD_MAX (__HWSIM_CMD_MAX - 1)
-- 
2.25.1

