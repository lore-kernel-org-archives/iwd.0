Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E077BB01
	for <iwd@lists.linux.dev>; Wed, 13 Mar 2024 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350023; cv=none; b=giN3E1OQTRYC6TiriudfrN1kYL7gEuuqkzSWTfhl1Gtz9NozRA0SMEkiTnMiVIEtvSccijDJBbBdQhDZOwH2ZDKSTns3nCxhqG/ylDTA2S+5Jzv/ShWtG1l7BXEYBLCNvrrRxoAFSHErqp7sOaOAZkbnviUGMM0EpxMrS1Wglmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350023; c=relaxed/simple;
	bh=SkVB6yaCtiY19HRA+P1Ou0mgmy5p+loI4m5zMOeA9OE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aN2vy8SUQ3sSavsoMYThX/hQQoxZ0XX5Pb4+O0uFqIFISZQh9YpzUwVi/oNPil81zrtLwWcvH7ny8fimfjsWAcYvw4G0bAjWAkZ4asHW359uYw7yoxk4lmKr+BO1FlWbDPX2nGuiLb1b9sV5fZZ5boFe+Hb2AJHPWzaXYOJXnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hImwDSIJ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hImwDSIJ"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7884a9a404fso3330985a.3
        for <iwd@lists.linux.dev>; Wed, 13 Mar 2024 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710350019; x=1710954819; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2I6EtzXK2xSu8dxZO7eznX3LUgn7LoxAObVVvvJZ4uM=;
        b=hImwDSIJ/NgA6WZ/yq6afJjTb5vddG6PTpAn7IvlXzzfsQphjR/E/nBllbWMRu7Pcn
         PGiEKI58/2Y0yTH8p7nf3ePzh+wsQqsiZY5CuZiAoQKE6Vp0novKMuF5gUpOxxVHYWGa
         Obxo8dQopOxbGKWo3i9F47frEWW7+O/H4oSb3H4CojMT76ca8NjYqDMItrdipUcPd8OI
         d9RyH4kjnQzlvq9ngjwwE1lwF05EkZQyzrJkdBBk907z+74W8NnGIJazZfippiGWrFpE
         /k+wCDtTTETgJ03tEOgJega4nHocNEcpC6OzK3k8izJVIJH+5BzvllD0y0h44kEVEFSi
         Wq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710350019; x=1710954819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I6EtzXK2xSu8dxZO7eznX3LUgn7LoxAObVVvvJZ4uM=;
        b=A+JqNv/RKecUhU6UBdYD7IApc8evdkv7eIDAjKPYJmKBQnQfyaM+0BsyD8v2aSrpqO
         xmnzQjQNB41V3GYU5bcpFnxuoxYin/hdURS04sqlyjgXEgAKnm+h/J0ExdSHKPz7QT6a
         vjd/w8XI4bNL2yjYHtT80eGXSOWuY79476ZWsfyL22ks8Bx6T9qnNIDQQB8Tjcv09khK
         7X3sPSO2GOXt9AMJVBshuGBXptyyAJEApjFkaZCWHToEVJf/wg3PjYMmuYAE0J80pYDz
         iquek8HmGC80aSbPZbgytyegd3g9jot+6QKoOIAw/m/rOlB+lqdXvuUKAUWrZRPlktk+
         vE9A==
X-Gm-Message-State: AOJu0YzSHmKhXG9r+qu2+P4XW2LufX77ocA8yN3QFQ9yUtWvY82IFYrg
	dMQlky53k6SyFFNQUNpCdMeljnNPLKqrEN/SWGhhRP34pL0ynazfIf6Va0p9
X-Google-Smtp-Source: AGHT+IFSqti2AKulEQdcXsMEd6UdbXKPYEmHs6qlUovkbIlydm2KuRkT9YUCc4XTwu1zYCBHyfb6QA==
X-Received: by 2002:a05:620a:ecc:b0:788:2b1c:1e57 with SMTP id x12-20020a05620a0ecc00b007882b1c1e57mr476280qkm.55.1710350019585;
        Wed, 13 Mar 2024 10:13:39 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id i4-20020ae9ee04000000b007882e204d45sm4927136qkg.37.2024.03.13.10.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:13:39 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 4/5] dpp: use dpp_append_point
Date: Wed, 13 Mar 2024 10:13:10 -0700
Message-Id: <20240313171311.695830-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313171311.695830-1-prestwoj@gmail.com>
References: <20240313171311.695830-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dpp_append_point where possible to avoid temporarily copying data
---
 src/dpp.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index d710aa98..47ebd495 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1504,7 +1504,6 @@ static void send_authenticate_response(struct dpp_sm *dpp)
 	uint8_t frame[512];
 	uint8_t *ptr = frame;
 	uint8_t status = DPP_STATUS_OK;
-	uint64_t r_proto_key[L_ECC_MAX_DIGITS * 2];
 	uint8_t version = 2;
 	struct iovec iov;
 	uint8_t wrapped2_plaintext[dpp->key_len + 4];
