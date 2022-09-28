Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823414C62
	for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 19:48:55 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id s206so13149988pgs.3
        for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 12:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=S1LjIPb0zYpsAv3hLf0T5oMgYs+h4GRz4GjdN1/1tzo=;
        b=e1/1d2ZFytlp55EkzUwVcjvgjxg3fEtl9Oo2YhLYRRA8fQDMKCKAzVmqmSRorE79sU
         /yT2EXnz26oe6nL3Of+d0B0ZwvRKXvwSurKnX4fiMcXT6nMNLfQB7YNY2fs4zBs8t2r5
         /2uerTjSuaQvIYwhmItuNR9o7tMVM2a0gaKmRV156QfFl4wS1ujitMWbS4KjUSV7dCC+
         xBcXLudabOBmhnPbGaNDUPlTIYP+W+CIiC1Kc/rNEIQtLwOgOctprPlBo3UXSSq07r5T
         0S23pTFqfd+HQDIp1NvI6K20/JMOBmUB8o7PRzx0k1julYhIaKKcIFqRBmfA0RmfFM3H
         LY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=S1LjIPb0zYpsAv3hLf0T5oMgYs+h4GRz4GjdN1/1tzo=;
        b=XCqOjEBvvo0WtLcjmoEaU45j9Lr+NcBMcDzIMgPJl3TnJ7XrTvunNB2QeDoo65vAbR
         CItKGuuGmSbepCUzSBBJzUJo5lmFwQsVCAMqJPnyIxwbkjf1xfsnw4DaHODThH6vIfA1
         0q5GTWAhkuW83qt+ZJ1ucpc541uBQCPLXDfN9HZmk5LjO6EGQBA13Y5Rz6G8qyE/t69j
         NASyFnMVWRxqVu/iylNL6NdtZToE5OVIKHhrgAbLkCBK6k5/kcvrdb3p5Zm517Fp8zp7
         c0vsFHP7J0wZdEJHql5CwBNMmI3qsxv52nciy+ajt+eaZQOgni9Dj0oXLOpJ2luhur8I
         a4+A==
X-Gm-Message-State: ACrzQf1AQaBfQxfueEVwhROVr2i4/NYy17ypSvCBXxmoCvml9xxEV9iP
	ge1HOXaiOm4C+VzTFlAibbZ/+LGduSw=
X-Google-Smtp-Source: AMsMyM5615P18zzc5wMKV9hAYbTW6ZjcRhOF/GflVPT/yCYnDTGbZdaj3hU5UpryLdAI9eeEuLnv8w==
X-Received: by 2002:aa7:952f:0:b0:540:e8ee:a077 with SMTP id c15-20020aa7952f000000b00540e8eea077mr36243527pfp.34.1664394534798;
        Wed, 28 Sep 2022 12:48:54 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id r17-20020aa79ed1000000b00550724f8ea0sm4363308pfq.128.2022.09.28.12.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 12:48:54 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] wiphy: add wiphy_supports_probe_resp_offload
Date: Wed, 28 Sep 2022 12:48:51 -0700
Message-Id: <20220928194852.375786-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse the AP probe response offload attribute during the dump. If
set this indicates the driver expects the probe response attribute
to be included with START_AP.
---
 src/wiphy.c | 9 +++++++++
 src/wiphy.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 28d4b66e..6fdd3df5 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -138,6 +138,7 @@ struct wiphy {
 	bool blacklisted : 1;
 	bool registered : 1;
 	bool self_managed : 1;
+	bool ap_probe_resp_offload : 1;
 };
 
 static struct l_queue *wiphy_list = NULL;
@@ -473,6 +474,11 @@ const struct scan_freq_set *wiphy_get_disabled_freqs(const struct wiphy *wiphy)
 	return wiphy->disabled_freqs;
 }
 
+bool wiphy_supports_probe_resp_offload(struct wiphy *wiphy)
+{
+	return wiphy->ap_probe_resp_offload;
+}
+
 bool wiphy_can_transition_disable(struct wiphy *wiphy)
 {
 	/*
@@ -1644,6 +1650,9 @@ static void wiphy_parse_attributes(struct wiphy *wiphy,
 		case NL80211_ATTR_WIPHY_SELF_MANAGED_REG:
 			wiphy->self_managed = true;
 			break;
+		case NL80211_ATTR_PROBE_RESP_OFFLOAD:
+			wiphy->ap_probe_resp_offload = true;
+			break;
 		}
 	}
 }
diff --git a/src/wiphy.h b/src/wiphy.h
index 9cd18451..2c6bf86b 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -97,6 +97,7 @@ uint32_t wiphy_get_supported_bands(struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_supported_freqs(
 						const struct wiphy *wiphy);
 const struct scan_freq_set *wiphy_get_disabled_freqs(const struct wiphy *wiphy);
+bool wiphy_supports_probe_resp_offload(struct wiphy *wiphy);
 bool wiphy_can_transition_disable(struct wiphy *wiphy);
 bool wiphy_can_offload(struct wiphy *wiphy);
 bool wiphy_supports_cmds_auth_assoc(struct wiphy *wiphy);
-- 
2.34.3

