Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3AD4C62
	for <iwd@lists.linux.dev>; Wed,  3 Aug 2022 21:36:51 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id p18so282102plr.8
        for <iwd@lists.linux.dev>; Wed, 03 Aug 2022 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3DSUZ3LI0kIvemOjoG+kiGN/Th0kOn19dPHdZhnbnDE=;
        b=EfX1u72P+iH9JVx1NcE9VsJfZ2dXkEpzhVc6t9cCAKEoq/tX5q85vSFbzrEG4DO/Ks
         jyB/qzKW1ZCfiN2rV24Fr1il1tTNIAK3YhJJje13FvCW9LclLqvL7IAfaDtKoBo660Q5
         ApnEkeI6PrblU1xSRcW0bRJpcyNUdUJvupKQWiXgISLlOZndrC5rKZ48HSUtIa1MwNfC
         K+wYRK6JqHw5N2nS85/EAFS0O8XW0dLWjF4Vj+P+5NQzgQL1pYy+r4HNi5rMPyjUKi5Q
         58MgJJPAtJ8OPQgWrUm96CiElfhPjQTf/328JADBfomMxBmpczDAoPtCLiMDDsHHsCvh
         rZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3DSUZ3LI0kIvemOjoG+kiGN/Th0kOn19dPHdZhnbnDE=;
        b=GN3383fhl+Lqat/FMOzl1zurArNN7TmDMPWf481Yx4IyNwrSsQpjY+UQjGELQ89o2D
         5axFT1IDi8P7I9o1c8bZ2iVcuHUNuEmufOxPJL9EF4oazvWHb3wcbUSXiifWVEfQERC8
         T+fhhZK/A1RABULR/tKUUnarySSlsk/6BaJsr2dk1NDdrz39ecULRP4qNOhVom0Z6Sm8
         braikRWH9d1OlqZdP+KEG82zQ0SJnDN+z48mVsdUyBJ23elQi+4P75rb5m3BG77aur0L
         Qgd0LoqCtp/KiAoM+iZ7ONP+JRzbpU+lTnTAzor57USHM+l1+Z9Xgm7H/bsJLQjCTxGy
         51Gg==
X-Gm-Message-State: ACgBeo2ebqPXmiDPm5Uk1Ys64BIwrOPFbV9zc98HZO5ec6LKPe7zkQmd
	iOqK2XUpt65pl8FPPLoFnxNjGfBr4p8=
X-Google-Smtp-Source: AA6agR50ZJHkTddT+X8b9zz9vqUUfjbrhcRQEVLiGcymySPHz3mxJRqlkiIpCCka3HpSOjfunZRHlw==
X-Received: by 2002:a17:90b:224e:b0:1f4:ebed:16f6 with SMTP id hk14-20020a17090b224e00b001f4ebed16f6mr6823369pjb.17.1659562611295;
        Wed, 03 Aug 2022 14:36:51 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id b13-20020a65578d000000b00419fc2c27d8sm11527066pgr.43.2022.08.03.14.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:36:51 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 08/13] wiphy: add wiphy_regdom_is_updating
Date: Wed,  3 Aug 2022 14:36:39 -0700
Message-Id: <20220803213644.277534-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220803213644.277534-1-prestwoj@gmail.com>
References: <20220803213644.277534-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows a module to check the current status of the regdom
in case it misses the wiphy event (e.g. registers after the
STARTED event).
---
 src/wiphy.c | 5 +++++
 src/wiphy.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index b9f8009d..6a109655 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -905,6 +905,11 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 						out_data_rate);
 }
 
+bool wiphy_regdom_is_updating(struct wiphy *wiphy)
+{
+	return wiphy->pending_freqs != NULL;
+}
+
 uint32_t wiphy_state_watch_add(struct wiphy *wiphy,
 				wiphy_state_watch_func_t func,
 				void *user_data, wiphy_destroy_func_t destroy)
diff --git a/src/wiphy.h b/src/wiphy.h
index 070c8aea..1fea6c23 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -133,6 +133,7 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 				const void *ies, uint16_t ies_len,
 				const struct scan_bss *bss,
 				uint64_t *out_data_rate);
+bool wiphy_regdom_is_updating(struct wiphy *wiphy);
 
 uint32_t wiphy_state_watch_add(struct wiphy *wiphy,
 				wiphy_state_watch_func_t func, void *user_data,
-- 
2.34.3

