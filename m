Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF02C81C
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 04:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXfUAq2l"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-58d06bfadf8so2338684eaf.1
        for <iwd@lists.linux.dev>; Sun, 26 Nov 2023 20:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701060013; x=1701664813; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXxyGLc7j7CR85/9rJLh7fxxwQry4P9sd221GusiwY8=;
        b=PXfUAq2lorttgiJjjcu0l/7jJyhbDSBD7G2InemPS/Edlkg9HZMLs1iyE1tLDH2l2V
         viMJwJhzzFvKDps6Js3rx0mcRrZPHhSDW7VUFaCQHmE3z0uQ7AzcQVUdiol+ZvNU4d4a
         AS1hR+XqiJJ9lZWyn8AdDCrIvHMMcehrVCC12DxTJDgIdukTxDwCz4/C9cgl5MjujDVc
         +tyBfKBfDzEQM4O7YJ5UWObgGyele48h5cL6yzeW61FQxApAWzAl5VPdA8NMXJhpE34y
         A+PTLfVRSDkY4jjYGA3nnzl9zGyspdFFIV46CbqfH90b+oKlIHD8yFbcd9vFlQFnd0Q8
         Bc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701060013; x=1701664813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXxyGLc7j7CR85/9rJLh7fxxwQry4P9sd221GusiwY8=;
        b=W+S4RGiMph2uSGHF+0cQmXWxpTtMCdt37m4ks+YuM2wP4d9EP8TJkTGA9h68sPVgGC
         2s5oHY2+5XvN7vqZkfc1b1IlswRfPQgIL52TS8dujobekGLYbw8ugPYV+NXbBi2pOY0m
         yJtAMscLKvJ/NDhwr/0ZgN6dWv/cw9aZZ96npubIM33mUceFyKyWehJUeguE8oh9gFdB
         2gBUlNhePPeSl9DtmcrNjC5msLvfjJkgXERsK5cF7H+xUVx5TcyGQ+8OO0thaCj3aOWg
         KcjgLfToaPU+x20X65JzJ4mH+cJsYPxbaN6R7WGX14A+ywEiCJky9zS0hTOVVZZknFWk
         zp+g==
X-Gm-Message-State: AOJu0YxGKhojbTopNGTQ7tbZ9p38l5EXRCYUwvitBRiFiBYUg55f+nDy
	hiaRr9smnTcL6SmMawKEqw4T5sz/rjs=
X-Google-Smtp-Source: AGHT+IF8+L9adUfVvOA+nC8HwN6JiBj7JYVo3pDoDqthrNEn87ULSMVn1CefRq3LbWc5cGnMDssg+w==
X-Received: by 2002:a05:6870:9a0a:b0:1fa:a10:d016 with SMTP id fo10-20020a0568709a0a00b001fa0a10d016mr9886433oab.5.1701060013611;
        Sun, 26 Nov 2023 20:40:13 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id nq6-20020a056871378600b001f5d5930e85sm2110558oac.33.2023.11.26.20.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 20:40:13 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 3/6] netdev: Don't duplicate vendor_ies
Date: Sun, 26 Nov 2023 22:38:43 -0600
Message-ID: <20231127043924.1328538-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127043924.1328538-1-denkenz@gmail.com>
References: <20231127043924.1328538-1-denkenz@gmail.com>
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

