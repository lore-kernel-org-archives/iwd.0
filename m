Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCFD1DFC5
	for <iwd@lists.linux.dev>; Tue, 25 Jun 2024 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320804; cv=none; b=V36aESHwsfj67j3065kdgo3Ws2mTGZOpsNaOKw81RF1VCP7kAnG6zRQURoHInG8/zzFnZUo6J1Htx+joCcr0jI1ROh29iq+POhj2303p+bBQSbMa1gPKGSHp15u5yPQpmIwuZq6LtA/eC1xg5kS+KVdsz/ueZySOHTVgvvKydhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320804; c=relaxed/simple;
	bh=CoC/KIdxvjtpsPj6dQFrj4n+ScD1uofc7OC15kF1aqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rqtSB0hCJ1YOp9hnHHZz8XRyodeBWRoxzVNFXjuERWneJGy/dEUcKavt3CWLLBSUim9KJdpEAATArBedOWnIj0dexZydVc0p0E/MDTjWxj0fbHPEJxRWMrVZCDh3L5ZWzlO/kYttOc4DNW1ENe6R00GI7fZP94OYip7PGwxVaDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4TwR2oY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4TwR2oY"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f4a5344ec7so37383335ad.1
        for <iwd@lists.linux.dev>; Tue, 25 Jun 2024 06:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719320802; x=1719925602; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7s5jUFXHrWv1UL5cLoznJmUrDZSIR9KIuI8ExjIwP0=;
        b=H4TwR2oYPAu9n/W9F2mlhrezwatakEpf75kS6EKs34Z5MUXKjTmOjQVMRf+2/lcqT4
         7HC6mfv59D6SlaTL7cVTEDgn/xr9OjmMarzt6l4CiK+3Guz+Mre0Pc8KQ3ovPDIWLFR6
         evzRnGT/kI3WXwUpm5jiBt1hlcnnDF8uFZoy6MaVXrYJBYUVrtpYuoeYUM4jd1GJb4RN
         Arn9EApVAxsJJXwmf/sHrgyztWT/j6921dfyaeY4wtCxZLmitlQiLm68NkM3Fq5ip5lx
         6MABDWAEk9WF2YE7ANngENtOa+9xrrC1z9ZjlagMC+6C8UIgaXvXLpY7FWVAIlQmYdD5
         fm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719320802; x=1719925602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7s5jUFXHrWv1UL5cLoznJmUrDZSIR9KIuI8ExjIwP0=;
        b=N16aJUT6btYeLkSL29e/X0euUeUUX+IMRD0HdfyOfF6erGL6ya+R4YZF8ZG11vPdK4
         E9hEvhHaZ58avz+7HdnCnmVkQcOODEwmupxxMgciIk+gY9pKWvpouOoqfNtyVR4MCfB5
         b4NIZE19nf8RShuqB43LG/VfqF3OAC35+BzhQD3Mx/W/NXnnztxxZxpkAZ128WBvltm5
         uZ/MaVOqYgsodbBJD+fcl46buc/747brJnuzeHgyUN6vXbpP9Qkv1QoUHZuzkH/GuYFm
         uM92A70ZFGir4TXpgJAJvsdmNyfO3wVyzbnbaM1Dzm+fXf6V91mVbfWPL0F61pXZEsFT
         WQLQ==
X-Gm-Message-State: AOJu0Yymk20/MrVHuFi/TY6CHJ4nqptxmIeveTZ4QcPzn3Fhap8SIIqq
	kxjQ948mMJDuz06YS0wBnb8gPA1vHDf8kf6cYQ8aytHjjZHzSfAYgbtLjA==
X-Google-Smtp-Source: AGHT+IFGe98nHmrug9NH51Sp4zzQdT1kFfbVCuRX72MsTrRs/5Ak4r/wWEOMyirOgUaoDaBlb30XSg==
X-Received: by 2002:a17:902:d2d0:b0:1f4:6fad:ba59 with SMTP id d9443c01a7336-1fa5e674ea3mr58912375ad.14.1719320801851;
        Tue, 25 Jun 2024 06:06:41 -0700 (PDT)
