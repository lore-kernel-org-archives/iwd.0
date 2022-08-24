Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050ED1C3E
	for <iwd@lists.linux.dev>; Wed, 24 Aug 2022 22:55:25 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id m2so16978972pls.4
        for <iwd@lists.linux.dev>; Wed, 24 Aug 2022 15:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dtQ+eEC76CpNq4iFz6Rhy5rCcSmVIHg+Fd4Jtdeguhg=;
        b=PDJ8uQu1YKii6vfrgTjzEUpxQ6JEHuOkVKfO9i7JrUVCPBsZWux9PZ/0zGphp/zyYK
         kcQ6OxlZONENqh1GIJXjStWoqYyKXceYawn++5IRk1YWtc8M+3LWSnRxQIZRdeC94aeB
         pCeUr4v/YfU6IlbwrMh9D5rXnaH5J5tr8M1pPGz7B9iZxJTzP4EI7w4kNilJoCNzH5dg
         ESwkvKYwaOGqsz0A7yXIR6EWgdh+qTFebH/4ReCGY9vOjlWo270uae05EkbDzbEKDpWa
         GHWiVw+nTp13hnx2LGc7yZlSyr/3HredfGCs9szVo8dMORYN4xvR0qhZZqxc5Z6wERWZ
         A/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dtQ+eEC76CpNq4iFz6Rhy5rCcSmVIHg+Fd4Jtdeguhg=;
        b=Cf7EYAkKAPMwjNiO13MVpzePh0dEeuU92j9H05Sa2u5kPKZmemfBqERGW7V5jQYYjk
         xPWBiaryf86Qm3UqhDhdXnSGiTI66BEhqAgwmpFV8cDvUUpiPMJMbOtdfnZKTxRh+c0/
         iYQTHs3ILiG6iY+mS7WD7S6SkrKPf1s4czjjwFeKlkW4uY2zpmolKG7z87St0QyvtTVB
         PybVH7Cu6Xdn/QJ//dBeIn9QoRbRMotH4doVFFP5RZcnpIu/cUDycHOyegzUd9iaeCxU
         PUs4RQ0rnWgFGoZQHQks0Xe4IQ+LakyY17WqEcZc2DTO89c3oO5a8r7eKwvqxhvONMOE
         aDpg==
X-Gm-Message-State: ACgBeo2MLzWV0mXeOuC/HFGniQ9yt8aRNRH0T2xto7ensLykj4qSWucH
	8TLrAr94uFUAxsx9IEVWheo1vaSVcpU=
X-Google-Smtp-Source: AA6agR6LCdVwD87kPWyxLTLj0D18nEwpmS3Qcx0KdT0Tklr+8qO3TzyFdDjYsN2nPbJCt9vtcpWUNA==
X-Received: by 2002:a17:903:228a:b0:172:ea8f:f2fd with SMTP id b10-20020a170903228a00b00172ea8ff2fdmr1080617plh.33.1661381725238;
        Wed, 24 Aug 2022 15:55:25 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id jn22-20020a170903051600b0016bcc35000asm6228682plb.302.2022.08.24.15.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:55:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/9] station: don't set OCVC for FT AKMs
Date: Wed, 24 Aug 2022 15:55:11 -0700
Message-Id: <20220824225518.2558698-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220824225518.2558698-1-prestwoj@gmail.com>
References: <20220824225518.2558698-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using OCV in FT is now disabled, so if the AKM is FT don't set the
capability or AP's may reject FT attempts.
---
 src/station.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 66b296b8..cdc31127 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1110,9 +1110,15 @@ build_ie:
 	 * seen that they do not include the OCI in the 4-way handshake yet
 	 * still advertise the capability. Because of this OCV is disabled if
 	 * any offload features are detected (since IWD prefers to use offload).
+	 *
+	 * TODO: For now OCV is disabled if the network is FT capable. This is
+	 *       being done until support in the kernel is added to
+	 *       automatically include the OCI element for the association
+	 *       request.
 	 */
 	info.ocvc = !disable_ocv && bss_info.ocvc && info.mfpc &&
-			!wiphy_can_offload(wiphy);
+			!wiphy_can_offload(wiphy) &&
+			!IE_AKM_IS_FT(info.akm_suites);
 
 	/*
 	 * IEEE 802.11-2020 9.4.2.24.4 states extended key IDs can only be used
-- 
2.34.3

