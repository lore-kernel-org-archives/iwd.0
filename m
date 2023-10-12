Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4993B7BD
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt1Ob0kw"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1c9e06f058bso7847275ad.0
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140919; x=1697745719; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YU51O4/SkwsOPlViTQ69Tqmhgy4EYgfzoU1I29u+30Y=;
        b=Jt1Ob0kwABGR55boqFwePueH5GJ++nLv+fyk9remrVABHJs9c2i3klJwHdC9oO+Mts
         a1trChkKiQk5pIOz4WUCIO60KHcD415yK6hi6O9c5TAXEOARulLImOyOTEOpAboi+lY/
         2APF/VwZCPWZe32ChkuZkxQxtENuPwV1xUY/uEpKYlIDBzGwrzrmV4qH5uZ/MFK/pY/U
         folaimXbini/l4XKGKXQ/LHjeANkJkOxwt5WkabxRsnzhYf8tYqfFOzPUNiA6KqUK8zY
         vPImQu5/NYBShhbFWRmiqg4NoBxpF/vlC33nMz27/kBnfY7b967HYHOM7OPkMadBqLV0
         /R4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140919; x=1697745719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YU51O4/SkwsOPlViTQ69Tqmhgy4EYgfzoU1I29u+30Y=;
        b=DWzB9jy0pAHodyWuioio0untGo06HNZMEork6dPLKL12X+/j3kcFU4eWBblHj0x1UY
         9TtC4PY75UQx1nSjvrWU0/MCZZBwIWmpwpbWuvGRghB8mmR1RUnKs7YlotX9TDq6CEk0
         Q7b3b99C30vL/w7FuVfBeeXtFANt0YWIRM2IhHPJ8gJJJu1FvuJcmeLAf+iUfY4kgxTP
         x0Ad5P9oZcI7NLFXGzXz/phv6eWsToKlXxYjpZ166b3GlyuZpQMrjW53vGgDmSMAMJx2
         0OtvCffqRKqFy2Fy5DJQlO7HtIePUtn9V5uHEzd1f1my/7JspvOFn4/KKNtaBN1KKmn5
         XaLA==
X-Gm-Message-State: AOJu0YxcKckoma2n32wfeLZ1UeMKdv0xQ4kOxkuXxgoWDjM0+Tan5/eX
	xhChz0sMBuGzTuHP82gPOptKX0Lwi/Y=
X-Google-Smtp-Source: AGHT+IG/dhI91+oIhfAv41COcHPxBFS6KFPFCa8ztzMCgELTmpy5zcjEAOj/A4QUnG8zOfHzjiqPkw==
X-Received: by 2002:a17:903:2290:b0:1c6:2655:625d with SMTP id b16-20020a170903229000b001c62655625dmr31874812plh.15.1697140918816;
        Thu, 12 Oct 2023 13:01:58 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:01:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/21] crypto: remove label from prf_plus, instead use va_args
Date: Thu, 12 Oct 2023 13:01:30 -0700
Message-Id: <20231012200150.338401-2-prestwoj@gmail.com>
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

The prf_plus API was a bit restrictive because it only took a
string label which isn't compatible with some specs (e.g. DPP
inputs to HKDF-Expand). In addition it took additional label
aruments which were appended to the HMAC call (and the
non-intuitive '\0' if there were extra arguments).

