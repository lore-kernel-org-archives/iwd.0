Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E0D7E
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:18:05 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id v17so11592398plo.1
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UEcUJlR2NFd3ZJzzkmtPSmop46MuCFADfvl0SGPai0=;
        b=OQlCI2w/ivziSLAImmk2EipRbkqpzpbdppQAJFxMTqTmy3urANipOJH+YUpGEygYJA
         aD2uNSKzhEJ/gpy/1OdXYpo7vTuq3XD3dlsQfAXe98SQv+DDumBmCcTEKXqwcVDv4TQ2
         5TwC16QCEv9CYMOXdDtth+TSRUX20Ma+/u2fmfWDmPvz4HVN7tLHRXcpUXheqtoERVGr
         H3lbm/JSZrZVMY4DgcGBjzkjDzC6/QI2WvV4SRU13eHmeEcYWGMfuZ6SyJqQfsSZvFyT
         GNjYKWV7Er9Ey0Tpdf/YqzhWSM76WICb7pV5+0bk/uVS0IRu50gKs9xNfSG+wHgWJ6t+
         lsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UEcUJlR2NFd3ZJzzkmtPSmop46MuCFADfvl0SGPai0=;
        b=3llqpUZM5mwQbbnQtcdDKrFS78MNCk3ZF1yhAjng1bTL3+PeI5pvWjCFmA7kUwLHfh
         Es87x0hChAReYnxdoWbdlLKL0nvitwBmH/yxzVDXM3cnAthSy3VbSVkB1u7IDhvKD0m+
         r6X+mLY7xy2OPrRwtaf87IwpxdGMeuIqkEAmAlIlWin5JP3j7nBxYjeZmrd9jeFFN7fC
         cBfoIxKgFBtiP6+6VrOOJxyBYBTTFZLnmwNKWBci5OcAsgjh3ZM37tYKHH7smaRfvvek
         3HNxrBindqLBJKU3h1nO9ga5wLnh9PMaSuVQ75YhvnXr8f+vQbdJ3VgwBdrObBoET54b
         LR0g==
X-Gm-Message-State: ACrzQf1DHEN0vOx/3uIVvJn8x6IPWHVSUIMfxB86g7NwACtetcCfw0Oa
	+dLE9GCMOADI5CxewyisoJC0ofyHSXU=
X-Google-Smtp-Source: AMsMyM6qLDq0jG/Zti1Ij5SUqZbgh9dBKPLShHpIf+K0EDvUa5+JJm4v6wVyoI2G4CoNjG6Rz8au+w==
X-Received: by 2002:a17:902:c40d:b0:186:ffe6:24cc with SMTP id k13-20020a170902c40d00b00186ffe624ccmr22089417plk.133.1667333884463;
        Tue, 01 Nov 2022 13:18:04 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00180a7ff78ccsm6781681plg.126.2022.11.01.13.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:18:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 16/17] netdev: parse michael MIC failure message
Date: Tue,  1 Nov 2022 13:17:46 -0700
Message-Id: <20221101201747.143379-16-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221101201747.143379-1-prestwoj@gmail.com>
References: <20221101201747.143379-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This event indicates a security issue. The proper handling would be
to rekey but for now at least provide some information to the user.
---
 src/netdev.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 23bbbcf6..ced87191 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -5224,6 +5224,20 @@ static void netdev_channel_switch_event(struct l_genl_msg *msg,
 				&netdev->frequency, netdev->user_data);
 }
 
+static void netdev_michael_mic_failure(struct l_genl_msg *msg,
+					struct netdev *netdev)
+{
+	uint8_t idx;
+	uint32_t type;
+
+	if (nl80211_parse_attrs(msg, NL80211_ATTR_KEY_IDX, &idx,
+				NL80211_ATTR_KEY_TYPE, &type,
+				NL80211_ATTR_UNSPEC) < 0)
+		return;
+
+	l_debug("ifindex=%u key_idx=%u type=%u", netdev->index, idx, type);
+}
+
 static void netdev_mlme_notify(struct l_genl_msg *msg, void *user_data)
 {
 	struct netdev *netdev = NULL;
@@ -5274,6 +5288,9 @@ static void netdev_mlme_notify(struct l_genl_msg *msg, void *user_data)
 	case NL80211_CMD_DEL_STATION:
 		netdev_station_event(msg, netdev, false);
 		break;
+	case NL80211_CMD_MICHAEL_MIC_FAILURE:
+		netdev_michael_mic_failure(msg, netdev);
+		break;
 	}
 }
 
-- 
2.34.3

