Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC53D38E
	for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeQTbjoy"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7781bc3783fso101983085a.1
        for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 13:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698352042; x=1698956842; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dY229fyI9LCFdAo8JRJ/it3w3S71YIxaVpFzHYbT+tI=;
        b=jeQTbjoyXAz0DPOAaU7TFteFlZUFBnaUV7DS6QgNx7ceRrjgEriyrteEcohQ5OJbP6
         VB42357SzNvGoE2Hj80Yf71Vh9xhlSDFHU7bkwHV2WnBntGAIbJe/lOpAzENHKIsDyJv
         DlNZk0W/PuJnQh/TLYu5ln1bNUjmMWuhiuyOMsdWUTqeG2AAEAcqV41vlgXBvPufBngj
         dFYUh2FQOiSJTVmWkkJnO7sue90Uy8s7V4rl7n52rel0lRsNJZZkbIupDt1RTOWY1ZFZ
         LKpy+BjUbPVWm+aiODrHveWB1fDRALHKt0YGG0M3BSTXq3L8UGr25cJ5z7wWjhj04TqE
         YISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698352042; x=1698956842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dY229fyI9LCFdAo8JRJ/it3w3S71YIxaVpFzHYbT+tI=;
        b=tbH9zOS8X2Ai+Yi1aVwPFkxx73rH2vyY/6xte0A7Dbh7rIMb0IUsVjLJa3typqQyw/
         bsRDgKXPoMxOJEBpkPNs9vpuv2cVS9+UrqJLkbe+TNIgTXAORyOg1GbCjKMKt6JnrgRg
         OSgR/+JblKTtEB5mnr4pzgOEgD8Kw2KN3q0IbaAIFbpk9IXgN1MQ0nKwVNMzmQOdeMEQ
         FjX7IXQM4T5dKMIRDtF5DTHSm8Vdr2B2KwQZFCFhUjxA2mqWdmGNOTfdONR6+3ansW+P
         OMgMH9Mi0W428rukFMKhuu0wweb8eUI7xD2H2Ja02BYwDC0jsmKoHMPF0h6RkbV3pZ4f
         ccCw==
X-Gm-Message-State: AOJu0YxC84B1aF8vI33rBkUFQgo2eX5zai/zJywEjVe9M2/UJw29Z/0/
	3qcynvfAw8BCohSEc0TD88sN3tkBKG8=
X-Google-Smtp-Source: AGHT+IF486NGQLP4yWa7VIf1H9TpPiIFP+jfm7ArIABPJ80mLIdUOP3oUEgRME4iQg3rle9eyjQ2Pw==
X-Received: by 2002:a05:620a:4046:b0:774:1470:9a88 with SMTP id i6-20020a05620a404600b0077414709a88mr376463qko.65.1698352042594;
        Thu, 26 Oct 2023 13:27:22 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id r4-20020a05620a298400b007742c2ad7dfsm7303qkp.73.2023.10.26.13.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:27:22 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 10/15] unit: add PKEX DPP tests
Date: Thu, 26 Oct 2023 13:26:52 -0700
Message-Id: <20231026202657.183591-11-prestwoj@gmail.com>
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
 unit/test-dpp.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/unit/test-dpp.c b/unit/test-dpp.c
index 1fa241af..781d494a 100644
--- a/unit/test-dpp.c
+++ b/unit/test-dpp.c
@@ -404,6 +404,146 @@ static void test_key_derivation(const void *data)
 	CHECK_FROM_STR(vector->i_auth, i_auth, 32);
 }
 
