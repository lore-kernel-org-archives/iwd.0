Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD81F6A33F
	for <iwd@lists.linux.dev>; Tue,  5 Dec 2023 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChT8Jpy0"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4254cde7506so22555771cf.0
        for <iwd@lists.linux.dev>; Tue, 05 Dec 2023 09:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701798731; x=1702403531; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQeH0zRBYyWxptrh5YYxQQbhmyOd47dCrYD36f95I+o=;
        b=ChT8Jpy0JzCyS72fGR2iz0AMnqTmAuE4gpsaMdRXNoc5yVGNrJg4jd9cus1ONeQS27
         39qpnX7tSU4n8n0rgJOWu8m4/jU3IauwkPuwVt3GpY+evU3c7mgvvVjevjGwdvYqobi3
         04LbyXQkSEdzwIMoNeWC8IIijyVxzOFLzIQvKLrHI2jslCMiC2NkPdI/UDD3NHhXwDno
         1lKigmRrpC77FwAByLRR5+6I2Sqz2unuoN2nd4EPHQ5OuGrFvBmieVeMuR+GGTq4LoLO
         RkeiQR/93eGAwE0D+sh10OatTM9swLcdY2+l2f2S81FoxXMlvZVGIONrmddtSdmwv5Q4
         B6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701798731; x=1702403531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQeH0zRBYyWxptrh5YYxQQbhmyOd47dCrYD36f95I+o=;
        b=Gw1efDdvxR60BEooKC9o9B/F2u+eNV79HcH+pinrRDYgw6MT6MGzZRTFvd3rNThrOz
         PtZggSK5wfXLnCwwQHmJ8y3ME5nHgSdmv/g0s8kbYRD5HdoEbDkxPgRjg4QikmuJp7xm
         Ppd4CeH0Vld1qdzeUBG9eyzoJkEGZyXvZ+vPQSFzrZNYktiNScIvpmkxf/claNzoFHia
         D+BtJCDuzysSz+a5eUo3PnY75O2VI61O5ygYUDgHNpUaL98g+Cxr0u3llkJErWepvd4n
         tHQxJhqSnYOFTYXmqrMh8j2wYp8ZD/eHUIprzbzj6Jtbe6Qe1jCNvQ+btTvRQkHWeAt2
         9UTw==
X-Gm-Message-State: AOJu0YzFdCXcvnPkqpL4uzm5OCAWLptDjK8k367Qp6UL0L4C2dAOPfqD
	SEVZNYLN5EJQFVIz11RN7J2tzdkT9NU=
X-Google-Smtp-Source: AGHT+IHGSL8HMtikkfeX4qrvx54dqoZNPuwNU3pTniTM97JJVXHyHUbBQqn6sSK9bnabzEDN+CP1yw==
X-Received: by 2002:ad4:4190:0:b0:67a:bb3a:f809 with SMTP id e16-20020ad44190000000b0067abb3af809mr1521607qvp.122.1701798731455;
        Tue, 05 Dec 2023 09:52:11 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c7-20020a0ce147000000b0067ae01ab283sm192599qvl.36.2023.12.05.09.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 09:52:11 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] netdev: hack back in disconnect event
Date: Tue,  5 Dec 2023 09:52:03 -0800
Message-Id: <20231205175203.1935692-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205175203.1935692-1-prestwoj@gmail.com>
References: <20231205175203.1935692-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not sure how we want to address this, but FT is special in that it
has no connect_cb but can still trigger an associate timeout.
Currently if FT times out associating IWD will hang indefinitely.

This behavior can be tested with the prior autotest patches (without
this patch applied).

Fixes: 30c6a10f28 ("netdev: Separate connect_failed and disconnected paths")
---
 src/netdev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index f2e887b4..2d1120c4 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3045,7 +3045,13 @@ static void netdev_associate_event(struct l_genl_msg *msg,
 			 * out. The failed connection must be explicitly
 			 * initiated here.
 			 */
-			netdev_connect_failed(netdev,
+			if (!netdev->ap) {
+				if (netdev->event_filter)
+					netdev->event_filter(netdev,
+						NETDEV_EVENT_DISCONNECT_BY_SME,
+						NULL, netdev->user_data);
+			} else
+				netdev_connect_failed(netdev,
 					NETDEV_RESULT_ASSOCIATION_FAILED,
 					status_code);
 			return;
-- 
2.34.1

