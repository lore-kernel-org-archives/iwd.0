Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD81DFF9
	for <iwd@lists.linux.dev>; Tue, 10 Oct 2023 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRZ9oL3i"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6969b391791so3891597b3a.3
        for <iwd@lists.linux.dev>; Tue, 10 Oct 2023 06:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696946227; x=1697551027; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wAUKOgvBnpbBryReM6CcnlI004rnlikb7s2SqBaWOt0=;
        b=CRZ9oL3iUQZIlot2ZJOQgEh6OFQ6rc5RyLl/8Z2knPT3syfxP74XtiBTQKvwjpggUm
         1/to17EVX/AuaYCc/edwYFrQHJDPd1ZWy/xyrzGS3uMXOogDT1RPIy3pvF3r6v72mA15
         sZHYfnhoPsmqujr7x20Ek8Xy+WNnWbTAxT+Bxw2rAH7loypUH0ji9JKv8YPkPup7H31O
         qLF7J8vx7yIxLAMPXA3rnrlYW6gxUtmqcUgNNvuQGz9edvdbnxZKTfco78IIYqprytox
         Mg8QPK/4pZRIw6BAK3YuYXwiWrsQlvZ2Tc+L2KfWByDsH81pIG1Kvbsn+QchUw02LfB7
         eVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696946227; x=1697551027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wAUKOgvBnpbBryReM6CcnlI004rnlikb7s2SqBaWOt0=;
        b=aRpE0wA+gmfgDeQiG9mHMeJMw+N5Ir5GEnY/ITAnUC53Va+prJwF4ZBQcZmTiw6tUI
         5zlbW4SOsyYJeoHUR0pOySs1a921itZyzkKakPo/dTAe1ILMAu2CxzaW2KW6rO6hpvWy
         6Sc4TiHL6n6rVeRvFYnzCnU3rID4EqlkcdUJhtBCozxRWTL/XnnzmRpVp9u6z9pDW8MS
         /aMPi7o59CZNnXWlwoPaReg7YlUerCM/ArbLdZjFkRPmgQoIO/NQjXrpR3U4AXfRTxYc
         4F7EyuWS+dXJHPnJBYYYtNoguzNjMIj2bP3q7ma2G8iRYjED5wKI05fkJOS8rNjosMaV
         F3ig==
X-Gm-Message-State: AOJu0YxeiM3cXQ+vbu6zwI7S3AALyfruzdT41Z+Jx95wtds44C3h3aoA
	KDGsdT8orRS0Swz2h1LBnU8f3TNFg/A=
X-Google-Smtp-Source: AGHT+IHbfslHodaOsiID4bOPm7LNzC6Jx8vGBAK4rjMUiWEgd7xNpV5cZMwN5PsKcDgg4g6i3MxEsA==
X-Received: by 2002:a05:6a20:1584:b0:155:2359:e28c with SMTP id h4-20020a056a20158400b001552359e28cmr19198886pzj.9.1696946227337;
        Tue, 10 Oct 2023 06:57:07 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id b10-20020a170903228a00b001b03a1a3151sm11830364plh.70.2023.10.10.06.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 06:57:07 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] unit: add to test-dpp to expose ASN1 point conversion bug
Date: Tue, 10 Oct 2023 06:57:01 -0700
Message-Id: <20231010135704.198723-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test to show the incorrect ASN1 conversion to and from points.
This was due to the check if Y is odd/even being inverted which
incorrectly prefixes the X coordinate with the wrong byte.

The test itself was not fully correct because it was using compliant
points rather than full points, and the spec contains the entire
Y coordinate so the full point should be used.

This patch also adds ASN1 conversions to validate that
dpp_point_from_asn1 and dpp_point_to_asn1 work properly.
---
 unit/test-dpp.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/unit/test-dpp.c b/unit/test-dpp.c
index 96175759..c782efba 100644
--- a/unit/test-dpp.c
+++ b/unit/test-dpp.c
@@ -162,11 +162,14 @@ static void test_bad_channels(const void *data)
  * B.2 Test Vectors for DPP Authentication Using P-256 for
  * Responder-only Authentication
  */
-const char *i_proto_public_bytes = "50a532ae2a07207276418d2fa630295d45569be425aa634f02014d00a7d1f61a";
-const char *r_boot_public_bytes = "09c585a91b4df9fd25a045201885c39cc5cfae397ddaeda957dec57fa0e3503f";
+const char *i_proto_public_bytes = "50a532ae2a07207276418d2fa630295d45569be425aa634f02014d00a7d1f61a"
+				"e14f35a5a858bccad90d126c46594c49ef82655e78888e15a32d916ac2172491";
+const char *r_boot_public_bytes = "09c585a91b4df9fd25a045201885c39cc5cfae397ddaeda957dec57fa0e3503f"
+				"52bf05968198a2f92883e96a386d767579883302dbf292105c90a43694c2fd5c";
 const char *r_boot_private_bytes = "54ce181a98525f217216f59b245f60e9df30ac7f6b26c939418cfc3c42d1afa0";
 const char *r_proto_private_bytes = "f798ed2e19286f6a6efe210b1863badb99af2a14b497634dbfd2a97394fb5aa5";
