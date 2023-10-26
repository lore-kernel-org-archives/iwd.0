Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B54B156CE
	for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joUGmER9"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-77774120c6eso99328185a.2
        for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 13:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698352038; x=1698956838; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dC23NXL4BiynuBhMKrtU8WsgzA1WeIIudl3YwLneMEs=;
        b=joUGmER9RniOOeKAU899BGSb6PFK3PfRUw4RLxZ7LS+1Bqh67ahq81ZPjqWdXT+/nr
         al9xuQMPNY/S1wJ0FzYianQ5pfPY5NfitSGw0lAKNNQBVlkJA0JPI0yOnCUqbR+LDons
         REDa4bITo9EK1z8mAgkezQZJlnA1L9hw638ofrPqOlAo7bTn6ybpRXnZAM+izt1U/fEI
         HD0PtJsgA0+pNeVNlHkuWFW8yMiLgYTLxRSNrDBoY3urZ+wDi+rw61u3k38dvTCThHt8
         /Ejf9kq8E5QyN+O2oIGfRy2v/8i6InO68P3LoiOPBQ2JkUX/79PzEqpER/II5I8+RifJ
         eStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698352038; x=1698956838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dC23NXL4BiynuBhMKrtU8WsgzA1WeIIudl3YwLneMEs=;
        b=WeG/4ULoVskBNFopOmuVJlQKURfjM4UbTcPyphfZYaNHNMR90iAsI5eLBTRj7gmlau
         PG+0tId4V48/k+KT6XoAw81a/ttM6AVKDBY4aTHKAFIVcapHCXnWQrfyK7+1MG+CJ776
         4s3ccMH1SJR/kDUCzM3MxwDANE29xzo3hhGdn6uIL/J2wAx2zq8C+5LEvUgi0zZIu7yM
         Zjr+ECYvlnBdxXHN7gNmR7mPkX3bNh2kTFFVstyexMUbfNxpr+4KamdtPv6cCGo5h9uc
         y/76HNQinExccK/7ctadxvCpi0QGm4Qw4HGzETeEEswHdvO5//MvvOu8f+0Hd7egx2H1
         KDTg==
X-Gm-Message-State: AOJu0YywkZ4l0Hi46mkC7DCCn4qbRsu6KfZHGa8y/ZPfLNTbYFgxjyj8
	11JUyUL0DK7+mKJYGXv7fHdCEKJSCvU=
X-Google-Smtp-Source: AGHT+IHnV6rPGThyrZDpzq6TX87XlB1Ga0FetpKHaD60pqi9gHTWa+33QBjvGEHmmUg2YY5Nn/l6BA==
X-Received: by 2002:a05:620a:2890:b0:778:9be8:276c with SMTP id j16-20020a05620a289000b007789be8276cmr491977qkp.37.1698352037960;
        Thu, 26 Oct 2023 13:27:17 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id r4-20020a05620a298400b007742c2ad7dfsm7303qkp.73.2023.10.26.13.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:27:17 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 08/15] unit: make test-dpp key derivation test more extendable
Date: Thu, 26 Oct 2023 13:26:50 -0700
Message-Id: <20231026202657.183591-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026202657.183591-1-prestwoj@gmail.com>
References: <20231026202657.183591-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a new structure to hold key values so they can be changed for
different test vectors while using the same test function.
---
 unit/test-dpp.c | 104 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 36 deletions(-)

diff --git a/unit/test-dpp.c b/unit/test-dpp.c
index c3f3731f..0cf60f0a 100644
--- a/unit/test-dpp.c
+++ b/unit/test-dpp.c
@@ -158,29 +158,59 @@ static void test_bad_channels(const void *data)
 		test_uri_parse(&bad_channels[i]);
 }
 
+struct dpp_test_vector {
+	/* Initiator values */
+	const char *i_proto_public;
+	const char *i_proto_private;
+	const char *i_boot_public;
+	const char *i_boot_private;
+	const char *i_nonce;
+	const char *i_auth;
+	const char *i_asn1;
+
+	/* Responder values */
+	const char *r_proto_public;
+	const char *r_proto_private;
+	const char *r_boot_public;
+	const char *r_boot_private;
+	const char *r_nonce;
+	const char *r_auth;
+	const char *r_asn1;
+
+	const char *k1;
+	const char *k2;
+	const char *ke;
+	const char *mx;
+	const char *nx;
+};
+
 /*
  * B.2 Test Vectors for DPP Authentication Using P-256 for
  * Responder-only Authentication
  */
