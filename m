Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FD24C8C
	for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 21:18:56 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id y136so19314511pfb.3
        for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=4TLkgr+QGSGcjHzoOXFQHNub61vW0zMl/0KFD8JbmTg=;
        b=eACxiz1RS/5scn6wZrAA6XMq3tQA81eO4BZSbL7V4/xDJHKVrX9AUha/6j5N8/5Lr+
         tarDK2Dk6POR3rSqrU5iTePCZkhqpG5oYoiyLqYbRv0xmWmxOcmLwMvGBJIqJ4WvYNge
         IApah4Jqe7cu0E4fpZFXtkIgQ4/ad/ZyUyAyPwZrwIcIHuXajY/avxIOXGEXOdzzWhia
         RAdyNY/3LvNyiMMW2x+qsbe9UAU7IGl9F5fCzTkhk6QECGZBRlU5po2M13cJvYFxaUfL
         2U4elSNBhUv9uBrAsXkfoeRqudp329qdemISVet++CFdFZYbOkPN0RP/AM+SntgdqzEx
         S26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=4TLkgr+QGSGcjHzoOXFQHNub61vW0zMl/0KFD8JbmTg=;
        b=Iali6bWfrX1Gc0sMeQlg0aliwv0gj7Xmm5Dm30QfxN/sKIDDvk2INjY8C6Y4B99Kf4
         NAzHSL72+ANFn5WZSpm0i9FLH5odRNLy92b4608XRxMRyRznwCauhwre5b1T49Gx8W8b
         C7icRj5sT1gSwr334tUVGwcplIphwmjL9qgWasMwn4+q0oT7D0/qzvBwLjKU2wyCegrJ
         7DVn4iBfB6V4r32aLzEXw6JPPxj50E0sIl/AhYp1fvsM2BnwX1auxbz/GBV3fvZXuT+f
         nGPGG831NB/3OnOX7+nA9fa1LE1es479LpD1oJiG+BR0mSpnQhohLBrPv8SgO26foy3t
         Yylg==
X-Gm-Message-State: ACrzQf2trEjb9V1RjbM9ESjP86ZdEMhCYJuUxMQRKvHMWQmISOhvItsE
	3PjLH7eGJoB99mzi2/xWe2MOUITvhCk=
X-Google-Smtp-Source: AMsMyM5oc4OvxVvTE7syfEr2uvoQ6MVjVrELj/iocB6sztRSybfVK3vpBo0hDaph/BV+x/o2TZno6A==
X-Received: by 2002:a05:6a00:1342:b0:545:4d30:eecb with SMTP id k2-20020a056a00134200b005454d30eecbmr1715092pfu.69.1663276735416;
        Thu, 15 Sep 2022 14:18:55 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id 2-20020a621902000000b0054aa69bc192sm125139pfz.72.2022.09.15.14.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 14:18:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/2] mpdu: fix timestamp size in mpdu frames
Date: Thu, 15 Sep 2022 14:18:52 -0700
Message-Id: <20220915211853.1093078-1-prestwoj@gmail.com>
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

v2:
 * Use __le64 rather than uint64_t

diff --git a/src/mpdu.h b/src/mpdu.h
index 36fe2470..9a825f2a 100644
--- a/src/mpdu.h
+++ b/src/mpdu.h
@@ -374,7 +374,7 @@ struct mmpdu_probe_request {
 
 /* 802.11, Section 8.3.3.10 */
 struct mmpdu_probe_response {
-	uint8_t timestamp;
+	__le64 timestamp;
 	__le16 beacon_interval;
 	struct mmpdu_field_capability capability;
 	uint8_t ies[0];
@@ -382,14 +382,14 @@ struct mmpdu_probe_response {
 
 /* 802.11, Section 8.3.3.15 */
 struct mmpdu_timing_advertisement {
-	uint8_t timestamp;
+	__le64 timestamp;
 	struct mmpdu_field_capability capability;
 	uint8_t ies[0];
 } __attribute__ ((packed));
 
 /* 802.11, Section 8.3.3.2 */
 struct mmpdu_beacon {
-	uint8_t timestamp;
+	__le64 timestamp;
 	__le16 beacon_interval;
 	struct mmpdu_field_capability capability;
 	uint8_t ies[0];
-- 
2.34.3