Received: from LOCLAP699.localdomain ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5bf2sm80778305ad.189.2024.06.25.06.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 06:06:41 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/7] nl80211util: use nl80211_parse_attrs/nested for get_key_seq
Date: Tue, 25 Jun 2024 06:06:19 -0700
Message-Id: <20240625130624.385553-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625130624.385553-1-prestwoj@gmail.com>
References: <20240625130624.385553-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This really reduces the number of checks needed and overall function
length by using the helper APIs.
---
 src/nl80211util.c | 51 +++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index ac4ad223..eaf9f610 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -184,6 +184,7 @@ static attr_handler handler_for_nl80211(int type)
 		return extract_iovec;
 	case NL80211_ATTR_WIPHY_BANDS:
 	case NL80211_ATTR_SURVEY_INFO:
+	case NL80211_ATTR_KEY:
 		return extract_nested;
 	case NL80211_ATTR_KEY_IDX:
 		return extract_u8;
@@ -208,6 +209,18 @@ static attr_handler handler_for_survey_info(int type)
 	return NULL;
 }
 
+static attr_handler handler_for_key(int type)
+{
+	switch (type) {
+	case NL80211_KEY_SEQ:
+		return extract_iovec;
+	default:
+		break;
+	}
+
+	return NULL;
+}
+
 struct attr_entry {
 	uint16_t type;
 	void *data;
@@ -322,6 +335,9 @@ int nl80211_parse_nested(struct l_genl_attr *attr, int type, int tag, ...)
 	case NL80211_ATTR_SURVEY_INFO:
 		handler = handler_for_survey_info;
 		break;
+	case NL80211_ATTR_KEY:
+		handler = handler_for_key;
+		break;
 	default:
 		return -ENOTSUP;
 	}
@@ -568,46 +584,29 @@ struct l_genl_msg *nl80211_build_get_key(uint32_t ifindex, uint8_t key_index)
 
 const void *nl80211_parse_get_key_seq(struct l_genl_msg *msg)
 {
-	struct l_genl_attr attr, nested;
-	uint16_t type, len;
-	const void *data;
+	struct l_genl_attr nested;
+	struct iovec iov;
 
-	if (l_genl_msg_get_error(msg) < 0 || !l_genl_attr_init(&attr, msg)) {
+	if (l_genl_msg_get_error(msg) < 0 ||
+			nl80211_parse_attrs(msg, NL80211_ATTR_KEY, &nested,
+						NL80211_ATTR_UNSPEC) < 0) {
 		l_error("GET_KEY failed for the GTK: %i",
 			l_genl_msg_get_error(msg));
 		return NULL;
 	}
 
-	while (l_genl_attr_next(&attr, &type, &len, &data)) {
-		if (type != NL80211_ATTR_KEY)
-			continue;
-
-		break;
-	}
-
-	if (type != NL80211_ATTR_KEY || !l_genl_attr_recurse(&attr, &nested)) {
+	if (nl80211_parse_nested(&nested, NL80211_ATTR_KEY, NL80211_KEY_SEQ,
+					&iov, NL80211_ATTR_UNSPEC)) {
 		l_error("Can't recurse into ATTR_KEY in GET_KEY reply");
 		return NULL;
 	}
 
-	while (l_genl_attr_next(&nested, &type, &len, &data)) {
-		if (type != NL80211_KEY_SEQ)
-			continue;
-
-		break;
-	}
-
-	if (type != NL80211_KEY_SEQ) {
-		l_error("KEY_SEQ not returned in GET_KEY reply");
-		return NULL;
-	}
-
-	if (len != 6) {
+	if (iov.iov_len != 6) {
 		l_error("KEY_SEQ length != 6 in GET_KEY reply");
 		return NULL;
 	}
 
-	return data;
+	return iov.iov_base;
 }
 
 struct l_genl_msg *nl80211_build_cmd_frame(uint32_t ifindex,
-- 
2.34.1

