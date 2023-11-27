Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E37010F8
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 04:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibeCx3YR"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6d81fbfe7aaso493561a34.1
        for <iwd@lists.linux.dev>; Sun, 26 Nov 2023 20:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701060012; x=1701664812; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kOTUEgUpIUa3xSXsm+qBrM9i2hQEQ7mS1G0rrydGMY4=;
        b=ibeCx3YRFdCWnbkE0gC70a1H+1+0rJH1WrFKOfP2ZOGsVBdsQfM8dRRN25tXorhW3j
         Ak0FjRo+ieyEe3N9ZOHPvB27CVceXCSYBJP6HfvAtOkVcNwRxee742Ykph8V8gvTEPF7
         Rf7nrAvQvFJRODG2Im2XBiXHrxjPf7jei1z/Wb+2acTnsl5SfrXAS69bq/I8R4hwB9+t
         axmAQwS2RAR1EhCc+Zswh+XhDUtPtmntOyfbg5zngWVpG4aFld51v/wngb7SQXFD7pIm
         /34ZhyJsIEKk7RUGuou9B5XOqjSR/WL1Swc2NhJlFnjkRp4RTsgDk5C07QMv07u9LcqS
         7uzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701060012; x=1701664812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOTUEgUpIUa3xSXsm+qBrM9i2hQEQ7mS1G0rrydGMY4=;
        b=azA0iAtJOgPI0er00DlO28g+1QqbntfNOiT4f5LlAl/GmBjLkww9E2rBhXu73g/b0i
         mJUdgJG5BzPwLPgAvFpio4RDwFzV/unxr3BRm1tTPbUbfa10R6o/GRn/zapdUesK1lm2
         I81setrBMLdXBJPRfAnxQ5dNRQDKpaT+tDv7JWCzin94xdgWIEziZFIuNqzTkKIFUgX2
         X3C79vZbdS22FrJrfOPQCV8IRZGfM+7WMO2mTb41CsN2d0RpGLVtZNcrB26urz97uuhX
         3x03RJq3h290EaqUzaTC5zmVg5Gd2x9E9hJvZMt//swQy3Ov7dtDpKZni7evpVFLTBLI
         z+GA==
X-Gm-Message-State: AOJu0YzdsTFH+krvWP33fnUrYm9wa+a2R3CH16FKE7lnP4O18QRf0aPV
	MtlcPpThOthYACSAk+I6p9Rbk+Wn/jw=
X-Google-Smtp-Source: AGHT+IF4Csbew0DtREwn5tdNnt+vWfKZ+L4lYHZR+VsMkyMt+QnRsC14+04SSdP4coqc/qU2v3JMFg==
X-Received: by 2002:a05:6870:3c0c:b0:1fa:692:f37e with SMTP id gk12-20020a0568703c0c00b001fa0692f37emr13465042oab.57.1701060012326;
        Sun, 26 Nov 2023 20:40:12 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id nq6-20020a056871378600b001f5d5930e85sm2110558oac.33.2023.11.26.20.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 20:40:11 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 1/6] ie: Move AKM suite converter from netdev
Date: Sun, 26 Nov 2023 22:38:41 -0600
Message-ID: <20231127043924.1328538-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is more logical to host this function inside ie.c than netdev.c.
Particularly since ie_rsn_cipher_suite_to_cipher is already present in
ie.c.
---
 src/ie.c     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 src/ie.h     |  2 ++
 src/netdev.c | 47 +----------------------------------------------
 3 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/src/ie.c b/src/ie.c
index 6b08ce180a87..a51724aa74c8 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -481,6 +481,52 @@ const char *ie_rsn_cipher_suite_to_string(enum ie_rsn_cipher_suite suite)
 	return NULL;
 }
 
+uint32_t ie_rsn_akm_suite_to_akm(enum ie_rsn_akm_suite akm)
+{
+	switch (akm) {
+	case IE_RSN_AKM_SUITE_8021X:
+		return CRYPTO_AKM_8021X;
+	case IE_RSN_AKM_SUITE_PSK:
+		return CRYPTO_AKM_PSK;
+	case IE_RSN_AKM_SUITE_FT_OVER_8021X:
+		return CRYPTO_AKM_FT_OVER_8021X;
+	case IE_RSN_AKM_SUITE_FT_USING_PSK:
+		return CRYPTO_AKM_FT_USING_PSK;
+	case IE_RSN_AKM_SUITE_8021X_SHA256:
+		return CRYPTO_AKM_8021X_SHA256;
+	case IE_RSN_AKM_SUITE_PSK_SHA256:
+		return CRYPTO_AKM_PSK_SHA256;
+	case IE_RSN_AKM_SUITE_TDLS:
+		return CRYPTO_AKM_TDLS;
+	case IE_RSN_AKM_SUITE_SAE_SHA256:
+		return CRYPTO_AKM_SAE_SHA256;
+	case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
+		return CRYPTO_AKM_FT_OVER_SAE_SHA256;
+	case IE_RSN_AKM_SUITE_AP_PEER_KEY_SHA256:
+		return CRYPTO_AKM_AP_PEER_KEY_SHA256;
+	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA256:
+		return CRYPTO_AKM_8021X_SUITE_B_SHA256;
+	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA384:
+		return CRYPTO_AKM_8021X_SUITE_B_SHA384;
+	case IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384:
+		return CRYPTO_AKM_FT_OVER_8021X_SHA384;
+	case IE_RSN_AKM_SUITE_FILS_SHA256:
+		return CRYPTO_AKM_FILS_SHA256;
+	case IE_RSN_AKM_SUITE_FILS_SHA384:
+		return CRYPTO_AKM_FILS_SHA384;
+	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
+		return CRYPTO_AKM_FT_OVER_FILS_SHA256;
+	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
+		return CRYPTO_AKM_FT_OVER_FILS_SHA384;
+	case IE_RSN_AKM_SUITE_OWE:
+		return CRYPTO_AKM_OWE;
+	case IE_RSN_AKM_SUITE_OSEN:
+		return CRYPTO_AKM_OSEN;
+	}
+
+	return 0;
+}
+
 /* 802.11, Section 8.4.2.27.2 */
 static bool ie_parse_cipher_suite(const uint8_t *data,
 					enum ie_rsn_cipher_suite *out)
