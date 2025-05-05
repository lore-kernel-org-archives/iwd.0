Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6204824E4AA
	for <iwd@lists.linux.dev>; Mon,  5 May 2025 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746448546; cv=none; b=r4CYzKxZVyIhwEZVi92PjKHJJWmdvPYvO8r5EWOQdNlxJkBeDofKrH8Im1kxfLkh2TB4v4W6fUH72UCd98shXQQZZk1Ov41qMb8ycoF+Armj+xFwllDGTvmvye21WaSk8U9do1MK8dQUNZAjdkMW/BDCtCgmFR/MXW9EIdcnV+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746448546; c=relaxed/simple;
	bh=OSZcHU0sO2KwuW1OsLXRGnpPhJTLONKrCgISe5eXjOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sGGkg1WOUuZzn3p2rwLadSqBtjrW/XnNbxqt04/BGWSESHkucAdz17uY2iaXthhhsR3jDIOkIi+9DYzehkm0lUCwvlGPH1UCDB5egfu4J/ZOF4tIamwaQFKqoFilN3/B+l0toxob+uA0er6r7/Dw53mgu4wOYla7qhUvrQqHK4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JK730k8J; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JK730k8J"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso4348529b3a.2
        for <iwd@lists.linux.dev>; Mon, 05 May 2025 05:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746448544; x=1747053344; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3mQoURK8wLQjuCle6ze7TN6BcXjeAI4ZR201Wrr528=;
        b=JK730k8JFo1xc4DA4auJSDSa/miHaKdDB6pnQkaoI9H5wEy4LO58fVkbrEYs1Dweob
         Q/JVXelWjltvo/gFoJWleHcfSitVuztN9vgrSBNA4skgAZNjeOGFHOWe5VJDykPXKbNi
         qL1o85sPFot/4FMFyE4Yr3smAO8Xrveu4G28Bb7AHQ5p/0vkdFmUpeLW1D9+ndd9noA4
         fwm5noUlWvpwnnt8gxQs5hQ+qSVwP9e5P+lH0K8nwxpmshOeYfQiZ6h2bvlQyg5ZsfK2
         kGsWXpacObzGjZuqu8qlO2tMxSRJRz/k66eUF0VEsm/b2fEgiQF4pSBEihuRdkg3Q4X4
         VRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746448544; x=1747053344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3mQoURK8wLQjuCle6ze7TN6BcXjeAI4ZR201Wrr528=;
        b=SUCdkM/xkiCg6HCcU8/kCO2kNLhVWfHSa3tya4S9ZF1B3TXbm0tnR+VS5P2/qhj1vn
         rnT51TH1HN/dy4zLsO1A9MvJI8vJEi9Ey3kNkjI7fzN10NHW8akqueKWFfMh1yV0uH3j
         yx+BO6CHkPbYI6e4zneCjsZPbdY2MCGGY90sGFrW/pxKU7UK1dDtoT/4PDsGgCT0mC/T
         nxdcvi0YHdIjdtA6jvvpjR87wW7WDqb5GeBx+7ti0kDOeSLvykFTzXxcfe8tZa9TzB3E
         5vVJtWmEFBeELI4ck8mqD34qgUP08IEuqicyARWgWtkfzfX3Spp/pYnLnGk3OAMN2ur7
         3IXA==
X-Gm-Message-State: AOJu0YzfLiZdF4r3yGdsZIgBrsHz+niwgUKghO1nrciT1T+mHUdyPnai
	cFCIxjpJjG3TdH1qLbYiP52QlQY3tyDVsjy4LTjJJ1e2jmQkFJenETqafw==
X-Gm-Gg: ASbGncuAmEGRcQE8oAaaVdNQrjEGKSfaGAzcINiP3OUh465qovfptF3oteQZdM8DS/F
	9e+q7qmBIlsMNrFsse/eRY1cZTXMkweF9Ef7x27xwofil+W9Mxgne8HalAUUpHs4MHEaH+D3wWu
	LVP4wBol3F/LWY3qxJjgavRtrbD80uNVHt2VlhgkcGZ9DLf7fyHRuDRRKKFavzk1ddYc1zGzUs6
	qRtzydxonRf+C89hkSHAKJsTw3jAVUdLwbL0xo8mZf1SNo+izsDvPoRanPPVSMzXL4F7YUyd+Vv
	a+12Y1BsC/Jz1GYUi2/vdC2JHCu+po/V2bkaDE2mLy5c7n7ZY6cnE97j7/yr8Vo6TuTGe5VSKnE
	HizejKhwHbAgT1gB86BFAckA3Au6sNR82c7OIxQ==
X-Google-Smtp-Source: AGHT+IG3fG7aXKCaSUfpaIpzzTc+9oBUAbahUhiHAWCAyHxFBgJGGQGCoOCtiac4n7cC63gmUBXSEw==
X-Received: by 2002:a05:6a00:410e:b0:736:7270:4d18 with SMTP id d2e1a72fcca58-74058a568d4mr16750351b3a.14.1746448544289;
        Mon, 05 May 2025 05:35:44 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058dbb71esm6642054b3a.38.2025.05.05.05.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 05:35:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] unit: check cipher support and cleanup in test-storage
Date: Mon,  5 May 2025 05:35:40 -0700
Message-Id: <20250505123540.281773-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __storage_decrypt API requires AES_CTR so support should be
checked before running that test. In addition storage_exit was never
being called which leaves unbalanced mlock/munlock calls.
---
 unit/test-storage.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/unit/test-storage.c b/unit/test-storage.c
index c40518e6..765d9967 100644
--- a/unit/test-storage.c
+++ b/unit/test-storage.c
@@ -44,12 +44,19 @@ static void test_short_encrypted_bytes(const void *data)
 
 int main(int argc, char *argv[])
 {
+	int ret;
+
 	l_test_init(&argc, &argv);
 
 	storage_init((const uint8_t *)"abc123", 6);
 
-	l_test_add("/storage/profile encryption",
+	if (l_cipher_is_supported(L_CIPHER_AES_CTR))
+		l_test_add("/storage/profile encryption",
 			test_short_encrypted_bytes, NULL);
 
-	return l_test_run();
+	ret = l_test_run();
+
+	storage_exit();
+
+	return ret;
 }
-- 
2.34.1

