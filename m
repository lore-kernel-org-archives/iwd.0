Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEA61DF976
	for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288563; cv=none; b=iCOcEX9sroAbOM+awPkBf53b6LdtCW/q2kxD49dzYJRZXTgPuuVOKqS5T+EEEM4TXCBJNohtO6v1ynTN/9bUgqVjq8w0Q7403a4LCJpy9u098M4YbPe44E6P9X9EOFF39JJkzJSFEjt0llvZFfrvssT+Tilj61BGSrZazSlDNqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288563; c=relaxed/simple;
	bh=230tCrv6eS/YKazBZPgfJnsYDXGXQokhPPwmyy0C2r0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AmcBcOCXUpTAN0po8j3TnZUJtcH47p94ynelcWc213Vtehx4zO1wNkf5O/um1TtnCJ3QmdTcmueAwrV8xPYcwH1K+XCDaAgA2wwNzH77nGC7COwk9hjpMlM7LCUsBvNGMHz4c3XOt7n6kdap+vs6gIO85oQQfwkokJGvuqLBXL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDLkMFWJ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDLkMFWJ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso1573465a12.3
        for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 07:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732288560; x=1732893360; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAgHWR+yJqfwD2qesQmtXh6fgB90YeAcv/lCztwTggw=;
        b=IDLkMFWJETXtOk8dfSBN1dgLDqYMW10Uz+KiTBL4Ql5vw/axoQ7dDs4VxGufZGQZQN
         e6RRbhRCh4dnmLs2Wj6k8SgDLqgEkUwhfPPrjLcGSrIUNBvw2aUl6rBl+wF4h65yqFqa
         500K2+O7iz5v4juUJpvh1hvAsUT8DVN6TEJFd5H8iqZoJV+k8D7MFHHHvpYIQy26qftZ
         0tq/cpZ13sfm0qEqK57T3X1hh0RB7SnArpO6odgJPV+6ESHdbvefNHr6J8xL+OsEELqO
         WsgQlaf7PbZxEmt4+9WcLbgKx4uoGsRfQavJFIz/Vu35NnEkXqKaBTBf0Uhb+eMWFQBm
         ovfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288560; x=1732893360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAgHWR+yJqfwD2qesQmtXh6fgB90YeAcv/lCztwTggw=;
        b=SCih/pDiU5HSgqF3xpRX6BBtCEkDm7EyK1RTAij/XICDwWkEobTtFwcMtuYt/gffjA
         w4oxgSjF6RlFnth7lIouAAq4NiaEWbAbs2MH8DvK2rmgdLT5b8WEGPUO+1KYvs8+3ZrD
         weDCXUevtIYOjZwCQJBlb3GWwXFHSqh++SXfiNckloIytS6Dd+TuBHKsnlWfwYQSJj6i
         D6eA6Lv2RV9/7RwQ38YF4mMjdaVodxMhthBZKvkGBeF79LQJc34CD8a2IwLF9mt9+bhj
         OaKQuZ51rC8Y61b7oEWKO5FimAKOq6nSQ0xL/H73oV2WjtdqAeEavJXuS0nELLXZe5BO
         YebA==
X-Gm-Message-State: AOJu0YxobSLJo4o/t4z27OdunBO4FkOoLGmn6pIawk+6RG+R+pnAXKsn
	EOxC6qwVrRINUAnm8MRYDHXZFpyrKZwvq3lkxiF52PP8MG4g6sqEvsT+HQ==
X-Gm-Gg: ASbGncuYYZOQA53zVDiBrgFxeWdXo7wcxvya4TU3R6ahq9ALiCPYTfG3xRGk/EXtcY9
	7gvSvbWZB+UPwFH78i4qgmSVXLBovAUbmBe6ijmIUPhaH8x3kL3iENce8dX17E9aNHlyVLYV3fm
	qYF7YRAsZgX2CBUmPY7HxRHtavUn+gQ563IyfdmqIzklcM71EDHHrm9RwUP0UDixsnQ6QxsNGrH
	FO2wnAhcgoP3fGTAL10s34CLFznvWarpgVTXk8PjDQJCZFMi5aBsjf2Kg+g
X-Google-Smtp-Source: AGHT+IH/ue5LLjXgmtDujGDJLEH1X5jYObbw8R7TtqnbYaoUKW7jfcB0vhfaV78pqONedV1SGXYeYA==
X-Received: by 2002:a05:6a21:3399:b0:1d9:78c:dcf2 with SMTP id adf61e73a8af0-1e09e5ff718mr3898615637.43.1732288559981;
        Fri, 22 Nov 2024 07:15:59 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a9a720sm10722706d6.50.2024.11.22.07.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:15:59 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 02/15] unit: update use of handshake_state with ref/unref
