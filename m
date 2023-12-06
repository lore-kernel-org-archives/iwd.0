Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C006048CFA
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TU2n8Jyt"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ce6b62746dso215009b3a.2
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 12:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701893891; x=1702498691; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DzlhUMXwricrd/pzBGQ6SKtzknJFadlM6DGba9y6jE=;
        b=TU2n8JytPDFoOHZJpD+BoHEQkUDcbWFULcg3QSdckwL/mwJmHGWy6DdC2RYjFuORzo
         68YYf6QFFFfo34W1Sjtuzca0awUzNMJFNoCwUEqp560GlNeSe7H+jwOJ19wNzx6j4Low
         LkmtZEK4PrXh49fibYxCOjQgbGohBchzavQbvt5nalsyyzcMIkOWvBl2198IJUjyUjIx
         NLyEaSegEkzdQM5gLI4VLzC0p4Q+KR3fUYAO0NGwcug3EJjURMWZJxpavbcw68HLxM4c
         6Z/I5yDF0hvhMr4t33S5THUxFDfe4t8cDuYt8sPljG7JVFSDIjDEG3KMinF++w7LaBWH
         84wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893891; x=1702498691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DzlhUMXwricrd/pzBGQ6SKtzknJFadlM6DGba9y6jE=;
        b=dO3z1HJmG4fUwIEUCJqmAHDEo4KqZ1FpbHAN+oofsPOs3K7U4p+Pgg1GbROIcR7UML
         apb3dBUiPdCE5N1roAO7fxHUNcO1vnVkymzLWCNoIjlmRTGYJePk7mwmrAVGXGikoFz9
         IpA5iAmvnFKVj48MesE+oa7vz5CivvsqYBIN8rAoP1/WmA2sZDh51zOWr1D/uDtXRMoZ
         jAtuNh3ABDUlFg98toeZfOsXIEGtGMaC5JG26KuKbA2DDgGWQqr9ootJeg1JOc/rR9vA
         dtylNRd7o2dU6uIPcD0011PZLVOBXzO+wLyZRmKX4zL1X+EqKoHoke1ECgeKWuqLiJti
         sB+w==
X-Gm-Message-State: AOJu0YxTeFu970b2eu9XOrT9+IA0rrnxbiXmSa+h+PTOpmHs53tCWvB0
	mPfJJ1Rdpx9iU02pieTClXTMrnX0Nsiu8Q==
X-Google-Smtp-Source: AGHT+IG2ZxD3lu4IMNExsU1JnY+30fvn0oLbWuSs8xU/DMgI/Q1HnOURKByggHisMb6Kv5CJiFruyQ==
X-Received: by 2002:a05:6a00:f90:b0:6ce:38d4:273e with SMTP id ct16-20020a056a000f9000b006ce38d4273emr1298304pfb.58.1701893890863;
        Wed, 06 Dec 2023 12:18:10 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id by40-20020a056a0205a800b005c2185be2basm243168pgb.54.2023.12.06.12.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:18:10 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 07/13] handshake: remove handshake_state_set_fte
Date: Wed,  6 Dec 2023 12:17:56 -0800
Message-Id: <20231206201802.2139649-7-prestwoj@gmail.com>
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

Replaced by set_authenticator_fte
---
 src/handshake.c | 6 ------
 src/handshake.h | 2 --
 2 files changed, 8 deletions(-)

diff --git a/src/handshake.c b/src/handshake.c
index ad8533f4..8fab4498 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -122,7 +122,6 @@ void handshake_state_free(struct handshake_state *s)
 	l_free(s->authenticator_rsnxe);
 	l_free(s->supplicant_rsnxe);
 	l_free(s->mde);
-	l_free(s->fte);
 	l_free(s->authenticator_fte);
 	l_free(s->supplicant_fte);
 	l_free(s->fils_ip_req_ie);
@@ -310,11 +309,6 @@ void handshake_state_set_mde(struct handshake_state *s, const uint8_t *mde)
 	replace_ie(&s->mde, mde);
 }
 
-void handshake_state_set_fte(struct handshake_state *s, const uint8_t *fte)
-{
-	replace_ie(&s->fte, fte);
-}
-
 void handshake_state_set_authenticator_fte(struct handshake_state *s,
 						const uint8_t *fte)
 {
diff --git a/src/handshake.h b/src/handshake.h
index e6344048..562e44ce 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -103,7 +103,6 @@ struct handshake_state {
 	uint8_t *authenticator_rsnxe;
 	uint8_t *supplicant_rsnxe;
 	uint8_t *mde;
-	uint8_t *fte;
 	uint8_t *authenticator_fte;
 	uint8_t *supplicant_fte;
 	uint8_t *vendor_ies;
@@ -216,7 +215,6 @@ void handshake_state_set_ssid(struct handshake_state *s,
 					const uint8_t *ssid, size_t ssid_len);
 void handshake_state_set_mde(struct handshake_state *s,
 					const uint8_t *mde);
-void handshake_state_set_fte(struct handshake_state *s, const uint8_t *fte);
 void handshake_state_set_authenticator_fte(struct handshake_state *s,
 						const uint8_t *fte);
 void handshake_state_set_supplicant_fte(struct handshake_state *s,
-- 
2.34.1

