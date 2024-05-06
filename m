Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1493811721
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 00:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956517; cv=none; b=YaQDFi5VIr1kc4O5Vw+pV1KierKCWQ3E6Mchn83Flsgge20Rk/wPPXOHZeMlMyjGdJHFdf9Hv3eu3BafYQZFn8WOve2Sb2RawU5sKgYuapLXSd69VaLib4w0Sek+mXB0f7teCWOtJBlPQxE86rirzOSsSp2minFrLZsMRnEIQpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956517; c=relaxed/simple;
	bh=Y6cuD+Bxg1iV4E9ycexaBAEwfqRA0yw7SN8DaeNhTU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B50Jscz8NSmifKu24vJenZEJ/sctzp/pFJrHUycOiKShVOKNJ53smyikkXSCWt6lrt3jEYeqSCkGjnqay+IdMVlWaNlZvzT3tTlATzKr009autzBK2Z31FoQBmS+zieJ+I3vvMITFm6Qsn1IwtVDo29MMs2ZskV83jgPQ0RlxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RW/KOgWI; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RW/KOgWI"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f06e836d5aso44242a34.3
        for <iwd@lists.linux.dev>; Sun, 05 May 2024 17:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714956515; x=1715561315; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwVggoRUwLeFkQ4iPmQh35xD/Dk3FiY62I1QDinlZaQ=;
        b=RW/KOgWI8ajUWdbtz1RhiAOsUiJi5GDAXgFi03ip5WgMfqN+4f03KsD/t8Q6TEvbuy
         b+kkT4g3hHeTEp0DHQbFL0HnwMYTFtNMpMruVUinB8pvjnL2/HJ49NJoXutMmw0BhzMu
         61X+vd+dAGRH9Agpi1rY4hJajgyjzVhLkzjj+QFmdrN3GUKiHwZKNDbzU91RwbLPFAyo
         pXMxcsEQnv1xeQ8KJ4zZWBI5bzF+xQsMxbyEuTfZ6jWsqyJIlb4Jljkl8CiqdFSk3/Ea
         A/OV8r3lUl67TlPum39Jn+kWXWbXs9w3rn0xfh33DfbdXPDf41/VopO0gTIIgWeP2jXz
         ZMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956515; x=1715561315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwVggoRUwLeFkQ4iPmQh35xD/Dk3FiY62I1QDinlZaQ=;
        b=Y8JW6q9GguL3eDD3fVIwYN3EOI0vfPEOXi5cVGm/DTUvduAvldufP2EWutS7mwu62U
         vKV1rgLyk02pk35w3JMNg2EljUm8kep5a+BpFeV9FkOtf5zGAPbrCBrpZ/XRMDGYS7FA
         e31yhl83DcT8UjJwIEwsamaWsj7HwWj6LnEckn44mwLTIrSIGHULiAiLB4YkNfPkZLCC
         JTvwn3uy8Y7UI1gFyUtfMBMtZeCFKaVk+mYKZvDnpiwkMBOqR5d5RUsT8ltKgMUonTeM
         L6WG4+k6UNXBbO52J//S7USZv+jKWrpNm+Bm582Yr8wXp9uMVwBSsPjbaFsHOLcx4MZu
         WFTw==
X-Gm-Message-State: AOJu0YxfZNKAGYfLSvxGMO159XONcbEz+menUBOFkntufB8AcZi9vshL
	M3dnhaPVl9dSUXQR5HhjcInQtveU4HTXv4r2+Y4cKlRo/edSoNn723Cb3A==
X-Google-Smtp-Source: AGHT+IHGhFCgDjAYuhoHKziTiaMgHflhPiVKj3fLG0Kyq9I/5GQ7f2L4rau72Smr2+YNgapYzJulcQ==
X-Received: by 2002:a9d:7d8e:0:b0:6ed:51e8:4d0b with SMTP id j14-20020a9d7d8e000000b006ed51e84d0bmr9873054otn.11.1714956514995;
        Sun, 05 May 2024 17:48:34 -0700 (PDT)
Received: from localhost ([192.145.118.41])
        by smtp.gmail.com with ESMTPSA id m13-20020a62f20d000000b006f45831ac05sm3226160pfh.0.2024.05.05.17.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:48:34 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH v2 05/18] sae: refactor and add function sae_calculate_keys
