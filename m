Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4413C6B0
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgIdT4Ul"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1c9b95943beso12148535ad.1
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140924; x=1697745724; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rvPDOc+1rLHUCoKJx1s6sX8mdBD7w+IcaesF6MY8tY=;
        b=UgIdT4UlRYgao8tuaUY0Tm8bB7G2IOCkZ83p5ahPemtztYORTM+Ukk/6XLgUiOqecZ
         eqfg4rX9z0CJLl42xRMGs/pPvxyDLXnX0F9vv89V5sX6EsQ6Ig6PdS0hb7dNjV66CAc3
         ERrGCsY9oQdRXpOyOr1zH0+xpGGnf9wiQmzO0bbI+AobfyCgAO4E8/kc7W5Vva/1zZoC
         2G60aZnL22l+3UX/yQAwYZ0Du+ICbYEHhtJde+Ttrnt/MYXX1ianus2MkQltXtsAaFcq
         Kdhu0661N9QmQIf5Ur2EU9mXgOgNeaVJIXh3Xn4CA6UcH/Pc7ubhhf3ln5lshdalOeYm
         FLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140924; x=1697745724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rvPDOc+1rLHUCoKJx1s6sX8mdBD7w+IcaesF6MY8tY=;
        b=OCrW1MBwu9DpDpAEDP+qmWejgBloU5PcGyPS/BHNXEWAydsB7kzHx/QXR6nEEBJjCJ
         1LjDZa59T0RsqX4ys9dmAcrYRO+S8QSjV57MvsgSuGvPAuP4UZCc6uyVN7HSnEYdzecq
         zQnvdzArt52r1u2XmmsbVdGqTMGcUltntVqRoHfMZ8Z1gllCXqXiiRYoBP6uHcnKP1mW
         bI8P/zyMgiLBBfDnPdIJVSPcpdpCZV+T5dJ7O1XJ37u4yJVXXZzuCnBuJ5hw/99d7Rn4
         Tdyr3NYFPgp974BRwZqlrRu0gCDP/YbTfaC35/rnelo6v5b78M1x9aFqsubbM/Ag8hKh
         beLg==
X-Gm-Message-State: AOJu0YwUTVeKIQ9KPYX8R2TngtWlZ0VycInIrTSosmxAl8w9tc74/BoQ
	liNnC+1B2qy59R6DOiSowFW58As6qAo=
X-Google-Smtp-Source: AGHT+IHhlnIJ52+s4zXZOPKwaxNrjCo8LDR6JtBHBf7KWn3MpRqMYoP6e80gDF+57pBUX7ykvxPvhw==
X-Received: by 2002:a17:902:ea0a:b0:1bb:598a:14e5 with SMTP id s10-20020a170902ea0a00b001bb598a14e5mr32702166plg.43.1697140923608;
        Thu, 12 Oct 2023 13:02:03 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 08/21] dpp-util: allow mutual auth in dpp_derive_ke
Date: Thu, 12 Oct 2023 13:01:37 -0700
Message-Id: <20231012200150.338401-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012200150.338401-1-prestwoj@gmail.com>
References: <20231012200150.338401-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Ke derivation requires an additional "L.x" value when
mutual authentication is used.
---
 src/dpp-util.c | 10 +++++++---
 src/dpp-util.h |  2 +-
 src/dpp.c      |  4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index d3171d02..0406a4dc 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -681,12 +681,13 @@ free_n:
 
 bool dpp_derive_ke(const uint8_t *i_nonce, const uint8_t *r_nonce,
 				struct l_ecc_scalar *m, struct l_ecc_scalar *n,
-				void *ke)
+				struct l_ecc_point *l, void *ke)
 {
 	uint8_t nonces[32 + 32];
 	size_t nonce_len;
 	uint64_t mx_bytes[L_ECC_MAX_DIGITS];
 	uint64_t nx_bytes[L_ECC_MAX_DIGITS];
+	uint64_t lx_bytes[L_ECC_MAX_DIGITS];
 	uint64_t bk[L_ECC_MAX_DIGITS];
 	ssize_t key_len;
 	enum l_checksum_type sha;
@@ -697,12 +698,15 @@ bool dpp_derive_ke(const uint8_t *i_nonce, const uint8_t *r_nonce,
 	nonce_len = dpp_nonce_len_from_key_len(key_len);
 	sha = dpp_sha_from_key_len(key_len);
 
+	if (l)
+		l_ecc_point_get_x(l, lx_bytes, key_len * 2);
+
 	memcpy(nonces, i_nonce, nonce_len);
 	memcpy(nonces + nonce_len, r_nonce, nonce_len);
 
 	/* bk = HKDF-Extract(I-nonce | R-nonce, M.x | N.x [ | L.x]) */
-	if (!hkdf_extract(sha, nonces, nonce_len * 2, 2, bk, mx_bytes,
-			key_len, nx_bytes, key_len))
+	if (!hkdf_extract(sha, nonces, nonce_len * 2, 3, bk, mx_bytes,
+			key_len, nx_bytes, key_len, lx_bytes, l ? key_len : 0))
 		return false;
 
 	/* ke = HKDF-Expand(bk, "DPP Key", length) */
diff --git a/src/dpp-util.h b/src/dpp-util.h
index 050d66cc..96711c35 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -176,7 +176,7 @@ struct l_ecc_scalar *dpp_derive_k2(const struct l_ecc_point *i_proto_public,
 				void *k2);
 bool dpp_derive_ke(const uint8_t *i_nonce, const uint8_t *r_nonce,
 				struct l_ecc_scalar *m, struct l_ecc_scalar *n,
-				void *ke);
+				struct l_ecc_point *l, void *ke);
 
 uint8_t *dpp_point_to_asn1(const struct l_ecc_point *p, size_t *len_out);
 struct l_ecc_point *dpp_point_from_asn1(const uint8_t *asn1, size_t len);
diff --git a/src/dpp.c b/src/dpp.c
index bbb27ff1..fc3d5c4f 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1807,7 +1807,7 @@ static void authenticate_request(struct dpp_sm *dpp, const uint8_t *from,
 
 	l_getrandom(dpp->r_nonce, dpp->nonce_len);
 
-	if (!dpp_derive_ke(dpp->i_nonce, dpp->r_nonce, m, n, dpp->ke))
+	if (!dpp_derive_ke(dpp->i_nonce, dpp->r_nonce, m, n, NULL, dpp->ke))
 		goto auth_request_failed;
 
 	if (!dpp_derive_r_auth(dpp->i_nonce, dpp->r_nonce, dpp->nonce_len,
@@ -1983,7 +1983,7 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 		return;
 	}
 
-	if (!dpp_derive_ke(i_nonce, r_nonce, dpp->m, n, dpp->ke)) {
+	if (!dpp_derive_ke(i_nonce, r_nonce, dpp->m, n, NULL, dpp->ke)) {
 		l_debug("Failed to derive ke");
 		return;
 	}
-- 
2.25.1