Date: Fri, 22 Nov 2024 07:15:38 -0800
Message-Id: <20241122151551.286355-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122151551.286355-1-prestwoj@gmail.com>
References: <20241122151551.286355-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 unit/test-eapol.c | 38 +++++++++++++++++++++-----------------
 unit/test-sae.c   | 15 ++++++++-------
 unit/test-wsc.c   | 10 ++++++----
 3 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index 5317f9ad..0e01bfa5 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -94,6 +94,7 @@ static struct handshake_state *test_handshake_state_new(uint32_t ifindex)
 
 	ths->super.ifindex = ifindex;
 	ths->super.free = test_handshake_state_free;
+	ths->super.refcount = 1;
 
 	return &ths->super;
 }
@@ -2199,7 +2200,7 @@ static void eapol_sm_test_ptk(const void *data)
 	assert(verify_step4_called);
 
 	eapol_sm_free(sm);
-	handshake_state_free(hs);
+	handshake_state_unref(hs);
 	eapol_exit();
 }
 
@@ -2263,7 +2264,7 @@ static void eapol_sm_test_igtk(const void *data)
 	assert(verify_step4_called);
 
 	eapol_sm_free(sm);
-	handshake_state_free(hs);
+	handshake_state_unref(hs);
 	eapol_exit();
 }
 
@@ -2332,7 +2333,7 @@ static void eapol_sm_test_wpa2_ptk_gtk(const void *data)
 	assert(verify_gtk_step2_called);
 
 	eapol_sm_free(sm);
-	handshake_state_free(hs);
+	handshake_state_unref(hs);
 	eapol_exit();
 }
 
@@ -2399,7 +2400,7 @@ static void eapol_sm_test_wpa_ptk_gtk(const void *data)
 	assert(verify_gtk_step2_called);
 
 	eapol_sm_free(sm);
-	handshake_state_free(hs);
+	handshake_state_unref(hs);
 	eapol_exit();
 }
 
@@ -2467,7 +2468,7 @@ static void eapol_sm_test_wpa_ptk_gtk_2(const void *data)
 	assert(verify_gtk_step2_called);
 
 	eapol_sm_free(sm);
-	handshake_state_free(hs);
+	handshake_state_unref(hs);
 	eapol_exit();
 }
 
@@ -2721,7 +2722,7 @@ static void eapol_sm_wpa2_retransmit_test(const void *data)
 	l_free(ptk);
 
 	eapol_sm_free(sm);
-	handshake_state_free(hs);
+	handshake_state_unref(hs);
 	eapol_exit();
 }
 
@@ -3141,7 +3142,7 @@ done:
 	if (sm)
 		eapol_sm_free(sm);
 
-	handshake_state_free(hs);
+	handshake_state_unref(hs);
 	eapol_exit();
 	eap_exit();
 }
@@ -3424,7 +3425,7 @@ static void eapol_sm_test_eap_nak(const void *data)
 				sizeof(eap_failure), false);
 	assert(ths->handshake_failed);
 
-	handshake_state_free(hs);
+	handshake_state_unref(hs);
 	eapol_exit();
 	eap_exit();
 }
@@ -3510,7 +3511,7 @@ static void eapol_ft_handshake_test(const void *data)
 	assert(verify_step4_called);
 
 	eapol_sm_free(sm);
-	handshake_state_free(hs);
+	handshake_state_unref(hs);
 	eapol_exit();
 }
 
