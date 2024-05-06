Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D714EA934
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956603; cv=none; b=f3nfLLIBFbZD6zazO5nOVfYlCskSx509qlpL0VRv+UDbdBoUlFAH1CgTCU39fWpbPGejA1NPtglMjsUMy4jekfqebjp2sH6s8Rz5EEFJ5nw5wucZqzjgribQuztZdrvh7BIvngg6UmV2wJrWBFj1n0Ajsd6Q4o5w9bJe1DXJNh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956603; c=relaxed/simple;
	bh=eEq9Td+YFyMLbQxlT4nLIpPILrfWB3pFM6RwDSO05p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KO00IMdVVUuDuHTrDlVcwW+exFkOvnjrSmsiugf+u2k6qmm0x2nS69u+6Gj7b4MgTVAEsMzlgxTQ/e/mZWitjK+IowguS10RGOIUaXdVLYPv85xCS+SfljranN5Mhug1CfbBVLoDkYOypjy9eRov6YOt3JPU1INm0akX969JYTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCkGPumH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCkGPumH"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e3ca546d40so8969515ad.3
        for <iwd@lists.linux.dev>; Sun, 05 May 2024 17:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714956601; x=1715561401; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4WaFKoi3gYbHn3QYKFOplN1UMqY7nh1w7n7PFZNIWs=;
        b=YCkGPumHFlCjiPO/31QZhdnOfPrx89oMDq2HjMR5b019wWP499bjEeSHOJ3ckPW8yB
         eaoIiziCeX1h8BNXpCYMrHvZu7rv3tvXp8NLe+dGsiCjQQrEhQmic83mbmamMg0NPtQh
         P1JRdmzhV8pEphY98J3OX2hSwBhqNyc1WaU9vDC8Pm1daoIpURq5VhqARWNV5pjzn6Qg
         HTPdaPWTgTqQkHYADAGEAkzln1ChfOTxl/2+m/7gBSvRwwXihehdWRnEF+dC0OwSlkeb
         +urPeXn3UzyE2J0lEErIrFQaOfPL0YwxrpucSXgEkojT0IR40yQ+EKcMe125oiM98A3W
         dZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956601; x=1715561401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4WaFKoi3gYbHn3QYKFOplN1UMqY7nh1w7n7PFZNIWs=;
        b=RbbcHfMTJDrpwVvYvYzr9aCdpe+W5kYso4Ykg00+N8oH1VsPz3Mf+LGu7EWTqHp36w
         HGCc6IX+F9xBhUpCaG0gpQDo8OIb6iG4kmbQgi3nlvq1mmcd5uCNLTbFtnGRUXVhqUDy
         tT99OGVY4Lfx4lv43zRoGpZ5SuK5+3ZYfNEc3yrEuza5T4HZzA8FevDwSKvW15ICqzRH
         Ouh6KO8NOfOz1n0J+sAHOOAoqamljv7dh4BxjlipX21G6lxDiU0XObGGg7bCe2h/Wlid
         ednS4K4ZUPSeVqch0JyDvbCUQNDIEGrxKg0z3mic4kNPHZ09thVQlfIC0PlH3DWgilGL
         s96Q==
X-Gm-Message-State: AOJu0YwXktxoOZFI63KhsNX6tNu3Y0oGAaJ9s7R0VChVBPHaRxPgVMoJ
	6MzPhIzdTkq8nkwELx8nHBPs7ii+WgU4ctp8zk+v9vEhQ+ipNEfBriOQKA==
X-Google-Smtp-Source: AGHT+IE16+xhwZKMSYRlNAaQ/PZ9Nyrscu4RyFkD2ihSto1kO22XwGjoY1q7NfB138mTwxsyEZdQeA==
X-Received: by 2002:a17:902:a513:b0:1ec:8d50:8dec with SMTP id s19-20020a170902a51300b001ec8d508decmr7678440plq.39.1714956600971;
        Sun, 05 May 2024 17:50:00 -0700 (PDT)
Received: from localhost ([192.145.118.41])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b001e435350a7bsm3247619pln.259.2024.05.05.17.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:50:00 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH v2 12/18] eapol: encrypt key data for AKM-defined ciphers
Date: Sun,  5 May 2024 17:30:35 -0700
Message-ID: <20240506003518.320176-13-brandtwjohn@gmail.com>
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

