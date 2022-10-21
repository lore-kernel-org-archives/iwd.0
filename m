Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8113D60
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:38 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1324e7a1284so4712359fac.10
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECxO2H/ORGE1Urt6IuFQBDeZmF4FOWh6df8NeLalpVg=;
        b=dLd02jaFEk2sI3138F0NsqeGSU3tgL1vrMX62k4YVNxHXv+Iug1bp+mrfB+rq4rk/e
         +pKG+FAhOvimsZwd6evwAi0gH8gJSxFgA+Q3n1gk4tuKdBbHhCk+mbZRYIK2IkItF2R4
         S/CluaP18Sn9r7iN2Wb53wBsZzg0Zv+zUofPwwr1e7sWsTcLd5e0S/Y07fjG/A3Q3xH3
         jns78FYCedUfq7B4bwY3NN4UVux3O/FHmXCCXuRcGriI5soXB/AyqtA1ah3mxjUpD7L8
         ONxq+pg/UkPOuelraxwafW0MZhzFpqFmacrrbh3npv2RCp3XD88fXGjUFgwqa2ELQ2n0
         4WPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECxO2H/ORGE1Urt6IuFQBDeZmF4FOWh6df8NeLalpVg=;
        b=qFe+c+3GT9sG8WrWnrxzdOgCSEIZB1yK+RkuWys+ah8S6M+ve1cflMJJkILZEf9gTm
         bBKUxKnkEDQi32cl4YvlECtmTYHthzqN7zF1SSgPf+D2ylkTOtUJz589gFdVLp3mXNf2
         mbLBBVxQAgwi2zl5k5gtPgYOLe/weowjY2RpZrAzvR3nqsrHKBhWLcNtssw8JTozVoV8
         HJq6TYoaupqKkPHeU5zQegvlYklEcIyDl9vsUx++JcR9IG+JccE3iqU+pzx7c7IRxmH9
         ZS6dTi+w/1R6YmXZgWf91BOByiJ6ibAXVkbhd801Nx+XpcpRs0yL5/Rjn1Tsj6x1gTon
         zSvg==
X-Gm-Message-State: ACrzQf0ijGIKnXeq0S+cZ/S3lo6zTnKkAh9pw3PnwzwovQF+y+gyR3oH
	2cTjRcI465QeKRZq+UW1HW17l7JMcRI=
X-Google-Smtp-Source: AMsMyM44gKCwlxayH67bJsLNqkxISnse11h0ZB0PylaWBnxotrB+yFP5qJxvxQEzUyVXX1UZTifkeg==
X-Received: by 2002:a05:6870:d348:b0:131:9f68:cd49 with SMTP id h8-20020a056870d34800b001319f68cd49mr13466103oag.231.1666379616820;
        Fri, 21 Oct 2022 12:13:36 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:35 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 07/26] netdev: Build RSN attributes in a common function
Date: Fri, 21 Oct 2022 14:12:48 -0500
Message-Id: <20221021191307.31492-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021191307.31492-1-denkenz@gmail.com>
References: <20221021191307.31492-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both CMD_ASSOCIATE and CMD_CONNECT paths were using very similar code to
build RSN specific attributes.  Use a common function to build these
attributes to cut down on duplicated code.

While here, also start using ie_rsn_cipher_suite_to_cipher instead of
assuming that the pairwise / group ciphers can only be CCMP or TKIP.
---
 src/netdev.c | 139 ++++++++++++++++++++-------------------------------
 1 file changed, 53 insertions(+), 86 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index cd8e70863d3a..231ed9862cc5 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2519,6 +2519,44 @@ static unsigned int ie_rsn_akm_suite_to_nl80211(enum ie_rsn_akm_suite akm)
 	return 0;
 }
 
