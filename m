Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9B7AD27
	for <iwd@lists.linux.dev>; Fri, 24 Feb 2023 17:59:32 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so9375pjp.2
        for <iwd@lists.linux.dev>; Fri, 24 Feb 2023 09:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dcyPgkjbrJA46GHAk3B0cirRJhIvXa0OXkJXC0LW0Cg=;
        b=Uqr8pmIl5D4B6WGHBqQI09BNlARE5lm0C5H1OS5J0lwgZYsxpkg6jQDgkmeac7/4GO
         KktfWuR9AQYzqGO4bcEZPcLrHfeFzBQ7zlpJyFGjt24IEPw5W8rOge60BWja1LfAiWQw
         Q8/gjHC++ll/vjUPoxef95axOgJ6QxxL/nMr6eGCJujB31dA0obrcSebZknaG76kqjXv
         fKpXu28QcQP1IBfia7X0o5TMVZ0ghu5z/UEylPqz4BASwaLRHdxfvf5n9AktgCUK/6hL
         lf3SKJhBlw4hecmiIMR2IEnlgnHHelvRYYvSbKhg27KDp8kdPtSJE3If9d0ms8wx6WZe
         THXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcyPgkjbrJA46GHAk3B0cirRJhIvXa0OXkJXC0LW0Cg=;
        b=ITde03glbFhCWT/Np8DArWmVlDrfLmm/vCwud6bjCp31GrRrPe6gC44Zxi2xTh74sZ
         O8qf5vEH+cQecO0oDKOM+wRWv0rYtXTEIDKF41wUwynmSSJ15Sxty8wLD2LZD21XFYYT
         DV1XpLAiZfbM+c7STmf3JFGGL6X0DG5ZmaDtcf1tzAukiq6/vyyoHa8Zbxhg6L6YOZYj
         5oC/Ng+KMdSUo/HjjUwyE8qieH7qJlMFNnuJBgtwNcILH5ZbxehroVQIzhVhCKU28N5u
         YulKWyc6HDSRr8SS6NNOnp5oRwtabOIcdFktSfbkYkWxSsg1VSorPeo9OH4nMISqu1zz
         KMtg==
X-Gm-Message-State: AO0yUKUaEhoEzjMNjzeKWq4clX2bTKNsG5Ep+Li5SpqAdAUW0lHkhC75
	h+csnO/EeX7vnkLfP59ZmLY8cE16Pqk=
X-Google-Smtp-Source: AK7set9LTUUDVioCT7kxLpJv/HWiX1DEXroyYlkIXbGVB20JyF08bJdy99DBaKKvs+0x8RZKh8sqQg==
X-Received: by 2002:a05:6a20:728e:b0:cc:a5d4:c334 with SMTP id o14-20020a056a20728e00b000cca5d4c334mr1086724pzk.10.1677261571347;
        Fri, 24 Feb 2023 09:59:31 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7918f000000b005a8f1d76d46sm8763749pfa.13.2023.02.24.09.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 09:59:30 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] ap: check FULL_AP_CLIENT_STATE for NEW_STATION
Date: Fri, 24 Feb 2023 09:59:27 -0800
Message-Id: <20230224175928.1460558-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nl80211 has a check which returns -EINVAL for NEW_STATION if this
feature is not enabled and the mask contains Authenticated/Associated
flags.
---
 src/ap.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 2867e1ab..fee5a6c8 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -1643,19 +1643,22 @@ static struct l_genl_msg *ap_build_cmd_new_station(struct sta_state *sta)
 {
 	struct l_genl_msg *msg;
 	uint32_t ifindex = netdev_get_ifindex(sta->ap->netdev);
-	/*
-	 * This should hopefully work both with and without
-	 * NL80211_FEATURE_FULL_AP_CLIENT_STATE.
-	 */
 	struct nl80211_sta_flag_update flags = {
-		.mask = (1 << NL80211_STA_FLAG_AUTHENTICATED) |
-			(1 << NL80211_STA_FLAG_ASSOCIATED) |
-			(1 << NL80211_STA_FLAG_AUTHORIZED) |
+		.mask = (1 << NL80211_STA_FLAG_AUTHORIZED) |
 			(1 << NL80211_STA_FLAG_MFP),
 		.set = (1 << NL80211_STA_FLAG_AUTHENTICATED) |
 			(1 << NL80211_STA_FLAG_ASSOCIATED),
 	};
 
+	/*
+	 * Without this feature nl80211 rejects NEW_STATION if the mask contains
+	 * auth/assoc flags
+	 */
+	if (wiphy_has_feature(netdev_get_wiphy(sta->ap->netdev),
+				NL80211_FEATURE_FULL_AP_CLIENT_STATE))
+		flags.mask |= (1 << NL80211_STA_FLAG_ASSOCIATED) |
+				(1 << NL80211_STA_FLAG_AUTHENTICATED);
+
 	msg = l_genl_msg_new_sized(NL80211_CMD_NEW_STATION, 300);
 
 	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
-- 
2.34.3