Instead the label argument has been removed and callers can pass
it in through va_args. This also lets the caller decided the length
and can include the '\0' or not, dependent on the spec the caller
is following.
---
 src/crypto.c | 24 +++++++++---------------
 src/crypto.h |  2 +-
 src/erp.c    | 19 +++++++++++--------
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/src/crypto.c b/src/crypto.c
index 710641ed..3128b2a5 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -624,10 +624,10 @@ bool prf_sha1(const void *key, size_t key_len,
 
 /* PRF+ from RFC 5295 Section 3.1.2 (also RFC 4306 Section 2.13) */
 bool prf_plus(enum l_checksum_type type, const void *key, size_t key_len,
-		const char *label, void *out, size_t out_len,
+		void *out, size_t out_len,
 		size_t n_extra, ...)
 {
-	struct iovec iov[n_extra + 3];
+	struct iovec iov[n_extra + 2];
 	uint8_t *t = out;
 	size_t t_len = 0;
 	uint8_t count = 1;
@@ -637,24 +637,17 @@ bool prf_plus(enum l_checksum_type type, const void *key, size_t key_len,
 	ssize_t ret;
 	size_t i;
 
-	iov[1].iov_base = (void *) label;
-	iov[1].iov_len = strlen(label);
-
-	/* Include the '\0' from the label in S if extra arguments provided */
-	if (n_extra)
-		iov[1].iov_len += 1;
-
 	va_start(va, n_extra);
 
 	for (i = 0; i < n_extra; i++) {
-		iov[i + 2].iov_base = va_arg(va, void *);
-		iov[i + 2].iov_len = va_arg(va, size_t);
+		iov[i + 1].iov_base = va_arg(va, void *);
+		iov[i + 1].iov_len = va_arg(va, size_t);
 	}
 
 	va_end(va);
 
-	iov[n_extra + 2].iov_base = &count;
-	iov[n_extra + 2].iov_len = 1;
+	iov[n_extra + 1].iov_base = &count;
+	iov[n_extra + 1].iov_len = 1;
 
 	hmac = l_checksum_new_hmac(type, key, key_len);
 	if (!hmac)
@@ -664,7 +657,7 @@ bool prf_plus(enum l_checksum_type type, const void *key, size_t key_len,
 		iov[0].iov_base = t;
 		iov[0].iov_len = t_len;
 
-		if (!l_checksum_updatev(hmac, iov, n_extra + 3)) {
+		if (!l_checksum_updatev(hmac, iov, n_extra + 2)) {
 			l_checksum_free(hmac);
 			return false;
 		}
@@ -874,7 +867,8 @@ bool hkdf_extract(enum l_checksum_type type, const void *key,
 bool hkdf_expand(enum l_checksum_type type, const void *key, size_t key_len,
 			const char *info, void *out, size_t out_len)
 {
-	return prf_plus(type, key, key_len, info, out, out_len, 0);
+	return prf_plus(type, key, key_len, out, out_len, 1,
+			info, strlen(info));
 }
 
 /*
diff --git a/src/crypto.h b/src/crypto.h
index d2a96655..1f48a52b 100644
--- a/src/crypto.h
+++ b/src/crypto.h
@@ -122,7 +122,7 @@ bool prf_plus_sha1(const void *key, size_t key_len,
 		const void *data, size_t data_len, void *output, size_t size);
 
 bool prf_plus(enum l_checksum_type type, const void *key, size_t key_len,
-		const char *label, void *out, size_t out_len,
+		void *out, size_t out_len,
 		size_t n_extra, ...);
 
 bool hkdf_extract(enum l_checksum_type type, const void *key, size_t key_len,
diff --git a/src/erp.c b/src/erp.c
index 5af18fda..2729cfc8 100644
--- a/src/erp.c
+++ b/src/erp.c
@@ -281,8 +281,9 @@ static bool erp_derive_emsk_name(const uint8_t *session_id, size_t session_len,
 	uint16_t eight = L_CPU_TO_BE16(8);
 	char *ascii;
 
-	if (!prf_plus(L_CHECKSUM_SHA256, session_id, session_len, "EMSK",
-				hex, 8, 1, &eight, sizeof(eight)))
+	if (!prf_plus(L_CHECKSUM_SHA256, session_id, session_len,
+				hex, 8, 2, "EMSK", strlen("EMSK") + 1,
+				&eight, sizeof(eight)))
 		return false;
 
 	ascii = l_util_hexstring(hex, 8);
@@ -309,13 +310,15 @@ static bool erp_derive_reauth_keys(const uint8_t *emsk, size_t emsk_len,
 	uint16_t len = L_CPU_TO_BE16(emsk_len);
 	uint8_t cryptosuite = ERP_CRYPTOSUITE_SHA256_128;
 
-	if (!prf_plus(L_CHECKSUM_SHA256, emsk, emsk_len, ERP_RRK_LABEL,
-				r_rk, emsk_len, 1,
+	if (!prf_plus(L_CHECKSUM_SHA256, emsk, emsk_len,
+				r_rk, emsk_len, 2, ERP_RRK_LABEL,
+				strlen(ERP_RRK_LABEL) + 1,
 				&len, sizeof(len)))
 		return false;
 
-	if (!prf_plus(L_CHECKSUM_SHA256, r_rk, emsk_len, ERP_RIK_LABEL,
-				r_ik, emsk_len, 2,
+	if (!prf_plus(L_CHECKSUM_SHA256, r_rk, emsk_len,
+				r_ik, emsk_len, 3, ERP_RIK_LABEL,
+				strlen(ERP_RIK_LABEL) + 1,
 				&cryptosuite, 1, &len, sizeof(len)))
 		return false;
 
@@ -496,8 +499,8 @@ int erp_rx_packet(struct erp_state *erp, const uint8_t *pkt, size_t len)
 	length = L_CPU_TO_BE16(64);
 
 	if (!prf_plus(L_CHECKSUM_SHA256, erp->r_rk, erp->cache->emsk_len,
-				ERP_RMSK_LABEL,
-				erp->rmsk, erp->cache->emsk_len, 2,
+				erp->rmsk, erp->cache->emsk_len, 3,
+				ERP_RMSK_LABEL, strlen(ERP_RMSK_LABEL) + 1,
 				&seq, sizeof(seq),
 				&length, sizeof(length)))
 		goto eap_failed;
-- 
2.25.1

