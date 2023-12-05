Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CABA5F1F0
	for <iwd@lists.linux.dev>; Tue,  5 Dec 2023 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMFopRjp"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6d87cf8a297so1355446a34.2
        for <iwd@lists.linux.dev>; Tue, 05 Dec 2023 07:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701791218; x=1702396018; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJbWLOHkbdv7ZMeI6+OALlG00aL8CflGvOvaNaRwjT8=;
        b=RMFopRjpD8dKOdG97I2tOG0raxQX12qRXC9aMdvlu/AN048c0/rRr/Nc7fDD4MSi1E
         d1wVyrFKYpVhMCcObFPQLaoVBqivhqCFzJWV4Ho4FWfxD9OAnpt8vejW6hY8xQHz9oqK
         zyRPLe4LtZWuv+Tz+gZiaLMebsfLJLx0yI/5OCa9tjKdw47zRPXphhMHcjETv9CNfSWI
         I2jU0mnV6qqZdGcFCxIJeng3YTBZEUBgmhhKPhJ9I1lQuzz7rixwAK3K50yfuBEW7fG1
         XcjGgbNl4CF0fcbtxb0Ek87Oc82Tv5hulLFe4hdkGRGA2gAxu4UHMtYPIpygyA+bFSgf
         qCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701791218; x=1702396018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJbWLOHkbdv7ZMeI6+OALlG00aL8CflGvOvaNaRwjT8=;
        b=Wwev5nD9MZIx/v5faMOLpPVvza73QUtZ5648kQWHCL2f116IzVNaxD2C4AqWM3tXvB
         rtRXD6tYqDMpBf0ygak7c2gWmPtMmFLEiC7HZtdzYbvgziAwXlb/2iyEDfgSzFVxs3T1
         7gzYVmygauu6Nd9dm6Y81oVYnyoim34rBtEHOPltD0XRELu0cRt7p3vtn+fhIvO7Fpqv
         XxXfZcKH8c6AEdWBZjU8ya6OpK/aPuLrT29+y2290+8qKWQSzKzM1WRpPqH2n11653ZZ
         2bQkY7QbglcIHQg31fIfRmIe6ze0CxFH+l44/SKKpwEs4Pvii/zJWS1u/bNFU0ianwbb
         thNg==
X-Gm-Message-State: AOJu0YwYwL63HZcXsK7IFEOEfRLRA7QJFkZ7NqMe3Ui7DK5Nlp7cRAfC
	HVmoEwJj8pXu2DWgaNyalctGzd3f9i0=
X-Google-Smtp-Source: AGHT+IG62mNnv1cycUfsjUFadvZMxZRYHkK/2a5jh0PpF11wC17ZOz03GxVamQsqE5GeLGsWWy1WGg==
X-Received: by 2002:a05:6870:4708:b0:1fa:2d2c:9728 with SMTP id b8-20020a056870470800b001fa2d2c9728mr3833775oaq.34.1701791217940;
        Tue, 05 Dec 2023 07:46:57 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id kr3-20020a0562142b8300b0067aad395037sm3177567qvb.60.2023.12.05.07.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:46:57 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 04/10] network: add support for SAE password identifiers
Date: Tue,  5 Dec 2023 07:46:41 -0800
Message-Id: <20231205154647.1778389-4-prestwoj@gmail.com>
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

Adds a new network profile setting [Security].PasswordIdentifier.
When set (and the BSS enables SAE password identifiers) the network
and handshake object will read this and use it for the SAE
exchange.

Loading the PSK will fail if there is no password identifier set
and the BSS sets the "exclusive" bit. If a password identifier is
set and the BSS doesn't indicate support the setting will be ignored
(with a debug print).
---
 src/network.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/src/network.c b/src/network.c
index 79f964b2..d422b282 100644
--- a/src/network.c
+++ b/src/network.c
@@ -70,6 +70,7 @@ struct network {
 	struct network_info *info;
 	unsigned char *psk;
 	char *passphrase;
+	char *password_identifier;
 	struct l_ecc_point *sae_pt_19; /* SAE PT for Group 19 */
 	struct l_ecc_point *sae_pt_20; /* SAE PT for Group 20 */
 	unsigned int agent_request;
@@ -124,6 +125,13 @@ static void network_reset_passphrase(struct network *network)
 		network->passphrase = NULL;
 	}
 
