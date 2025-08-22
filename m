Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFBD8F7D
	for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892295; cv=none; b=gZqbrXSlYyAh4S6bvsgVRXq5O0+W6SElCg/1cpvK/DwIbLQmoSOKMBGVAwfiVIkAKf+JD356HWm/COvcbMDCIoCrBdRb3gbe1pv8Q5DeQwXfrvMkQpbrBN6oUWKjYQ4de5+GbpoSxrOEOR9mjW/VhwpKsBqhwUAMrXb1iC5Akn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892295; c=relaxed/simple;
	bh=ue2Iu5WxCdy3mfXZ1fhaWN+rcENAWdknsGgYR3p0zKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UOqveIvzzxmkYBJmTZ5TfY+kJCHsTkdpq2CsnZbv0wpc5ym5u6eBUgye7Syh+r7F/bq10OMd3D2Q9J7spoMI70vqnqzBOsd0d3g1CuusB80InIvsslybt5enMXodVU/nlIqKs7X7y395Bo7w6kKtEf3RufDFlp/6pqV3sidySkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4xJyJFi; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4xJyJFi"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e87031f560so352522885a.0
        for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 12:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755892292; x=1756497092; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/kvWZBXegsIJR+4jqdc+fm66d8SJHSv4xjUa/6E/NM=;
        b=L4xJyJFi0cRW/KaptqbpPNsMj+mK9rM79pJihUZ8c9yR1uOkajFwBdtS4Ddhva7YrB
         RKDUx8URMe1zcMt2H51A4TxponNHEMLQrCSfJddlqR3w23ag0/0JzJ5mI2EuaKC8owSb
         r+ottUauAL8+ZMNZU7F1+32wXzmGsyEJJDFA55wtu5weCI/RxeHtmCZPCwbxaKtEzTA0
         MHIvUnp5mvOF1ZxRONxAgaN8+7PopeEtzgPXiJxMTUiCYWyfRxBZnW5NrI620bJ1yy22
         udOEDPSmb3OvJBusRbucrzF3r51U1YDKYFvuB7KuAv7AcJ5XTTMZo+0KbSl8gArUP/qd
         9D+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755892292; x=1756497092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/kvWZBXegsIJR+4jqdc+fm66d8SJHSv4xjUa/6E/NM=;
        b=bh5uBEOOF7wwMZ+XdZmdodx/C3rwI1+XvDJQIq3H//Lgepp4OwaL81fu9k92ygcfMx
         Z9twmI6haA9GVyE9YOvtbEy+gd0ce2v9XJoHLixOMpvgJds/sniwYa09BCQ2ehOFNd4L
         UuvAlqycgK85biXe2oo38gczn+9oLBm18Ocwkhva04tCm73RIy5YeMf5XnLtqvtlFyHA
         20F7/IZdnSo/pWwMmviZvUJj/TC9PEWWo/TLW+kFbSLTIDQiGxlRpkaxPabhs8nZTikK
         oFfOcc9njcEqV5oIhNx8oYkXCkEIJY9+xwcMYOp/ObCJtn2GUWMh2sF+ketib2FBv5IR
         6QAA==
X-Gm-Message-State: AOJu0YwfW86x+q7DiZMGAdCQnUK9JR/JuEF+dvTcLUwU2+JMeBGTDcdT
	LUOOIVCdHkaQtUvmXjDy6RLsccGd0VP2ESRknXRsX1rLDjx34UomsW/Uxs6WVg==
X-Gm-Gg: ASbGncvETtIfAXNFXRwpvdHEueSegVyAvMId8AJruIiVxrqpwg3UKa29hjdnP+6AIxJ
	3YkF1XXIaLz2XV7gFDefyprxrwhexnNzwc3UegIx3cPoca8GHqEOz/nQbczE6N5hjtq/03SxaXl
	c+uLiOgfPqt5C/LQxmoZtAt0L5fT0ezpKaj1pT+v6gLsNb3+75JKxgJ8KLkxZACTkUqukrxGCYR
	sQZvE8WDowfPV//cwQw+Y4J95U0+GAmZf1m83UlCe+tLMKMd75dwsfQHFuU4/69FGCjsVDINyMu
	LgSWo3YYwvxSi4+FNy5fHfpVYb1aPleqW8eYYb7HahTqvq/oJtKq+XB8ELShvK6w/aHOvZDVP3z
	+kYnXAqK8ayI1BE6QsOpEpyhtWBvAj0cM
X-Google-Smtp-Source: AGHT+IFWdS7vJUsnVwuutEf+BMyKHKNv5/RvTaznHKOHgw0IGXW3aU9DlDPlzQZjfHin4Tpo1FMukA==
X-Received: by 2002:a05:620a:1aa7:b0:7e8:4675:1f98 with SMTP id af79cd13be357-7ea10f53dafmr498290385a.1.1755892292525;
        Fri, 22 Aug 2025 12:51:32 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e45c4asm4913221cf.46.2025.08.22.12.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 12:51:32 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 08/15] handshake: add vendor quirks into handshake object
Date: Fri, 22 Aug 2025 12:51:11 -0700
Message-Id: <20250822195118.271122-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822195118.271122-1-prestwoj@gmail.com>
References: <20250822195118.271122-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/handshake.c | 6 ++++++
 src/handshake.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/src/handshake.c b/src/handshake.c
index 92edac30..02f0e436 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -368,6 +368,12 @@ void handshake_state_set_vendor_ies(struct handshake_state *s,
 	}
 }
 
+void handshake_state_set_vendor_quirks(struct handshake_state *s,
+					uint32_t quirks_mask)
+{
+	s->vendor_quirks = quirks_mask;
+}
+
 void handshake_state_set_kh_ids(struct handshake_state *s,
 				const uint8_t *r0khid, size_t r0khid_len,
 				const uint8_t *r1khid)
diff --git a/src/handshake.h b/src/handshake.h
index b8891490..df0f8315 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -107,6 +107,7 @@ struct handshake_state {
 	uint8_t *authenticator_fte;
 	uint8_t *supplicant_fte;
 	uint8_t *vendor_ies;
+	uint32_t vendor_quirks;
 	size_t vendor_ies_len;
 	enum ie_rsn_cipher_suite pairwise_cipher;
 	enum ie_rsn_cipher_suite group_cipher;
@@ -237,6 +238,9 @@ void handshake_state_set_vendor_ies(struct handshake_state *s,
 					const struct iovec *iov,
 					size_t n_iovs);
 
+void handshake_state_set_vendor_quirks(struct handshake_state *s,
+					uint32_t quirks_mask);
+
 void handshake_state_set_kh_ids(struct handshake_state *s,
 				const uint8_t *r0khid, size_t r0khid_len,
 				const uint8_t *r1khid);
-- 
2.34.1

