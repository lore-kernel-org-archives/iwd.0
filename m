Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E03C538E
	for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 22:07:59 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id ge9so7616691pjb.1
        for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 15:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GaJZX2ya3j93rXESO11rEUA/ZBWXU/S0A7p8ZqNq65E=;
        b=SrVrkDwE4FKg7GSd1MU59kWfpveZEyRFQm9EjFknK2VqHWLj5eEeRMdql2EcQDBdjJ
         HiRPhFwUVi99vktJItw4fNfL2z2j9FeWs8GJwVPTqUcMQ8fhqbIFKdqPU/LXUZVLbnFp
         bFMZZI3lsutUc7t6zBzx3i2LlNGgC4r8rmXknBQst74wJGddKmeA91kGjkI4MIwIhUNW
         1ZIf5WXnSRO5nNCjBTy5BGUick54B7nOHyOHmiMPabWZmESZ1dqmQxGz3/WV4h34EonM
         bm72MmmzTTj/32qh2M9IA6FnaQsevIgloQ/0KKFgZo3eC9xSXMcHfhORo+Sea5loMka/
         4Hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GaJZX2ya3j93rXESO11rEUA/ZBWXU/S0A7p8ZqNq65E=;
        b=gs0PNfP3XhT1YQmVb+FttrHc2RnabWnzniEintO5uPHAWiFVFzWtM4VTpFJnImy2L4
         Z9UpXcxp3A37louJg8sYpart61HEuNo0ntuefOVn7Cfh2dWdF7Ju/QjuEl6PiveQgQDJ
         kA0iUcsFn0+gBDHHmHht3Rh5L/QwoC4NWIPQQvjn6tx6Zhpg78eYifcMTlHpzubu72Ut
         qTnusq4ubd/FxTWFP9HvGsoHDlNzretfZviM0g9XNcxvbGURuq+U5/6/CMQKKfLCsY4O
         t8WdODVMi3t6Ss0B2zycNwQiicjVfn+DnFsQ/tATWcc+IqHY/H+asLrOYTUKmCskctsj
         LKaA==
X-Gm-Message-State: ACrzQf0Y9A8c/Mjf25c4vzEsDZPcmNd4SVWFHedKhFy89EusFTbymct5
	BBtdswnRxb32BFD6MxyIE2L8zdUgvm4=
X-Google-Smtp-Source: AMsMyM7Ink2qeGN9qaMET2OCPUBgGZRI0rITB3JxPNLhz2xi46jCYEl7KozhoZXq+CBubeS+HaqoJw==
X-Received: by 2002:a17:902:8215:b0:178:6946:a282 with SMTP id x21-20020a170902821500b001786946a282mr1669552pln.162.1663279678654;
        Thu, 15 Sep 2022 15:07:58 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id k2-20020a6555c2000000b0041c0c9c0072sm12147165pgs.64.2022.09.15.15.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 15:07:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 11/14] netdev: check for authentication for FT-over-DS
Date: Thu, 15 Sep 2022 15:07:38 -0700
Message-Id: <20220915220741.1128728-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220915220741.1128728-1-prestwoj@gmail.com>
References: <20220915220741.1128728-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the target BSS never authenticated/responded to the initial
action frames there is no point in trying to associate. Any
attempt would fail, and cause a disconnect. Check this and return
-ENOENT so the caller can choose a different BSS.
---
 src/netdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index cfb741db..52ad89ba 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4578,6 +4578,9 @@ int netdev_fast_transition_over_ds(struct netdev *netdev,
 			l_get_le16(target_bss->mde))
 		return -EINVAL;
 
+	if (!ft_sm_can_associate(netdev->ft_sm, target_bss))
+		return -ENOENT;
+
 	netdev->connect_cb = cb;
 
 	prepare_ft(netdev, target_bss->addr, target_bss->frequency);
-- 
2.34.3

