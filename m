Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6B1746A
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 19:45:28 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id o18so4509838pjs.2
        for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 12:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vrcw2QBRPwT2GjuLiuX9hGERdTcp9ruT4hwdAiRupcw=;
        b=RMcF3X/Yxlg6GGjIqGawFnj3umDMJ8FOq6spmXJt/ljcD8gRbo5t7oK3BCuvTiWUH+
         p7XMJyWQthqO+wcVJ7ExhI1nghATUig0KDwQ3TiZSE1FP22h4WPhA96aquXIXP6Z25vl
         PN+/mwTQctbTEMxZOhbrAFhpzqz1CqPbmEmzZS0/bsQMs8+wj1B/N2pusBQ+yFCQh+bm
         Idt8nCTIaRt4oL6xnzk9kikO8HLHeXdBXm2r7wP8BaGCIcusftZ3zFKhT2naWHfIC+kf
         VjJufnepUf1CNy2Modq+gkKR0It/PyT0Or48AgxFRBme4d9wh4UGF/4M7tGXm2tOfDX/
         AnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vrcw2QBRPwT2GjuLiuX9hGERdTcp9ruT4hwdAiRupcw=;
        b=Eylp90bzuw6eErhZ3Rgz1f/3uNl7P5GFpQfWBKdIRKSttOpHWDuWdabPv57KrLW6+J
         /ukHstkkQRMwbzP4pvaNPLFu6il4yNdMfG43k8UDE9egwx3RPOwrpdu+Zzxm//0gHWkL
         MFouzjjocxbsJ1NvtAhA4SNIiGdySeKiWfRVmpJXyiJdkumpQH8WZZvwPQa6ir7gRMVU
         ZgSpz+WyO4GszfFCwuBfcSCmrSDxQD45XgHCigtCZEp7wSRYDMs5EOncF1cWQhGoLJn8
         8ngEZLv7Y/mEgI9ZPzl6KCiNmKOFePpbu221mgNEMBDEz1u9aZR3lWrPBG2Ct/gpaw7d
         5pBw==
X-Gm-Message-State: AJIora9vcGm2kI9ODCa2qCh9FND79Vg3tVIEOUMMhgyFfkfB3PAqZYD0
	4zr77TxWgw22Q6PH40bd3kxGVQcAGKo=
X-Google-Smtp-Source: AGRyM1vWFKL7FaweuxfyPC3Ws8QmyiZVARp3vuJnJTV9xYmv/i21Uuksq/Gob5uKhpnfL6frhjWLzQ==
X-Received: by 2002:a17:90a:d243:b0:1ef:9e70:3d4e with SMTP id o3-20020a17090ad24300b001ef9e703d4emr7279685pjw.232.1658346328031;
        Wed, 20 Jul 2022 12:45:28 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902684100b0016ccbc9db0fsm7064734pln.5.2022.07.20.12.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:45:27 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 2/3] wiphy: use HE element for data rate estimation
Date: Wed, 20 Jul 2022 12:43:16 -0700
Message-Id: <20220720194317.809749-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720194317.809749-1-prestwoj@gmail.com>
References: <20220720194317.809749-1-prestwoj@gmail.com>
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

