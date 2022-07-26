Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1E05385
	for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 17:09:28 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id w10so2334083plq.0
        for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 10:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ldr+thN1768lc2hRHqCnC5Ptsz0dCZYYSWJQ9WpU2OM=;
        b=i2orZ/xSZkgEDxDTq34a8EW3Le1JGX18SHQ3ENtae3OFtAO5uJERUR/ezDJ+3QUib7
         wiPwVB3t6OV1oScF6KOQ8d2vD4l9h3PIuAlIVREjLhEOrLkzOvtwzFsyWSK+2jE5HEGw
         6cpnwFp4CNjKUW4vOKH0jWYz74nrAc1LZhWwtgYUTKHB10yFwDTCmgu3mrdo9s34MBDn
         J3NvOEFoeQxueCB4TdGTsgYLK5tBe61Bpbqo36z1hTkt+nFHKkoyJrea36i8RHCkfn7b
         xRA39I5pxjA92P3CYOvzKScr3xq9XIWR+snTM7kyNyK/Rej4LLX3ZucVs73vMW+8zBbF
         2TOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ldr+thN1768lc2hRHqCnC5Ptsz0dCZYYSWJQ9WpU2OM=;
        b=SZ7U7MldLXSg8mX/ptL1EHQat0h5I9pa5e50l8MybZhPa8t00maj7Bk5n0woX0TK08
         Y883f2DVwh0JRsceH9VagacJwN6eZE6QEnHcraEuBPRNa4HtGDJIWcIX5mgYGUiaTL2H
         7F7o0NQ5K5EKoz2niQFLYNXZo1Asqa9j0ukUmkpCnoC1y+a8TrUw1onfO0YpMJhIRP1k
         o4vkIm6PxAVObQcuy5LwoON+vJXsW2TYAK7B/wsuhKWHqTb2kZyIPDv3Fx84X/ELZvnt
         P/ebB7jdjzDWUqlXK4WM7wci3O509nOzGyPTJrNJwwPl8M3lk8uj8G0L0hW0mUgWpBiC
         6ijQ==
X-Gm-Message-State: AJIora9BDE9t+ubT5kn7AVuMnI07aApw5rMDVoFa0tWsCzQFvmxnGekv
	MVzQazn/qsPCuMLgBJmsDJ0Tq2hlDt8=
X-Google-Smtp-Source: AGRyM1uvs/VbW7LiGvZFld9xt4NncoCU03lN2zFvpYURVUs77g5HT805nYnzDBP2zJs+7w2I+06jsg==
X-Received: by 2002:a17:90b:4a10:b0:1f2:a45c:125 with SMTP id kk16-20020a17090b4a1000b001f2a45c0125mr192796pjb.246.1658855368238;
        Tue, 26 Jul 2022 10:09:28 -0700 (PDT)
Received: from jprestwo-xps.none (h208-100-169-68.bendor.broadband.dynamic.tds.net. [208.100.169.68])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b0016c09e23b18sm11778694pli.154.2022.07.26.10.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:09:27 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 04/10] wiphy: fix runtime error from bit shift
Date: Tue, 26 Jul 2022 10:09:14 -0700
Message-Id: <20220726170920.15929-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220726170920.15929-1-prestwoj@gmail.com>
References: <20220726170920.15929-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compiler treated the '1' as an int type which was not big enough
to hold a bit shift of 31:

runtime error: left shift of 1 by 31 places cannot be represented in
		type 'int'

Instead of doing the iftype check manually, refactor
wiphy_get_supported_iftypes by adding a subroutine which just parses
out iftypes from a mask into a char** list. This removes the need to
case each iftype into a string.
---
 src/wiphy.c | 48 ++++++++++++++----------------------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 09b99fb2..98bd3aa4 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -707,17 +707,16 @@ bool wiphy_constrain_freq_set(const struct wiphy *wiphy,
 	return true;
 }
 
-static char **wiphy_get_supported_iftypes(struct wiphy *wiphy, uint16_t mask)
+static char **wiphy_iftype_mask_to_str(uint16_t mask)
 {
-	uint16_t supported_mask = wiphy->supported_iftypes & mask;
-	char **ret = l_new(char *, __builtin_popcount(supported_mask) + 1);
+	char **ret = l_new(char *, __builtin_popcount(mask) + 1);
 	unsigned int i;
 	unsigned int j;
 
-	for (j = 0, i = 0; i < sizeof(supported_mask) * 8; i++) {
+	for (j = 0, i = 0; i < sizeof(mask) * 8; i++) {
 		const char *str;
 
-		if (!(supported_mask & (1 << i)))
+		if (!(mask & (1 << i)))
 			continue;
 
 		str = netdev_iftype_to_string(i + 1);
@@ -728,6 +727,11 @@ static char **wiphy_get_supported_iftypes(struct wiphy *wiphy, uint16_t mask)
 	return ret;
 }
 
+static char **wiphy_get_supported_iftypes(struct wiphy *wiphy, uint16_t mask)
+{
+	return wiphy_iftype_mask_to_str(wiphy->supported_iftypes & mask);
+}
+
 bool wiphy_supports_iftype(struct wiphy *wiphy, uint32_t iftype)
 {
 	if (iftype > sizeof(wiphy->supported_iftypes) * 8)
@@ -951,38 +955,14 @@ static void wiphy_print_mcs_info(const uint8_t *mcs_map,
 static void wiphy_print_he_capabilities(struct band *band,
 				const struct band_he_capabilities *he_cap)
 {
-	int i;
-	char type_buf[128];
-	char *s = type_buf;
+	_auto_(l_strv_free) char **iftypes = NULL;
+	_auto_(l_free) char *joined = NULL;
 	uint8_t width_set = bit_field(he_cap->he_phy_capa[0], 1, 7);
 
-	for (i = 0; i < 32; i++) {
-		if (!(he_cap->iftypes & (1 << i)))
-			continue;
-
-		if (L_WARN_ON(s >= type_buf + sizeof(type_buf)))
-			return;
-
-		switch (i) {
-		case NETDEV_IFTYPE_ADHOC:
-			s += sprintf(s, "%s ", "Ad-Hoc");
-			break;
-		case NETDEV_IFTYPE_STATION:
-			s += sprintf(s, "%s ", "Station");
-			break;
-		case NETDEV_IFTYPE_AP:
-			s += sprintf(s, "%s ", "AP");
-			break;
-		case NETDEV_IFTYPE_P2P_CLIENT:
-			s += sprintf(s, "%s ", "P2P Client");
-			break;
-		case NETDEV_IFTYPE_P2P_GO:
-			s += sprintf(s, "%s ", "P2P GO");
-			break;
-		}
-	}
+	iftypes = wiphy_iftype_mask_to_str(he_cap->iftypes);
+	joined = l_strjoinv(iftypes, ' ');
 
-	l_info("\t\t\tInterface Types: %s", type_buf);
+	l_info("\t\t\tInterface Types: %s", joined);
 
 	switch (band->freq) {
 	case BAND_FREQ_2_4_GHZ:
-- 
2.34.3