-const char *i_proto_public_bytes = "50a532ae2a07207276418d2fa630295d45569be425aa634f02014d00a7d1f61a"
-				"e14f35a5a858bccad90d126c46594c49ef82655e78888e15a32d916ac2172491";
-const char *r_boot_public_bytes = "09c585a91b4df9fd25a045201885c39cc5cfae397ddaeda957dec57fa0e3503f"
-				"52bf05968198a2f92883e96a386d767579883302dbf292105c90a43694c2fd5c";
-const char *r_boot_private_bytes = "54ce181a98525f217216f59b245f60e9df30ac7f6b26c939418cfc3c42d1afa0";
-const char *r_proto_private_bytes = "f798ed2e19286f6a6efe210b1863badb99af2a14b497634dbfd2a97394fb5aa5";
-const char *r_proto_public_bytes = "5e3fb3576884887f17c3203d8a3a6c2fac722ef0e2201b61ac73bc655c709a90"
-				"2d4b030669fb9eff8b0a79fa7c1a172ac2a92c626256963f9274dc90682c81e5";
-const char *k1_bytes = "3d832a02ed6d7fc1dc96d2eceab738cf01c0028eb256be33d5a21a720bfcf949";
-const char *k2_bytes = "ca08bdeeef838ddf897a5f01f20bb93dc5a895cb86788ca8c00a7664899bc310";
-const char *ke_bytes = "c8882a8ab30c878467822534138c704ede0ab1e873fe03b601a7908463fec87a";
-const char *mx_bytes = "dde2878117d69745be4f916a2dd14269d783d1d788c603bb8746beabbd1dbbbc";
-const char *nx_bytes = "92118478b75c21c2c59340c842b5bce560a535f60bc37a75fe390d738c58d8e8";
-const char *i_nonce_bytes = "13f4602a16daeb69712263b9c46cba31";
-const char *r_nonce_bytes = "3d0cfb011ca916d796f7029ff0b43393";
-const char *i_auth_bytes = "787d1189b526448d2901e7f6c22775ce514fce52fc886c1e924f2fbb8d97b210";
-const char *r_auth_bytes = "43509ef7137d8c2fbe66d802ae09dedd94d41b8cbfafb4954782014ff4a3f91c";
-const char *r_asn1 = "3039301306072a8648ce3d020106082a8648ce3d0301070322000209c585a91b"
-			"4df9fd25a045201885c39cc5cfae397ddaeda957dec57fa0e3503f";
+static struct dpp_test_vector responder_only_p256 = {
+	.i_proto_public = "50a532ae2a07207276418d2fa630295d45569be425aa634f02014d00a7d1f61a"
+			"e14f35a5a858bccad90d126c46594c49ef82655e78888e15a32d916ac2172491",
+	.i_nonce = "13f4602a16daeb69712263b9c46cba31",
+	.i_auth = "787d1189b526448d2901e7f6c22775ce514fce52fc886c1e924f2fbb8d97b210",
+
+	.r_proto_public = "5e3fb3576884887f17c3203d8a3a6c2fac722ef0e2201b61ac73bc655c709a90"
+			"2d4b030669fb9eff8b0a79fa7c1a172ac2a92c626256963f9274dc90682c81e5",
+	.r_proto_private = "f798ed2e19286f6a6efe210b1863badb99af2a14b497634dbfd2a97394fb5aa5",
+	.r_boot_public = "09c585a91b4df9fd25a045201885c39cc5cfae397ddaeda957dec57fa0e3503f"
+			"52bf05968198a2f92883e96a386d767579883302dbf292105c90a43694c2fd5c",
+	.r_boot_private = "54ce181a98525f217216f59b245f60e9df30ac7f6b26c939418cfc3c42d1afa0",
+	.r_nonce = "3d0cfb011ca916d796f7029ff0b43393",
+	.r_auth = "43509ef7137d8c2fbe66d802ae09dedd94d41b8cbfafb4954782014ff4a3f91c",
+	.r_asn1 = "3039301306072a8648ce3d020106082a8648ce3d0301070322000209c585a91b"
+			"4df9fd25a045201885c39cc5cfae397ddaeda957dec57fa0e3503f",
+
+	.k1 = "3d832a02ed6d7fc1dc96d2eceab738cf01c0028eb256be33d5a21a720bfcf949",
+	.k2 = "ca08bdeeef838ddf897a5f01f20bb93dc5a895cb86788ca8c00a7664899bc310",
+	.ke = "c8882a8ab30c878467822534138c704ede0ab1e873fe03b601a7908463fec87a",
+	.mx = "dde2878117d69745be4f916a2dd14269d783d1d788c603bb8746beabbd1dbbbc",
+	.nx = "92118478b75c21c2c59340c842b5bce560a535f60bc37a75fe390d738c58d8e8",
+};
 
 #define HEX2BUF(s, buf, _len) { \
 	size_t _len_out; \
