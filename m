Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D108820
	for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 22:01:46 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id v9so11235528pjk.0
        for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 15:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681164106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=po88psfApkRhiOaO8e1T1smH/0ARPZGbU3XkdwXaLJM=;
        b=BmjToActnEcMQ3jQP362941rRkhhWQFSfIOGMY69eiItWCePacsyL4wKWCF0StPU91
         E7YYb8erXX9uVoSaSz5Vq8fdnAnQMZflT389wSsNU0SOOTZvVL3iTmy52dN4eFDMbjwo
         nfOHQVjvQSB+OoOYN6dCNrzxeX8WtZxY/0ZnZAuhcBCEN91Kg9/qbbnnnTLom3/dXKDD
         LV5w33NDhWB9q2UjUMvTn2qP2CeUkvnHQonWheri3S++W+Z6J+2hkT9fV4f3/bM9pGep
         PzmADe361tbGPTA1MMsoXOATvs8lLPNucPrlMPQmYyfOdGMHvELUnUsaioAAsd++nstG
         TKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681164106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=po88psfApkRhiOaO8e1T1smH/0ARPZGbU3XkdwXaLJM=;
        b=qTKe8KEpDuzAJde+dIqjxzXvDdYeX4pKoKX0lKSJtERjXxoTYMihfehuC55uXwhXGj
         gFLkJdyMn9crzz93kPI/TsU002qZPktzitbwl9MmzIQbYCmFQFmjs+mrvs8JP4Fbr2Ls
         jPqCIelwLY1pPyVJCz2tQ8xMPR8sqa1awVu6Xq8/0eLrP7yQg91sHiZgBNEBaIGj9XUw
         VCOm6FaNHR0PPNPHOf7PHJuuKzJUc2Wmh0oiDaL/SnigTQ/TI3G8E2eajU8YzXK75v19
         7NdQDrWh8iSouj4LDPEnFBx715c1KHk+q0Qm2NVAZuGS5H2+E+EBoYPiUhblCnlhFt/p
         XcpQ==
X-Gm-Message-State: AAQBX9eCSy+/inNnPGjhweML4nkUrwq0KjiOhxwCM/AL1yLfZnH75lIy
	NZD289Lj51tmYu0mVzpzmXOyUF9TGSHAuw==
X-Google-Smtp-Source: AKy350Zz0epVJ6ab8KFHMrwaJY2Ao7dXONssG8y9AoVUBctXF7mYfAz8HIR4vOrNfk2ydJtLDxk3tQ==
X-Received: by 2002:a17:903:2452:b0:1a6:3def:6007 with SMTP id l18-20020a170903245200b001a63def6007mr635699pls.7.1681164106131;
        Mon, 10 Apr 2023 15:01:46 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001a2806ae2f7sm8263372plr.83.2023.04.10.15.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:01:45 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 8/9] wiphy: add FT-8021X-SHA384 to supported AKMs
Date: Mon, 10 Apr 2023 15:01:34 -0700
Message-Id: <20230410220135.373872-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230410220135.373872-1-prestwoj@gmail.com>
References: <20230410220135.373872-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This AKM is now possible to choose from the list.
---
 src/wiphy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 2db2d2cd..40ab0a0b 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -281,6 +281,12 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *wiphy,
 				return IE_RSN_AKM_SUITE_FILS_SHA256;
 		}
 
+		if ((info->akm_suites &
+				IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384) &&
+				bss->rsne && bss->mde_present &&
+				wiphy->support_cmds_auth_assoc)
+			return IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384;
+
 		if ((info->akm_suites & IE_RSN_AKM_SUITE_FT_OVER_8021X) &&
 				bss->rsne && bss->mde_present &&
 				wiphy->support_cmds_auth_assoc)
-- 
2.25.1