+struct dpp_pkex_test_vector {
+	uint8_t mac_i[6];
+	uint8_t mac_r[6];
+	const char *identifier;
+	const char *key;
+
+	const char *i_boot_public;
+	const char *i_boot_private;
+	const char *qix;
+
+	const char *r_boot_public;
+	const char *r_boot_private;
+	const char *qrx;
+
+	const char *mx;
+	const char *nx;
+
+	const char *k;
+	const char *j;
+	const char *ax;
+	const char *yx;
+	const char *xx;
+	const char *bx;
+	const char *lx;
+
+	const char *z;
+	const char *u;
+	const char *v;
+};
+
+/*
+ * Appendix D PKEX Test Vector for NIST p256
+ */
+static struct dpp_pkex_test_vector pkex_vector = {
+	.mac_i = { 0xac, 0x64, 0x91, 0xf4, 0x52, 0x07 },
+	.mac_r = { 0x6e, 0x5e, 0xce, 0x6e, 0xf3, 0xdd },
+	.identifier = "joes_key",
+	.key = "thisisreallysecret",
+
+	.i_boot_public = "0ad58864754c812685ff3a52a573c1d72c72c4ebed98f3915622d4dfc84a438d"
+			"7e81429aac49ddec75ad6521db9c74074e30b5eb2ba53693c9341b79be14e101",
+	.i_boot_private = "5941b51acfc702cdc1c347264beb2920db88eb1a0bf03a211868b1632233c269",
+	.qix = "2867c4e080980dbad5099a8f821e8729679c5c714888c0bd9c7e8e4048c5fa5e",
+
+	.r_boot_public = "977b7fa39779a81429febb12e1dc5e20a7e017c4bc7437090e57c966a2b0e8a3"
+			"9d2b62733947639763f64c7b6708c1e0857becb7e24fc195248b5b06036cf792",
+	.r_boot_private = "2ae8956293f49986b6d0b8169a86805d9232babb5f6813fdfe96f19d59536c60",
+	.qrx = "134af1c41c8e7d974c647cc2bfca30b036966959f9044e90f673d756706e624c",
+
+	.mx = "bcca8e23e5c05032ae6051ca6392f7c4a4b4f9fe13e8126132d070e552848176",
+	.nx = "0a91e0728809bb8191ea36d0a1d5602bf36ab6708fbfd063e2511e533b534020",
+
+	.k = "7415e1c68611f0443cc345d136984e488c6a26d3d5482fa67e9841a03a87c78f",
+	.j = "31c1b9ab31d9c2f278b35b5c29d180dfeaf76d585ede9c0dd91cb66149db572e",
+	.ax = "0ad58864754c812685ff3a52a573c1d72c72c4ebed98f3915622d4dfc84a438d",
+	.yx = "a9972a94f143740df31c7a61124d01a4e949d0fdcede61369f4c6b097aeb18b5",
+	.xx = "740ab9f0c173507b0081b475b275de6a3060cf434b6a65f0b0144a1dbf913310",
+	.bx = "977b7fa39779a81429febb12e1dc5e20a7e017c4bc7437090e57c966a2b0e8a3",
+	.lx = "bc5f3128b0b997079a23ead63cf502ef4f7526602269620377b79bce20e03d44",
+
+	.z = "5271dee915cf7b1908747d8edb8394442411c5183ee38b79ebef399c08738e0b",
+	.u = "598c3d8dcccea2d43259068d542a907442f07e8cbcfb3fb49faac12eb2fee5b6",
+	.v = "b2833ce21ab4e42c082111a5dd232334e48019f66b2e274f521fe2f7dfa11999",
+};
+
+static void test_pkex_key_derivation(const void *user_data)
+{
+	const struct dpp_pkex_test_vector *vector = user_data;
+	const struct l_ecc_curve *curve = l_ecc_curve_from_ike_group(19);
+	uint64_t tmp[L_ECC_MAX_DIGITS * 2];
+	_auto_(l_ecc_point_free) struct l_ecc_point *qi = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *qr = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *n = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *m = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *j = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *k = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *a = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *y = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *x = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *b = NULL;
+	_auto_(l_ecc_point_free) struct l_ecc_point *l = NULL;
+	size_t len;
+
+	qi = dpp_derive_qi(curve, vector->key, vector->identifier,
+				vector->mac_i);
+	l_ecc_point_get_x(qi, tmp, sizeof(tmp));
+	CHECK_FROM_STR(vector->qix, tmp, 32);
+
+	qr = dpp_derive_qr(curve, vector->key, vector->identifier,
+				vector->mac_r);
+	l_ecc_point_get_x(qr, tmp, sizeof(tmp));
+	CHECK_FROM_STR(vector->qrx, tmp, 32);
+
+	HEX2BUF(vector->nx, tmp, 32);
+	n = l_ecc_point_from_data(curve, L_ECC_POINT_TYPE_COMPLIANT, tmp, 32);
+	assert(n);
+
+	HEX2BUF(vector->mx, tmp, 32);
+	m = l_ecc_point_from_data(curve, L_ECC_POINT_TYPE_COMPLIANT, tmp, 32);
+	assert(m);
+
+	HEX2BUF(vector->k, tmp, 32);
+	k = l_ecc_point_from_data(curve, L_ECC_POINT_TYPE_COMPLIANT, tmp, 32);
+	assert(k);
+
+	dpp_derive_z(vector->mac_i, vector->mac_r, n, m, k, vector->key,
+			vector->identifier, tmp, &len);
+	CHECK_FROM_STR(vector->z, tmp, 32);
+
+	HEX2BUF(vector->j, tmp, 32);
+	j = l_ecc_point_from_data(curve, L_ECC_POINT_TYPE_COMPLIANT, tmp, 32);
+	assert(j);
+
+	HEX2BUF(vector->ax, tmp, 32);
+	a = l_ecc_point_from_data(curve, L_ECC_POINT_TYPE_COMPLIANT, tmp, 32);
+	assert(a);
+
+	HEX2BUF(vector->yx, tmp, 32);
+	y = l_ecc_point_from_data(curve, L_ECC_POINT_TYPE_COMPLIANT, tmp, 32);
+	assert(y);
+
+	HEX2BUF(vector->xx, tmp, 32);
+	x = l_ecc_point_from_data(curve, L_ECC_POINT_TYPE_COMPLIANT, tmp, 32);
+	assert(x);
+
+	dpp_derive_u(j, vector->mac_i, a, y, x, tmp, &len);
+	CHECK_FROM_STR(vector->u, tmp, 32);
+
+	HEX2BUF(vector->bx, tmp, 32);
+	b = l_ecc_point_from_data(curve, L_ECC_POINT_TYPE_COMPLIANT, tmp, 32);
+	assert(b);
+
+	HEX2BUF(vector->lx, tmp, 32);
+	l = l_ecc_point_from_data(curve, L_ECC_POINT_TYPE_COMPLIANT, tmp, 32);
+	assert(l);
+
+	dpp_derive_v(l, vector->mac_r, b, x, y, tmp, &len);
+	CHECK_FROM_STR(vector->v, tmp, 32);
+}
+
 int main(int argc, char *argv[])
 {
 	l_test_init(&argc, &argv);
@@ -416,6 +556,9 @@ int main(int argc, char *argv[])
 		l_test_add("DPP test mutual key derivation",
 						test_key_derivation,
 						&mutual_p256);
+		l_test_add("DPP test PKEX key derivation",
+						test_pkex_key_derivation,
+						&pkex_vector);
 	}
 
 	l_test_add("DPP URI parse", test_uri_parse, &all_values);
-- 
2.25.1

