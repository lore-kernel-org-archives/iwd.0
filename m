Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1BD5F1F0
	for <iwd@lists.linux.dev>; Tue,  5 Dec 2023 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaGboaGr"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-58ceabd7cdeso3501686eaf.3
        for <iwd@lists.linux.dev>; Tue, 05 Dec 2023 07:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701791215; x=1702396015; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5sYOH7EK86gdZlBKFuGUGGBNmbTPUNMQuZN0UpGjRs=;
        b=VaGboaGr2Ns+lpNXct5fF/X2ikDmPMlAa7Ehk2h7VH/pGQBB+soqVCtCfUS/Y9RmdN
         FtoxX/zZun6MTC8NjUYhwctO8NlXfbZ7jf2FEROIZbx3AtYPdcicZb/AjA+kBTfOZgxP
         zHjWZP8DDVGpTHw6L9KSGLXpHE2HDPs/f1pP9iNMAWw9YvJFoleBzFG941hS88v6szxn
         tzEgVkMFbmHAwppO+7SEZLuJWfbHtpeUUB39WdVM4ZfaLRRxzv2unseLZ0bHDh1RJmEz
         aWzFo6nbKgaicQAwuMI5dW626HwDVXTxruSjWbRy3+tLsXFIPMY9mMGZeE9Sz9WdQPCy
         ds3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701791215; x=1702396015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5sYOH7EK86gdZlBKFuGUGGBNmbTPUNMQuZN0UpGjRs=;
        b=a+fYQA7JTKAKqE5V4wd/O0f2aNsXQJKcmbDFVJXpccVVFP6GqeprxTIvwZFBnPs7K7
         sQIQ5cRO7eFPKsuBBzc/R7Xthdiu9TlWSW6kFljP2sihxvWGwO3iuEOgn8z9i47418zQ
         2yWK6rGPzLplaupIS59Oc9N0nVSUgW5U7p718Y5xPDV1fHcD/yp5LgQmD7ZGTjddlrF5
         kNDcMZZy0VuoOY7wZWQVGrdQX7zVI7/ZkZNCx+hOTrTko8jCjZuXaetl0nZd0tnlFLxM
         buFRrGLeCe+NScyPlh//U8UmudMZjqfwgDqoEBU937zfLsr7Uogb5sjM7rVZC4QkOGEu
         OhIg==
X-Gm-Message-State: AOJu0YxQ3vF/GgC0mqxCX9xjc80Dldb5GX/gEhClWNu0NppTNAWXwIp/
	U228JLpRcLB0TmLMSaj3xZ9NTOBbAEE=
X-Google-Smtp-Source: AGHT+IETh1qqvUn3mgn66qdfQBv6d8NC2zEMSw+LGYUSXZt9CjiqxkCzMkWIr+RxbZmT4CxSZ7yDUw==
X-Received: by 2002:a05:6358:108:b0:170:17eb:1e4 with SMTP id f8-20020a056358010800b0017017eb01e4mr3666288rwa.39.1701791215600;
        Tue, 05 Dec 2023 07:46:55 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id kr3-20020a0562142b8300b0067aad395037sm3177567qvb.60.2023.12.05.07.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:46:55 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 02/10] network: pass scan_bss into network_load_psk
Date: Tue,  5 Dec 2023 07:46:39 -0800
Message-Id: <20231205154647.1778389-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205154647.1778389-1-prestwoj@gmail.com>
References: <20231205154647.1778389-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For adding SAE password identifiers the capability bits need to be
verified when loading the identifier from the profile. Pass the
BSS object in to network_load_psk rather than the 'need_passphrase'
boolean.
---
 src/network.c | 60 +++++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/src/network.c b/src/network.c
index f203834c..79f964b2 100644
--- a/src/network.c
+++ b/src/network.c
@@ -594,8 +594,34 @@ generate:
 	return -EIO;
 }
 
-static int network_load_psk(struct network *network, bool need_passphrase)
+static inline bool __bss_is_sae(const struct scan_bss *bss,
+						const struct ie_rsn_info *rsn)
 {
+	if (rsn->akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256)
+		return true;
+
+	return false;
+}
+
+static bool bss_is_sae(const struct scan_bss *bss)
+{
+	struct ie_rsn_info rsn;
+
+	memset(&rsn, 0, sizeof(rsn));
+	scan_bss_get_rsn_info(bss, &rsn);
+
+	return __bss_is_sae(bss, &rsn);
+}
+
+static int network_load_psk(struct network *network, struct scan_bss *bss)
+{
+	/*
+	 * A legacy psk file may only contain the PreSharedKey entry. For SAE
+	 * networks the raw Passphrase is required. So in this case where
+	 * the psk is found but no Passphrase, we ask the agent.  The psk file
+	 * will then be re-written to contain the raw passphrase.
+	 */
+	bool is_sae = bss_is_sae(bss);
 	const char *ssid = network_get_ssid(network);
 	enum security security = network_get_security(network);
 	size_t psk_len;
@@ -616,7 +642,7 @@ static int network_load_psk(struct network *network, bool need_passphrase)
 	}
 
 	/* PSK can be generated from the passphrase but not the other way */
-	if (!psk || need_passphrase) {
+	if (!psk || is_sae) {
 		if (!passphrase)
 			return -ENOKEY;
 
@@ -778,25 +804,6 @@ bool network_get_force_default_owe_group(struct network *network)
 	return network->force_default_owe_group;
 }
 
-static inline bool __bss_is_sae(const struct scan_bss *bss,
-						const struct ie_rsn_info *rsn)
-{
-	if (rsn->akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256)
-		return true;
-
-	return false;
-}
-
-static bool bss_is_sae(const struct scan_bss *bss)
-{
-	struct ie_rsn_info rsn;
-
-	memset(&rsn, 0, sizeof(rsn));
-	scan_bss_get_rsn_info(bss, &rsn);
-
-	return __bss_is_sae(bss, &rsn);
-}
-
 int network_can_connect_bss(struct network *network, const struct scan_bss *bss)
 {
 	struct station *station = network->station;
@@ -959,7 +966,7 @@ int network_autoconnect(struct network *network, struct scan_bss *bss)
 
 	switch (security) {
 	case SECURITY_PSK:
-		ret = network_load_psk(network, bss_is_sae(bss));
+		ret = network_load_psk(network, bss);
 		if (ret < 0)
 			goto close_settings;
 
@@ -1285,20 +1292,13 @@ static struct l_dbus_message *network_connect_psk(struct network *network,
 					struct l_dbus_message *message)
 {
 	struct station *station = network->station;
-	/*
-	 * A legacy psk file may only contain the PreSharedKey entry. For SAE
-	 * networks the raw Passphrase is required. So in this case where
-	 * the psk is found but no Passphrase, we ask the agent.  The psk file
-	 * will then be re-written to contain the raw passphrase.
-	 */
-	bool need_passphrase = bss_is_sae(bss);
 
 	if (!network_settings_load(network)) {
 		network->settings = l_settings_new();
 		network->ask_passphrase = true;
 	} else if (!network->ask_passphrase)
 		network->ask_passphrase =
-			network_load_psk(network, need_passphrase) < 0;
+			network_load_psk(network, bss) < 0;
 
 	l_debug("ask_passphrase: %s",
 		network->ask_passphrase ? "true" : "false");
-- 
2.34.1

