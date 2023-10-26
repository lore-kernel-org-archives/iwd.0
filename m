Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0534E3CCFD
	for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FF6xBtu6"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-778711ee748so104352385a.2
        for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 13:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698352040; x=1698956840; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkDBubNt3gstw368lHcAZnlIM74s0njBq318BQ7+2R0=;
        b=FF6xBtu6s2EGP0CStuf1N+q+g0WJJCh9jIIg6jetqXONT/ZMR6CTnOMxCJT+JKAzyQ
         ChNI9/nOmXpUcp7ejv37d4506f555rEjlFpS31x+cd/+oYCQTfjCZwPpHSezq1u7/TEv
         v2pKZ35oAdFXyI+Q4lyc2utdyZMSPfsiWypMLk6QlF/M907JAP1bTjxB8WNIsOvGa4Wt
         ZSjacQBvO9T3rAxy+Kz9wPKu6IFgoMr8ebCEgNbA1OPKqMxqH1ZwDOhN1izaZovUa2GZ
         /6QeXZm96dqlWb2/P+vdFffMgRqAswl6djHaeUo9uiiwvr0o/mt8YhGWLn2AR6TVZC1J
         aiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698352040; x=1698956840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkDBubNt3gstw368lHcAZnlIM74s0njBq318BQ7+2R0=;
        b=eA1oc5xLMn4xMH5JdPe6BXp91sWLAAPpKHYuCrdqW2icdwqKT6/clojaK0kn46c7IX
         wLmMerx02N1S9PBKgWFFexYJLSLR/UCvKos49dxaQQlT8RSVNCFRkgo1M6VTegvOukjN
         10lZqfAUVS6R0J3l9r2ZNlvtFX74ssCdegIVdoB8zGdsuZqH3sdOcR3TKaXxBaD4FVy1
         XuJf5nvwZdY0lXGYVNO0rmlYAJbIOf90lYqnF/wua1h4+RCi54srm8P7m3voVdScJ6JD
         QqCh1gaKfxhQZBnHdUV1W/ici4KqR+QRZkwZII0JF0KKoSAlP4EFabFoAO2HuRtELoUN
         bmJw==
X-Gm-Message-State: AOJu0YxiEQfESDvKLB26u8krzajJ07LqXI3H7oD3QS0uBPjvwzt6gz8M
	NtK+CnUVI/afrRX7Z3x99hai9yRq/XM=
X-Google-Smtp-Source: AGHT+IHtWJkzccygjKMSZRalCI9FuUCsvIV8dBsygi3XJHI5pfiRG4z9KvK+kBsyBIXbWokGMVSYcA==
X-Received: by 2002:a05:620a:28c2:b0:778:9be8:2742 with SMTP id l2-20020a05620a28c200b007789be82742mr515027qkp.3.1698352039970;
        Thu, 26 Oct 2023 13:27:19 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id r4-20020a05620a298400b007742c2ad7dfsm7303qkp.73.2023.10.26.13.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:27:19 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 09/15] unit: add DPP test for mutual authentication
Date: Thu, 26 Oct 2023 13:26:51 -0700
Message-Id: <20231026202657.183591-10-prestwoj@gmail.com>
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

---
 unit/test-dpp.c | 104 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 99 insertions(+), 5 deletions(-)

