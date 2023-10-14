Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157DFEDB
	for <iwd@lists.linux.dev>; Sun, 15 Oct 2023 00:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dmLwgOCS"
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 83A623F63D
	for <iwd@lists.linux.dev>; Sat, 14 Oct 2023 23:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1697327693;
	bh=/9XwTWaZQ1jDbDWqn+ymw4VoAOWJabzb1X5Lqo8mlkg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=dmLwgOCS8rZJsd19MUKb0Cjwm/tOT5mT6aQoIKPpQZHQaNolAiWn1c/ORtwNDEKgh
	 91fyLuKFzzHT6Dxzdv9P4/LzmRNiKr7RrCUyhoJPoWX9Kmj3CLZQUhIa5Mo9cQ89IW
	 j0mcpamxeC5c/ChZwxWrCDFUOBqC/koZBBNo86V3qrQmyu5RmUdtfRZQVL/FfTkzOB
	 ArSsXxGOH/3fTw65IEGQkwYNC0G/Zs/otSCkpSDJhucDWiW4+cqm/KcV/in6khtQUi
	 SScSupwNTpzkkNRDYIc3zVK99B57Dg67OLPo5SLdbJrN9ocQDMJcb0j6hHr6oQlvy/
	 ZB2enEKTPLftQ==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4077d3341efso5710835e9.1
        for <iwd@lists.linux.dev>; Sat, 14 Oct 2023 16:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697327692; x=1697932492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9XwTWaZQ1jDbDWqn+ymw4VoAOWJabzb1X5Lqo8mlkg=;
        b=JOLevhO6Gcxckvpcj53RHDS8krYoIjUOfWFzVvzPktW+YbAbDe0dxuJPMupxR3qhPO
         SV9hVxQWIs297k6j5laqol8s5r46su4fGUD0XKIeCKFdrJQwW1L/JlkU995s9lBGUiE+
         9YSxaAjcL3xHYjz7Pin89p+Yq5iiRw3aoDanOAisnlFtflcyUypCUcxrdx+po9GY6Ph9
         sgr0F+x6pHz0nizFDlVHXf9h+hRN1NMlDpJKTJN1nJQxy9YauB2jJwRpTAzuppRSYLVV
         focgAY0v2hSsPvufScWVnYKRdhgGVYJo/H34o+z6DposWY9zohtsyRPcvVOMqoVlXv5o
         pmMg==
X-Gm-Message-State: AOJu0Yww1ATcFsCZCGezy9bikqSNv43r1FJiEo5vcilpisTYwlhp3BOJ
	qDYX6ICs7VXwm6kyImIDhhdAHI1PHb8fM9UxJQGrJwGcMDQ+H0vmiBoObmMs5Oeu0fvy5DYVmg2
	daShAtO6+1OsHczqGn29Ot78ISuKfNsVxb5l//Uz6
X-Received: by 2002:a1c:7c0a:0:b0:401:be5a:989 with SMTP id x10-20020a1c7c0a000000b00401be5a0989mr26900441wmc.23.1697327692215;
        Sat, 14 Oct 2023 16:54:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs1cx71yHUi+XGECqTRQkFA6ZLYMopn1I1aH8IsIndbIBsqqf1OPeK3GE570UBONMPtkAxag==
X-Received: by 2002:a1c:7c0a:0:b0:401:be5a:989 with SMTP id x10-20020a1c7c0a000000b00401be5a0989mr26900431wmc.23.1697327691690;
        Sat, 14 Oct 2023 16:54:51 -0700 (PDT)
Received: from localhost ([2a01:4b00:85fd:d700:862e:f2d4:256b:89c8])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003fee6e170f9sm3085915wmo.45.2023.10.14.16.54.51
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 16:54:51 -0700 (PDT)
From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To: iwd@lists.linux.dev
Subject: [PATCH] eap-mschapv2: allow using on kernels without CRYPTO_MD4, and deprecate
Date: Sun, 15 Oct 2023 00:54:45 +0100
Message-Id: <20231014235445.167620-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently eap-mschapv2 does kernel MD4 check during init time, even
though it is possible to use it with Password-Hash on kernels without
MD4.

Separately, mschapv2 is obsolete, deprecated, and removed even in
Windows 11 22H2 [1][2]. Add an error message stating so encouraging
migration to PEAP-TLS or EAP-TLS. Separately, warnings like these often
don't work, thus likely need to remove this authentication method
completely.

IWD usage of MD4 was brought up on linux-crypto mailing list [3], upon
my attempt to remove CRYPTO_MD4 from the kernel which is no longer used
via crypto API by anything else.

It worries me that internet searches suggest that EDUROAM (a Wi-FI
network spanning 106 territories) seems to still often use
mschapv2. Thus dropping this support may leave millions of people
without connectivity. Given how broken and isecure this authentication
method has been since 2012, I hope that EDUROAM is migrating, or has
migrated to P/EAP-TLS.

[1] https://learn.microsoft.com/en-us/security-updates/securityadvisories/2012/2743314
[2] https://learn.microsoft.com/en-us/windows/security/identity-protection/credential-guard/considerations-known-issues
[3] https://lore.kernel.org/linux-crypto/2e52c8b4-e70a-453f-853a-1962c8167dfa@gmail.com/
---
 src/eap-mschapv2.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/src/eap-mschapv2.c b/src/eap-mschapv2.c
index ef0ce620a8..4f4739717a 100644
--- a/src/eap-mschapv2.c
+++ b/src/eap-mschapv2.c
@@ -437,6 +437,8 @@ static int eap_mschapv2_check_settings(struct l_settings *settings,
 	int r = 0;
 	size_t hash_len;
 
+	l_error("EAP_MSCHAPv2: Obsolete, please switch to P/EAP-TLS");
+
 	snprintf(setting, sizeof(setting), "%sIdentity", prefix);
 	identity = l_settings_get_string(settings, "Security", setting);
 
@@ -479,8 +481,14 @@ static int eap_mschapv2_check_settings(struct l_settings *settings,
 		}
 
 		return 0;
-	} else if (password)
+	} else if (password) {
+		if (!l_checksum_is_supported(L_CHECKSUM_MD4, false)) {
+			l_warn("EAP_MSCHAPv2: Obsolete MD4 not found");
+			l_warn("Please use Password-Hash instead of Password");
+			return -EINVAL;
+		}
 		goto validate;
+	}
 
 	secret = l_queue_find(secrets, eap_secret_info_match, setting2);
 	if (!secret) {
@@ -561,13 +569,6 @@ static struct eap_method eap_mschapv2 = {
 static int eap_mschapv2_init(void)
 {
 	l_debug("");
-
-	if (!l_checksum_is_supported(L_CHECKSUM_MD4, false)) {
-		l_warn("EAP_MSCHAPv2 init: MD4 support not found, skipping");
-		l_warn("Ensure that CONFIG_CRYPTO_MD4 is enabled");
-		return -ENOTSUP;
-	}
-
 	return eap_register_method(&eap_mschapv2);
 }
 
-- 
2.34.1

