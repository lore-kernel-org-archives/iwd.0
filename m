Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096061118
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 04:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzlYgMXE"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1fa21f561a1so674430fac.3
        for <iwd@lists.linux.dev>; Sun, 26 Nov 2023 20:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701060013; x=1701664813; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfHHDyb4tRLAYb0iJOZcpiUtWFE/ruaAKATQxemdK5U=;
        b=fzlYgMXE6k39sgCAKJbRYBoEJ3MunxFCW9mu6VO28pcycELyUChbCzHSsoYm6kRS+l
         VWsCteuBfCpQYgeIi95IMekGMvLxWy92VCZFp7iqU0w25urT4ixDYcOH6Kne7BcI2e4v
         tMCHJ+0ibdr3tZxzuI3G6hd3K9n9cfrLTwd3/0gYnZ8yYj8T8napUWdrcZpuYF/cpd77
         MrF1d37JCxDM9LAv6my1tMkCj2xxzZ/BP1gAgBPL5rQD0B7Qx7RZbmdKs8sIETnQZNK2
         /q8m/1tQLklZ7X21tOD5hwBEaBmZ/8R3f2J6n2M7vSf+DOtS2tIKPNQw0SfkKQR+Qgrp
         aZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701060013; x=1701664813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfHHDyb4tRLAYb0iJOZcpiUtWFE/ruaAKATQxemdK5U=;
        b=YwfUD1id+NpWqfpklcDqO+sWON2wOoGkkMX9VBSyAlIWTIWBj6qntKPV1QlmqpSTBb
         g43VZN/QMAKZvyRlheUv2nx8bmi3oZmy5yMGKoVhnizORVTNW6fDD2BM+HRXhLE7QwO0
         M9dgTrtPkMtVygkD2MNSGCon+A8lNkX4rXLPSb1zNfdiYLIuxaQJmEhMFjLynwoZ3W5K
         GkFvnBj2ITERJaVPoYtFet1D6ZCagncw1jjxOY47PkT8BYLMplF5i3pfBjaU7UqJV1IA
         ZeP1hpbGAXlUN7cevkjkPeGkWFp0tsMRPpKtQixgTgWgBdNFa6vZ9aS+7mK9ZKfJDv6G
         ZgNQ==
X-Gm-Message-State: AOJu0YxkxdkRQNiONLd5m06qK8hETfK81CLsBaQOPO7ZBk6lD94XAA+h
	qhTr30+OKitGvHrRUlLCt1hKEhMvmQA=
X-Google-Smtp-Source: AGHT+IH0vMdyTpmVZEgPjqhEB+TAfRm/ymiqDZx00n/fHzM6Ywt5dawqyfzXoEDzfGQjfB6muEgfUQ==
X-Received: by 2002:a05:6871:590:b0:1f9:e76e:174e with SMTP id u16-20020a056871059000b001f9e76e174emr11660722oan.18.1701060012948;
        Sun, 26 Nov 2023 20:40:12 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id nq6-20020a056871378600b001f5d5930e85sm2110558oac.33.2023.11.26.20.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 20:40:12 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 2/6] nl80211util: Move nl80211_append_rsn_attributes
Date: Sun, 26 Nov 2023 22:38:42 -0600
Message-ID: <20231127043924.1328538-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127043924.1328538-1-denkenz@gmail.com>
References: <20231127043924.1328538-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Makefile.am       |  1 +
 src/netdev.c      | 43 ++-----------------------------------------
 src/nl80211util.c | 40 ++++++++++++++++++++++++++++++++++++++++
 src/nl80211util.h |  4 ++++
 4 files changed, 47 insertions(+), 41 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index d0247faf7ed5..5ed6ab37164b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -407,6 +407,7 @@ tools_hwsim_SOURCES = tools/hwsim.c src/mpdu.h \
 					src/storage.h src/storage.c \
 					src/common.h src/common.c \
 					src/band.h src/band.c \
+					src/ie.h src/ie.c \
 					src/crypto.h src/crypto.c
 tools_hwsim_LDADD = $(ell_ldadd)
 
diff --git a/src/netdev.c b/src/netdev.c
index 7b951a6a4797..1c032b32acdc 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2445,45 +2445,6 @@ static void netdev_driver_connected(struct netdev *netdev)
 		eapol_register(netdev->sm);
 }
 
