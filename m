Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487413D0D4
	for <iwd@lists.linux.dev>; Thu,  7 Dec 2023 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM/EhwLK"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-67adac40221so6081106d6.2
        for <iwd@lists.linux.dev>; Thu, 07 Dec 2023 05:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701956908; x=1702561708; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3GWSRK6t4Zwb1f5hIoO2a4ez1XYNJe9ar6hpMqUBI4=;
        b=VM/EhwLKYrXG1ATeWsfP4LO4TtKrVf+CI/oogwGXg4ISC8zkXw2p88EbS4sPJ29DCm
         GERVoDGsGNRBaNqhTwKvZFnx2MFGnqtwZRZH4FxQB01BjBtJ+vb+HkPpYzbE0KTMejUU
         4UcpKZ2x07kPQzdMjk1d+2pBfMcGrXmeihPhnp3ADJYJCcZqWVkFU63gFriGCbAs1IHk
         IeEk5BCBpc2KzN7hSxPoT89ZcrsobRkLMEaST3tcf0Xy6bw10/XZ95U/SVdfp65YjnAZ
         pdMOvqSCasqgRRADVi9RITV+hXD43kc+ek1+XhGoM4+8/GY9+Wrtgo4Y4F7g++o0G0B7
         05aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701956908; x=1702561708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3GWSRK6t4Zwb1f5hIoO2a4ez1XYNJe9ar6hpMqUBI4=;
        b=YI83aef9ShUjirdZsACpChe8btqAqqg+Jp5DhgnbILIwCHlCSlotcOc6/wg9nWAAjg
         zYi+qsFo1jvTSXzbQ4YyeUIoYgbpwHg3nha56mBuPPiA4J4Kdjp+WjBr3ZSqHRBeasK3
         qv5iF4hIPubnWkP+ML8/MS84JFYNuVVh1bVF8ekogBY9dnuy89Zh2+/Flp8rd6/U0Uve
         TyrWli2DozjDU8a91Pmvu1pro5G7lf5yB0mj0o9V2/R0mqwx2muEH7cqZc0JIbyYzE3H
         Esyb5UYMTluHgDR2jbhfbmFbPaU4k57BBcve0XYZdqrljsnkOjuI1vTbOTV/fUg6+4Ko
         wgUA==
X-Gm-Message-State: AOJu0Yz+4O/wac45e6KJTD8ZV9uP/Nj+EyAWqneJD+G+FspzdiDwMJb0
	NJEfaJvXtBykvu/zOExiIvM402zGDOw=
X-Google-Smtp-Source: AGHT+IFkXEgyDpFVOyzmh5EnzrajhvH7I+UDU4QR4Q839DbBjG5w7LBfRsESYsjrRKi+Se0hIzylHA==
X-Received: by 2002:ad4:4e06:0:b0:67a:e40d:316d with SMTP id dl6-20020ad44e06000000b0067ae40d316dmr2794688qvb.101.1701956908611;
        Thu, 07 Dec 2023 05:48:28 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id w18-20020a0cef92000000b0067a27108513sm496494qvr.67.2023.12.07.05.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:48:28 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] network: add support for SAE password identifiers
Date: Thu,  7 Dec 2023 05:48:19 -0800
Message-Id: <20231207134822.2458827-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
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
 src/network.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/src/network.c b/src/network.c
index 79f964b2..70a5434b 100644
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
 
@@ -641,6 +657,31 @@ static int network_load_psk(struct network *network, struct scan_bss *bss)
 		psk_len = 0;
 	}
 
+	if (is_sae) {
+		/*
+		 * Fail if:
+		 *   - the BSS exclusively uses password IDs and the profile
+		 *     does not have one set.
+		 *   - the BSS does not use password IDs and the profile has
+		 *     one set.
+		 *
+		 * In theory you could have a network with a mix of BSS's that
+		 * use IDs and those that don't, but this is a strange
+		 * configuration (arguably broken).
+		 */
+		if (bss->sae_pw_id_exclusive && !password_id) {
+			l_error("[Security].PasswordIdentifier is not set but "
+				"BSS requires SAE password identifiers");
+			return -ENOKEY;
+		}
+
+		if (!bss->sae_pw_id_used && password_id) {
+			l_debug("[Security].PasswordIdentifier set but BSS "
+				"does not not use password identifiers");
+			return -ENOKEY;
+		}
+	}
+
 	/* PSK can be generated from the passphrase but not the other way */
 	if (!psk || is_sae) {
 		if (!passphrase)
@@ -655,6 +696,7 @@ static int network_load_psk(struct network *network, struct scan_bss *bss)
 	network_reset_passphrase(network);
 	network_reset_psk(network);
 	network->passphrase = l_steal_ptr(passphrase);
+	network->password_identifier = l_steal_ptr(password_id);
 
 	if (network_settings_load_pt_ecc(network, path,
 						19, &network->sae_pt_19) > 0)
@@ -726,6 +768,11 @@ static void network_settings_save(struct network *network,
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