@@ -198,6 +228,8 @@ const char *r_asn1 = "3039301306072a8648ce3d020106082a8648ce3d0301070322000209c5
 
 static void test_key_derivation(const void *data)
 {
+	const struct dpp_test_vector *vector = data;
+
 	uint64_t tmp[L_ECC_MAX_DIGITS * 2];
 	const struct l_ecc_curve *curve = l_ecc_curve_from_ike_group(19);
 	_auto_(l_ecc_point_free) struct l_ecc_point *i_proto_public = NULL;
@@ -218,19 +250,19 @@ static void test_key_derivation(const void *data)
 	_auto_(l_free) uint8_t *asn1 = NULL;
 	size_t asn1_len;
 
-	HEX2BUF(i_proto_public_bytes, tmp, 64);
+	HEX2BUF(vector->i_proto_public, tmp, 64);
 	i_proto_public = l_ecc_point_from_data(curve,
 						L_ECC_POINT_TYPE_FULL,
 						tmp, 64);
 	assert(i_proto_public);
 
-	HEX2BUF(r_boot_public_bytes, tmp, 64);
+	HEX2BUF(vector->r_boot_public, tmp, 64);
 	r_boot_public = l_ecc_point_from_data(curve,
 						L_ECC_POINT_TYPE_FULL,
 						tmp, 64);
 	assert(r_boot_public);
 
-	HEX2BUF(r_asn1, tmp, sizeof(tmp));
+	HEX2BUF(vector->r_asn1, tmp, sizeof(tmp));
 	asn1 = dpp_point_to_asn1(r_boot_public, &asn1_len);
 
 	from_asn1 = dpp_point_from_asn1(asn1, asn1_len);
@@ -240,47 +272,47 @@ static void test_key_derivation(const void *data)
 	assert(asn1_len == 59);
 	assert(memcmp(tmp, asn1, asn1_len) == 0);
 
-	HEX2BUF(r_proto_public_bytes, tmp, 64);
+	HEX2BUF(vector->r_proto_public, tmp, 64);
 	r_proto_public = l_ecc_point_from_data(curve,
 						L_ECC_POINT_TYPE_FULL,
 						tmp, 64);
 	assert(r_proto_public);
 
-	HEX2BUF(r_boot_private_bytes, tmp, 32);
+	HEX2BUF(vector->r_boot_private, tmp, 32);
 	r_boot_private = l_ecc_scalar_new(curve, tmp, 32);
 	assert(r_boot_private);
 
-	HEX2BUF(r_proto_private_bytes, tmp, 32);
+	HEX2BUF(vector->r_proto_private, tmp, 32);
 	r_proto_private = l_ecc_scalar_new(curve, tmp, 32);
 	assert(r_proto_private);
 
 	m = dpp_derive_k1(i_proto_public, r_boot_private, k1);
 	assert(m);
 
-	CHECK_FROM_STR(k1_bytes, k1, 32);
+	CHECK_FROM_STR(vector->k1, k1, 32);
 	l_ecc_scalar_get_data(m, tmp, sizeof(tmp));
-	CHECK_FROM_STR(mx_bytes, tmp, 32);
+	CHECK_FROM_STR(vector->mx, tmp, 32);
 
 	n = dpp_derive_k2(i_proto_public, r_proto_private, k2);
 	assert(n);
 
-	CHECK_FROM_STR(k2_bytes, k2, 32);
+	CHECK_FROM_STR(vector->k2, k2, 32);
 	l_ecc_scalar_get_data(n, tmp, sizeof(tmp));
-	CHECK_FROM_STR(nx_bytes, tmp, 32);
+	CHECK_FROM_STR(vector->nx, tmp, 32);
 
-	HEX2BUF(i_nonce_bytes, i_nonce, 16);
-	HEX2BUF(r_nonce_bytes, r_nonce, 16);
+	HEX2BUF(vector->i_nonce, i_nonce, 16);
+	HEX2BUF(vector->r_nonce, r_nonce, 16);
 	dpp_derive_ke(i_nonce, r_nonce, m, n, NULL, ke);
 
-	CHECK_FROM_STR(ke_bytes, ke, 32);
+	CHECK_FROM_STR(vector->ke, ke, 32);
 
 	dpp_derive_r_auth(i_nonce, r_nonce, 16, i_proto_public, r_proto_public,
 				NULL, r_boot_public, r_auth);
-	CHECK_FROM_STR(r_auth_bytes, r_auth, 32);
+	CHECK_FROM_STR(vector->r_auth, r_auth, 32);
 
 	dpp_derive_i_auth(r_nonce, i_nonce, 16, r_proto_public, i_proto_public,
 				r_boot_public, NULL, i_auth);
-	CHECK_FROM_STR(i_auth_bytes, i_auth, 32);
+	CHECK_FROM_STR(vector->i_auth, i_auth, 32);
 }
 
 int main(int argc, char *argv[])
@@ -289,8 +321,8 @@ int main(int argc, char *argv[])
 
 	if (l_checksum_is_supported(L_CHECKSUM_SHA256, true) &&
 						l_getrandom_is_supported())
-		l_test_add("DPP test key derivation",
-						test_key_derivation, NULL);
+		l_test_add("DPP test key derivation", test_key_derivation,
+						&responder_only_p256);
 
 	l_test_add("DPP URI parse", test_uri_parse, &all_values);
 	l_test_add("DPP URI no type", test_uri_parse, &no_type);
-- 
2.25.1

