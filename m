Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A23220
	for <iwd@lists.linux.dev>; Fri, 24 Feb 2023 18:51:50 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id q11so446909plx.5
        for <iwd@lists.linux.dev>; Fri, 24 Feb 2023 10:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dcyPgkjbrJA46GHAk3B0cirRJhIvXa0OXkJXC0LW0Cg=;
        b=p9pC7Bg9jGM38C1fEzuT21B+w15jaQFWhQZyHwRvtkVBUBer4F9An0TD9iW9wqaqdU
         sg8r6SHkQBTX0aAehMtcEVqqxs+LSmSjXlKlaVjWhQt2t5kEBczliSKG0NrUZAAjUkKj
         KmbztsT73NLhBI58q620xfeamMWK/SLgwV6sw26KMyiYAjZ6/2G/I77cOOJxDS5RZdip
         J07kEarkNwc8NHfyEWDHjds6hKjBio9O/KTkUCRQ5YuenZMVhA9J96MWqTq6SBvNa6LJ
         0x9AWOeEBHvNYDkWrazzRXzwWVvRSDTLuKzzZar7XgaFIBe78fzEftg+0PpGFaiUbNGI
         ahHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcyPgkjbrJA46GHAk3B0cirRJhIvXa0OXkJXC0LW0Cg=;
        b=F/cFXnUvfxZ4rcghiKzoUWjrd0pyTD8Ylz6h82niM/l5/r4gLeYVPfXOPYOYTCDKDs
         Dhhc6u+MgPanKvRGXaJ5s5c+GRNrwcp4vBd9z62NCPFval8awy3buueSFqBDhko7h31g
         zV5Oxg5PMeNWQUx4YirjtbqodgQ/flNcOLdx2J+4y8UZMXo0F92rrraghzcSfk2QFmDW
         82tNq3HdRkTnCDhOpUf9ABml9kiU5CeTlyrIF6/Saq0OHIcDm+iQ2tblEGFNfMEBrJRY
         g95BYF029t+OODzMSvzVOmB7YuyRmVhBzkjKP1k5e/nWgtH2ssEs52RUajXstU9eAJlZ
         90Bg==
X-Gm-Message-State: AO0yUKVHQQ70o1B2p4uVb6kPyafHR7drChFVOST1+1UtI81/3JTnLmdG
	JD1KWpTCQhjNzqJk5CRw3+N84CyPR7A=
X-Google-Smtp-Source: AK7set+qd059AymrWyBohFTXVNO+8YyKBE2XjKyQ7FEoVXH/GGzBjdgvMSSNMlH0M47gcwhRQVEonA==
X-Received: by 2002:a05:6a20:7f83:b0:be:a3b2:cc7d with SMTP id d3-20020a056a207f8300b000bea3b2cc7dmr8588152pzj.6.1677264709611;
        Fri, 24 Feb 2023 10:51:49 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id b26-20020a65669a000000b004fd50189885sm8406550pgw.91.2023.02.24.10.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 10:51:49 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/2] ap: check FULL_AP_CLIENT_STATE for NEW_STATION
Date: Fri, 24 Feb 2023 10:51:46 -0800
Message-Id: <20230224185147.1462945-1-prestwoj@gmail.com>
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

