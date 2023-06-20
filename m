Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C03C2AB53
	for <iwd@lists.linux.dev>; Tue, 20 Jun 2023 17:25:44 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-62de5392c7bso33173866d6.2
        for <iwd@lists.linux.dev>; Tue, 20 Jun 2023 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687281943; x=1689873943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VM/IO02ODlTyZhnSNKt9OS43tEFlN4s9sLIQhPn4UMM=;
        b=jJ19Epx3TG0QWrv2LhQ1oyTi2x29pGt/DZKxG6/o2A/eXcQhMbegmnPTlKJ8Q/f1KN
         95H3X6abiDbEjW9x6egL6GJZOS/RXihLDZCMxsjq7moO9rRpFUXN/kOO0fjGbPxnEKS/
         7okUDM/YYj1YV7LklwkD3e3pZ7qjzIFL1gi6MokfYi0oRH6iCynLJZAYorCP+9XZsGKq
         QRakHoV0m1UZ8/92q9XXDOFeG0tWPur4A2g5Y+fsJD55baDkcRHs3U9DzBbnagYu13jQ
         nIr7XbOPxwKgzn/XAlx8d3jQcpZvAhENi8+mw8UaNwmkZpvY9HzjLZUXNO4OefZwyqvs
         jkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281943; x=1689873943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM/IO02ODlTyZhnSNKt9OS43tEFlN4s9sLIQhPn4UMM=;
        b=braf2oWyDn687dospLIruCi76mQ/M5X1mRTkcFqqo9l5XWQo2zBhOWNWDpclEqzel5
         z2dD0XfIKAMAejyPRK4P30FG8ylOT2W1eAcecElkcugSGzDfwhUgcbfyhVq8ASWPr0w1
         GV4NMNJ/ufkFsyTsLuLFWdKn+lHG+P8LKNNlV4gdMy1ZmRIYR+N+0FKD9V3nZJB0Y/jD
         yBCV31qqgPAu6mCi3ahzjfuBFSCUrdUnlU9T6LReuERJMDjtYDxzReJR4HVHDEdTDdtU
         sqmR31ct0YnwJbqqUgyOmvZj6+hfOVrnIfTxyLXZCDwA7fXc9+WsCZ7bBI3zbJTwG/dW
         ldxg==
X-Gm-Message-State: AC+VfDxeSIWHRZYbBf4kCQBkjkto5hSfbNKX3n9AnW7Npo4gq1zWjofD
	zkjrq0m3WIkWWjtgG3tygeuLc04L09D3Aw==
X-Google-Smtp-Source: ACHHUZ59X+x2V9DX4EZDAH6iHw5TA4g6c0k/s00Cinm0Q32//jDQ4fRg056+LhKfVFDAETc6vFWTHQ==
X-Received: by 2002:a05:6214:2a8f:b0:630:14e0:9827 with SMTP id jr15-20020a0562142a8f00b0063014e09827mr10004322qvb.28.1687281943236;
        Tue, 20 Jun 2023 10:25:43 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id g8-20020a0cf088000000b006261e6a88c7sm1475913qvk.36.2023.06.20.10.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 10:25:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3 v2] handshake: handshake: add FT_OVER_8021X AKM for SHA256 PMKID derivation
Date: Tue, 20 Jun 2023 10:25:33 -0700
Message-Id: <20230620172533.727504-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230620172533.727504-1-prestwoj@gmail.com>
References: <20230620172533.727504-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hostapd commit b6d3fd05e3 changed the PMKID derivation in accordance
with 802.11-2020 which then breaks PMKID validation in IWD. This
breaks the FT-8021x AKM in IWD if the AP uses this hostapd version
since the PMKID doesn't validate during EAPoL.

This updates the PMKID derivation to use the correct SHA hash for
this AKM, and following patches will address backwards compatibility
with older hostapd versions.
---
 src/handshake.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/src/handshake.c b/src/handshake.c
index 46755841..6b93774a 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -756,8 +756,26 @@ bool handshake_state_pmkid_matches(struct handshake_state *s,
 	uint8_t own_pmkid[16];
 	enum l_checksum_type sha;
 
+	/*
+	 * 802.11-2020 Table 9-151 defines the hashing algorithm to use
+	 * for various AKM's. Note some AKMs are omitted here because they
+	 * export the PMKID individually (SAE/FILS/FT-PSK)
+	 *
+	 * SHA1:
+	 * 	00-0F-AC:1 (8021X)
+	 * 	00-0F-AC:2 (PSK)
+	 *
+	 * SHA256:
+	 * 	00-0F-AC:3 (FT-8021X)
+	 * 	00-0F-AC:5 (8021X-SHA256)
+	 * 	00-0F-AC:6 (PSK-SHA256)
+	 *
+	 * SHA384:
+	 * 	00-0F-AC:13 (FT-8021X-SHA384)
+	 */
 	if (s->akm_suite & (IE_RSN_AKM_SUITE_8021X_SHA256 |
-			IE_RSN_AKM_SUITE_PSK_SHA256))
+			IE_RSN_AKM_SUITE_PSK_SHA256 |
+			IE_RSN_AKM_SUITE_FT_OVER_8021X))
 		sha = L_CHECKSUM_SHA256;
 	else
 		sha = L_CHECKSUM_SHA1;
@@ -765,7 +783,19 @@ bool handshake_state_pmkid_matches(struct handshake_state *s,
 	if (!handshake_state_get_pmkid(s, own_pmkid, sha))
 		return false;
 
-	return l_secure_memcmp(own_pmkid, check, 16) == 0;
+	if (l_secure_memcmp(own_pmkid, check, 16)) {
+		if (s->akm_suite != IE_RSN_AKM_SUITE_FT_OVER_8021X)
+			return false;
+
+		l_debug("PMKID did not match, trying SHA1 derivation");
+
+		if (!handshake_state_get_pmkid(s, own_pmkid, L_CHECKSUM_SHA1))
+			return false;
+
+		return l_secure_memcmp(own_pmkid, check, 16) == 0;
+	}
+
+	return true;
 }
 
 void handshake_state_set_gtk(struct handshake_state *s, const uint8_t *key,
-- 
2.25.1