Date: Sun,  5 May 2024 17:30:28 -0700
Message-ID: <20240506003518.320176-6-brandtwjohn@gmail.com>
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

Refactor code by moving code to the new function sae_calculate_keys.
This will make it easier in the next commits to add SAE support for AP
mode.
---
 src/sae.c | 86 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 36 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index 4e0b73d8..7787a390 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -685,10 +685,9 @@ static bool sae_send_confirm(struct sae_sm *sm)
 	return true;
 }
 
-static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
-					const uint8_t *frame, size_t len)
+
+static int sae_calculate_keys(struct sae_sm *sm)
 {
-	uint8_t *ptr = (uint8_t *) frame;
 	unsigned int nbytes = l_ecc_curve_get_scalar_bytes(sm->curve);
 	enum l_checksum_type hash =
 		crypto_sae_hash_from_ecc_prime_len(sm->sae_type, nbytes);
@@ -704,39 +703,6 @@ static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
 	struct l_ecc_scalar *tmp_scalar;
 	struct l_ecc_scalar *order;
 
-	ptr += 2;
-
-	sm->p_scalar = l_ecc_scalar_new(sm->curve, ptr, nbytes);
-	if (!sm->p_scalar) {
-		l_error("Server sent invalid P_Scalar during commit");
-		return sae_reject(sm, SAE_STATE_COMMITTED,
-				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP);
-	}
-
-	ptr += nbytes;
-
-	sm->p_element = l_ecc_point_from_data(sm->curve, L_ECC_POINT_TYPE_FULL,
-						ptr, nbytes * 2);
-	if (!sm->p_element) {
-		l_error("Server sent invalid P_Element during commit");
-		return sae_reject(sm, SAE_STATE_COMMITTED,
-				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP);
-	}
-
-	/*
-	 * If they match those sent as part of the protocol instance's own
-	 * SAE Commit message, the frame shall be silently discarded (because
-	 * it is evidence of a reflection attack) and the t0 (retransmission)
-	 * timer shall be set.
-	 */
-	if (l_ecc_scalars_are_equal(sm->p_scalar, sm->scalar) ||
-			l_ecc_points_are_equal(sm->p_element, sm->element)) {
-		l_warn("peer scalar or element matched own, discarding frame");
-		return -ENOMSG;
-	}
-
-	sm->sc++;
-
 	/*
 	 * K = scalar-op(rand, (element-op(scalar-op(peer-commit-scalar, PWE),
 	 *			PEER-COMMIT-ELEMENT)))
@@ -825,6 +791,54 @@ static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
 	/* don't set the handshakes pmkid until confirm is verified */
 	memcpy(sm->pmkid, tmp, 16);
 
+	return 0;
+}
+
+
+static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
+					const uint8_t *frame, size_t len)
+{
+	uint8_t *ptr = (uint8_t *) frame;
+	unsigned int nbytes = l_ecc_curve_get_scalar_bytes(sm->curve);
+	int r;
+
+	ptr += 2;
+
+	sm->p_scalar = l_ecc_scalar_new(sm->curve, ptr, nbytes);
+	if (!sm->p_scalar) {
+		l_error("Server sent invalid P_Scalar during commit");
+		return sae_reject(sm, SAE_STATE_COMMITTED,
+				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP);
+	}
+
+	ptr += nbytes;
+
+	sm->p_element = l_ecc_point_from_data(sm->curve, L_ECC_POINT_TYPE_FULL,
+						ptr, nbytes * 2);
+	if (!sm->p_element) {
+		l_error("Server sent invalid P_Element during commit");
+		return sae_reject(sm, SAE_STATE_COMMITTED,
+				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP);
+	}
+
+	/*
+	 * If they match those sent as part of the protocol instance's own
+	 * SAE Commit message, the frame shall be silently discarded (because
+	 * it is evidence of a reflection attack) and the t0 (retransmission)
+	 * timer shall be set.
+	 */
+	if (l_ecc_scalars_are_equal(sm->p_scalar, sm->scalar) ||
+			l_ecc_points_are_equal(sm->p_element, sm->element)) {
+		l_warn("peer scalar or element matched own, discarding frame");
+		return -ENOMSG;
+	}
+
+	sm->sc++;
+
+	r = sae_calculate_keys(sm);
+	if (r != 0)
+		return r;
+
 	if (!sae_send_confirm(sm))
 		return -EPROTO;
 
-- 
2.45.0