+static void netdev_append_nl80211_rsn_attributes(struct l_genl_msg *msg,
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
+	nl_akm = ie_rsn_akm_suite_to_nl80211(hs->akm_suite);
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
+
 static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
 						struct handshake_state *hs,
 						const uint8_t *prev_bssid,
@@ -2575,49 +2613,18 @@ static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
 	l_genl_msg_append_attr(msg, NL80211_ATTR_SOCKET_OWNER, 0, NULL);
 
 	if (is_rsn) {
-		uint32_t nl_cipher;
-		uint32_t nl_akm;
-		uint32_t wpa_version;
-
-		if (hs->pairwise_cipher == IE_RSN_CIPHER_SUITE_CCMP)
-			nl_cipher = CRYPTO_CIPHER_CCMP;
-		else
-			nl_cipher = CRYPTO_CIPHER_TKIP;
-
-		l_genl_msg_append_attr(msg, NL80211_ATTR_CIPHER_SUITES_PAIRWISE,
-					4, &nl_cipher);
-
-		if (hs->group_cipher == IE_RSN_CIPHER_SUITE_CCMP)
-			nl_cipher = CRYPTO_CIPHER_CCMP;
-		else
-			nl_cipher = CRYPTO_CIPHER_TKIP;
-
-		l_genl_msg_append_attr(msg, NL80211_ATTR_CIPHER_SUITE_GROUP,
-					4, &nl_cipher);
-
-		if (hs->mfp) {
-			uint32_t use_mfp = NL80211_MFP_REQUIRED;
-			l_genl_msg_append_attr(msg, NL80211_ATTR_USE_MFP,
-								4, &use_mfp);
-		}
-
-		nl_akm = ie_rsn_akm_suite_to_nl80211(hs->akm_suite);
-		if (nl_akm)
-			l_genl_msg_append_attr(msg, NL80211_ATTR_AKM_SUITES,
-							4, &nl_akm);
-
-		if (IE_AKM_IS_SAE(hs->akm_suite))
-			wpa_version = NL80211_WPA_VERSION_3;
-		else if (hs->wpa_ie)
-			wpa_version = NL80211_WPA_VERSION_1;
-		else
-			wpa_version = NL80211_WPA_VERSION_2;
+		netdev_append_nl80211_rsn_attributes(msg, hs);
+		c_iov = iov_ie_append(iov, n_iov, c_iov, hs->supplicant_ie);
+	}
 
-		l_genl_msg_append_attr(msg, NL80211_ATTR_WPA_VERSIONS,
-						4, &wpa_version);
+	if (is_rsn || hs->settings_8021x) {
+		l_genl_msg_append_attr(msg, NL80211_ATTR_CONTROL_PORT,
+						0, NULL);
 
-		l_genl_msg_append_attr(msg, NL80211_ATTR_CONTROL_PORT, 0, NULL);
-		c_iov = iov_ie_append(iov, n_iov, c_iov, hs->supplicant_ie);
+		if (netdev->pae_over_nl80211)
+			l_genl_msg_append_attr(msg,
+					NL80211_ATTR_CONTROL_PORT_OVER_NL80211,
+					0, NULL);
 	}
 
 	if (netdev->owe_sm) {
@@ -2625,11 +2632,6 @@ static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
 		c_iov = iov_ie_append(iov, n_iov, c_iov, owe_dh_ie);
 	}
 
-	if (netdev->pae_over_nl80211)
-		l_genl_msg_append_attr(msg,
-				NL80211_ATTR_CONTROL_PORT_OVER_NL80211,
-				0, NULL);
-
 	c_iov = iov_ie_append(iov, n_iov, c_iov, hs->mde);
 	c_iov = netdev_populate_common_ies(netdev, hs, msg, iov, n_iov, c_iov);
 
@@ -2953,52 +2955,17 @@ static struct l_genl_msg *netdev_build_cmd_associate_common(
 	l_genl_msg_append_attr(msg, NL80211_ATTR_SSID, hs->ssid_len, hs->ssid);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_SOCKET_OWNER, 0, NULL);
 
-	if (is_rsn) {
-		uint32_t nl_cipher;
-		uint32_t nl_akm;
-		uint32_t wpa_version;
+	if (is_rsn)
+		netdev_append_nl80211_rsn_attributes(msg, hs);
 
-		l_genl_msg_append_attr(msg, NL80211_ATTR_CONTROL_PORT, 0, NULL);
+	if (is_rsn || hs->settings_8021x) {
+		l_genl_msg_append_attr(msg, NL80211_ATTR_CONTROL_PORT,
+						0, NULL);
 
 		if (netdev->pae_over_nl80211)
 			l_genl_msg_append_attr(msg,
 					NL80211_ATTR_CONTROL_PORT_OVER_NL80211,
 					0, NULL);
-
-		if (hs->pairwise_cipher == IE_RSN_CIPHER_SUITE_CCMP)
-			nl_cipher = CRYPTO_CIPHER_CCMP;
-		else
-			nl_cipher = CRYPTO_CIPHER_TKIP;
-
-		l_genl_msg_append_attr(msg, NL80211_ATTR_CIPHER_SUITES_PAIRWISE,
-					4, &nl_cipher);
-
-		if (hs->group_cipher == IE_RSN_CIPHER_SUITE_CCMP)
-			nl_cipher = CRYPTO_CIPHER_CCMP;
-		else
-			nl_cipher = CRYPTO_CIPHER_TKIP;
-
-		l_genl_msg_append_attr(msg, NL80211_ATTR_CIPHER_SUITE_GROUP,
-					4, &nl_cipher);
-
-		if (hs->mfp) {
-			uint32_t use_mfp = NL80211_MFP_REQUIRED;
-			l_genl_msg_append_attr(msg, NL80211_ATTR_USE_MFP,
-								4, &use_mfp);
-		}
-
-		nl_akm = ie_rsn_akm_suite_to_nl80211(hs->akm_suite);
-		if (nl_akm)
-			l_genl_msg_append_attr(msg, NL80211_ATTR_AKM_SUITES,
-							4, &nl_akm);
-
-		if (hs->wpa_ie)
-			wpa_version = NL80211_WPA_VERSION_1;
-		else
-			wpa_version = NL80211_WPA_VERSION_2;
-
-		l_genl_msg_append_attr(msg, NL80211_ATTR_WPA_VERSIONS,
-						4, &wpa_version);
 	}
 
 	return msg;
-- 
2.35.1

