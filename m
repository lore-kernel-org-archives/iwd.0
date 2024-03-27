Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864D454770
	for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552809; cv=none; b=Ah19o8RUwBn8WNOWhzIfGcByRRr0s2hyyFSmNm6qM5pk737YOq71pyIeewAbwz/QD45iNyOC2rsBjJsLij/DtKw67y/xlL+ErUXxO72p1yx7TA2RGtKYLsz3HxEeppAPHJ617iHXrp9tVY2NrG12jFncC3qa45UVnZscHCBSmqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552809; c=relaxed/simple;
	bh=SkVB6yaCtiY19HRA+P1Ou0mgmy5p+loI4m5zMOeA9OE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y0EeeF6Z6H3ox+rtrp1QAlnB1BGShRAfZn1oYvkHZ9uorbSzIdjyIA9TdlHR6gRehaSK+ySWHZrRLpKGx74aDWfDdWMKhU7Y0KMyKw6QTsxlcPBA1Aq5zk1d2kEPN48FrFSOfeGjGLqT8C1B6z6NtIVbHcXjRIZb7jO0HKh9EPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfP3Em7X; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfP3Em7X"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-430a65e973bso42634711cf.3
        for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 08:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711552806; x=1712157606; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2I6EtzXK2xSu8dxZO7eznX3LUgn7LoxAObVVvvJZ4uM=;
        b=TfP3Em7XpMoT5DUNawBBKA5NVivEZhZgJ8FMH+zLyHICmEi8P90V+zZxfOylD7gRNi
         ozYk0bcj+HNHWdrCE3P1+ItKYMnvaQYdAZX3+f4wXDc5ggbV9b3/bJ+gYXql1+i/ffZu
         UOWaPF2Kfs694c+ez1k4YyF0tN8CaX3OZEW32CdpxophYT8FNlcmI20q1kMyytyblP05
         DyDjp645ItsyPk427wCiKaYFNs9OcJiDCIdNgA9ZReK6CR8/iMFaXn4GHwWrz6wTgpQc
         QqGO6XG/dG8IdUYWAeetMK7BoQ9DmADpIiO2/nus+kcnSJXTNBXD8fSX8UlEMaVcvhw/
         IBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711552806; x=1712157606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I6EtzXK2xSu8dxZO7eznX3LUgn7LoxAObVVvvJZ4uM=;
        b=LTVIQAzn9l1wu99RDoWJ2ukgPyXGbaaCuG767PTFZYSHHBisK7yAZCYgob69cpwD6e
         Ug4R3QNWmolgUuPBLaCGtV+NyNU4mC06cDPMQXPVReFnBhWdvMVq+CxTWX043w9NKp5T
         ByAQ0hk1nRhdgQa6Pu2MZN8X2bmIp/gFg1tWtliQz+bGgv1XUHUbn3yOysp/5RzKKS9j
         uQF2j+W6S3qMcT1JDxBs4orm0QXrVU6BPzkp5eQbSlS1JT7IxuF3GCShtPUNweq4CzDO
         Q2dDgT1SsQqZW0ux8DgWXrAO4XeiCi6y6iCYqg1JTxf9Vk0Hw7WSPllf0ij/40Vy4jOP
         g71A==
X-Gm-Message-State: AOJu0Yxlm7cH8mkGD0Z9U/Mh5CCIPDK2tO9Fokqdm2L2+hpGttf1IQGq
	CEr/392MYETCXdNMicay0sDzOwP1nQWfUupZUZX+MM3j0iffj7hnqOFDfiIs
X-Google-Smtp-Source: AGHT+IECeaW7etGg70oBgmSmUFXWsGQUmia6XbxCIfZUC8ESKbdHESMEy8NVlKd7QY3Dl/tG+Dn0fQ==
X-Received: by 2002:a05:6214:27e2:b0:696:9df4:58e5 with SMTP id jt2-20020a05621427e200b006969df458e5mr1766225qvb.1.1711552806242;
        Wed, 27 Mar 2024 08:20:06 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 7-20020a056214202700b006968ce99b7esm3520782qvf.34.2024.03.27.08.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:20:05 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/9] dpp: use dpp_append_point
Date: Wed, 27 Mar 2024 08:19:52 -0700
Message-Id: <20240327151957.1446149-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327151957.1446149-1-prestwoj@gmail.com>
References: <20240327151957.1446149-1-prestwoj@gmail.com>
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