-
-static void netdev_append_nl80211_rsn_attributes(struct l_genl_msg *msg,
-						struct handshake_state *hs)
-{
-	uint32_t nl_cipher;
-	uint32_t nl_akm;
-	uint32_t wpa_version;
-
-	nl_cipher = ie_rsn_cipher_suite_to_cipher(hs->pairwise_cipher);
-	L_WARN_ON(!nl_cipher);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_CIPHER_SUITES_PAIRWISE,
-					4, &nl_cipher);
-
-	nl_cipher = ie_rsn_cipher_suite_to_cipher(hs->group_cipher);
-	L_WARN_ON(!nl_cipher);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_CIPHER_SUITE_GROUP,
-					4, &nl_cipher);
-
-	if (hs->mfp) {
-		uint32_t use_mfp = NL80211_MFP_REQUIRED;
-
-		l_genl_msg_append_attr(msg, NL80211_ATTR_USE_MFP, 4, &use_mfp);
-	}
-
-	nl_akm = ie_rsn_akm_suite_to_akm(hs->akm_suite);
-	L_WARN_ON(!nl_akm);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_AKM_SUITES, 4, &nl_akm);
-
-	if (IE_AKM_IS_SAE(hs->akm_suite))
-		wpa_version = NL80211_WPA_VERSION_3;
-	else if (hs->wpa_ie)
-		wpa_version = NL80211_WPA_VERSION_1;
-	else
-		wpa_version = NL80211_WPA_VERSION_2;
-
-	l_genl_msg_append_attr(msg, NL80211_ATTR_WPA_VERSIONS,
-						4, &wpa_version);
-}
-
 static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
 						struct handshake_state *hs,
 						const uint8_t *prev_bssid,
@@ -2540,7 +2501,7 @@ static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
 	l_genl_msg_append_attr(msg, NL80211_ATTR_SOCKET_OWNER, 0, NULL);
 
 	if (is_rsn) {
-		netdev_append_nl80211_rsn_attributes(msg, hs);
+		nl80211_append_rsn_attributes(msg, hs);
 		c_iov = iov_ie_append(iov, n_iov, c_iov, hs->supplicant_ie);
 	}
 
@@ -2888,7 +2849,7 @@ static struct l_genl_msg *netdev_build_cmd_associate_common(
 	l_genl_msg_append_attr(msg, NL80211_ATTR_SOCKET_OWNER, 0, NULL);
 
 	if (is_rsn)
-		netdev_append_nl80211_rsn_attributes(msg, hs);
+		nl80211_append_rsn_attributes(msg, hs);
 
 	if (is_rsn || hs->settings_8021x) {
 		l_genl_msg_append_attr(msg, NL80211_ATTR_CONTROL_PORT,
diff --git a/src/nl80211util.c b/src/nl80211util.c
index ef69cc718e04..0f45c9051330 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -32,6 +32,8 @@
 
 #include "src/nl80211util.h"
 #include "src/band.h"
+#include "src/ie.h"
+#include "src/handshake.h"
 #include "src/util.h"
 
 typedef bool (*attr_handler)(const void *data, uint16_t len, void *o);
@@ -687,3 +689,41 @@ int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
 
 	return 0;
 }
+
+void nl80211_append_rsn_attributes(struct l_genl_msg *msg,
+						struct handshake_state *hs)
+{
+	uint32_t nl_cipher;
+	uint32_t nl_akm;
+	uint32_t wpa_version;
+
+	nl_cipher = ie_rsn_cipher_suite_to_cipher(hs->pairwise_cipher);
+	L_WARN_ON(!nl_cipher);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_CIPHER_SUITES_PAIRWISE,
+					4, &nl_cipher);
+
+	nl_cipher = ie_rsn_cipher_suite_to_cipher(hs->group_cipher);
+	L_WARN_ON(!nl_cipher);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_CIPHER_SUITE_GROUP,
+					4, &nl_cipher);
+
+	if (hs->mfp) {
+		uint32_t use_mfp = NL80211_MFP_REQUIRED;
+
+		l_genl_msg_append_attr(msg, NL80211_ATTR_USE_MFP, 4, &use_mfp);
+	}
+
+	nl_akm = ie_rsn_akm_suite_to_akm(hs->akm_suite);
+	L_WARN_ON(!nl_akm);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_AKM_SUITES, 4, &nl_akm);
+
+	if (IE_AKM_IS_SAE(hs->akm_suite))
+		wpa_version = NL80211_WPA_VERSION_3;
+	else if (hs->wpa_ie)
+		wpa_version = NL80211_WPA_VERSION_1;
+	else
+		wpa_version = NL80211_WPA_VERSION_2;
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WPA_VERSIONS,
+						4, &wpa_version);
+}
diff --git a/src/nl80211util.h b/src/nl80211util.h
index 9f8ae17aeaa4..6f7b9eabbc27 100644
--- a/src/nl80211util.h
+++ b/src/nl80211util.h
@@ -25,6 +25,7 @@
 struct band_chandef;
 struct scan_freq_set;
 struct band_freq_attrs;
+struct handshake_state;
 
 int nl80211_parse_attrs(struct l_genl_msg *msg, int tag, ...);
 
@@ -90,3 +91,6 @@ int nl80211_parse_supported_frequencies(struct l_genl_attr *band_freqs,
 					struct scan_freq_set *supported_list,
 					struct band_freq_attrs *list,
 					size_t num_channels);
+
+void nl80211_append_rsn_attributes(struct l_genl_msg *msg,
+						struct handshake_state *hs);
-- 
2.42.0

