Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729E17464
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 19:36:00 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id h132so17289085pgc.10
        for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 12:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vrcw2QBRPwT2GjuLiuX9hGERdTcp9ruT4hwdAiRupcw=;
        b=jFwPfWNlN+Mv/j3CytkrtdQwN8ncsBaN1OQ/TEaw7Lg3Gs62VVd0chbmuQHdnhtiyM
         BXzU9hANyCoWZY7a8eh2DK95NIAtpIQ1sV9wn0CNPjPLB0xeE774h4lstm+sJ0WKSBQj
         EwJJx08Kh4Sz0wccBW+beVdyj24ns7+MmJUoBS5z8zoeYnuXNTWfbe1+ye/Ns3OjdPlt
         /j256R4hGxFmDzFk7XhcGYEl9Ln03LX1RbC/oylrqsymfsB/Mxv5CZ091s9yacUploxN
         JcD+TKBh7hYx/s+1YObOnu6zK4mnsULqZpDxfgaVA4R4d4oddtTrdTU9fLGFa4MOuWh+
         oKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vrcw2QBRPwT2GjuLiuX9hGERdTcp9ruT4hwdAiRupcw=;
        b=A9l1ELPHxDD02lAO8JJiM43BNQgsSv9Wf0XnsuJjnHXVBUPq/pMDyWX3zuduKnAzEw
         u/UcHDaUOgbFyemHVAMaIgFAuTb51pQj0yAgAdS5+nSwYcx9dBNKAMRs9WmjqBZvAaan
         S2UluZdrDnW5pvbwgWni5iRWAfeQFHt4bSTwfC3lsSaNQLKmnwaFbZ/g7olueRna5st5
         DoivHt5vyGFOMzDJPSlZYsqaHwnsFMhKPwAuVLQKuFmq3GxaV51TRX0Z0YsV2XqAAcvQ
         oziTP1iYX9Gy2OLv2NgY5bqZOuarQ+LpHeQFJ0d7tqpT8kOh/mKZMRjnc738qbiNO0nt
         y3mw==
X-Gm-Message-State: AJIora+QulPJp00ZxBSdpgRpprD9oPUOhZ3uRqPMNZiWnEWhIWwjWxTl
	yve/UdDRnsGIO80vJm4/Ntlg5zbcInU=
X-Google-Smtp-Source: AGRyM1vgu8KULV1+EAhs7EaPY671WMJNdNKZl7N0CUbGfAptQU96Qp8gyglwpmE/2zqULTYZSycmkA==
X-Received: by 2002:a65:6786:0:b0:415:c67a:49a9 with SMTP id e6-20020a656786000000b00415c67a49a9mr35114640pgr.395.1658345759695;
        Wed, 20 Jul 2022 12:35:59 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902ecc300b0016be4d78792sm14244601plh.257.2022.07.20.12.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:35:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/3] wiphy: use HE element for data rate estimation
Date: Wed, 20 Jul 2022 12:33:51 -0700
Message-Id: <20220720193352.806339-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720193352.806339-1-prestwoj@gmail.com>
References: <20220720193352.806339-1-prestwoj@gmail.com>
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
index 696064c0..9bcbea77 100644
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
+			if (iter.len < 23)
+				return -EBADMSG;
+
+			he_capabilities = iter.data - 2;
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