Support encrypting key data when the cipher is AKM-defined. This is
needed to support SAE in AP mode.
---
 src/eapol.c | 51 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index a9b4f3ba..524a26c9 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -387,6 +387,23 @@ error:
 	return NULL;
 }
 
+static int padded_aes_wrap(const uint8_t *kek, uint8_t *key_data,
+				size_t *key_data_len,
+				struct eapol_key *out_frame, size_t mic_len)
+{
+	if (*key_data_len < 16 || *key_data_len % 8)
+		key_data[(*key_data_len)++] = 0xdd;
+	while (*key_data_len < 16 || *key_data_len % 8)
+		key_data[(*key_data_len)++] = 0x00;
+
+	if (!aes_wrap(kek, key_data, *key_data_len,
+				EAPOL_KEY_DATA(out_frame, mic_len)))
+		return -ENOPROTOOPT;
+
+	*key_data_len += 8;
+	return 0;
+}
+
 /*
  * Pad and encrypt the plaintext Key Data contents in @key_data using
  * the encryption scheme required by @out_frame->key_descriptor_version,
@@ -395,12 +412,12 @@ error:
  * Note that for efficiency @key_data is being modified, including in
  * case of failure, so it must be sufficiently larger than @key_data_len.
  */
-static int eapol_encrypt_key_data(const uint8_t *kek, uint8_t *key_data,
-				size_t key_data_len,
+static int eapol_encrypt_key_data(enum ie_rsn_akm_suite akm, const uint8_t *kek,
+				uint8_t *key_data, size_t key_data_len,
 				struct eapol_key *out_frame, size_t mic_len)
 {
 	uint8_t key[32];
-	bool ret;
+	int ret;
 
 	switch (out_frame->key_descriptor_version) {
 	case EAPOL_KEY_DESCRIPTOR_VERSION_HMAC_MD5_ARC4:
@@ -426,18 +443,21 @@ static int eapol_encrypt_key_data(const uint8_t *kek, uint8_t *key_data,
 		break;
 	case EAPOL_KEY_DESCRIPTOR_VERSION_HMAC_SHA1_AES:
 	case EAPOL_KEY_DESCRIPTOR_VERSION_AES_128_CMAC_AES:
-		if (key_data_len < 16 || key_data_len % 8)
-			key_data[key_data_len++] = 0xdd;
-		while (key_data_len < 16 || key_data_len % 8)
-			key_data[key_data_len++] = 0x00;
-
-		if (!aes_wrap(kek, key_data, key_data_len,
-					EAPOL_KEY_DATA(out_frame, mic_len)))
-			return -ENOPROTOOPT;
-
-		key_data_len += 8;
+		ret = padded_aes_wrap(kek, key_data, &key_data_len, out_frame, mic_len);
+		if (ret < 0)
+			return ret;
 
 		break;
+	case EAPOL_KEY_DESCRIPTOR_VERSION_AKM_DEFINED:
+		switch (akm) {
+		case IE_RSN_AKM_SUITE_SAE_SHA256:
+			ret = padded_aes_wrap(kek, key_data, &key_data_len, out_frame, mic_len);
+			if (ret < 0)
+				return ret;
+			break;
+		default:
+			return -ENOTSUP;
+		}
 	}
 
 	l_put_be16(key_data_len, EAPOL_KEY_DATA(out_frame, mic_len) - 2);
@@ -1467,8 +1487,9 @@ static void eapol_send_ptk_3_of_4(struct eapol_sm *sm)
 	}
 
 	kek = handshake_state_get_kek(sm->handshake);
-	key_data_len = eapol_encrypt_key_data(kek, key_data_buf,
-						key_data_len, ek, sm->mic_len);
+	key_data_len = eapol_encrypt_key_data(sm->handshake->akm_suite, kek,
+						key_data_buf, key_data_len, ek,
+						sm->mic_len);
 	explicit_bzero(key_data_buf, sizeof(key_data_buf));
 
 	if (key_data_len < 0)
-- 
2.45.0

