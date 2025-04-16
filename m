Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C05B217648
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824838; cv=none; b=HEYS0AL99OjtOgllOQbIS95VlpdM36yWqwOb5xrx/XWYZkgSEc4VIcpMStaZTJhTpJTpeOYlCJVUOrQUvoHIr/D8ENIl5rV/lBR0A56dkmOYxqCwBIw/AhM5EfxB5CqTJL5BjK52yMCP3F83/DoslyDXzLG7nmvpJt0VXIugBkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824838; c=relaxed/simple;
	bh=2Z8TRvkw90f80EiT2iTlzF46VTMPZcmWm49GpbJ6hmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gF9vV2T7IjBHNHWBG+FzSPHOaV+SizYiPEGPmAOJgjxk8fbOfpJaGGxRCuH2oHxt8rBN3T6furb83tXcGBuSlJFj3DX35aPAqkPSqUH1ms7ruKtNnP21TD4wVj1FfDoPJizv0S/BgkqWRAkwlExQbtLDbfxAMvphGa4pPGaMeU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWuh8YfP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWuh8YfP"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-225477548e1so70812955ad.0
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 10:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824836; x=1745429636; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9OKIAaTqy9rd5buBUYDES3ctTAbhthQN1ANbhLhB8Y=;
        b=PWuh8YfPS8ithsyPmWWUh/qh6zznj5Vqa4SVk439XarAT2ElwZyPDriugi22YkJ/Uv
         QmJEY1wjL/ys9y+56XgDat6iQSU8DlaNwBB3igx2cZTOQ27tQNiF9+S0qFHVLLdQ/2P4
         6BXc3i5wh/euwOyY+e8SRkFNTQRlKJfX2Ch/Kb+QJhNwuV7GXLWJOnLiZcXIkWJo6rsj
         CCwWqibsDzWEoEfEU5TOI8jD2qQ74JUcumJv7UKGVHOzC+2lSG5Ko1EbNnypoWJOCZss
         HuK2emuKRD0mYMXuROvsHjK4RZ1pCbWKeOEOyPD5VsKL6L3l4p5eWUh22jDJXEcYmDeT
         ijAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824836; x=1745429636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9OKIAaTqy9rd5buBUYDES3ctTAbhthQN1ANbhLhB8Y=;
        b=CMnV11NdNjeFuZ060fXQsYOVhA9K+QHPTI3H6dM+AVTBWKmQzJYgoQH3aTZGBSKlf1
         5Laj8eDK8Db+CKb75fzkqQoLflAb/TekpmSBe3t/WMTTfujhfpHZoHqYsDUbMdm/C3q5
         v16ewjbzWUJZayrAj+MQqYlbnlzu1DGFh6EcqAx4ZnEDRZvBzOGolMEryt55kEaJ6BTE
         QhEc1YdT65Lps9PX0zEEOHRQdfBfowneqgGdxkOk9EyRuLYUyXo2HJ8VjmfNwoDdjgQP
         HJ2QnMyahK/quFZAQ9O+tl+FvJ+IHCtcXpl1OGUWLcCJWFBFQtS9Hp8UmNQ6fZwkKxUc
         ZfTQ==
X-Gm-Message-State: AOJu0YxRN6iaZOlWdLzhVSv2X98T5PP+43KEG5FESvd/UZGKPr5nsyKK
	RDYTWBjpTWjfU1nDzRmi4QOs3cjQiowws4hO0P1hAbSetTflua90ZWNzRg==
X-Gm-Gg: ASbGncslz1dKUa/jykeWC90s6FHqXfc0FJmrJQvFMU2uu6BkJdSNsod7dnWgj4J1oG4
	MXG/RVHGVAEcn8hd+V+5hPhEbRfmEnxD3aMHZF+URqd5dZ1tNtZmbS9Hmb7112DNBzrMrugXj6T
	CD2huoQrw9pbuleKgvRAsYN1gxEY2Dfaxi/TwRQh959G3NAkJplyNKmkcHjJo81ZElKAjEbhBYT
	xrMSyEjcp7mYBZB7HPgAFWInTekppEdH3SWpM7v63TJUFq3bUnmgzcrzYuRUwqiMt0MK2SJ+i3z
	C74KS6cVcveBFBbq09gQV9wc8S0Wv8tyQ3kHGwC7UX3JzFD5lSYGepOVDMZu9w==
X-Google-Smtp-Source: AGHT+IENmBX7KewZ9xsOWY8S0Xb/KUT/2fXZcWnGRy2nwWz8uyEYPmtNaZtG9rhBd806w1EgCUt82w==
X-Received: by 2002:a17:902:ec83:b0:21f:4649:fd49 with SMTP id d9443c01a7336-22c35982438mr40400245ad.49.1744824836168;
        Wed, 16 Apr 2025 10:33:56 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1cd56sm17093055ad.83.2025.04.16.10.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:33:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/9] unit: add test for duplicate URI elements
Date: Wed, 16 Apr 2025 10:33:40 -0700
Message-Id: <20250416173345.136025-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416173345.136025-1-prestwoj@gmail.com>
References: <20250416173345.136025-1-prestwoj@gmail.com>
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

