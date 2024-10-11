Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BAF7DA81
	for <iwd@lists.linux.dev>; Fri, 11 Oct 2024 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658510; cv=none; b=TW5xnqclKP/0SNaVkZHKhWUjWTusBW2J/WkAZP1+nRuKvSlqAt6sSD/+QCJtlkKKu/2Ye7DUEuxz/9WYZ0wpPHIv7mHaDmXbc0avLsG1hDNAa7lGmKkU81O6J0u3RsBDdwCAAN9qA7awIvxQ3zzGa/hmyLBG4alkJBqgWisUU6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658510; c=relaxed/simple;
	bh=DBIr3dFRjbsdJb5jiorNuMknXK9n22rWsrkpbYf+LFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iaBQs13xkbaG3/vLjGMt9rgpTzG9W5mXfjiug7taoEnCkPWr3NFs0NH50kQlLP+sPVaQuCYZeihQSzTyboINiBZacck6snki8aLxHc2mpojGkEe9ro21x8w644WfRoMrrv4cQgWgblMQvu7QpGQT2gfajo20uD0owrVXcJkUFJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9mlzhXY; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9mlzhXY"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbe90c7c95so15426116d6.1
        for <iwd@lists.linux.dev>; Fri, 11 Oct 2024 07:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728658508; x=1729263308; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sf7ncQrfBKLuIifzo8sTZu2pPsaJml+rDEnD+1wpZWI=;
        b=b9mlzhXYL0YsXcvE9H8736svpVQTSbwKG9dm513Y/eL7IbgMIHFgGmN/ZUCha7xxyd
         tn/Ah6Vmqz8NLk2iGbENMQMF7qDSLsdif4TJ5igL+xRRhbRb1hNyBNeamXTtGvrt4YM3
         z7Caap+xR5MzhrNpVXNOF3Qmxx1CvMGYAHphUUU9I0t95nH90djoThdYcoJKZyv0lDRf
         Ye+guhV13TtVAi9fQdn7YsvdTvhRolnQiMwLhFiYdbRb5av0FFq4BnJexBfGd5ZcyEx4
         uRSb8Dhy6K/9OjDUdYbL+bUR7EKTFUUKGAe2RzrmecDooiG4LPkTCh16izzG7Fcr9cAY
         uJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658508; x=1729263308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sf7ncQrfBKLuIifzo8sTZu2pPsaJml+rDEnD+1wpZWI=;
        b=aS6pioDkebHAP71KCxvd18gqRTqmzZ1LChdt17BeGVYtXPuSuLGDxzOKn62se/3b3U
         1kkMGf8xbRj22fhHmuC61xfi9xoajNnDS5Rq0wCIa0KCvYE0EDg5Y2IruVN/Qonf7T6L
         8C4+TilhiWwAsbBFA4cHgh4GRSFHVHL3RshXYidbfryvc3bUr8vjEcdvFp96+bnpbFct
         qLXODGfNCdv6ffNnt7XkGFMotKp4ieOSFgyNBUgwXAld+aR4KlbH/AvsFPJC/LqzGiFs
         T5PDoXfs4q6a2Amv0TSWQrZvUIqzeJIA9mqIDJrg1UiQlQNATxbvDhvQvx9NfH+ubFXJ
         XI6Q==
X-Gm-Message-State: AOJu0YywFCS9xCLGYiCYIP/Yb4XDSSe12O7GO3PZ++AiW6orajHpIBbR
	+z5B21uTQZrbR+nbLbmfI4z8vWqxtMb+Ono6vwR01YxnszFJRZ9SJh5mTw==
X-Google-Smtp-Source: AGHT+IF5sN9d6+6ynOJHOhE1s7Mv5kVOWc1sXTPxgfHcL9TkTSLzGwdtKp/utvunh1EX7ZPreXhDyQ==
X-Received: by 2002:a05:6214:3a81:b0:6cb:3a7b:96b9 with SMTP id 6a1803df08f44-6cbeff4d9c3mr45135706d6.15.1728658507671;
        Fri, 11 Oct 2024 07:55:07 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85b7767sm16157216d6.34.2024.10.11.07.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:55:07 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] wiphy: parse TX/RX frame types, and API to check auth frame support
