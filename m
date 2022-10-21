Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C201B6135
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:14:01 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-13aeccf12fbso4702197fac.11
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PosxOZALKrEhJtYjRnocYQmLJH8qbE1BqkZ2znv3s3g=;
        b=HyLacZWZPzhDnXq/W0EWVW6s+gKbmK8NgKysG737j1lTL2j2ZRmvwcEOrpQ3lqYw4L
         kAP7wkThCFQs/VDte6CPxkHefGsDO9kfYH98F0q+IBoamSOXZE8Bv9fY7Pviu+hn1daz
         2NIkIk554Cb9pTl9LAvsE/87pgjXAD27BiBPyfY0gv6X6UIkk12vf41z6GC/YCdpUIW0
         1KtDZhnHAl1tIp5tzC9sG+VflaDzcreuoJkLUzMqzyqaKu0bGFh+HqD+Kn8+1Fiw7wxZ
         8QfEchrLV9V9tVgOFAfYotRHXFgn/lCCdlBu/OqBhGnCNjT80+8G66AGwvswzam05mc9
         JYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PosxOZALKrEhJtYjRnocYQmLJH8qbE1BqkZ2znv3s3g=;
        b=SQWN/ymxkbd57CrDo1bMV0YUxiT12Q6fSS5BVfkV4Dg9JTi4IDVsGg+M7fNchz4uFs
         5eF72iIzBfHxsxVQlqTp6FmMh+erE/cghD9eRhu8OtQSQg89Mwt4jQ/Mome8d2I2wQ/s
         bf8ybU4E6LrRGm23Pxt6e7r67en+QSE3nVF1NBdOH+jM2T5GZVUaFx43WyKwv7Nxu1v0
         54+6hto54rnuPfwDlBmTFqWuPzi2TfN0gSA9YUGEIMQHVTZRUtZKSlOVtVYEpefRp+VZ
         ED2Jlylk2imTwnSI9F/PIwuFujIrNr8ShyMPY8NkVQeBSPUST+AKj38SFn68MIfJj0xm
         PnFw==
X-Gm-Message-State: ACrzQf3g8LU+B5+IkUyc5yiAUx/2krnAFbgWzDdeClAbfbCtf3gjokFi
	o3do1xI6PZjnjtR8MDmGErGXgpAhc+c=
X-Google-Smtp-Source: AMsMyM7aeTywl6cq97Wi4xX8Ot1IyC+sIrYF+ijlmx6VSfSHHZyC9df5yg29FYJK4370TzHKSXvbhg==
X-Received: by 2002:a05:6870:d191:b0:131:a0be:b305 with SMTP id a17-20020a056870d19100b00131a0beb305mr12614998oac.169.1666379640571;
        Fri, 21 Oct 2022 12:14:00 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:59 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 21/26] doc: Document GCMP|CCMP-256 ciphers
Date: Fri, 21 Oct 2022 14:13:02 -0500
Message-Id: <20221021191307.31492-21-denkenz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021191307.31492-1-denkenz@gmail.com>
References: <20221021191307.31492-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 doc/station-diagnostic-api.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/station-diagnostic-api.txt b/doc/station-diagnostic-api.txt
index a974b8130c3a..f6e099b51241 100644
--- a/doc/station-diagnostic-api.txt
+++ b/doc/station-diagnostic-api.txt
@@ -48,6 +48,8 @@ Methods		dict GetDiagnostics()
 					- CCMP-128
 					- TKIP
 					- GCMP-128
+					- GCMP-256
+					- CCMP-256
 
 			Possible errors: net.connman.iwd.Busy
 					 net.connman.iwd.Failed
-- 
2.35.1

