Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86B8BFA
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 00:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956501; cv=none; b=NLoRntviwBh+AUGV/MmNL6o0W/gqeenVld29MOFSYLImuJz8riRW1SHr41DeoiC6p0BB1+0k85Ci7K3fgREUBSf0f0QKazajWyVQHCEy/vzyCviGPv/TVuCE4PEKktJk6cU5/sExVCKun9yMoyT65rlo4Oui76SA443UtlGZBlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956501; c=relaxed/simple;
	bh=/bJVwoD1a/l1DOgdYi4ajgxDTE6dyLk1Pn0D2X66mSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MV0Sb/htoG9VNBOxg/ZKGidHZxhbiiY2H50qpupj7VxlNouwjiAdgnj/ddoSVW59P2L87Z2wUaOxZaDNOtsU48rtjwv7oLImxkeecR1Ivdo7nVPkmsyZ5w3YNbhdN7X4rwcqSq40c5x5DQ1NRNNznENhCR3YP3rIJXg4BhCgMfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPvlpI8U; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPvlpI8U"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ecd3867556so8131555ad.0
        for <iwd@lists.linux.dev>; Sun, 05 May 2024 17:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714956499; x=1715561299; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/66dZsH6jmh4n0HTCCoJR2S9p2rhXmogodRNKEcFdA=;
        b=TPvlpI8UM304ESpSnyrNbCVWiUzTdOVmgu29188zNQ0ER7X4Wogd1Xvx3FyiDPiA9x
         em3Mj88G9alsxeGWwja/DhD34VeWEH2KDAmLtTMZbJE8ujp/WppMcRs02v6duDEQn4k0
         B4KiGKIwlDMfawrCawRxAz83xiPiRsEFnFxsjywqAvPX10FF3rMrUF3/yivNQYfiG4LX
         nhu06zwbF/PHvSEvR/iqC9EGGrg1jIMQhnTRUUIeq+N50t0SUlogP+VHrUETPa05xdGF
         LOVj8fJ3nZ3gl4+BWrH0nf4tvBu85FP1lWUF0bqDEtPFFO8xQkx3cAElckwsCzd6RO6J
         rzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956499; x=1715561299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/66dZsH6jmh4n0HTCCoJR2S9p2rhXmogodRNKEcFdA=;
        b=bArc1GmsTR5sWVyG0HdkMiKXlmtxWV9ykOyI99sxHLPcW4JbO9b2nz12wxNhAvC7IO
         2yluq5m9E0CtSVjZE+fn+NAqiaHEhD4i/Aa5ZRYSWvaHDx71WqaZBB8GzLKGjtcKBIxK
         HA7geym00rGJE770pQJXwPvQWQVbfUeFKpeWeiD62+y1Bc/8TvHl21uLtzI2oTW0jbfa
         8K/jktWoeMI5mNwpx9dEefpYjM9yMZlAG+a8yGuYyBvFQETfIFz2fEV0tUeRn8YU1Nhy
         +wvT/mHTnOwqUAQ78WfHUem5HwBaJAdyZ9ku5lZtR+sJE33WiQevQPB7B9k64THlhoxI
         OPzQ==
X-Gm-Message-State: AOJu0Yw1OgKIwKxwwqyh7xkobq8KPqOnN38LWqo1aOKK9V2/bPXhZSpA
	gqkieZ5aY8Vaei9T6HAEvbM4f5V2sOcmd80x9HhQzPHVLl4Lf5sR0hUpNA==
X-Google-Smtp-Source: AGHT+IHYt5gw3Q+K+yEPCPTqFfTECMfIC3I0HYJZbmP9rhyOnOSfO85qZS5Dg6eeiBLEEwrFziw3qQ==
X-Received: by 2002:a17:903:48f:b0:1e4:4a3f:9a88 with SMTP id jj15-20020a170903048f00b001e44a3f9a88mr6836714plb.46.1714956499047;
        Sun, 05 May 2024 17:48:19 -0700 (PDT)
Received: from localhost ([192.145.118.41])
        by smtp.gmail.com with ESMTPSA id jw19-20020a170903279300b001eab3ba8ccfsm6997973plb.285.2024.05.05.17.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:48:18 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH v2 03/18] unit: fix SAE unit tests
Date: Sun,  5 May 2024 17:30:26 -0700
Message-ID: <20240506003518.320176-4-brandtwjohn@gmail.com>
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

Don't mark either client as being the authenticator. In the current unit
tests, both instances act as clients to test functionality. This ensures
the unit does not show an error during the following commits where SAE
for AP mode is added.
---
 unit/test-sae.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/unit/test-sae.c b/unit/test-sae.c
index d9ec6b31..04783d18 100644
--- a/unit/test-sae.c
+++ b/unit/test-sae.c
@@ -421,7 +421,6 @@ static void test_bad_confirm(const void *arg)
 	handshake_state_set_supplicant_address(hs2, aa);
 	handshake_state_set_authenticator_address(hs2, spa);
 	handshake_state_set_passphrase(hs2, passphrase);
-	handshake_state_set_authenticator(hs2, true);
 
 	ap1 = sae_sm_new(hs1, end_to_end_tx_func, test_tx_assoc_func, td1);
 	ap2 = sae_sm_new(hs2, end_to_end_tx_func, test_tx_assoc_func, td2);
@@ -496,7 +495,6 @@ static void test_confirm_after_accept(const void *arg)
 	handshake_state_set_supplicant_address(hs2, aa);
 	handshake_state_set_authenticator_address(hs2, spa);
 	handshake_state_set_passphrase(hs2, passphrase);
-	handshake_state_set_authenticator(hs2, true);
 
 	ap1 = sae_sm_new(hs1, end_to_end_tx_func, test_tx_assoc_func, td1);
 	ap2 = sae_sm_new(hs2, end_to_end_tx_func, test_tx_assoc_func, td2);
@@ -581,7 +579,6 @@ static void test_end_to_end(const void *arg)
 	handshake_state_set_supplicant_address(hs2, aa);
 	handshake_state_set_authenticator_address(hs2, spa);
 	handshake_state_set_passphrase(hs2, passphrase);
-	handshake_state_set_authenticator(hs2, true);
 
 	ap1 = sae_sm_new(hs1, end_to_end_tx_func, test_tx_assoc_func, td1);
 	ap2 = sae_sm_new(hs2, end_to_end_tx_func, test_tx_assoc_func, td2);
-- 
2.45.0