+	if (network->password_identifier) {
+		explicit_bzero(network->password_identifier,
+				strlen(network->password_identifier));
+		l_free(network->password_identifier);
+		network->password_identifier = NULL;
+	}
+
 	if (network->sae_pt_19) {
 		l_ecc_point_free(network->sae_pt_19);
 		network->sae_pt_19 = NULL;
@@ -317,7 +325,8 @@ static struct l_ecc_point *network_generate_sae_pt(struct network *network,
 	l_debug("Generating PT for Group %u", group);
 
 	pt = crypto_derive_sae_pt_ecc(group, network->ssid,
-						network->passphrase, NULL);
+						network->passphrase,
+						network->password_identifier);
 	if (!pt)
 		l_warn("SAE PT generation for Group %u failed", group);
 
@@ -462,6 +471,10 @@ static int network_set_handshake_secrets_psk(struct network *network,
 
 		handshake_state_set_passphrase(hs, network->passphrase);
 
+		if (network->password_identifier)
+			handshake_state_set_password_identifier(hs,
+						network->password_identifier);
+
 		if (ie_rsnxe_capable(hs->authenticator_rsnxe,
 							IE_RSNX_SAE_H2E)) {
 			l_debug("Authenticator is SAE H2E capable");
@@ -631,6 +644,9 @@ static int network_load_psk(struct network *network, struct scan_bss *bss)
 	_auto_(l_free) char *passphrase =
 			l_settings_get_string(network->settings,
 						"Security", "Passphrase");
+	_auto_(l_free) char *password_id =
+			l_settings_get_string(network->settings, "Security",
+						"PasswordIdentifier");
 	_auto_(l_free) char *path =
 		storage_get_network_file_path(security, ssid);
 
@@ -641,6 +657,32 @@ static int network_load_psk(struct network *network, struct scan_bss *bss)
 		psk_len = 0;
 	}
 
+	/*
+	 * Sort out if the password identifier is required, should be used, "
+	 * or should be ignored.
+	 */
+	if (is_sae) {
+		if (bss->sae_pw_id_exclusive && !password_id) {
+			l_error("BSS requires SAE password identifiers, check "
+				"[Security].PasswordIdentifier");
+			return -ENOKEY;
+		}
+
+		/*
+		 * If the profile contains a password identifier but the network
+		 * does not support it IWD will still attempt to connect. The
+		 * caveat here is if the connection is successful the sync will
+		 * remove the password identifier entry. Though this might be
+		 * unexpected to the user, retaining this (invalid) setting
+		 * isn't worth special casing.
+		 */
+		if (!bss->sae_pw_id_used && password_id) {
+			l_debug("[Security].PasswordIdentifier set but BSS "
+				"does not not use password identifiers");
+			l_free(l_steal_ptr(password_id));
+		}
+	}
+
 	/* PSK can be generated from the passphrase but not the other way */
 	if (!psk || is_sae) {
 		if (!passphrase)
@@ -655,6 +697,7 @@ static int network_load_psk(struct network *network, struct scan_bss *bss)
 	network_reset_passphrase(network);
 	network_reset_psk(network);
 	network->passphrase = l_steal_ptr(passphrase);
+	network->password_identifier = l_steal_ptr(password_id);
 
 	if (network_settings_load_pt_ecc(network, path,
 						19, &network->sae_pt_19) > 0)
@@ -726,6 +769,11 @@ static void network_settings_save(struct network *network,
 		l_settings_set_string(settings, "Security", "Passphrase",
 					network->passphrase);
 
+	if (network->password_identifier)
+		l_settings_set_string(settings, "Security",
+					"PasswordIdentifier",
+					network->password_identifier);
+
 	if (network->sae_pt_19)
 		network_settings_save_sae_pt_ecc(settings, network->sae_pt_19);
 
-- 
2.34.1

