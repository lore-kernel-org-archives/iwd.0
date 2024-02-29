Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4298716062E
	for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230347; cv=none; b=Q+nW6dtz2XhXd3cM9h0rVBtiYVDSs01ini3pO2FUAimMf086kHcgfq4sanVwhDaQOfFFbOpd3Z7R2tWzM8CrjAXhPQaNp6dwXm9c9rlZVe84ZtuFizA0mcJk/HHG3agVjzIeNkTH+ugOK1RAgqmDPVlUNPRYUC5AFOlg+sHZ0rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230347; c=relaxed/simple;
	bh=DWiOEHAar973PghSXAZgRxP/Hftyl595KVjHNKnCjeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NR42/McolRzPCU8ANXphPm5ay3n0S/qt3SeBjEajkWOtd/B5aF+ttgbYZeZdeVnduoU+YYiXj8xlGaBGU7JMx7lyWkxoS8pLRpI9JQKk5bRLrXdYxc+9kWEX0U6ABacPfVpA7rUtAePjSbnbjOemA2mTsVKRVYdqnjQ2LmU03Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlMjpiAA; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlMjpiAA"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1a7d51fb5so990095b6e.1
        for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 10:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709230345; x=1709835145; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjqAu03B4BDxAKqLbGFRDggUMZqATfnkNUiiCO8E6f4=;
        b=hlMjpiAAbUOMMexBZZpw9Zh8798T9gHqo2vU1tkiabLGSMXSuij4sVTMt7YwtVRejD
         qZq7qGmEmiTe+1M2Qi4ewaI08Z33ysGb8AdrNnInWbm82V6LioFr6/9AgJaxdmz0RNnB
         On8lr5q6nOSFF951TXdPR/DpQADdswXYDG6uFUeBvpT9NKkRqw8CZ938oWCEGGQ2ztgN
         q0v/7qr/1nZJ38lz7ogbwC87G52KDV8M3HVYb+jBkiYWbclhnaFDQw60WRC2FEUaDxdn
         +dDCrQB/lUnVZQK3ebPyXXBvLDmImj1vywbmgQDlo1JTXWmAMGr9wEkLsblFN6XY4CA6
         T4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230345; x=1709835145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjqAu03B4BDxAKqLbGFRDggUMZqATfnkNUiiCO8E6f4=;
        b=hOIKrJgRESxWbC5jnEiK+ZCDIGcDvW5CgwbnaljI8UQVM4uueXrUJtO4dH108/4KIy
         +gD7fZmelOT3Uo6KzACpgP0vEZa53z5eq1X8IiuyfZADAS9ajHdr5xWt9YydVLS3iLyM
         sEVxcQLSLUUfO4lDuQqWJqDhvoPdSTeG4Q9BnqR39N+9YvEp7mHk9Knw9mudBIOO5E1n
         e73Y5pUkSfYlGfAXkTaIfXKLPsl4rw0zwl1xcFdIxC0jZecFwnGI/Ndh5FUwebem25j5
         JH73KHlmw3F4WymMQX3b/zK/ldVsebk5j4bW0lknGI1giaV49SBLAXOVUUKgUHp6AyRL
         VqTg==
X-Gm-Message-State: AOJu0YwQWFI2vb4fBYRk/f1kcak/6jHthLhk1oNiPcom8kAujPpCllxs
	5RwJdR8DgCOWAp1EwtQY3MtWAs3jqRPWjb2/yFW3XDEnWa+BWk4yAK0NlTat
X-Google-Smtp-Source: AGHT+IFMFT+Ewy+y4uU/LxK8rbvdWBqtN2/EFO02m7ZaJqcBN0EKZ8phCtc/P+lEkV2ssJ8REEK9AA==
X-Received: by 2002:a05:6358:7f0a:b0:17b:ee6f:b6b1 with SMTP id p10-20020a0563587f0a00b0017bee6fb6b1mr937614rwn.31.1709230344579;
        Thu, 29 Feb 2024 10:12:24 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id mf15-20020a0562145d8f00b0068cc0b46682sm994209qvb.4.2024.02.29.10.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:12:24 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] ap: verify ATTR_MAC exists in NEW_STATION
Date: Thu, 29 Feb 2024 10:12:16 -0800
Message-Id: <20240229181217.1503555-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229181217.1503555-1-prestwoj@gmail.com>
References: <20240229181217.1503555-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Caught by static analysis, if ATTR_MAC was not in the message there
would be a memcpy with uninitialized bytes. In addition there is no
reason to memcpy twice. Instead 'mac' can be a const pointer which
both verifies it exists and removes the need for a second memcpy.
---
 src/ap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 25d1b8a3..a6f8f306 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2963,7 +2963,7 @@ static void ap_handle_new_station(struct ap_state *ap, struct l_genl_msg *msg)
 	uint16_t type;
 	uint16_t len;
 	const void *data;
-	uint8_t mac[6];
+	const uint8_t *mac = NULL;
 	uint8_t *assoc_rsne = NULL;
 
 	if (!l_genl_attr_init(&attr, msg))
@@ -2983,12 +2983,12 @@ static void ap_handle_new_station(struct ap_state *ap, struct l_genl_msg *msg)
 			if (len != 6)
 				goto cleanup;
 
-			memcpy(mac, data, 6);
+			mac = data;
 			break;
 		}
 	}
 
-	if (!assoc_rsne)
+	if (!assoc_rsne || !mac)
 		goto cleanup;
 
 	/*
-- 
2.34.1

