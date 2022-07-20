Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1347A747E
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 22:17:16 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so3570125pjf.2
        for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 15:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0FUZ24uKdjXbXR5N8bxcxWhCdfkYHd6fP/PdcchXM+w=;
        b=XJARpSot/J6pBBVOtn8FqtfZKZESSeyX6cPcabxzsH5sFngKukogYD+C8Edot1b7Bg
         MZthQ9CILbxaEJYIzy05HYSbv2O3eQSIinpl3YlLD9OSxs6lT1X5HmlK66GulhdEX5fx
         2qP0fWuQ6ucK7M+0afFWLcZscV5ScdySybwA3q9QttslsGV7JPzYhKWho0hoMUPqC/n2
         I+S8bVd6K9Dd2LcVuUni+e8g3cdpok+S8GGYAW3xhFTflk83l5ng8q1oFsz52yqD9uuL
         vw08d1sX57zRNfKDiK207vE8GeU7KvOB9wAa5Z6LcEOkl2Z0+nz8fSEVwYK3KFPEIIl0
         gmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0FUZ24uKdjXbXR5N8bxcxWhCdfkYHd6fP/PdcchXM+w=;
        b=jHneCVY114TNjpySA36pojO3Sizs9hxPJBDR1G8E/YDZ3BoeBwdT1KcoOozXSVRJwv
         kE7wSRFSlzGpUmOFot2llFBHdgUhOrUJRuuwCTwh17gO34jE9Hg7l6NKoDC2TyC0tdAa
         EV4VRjpToorHwIQYNonar9CSoJ+2OxMCYKlpddeP9+vv/ho7qvRpwv8y7fjwboY8SN+k
         GAaBvRqkr8gvPhOkT1VWA2l1TRfoohKHlUMz03grDtnCZHi6QneVuR6FlVClCKi/oMRi
         qHmkd75iRKG9vYrHo8XA0D/ZIR4TRH55JxYCVPpRD/aVwtJZgzpmAdsGIOILf4Pl6+Qi
         vUdA==
X-Gm-Message-State: AJIora8kg0BwJ9bbc+Q5UovLnxkzGYnxBF9E27QmeCHOKpwWkXI4ZbXp
	Fuv8OfwZP9IqRhgWdrAIFJd6Q5ZLY58=
X-Google-Smtp-Source: AGRyM1vQI7bmOpFMWtWi/8BmMqx1aPMbMrvrCzsVMntIGJPC1UJqIsbnMOAGkhdbpiaPKv/OE3ecow==
X-Received: by 2002:a17:903:2285:b0:16c:33dc:8754 with SMTP id b5-20020a170903228500b0016c33dc8754mr41222209plh.126.1658355435372;
        Wed, 20 Jul 2022 15:17:15 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id q10-20020a170903204a00b0016a1e2d148csm75859pla.32.2022.07.20.15.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 15:17:15 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 3/5] wiphy: use HE element for data rate estimation
Date: Wed, 20 Jul 2022 15:15:05 -0700
Message-Id: <20220720221507.886811-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720221507.886811-1-prestwoj@gmail.com>
References: <20220720221507.886811-1-prestwoj@gmail.com>
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