@@ -3609,6 +3610,7 @@ static struct handshake_state *test_ap_sta_hs_new(struct test_ap_sta_data *s,
 
 	ths->super.ifindex = ifindex;
 	ths->super.free = (void (*)(struct handshake_state *s)) l_free;
+	ths->super.refcount = 1;
 	ths->s = s;
 
 	return &ths->super;
@@ -3692,8 +3694,10 @@ static void eapol_ap_sta_handshake_test(const void *data)
 
 	test_ap_sta_run(&s);
 
-	handshake_state_free(s.ap_hs);
-	handshake_state_free(s.sta_hs);
+	l_info("freeing in eapol_ap_sta_handshake_test()");
+
+	handshake_state_unref(s.ap_hs);
+	handshake_state_unref(s.sta_hs);
 	__handshake_set_install_tk_func(NULL);
 
 	assert(s.ap_success && s.sta_success);
@@ -3753,8 +3757,8 @@ static void eapol_ap_sta_handshake_bad_psk_test(const void *data)
 
 	test_ap_sta_run(&s);
 
-	handshake_state_free(s.ap_hs);
-	handshake_state_free(s.sta_hs);
+	handshake_state_unref(s.ap_hs);
+	handshake_state_unref(s.sta_hs);
 	__handshake_set_install_tk_func(NULL);
 
 	/*
@@ -3825,8 +3829,8 @@ static void eapol_ap_sta_handshake_ip_alloc_ok_test(const void *data)
 	assert(s.sta_hs->subnet_mask == s.ap_hs->subnet_mask);
 	assert(s.sta_hs->go_ip_addr == s.ap_hs->go_ip_addr);
 
-	handshake_state_free(s.ap_hs);
-	handshake_state_free(s.sta_hs);
+	handshake_state_unref(s.ap_hs);
+	handshake_state_unref(s.sta_hs);
 	__handshake_set_install_tk_func(NULL);
 
 	assert(s.ap_success && s.sta_success);
@@ -3889,8 +3893,8 @@ static void eapol_ap_sta_handshake_ip_alloc_no_req_test(const void *data)
 	assert(!s.ap_hs->support_ip_allocation);
 	assert(!s.sta_hs->support_ip_allocation);
 
-	handshake_state_free(s.ap_hs);
-	handshake_state_free(s.sta_hs);
+	handshake_state_unref(s.ap_hs);
+	handshake_state_unref(s.sta_hs);
 	__handshake_set_install_tk_func(NULL);
 
 	assert(s.ap_success && s.sta_success);
diff --git a/unit/test-sae.c b/unit/test-sae.c
index 04783d18..2e564133 100644
--- a/unit/test-sae.c
+++ b/unit/test-sae.c
@@ -101,6 +101,7 @@ static struct handshake_state *test_handshake_state_new(uint32_t ifindex)
 
 	ths->super.ifindex = ifindex;
 	ths->super.free = test_handshake_state_free;
+	ths->super.refcount = 1;
 
 	return &ths->super;
 }
@@ -183,7 +184,7 @@ static struct auth_proto *test_initialize(struct test_data *td)
 
 static void test_destruct(struct test_data *td)
 {
-	handshake_state_free(td->handshake);
+	handshake_state_unref(td->handshake);
 	l_free(td);
 }
 
@@ -459,8 +460,8 @@ static void test_bad_confirm(const void *arg)
 	assert(td1->tx_assoc_called);
 	assert(td2->status != 0);
 
-	handshake_state_free(hs1);
-	handshake_state_free(hs2);
+	handshake_state_unref(hs1);
+	handshake_state_unref(hs2);
 
 	ap1->free(ap1);
 	ap2->free(ap2);
@@ -544,8 +545,8 @@ static void test_confirm_after_accept(const void *arg)
 	assert(auth_proto_rx_associate(ap1, (uint8_t *)assoc, frame_len) == 0);
 	assert(auth_proto_rx_associate(ap2, (uint8_t *)assoc, frame_len) == 0);
 
-	handshake_state_free(hs1);
-	handshake_state_free(hs2);
+	handshake_state_unref(hs1);
+	handshake_state_unref(hs2);
 
 	auth_proto_free(ap1);
 	auth_proto_free(ap2);
@@ -621,8 +622,8 @@ static void test_end_to_end(const void *arg)
 	assert(auth_proto_rx_associate(ap1, (uint8_t *)assoc, frame_len) == 0);
 	assert(auth_proto_rx_associate(ap2, (uint8_t *)assoc, frame_len) == 0);
 
-	handshake_state_free(hs1);
-	handshake_state_free(hs2);
+	handshake_state_unref(hs1);
+	handshake_state_unref(hs2);
 
 	auth_proto_free(ap1);
 	auth_proto_free(ap2);
diff --git a/unit/test-wsc.c b/unit/test-wsc.c
index 8b130f45..8022ebf6 100644
--- a/unit/test-wsc.c
+++ b/unit/test-wsc.c
@@ -61,6 +61,7 @@ static struct handshake_state *test_handshake_state_new(uint32_t ifindex)
 
 	ths->super.ifindex = ifindex;
 	ths->super.free = test_handshake_state_free;
+	ths->super.refcount = 1;
 
 	return &ths->super;
 }
@@ -2093,7 +2094,7 @@ static void wsc_test_pbc_handshake(const void *data)
 					eap_fail, sizeof(eap_fail), false);
 	assert(verify.eapol_failed);
 
-	handshake_state_free(hs);
+	handshake_state_unref(hs);
 	eapol_exit();
 	eap_exit();
 }
@@ -2216,7 +2217,7 @@ static void wsc_test_retransmission_no_fragmentation(const void *data)
 						sizeof(eap_fail), false);
 	assert(verify.eapol_failed);
 
-	handshake_state_free(hs);
+	handshake_state_unref(hs);
 	eapol_exit();
 	eap_exit();
 }
@@ -2335,6 +2336,7 @@ static struct handshake_state *test_ap_sta_hs_new(struct test_ap_sta_data *s,
 
 	ths->super.ifindex = ifindex;
 	ths->super.free = (void (*)(struct handshake_state *s)) l_free;
+	ths->super.refcount = 1;
 	ths->s = s;
 
 	return &ths->super;
@@ -2535,8 +2537,8 @@ static void wsc_r_test_pbc_handshake(const void *data)
 
 	test_ap_sta_run(&s);
 
-	handshake_state_free(s.ap_hs);
-	handshake_state_free(s.sta_hs);
+	handshake_state_unref(s.ap_hs);
+	handshake_state_unref(s.sta_hs);
 	__handshake_set_install_tk_func(NULL);
 	l_settings_free(ap_8021x_settings);
 	l_settings_free(sta_8021x_settings);
-- 
2.34.1