Date: Fri, 11 Oct 2024 07:55:02 -0700
Message-Id: <20241011145503.51330-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers have been identified that do not support authentication via
CMD_FRAME. This prevents FT from succeeding but since there is no
way to check this in IWD station cannot handle it gracefully.

Now IWD can parse the TX/RX frame types and check if authentication
is supported and plan the type of roam according to what protocol
will work correctly.
---
 src/wiphy.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/wiphy.h |  1 +
 2 files changed, 55 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 06f72ef2..cc0e6dd7 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -150,6 +150,8 @@ struct wiphy {
 	bool ap_probe_resp_offload : 1;
 	bool supports_uapsd : 1;
 	bool supports_cmd_offchannel : 1;
+	/* Bit 0 for TX, Bit 1 for RX */
+	uint8_t supports_auth_frame : 2;
 };
 
 static struct l_queue *wiphy_list = NULL;
@@ -938,6 +940,11 @@ bool wiphy_supports_cmd_offchannel(const struct wiphy *wiphy)
 	return wiphy->supports_cmd_offchannel;
 }
 
+bool wiphy_supports_auth_frame(const struct wiphy *wiphy)
+{
+	return wiphy->supports_auth_frame == 0x03;
+}
+
 const uint8_t *wiphy_get_ht_capabilities(const struct wiphy *wiphy,
 						enum band_freq band,
 						size_t *size)
@@ -1816,6 +1823,45 @@ static void parse_iftype_extended_capabilities(struct wiphy *wiphy,
 	}
 }
 
+static void wiphy_parse_frame_types(struct wiphy *wiphy,
+					struct l_genl_attr *attr, bool tx)
+{
+	uint16_t type, len;
+	const void *data;
+
+	while (l_genl_attr_next(attr, NULL, NULL, NULL)) {
+		struct l_genl_attr types;
+
+		if (!l_genl_attr_recurse(attr, &types))
+			continue;
+
+		while (l_genl_attr_next(&types, &type, &len, &data)) {
+			uint16_t frame_type;
+
+			if (L_WARN_ON(type != NL80211_ATTR_FRAME_TYPE))
+				continue;
+
+			if (L_WARN_ON(len != 2))
+				continue;
+
+			frame_type = l_get_le16(data);
+
+			switch (frame_type) {
+			/* Authentication */
+			case 0x00b0:
+				if (tx)
+					wiphy->supports_auth_frame |= 0x01;
+				else
+					wiphy->supports_auth_frame |= 0x02;
+				break;
+			default:
+				break;
+			}
+
+		}
+	}
+}
+
 static void wiphy_parse_attributes(struct wiphy *wiphy,
 					struct l_genl_msg *msg)
 {
@@ -1903,6 +1949,14 @@ static void wiphy_parse_attributes(struct wiphy *wiphy,
 		case NL80211_ATTR_SUPPORT_AP_UAPSD:
 			wiphy->supports_uapsd = true;
 			break;
+		case NL80211_ATTR_TX_FRAME_TYPES:
+			if (l_genl_attr_recurse(&attr, &nested))
+				wiphy_parse_frame_types(wiphy, &nested, true);
+			break;
+		case NL80211_ATTR_RX_FRAME_TYPES:
+			if (l_genl_attr_recurse(&attr, &nested))
+				wiphy_parse_frame_types(wiphy, &nested, false);
+			break;
 		}
 	}
 }
diff --git a/src/wiphy.h b/src/wiphy.h
index 17e53075..fe7e9e49 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -142,6 +142,7 @@ void wiphy_get_reg_domain_country(struct wiphy *wiphy, char *out);
 bool wiphy_country_is_unknown(struct wiphy *wiphy);
 bool wiphy_supports_uapsd(const struct wiphy *wiphy);
 bool wiphy_supports_cmd_offchannel(const struct wiphy *wiphy);
+bool wiphy_supports_auth_frame(const struct wiphy *wiphy);
 
 const uint8_t *wiphy_get_ht_capabilities(const struct wiphy *wiphy,
 						enum band_freq band,
-- 
2.34.1

