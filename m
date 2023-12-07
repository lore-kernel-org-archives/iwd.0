Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321503DB99
	for <iwd@lists.linux.dev>; Thu,  7 Dec 2023 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMJQnEQ9"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-77f408d123bso19883785a.0
        for <iwd@lists.linux.dev>; Thu, 07 Dec 2023 06:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701957653; x=1702562453; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dgoD/V9gLxLUEDqt89OTfPLqaSugrC/C2RFfB3sN3bc=;
        b=OMJQnEQ9JIDgK9Yq8hQM0P0ChZqFU51q9hAeT0YbDYkSJZVZAIpuonsjl8X3qMOo79
         rNEowUc2QQAhYmOxty18IEql9fljX7xOOz5XUH+mwNG10fKBKySSmaBHK73eOze15d5k
         S8O/3ycfIBDtszD/eUfNNYRFfzAU9VTHzrW5RJ7LEZWly2C7P4wccATVFkkv5jIcTQiE
         +etmrfqfYbEd969ypbIX4xor5RO5YPtyi35Uy0Ef+ClftbD5ZYPrdWqRROClN0PJuv/0
         XE549re6m0Afo56Ukk3ahSxN19XocilOar5DM7U5WlfzMFnxLTv63Soqqs0zaUHca/vp
         uqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957653; x=1702562453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgoD/V9gLxLUEDqt89OTfPLqaSugrC/C2RFfB3sN3bc=;
        b=g48wuZbkWX2esByjIAIAgN7Op/pRHg/8pot+ejltzAZBSndjeBUradlzm2HhsaS3hW
         r/+MzHRIDm8FzZU/YpddhMK9b8eOQVH1iEDxqoF0fHZZ1aMr/xtfhRcaoks/3hdeZXIK
         scbe89+kxgkK/7dpM/EN3nHYLBbXL9eaalLg41GAKr9xQ2jeCbzC/bP+IBOjzhwagaic
         U1nNRCxhEW5j5ikITFq4yp1X8JxHIuhR5BuPmIS/iMSaWxQEnT/P+0UVN9nlI++q36iE
         gUSUOyMlquRVtr2AVSbraz1pFlXpRcdHmWO12oM5ltxOLwFiDhkdFscVBfpdeXT1ocVQ
         CX7g==
X-Gm-Message-State: AOJu0YwCTadzaZZW5FmmY3s3AHnH471wz2tzXMSFpqQ+AGGoQmoJlb8K
	uaV+TxWbNv60guWKscZev3VzHSsPcuc=
X-Google-Smtp-Source: AGHT+IHWzVu6DaKAhfN4ofopIWHyAc3hmrCMeKYHrkYBlc8mDNKMRcJXL+VpV5XozISHRp4/e3x1bw==
X-Received: by 2002:a05:620a:5589:b0:77d:7630:2073 with SMTP id vq9-20020a05620a558900b0077d76302073mr904226qkn.73.1701957652685;
        Thu, 07 Dec 2023 06:00:52 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id px24-20020a05620a871800b0077dc1476413sm407699qkn.131.2023.12.07.06.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:00:52 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/4] network: add support for SAE password identifiers
Date: Thu,  7 Dec 2023 06:00:46 -0800
Message-Id: <20231207140049.2614514-1-prestwoj@gmail.com>
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

Loading the PSK will fail if:
 - there is no password identifier set and the BSS sets the
   "exclusive" bit.
 - there is a password identifier set and the BSS does not set
   the "in-use" bit.
---
 src/network.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

v3:
 * fix outdated commit description

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

