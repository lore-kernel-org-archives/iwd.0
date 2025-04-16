Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF8FDDC5
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824837; cv=none; b=kQzXei1L1u0mxVZnvuYh3oRlOueJFxhPQvRK+LVDHrG/z03da/TzP44ybei6dm1W7FUMAiDyjS020xi5xI+1HMHwurml63L2YRMJiHGtH3bX597WGO/Xr1AprWVKLV+Nt+0s6U86PNJ6vO5/n1PRbCMvRFcoFzwg07QQ6Ue4YHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824837; c=relaxed/simple;
	bh=dnAh0hNNULRts5xVDY0QT2AYmER4tftL68IrsBPMwPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mN4Mr0iLm0dVflbKC+EsxcJsvNQHvHxsxeuu9cLjOgY9bXwvRmv+wcdqOcAxxcW8Of0XkaMRhAdl5sbQTp8SdupeAolhtAdqyxPv9eqUiTJJ8VrTya8bv4xVRNW/On2Ae2HIB1MpO6SBer1R1chid7daktFkccgQWXFVbkxk9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRmgQLD3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRmgQLD3"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223fb0f619dso80077995ad.1
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824834; x=1745429634; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbLhRUJxLcFIeWz6VpxzfDCs5nU8wpLLiYjEYwooRvM=;
        b=eRmgQLD3p6KgldEjb8SknlaYZTrMQboTcPwWc953oNyKKTHwlXriN3oerIlPcu8lUk
         U+5SN1J4HRwobP69tsdh2cA2csVngFqvP5c4hJU3Y4I6J9y4m7NY0b9xVbx+D6L5qe0R
         had0Zi5rAf5kC8yp7kZmg1AvzTIyqWY/g+VzL6ASrGVCptlH+sAaYMyGopM16CrO/KE4
         b9CJkDqAF4fKzpM5GZebYEZzFyoeI5YfZVgQimNtJ5s1+t5e/aHRhMi4zCO6MBTK2lYO
         Y+7pxXJuQ/RlW9xu0kpmmT247YKrHW/pYbvnq6qdFgEH4V1cdQW2qOW8TQYJVQH+Lhnz
         FsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824834; x=1745429634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbLhRUJxLcFIeWz6VpxzfDCs5nU8wpLLiYjEYwooRvM=;
        b=mx86IR3zGfAC0dj/9TgITiBhmtPTfHleAT3S2YnheT/eqt418a6n2qoLfXatk62IRm
         XpynAyVIASSoNs7Ta5QC10zDUXyMsocXbhUA3ON4jS7fD+pkW9b/JCSrwd2cI9wGgm85
         BkfmTPtqJtp17n6gxyz0X3QcWPxUiU7X5k0xBtkuN3L+XEBEpWoTcvEH9+3rkwd3LlP6
         uMzYYPDukAQ1+Hm3H4QhG2BH2DHbuOyz1+joGujqwhLE8i1kJzrcMxKZ+kwX2jGI4hKu
         1mw2zOtjNjmWIwhwfhUagJM0UE53cr0ppcVGQ0HFvyltRmJrjUVT/isubFkL6/tt+Uky
         E5tw==
X-Gm-Message-State: AOJu0Yxyzph5S5RjVuDTeUTDU6TaPvnFojTMWRp3Nu45rVKYMFGqrRx+
	i744L0k7cM76ftyiEt/uPYLSl0YnJwsE7v6IiS4DhMI6Lzcs4uWQskK4fw==
X-Gm-Gg: ASbGncs2yLcfpuGLibg56xJ6qJl5U1YW/n0+L+B25icyZcm65Cid6MWqzfVayWMyLPb
	b2GHGVs3x83WUMm/RUMZflKYmQNUm9kOj3wFenJyjSob1/pzBYMnsfKipfpeWQwxa49nIGFfB9z
	W3WVTWpwez7UwiFtzCP9ZbBUZfCxYZo/AZKepnL/cBtV0xbw01NEUqJGF4i4AqOmde/foWOMekf
	cIIjXq9PSvoWruOac+8YYNBShLtZCN+CndH6TDMt79rRrSXgcG3+PKJm+kkGoJfq+VmSycZ4P8S
	UuVQmQdjP4pxL3WLC7Ya0BN08Lx+Gr3QF0kwe957AovMXwITacI=
X-Google-Smtp-Source: AGHT+IHjZ1FPaDFhQWRmitF9aScEQddB3OFIeaYK9AwzczqJOCXYavrHsBSiSxRHnvjoq83WZWbICg==
X-Received: by 2002:a17:903:2383:b0:229:1717:8826 with SMTP id d9443c01a7336-22c358fd48bmr46785905ad.28.1744824834006;
        Wed, 16 Apr 2025 10:33:54 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1cd56sm17093055ad.83.2025.04.16.10.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:33:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/9] dpp-util: fail on duplicate values in URI
Date: Wed, 16 Apr 2025 10:33:39 -0700
Message-Id: <20250416173345.136025-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416173345.136025-1-prestwoj@gmail.com>
References: <20250416173345.136025-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAC and version elements weren't super critical but the channel
and bootstrapping key elements would result in memory leaks if there
were duplicates.

This patch now will not allow duplicate elements in the URI.

Fixes: f7f602e1 ("dpp-util: add URI parsing")
---
 src/dpp-util.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index cfdedbdd..1986a5cc 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -1166,21 +1166,34 @@ struct dpp_uri_info *dpp_parse_uri(const char *uri)
 
 		switch (*pos) {
 		case 'C':
+			if (L_WARN_ON(info->freqs))
+				goto free_info;
+
 			info->freqs = dpp_parse_class_and_channel(pos + 2, len);
 			if (!info->freqs)
 				goto free_info;
 			break;
 		case 'M':
+			if (L_WARN_ON(!l_memeqzero(info->mac,
+							sizeof(info->mac))))
+				goto free_info;
+
 			ret = dpp_parse_mac(pos + 2, len, info->mac);
 			if (ret < 0)
 				goto free_info;
 			break;
 		case 'V':
+			if (L_WARN_ON(info->version != 0))
+				goto free_info;
+
 			ret = dpp_parse_version(pos + 2, len, &info->version);
 			if (ret < 0)
 				goto free_info;
 			break;
 		case 'K':
+			if (L_WARN_ON(info->boot_public))
+				goto free_info;
+
 			info->boot_public = dpp_parse_key(pos + 2, len);
 			if (!info->boot_public)
 				goto free_info;
-- 
2.34.1

