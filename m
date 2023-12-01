Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734766D3F
	for <iwd@lists.linux.dev>; Fri,  1 Dec 2023 04:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRS1vlja"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-58d521f12ebso952023eaf.2
        for <iwd@lists.linux.dev>; Thu, 30 Nov 2023 20:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701403273; x=1702008073; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5rs4fqmuY15Ww23hL1mdIl/7uXBy1DIKUhPEOMYB/8=;
        b=kRS1vljauRtcikS6f4bgWlLSb/krxsZMyrBKuWIDjf2wvf0VGYRt0r34yajsoPKBQb
         wt9HANTME8YQay3JG5TTa7A7MQeaVQXAz+IppgqWqEDWidLuhkUqhCxrpt82vDwXXlch
         AkispkShZ9m/uJdpN9gfg0RrSboeKjMcPdwkyKkTR8SU+QAt0NPg2cgvYA/JkZbBfRWD
         3eNdn7y3wUuf22nHFI/gCwUMqQF+1xLQfP4cq6WwRB7eYifIm5JGj2Z1IOJTYgXWOhcy
         yhHyBjXHXr8/h5/R8ScZsRBUt5ZbM0TWwxf9TxN224HVv3BX+20q8U2/azvwfK7ninfm
         jMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701403273; x=1702008073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5rs4fqmuY15Ww23hL1mdIl/7uXBy1DIKUhPEOMYB/8=;
        b=NuXL7s2r/OKmvF+6cayaWVf6zPiuvamKF9cQmhsOkapc7Td1g+SepjT0nKOd+c/cpv
         uL/ErdA3l8tgRc2noUGZCDuFWAK++2WlagKKS17QFcZWMLG7OT79Xa66IhjzmfuEiN9V
         zAg/M7vvKAihtRVASCRQDZ7xXFoxYA3EdZSGcp/ikgrYgIfvXnzO57naj+iwznPXQtEf
         BBLRrpmCcEBtBs1vDBDqXgv2/QM89pTvaJOKiUKQgZdxN6ZMqI7kHQotj4XPN8KsKC4n
         hl+/KF57ldKDke5wJQySL+at/vPNhIk+PkutkPC0T0P+AMqdFNg1aOITbNwXCT5bsJkM
         OdSg==
X-Gm-Message-State: AOJu0Yx3i0ploCo+plpSKjJK+24N0j1GL1TEKZ8KD2iZUderp3P8JuwH
	lC8R13g7vrDHztoq1SJG32tnCKwrsTM=
X-Google-Smtp-Source: AGHT+IEyzP3tEkn3+WsBKlILMWH/XAB+h682m3PGgObWZGMDzz5DqyNAS/cgAYR8uCATw5WRmtLuvQ==
X-Received: by 2002:a05:6820:2202:b0:581:ea96:f800 with SMTP id cj2-20020a056820220200b00581ea96f800mr1677102oob.6.1701403273449;
        Thu, 30 Nov 2023 20:01:13 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id o3-20020a4ad143000000b0058ab906ae38sm404005oor.2.2023.11.30.20.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 20:01:13 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 6/7] wsc: Use handshake to pass vendor ies
Date: Thu, 30 Nov 2023 22:00:06 -0600
Message-ID: <20231201040020.161143-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201040020.161143-1-denkenz@gmail.com>
References: <20231201040020.161143-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of passing them directly via netdev_connect
---
 src/wsc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/wsc.c b/src/wsc.c
index cb2e2c3e2ad0..b063313ac6dc 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -382,7 +382,9 @@ static int wsc_enrollee_connect(struct wsc_enrollee *wsce, struct scan_bss *bss,
 	if (ies_num)
 		memcpy(ie_iov + 1, ies, sizeof(struct iovec) * ies_num);
 
-	r = netdev_connect(wsce->netdev, bss, hs, ie_iov, 1 + ies_num,
+	handshake_state_set_vendor_ies(hs, ie_iov, 1 + ies_num);
+
+	r = netdev_connect(wsce->netdev, bss, hs, NULL, 0,
 				wsc_enrollee_netdev_event,
 				wsc_enrollee_connect_cb, wsce);
 	l_free(ie_iov[0].iov_base);
-- 
2.43.0

