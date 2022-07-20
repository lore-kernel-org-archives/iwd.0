Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4840747E
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 22:17:14 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id d7so68820plr.9
        for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 15:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0NMJ8OT3tYSx1a5FOr4/YBmdnssT7l39LN0oyZfg/wQ=;
        b=YHrjhPSRn3AKCb3cXpuyJHAgS1dz+c40vFtch68nG7Zj2q/LaI3kV61y7ZFNt4g+AN
         DGmwYsYtJWPSdqKRkTb382wRq/rdhoBd3kBR2M5uEP0fG8nsIKY6p37VmlT6wx9rA6w/
         rGQmDxBCb6iNdLqFwcjc6ECjq1K4nJPojBKTe7ExZKnAMVIUqNJ7fXpDIMT+jwxoOH41
         gJdosETEO8n9sylPUAHKbnqTvlbUhwUZ4O0GLfXgqtp3I0JPVUvBGYhO0/NkGMuMznBA
         Ca8togqjcUa7qFaJ9IzqOPVeNiQUlT8H9i0cELP4Rx9zBr8uaAwxuq3is9dzc0G5Y4KF
         PxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0NMJ8OT3tYSx1a5FOr4/YBmdnssT7l39LN0oyZfg/wQ=;
        b=2I2+jO1BJA/VmxB+dbti443h9/vI8z8CNHtmU2K6imyVCNndHTqQtfwrvlh9gu5UCp
         betXGXrVhxYZzW8CjE1uzWEnUHNQxKUgVam2YL8DovMzFs371oNoiNgvypnEvWhKD4+o
         Ay+oZRLienFUvwDLLm1chm9JIQzmO9xea/MISzQ/xrmnY/PDXIH1cwv0sVT4djIp+4Hy
         f5ENWQWKuaX5wrqvsGjJaGziTydxeMnVXJ+kAe0vLqTDff98fHF5eMt90LtFOMquBDik
         li5y/48p14dnnadpnCl6QYFldRXzQOtcFnholHwp6EhpQNtVS4pa//obkYyNmqjLOqpX
         Y6oA==
X-Gm-Message-State: AJIora8Cg0vYkdXkhQwMuj0SpfD5D4yjVOVpvCJV3Fze1Cayjai9nMWK
	KiSiSo3KRg05MgYY7EFVR7IjBGF4+wc=
X-Google-Smtp-Source: AGRyM1sWx1IaYZMwbcXOqtRLJwKxof8DdG2UcfXTpGaoYhb1y8fA5wF8uQ/rvfhNcs84zyxWrBbP1Q==
X-Received: by 2002:a17:902:efd5:b0:16d:2da8:64a7 with SMTP id ja21-20020a170902efd500b0016d2da864a7mr2100850plb.157.1658355433976;
        Wed, 20 Jul 2022 15:17:13 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id q10-20020a170903204a00b0016a1e2d148csm75859pla.32.2022.07.20.15.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 15:17:13 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 1/5] ie: add validation for HE Capabilities element
Date: Wed, 20 Jul 2022 15:15:03 -0700
Message-Id: <20220720221507.886811-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes sure the width set bits are sane, and validates the length
depending on which MCS sets are enabled.
---
 src/ie.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/ie.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/src/ie.c b/src/ie.c
index 7ef07c37..070454ef 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -2577,3 +2577,51 @@ int ie_parse_oci(const void *data, size_t len, const uint8_t **oci)
 
 	return 0;
 }
+
+/*
+ * Checks the supported width set (Table 9-322b) meets the following
+ * requirements:
+ *  - B0 and bits B1/B2/B3 are mutually exclusive.
+ *  - B2 is only set if B1 is set
+ *  - B3 is only set if B2 is set (and in turn, B1 is set)
+ *  - The IE length supports B2 and B3 MCS sets
+ */
+bool ie_validate_he_capabilities(const void *data, size_t len)
+{
+	uint8_t width_set;
+	const uint8_t *ptr = data;
+	bool freq_2_4;
+	bool width_40_80;
+	bool width_160;
+	bool width_80p80;
+
+	if (len < 22)
+		return false;
+
+	width_set = bit_field((ptr + 7)[0], 1, 7);
+
+	/* B0 indicates support for 40MHz, but only in 2.4GHz band */
+	freq_2_4 = test_bit(&width_set, 0);
+
+	/* B1 indicates support for 40/80MHz */
+	width_40_80 = test_bit(&width_set, 1);
+
+	if (width_40_80 && freq_2_4)
+		return false;
+
+	/* B2 indicates support for 160MHz MCS table */
+	width_160 = test_bit(&width_set, 2);
+
+	/* Ensure B1 is set, not B0, and the length includes this MCS table */
+	if (width_160 && (!width_40_80 || freq_2_4 || len < 26))
+		return false;
+
+	/* B3 indicates support for 80+80Mhz MCS table */
+	width_80p80 = test_bit(&width_set, 3);
+
+	/* Ensure B2 is set, not B0, and the length includes this MCS table */
+	if (width_80p80 && (!width_160 || freq_2_4 || len < 30))
+		return false;
+
+	return true;
+}
diff --git a/src/ie.h b/src/ie.h
index d38e9e8e..e56df984 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -682,3 +682,5 @@ int ie_parse_owe_transition(const void *data, size_t len,
 				struct ie_owe_transition_info *info);
 
 int ie_parse_oci(const void *data, size_t len, const uint8_t **oci);
+
+bool ie_validate_he_capabilities(const void *data, size_t len);
-- 
2.34.1

