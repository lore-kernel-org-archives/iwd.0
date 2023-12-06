Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A83B6EB72
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNNSxxhi"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ce94f62806so192523b3a.1
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 12:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701893889; x=1702498689; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAY4bt0O+virkaMM/crr7PzAI4YN/UAAgk6iGrGxQ+4=;
        b=eNNSxxhie5cxzcbPy6iwgOIsNR4zO1QE/v4bxbUhDBGfKICP6ZxIOlqTb2CRobxnAf
         Yb0yqVDXDfO8z9SoIWCDx5E23vPXxpDQE8OFDhvAxVgguGFiWzgBslpCj8kiUxVlcJmB
         8iylr+ra4KYFnoieUtIpSpVWjG8rUtg+g5ggG2o8PmHG/W1uHQp13dZIW9p42MD7xoXh
         lUNMd+JujP261WceMR1vU02mUNFJRoGY5Lcd0+8SWhN5645IDSigt8dIFqxNF6nfb+Ak
         S2WZM0TtCBE/5nd4y+3R6UKNMjOCJ157ULsh96tkzG4ILy5PFl4lousOUe/VLvyl4Lj6
         r+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893889; x=1702498689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAY4bt0O+virkaMM/crr7PzAI4YN/UAAgk6iGrGxQ+4=;
        b=Y22gVfKbp7M2wN3EybBuUwHValx5krVAsW1jAxiJktdexJeR1nPv7JMFBs3d8HKXLD
         6YN82xq4BZdaXO1jIn1xIib00Jukv4kgL3KtlTr1qLQjuWINoL8CjsqDromUQS3rejnU
         awwURdhP98I0yys43FzJi+1bnzTXnhesfOK06yh9cAmJTgf7Te4PfKpcR6I2t3iFGFss
         J8bIc4y2Onrpe+1vM5iqH1WiwovVZvy7qTqT8Eld4Fcn7FesDReC9LRFa84E+eTg+hUi
         9a7LlhHrb7HEu42mmFGr3FVVabHbp2F2Z5IxwRtSxsCOU+tWF/5HuE2lUOBsBY+Jf2zd
         hPpA==
X-Gm-Message-State: AOJu0YzHswCN6mM88EAYQC48FS9L/IMUmJ7Bzlytq8EaDGkRPbXQq29E
	zHNFWRMlaeXc6WH4BP1UskCIsBPYCUyosA==
X-Google-Smtp-Source: AGHT+IHKtLBb+4rjuubyIkSN9WjdFKOwexf6sHpu0eiiSbJj79drnZw5/zRw5Ayker52psUSkUJsNw==
X-Received: by 2002:a05:6a20:7d8d:b0:18f:f637:99d1 with SMTP id v13-20020a056a207d8d00b0018ff63799d1mr445126pzj.57.1701893889076;
        Wed, 06 Dec 2023 12:18:09 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id by40-20020a056a0205a800b005c2185be2basm243168pgb.54.2023.12.06.12.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:18:08 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 04/13] handshake: add setters for authenticator/supplicant_fte
Date: Wed,  6 Dec 2023 12:17:53 -0800
Message-Id: <20231206201802.2139649-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206201802.2139649-1-prestwoj@gmail.com>
References: <20231206201802.2139649-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In general only the authenticator FTE is used/validated but with
some FT refactoring coming there needs to be a way to build the
supplicants FTE into the handshake object. Because of this there
needs to be separate FTE buffers for both the authenticator and
supplicant.
---
 src/handshake.c | 14 ++++++++++++++
 src/handshake.h |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/src/handshake.c b/src/handshake.c
index 1c5ed2c9..f35da9b1 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -123,6 +123,8 @@ void handshake_state_free(struct handshake_state *s)
 	l_free(s->supplicant_rsnxe);
 	l_free(s->mde);
 	l_free(s->fte);
+	l_free(s->authenticator_fte);
+	l_free(s->supplicant_fte);
 	l_free(s->fils_ip_req_ie);
 	l_free(s->fils_ip_resp_ie);
 	l_free(s->vendor_ies);
@@ -313,6 +315,18 @@ void handshake_state_set_fte(struct handshake_state *s, const uint8_t *fte)
 	replace_ie(&s->fte, fte);
 }
 
+void handshake_state_set_authenticator_fte(struct handshake_state *s,
+						const uint8_t *fte)
+{
+	replace_ie(&s->authenticator_fte, fte);
+}
+
+void handshake_state_set_supplicant_fte(struct handshake_state *s,
+						const uint8_t *fte)
+{
+	replace_ie(&s->supplicant_fte, fte);
+}
+
 void handshake_state_set_vendor_ies(struct handshake_state *s,
 					const struct iovec *iov,
 					size_t n_iovs)
diff --git a/src/handshake.h b/src/handshake.h
index 815eb44f..e6344048 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -104,6 +104,8 @@ struct handshake_state {
 	uint8_t *supplicant_rsnxe;
 	uint8_t *mde;
 	uint8_t *fte;
+	uint8_t *authenticator_fte;
+	uint8_t *supplicant_fte;
 	uint8_t *vendor_ies;
 	size_t vendor_ies_len;
 	enum ie_rsn_cipher_suite pairwise_cipher;
@@ -215,6 +217,11 @@ void handshake_state_set_ssid(struct handshake_state *s,
 void handshake_state_set_mde(struct handshake_state *s,
 					const uint8_t *mde);
 void handshake_state_set_fte(struct handshake_state *s, const uint8_t *fte);
+void handshake_state_set_authenticator_fte(struct handshake_state *s,
+						const uint8_t *fte);
+void handshake_state_set_supplicant_fte(struct handshake_state *s,
+						const uint8_t *fte);
+
 void handshake_state_set_vendor_ies(struct handshake_state *s,
 					const struct iovec *iov,
 					size_t n_iovs);
-- 
2.34.1

