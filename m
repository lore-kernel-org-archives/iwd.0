Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B094403
	for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 20:55:57 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id s18so13563767plr.4
        for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 13:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=IlT/6XyqP0a7mRpx1Cddn97vcKDkSytAjyVoAExYO40=;
        b=d3N01LqgzDCFwv/mnncgAeWzkYuVi7yBI4HSHaz2e77mJINDOqTidoSfgPWAXYzKzR
         dQXE5mZdp/co0pRF7nExAAES6ykVxbqTKsoIazWJ1IMLAhnKoIrTYF1dSjLp1IydSYyt
         OCp0Z43xgP8llIyc5EaU8lebWAw1M6emSBBOLjE1qUNqdV7cqU+mSrxtmfFlDjhhgZ0m
         Q62QUPCtrde4C0yka9EBj3EyLn0Y3qeNvX4hzbVJnKSOZfP+KvbMgWNmZv9mheCa4b2q
         VnDy7RVpwZpO1I27BFRJtpNVMAymTQWmlCx3z4wtLss1z87xDqRMsevkvtUVbGihvCRk
         fCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=IlT/6XyqP0a7mRpx1Cddn97vcKDkSytAjyVoAExYO40=;
        b=gx8PTcCJoKijg/K5ZUb7uL4aXexFGgMXQhGbKfDWye2RDmLZmXqko7O/HQuWETdbkW
         0hx3ORamisJqQN0J1dhg3oDQ+3XxeAwvbKjF2JU+CWdRiuRbwq5ApHGCSFOjmRA4EIaY
         ujD6Xx4O733GipDYGT7ylT4w+Yy2aRl9oCj4Kd863yDnoEADlHQtCq1Olx6OYkgcCUhl
         /7J4e9iH2OU/UO7BRHw3JvJy/O96BrNu8OKepAI4YJhZ0gJCbSb3vKm/f8xqvAZ1CPJ4
         j1BYZrTwx/QIardaXvSj3YAhbKaZD3Fc2uuJ70L5jH0uu+I0qkxLNb7V3NYh/FIjvsq4
         k9Lw==
X-Gm-Message-State: ACrzQf3PJASKCllaN383+UcaiBmPqVx8dBoHi02m7ego10K7/MVEEDDV
	oa9OKOS/rcQf7V1Sldu8cuNY67YfrwM=
X-Google-Smtp-Source: AMsMyM4Qqezokii7X6zMbwKzdzmt+6xnuf9+2wfwLkpVeVAVQTb/Cq4xYWAuOdL+a1td9dm02zRBlw==
X-Received: by 2002:a17:903:2015:b0:178:8022:ff1 with SMTP id s21-20020a170903201500b0017880220ff1mr381096pla.18.1663275356832;
        Thu, 15 Sep 2022 13:55:56 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id e19-20020a656bd3000000b004351358f056sm11923834pgw.85.2022.09.15.13.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 13:55:56 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] mpdu: fix timestamp size in mpdu frames
Date: Thu, 15 Sep 2022 13:55:53 -0700
Message-Id: <20220915205554.1061014-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Beacons, probe responses and timing advertisements were only using
1 byte for the timestamps which should be 8 bytes.
---
 src/mpdu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/mpdu.h b/src/mpdu.h
index 36fe2470..32aa5712 100644
--- a/src/mpdu.h
+++ b/src/mpdu.h
@@ -374,7 +374,7 @@ struct mmpdu_probe_request {
 
 /* 802.11, Section 8.3.3.10 */
 struct mmpdu_probe_response {
-	uint8_t timestamp;
+	uint64_t timestamp;
 	__le16 beacon_interval;
 	struct mmpdu_field_capability capability;
 	uint8_t ies[0];
@@ -382,14 +382,14 @@ struct mmpdu_probe_response {
 
 /* 802.11, Section 8.3.3.15 */
 struct mmpdu_timing_advertisement {
-	uint8_t timestamp;
+	uint64_t timestamp;
 	struct mmpdu_field_capability capability;
 	uint8_t ies[0];
 } __attribute__ ((packed));
 
 /* 802.11, Section 8.3.3.2 */
 struct mmpdu_beacon {
-	uint8_t timestamp;
+	uint64_t timestamp;
 	__le16 beacon_interval;
 	struct mmpdu_field_capability capability;
 	uint8_t ies[0];
-- 
2.34.3

