Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71CC4A11
	for <iwd@lists.linux.dev>; Wed,  3 Aug 2022 21:36:47 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id 12so16274461pga.1
        for <iwd@lists.linux.dev>; Wed, 03 Aug 2022 14:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=veQVBEK6G4p2f6TqK/4E3nTIjcHKzc9PjkBX+HGaJtc=;
        b=MjN0K0oGbXYwHlhh1kztBPLFwOmvYp8Y7pRSwD6GdroksIPCUpqjVR2NFg29RQa68D
         Pf2U7r1YCGVg2i3yBn6pu6k8XPxKGA76L2FhWbUMCRTTFbpHip1dARpZn/qpTvbUKI0Q
         Tr+DIfgPKYhJBDRxtJ7Gr1FsiPktyFEuzEqZ8LC1WY3jPvDqGUePkEQP45uoGQSTlFjv
         YpugLjeHN6/L9WI16SVsRP8VlT7OCkhVB05Xg5BYvUvdarukZzc2hNGzGuLP047+BsQj
         N9pALKKaBQCrZCW9dPcTufuiaRx9vqzJtqCixE7R3p5rjhzb3EKNkxiDhh3t3dS7f6f1
         Jg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=veQVBEK6G4p2f6TqK/4E3nTIjcHKzc9PjkBX+HGaJtc=;
        b=BXMPrp8XfQArdvvRbjLnijwKe0CNreIXlFES4UdqDNuwRCgIof0cOo/K4STVgW8ZSJ
         SC+h6bFjegpGCdJR9vXbEKXzQmnkXsXuPSqLcnYm49vnpKvBalZCYxIx+ifqtM8jZ5qv
         ywYGsBAFgeXxhjeSpwbG5wQTlJ/kEznm8b9/xENiZbx5unm1/5LeW9e4XjG37I/iYw22
         pCqlllM3j6GzJrNygSMIMXYOsOoHT/3HW61ipQFG05wAB7pO4MCPsaeWxRKbyj6/4CQ2
         L8TejsIeUZAHuWkb+6iVxxC+o+90oYx6GXgd/cs0zAGSHtd1V6oPrivTPOQkqnpDOLl6
         axbg==
X-Gm-Message-State: AJIora9d9zZVrMfiZJTiHFUL2DKN1NuwE1planybjeCsn7LBmCPRlncp
	n5Pth+jO/iasAZVRY5o9La/UOr+Yq2A=
X-Google-Smtp-Source: AGRyM1u4ZOOsFMIRNI8tBwFsrMuqNdJdyrv40PAumJjEVtSDHKjMzKUKWs9e3AUC4YwA5s6k5tGAGA==
X-Received: by 2002:a65:558f:0:b0:419:57c9:31dd with SMTP id j15-20020a65558f000000b0041957c931ddmr22352486pgs.222.1659562606744;
        Wed, 03 Aug 2022 14:36:46 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id b13-20020a65578d000000b00419fc2c27d8sm11527066pgr.43.2022.08.03.14.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:36:46 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 01/13] wiphy: fix runtime error from bit shift
Date: Wed,  3 Aug 2022 14:36:32 -0700
Message-Id: <20220803213644.277534-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
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
 src/wiphy.c | 50 +++++++++++++++-----------------------------------
 1 file changed, 15 insertions(+), 35 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 026605fe..2514c95a 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -716,17 +716,16 @@ bool wiphy_constrain_freq_set(const struct wiphy *wiphy,
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
@@ -737,6 +736,11 @@ static char **wiphy_get_supported_iftypes(struct wiphy *wiphy, uint16_t mask)
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
@@ -960,38 +964,14 @@ static void wiphy_print_mcs_info(const uint8_t *mcs_map,
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
@@ -1341,7 +1321,7 @@ static uint32_t get_iftypes(struct l_genl_attr *iftypes)
 		if (len != 0)
 			continue;
 
-		types |= (1 << type);
+		types |= (1 << (type - 1));
 	}
 
 	return types;
-- 
2.34.3

