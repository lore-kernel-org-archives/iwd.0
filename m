Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A9B4C82
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 18:58:00 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id z3so438197plb.1
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xaef9G1spqxBWHxWDLEPhZ4GFHqkP6QHeNcAFX5YXQg=;
        b=bPaam1ZecN7f4BLk+kLy7wRNhui8wvGpvoq63SsWCuESP0yqqvytr6IKK7siCr4wLq
         At8nE9eQPFznBKb8gA3uQrlD4ARmHsGEM4pJPzZPuTCHSx8XoaP8tqAy9g5+OfoVq4cP
         +7rZi/2RTkg+bpOq5zOCUSsLfRos0hriMDq/m/2Ua8+IfMdviddP2LBNVr7LTn5KSwAa
         cvcCiKokQutFr3PReNfv7Umd/88KFMsG+Ij7KHeQsMeqN94FiF3GMkNaUTWqqprv0u7z
         QLCPJvxNhpPq8r9B5a8ex+fFrcjXPCdL93G7+/GW5YcbCPzTV8GUT/96Rnnn/ZDUY2V9
         L13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xaef9G1spqxBWHxWDLEPhZ4GFHqkP6QHeNcAFX5YXQg=;
        b=M31wh7QlbHj3ctre4gdvr0SjxOFbrdLZxq73vt9LC1vPXqNKzjurWJ2lulTwStllpM
         SpN3veoKygBVI3EScjml7JJWCJz0yi+4hq+GiLnHBLz1TvmEjG7svxbGG0uOKex3GORj
         GG25c+McJcTTIxZoXhWn4lVjc+/PXixYEGNeYFrq2r1B3cgk/Y9vSCGm9etgiWyGJXV/
         isYlli5TRxdDqU/7kbmhWuWYqcb0o9I5bt1afFyU1m1V4BdrRvrAOPvlBCoWJaVYSZY9
         8dcgvpQNH+6SlDCuGpJHYOVSIOpFN/W383U9FVdy6JxtDe1ejOmQpvxq7IB+ubPwSXpi
         Sivw==
X-Gm-Message-State: AJIora/rKq8NwysIzU/w3XGu9ziuu6rYSFlehyXrBdi8p3BBng88R6HX
	djtO5mgbYb3HQa3axVo9FX9IbBlQseM=
X-Google-Smtp-Source: AGRyM1vDD5TuRWpeKT5I5b2DDT0I0ftQZUmFoD3ppoP/TeDrGbuKbZ4YeVcOzu5EHi6Ojh0aVG82yg==
X-Received: by 2002:a17:90b:1bc7:b0:1ef:d6f3:b3d0 with SMTP id oa7-20020a17090b1bc700b001efd6f3b3d0mr896203pjb.4.1658257080035;
        Tue, 19 Jul 2022 11:58:00 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b0016c68b56be7sm11937785plg.158.2022.07.19.11.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:57:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 05/12] wiphy: set band->freq when parsing band info
Date: Tue, 19 Jul 2022 11:55:37 -0700
Message-Id: <20220719185544.456727-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719185544.456727-1-prestwoj@gmail.com>
References: <20220719185544.456727-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This sets the band into the 'band' structure in order to support
HE data rates.
---
 src/wiphy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index a52d0941..22305d5d 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1203,16 +1203,20 @@ static void parse_supported_bands(struct wiphy *wiphy,
 	while (l_genl_attr_next(bands, &type, NULL, NULL)) {
 		struct band **bandp;
 		struct band *band;
+		enum band_freq freq;
 
 		switch (type) {
 		case NL80211_BAND_2GHZ:
 			bandp = &wiphy->band_2g;
+			freq = BAND_FREQ_2_4_GHZ;
 			break;
 		case NL80211_BAND_5GHZ:
 			bandp = &wiphy->band_5g;
+			freq = BAND_FREQ_5_GHZ;
 			break;
 		case NL80211_BAND_6GHZ:
 			bandp = &wiphy->band_6g;
+			freq = BAND_FREQ_6_GHZ;
 			break;
 		default:
 			continue;
@@ -1226,6 +1230,8 @@ static void parse_supported_bands(struct wiphy *wiphy,
 			if (!band)
 				continue;
 
+			band->freq = freq;
+
 			/* Reset iter to beginning */
 			if (!l_genl_attr_recurse(bands, &attr)) {
 				band_free(band);
-- 
2.34.1

