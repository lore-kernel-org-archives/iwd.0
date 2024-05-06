Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FDCB673
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956640; cv=none; b=UfoMJAFUWQSVY7Ni2TY2SwH1UPzF1pukFjz+m6KomJnr33ZyYNmqfdVaJXqBE+ByJCPvuMhaozXsCF6FgoydKmA8qnpNwCs2GXlcmlEE4rQdO5df76g6xrBGmg0IAmDeTByREnleTrdnNwqQv+yJRIHetftYmyh5pR8mzCIdmRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956640; c=relaxed/simple;
	bh=VydOKVJuPBTss2PStFya0mkiAZeXJlVm1B0Smv+bZCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgtMw7Yr0eAO2bd4bdFXoNIHA1PhtUI4t6uSrKCsrSUi+yL7SL8v20ryIFgQbGoHwLLWDncCuEcwAbHK2D5d0t64Gmnnqy4mEyIsBewJ5Unvof0bOZ4mduFAApAmW1QCygGlOkIEOxKXOjd8s8l+6PfRhKRjf92Jb+9vIHwsAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVZYoj1s; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVZYoj1s"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e9ffd3f96eso8487185ad.3
        for <iwd@lists.linux.dev>; Sun, 05 May 2024 17:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714956638; x=1715561438; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5580yddf2aMg8WBhr7IZrzQ4F8u9ZGBSofyZ1Dq2gY=;
        b=DVZYoj1sJF9Qoz/0ukpCG2E1ft8ga90kaG3fnz2WrU8Mtez2/wXBiueqKNCyVFAhau
         Vc54wu2esQwqL04aZvk5FLggxTZVhM6yeWt4sU0jykuYO0AKiWDebvaPhpnXSbzaW0nk
         jArXX8EpRN4PLw1m+6QwW2xTyDVJ8RculH60OmZnZG0+mF6rfOlxUImBfPmvvv2N8apk
         NFEXbHfxsrgcM5cB57CUQ/RvupNupIt1BmudBKUc8FSbjQj4jP4ZIyuZktJoZwJ36bZe
         JRxsMEz8oUaLye21xoozQDXFfsrM5HwvuvVFquSB3xu0soaUZb0hDXvdGF/fecnUsPRG
         DmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956638; x=1715561438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5580yddf2aMg8WBhr7IZrzQ4F8u9ZGBSofyZ1Dq2gY=;
        b=ThUr+MD5gxZOfeC6gmMZS5sQvkL5zr8ziHMtSdO1qAq3sLbDr4/58DJ4w5Zcd+9o55
         lDYQeZtElSMgPo2MEB3fM08mVk6a7/Uk8+hQBozwzrGAE2jv9F7xZdzUWhR8G4RaRaXI
         R6vgxOJhDjN9+C7UEtd1r8TucJdYmzlB9DSttZBGN9IaoLfXGhpZTPpHCdI82ZP3vrB5
         TB04tbPDn0SR+55efY+yqKso+inDCK7sOOSL6lyX9IxLIYpqK3w3qd96v1nyuOYbnx6O
         4HqN3PZCl93WEwwntiVvs+JP8l8lOrS527QCzEyRb3S2wFJrkR7FgyiCGpiQnyPEkdWc
         MyvA==
X-Gm-Message-State: AOJu0YwGKZaGNG0HZDa3hoiPWS/i2hYoAp4zHSusQog+CmnaYZkDXuHR
	TilnbIHw3ZUUk1ZOFF9yqeyJCBfrinCirlusi6CAZp21EjlU2/9O/VSzew==
X-Google-Smtp-Source: AGHT+IHGTTbnJ5sEsjxjA1Yb3rMqJ1pWq8LEOHhVkRhseZ549M9b4ZK/o4hycFWN5jaARTGmcQmEFw==
X-Received: by 2002:a17:902:db0a:b0:1eb:acff:63ba with SMTP id m10-20020a170902db0a00b001ebacff63bamr11783239plx.67.1714956637890;
        Sun, 05 May 2024 17:50:37 -0700 (PDT)
Received: from localhost ([192.145.118.41])
        by smtp.gmail.com with ESMTPSA id n5-20020a170903110500b001eab26889a7sm7043391plh.136.2024.05.05.17.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:50:37 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH v2 15/18] handshake: add functions to save and set IGTK
