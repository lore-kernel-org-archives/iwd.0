Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D6D2FC21
	for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8aO8Eax"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-425952708afso4688071cf.0
        for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 04:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702557244; x=1703162044; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ikbPS5hzMOcGfJ18DvoHNc98uuyRJgbrRlnLNeB87k=;
        b=M8aO8Eaxg7OP2tgjWsaCJq87NlzegRtenUaTMWjORZs1DEBr65cx+6lpb+tDiB2IJn
         orslQUTW1qoDrog2WcWOsskco27+DmXOaaK1Jx/Ij1NLiQZz5nxe/pTbbgQQDe5zcg9e
         QgJF224DJp/CBUuQ3boITJQRB8OJWrl6MnVJwj+TKL63oLX9IHN2366ZZWq8pFTuL84V
         kBl5Wh20sq1M9YisStXEhoym5PbXUn+Mr4G3/LSdmHY7sCeRX3MLPivDXk/fb9GMuVNI
         N03tpyR9biuVZqgauzujG+RhhwBtsun5XXXh/Vbzmj4Ypl+zKEbzaksFJyPqY9JO/Jbz
         YTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702557244; x=1703162044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ikbPS5hzMOcGfJ18DvoHNc98uuyRJgbrRlnLNeB87k=;
        b=V05naVOPZzqVsXhaQ9GWIGmuUeAtLEPpjPxQlG0qI+rHqnzyeLfwmwdhoeTPKhLWn7
         qBWMFQj2LbViH4kc7wcsDMedtq1lUR9nVodNWpv/I/KcmcLhHlFXuSoUY6SXiicmFJoz
         Nj6Ox/I68oWRyRyLkFHySu3PxbM7Olp7BSFwpLOQzjz4hL05mTG6Uanyp3Ql3VfW5cv8
         o7F2r0QLAKDItpvOtQCmpc5bSNyyFfRVSNQlthvFyTZVygJeSsDVXNRrVH02FYYK1SYT
         d/A9QDmfngfA1kGvFSjilIZ+bhc2aOIgXYot+IFkXc1+sjY8wNdhb1kHkZpDoy8jRZmJ
         uLIw==
X-Gm-Message-State: AOJu0YywTjx3KmYehWG+QdZwSWqvJnUGaMCNK5ED84u/hhOUQRIFMyJg
	3IHLS62Fqn9w52ESA5erV4h/Y413weI=
X-Google-Smtp-Source: AGHT+IHc9Xb08psFu3Z0OomJiL0VbKHRwNQPqH156ZEF1cJlMe1Yu/JaDSHw8FX4GJj0j0Ihp3TirA==
X-Received: by 2002:ac8:5956:0:b0:425:9668:3b5f with SMTP id 22-20020ac85956000000b0042596683b5fmr17927823qtz.46.1702557243704;
        Thu, 14 Dec 2023 04:34:03 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id x3-20020ac87303000000b0042551dce749sm5745883qto.46.2023.12.14.04.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:34:03 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 1/4] network: add support for SAE password identifiers
Date: Thu, 14 Dec 2023 04:33:57 -0800
Message-Id: <20231214123400.12924-1-prestwoj@gmail.com>
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

Building the handshake will fail if:
 - there is no password identifier set and the BSS sets the
   "exclusive" bit.
 - there is a password identifier set and the BSS does not set
   the "in-use" bit.
---
 src/network.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

v4:
 * Moved the checks out of network_load_psk and into the
   handshake setup function. This is more consistent to where
   other BSS-specific checks are made.

diff --git a/src/network.c b/src/network.c
index 79f964b2..b6723fa9 100644
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
@@ -495,6 +508,19 @@ int network_handshake_setup(struct network *network, struct scan_bss *bss,
 
 	switch (network->security) {
 	case SECURITY_PSK:
+		/* Check the BSS password ID settings match our configuration */
+		if (bss->sae_pw_id_exclusive && !network->password_identifier) {
+			l_error("[Security].PasswordIdentifier is not set but "
+				"BSS requires SAE password identifiers");
+			return -ENOKEY;
+		}
+
+		if (!bss->sae_pw_id_used && network->password_identifier) {
+			l_error("[Security].PasswordIdentifier set but BSS "
+				"does not not use password identifiers");
+			return -ENOKEY;
+		}
+
 		r = network_set_handshake_secrets_psk(network, hs);
 		if (r < 0)
 			return r;
@@ -631,6 +657,9 @@ static int network_load_psk(struct network *network, struct scan_bss *bss)
 	_auto_(l_free) char *passphrase =
 			l_settings_get_string(network->settings,
 						"Security", "Passphrase");
+	_auto_(l_free) char *password_id =
+			l_settings_get_string(network->settings, "Security",
+						"PasswordIdentifier");
 	_auto_(l_free) char *path =
 		storage_get_network_file_path(security, ssid);
 
@@ -655,6 +684,7 @@ static int network_load_psk(struct network *network, struct scan_bss *bss)
 	network_reset_passphrase(network);
 	network_reset_psk(network);
 	network->passphrase = l_steal_ptr(passphrase);
+	network->password_identifier = l_steal_ptr(password_id);
 
 	if (network_settings_load_pt_ecc(network, path,
 						19, &network->sae_pt_19) > 0)
@@ -726,6 +756,11 @@ static void network_settings_save(struct network *network,
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