-const char *r_proto_public_bytes = "5e3fb3576884887f17c3203d8a3a6c2fac722ef0e2201b61ac73bc655c709a90";
+const char *r_proto_public_bytes = "5e3fb3576884887f17c3203d8a3a6c2fac722ef0e2201b61ac73bc655c709a90"
+				"2d4b030669fb9eff8b0a79fa7c1a172ac2a92c626256963f9274dc90682c81e5";
 const char *k1_bytes = "3d832a02ed6d7fc1dc96d2eceab738cf01c0028eb256be33d5a21a720bfcf949";
 const char *k2_bytes = "ca08bdeeef838ddf897a5f01f20bb93dc5a895cb86788ca8c00a7664899bc310";
 const char *ke_bytes = "c8882a8ab30c878467822534138c704ede0ab1e873fe03b601a7908463fec87a";
@@ -176,6 +179,8 @@ const char *i_nonce_bytes = "13f4602a16daeb69712263b9c46cba31";
 const char *r_nonce_bytes = "3d0cfb011ca916d796f7029ff0b43393";
 const char *i_auth_bytes = "787d1189b526448d2901e7f6c22775ce514fce52fc886c1e924f2fbb8d97b210";
 const char *r_auth_bytes = "43509ef7137d8c2fbe66d802ae09dedd94d41b8cbfafb4954782014ff4a3f91c";
+const char *r_asn1 = "3039301306072a8648ce3d020106082a8648ce3d0301070322000209c585a91b"
+			"4df9fd25a045201885c39cc5cfae397ddaeda957dec57fa0e3503f";
 
 #define HEX2BUF(s, buf, _len) { \
 	unsigned char *_tmp = l_util_from_hexstring(s, NULL); \
@@ -192,7 +197,7 @@ const char *r_auth_bytes = "43509ef7137d8c2fbe66d802ae09dedd94d41b8cbfafb4954782
 
 static void test_key_derivation(const void *data)
 {
-	uint64_t tmp[L_ECC_MAX_DIGITS];
+	uint64_t tmp[L_ECC_MAX_DIGITS * 2];
 	const struct l_ecc_curve *curve = l_ecc_curve_from_ike_group(19);
 	_auto_(l_ecc_point_free) struct l_ecc_point *i_proto_public = NULL;
 	_auto_(l_ecc_point_free) struct l_ecc_point *r_boot_public = NULL;
@@ -201,6 +206,7 @@ static void test_key_derivation(const void *data)
 	_auto_(l_ecc_point_free) struct l_ecc_point *r_proto_public = NULL;
 	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *m = NULL;
 	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *n = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *from_asn1 = NULL;
 	uint64_t k1[L_ECC_MAX_DIGITS];
 	uint64_t k2[L_ECC_MAX_DIGITS];
 	uint64_t ke[L_ECC_MAX_DIGITS];
@@ -208,23 +214,35 @@ static void test_key_derivation(const void *data)
 	uint8_t r_nonce[16];
 	uint64_t r_auth[L_ECC_MAX_DIGITS];
 	uint64_t i_auth[L_ECC_MAX_DIGITS];
+	_auto_(l_free) uint8_t *asn1 = NULL;
+	size_t asn1_len;
 
-	HEX2BUF(i_proto_public_bytes, tmp, 32);
+	HEX2BUF(i_proto_public_bytes, tmp, 64);
 	i_proto_public = l_ecc_point_from_data(curve,
-						L_ECC_POINT_TYPE_COMPLIANT,
-						tmp, 32);
+						L_ECC_POINT_TYPE_FULL,
+						tmp, 64);
 	assert(i_proto_public);
 
-	HEX2BUF(r_boot_public_bytes, tmp, 32);
+	HEX2BUF(r_boot_public_bytes, tmp, 64);
 	r_boot_public = l_ecc_point_from_data(curve,
-						L_ECC_POINT_TYPE_COMPLIANT,
-						tmp, 32);
+						L_ECC_POINT_TYPE_FULL,
+						tmp, 64);
 	assert(r_boot_public);
 
-	HEX2BUF(r_proto_public_bytes, tmp, 32);
+	HEX2BUF(r_asn1, tmp, sizeof(tmp));
+	asn1 = dpp_point_to_asn1(r_boot_public, &asn1_len);
+
+	from_asn1 = dpp_point_from_asn1(asn1, asn1_len);
+
+	assert(l_ecc_points_are_equal(from_asn1, r_boot_public));
+
+	assert(asn1_len == 59);
+	assert(memcmp(tmp, asn1, asn1_len) == 0);
+
+	HEX2BUF(r_proto_public_bytes, tmp, 64);
 	r_proto_public = l_ecc_point_from_data(curve,
-						L_ECC_POINT_TYPE_COMPLIANT,
-						tmp, 32);
+						L_ECC_POINT_TYPE_FULL,
+						tmp, 64);
 	assert(r_proto_public);
 
 	HEX2BUF(r_boot_private_bytes, tmp, 32);
-- 
2.25.1

