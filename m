Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAA715ACB
	for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713704057; cv=none; b=JF9uElTg+7Azf8NHQCLjzvTO7vXl0yW8+vv9Hzg4q1NnzvrUYGa1LivMrp8da3tRzQjhgdJgNSSomtMvvvdX+KoduaBirYCqfKHtWYWE8t3FTrBczP5rRU2sztbS2oBK9WIebftmZML6O3FVtCCoKUzl2tw4BTZXfEe9Ky2UyUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713704057; c=relaxed/simple;
	bh=qlnxvCEvGuKHk7cMN069fLQZYLphU+QadhK3WPeK8wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ki21146A67nTwfs8ohcdVv1m5asK8gmBI7/bxTxxMJcqs00LVsYn7UgN+djOmVAQ7e05C+io8qYenAWn9Dut4MKMlix1CaFJ6zJQVvRTwsQEBHVY04duUmFYF1j1o2ey9o8CzdQXbyYvHWneWLRWWk4R8Z9NcXVfRhXRmh+By2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSYzX1uB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSYzX1uB"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ecec796323so3645069b3a.3
        for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 05:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713704055; x=1714308855; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/39Tl9fV3mE8KRJQM0Q7l/VA1W53h/eZdlPp/oMDTk=;
        b=BSYzX1uBzBMwWngrvYYEFtS10f/yeeA22wWuCPhCPo6lUHWefY7ZTbfVFgFgzDyvUO
         poWvXBJyYEa7112l1qQA+xkvIGnZeedZySVswVOmgylsf85sWXPaiwhtxcstxnsB41HQ
         2pNDwfbs4LOLcr2a0nq88IyM8kU56wdkrxTqhGl6622fJbUk5cZe8D57e8wK3SvbITTm
         6AGYpCUTeKcsqDqbiIYEyMiLU4sk4EKKSwZZwoGXlSp4WpHvveP/RRL0V/U6pSQkGxrE
         ig+kXxsxyPUncEVJmoOswIVL8GKc4ixrGak3h8HQveAxP1/SqPcYHqYOuh9UbXqRJ2UE
         4xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713704055; x=1714308855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/39Tl9fV3mE8KRJQM0Q7l/VA1W53h/eZdlPp/oMDTk=;
        b=SCaJjCfV9A5ynSGz19qXpMq/+qRRSCZddDUcNya1SD9yBultcnzs650uMTBKupQxog
         DBJFpLhAXSmsJajCGQnng4I5H70AA/ueB1BRhlx/3FmDcG4WW9F7Dm/mn20V7l6gdRw6
         vrUmC7NuntS/ks5GqN7rnLlSFkfOcc8xXszwTwXdyY36rTRoGY1RZM1Hy+9GyBnt60Dd
         4hLX9gZRmUP2i7NFb2Dv2AL3GXBJjPO3NuBos4Wr+wsmN7Z6DT0Vh14inw7JUyLR32nB
         qQGs/vDXtlIjQj4F2jyDXXuXIsZBZfMse+nAzvfHV5gjQhc+OzTqCeeEq6gzboNuW6PX
         4GBw==
X-Gm-Message-State: AOJu0YyyrreAVv8vQ8vVsmXSPzc6cmLctRDuaz3Mf3z18Ah8RThysWYr
	FQD5bz6ARsTvSRPSiyw+4hBqNf15CF+oPfUxUgn/4EwkhVtLYVacp7kbgaUNLRY=
X-Google-Smtp-Source: AGHT+IHLbzT4wUY/25jDwgVKMpPRRILzWu0aEYxgSTWLqoRdkt7NRzR0bY56+CQhfOvSW75scQ9CWw==
X-Received: by 2002:a05:6a00:cc8:b0:6ed:de6f:d738 with SMTP id b8-20020a056a000cc800b006edde6fd738mr11359918pfv.9.1713704055356;
        Sun, 21 Apr 2024 05:54:15 -0700 (PDT)
Received: from localhost ([185.169.0.163])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b006ed0d0307aasm6121745pfu.70.2024.04.21.05.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 05:54:15 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH 11/11] eapol: encrypt key data for AKM-defined ciphers
Date: Sun, 21 Apr 2024 05:50:41 -0700
Message-ID: <20240421125050.6649-12-brandtwjohn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421125050.6649-1-brandtwjohn@gmail.com>
References: <20240421125050.6649-1-brandtwjohn@gmail.com>
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
2.44.0