diff --git a/unit/test-dpp.c b/unit/test-dpp.c
index 0cf60f0a..1fa241af 100644
--- a/unit/test-dpp.c
+++ b/unit/test-dpp.c
@@ -182,6 +182,46 @@ struct dpp_test_vector {
 	const char *ke;
 	const char *mx;
 	const char *nx;
+	const char *lx;
+};
+
+/*
+ * B.1 Test Vectors for DPP Authentication Using P-256 for
+ * Mutual Authentication
+ */
+static struct dpp_test_vector mutual_p256 = {
+	.i_proto_public = "50a532ae2a07207276418d2fa630295d45569be425aa634f02014d00a7d1f61a"
+			"e14f35a5a858bccad90d126c46594c49ef82655e78888e15a32d916ac2172491",
+	.i_proto_private = "a87de9afbb406c96e5f79a3df895ecac3ad406f95da66314c8cb3165e0c61783",
+	/*
+	 * The spec uses a 31 octet Y value, a zero byte was prepended to the
+	 * Y value here otherwise the point cannot be created
+	 */
+	.i_boot_public = "88b37ed91938b5197097808a6244847617892046d93b9501afd48fa0f148dfde"
+			"00f73b6991287884a9c9a33f8e0691f14d44b59811e9d8242d010270b0d33ec0",
+	.i_boot_private = "15b2a83c5a0a38b61f2aa8200ee4994b8afdc01c58507d10d0a38f7eedf051bb",
+	.i_nonce = "13f4602a16daeb69712263b9c46cba31",
+	.i_auth = "d34944bb4b1f05caebda762c6e4ae034c819ec2f62a57dcfade2473876e007b2",
+	.i_asn1 = "3039301306072a8648ce3d020106082a8648ce3d0301070322000288b37ed919"
+			"38b5197097808a6244847617892046d93b9501afd48fa0f148dfde",
+
+	.r_proto_public = "5e3fb3576884887f17c3203d8a3a6c2fac722ef0e2201b61ac73bc655c709a90"
+			"2d4b030669fb9eff8b0a79fa7c1a172ac2a92c626256963f9274dc90682c81e5",
+	.r_proto_private = "f798ed2e19286f6a6efe210b1863badb99af2a14b497634dbfd2a97394fb5aa5",
+	.r_boot_public = "09c585a91b4df9fd25a045201885c39cc5cfae397ddaeda957dec57fa0e3503f"
+			"52bf05968198a2f92883e96a386d767579883302dbf292105c90a43694c2fd5c",
+	.r_boot_private = "54ce181a98525f217216f59b245f60e9df30ac7f6b26c939418cfc3c42d1afa0",
+	.r_nonce = "3d0cfb011ca916d796f7029ff0b43393",
+	.r_auth = "a725abe6dc66ccf3aa3d6d61a19932fcbb0799ed09ff78e5bc6d4ea5ef8e8670",
+	.r_asn1 = "3039301306072a8648ce3d020106082a8648ce3d0301070322000209c585a91b"
+			"4df9fd25a045201885c39cc5cfae397ddaeda957dec57fa0e3503f",
+
+	.k1 = "3d832a02ed6d7fc1dc96d2eceab738cf01c0028eb256be33d5a21a720bfcf949",
+	.k2 = "ca08bdeeef838ddf897a5f01f20bb93dc5a895cb86788ca8c00a7664899bc310",
+	.ke = "b6db65526c9a0174c3bed56f7e614f3a656233c078693249ac3516425127e5d5",
+	.mx = "dde2878117d69745be4f916a2dd14269d783d1d788c603bb8746beabbd1dbbbc",
+	.nx = "92118478b75c21c2c59340c842b5bce560a535f60bc37a75fe390d738c58d8e8",
+	.lx = "fb737234c973cc3a36e64e5170a32f12089d198c73c2fd85a53d0b282530fd02"
 };
 
 /*
@@ -232,6 +272,8 @@ static void test_key_derivation(const void *data)
 
 	uint64_t tmp[L_ECC_MAX_DIGITS * 2];
 	const struct l_ecc_curve *curve = l_ecc_curve_from_ike_group(19);
+	_auto_(l_ecc_point_free) struct l_ecc_point *i_boot_public = NULL;
+	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *i_boot_private = NULL;
 	_auto_(l_ecc_point_free) struct l_ecc_point *i_proto_public = NULL;
 	_auto_(l_ecc_point_free) struct l_ecc_point *r_boot_public = NULL;
 	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *r_boot_private = NULL;
@@ -239,6 +281,7 @@ static void test_key_derivation(const void *data)
 	_auto_(l_ecc_point_free) struct l_ecc_point *r_proto_public = NULL;
 	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *m = NULL;
 	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *n = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *l = NULL;
 	_auto_(l_ecc_point_free) struct l_ecc_point *from_asn1 = NULL;
 	uint64_t k1[L_ECC_MAX_DIGITS];
 	uint64_t k2[L_ECC_MAX_DIGITS];
@@ -262,6 +305,20 @@ static void test_key_derivation(const void *data)
 						tmp, 64);
 	assert(r_boot_public);
 
+	if (vector->i_boot_public) {
+		HEX2BUF(vector->i_boot_public, tmp, 64);
+		i_boot_public = l_ecc_point_from_data(curve,
+						L_ECC_POINT_TYPE_FULL,
+						tmp, 64);
+		assert(i_boot_public);
+	}
+
+	if (vector->i_boot_private) {
+		HEX2BUF(vector->i_boot_private, tmp, 32);
+		i_boot_private = l_ecc_scalar_new(curve, tmp, 32);
+		assert(i_boot_private);
+	}
+
 	HEX2BUF(vector->r_asn1, tmp, sizeof(tmp));
 	asn1 = dpp_point_to_asn1(r_boot_public, &asn1_len);
 
@@ -272,6 +329,19 @@ static void test_key_derivation(const void *data)
 	assert(asn1_len == 59);
 	assert(memcmp(tmp, asn1, asn1_len) == 0);
 
+	if (vector->i_asn1) {
+		HEX2BUF(vector->i_asn1, tmp, sizeof(tmp));
+		asn1 = dpp_point_to_asn1(i_boot_public, &asn1_len);
+
+		from_asn1 = dpp_point_from_asn1(asn1, asn1_len);
+
+		assert(l_ecc_points_are_equal(from_asn1, i_boot_public));
+
+		assert(asn1_len == 59);
+		assert(memcmp(tmp, asn1, asn1_len) == 0);
+	}
+
+
 	HEX2BUF(vector->r_proto_public, tmp, 64);
 	r_proto_public = l_ecc_point_from_data(curve,
 						L_ECC_POINT_TYPE_FULL,
@@ -300,18 +370,37 @@ static void test_key_derivation(const void *data)
 	l_ecc_scalar_get_data(n, tmp, sizeof(tmp));
 	CHECK_FROM_STR(vector->nx, tmp, 32);
 
+	if (vector->lx) {
+		/* Check initiator derivation */
+		l = dpp_derive_li(r_boot_public, r_proto_public,
+					i_boot_private);
+		assert(l);
+		l_ecc_point_get_x(l, tmp, sizeof(tmp));
+		CHECK_FROM_STR(vector->lx, tmp, 32);
+		l_ecc_point_free(l);
+		l = NULL;
+
+		/* Check responder derivation */
+		l = dpp_derive_lr(r_boot_private, r_proto_private,
+					i_boot_public);
+		assert(l);
+		l_ecc_point_get_x(l, tmp, sizeof(tmp));
+		CHECK_FROM_STR(vector->lx, tmp, 32);
+
+	}
+
 	HEX2BUF(vector->i_nonce, i_nonce, 16);
 	HEX2BUF(vector->r_nonce, r_nonce, 16);
