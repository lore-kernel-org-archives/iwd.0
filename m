Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9902F55
	for <iwd@lists.linux.dev>; Thu, 23 Feb 2023 18:14:22 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id k21-20020a17090aaa1500b002376652e160so206851pjq.0
        for <iwd@lists.linux.dev>; Thu, 23 Feb 2023 10:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tL1DyDz7YrnBygu8GlhOcxPnFTNvCo3MRzSw3Fl3BvY=;
        b=mvJLFieqW0O4dOpm3SPHLD3gTS0/jcVhsATn0vtnuvTDF/hdvDL1GeF+jjt/ceoShp
         FQPUIMuaSMstLs3Nz9p2iNOj/V6HXC8Qbmd76PhgDIs2xHUggudGuw2Sfu55yZvi0yiw
         v/IynHTbs5KldYwsRm8MEq6VVSTfSkk/HnIgSwhxVVkqq4eVHHH9NqCBRK0Vs4U1pr9w
         23h8P70tvPocLxzyO9X5S15yxbET2W7NhawnLsMuWirC5U7KzJb7aN27+eXhfXBibDiP
         s9W0rfeFATfhstY1xiUC30Evsu4NuDidtbhO2neSeo6lwCkYZxU5pluareW75bw7Nlo4
         X4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tL1DyDz7YrnBygu8GlhOcxPnFTNvCo3MRzSw3Fl3BvY=;
        b=p6Nwb4Ssdvz1tk46dbugMGkyy1M8npJ8oV5nGxvsW9VZH/oUM+6gUUdBguXqhXvI+K
         yMTdsa9y0KmFieKAyyNaye2uIgu2sZ7rfeLQwQd/o0500YeTtw5UNPauLiJ6w1hfJ3DR
         uGPjx9GdmHzjdo+EcxIie7ly1w1NlPdw3kG+YkjC+VJ6jKVEjtpyyDr/K880Aq0Swk3K
         T0cvQqsEt/hv5nUI9iNfNSEXRbdAE6mXbecisE873Lr4bzfRaHuc+RwlhPo04QD3qSx5
         S6snsorclx9F4bf5WMWzQjqZOOlwOWfQA6BoWbORwz0Q2T8TS5cvBe226xv3I2a0KWbR
         +URw==
X-Gm-Message-State: AO0yUKVuo29Xhzhc1UCH9yOAi67WjsCF3g0sJJQyUmNsylfyJJD6XOQN
	zSZnHK0idXBxLJULNh6vegOTYs1WZhY=
X-Google-Smtp-Source: AK7set+6Yxnaa+ITFjEr5DQ2rMbo99p5xcxDT+pC8WmORu0YAwZLZ7MiTQKu6fCm0QJ5VrNFVW7zkA==
X-Received: by 2002:a05:6a21:3385:b0:c7:684a:e4ae with SMTP id yy5-20020a056a21338500b000c7684ae4aemr15732603pzb.15.1677176062112;
        Thu, 23 Feb 2023 10:14:22 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id x9-20020a63aa49000000b004fc2582aedbsm6070173pgo.17.2023.02.23.10.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 10:14:21 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] netdev: check iftype in channel switch event
Date: Thu, 23 Feb 2023 10:14:17 -0800
Message-Id: <20230223181417.1384624-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230223181417.1384624-1-prestwoj@gmail.com>
References: <20230223181417.1384624-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers send this event when starting AP mode which means
the handshake object is NULL, causing a crash.
---
 src/netdev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 035dbd00..dbfdff1a 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -5145,8 +5145,12 @@ static void netdev_send_sa_query_delay(struct l_timeout *timeout,
 static void netdev_channel_switch_event(struct l_genl_msg *msg,
 					struct netdev *netdev)
 {
-	_auto_(l_free) struct band_chandef *chandef =
-						l_new(struct band_chandef, 1);
+	_auto_(l_free) struct band_chandef *chandef = NULL;
+
+	if (netdev->type != NL80211_IFTYPE_STATION)
+		return;
+
+	chandef = l_new(struct band_chandef, 1);
 
 	if (nl80211_parse_chandef(msg, chandef) < 0) {
 		l_debug("Couldn't parse operating channel info.");
-- 
2.34.3

