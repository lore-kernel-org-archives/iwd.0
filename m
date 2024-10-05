Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8DE1C6B2
	for <iwd@lists.linux.dev>; Sat,  5 Oct 2024 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728094807; cv=none; b=KYnw1vjB0gp44MeHDxNnwBGB2ybgd5dGBvnwlbejqNrnbMpxq2jk93Cw1oACbm1Dx1LaqpU8ZY6Nb29U5llTiJpxwZ/VdO2UZTNfhAGU2zWW5JQE5S8Ck9wtqrD/YLK0v2WPqW9ew8QXAozbBe7X25M817SioUi/cRFLm6jNkCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728094807; c=relaxed/simple;
	bh=t1cwRSaJoTnveHjS9362/m3pudWBdTgznB7d5crg8xM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zcb++1HllxSI7D9MXL7e5lYG2D1FzQaXs1hIqLoX1ktcCXpMAG/qpNrnt8ICJjsbolcCvicp6HG3MK42lgAtC35pRR2+fR1pLundDIY1HuisnAXc/WWw81nKZZJ9fSf62xgNBr+N/MMPXuuX8bTvICWCDrvzAj9NlutswSc5F4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z1IaGHIm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z1IaGHIm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728094803;
	bh=t1cwRSaJoTnveHjS9362/m3pudWBdTgznB7d5crg8xM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Z1IaGHImX7gMJ414Z01h5esyGDWw+Ut+1jjHK9Rk4SgQOqqm08Md3gFVypccjL/Vu
	 a+h1zJ58xR4epuIvwMupNBAejztggd3gjBbJGhqZW9RTryvn2kyV+UTD7iYXMtNNyQ
	 Kn4Fs6qTSr4+hL+Xe7hrjp6go2AxJrHN9iqkwk23nkXM+7gsihzuMH2wLl4QsggLS4
	 mKmgbBkvMU4/Uuw5Q328I6AELQqJmx6izDYjFhnnbJNRsBKwK9PwnxTWpKtt0T7D3R
	 XNHQUvX7JnR8mDGIjH7UYU8EUdDDOYboxgOLOW093N2X7n/up5s4FImKfmnjPoGI7s
	 xl1Pc7gYg/tMA==
Received: from noise.lan (unknown [IPv6:2001:4d48:ad5d:8e00::197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vivek)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5B79917E0F8B
	for <iwd@lists.linux.dev>; Sat,  5 Oct 2024 04:20:03 +0200 (CEST)
From: =?UTF-8?q?Vivek=20Das=C2=A0Mohapatra?= <vivek@collabora.com>
To: iwd@lists.linux.dev
Subject: [PATCH 2/2] mpdu: tolerate technically illegal but harmless cloned IEs
Date: Sat,  5 Oct 2024 03:19:29 +0100
Message-Id: <20241005021929.2075817-3-vivek@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241005021929.2075817-1-vivek@collabora.com>
References: <6dbd0686-f054-4c16-bf84-0e383baefdc9@collabora.com>
 <20241005021929.2075817-1-vivek@collabora.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/ie.h   | 17 +++++++++++++++++
 src/mpdu.c | 10 +++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/src/ie.h b/src/ie.h
index 4498785a..bc750696 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -598,6 +598,23 @@ static inline const unsigned char *ie_tlv_iter_get_data(
 	return iter->data;
 }
 
+static inline bool ie_tlv_iter_data_eq(struct ie_tlv_iter *a,
+					struct ie_tlv_iter *b)
+{
+	if (a == b)
+		return true;
+
+	if (a == NULL || b == NULL)
+		return false;
+
+	if (ie_tlv_iter_get_length(a) != ie_tlv_iter_get_length(b))
+		return false;
+
+	return memcmp(ie_tlv_iter_get_data(a),
+			ie_tlv_iter_get_data(b),
+			ie_tlv_iter_get_length(a)) == 0;
+}
+
 void *ie_tlv_extract_wsc_payload(const uint8_t *ies, size_t len,
 							ssize_t *out_len);
 void *ie_tlv_encapsulate_wsc_payload(const uint8_t *data, size_t len,
diff --git a/src/mpdu.c b/src/mpdu.c
index 9d0409d2..09df696e 100644
--- a/src/mpdu.c
+++ b/src/mpdu.c
@@ -398,9 +398,17 @@ static bool validate_mgmt_ies(const uint8_t *ies, size_t ies_len,
 
 			memcpy(&clone, &iter, sizeof(clone));
 
+			/*
+			 * Some APs send completely identical duplicate IEs:
+			 * Since these are harmless (and ignored by us) we're
+			 * going to allow them here for interoperability.
+			 */
 			while (ie_tlv_iter_next(&clone)) {
-				if (ie_tlv_iter_get_tag(&clone) != tag)
+				if (ie_tlv_iter_get_tag(&clone) != tag) {
 					continue;
+				} else if (ie_tlv_iter_data_eq(&iter, &clone)) {
+					continue;
+				}
 
 				return false;
 			}
-- 
2.30.2

