Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D1D302742
	for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299309; cv=none; b=qTCNCq+uVDn88eX0EFfMWsN9lk3avzt3BPMOMJniMTo3PLgF2658pch5ycxHkneLxUI1qOAVWzQIKVx09C5QNLEnE/BkUUf2oa+PivxgVwUv3uSq/ihxgPi9Gp4lCLg22rG95r1BBUvOrbBouhBRIHVj3lnqPdTcM+2Cqx66tJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299309; c=relaxed/simple;
	bh=kF2+wLENh/nOoTo2tlCIAbvtoJeHdnG+V2cqkB1fYuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EKgXFRKNYoHbaU/T9n/fb6rEIAaOncgax/Vmf77G2PZfdlHnV/zMQLh/na1Bd4dPsY/49JGdES5Fsl0ahV2w24QPrwIE8lOQK6J9DKGa9LfY4B7oyGTRDUdkfiGzQHs0tUCJl08sY6r4XlJNrdLDurrRR+dho3yoIXNCQcXRaCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLEsh6fJ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLEsh6fJ"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7720c7cbcabso276415b3a.3
        for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 05:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756299307; x=1756904107; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+VP+Tdg3cGrdOrAg8mTfHa0HMyM/+yTWr91yeBovfo=;
        b=jLEsh6fJIjFRIaiEOBfNPuXcabC5djh1UJtvqlqiiGV/lCsUQ++q/U9OyhsZdqRwuQ
         qUD08HAie/6Qu0OZO2otlRnJ/FeF50kDyr0HXnAIaQudFT49D3cQHo96S9NpymCgZ0ld
         aK51hHb5F3biwlHukeoDqoxz07wqQFlogmcRDoNm0OpRAxFeLjYNuEzWFG3ajMrerSrG
         90S4MXjmjO4ZeRDUFkHMueGGkFaQGBUkxl452JjlBjamWrnQS0h1IayjfQ9EgMCJSDlw
         tBYheJEaog9dmTq2ATJyCJGfOjynVJLVJkTCn8WGx8JMRtbTHzSdtF+OIQwVbHgyzN0s
         h1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299307; x=1756904107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+VP+Tdg3cGrdOrAg8mTfHa0HMyM/+yTWr91yeBovfo=;
        b=HfZwSAw9rf5d4n3OYTxllT+kkMjaOZZwNCsQq3Td8hpHR2NasICz3Wo6T3NzSNyFIG
         fomHXHSEnC9avkn/9JstDupGKy5E1ybAlGgEzC5Mgz4P1HZI1S5uc5iVFoFyUnEuf1II
         wocuVDZO26KO6WjXRUJbQyGjPMDBvw8n32KzMwo4fOyyh3BzL5MDp27i7d09O8TJy0wc
         dR15/ww/vlkE0ODHTlqbLdkoLuPIuzdySjyNaKhnj46i+e7UcPn9tWGoNMsblfUf0nQv
         cMOlD62EWm09h+p/USoamb8CW8LtzT6hfHX8gZ4z+KD8mdL98QlDvU2JFaSZHfdoF77O
         ydEg==
X-Gm-Message-State: AOJu0YxhEbwOQGY+ZbMzhg+cT0yH/l2fsIdkDgwJwePkUZh9vv2aGFLI
	8sG/Z0vSJb9ga8SzXN3AhIXQJnu7cEZChFtk8PdoCyLHzttD4qQC/RT2xJHF2w==
X-Gm-Gg: ASbGncvJZYMKPBuwHKsfbyI7s01WB0iAZCW78dQpfv+Y/G5cws6ZDCx/pmIGuJouogj
	OA2K1dPiupn5HQ5RZaF8AHhu5h93F4Wjj53hc0Cp+P4P7I0vOPJFxdv+e8LaAZWXcLp/WiduIf/
	3+Y6VSwhMqJWMS1ooF138V4uDlnt+G0Kn2pUkVf12cigRR19Q0rdmShA1QJBKYu1W2oo4zZp3+z
	c9ey+WxgpssP3kn/usZGBM9WWmiM5TxbbTSgkUf0QiGt6unAURlK9VlvWd81Z/yuv2HoDzUwUqq
	XE8EqvDqAgvWkQGDNO6rLPEwWGJwpx1gm6AyozHF4mrnmxuzAIG1cV0nTCcSUSZureNSVNmc42s
	y7ZafatU7KrcI1rXWnfzZLCpNIL9Gooj/4r4zs6dxPSoZ1oJIwxo7hW1oeB19htFmmQQWbQn8Df
	/2QdTgGEGd
X-Google-Smtp-Source: AGHT+IEry5zcV0slWTaNS4UlDuLAmeTxbO9KRhLgd+Nd7ZPOvrDMlXBXAjdp/GsrzubPSSpBoU5H9Q==
X-Received: by 2002:a17:902:f606:b0:246:e8cc:8cea with SMTP id d9443c01a7336-246e8cc8eb9mr107637385ad.22.1756299307088;
        Wed, 27 Aug 2025 05:55:07 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687c75b5sm121650955ad.66.2025.08.27.05.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:55:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 04/11] handshake: add vendor quirks into handshake object
Date: Wed, 27 Aug 2025 05:54:54 -0700
Message-Id: <20250827125501.477908-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827125501.477908-1-prestwoj@gmail.com>
References: <20250827125501.477908-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/handshake.c | 6 ++++++
 src/handshake.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/src/handshake.c b/src/handshake.c
index 92edac30..02dfe2d8 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -368,6 +368,12 @@ void handshake_state_set_vendor_ies(struct handshake_state *s,
 	}
 }
 
+void handshake_state_set_vendor_quirks(struct handshake_state *s,
+					struct vendor_quirk quirks)
+{
+	s->vendor_quirks = quirks;
+}
+
 void handshake_state_set_kh_ids(struct handshake_state *s,
 				const uint8_t *r0khid, size_t r0khid_len,
 				const uint8_t *r1khid)
diff --git a/src/handshake.h b/src/handshake.h
index b8891490..9ddeecd6 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -26,6 +26,8 @@
 #include <linux/types.h>
 #include <ell/cleanup.h>
 
+#include "src/vendor_quirks.h"
+
 struct handshake_state;
 enum crypto_cipher;
 struct eapol_frame;
@@ -107,6 +109,7 @@ struct handshake_state {
 	uint8_t *authenticator_fte;
 	uint8_t *supplicant_fte;
 	uint8_t *vendor_ies;
+	struct vendor_quirk vendor_quirks;
 	size_t vendor_ies_len;
 	enum ie_rsn_cipher_suite pairwise_cipher;
 	enum ie_rsn_cipher_suite group_cipher;
@@ -237,6 +240,9 @@ void handshake_state_set_vendor_ies(struct handshake_state *s,
 					const struct iovec *iov,
 					size_t n_iovs);
 
+void handshake_state_set_vendor_quirks(struct handshake_state *s,
+					struct vendor_quirk quirks);
+
 void handshake_state_set_kh_ids(struct handshake_state *s,
 				const uint8_t *r0khid, size_t r0khid_len,
 				const uint8_t *r1khid);
-- 
2.34.1

