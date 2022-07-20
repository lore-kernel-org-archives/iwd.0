Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5396E7475
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 21:31:40 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id c139so11308003pfc.2
        for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 14:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0NMJ8OT3tYSx1a5FOr4/YBmdnssT7l39LN0oyZfg/wQ=;
        b=F9ElbvtwwGe+PfNcPRk+ifJ7N6UR4QEmRMEs0ivXx0ttT2sSAW72s81gwoJu9hJgRh
         OMmMVAKFEgYcAQyTdo9ROMLtwXZUughQkkGe3RJIdt4ksncq+G0CCyAbkkX6w01MMmQ2
         T6qTV3gFbIWnElhkBrKLliRxz/73RXgbDCwg9MXpejpYsnDcsymVSJxCSDRezswQ7U50
         5UVMmGS1GTjXvv8sVEg5XpH8T9a+oL/MF7X4aaMCtCfPeypV2BCQ2hvBRVpVLtHeltOZ
         PJ2mkuiVPswpE/Ix3prHWqTfoDCu9Y+JSO1RJnFTaOvltFG23TS2Xu+621djJbpNxBOq
         9S/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0NMJ8OT3tYSx1a5FOr4/YBmdnssT7l39LN0oyZfg/wQ=;
        b=cod66/797feDLve6ePRxmeLd+rErM40c+4mNabI2Q+EfWnKGGIq053DY6bU7CJsEaC
         TPkQygNKbnnZkPBD2y16AbDeqasiiUXKJrOeS+1Jcew5q9Qd76mJTroocknrPD921TUF
         HynBFU+iD/WGUWtzEyr5P1GyJdD8LELvReX3KFsldovw8sXEDBibCFQjK64umqZqKeYZ
         JQxZe2mnuc4Nc0krxVStAHX7m3DVYJydgzWDJCKQ93sDLeG0nuVqNsBq6dVOZ5mHXb3T
         5y0qkyF0iYQV0ZWvoLxez/8PbOOUF5rgMLaplctdZs+Kf2OdK/Fu8ZxpwXYN8bSxJRBh
         4QhQ==
X-Gm-Message-State: AJIora/W70jcpR1CtAfVg6sA8wsO4mYGEJswqlApAgw4MDklc1TIvXgO
	0NEore0s9YZfGuXnNB9m3v+kwigOmtY=
X-Google-Smtp-Source: AGRyM1vno3PdOVKiBu0AJ4fG7cpJbt5zhTxYm2GgXIgQpAGNRh0d9PUYlcQPEnNtrIIdLZG9Nv1mOw==
X-Received: by 2002:a05:6a00:174f:b0:525:518e:71d6 with SMTP id j15-20020a056a00174f00b00525518e71d6mr41755232pfc.68.1658352699262;
        Wed, 20 Jul 2022 14:31:39 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y22-20020a170902b49600b0016c5306917fsm41475plr.53.2022.07.20.14.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:31:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 1/5] ie: add validation for HE Capabilities element
Date: Wed, 20 Jul 2022 14:29:28 -0700
Message-Id: <20220720212932.873353-1-prestwoj@gmail.com>
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

