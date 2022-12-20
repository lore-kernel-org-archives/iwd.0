Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA688F75
	for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 21:43:24 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso162482pjt.0
        for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 13:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhdFfKuUELe8YmAY2y1ETVrJG+tP9cUhU7kQK4uAlCI=;
        b=mbubsD277a4TclDFRP61TVGEkPnxoGAwJhcutJOkG9Bv6wA/3g3lhrVuxy7BWwaM2u
         fbgxz1ufkxlwX50M2N2HdzEfin8FnNoSB1kmbzoRLYnMWpWQLD8ZPD7ol5KyEukgZrzA
         ur4u06wvzLUhIJbGUUNzbihIgBkcbUj41uRon8C4ymDhZ1ekXAKtCqeM61IOl2NtVu2j
         o+5ZFyyBpy3oHYda5BRRB23OhrA+BdLk86kGpbUMM4/9hVTv9kX2KN65rRUdfj4lAyux
         pUSwTM8RFDmk0Uc3lUMqG3hT9LcoPtw+q7ed19Sa7tp7/o0N+gQUqW/WjqM6mJDHkGfR
         jLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhdFfKuUELe8YmAY2y1ETVrJG+tP9cUhU7kQK4uAlCI=;
        b=15cHLUeIxl1AKiU9G/eXyaTAzwBHtFSzbGmizWJrVQdlVA9RY0RIc7V+2udwSM/ygt
         dE5iJBGLoWZNBb+U21dSpoFr6FaXo/4GMrUt+eNpir8bskngrTOEwG9Gko09GD57absH
         OSd9I86ngbwCqVhdspT+W041Q6VOvW3FZNOcc7LNO3seAO9/qsr3caeZhHyytGP83F+D
         ML+vVXZk0/5DaEplJythJF8RzeiGe4aw/mPktnyRJpXVLAmLedG0zqU1jm+TyVvUdQIM
         loX4YfB7Uvrq0yTNWnCwfYtaMcVt/RpukTLpngGY5bF/hk3Gzkd56oYPCshyKhHMXwqH
         wF+A==
X-Gm-Message-State: ANoB5ploBpK9q4lTmQE68qbZ2CO1dZH7K1JFqjSINKZwuPm5Vi8Q6hRa
	i/NhAbRMiBMMkm7Z1o/x6vTBYwcITQc=
X-Google-Smtp-Source: AA0mqf6rwHWKKwQFeDn5ay58Pqu3BgT1Pfzh7PpXFpXmAdKcSldSGA2HKIdDK3k7I/JS8I6nj81T5w==
X-Received: by 2002:a17:90a:d347:b0:219:9676:fef5 with SMTP id i7-20020a17090ad34700b002199676fef5mr49867804pjx.12.1671572604137;
        Tue, 20 Dec 2022 13:43:24 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e88-20020a17090a6fe100b00219cf5c3829sm8153301pjk.57.2022.12.20.13.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 13:43:23 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 02/10] nl80211util: parse additional channel restriction flags
Date: Tue, 20 Dec 2022 13:43:10 -0800
Message-Id: <20221220214318.2041986-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221220214318.2041986-1-prestwoj@gmail.com>
References: <20221220214318.2041986-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/band.h        |  5 +++++
 src/nl80211util.c | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/src/band.h b/src/band.h
index da4c0ae5..e196a416 100644
--- a/src/band.h
+++ b/src/band.h
@@ -59,6 +59,11 @@ struct band_freq_attrs {
 	bool supported : 1;
 	bool disabled : 1;
 	bool no_ir : 1;
+	bool no_ht40_plus : 1;
+	bool no_ht40_minus : 1;
+	bool no_80mhz : 1;
+	bool no_160mhz : 1;
+	bool no_he : 1;
 } __attribute__ ((packed));
 
 struct band {
diff --git a/src/nl80211util.c b/src/nl80211util.c
index 712cdec3..400871fd 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -533,6 +533,21 @@ int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
 			case NL80211_FREQUENCY_ATTR_NO_IR:
 				freq_attr.no_ir = true;
 				break;
+			case NL80211_FREQUENCY_ATTR_NO_HT40_MINUS:
+				freq_attr.no_ht40_minus = true;
+				break;
+			case NL80211_FREQUENCY_ATTR_NO_HT40_PLUS:
+				freq_attr.no_ht40_plus = true;
+				break;
+			case NL80211_FREQUENCY_ATTR_NO_80MHZ:
+				freq_attr.no_80mhz = true;
+				break;
+			case NL80211_FREQUENCY_ATTR_NO_160MHZ:
+				freq_attr.no_160mhz = true;
+				break;
+			case NL80211_FREQUENCY_ATTR_NO_HE:
+				freq_attr.no_he = true;
+				break;
 			}
 		}
 
-- 
2.34.3