@@ -1514,9 +1513,6 @@ static void send_authenticate_response(struct dpp_sm *dpp)
 
 	memset(frame, 0, sizeof(frame));
 
-	l_ecc_point_get_data(dpp->own_proto_public, r_proto_key,
-				sizeof(r_proto_key));
-
 	ptr += dpp_build_header(netdev_get_address(dpp->netdev),
 				dpp->peer_addr,
 				DPP_FRAME_AUTHENTICATION_RESPONSE, ptr);
@@ -1526,8 +1522,8 @@ static void send_authenticate_response(struct dpp_sm *dpp)
 	if (dpp->mutual_auth)
 		ptr += dpp_append_attr(ptr, DPP_ATTR_INITIATOR_BOOT_KEY_HASH,
 				dpp->peer_boot_hash, 32);
-	ptr += dpp_append_attr(ptr, DPP_ATTR_RESPONDER_PROTOCOL_KEY,
-				r_proto_key, dpp->key_len * 2);
+	ptr += dpp_append_point(ptr, DPP_ATTR_RESPONDER_PROTOCOL_KEY,
+				dpp->own_proto_public);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION, &version, 1);
 
 	/* Wrap up secondary data (R-Auth) */
@@ -1778,7 +1774,6 @@ static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
 {
 	uint8_t frame[256];
 	uint8_t *ptr = frame;
-	uint64_t i_proto_key[L_ECC_MAX_DIGITS * 2];
 	uint8_t version = 2;
 	struct iovec iov;
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
@@ -1793,9 +1788,6 @@ static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
 		return false;
 	}
 
-	l_ecc_point_get_data(dpp->own_proto_public, i_proto_key,
-				sizeof(i_proto_key));
-
 	ptr += dpp_build_header(netdev_get_address(dpp->netdev),
 				dpp->peer_addr,
 				DPP_FRAME_AUTHENTICATION_REQUEST, ptr);
@@ -1803,8 +1795,8 @@ static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
 				dpp->peer_boot_hash, 32);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_INITIATOR_BOOT_KEY_HASH,
 				dpp->own_boot_hash, 32);
-	ptr += dpp_append_attr(ptr, DPP_ATTR_INITIATOR_PROTOCOL_KEY,
-				i_proto_key, dpp->key_len * 2);
+	ptr += dpp_append_point(ptr, DPP_ATTR_INITIATOR_PROTOCOL_KEY,
+				dpp->own_proto_public);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION, &version, 1);
 
 	if (dpp->role == DPP_CAPABILITY_CONFIGURATOR &&
@@ -1835,7 +1827,6 @@ static void dpp_send_pkex_exchange_request(struct dpp_sm *dpp)
 	uint8_t hdr[32];
 	uint8_t attrs[256];
 	uint8_t *ptr = attrs;
-	uint64_t m_data[L_ECC_MAX_DIGITS * 2];
 	uint16_t group;
 	struct iovec iov[2];
 	const uint8_t *own_mac = netdev_get_address(dpp->netdev);
@@ -1855,10 +1846,7 @@ static void dpp_send_pkex_exchange_request(struct dpp_sm *dpp)
 		ptr += dpp_append_attr(ptr, DPP_ATTR_CODE_IDENTIFIER,
 					dpp->pkex_id, strlen(dpp->pkex_id));
 
-	l_ecc_point_get_data(dpp->pkex_m, m_data, sizeof(m_data));
-
-	ptr += dpp_append_attr(ptr, DPP_ATTR_ENCRYPTED_KEY,
-				m_data, dpp->key_len * 2);
+	ptr += dpp_append_point(ptr, DPP_ATTR_ENCRYPTED_KEY, dpp->pkex_m);
 
 	iov[1].iov_base = attrs;
 	iov[1].iov_len = ptr - attrs;
@@ -3018,7 +3006,6 @@ static void dpp_send_pkex_exchange_response(struct dpp_sm *dpp,
 	uint8_t hdr[32];
 	uint8_t attrs[256];
 	uint8_t *ptr = attrs;
-	uint64_t n_data[L_ECC_MAX_DIGITS * 2];
 	uint16_t group;
 	uint8_t status = DPP_STATUS_OK;
 	struct iovec iov[2];
@@ -3036,10 +3023,7 @@ static void dpp_send_pkex_exchange_response(struct dpp_sm *dpp,
 		ptr += dpp_append_attr(ptr, DPP_ATTR_CODE_IDENTIFIER,
 					dpp->pkex_id, strlen(dpp->pkex_id));
 
-	l_ecc_point_get_data(n, n_data, sizeof(n_data));
-
-	ptr += dpp_append_attr(ptr, DPP_ATTR_ENCRYPTED_KEY,
-				n_data, dpp->key_len * 2);
+	ptr += dpp_append_point(ptr, DPP_ATTR_ENCRYPTED_KEY, n);
 
 	iov[1].iov_base = attrs;
 	iov[1].iov_len = ptr - attrs;
-- 
2.34.1

