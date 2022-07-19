Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423B64C82
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 18:58:02 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id x24-20020a17090ab01800b001f21556cf48so1045300pjq.4
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HtXr+E9J9eMunxHwACibY2SAcmgV0klG9HHmC9iZ9WM=;
        b=beZZ29I8YdTYJlxAofNu3aR6HfavWN1l7zP14zg23/kAMe149VRBhfAdcPvBs7LhIy
         kde6K1Ce3wvE9R4Th5iwoeH5ZnFvjBtUjW0RBKMhk3eCoK/GiTxjH+ENFdhPTk9+TGde
         1xuzvbbFpYjLM8AO794Z/gnoTy7bbXI/zV5XQfw5N97bAAPcygfXmhyuPD7i8htStdSv
         CJmSp7e0vs1gWZcamEr7o83AiYn6DpEqRnOn2l6D+yi572q+5EYUcmYhT1SoXEADNI5O
         IxMYy3KL0qeaLIxSB3ejBkhP1ximbN+NOiTdYJfQElI/PSvkbe0yIIkhitfs68rtm4Dg
         QsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HtXr+E9J9eMunxHwACibY2SAcmgV0klG9HHmC9iZ9WM=;
        b=yn3IeNKfs25vT/UEBb7H/jpvX83bdVyBnnTE7yG00h9RZToZnuh1z5flHe1SvPT7No
         vQFwo0jptFalwlNm7sxdVFIZpYo/e5E5Wf5k8gvf7z1AJx2QsfwlllRCgcS10RYOS8ds
         Z6yABMD/wml2nwvRxW07G4KuGX+TXowicNXC5jYhnEEwVU4Iji5h2w0WR0l1H/7DLlWo
         m6Y9hwENOkHG2dZfjD56oheJzYKOnODkUyHdJiFvG07lhlC9MDfB81Q1yQJ6OlQh8PcV
         wcPIaYmhDrdiNhT8kUDrY9D++JQwZs7JocTGHferoeOgfwARRrbUGqPXgztn1hT8XsfB
         lGMA==
X-Gm-Message-State: AJIora/68Qeyf87fo1PscCWdkATdkkoEGbAsM9i5D9Lfvzf3+AoCIgqJ
	OnZQO2TxQQPjZowSifxDRCqVsA2wN1A=
X-Google-Smtp-Source: AGRyM1vDgkYTGwzAZsjSd7P03d91P8DFaLC+gKLI4sfJtflkWaweKYphHexAnMr2zVugrrP5sbgHww==
X-Received: by 2002:a17:90b:251:b0:1f2:1842:6fea with SMTP id fz17-20020a17090b025100b001f218426feamr544559pjb.73.1658257081535;
        Tue, 19 Jul 2022 11:58:01 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b0016c68b56be7sm11937785plg.158.2022.07.19.11.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:58:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 07/12] wiphy: make MCS info print more generic
Date: Tue, 19 Jul 2022 11:55:39 -0700
Message-Id: <20220719185544.456727-7-prestwoj@gmail.com>
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

With the addition of HE, the print function for MCS sets needs to change
slightly. The maps themselves are the same format, but the values indicate
different MCS ranges. Now the three MCS max values are passed in.
---
 src/wiphy.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index d3cbe73d..88a0fff8 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -903,19 +903,35 @@ static void wiphy_print_mcs_indexes(const uint8_t *mcs)
 	}
 }
 
-static void wiphy_print_vht_mcs_info(const uint8_t *mcs_map,
-						const char *prefix)
+static void wiphy_print_mcs_info(const uint8_t *mcs_map,
+						const char *prefix,
+						uint8_t value0,
+						uint8_t value1,
+						uint8_t value2)
 {
 	int i;
 
 	for (i = 14; i >= 0; i -= 2) {
+		uint8_t value;
 		int mcs = bit_field(mcs_map[i / 8], i % 8, 2);
 
 		if (mcs == 0x3)
 			continue;
 
+		switch (mcs) {
+		case 0:
+			value = value0;
+			break;
+		case 1:
+			value = value1;
+			break;
+		case 2:
+			value = value2;
+			break;
+		}
+
 		l_info("\t\t\tMax %s MCS: 0-%d for NSS: %d", prefix,
-			mcs + 7, i / 2 + 1);
+			value, i / 2 + 1);
 		return;
 	}
 }
@@ -976,8 +992,8 @@ static void wiphy_print_band_info(struct band *band, const char *name)
 		if (test_bit(band->vht_capabilities, 6))
 			l_info("\t\t\tShort GI for 160 and 80 + 80 Mhz");
 
-		wiphy_print_vht_mcs_info(band->vht_mcs_set, "RX");
-		wiphy_print_vht_mcs_info(band->vht_mcs_set + 4, "TX");
+		wiphy_print_mcs_info(band->vht_mcs_set, "RX", 7, 8, 9);
+		wiphy_print_mcs_info(band->vht_mcs_set + 4, "TX", 7, 8, 9);
 	}
 }
 
-- 
2.34.1

