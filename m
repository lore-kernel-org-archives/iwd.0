Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA91FBC
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 02:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKzht73D"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1fa20395185so878075fac.3
        for <iwd@lists.linux.dev>; Sun, 26 Nov 2023 18:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701053650; x=1701658450; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXxyGLc7j7CR85/9rJLh7fxxwQry4P9sd221GusiwY8=;
        b=mKzht73Dp4SCMlDCjToSdYEfM8UppRnIRKUzSpbCtzAnIzQrucA1w+7Q2nnoWtagAi
         5IjCTlUGKT5zXWoCV6DhzRf0AWGBp4VHwa72Z8KnO2Qq7z0d5o0rrcPkyyDHFoS2mnfV
         Fb77E+90Zqvc/QmBVJMEbJi15dq6+EimgXvJ/DZ5smGVQOwVwsdN9vSpEfxnTUVR4rh/
         oFqYxJGDsys+dvvABavDrp2rbSs/8gmrs+JoWggJMVoO5Q8DyG1jG/zPboLLKSe1PWCv
         SNZ8RjifbiZqQkvV+Gcq04jo27AH4L2jPbAzKgPoSET/l5zJ0kMCZJzmkRTey1ZUzXcr
         tD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701053650; x=1701658450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXxyGLc7j7CR85/9rJLh7fxxwQry4P9sd221GusiwY8=;
        b=WDphtUfPD4UGUSqI7rdOIYby0V8Ri9A1ADSG6q+ZdZuP7hJ/UpCDkbd8Dg0kW/M6NM
         p/bhhTWJyOqS06Mt2j2EqJqYDImR4yk96pnj7sXW5vWGDGvP0GTXH135Rdw3KmH8F2k7
         zn9B+hDsgQH2Sz0lhoVlYQCqVMgHWq3WdzFK/az8MQnVHhq1AtoYmW+G6f5+p7+3JD2D
         m8y6erO9RDW/9HzYyr3HicF/ol/LdBebpCcT9BoRnsN3snucP04pBV/fP97ycxcm3V16
         6WeGUMCczJk2udQ5NXOhUazq+p+62h35PpikMHBFGnhyGjL0Dp7ysHqLGlVhCqgWRm7G
         NGgg==
X-Gm-Message-State: AOJu0YxrYHvHXLRkAPMihImZv1PcvvKXPBElKd8EVG3JrPLhXPJH/bV1
	gFrKu6GqQ+LskzbN8CMiXpn/dE1hYoE=
X-Google-Smtp-Source: AGHT+IFGa6EIzVb3pDFIyOFAMaWC1VseYSX2DYZo0MYgHiG8WMOgCi1kLX/b8c34g4FAvgFClP4gkA==
X-Received: by 2002:a05:6870:9f8b:b0:1e9:ce72:35e0 with SMTP id xm11-20020a0568709f8b00b001e9ce7235e0mr15659314oab.0.1701053650245;
        Sun, 26 Nov 2023 18:54:10 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id ti3-20020a056871890300b001f9e3731545sm1818846oab.11.2023.11.26.18.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 18:54:09 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/6] netdev: Don't duplicate vendor_ies
Date: Sun, 26 Nov 2023 20:53:00 -0600
Message-ID: <20231127025320.1310543-3-denkenz@gmail.com>
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

vendor_ies stored in handshake_state are already added as part of
netdev_populate_common_ies(), which is already invoked by
netdev_build_cmd_connect().

Normally vendor_ies is NULL for OWE connections, so no IEs are
duplicated as a result.
---
 src/netdev.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 1c032b32acdc..e7b502b1c3ba 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2561,16 +2561,11 @@ static void netdev_cmd_connect_cb(struct l_genl_msg *msg, void *user_data)
 
 static bool netdev_retry_owe(struct netdev *netdev)
 {
-	struct iovec iov;
-
 	if (!owe_next_group(netdev->owe_sm))
 		return false;
 
-	iov.iov_base = netdev->handshake->vendor_ies;
-	iov.iov_len = netdev->handshake->vendor_ies_len;
-
 	netdev->connect_cmd = netdev_build_cmd_connect(netdev,
-					netdev->handshake, NULL, &iov, 1);
+					netdev->handshake, NULL, NULL, 0);
 
 	netdev->connect_cmd_id = l_genl_family_send(nl80211,
 						netdev->connect_cmd,
-- 
2.42.0