Date: Sun,  5 May 2024 17:30:38 -0700
Message-ID: <20240506003518.320176-16-brandtwjohn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506003518.320176-1-brandtwjohn@gmail.com>
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To add MFP support in the AP mode, add utility functions to save the
IGTK and to add the IGTK to handshake messages.
---
 src/handshake.c | 34 ++++++++++++++++++++++++++++++++++
 src/handshake.h |  8 ++++++++
 2 files changed, 42 insertions(+)

diff --git a/src/handshake.c b/src/handshake.c
index ee23dbad..fc1978df 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -838,6 +838,21 @@ void handshake_state_set_gtk(struct handshake_state *s, const uint8_t *key,
 	memcpy(s->gtk_rsc, rsc, 6);
 }
 
+void handshake_state_set_igtk(struct handshake_state *s, const uint8_t *key,
+				unsigned int key_index, const uint8_t *rsc)
+{
+	enum crypto_cipher cipher =
+		ie_rsn_cipher_suite_to_cipher(s->group_management_cipher);
+	int key_len = crypto_cipher_key_len(cipher);
+
+	if (!key_len)
+		return;
+
+	memcpy(s->igtk, key, key_len);
+	s->igtk_index = key_index;
+	memcpy(s->igtk_rsc, rsc, 6);
+}
+
 /*
  * This function performs a match of the RSN/WPA IE obtained from the scan
  * results vs the RSN/WPA IE obtained as part of the 4-way handshake.  If they
@@ -1027,6 +1042,25 @@ void handshake_util_build_gtk_kde(enum crypto_cipher cipher, const uint8_t *key,
 	memcpy(to, key, key_len);
 }
 
+void handshake_util_build_igtk_kde(enum crypto_cipher cipher, const uint8_t *key,
+					unsigned int key_index, uint8_t *to)
+{
+	size_t key_len = crypto_cipher_key_len(cipher);
+
+	*to++ = IE_TYPE_VENDOR_SPECIFIC;
+	*to++ = 12 + key_len;
+	l_put_be32(HANDSHAKE_KDE_IGTK, to);
+	to += 4;
+	*to++ = key_index;
+	*to++ = 0;
+
+	/** Initialize PN to zero **/
+	memset(to, 0, 6);
+	to += 6;
+
+	memcpy(to, key, key_len);
+}
+
 static const uint8_t *handshake_state_get_ft_fils_kek(struct handshake_state *s,
 						size_t *len)
 {
diff --git a/src/handshake.h b/src/handshake.h
index 62118fe2..8a356e6b 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -150,8 +150,11 @@ struct handshake_state {
 	uint8_t r1khid[6];
 	uint8_t gtk[32];
 	uint8_t gtk_rsc[6];
+	uint8_t igtk[32];
+	uint8_t igtk_rsc[6];
 	uint8_t proto_version : 2;
 	unsigned int gtk_index;
+	unsigned int igtk_index;
 	uint8_t active_tk_index;
 	struct erp_cache_entry *erp_cache;
 	bool support_ip_allocation : 1;
@@ -288,6 +291,9 @@ bool handshake_decode_fte_key(struct handshake_state *s, const uint8_t *wrapped,
 void handshake_state_set_gtk(struct handshake_state *s, const uint8_t *key,
 				unsigned int key_index, const uint8_t *rsc);
 
+void handshake_state_set_igtk(struct handshake_state *s, const uint8_t *key,
+				unsigned int key_index, const uint8_t *rsc);
+
 void handshake_state_set_chandef(struct handshake_state *s,
 					struct band_chandef *chandef);
 int handshake_state_verify_oci(struct handshake_state *s, const uint8_t *oci,
@@ -307,5 +313,7 @@ const uint8_t *handshake_util_find_pmkid_kde(const uint8_t *data,
 					size_t data_len);
 void handshake_util_build_gtk_kde(enum crypto_cipher cipher, const uint8_t *key,
 					unsigned int key_index, uint8_t *to);
+void handshake_util_build_igtk_kde(enum crypto_cipher cipher, const uint8_t *key,
+					unsigned int key_index, uint8_t *to);
 
 DEFINE_CLEANUP_FUNC(handshake_state_free);
-- 
2.45.0

