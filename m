Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DBB14658D
	for <iwd@lists.linux.dev>; Tue, 19 Nov 2024 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026281; cv=none; b=VNS6koX9lXWmxZtV24XUujm7cvADXcST6zRmP0R2dwkaK2DlxMYnfj4sOijVh6skySVUiAJdw/TY9Luqnejul/C+qc/pHRfxiU+FTdtohJGYAFgdCh8J4FhViifOpV1TZiInK9M3w6R9VF/+OG/A8RZfDSVIMmZ8K2HAUGbAloA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026281; c=relaxed/simple;
	bh=4IeCTmAPtfld/FmYqeFjoJbp+QeeUZikFMRHKNou+zQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PvkwCWkFkLdD1ld/ZCOQzz/9PBfdvPqwJgI+Ij0xAOFAeQQgnZm+yGSeSRvx4ZQ25Ckcqw38187Qvso7F0U3XDoCKGL8fbdyUlPPianmN11FAIBDbFCtluBPr8L0HF8C7hvmZ8GTQ+uc+LJ+jx5xiVO7adj8m5m83Mt64WsRuz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca2eBGSD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca2eBGSD"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21263dbbbc4so2236065ad.1
        for <iwd@lists.linux.dev>; Tue, 19 Nov 2024 06:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732026279; x=1732631079; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtU52x7s4D31fi37GKm2PrginWk4pa8cpE35hMqaCRQ=;
        b=Ca2eBGSDLiRuPf7F7TwwCORFjER2WdTW02udwz0wDe/8JgW8hBCpb+W7q2p5EOMtmB
         L9WrwqzyFE/k4CZZ+/21unlbHBSqOLPZVj97kkgBMoaOkMpQ2vz2b0z/zTnP4/ByxQnk
         ZZHOrFrmgpw7F0BdP7ZEhBjZrpjVDAFlKHnmK3trDw8OktJl2/tCuPRfx7OtQLTxt3Ab
         wSkg3yu7oI1yILYMRnNoUg4ARwQ52H10DXO2jCOmqYLQh0x9V/xMMVW0Z+pOB495vRF+
         QkKHLJeuxJUflw/MpoLu9d4nCUZHH+egcMzIX20ufOBhPopAvq06BEZE2uYVkE8CfZ5D
         fQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732026279; x=1732631079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtU52x7s4D31fi37GKm2PrginWk4pa8cpE35hMqaCRQ=;
        b=pBzVFEE1+XfG1a2SnHewCW2EX2f2wqB2ZmuFp7Mty6yizvPTyG10WU7ricBm40Kic7
         SyGIlCQxU68+JNFGzuUtIuxZ/2A5PceN+dOC0knVqaN9Uf//sT88xc7z+b0pG1cHHYeQ
         +qOZQPrqaSWOcCKOlawhyzy9Z5GQQ6Gvn+x1+1ZF5gjw7rBHJVu+Sgvk5Sksf0iVUqY6
         Z+s3uvQHow7yAzTkUlwdcXgdHaFXgmKdy7jlpqy7tlyUAfEEazqEnj2EB41Q3BFsDryK
         kHfj3XbzecHIU/5xd9krRht/EnN+ARk2oizt2q8o6AgNleegIqh2KtHLPbsLHDw7AMTB
         CGXQ==
X-Gm-Message-State: AOJu0YzufWKVGq+CqqVwSkOmMbctj1m8vqcpnb//lnKBeFYHw/0vjcxi
	ouCJOmblm8NnfObUJvAPJJA0gMDGczu2XSTNktpjVcdH6ombkndTfVm+Dw==
X-Google-Smtp-Source: AGHT+IF8fAV0jXjFQUq4nI2gJr/XexbF58QbBd68H+LJwe7GZat8Kelnbi8vWv1TQKECOzhF6FxWXg==
X-Received: by 2002:a17:902:fc46:b0:211:f13e:a56d with SMTP id d9443c01a7336-211f13ea929mr182717665ad.24.1732026279159;
        Tue, 19 Nov 2024 06:24:39 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212389529b6sm29219115ad.236.2024.11.19.06.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 06:24:38 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/8] unit: add linear mapping test
Date: Tue, 19 Nov 2024 06:24:24 -0800
Message-Id: <20241119142430.323074-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142430.323074-1-prestwoj@gmail.com>
References: <20241119142430.323074-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 unit/test-util.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/unit/test-util.c b/unit/test-util.c
index 0bfd1587..214d4819 100644
--- a/unit/test-util.c
+++ b/unit/test-util.c
@@ -184,6 +184,75 @@ static void ip_prefix_test(const void *data)
 	}
 }
 
+struct linear_map_case {
+	double value;
+	double a_start;
+	double a_end;
+	double b_start;
+	double b_end;
+	double expected;
+
+	bool fails : 1;
+};
+
+struct linear_map_case cases[] = {
+	/* Value out of range */
+	{
+		.value = 100,
+		.a_start = 1,
+		.a_end = 3,
+		.b_start = 10,
+		.b_end = 12,
+		.fails = true,
+	},
+	/* Ascending start range */
+	{
+		.value = 1,
+		.a_start = 0,
+		.a_end = 2,
+		.b_start = 10,
+		.b_end = 12,
+		.expected = 11,
+	},
+	/* Descending start range */
+	{
+		.value = 1,
+		.a_start = 2,
+		.a_end = 0,
+		.b_start = 10,
+		.b_end = 12,
+		.expected = 11,
+	},
+	/* Negatives */
+	{
+		.value = -1,
+		.a_start = -2,
+		.a_end = 0,
+		.b_start = 0,
+		.b_end = 2,
+		.expected = 1,
+	},
+};
+
+static void test_linear_map(const void *data)
+{
+	double mapped;
+	unsigned int i;
+
+	for (i = 0; i < L_ARRAY_SIZE(cases); i++) {
+		struct linear_map_case *c = &cases[i];
+		bool ret = util_linear_map(c->value, c->a_start, c->a_end,
+						c->b_start, c->b_end, &mapped);
+		if (c->fails) {
+			assert(ret == false);
+			continue;
+		}
+
+		assert(ret);
+		assert(mapped == c->expected);
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	l_test_init(&argc, &argv);
@@ -192,6 +261,7 @@ int main(int argc, char *argv[])
 	l_test_add("/util/get_domain/", get_domain_test, NULL);
 	l_test_add("/util/get_username/", get_username_test, NULL);
 	l_test_add("/util/ip_prefix/", ip_prefix_test, NULL);
+	l_test_add("/util/test_linear_map", test_linear_map, NULL);
 
 	return l_test_run();
 }
-- 
2.34.1

