Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B481D7482
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806869; cv=none; b=h/hBjJEKLZpGbcM9BwB2UyMktipRvPn8HJkWIApEf6VNwQseHkMZw9GRBVMhARTrWMQC0J3LKW7b+NGX9+P8TTTvcgG+D/c91SbMyYWbaREd1/54fTy/ptDnbE8/75cTbUUyns+QoEp4llpRZfd44Veku2qkhG0cuyx++fznRk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806869; c=relaxed/simple;
	bh=L2d7SjvNztX9oaRDX6Cn0YsACv9OG0P+cVAbS6jXgO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R+V64EY4P6rWkFOSoYlNZoWQLsRxA/QoXdZek1Pq068KrKDa7bG3oyJXH55Z9as8wRUuuO31VfAw+HwxuVtJZCr9FtV0mjR+Nyno/v43D2m0flNXdI/mmFNMJpKThtmamARHvy6eD29gEEM3ufdAXgw6DMiVIeOt6QU80eLbg8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUT/jDGc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUT/jDGc"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so3213240b3a.1
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 05:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744806867; x=1745411667; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/8QrNsH8FRKdQ7pDgrlKgeRgAHiHqK1bOziFAxeH4Y=;
        b=PUT/jDGcpnIXPvQHJCpAf7jiq/SgFD/FbDHrIzCIpazRseMALjPGN0SgA4YuwmrlPo
         DF4vSr0AwsBGOdEksDNP6jk7Mxj5Bf442ZtKONuFypvbijo4+/XMYiCZI2snQjR7mvwg
         MCeqngzaIrzrVQtkB7mjdw8wTTLHPTzo5t9zS8YjwyL2rnFTm/wfU/CdYisyPYkG27r/
         9zLeqxpOfDJPaeT367KZfCD6bkk7TEt+UP1IwrzpakOMyUtOS0lPxP0KrUDwlBsVWfGI
         18xHpAb+1+7CDyQYsVUY+zPxHUZDwjq2ZO/LSYm6ThECRll6hAa2rRCXI+78lxqyPCs7
         xQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744806867; x=1745411667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/8QrNsH8FRKdQ7pDgrlKgeRgAHiHqK1bOziFAxeH4Y=;
        b=Y6y2D3CD9cZPaH6ZdoE4jMTLF2zIcj9I9PuQRqLYj3nMXbFuJuo+dLUhjdhvVtyzB9
         vLIpKBQ5zwALqpdHt4WJgYzW/4gRydzXbVgUGFwfD37XhkSsBnZZK5BtIR4bxzYATk4H
         SSKTlM3buw70exb46vipwYaBSwcPaesJWkItklKPFjRpATm51Eimyaa/4PUKVn1JHpUI
         8qF6rDlP/MTHaxW/m1OGZtrU9zedn3dZpKfgWb0OMWauBnmOWm7KcLdFP8Ktye/pGWQ9
         81NDkCMQ4KCQCvENPlFV6KKvk0wU1sYNkUshm6FmUDHiZFTSd9E57WeSzOxe9RTHzB5j
         j3/w==
X-Gm-Message-State: AOJu0Yyzr74/AVCgyqhwh1Z1/EcyOjSH9e/ixxlRNZKCLuTQkwP6E8kI
	Bw1nXLKum/Ra8oUr2XhCUq2w9rO8r/1Mmp1CZCtQDpjhA3lZXTKjjLbang==
X-Gm-Gg: ASbGncuOIUdlvP5lLRVb7QAU/gFFi0cFEQhYCpnUZ9jPsAZXNKLsY1V0X50g4I2WI4Y
	sdtt1mYuK3Juw0ReVt1TbHpd1andSQ0VU/Hc8tUE/zr1IXXJodyWubseYEqg3cfsrynQ609p/w4
	PqQak4NBUis/SdEtyH5ZuKWVCb9sfkXq0hFM5mwc+vhVk1JyNjshhVu0JNIW7g1YfXpfapAGAH8
	q4jB+QK02BMGcYduQFzXAhQ82DrHq06x0aLARTtxVHrtuWWjteDOobwOg6i5ZqN+xGBsrAKOvVR
	OrVWmeDYtICfiFjgXqdynM9BujUExUXuQEP2waBMp2Jw9L+LYsfFY/wkAmfPBPJhQHw9ZATDznA
	ijTJtA6M7eOvv4khzOCk2WSmuFts=
X-Google-Smtp-Source: AGHT+IF9sr5gBBVLLvYLtgeYw9bZbA5PWrkBZftKARlSvuCr+EWbxDKF/qiqGInhw4hdIms8kCHixA==
X-Received: by 2002:aa7:888d:0:b0:736:ab49:d56 with SMTP id d2e1a72fcca58-73c266aaaf3mr2199279b3a.1.1744806866586;
        Wed, 16 Apr 2025 05:34:26 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b22217ecasm1124408a12.68.2025.04.16.05.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 05:34:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 9/9] eap-mschapv2: Fix leak of state->user on error path
Date: Wed, 16 Apr 2025 05:34:14 -0700
Message-Id: <20250416123414.114231-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416123414.114231-1-prestwoj@gmail.com>
References: <20250416123414.114231-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/eap-mschapv2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/eap-mschapv2.c b/src/eap-mschapv2.c
index 1639f578..00976d73 100644
--- a/src/eap-mschapv2.c
+++ b/src/eap-mschapv2.c
@@ -544,7 +544,8 @@ static bool eap_mschapv2_load_settings(struct eap_state *eap,
 	return true;
 
 error:
-	free(state);
+	l_free(state->user);
+	l_free(state);
 	return false;
 }
 
-- 
2.34.1

