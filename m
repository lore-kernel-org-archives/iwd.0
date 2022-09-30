Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0A65C8C
	for <iwd@lists.linux.dev>; Fri, 30 Sep 2022 23:28:15 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id 10so1564017pli.0
        for <iwd@lists.linux.dev>; Fri, 30 Sep 2022 16:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Am6rwPGAzyxKnklm5MTt++rEqsudpEW14wY+h1lBoTU=;
        b=P1sacYl6oVIcNCnkNpiwvU5iuMhqHUoXQWmosgDdbmBU27KHiZ6vRYprqBnXz/vx47
         7J5+Wu+dEfUkAUKPPlthjEa2sSNvPFdS2pPJD0cEV7BdiKLOGVNYaGXSv5zobAVRMIuN
         hpJ6c2D3MLKSqZMF+czKcPRiNUvp1GqI7wVhaa6P/wk3LUj6K4R6B4M2aynmQMRsnUtH
         LCbZpzbd0+83L9Xa5srfYgfpPSRxSDa6uJTHNt5r/D54pLRASdv5fjWFWZoAUk4jy6Wq
         MG4A36UpSl63ZsxL8QFKkfUW0t3BOdqjlwnv3VqIZsHddmqrFHRamE9zvVkBMwLcv50G
         dbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Am6rwPGAzyxKnklm5MTt++rEqsudpEW14wY+h1lBoTU=;
        b=l739Dfsp8DiqvYBBunDXDwPJ0K3t7KXyG92Y+aTa++pxHm+qAY9dI9FpFIWmXHoNnf
         TKSkIDwDTs+gBGMJuIN0+XxI9/T3YPQQV41hivkH+OvT+qCAl+nzqhXiCAVc6HPPPfir
         Ja/ZuuPeFRyiFSRsD89VImdzxxivJ57CLYaWLqhT5r0xgi7xFIshORhGzUFS5Y+Z7j0V
         6xb2fwkUvgjOPsuJJBLAT9Vn+0cvEMgyuH+zO1Rl0GHPh4aV7KmsnQTEiVU03dGF6Cim
         cBDEnE0VCJnPhPOyhQ6xnf6ZSu9naFxTbTlZ6DEfkjp/RaE3oh+hGk1vE+aN+GRjbZ3x
         QOTQ==
X-Gm-Message-State: ACrzQf0xbTqunObZAMWEqbdUKny1s7uGCKLeTW4lrJGc43m5hsiPvsvy
	kIXuUjZLtIv+S/EfsIuQ4vZ8xkKEyaY=
X-Google-Smtp-Source: AMsMyM6lBwcwjSujwXKk1QA77Frz7+24zPxoFkDfTS9b8hb1UgFIpFB94zTrDREAEzjvYTymmDPOXw==
X-Received: by 2002:a17:902:db12:b0:176:d6a4:53ab with SMTP id m18-20020a170902db1200b00176d6a453abmr11511346plx.113.1664580494750;
        Fri, 30 Sep 2022 16:28:14 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e5c200b001767f6f04efsm2467893plf.242.2022.09.30.16.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 16:28:13 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] monitor: change Port ID to %u print
Date: Fri, 30 Sep 2022 16:28:09 -0700
Message-Id: <20220930232809.810726-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220930232809.810726-1-prestwoj@gmail.com>
References: <20220930232809.810726-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The port ID is a u32 so print with %u rather than %d
---
 monitor/nlmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 5ae014e4..2e232130 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -7952,7 +7952,7 @@ static void print_nlmsghdr(const struct timeval *tv,
 							nlmsg->nlmsg_flags);
 	print_field("Sequence number: %u (0x%08x)",
 					nlmsg->nlmsg_seq, nlmsg->nlmsg_seq);
-	print_field("Port ID: %d", nlmsg->nlmsg_pid);
+	print_field("Port ID: %u", nlmsg->nlmsg_pid);
 }
 
 static void print_nlmsg(const struct timeval *tv, const struct nlmsghdr *nlmsg)
-- 
2.34.3

