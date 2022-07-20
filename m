Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2EF747C
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 21:31:41 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id q5so16149124plr.11
        for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 14:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0FUZ24uKdjXbXR5N8bxcxWhCdfkYHd6fP/PdcchXM+w=;
        b=NcwAmKqolUacdwuVEPOFRzAAKkhpH9bjtLIEQ86Yckn6RPoIc+M5AYMEtACzzxeCtF
         Yd+uif/FbFIjL9XwGOE9ODN1RQhEMIZMm0RAttuiBlxbbUCZ7OcRJZqyq0YhAwx8xsK5
         OljQjS2kYX4ZZSlyQwWB0STtMK3qkRmGepu8DR6CYxo/CUJCipQSE5Y28uOuCeg1Nc3S
         hjoNZMKuNbBuxhj46hdHvwVf79FkvWeD9GgVOO20znQ/PAyYu6OJFg+zrH8JFoUAg+Ok
         auCI1CyiKUbxwJyIs7Y/jQ0ITghfCamnlyZ5VhR5fxMr0zupz8gLrx2PbZ/U+vkwcPzH
         HgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0FUZ24uKdjXbXR5N8bxcxWhCdfkYHd6fP/PdcchXM+w=;
        b=yV0jpD2BV0xxaieWFzjUCUCLyRmInGkqxV/Az1ROE3r4BPp6i1ivM5EejmIIpQFWCt
         MgQOnojQIBGOEUVmtFJrt+9/OQVPT2DfszrGJnHH7PVpj37M9s6v7KsZ6r7pz42JND51
         MoUDRu2Z72e8kLAWo+GGPS8v2Zx3cymF0u812oWBqakF+g30JBGz3G0YEFievDocrvdG
         kg528jRGQ4K3RaTnn3wREbqjSq2WKMMiHcvm8l4wVNBgmCXNAUM9vw+TGhGFwwTAB/hd
         hW6Sl8zqJASAMVSl66ELjB52hiQTkT3cChdn0nWg9akSX4F1AEi0OJhv0KneE9oNSQuD
         479A==
X-Gm-Message-State: AJIora83xk7LMx7Uo88Zd13UYNPtOeuUOTUxI4tUWA2aiY9PKrHsvz0H
	FnJpYUJ5gb9B6+s+szciZn4UY1e3Mrg=
X-Google-Smtp-Source: AGRyM1vhEpRLf97ivp2GGgL+g/LEy4883gEZdLM8+XF7XT9+Bigj6QKrH5ZQf/nurEXomSylCT1XSg==
X-Received: by 2002:a17:903:32c4:b0:16c:3cab:5918 with SMTP id i4-20020a17090332c400b0016c3cab5918mr39769341plr.16.1658352700307;
        Wed, 20 Jul 2022 14:31:40 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y22-20020a170902b49600b0016c5306917fsm41475plr.53.2022.07.20.14.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:31:40 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 3/5] wiphy: use HE element for data rate estimation
Date: Wed, 20 Jul 2022 14:29:30 -0700
Message-Id: <20220720212932.873353-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720212932.873353-1-prestwoj@gmail.com>
References: <20220720212932.873353-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an HE element is found, prefer using this for the rate estimation
since it will likely yield the fastest rate.
---
 src/wiphy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 696064c0..09b99fb2 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -788,6 +788,7 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 	const void *vht_operation = NULL;
 	const void *ht_capabilities = NULL;
 	const void *ht_operation = NULL;
+	const void *he_capabilities = NULL;
 	const struct band *bandp;
 	enum band_freq band;
 
@@ -847,11 +848,22 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 
 			vht_operation = iter.data - 2;
 			break;
+		case IE_TYPE_HE_CAPABILITIES:
+			if (!ie_validate_he_capabilities(iter.data, iter.len))
+				return -EBADMSG;
+
+			he_capabilities = iter.data;
+			break;
 		default:
 			break;
 		}
 	}
 
+	if (!band_estimate_he_rx_rate(bandp, he_capabilities,
+					bss->signal_strength / 100,
+					out_data_rate))
+		return 0;
+
 	if (!band_estimate_vht_rx_rate(bandp, vht_capabilities, vht_operation,
 					ht_capabilities, ht_operation,
 					bss->signal_strength / 100,
-- 
2.34.1