-	dpp_derive_ke(i_nonce, r_nonce, m, n, NULL, ke);
+	dpp_derive_ke(i_nonce, r_nonce, m, n, l, ke);
 
 	CHECK_FROM_STR(vector->ke, ke, 32);
 
 	dpp_derive_r_auth(i_nonce, r_nonce, 16, i_proto_public, r_proto_public,
-				NULL, r_boot_public, r_auth);
+				i_boot_public, r_boot_public, r_auth);
 	CHECK_FROM_STR(vector->r_auth, r_auth, 32);
 
 	dpp_derive_i_auth(r_nonce, i_nonce, 16, r_proto_public, i_proto_public,
-				r_boot_public, NULL, i_auth);
+				r_boot_public, i_boot_public, i_auth);
 	CHECK_FROM_STR(vector->i_auth, i_auth, 32);
 }
 
@@ -320,9 +409,14 @@ int main(int argc, char *argv[])
 	l_test_init(&argc, &argv);
 
 	if (l_checksum_is_supported(L_CHECKSUM_SHA256, true) &&
-						l_getrandom_is_supported())
-		l_test_add("DPP test key derivation", test_key_derivation,
+						l_getrandom_is_supported()) {
+		l_test_add("DPP test responder-only key derivation",
+						test_key_derivation,
 						&responder_only_p256);
+		l_test_add("DPP test mutual key derivation",
+						test_key_derivation,
+						&mutual_p256);
+	}
 
 	l_test_add("DPP URI parse", test_uri_parse, &all_values);
 	l_test_add("DPP URI no type", test_uri_parse, &no_type);
-- 
2.25.1

