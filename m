Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A88F6E
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806863; cv=none; b=S8CgXPSnpJUBx7kSt9gpNGp/CUVlG+V7RzlYGMjAF25gBsWICOgu7CmqCnxJLZg70HnbhttxQaOiwWxFvL835X6PNlN4DxLZzSmQ8YplvKF5W1fWY0i6CW7s+xiuENNGB03eaMLtxxV2qdAstaoF32zEAVQTcVZc8jygrhYA864=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806863; c=relaxed/simple;
	bh=2Z8TRvkw90f80EiT2iTlzF46VTMPZcmWm49GpbJ6hmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c8DALoczgNdBwTS+4DLNsc8Kkos+25f9LGry7rGqNwV48LNfHIoIMwk07ykGsfAYgeU3e44wg36AIJ1YY4hFTkK6d4OOb7MXqYVdoP1C3ObcJqRPJv5wGvG8wuSk69FkH4/0VyM2x6FdQq7vDq44G/cG8b5DlbTZkxiX8IyMENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMHzOdN2; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMHzOdN2"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so4797153b3a.2
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 05:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744806861; x=1745411661; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9OKIAaTqy9rd5buBUYDES3ctTAbhthQN1ANbhLhB8Y=;
        b=VMHzOdN2DpWFjIAIKoJlP4Q+NhhKjGFf0fX1hjGmYQCYGwzmY3e3IpGTaopfSDVoA0
         xdX8vPBiUG2lbXvOGW9/rCIc/aspaCBkYJpoA0HX8Lqah8VASS6DytkcvOT9A6vnb9Qs
         dY+K7yRNzy5yQDZYEcCD7SN/e4dyeru5JRM0LIWZHM8KQXLRKyQNUZ7+6pm6GhupeBbj
         cqpMIgsiFM/IPcsknQIDtEV/Ddg3SNKq66c1bDDLVO9oXGlrwIfZKkeEuSFnX3jLNkHX
         K281hX8eeaRIWq3JgNKW3f57Wbo4b999Ym2I/lcFFZD7F0huJ9hPFgceitgRd0hsgXF4
         tuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744806861; x=1745411661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9OKIAaTqy9rd5buBUYDES3ctTAbhthQN1ANbhLhB8Y=;
        b=U+q7LQ6+a4H+FPb61PpbItb+rwsT+sUomDC7muKYM4uKVW5rmE5XJ3PNM1AwtAFb6/
         kAlh/kP2G53FqkF9KFha5r0HEs/iQ52QbgDJY9Z+78xmqbThaqhF5P42poa0xPKEuIFr
         3Q2qHRKu2dnwc/5XyZqxGYXa+69vl7B0HSL3Z7wea5oR1u546cS9dnp4xap/ykZnVWoA
         9xh+S4sKVlvXlZnk7A3YjmodJmGul2Sqre+F6WMRny06OLxMxHzZBLbwz+tXcoGIIx9e
         drjE/HtlQPZpg1mRwyEQcE4Bfr1hmWDeRydOrEp6+s9PHTy9AilULUYu34mSgNA8eWn6
         XAVQ==
X-Gm-Message-State: AOJu0YywvZgFzp/CjfBqmKmRdkrx4oqE0qwrWZwPPy8ra9Xa4BuEfNgN
	sfQMA3zOqyO/eR2irxhXWdBtzHt0VrygyS7GWXfJ5NgLv8Uiar6chaiIPg==
X-Gm-Gg: ASbGncvqaV64zAdJsA90EPlsqIWB24zxvubvs9LHe4CF5emNQvkCQQU8amVlod2orvJ
	1abvy+fu1HbBJYbmmgBS6HyV/txNVryuSzRqtYei0Y0vV4rN0REjYv25upVEjdh1gtHBEYTGT3U
	5257Y0aFsMq0+bGTOFQ2NmLaxt5E0s8A+8F/xbtSK7/XbwAH2PjbfjiqJH6o8ze8L3lPaHcbFDT
	OLCSQq/QynYbnp0ECogrJF5U6ghVSUsoZNpn4+m64Im9aFc3JrVAw6YMdSaS2KWDjSM7cBvPuIs
	Gx3GW4iJKduGIKj3Apn462cafUfeIXAjWawAsfnRlCg3qSlrMkdlnqvNuGZ/jNmYRaQZ+XeKc+O
	3gur8hfQ9TtfLbzCX2kUiWgflqwE=
X-Google-Smtp-Source: AGHT+IFCNE+SICNC85rQzMsBmvkEBj/xqJXlE1PkgxQwh5pNj06PBPnwc1OU5rw2ix39Ob4ru/wkMw==
X-Received: by 2002:a05:6a21:8dc9:b0:1f5:6e00:14db with SMTP id adf61e73a8af0-203b3e9d9bfmr2252203637.14.1744806860636;
        Wed, 16 Apr 2025 05:34:20 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b22217ecasm1124408a12.68.2025.04.16.05.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 05:34:20 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/9] unit: add test for duplicate URI elements
Date: Wed, 16 Apr 2025 05:34:09 -0700
Message-Id: <20250416123414.114231-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416123414.114231-1-prestwoj@gmail.com>
References: <20250416123414.114231-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 unit/test-dpp.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/unit/test-dpp.c b/unit/test-dpp.c
index 70e79814..af2f5813 100644
--- a/unit/test-dpp.c
+++ b/unit/test-dpp.c
@@ -116,6 +116,29 @@ struct dpp_test_info bad_channels[] = {
 	},
 };
 
+struct dpp_test_info duplicates[] = {
+	/* Duplicate key */
+	{
+		.uri = "DPP:K:MDkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDIgADURzxmttZoIRIPWGoQMV00XHWCAQIhXruVWOz0NjlkIA=;K:MDkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDIgADURzxmttZoIRIPWGoQMV00XHWCAQIhXruVWOz0NjlkIA=;;",
+		.expect_fail = true
+	},
+	/* Duplicate frequencies*/
+	{
+		.uri = "DPP:C:81/1,115/36;C:81/1,115/36;;",
+		.expect_fail = true
+	},
+	/* Duplicate MACs*/
+	{
+		.uri = "DPP:M:5254005828e5;M:5254005828e5;;",
+		.expect_fail = true
+	},
+	/* Duplicate versions */
+	{
+		.uri = "DPP:V:2;V:2;;",
+		.expect_fail = true
+	},
+};
+
 static bool verify_info(const struct dpp_uri_info *parsed,
 			const struct dpp_test_info *result)
 {
@@ -158,6 +181,14 @@ static void test_bad_channels(const void *data)
 		test_uri_parse(&bad_channels[i]);
 }
 
+static void test_duplicate_in_uri(const void *data)
+{
+	unsigned int i;
+
+	for (i = 0; i < L_ARRAY_SIZE(duplicates); i++)
+		test_uri_parse(&duplicates[i]);
+}
+
 struct dpp_test_vector {
 	/* Initiator values */
 	const char *i_proto_public;
@@ -576,6 +607,7 @@ int main(int argc, char *argv[])
 	l_test_add("DPP URI bad key", test_uri_parse, &bad_key);
 	l_test_add("DPP URI bad channels", test_bad_channels, &bad_channels);
 	l_test_add("DPP URI unexpected ID", test_uri_parse, &unexpected_id);
+	l_test_add("DPP URI duplicates", test_duplicate_in_uri, &duplicates);
 
 	return l_test_run();
 }
-- 
2.34.1