diff --git a/src/ie.h b/src/ie.h
index c9a6c78324d6..9ada64bf3bd7 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -621,6 +621,8 @@ unsigned char *ie_tlv_builder_finalize(struct ie_tlv_builder *builder,
 uint32_t ie_rsn_cipher_suite_to_cipher(enum ie_rsn_cipher_suite suite);
 const char *ie_rsn_cipher_suite_to_string(enum ie_rsn_cipher_suite suite);
 
+uint32_t ie_rsn_akm_suite_to_akm(enum ie_rsn_akm_suite akm);
+
 int ie_parse_rsne(struct ie_tlv_iter *iter, struct ie_rsn_info *info);
 int ie_parse_rsne_from_data(const uint8_t *data, size_t len,
 				struct ie_rsn_info *info);
diff --git a/src/netdev.c b/src/netdev.c
index f23ca59ea1cb..7b951a6a4797 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2445,51 +2445,6 @@ static void netdev_driver_connected(struct netdev *netdev)
 		eapol_register(netdev->sm);
 }
 
-static unsigned int ie_rsn_akm_suite_to_nl80211(enum ie_rsn_akm_suite akm)
-{
-	switch (akm) {
-	case IE_RSN_AKM_SUITE_8021X:
-		return CRYPTO_AKM_8021X;
-	case IE_RSN_AKM_SUITE_PSK:
-		return CRYPTO_AKM_PSK;
-	case IE_RSN_AKM_SUITE_FT_OVER_8021X:
-		return CRYPTO_AKM_FT_OVER_8021X;
-	case IE_RSN_AKM_SUITE_FT_USING_PSK:
-		return CRYPTO_AKM_FT_USING_PSK;
-	case IE_RSN_AKM_SUITE_8021X_SHA256:
-		return CRYPTO_AKM_8021X_SHA256;
-	case IE_RSN_AKM_SUITE_PSK_SHA256:
-		return CRYPTO_AKM_PSK_SHA256;
-	case IE_RSN_AKM_SUITE_TDLS:
-		return CRYPTO_AKM_TDLS;
-	case IE_RSN_AKM_SUITE_SAE_SHA256:
-		return CRYPTO_AKM_SAE_SHA256;
-	case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
-		return CRYPTO_AKM_FT_OVER_SAE_SHA256;
-	case IE_RSN_AKM_SUITE_AP_PEER_KEY_SHA256:
-		return CRYPTO_AKM_AP_PEER_KEY_SHA256;
-	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA256:
-		return CRYPTO_AKM_8021X_SUITE_B_SHA256;
-	case IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA384:
-		return CRYPTO_AKM_8021X_SUITE_B_SHA384;
-	case IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384:
-		return CRYPTO_AKM_FT_OVER_8021X_SHA384;
-	case IE_RSN_AKM_SUITE_FILS_SHA256:
-		return CRYPTO_AKM_FILS_SHA256;
-	case IE_RSN_AKM_SUITE_FILS_SHA384:
-		return CRYPTO_AKM_FILS_SHA384;
-	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
-		return CRYPTO_AKM_FT_OVER_FILS_SHA256;
-	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
-		return CRYPTO_AKM_FT_OVER_FILS_SHA384;
-	case IE_RSN_AKM_SUITE_OWE:
-		return CRYPTO_AKM_OWE;
-	case IE_RSN_AKM_SUITE_OSEN:
-		return CRYPTO_AKM_OSEN;
-	}
-
-	return 0;
-}
 
 static void netdev_append_nl80211_rsn_attributes(struct l_genl_msg *msg,
 						struct handshake_state *hs)
@@ -2514,7 +2469,7 @@ static void netdev_append_nl80211_rsn_attributes(struct l_genl_msg *msg,
 		l_genl_msg_append_attr(msg, NL80211_ATTR_USE_MFP, 4, &use_mfp);
 	}
 
-	nl_akm = ie_rsn_akm_suite_to_nl80211(hs->akm_suite);
+	nl_akm = ie_rsn_akm_suite_to_akm(hs->akm_suite);
 	L_WARN_ON(!nl_akm);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_AKM_SUITES, 4, &nl_akm);
 
-- 
2.42.0

