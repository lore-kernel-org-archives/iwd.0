Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B32570
	for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 22:32:02 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id fs14so7915742pjb.5
        for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 15:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=sF9i8MLvxNSrlwE2hoOKZKXxn1AvGyglsZOa9AZ2mcE=;
        b=mkkKWOHrTIcKg027/eZUIPna8DDX/KMVNqkEgLalwL8XD8uzwhyoQC1SJPx/TJI5fX
         HVHTILrBOYpqNc37ahC9hYIuR7sEE21yFjLQ2X3ySHYk1sQuSHfykAIyZpihIKwlbv2y
         SeJEZc1Ua7cZB40RzXVrGC/kpIprwtPKG4FGjiH++YzUKhD5JhMEWC5y55j9/tA1gnlf
         EkzSzw1c3UBOQzu1bT+qmOJRn89o8ElIHj8ZjA8I2e9HlwgvRoJxP5unP+ltoopUhQqo
         UjwaU3K5+4kFUlvJEM9z8vtL+dkUcf5cxsa6lLTyxPMAPYjNTRHRC2v1EDqhHIBKPAkL
         C4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sF9i8MLvxNSrlwE2hoOKZKXxn1AvGyglsZOa9AZ2mcE=;
        b=JTwmfx33Th6KKWaAB4dbP0kYFWSMbUkRh92G8lwLQ/GgBA+Yb3vvpEnbSYg/t95g5b
         tygBOqXzglX4MywY1QBZa1DtFi8VMzVl+dEgIHz8iF1NvZvOQtktMNociAAK3n4hHCFO
         hNYPGYRLd/oqe5TOQASLBSQIAwdnB7/A2Kgtbq/oASVQaM5QT2wu+92F+8kGzdlCQnN7
         K64Vuc4ek8WwYy+0wA4SbKLI5doWOxExU0AMC1sYYGIynHwV1MhFkNm2B0GXzAxnoDKi
         hZPdhi7apcjnH/djZHdrFNdu9tVNq9MoKU6bTg5CnSAN/o9ySoIAei2xDMDN3Um3iCZw
         U4Vg==
X-Gm-Message-State: ACrzQf2l/aEjLsISNyBy5dTmAq4eImXsENG/kE/cFSLjWOeMOJ2uNGjR
	ReB1suAtxX5F0HaT10BOr6qxj/aWA1Y=
X-Google-Smtp-Source: AMsMyM4fM8dij4iZy1boKUsBS8YIFN51j3OdzsG7nbfXdaCvVFIl+gUCsACRk8vOzPs8Mzuw8uZzkg==
X-Received: by 2002:a17:90b:3a85:b0:203:2044:c26 with SMTP id om5-20020a17090b3a8500b0020320440c26mr363031pjb.109.1663799521812;
        Wed, 21 Sep 2022 15:32:01 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id r10-20020a63e50a000000b00438c0571456sm2393135pgh.24.2022.09.21.15.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:32:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 03/15] wiphy: add new work priority for FT
Date: Wed, 21 Sep 2022 15:31:46 -0700
Message-Id: <20220921223158.704658-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220921223158.704658-1-prestwoj@gmail.com>
References: <20220921223158.704658-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FT is special in that it really should not be interrupted. Since
FRAME/OFFCHANNEL have the highest priority we run the risk of
DPP or some other offchannel operation interfering with FT.
---
 src/wiphy.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/wiphy.h b/src/wiphy.h
index 2159fc00..9cd18451 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -46,11 +46,12 @@ struct wiphy_radio_work_item {
 };
 
 enum {
-	WIPHY_WORK_PRIORITY_FRAME = 0,
-	WIPHY_WORK_PRIORITY_OFFCHANNEL = 0,
-	WIPHY_WORK_PRIORITY_CONNECT = 1,
-	WIPHY_WORK_PRIORITY_SCAN = 2,
-	WIPHY_WORK_PRIORITY_PERIODIC_SCAN = 3,
+	WIPHY_WORK_PRIORITY_FT = 0,
+	WIPHY_WORK_PRIORITY_FRAME = 1,
+	WIPHY_WORK_PRIORITY_OFFCHANNEL = 1,
+	WIPHY_WORK_PRIORITY_CONNECT = 2,
+	WIPHY_WORK_PRIORITY_SCAN = 3,
+	WIPHY_WORK_PRIORITY_PERIODIC_SCAN = 4,
 };
 
 enum wiphy_state_watch_event {
-- 
2.34.3

