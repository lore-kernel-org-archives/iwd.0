Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB7320B7F7
	for <iwd@lists.linux.dev>; Wed, 12 Feb 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377449; cv=none; b=g8VapwGt2xr2E4zjvaxuzYqrHJ4Pp62FIrGk7PQlOLSK/SDDtD319ybWQK0nHSxbUJe84NRiAxMRu7znn5ITnUBN6zCH8b8kvRnn+A/0eA0M7rO43rBjhlOv6fm/6HZDidtpxWtCM7KK7E03BKggl0BnH4zoBqIXWeIDlsu0o7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377449; c=relaxed/simple;
	bh=ykejZzXyXZzTxqDjHa5U7M2vXkmVWua+9D+cVByWsOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YqwJQq3J6A8Wb0m9jxVNntbIx+otesU80BDpoJqUkdU4yFDfj2Zr79n0us3qU2hlFbHl5/5d9+5gnEUxzd78tGuHIqgg0wcKU4trgWrY6VjSOKqePMLpW+dPFFylJEYnU6XrYDcvxBkcCaPOX/j4gZHNFfvJ16zrPOSPn8q1zAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKnoVFCI; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKnoVFCI"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c05d75007cso479449085a.1
        for <iwd@lists.linux.dev>; Wed, 12 Feb 2025 08:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739377446; x=1739982246; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pCkHdx9LiuuyEfXsXgtMCMDq8bWGJ7vMMayCSWHOZo=;
        b=mKnoVFCIBtQogk18EGQS81VsiXKN0Kv9jo5jDcZMFArsfkMp6RQDrTuuW//PD0MMfA
         ofq6OPMuF24vEsxRaJSq6NSGJqf3udsnYJM2i4KNqivl2r3iY2G1AYoGRRbzyhNCW+N5
         T1Zx62WLND/wE6qfvc8T9aXo6RGrlMuVn40Op4O61zvoIs26P35EnlQAUqm+90OH5SpU
         c+DDeUTIk9TYKndEtTwtLJ1fMeWic6tIs2gsQenbJRLYVy9qq+iH8HEd1FGgPivPzVVg
         GhwJGNVvN/Nd9h8z4VjRKcoRIgc7lFAjNo0sP7oE00A7wWPIEt0KJE7kwK2cRadulz7Z
         lKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739377446; x=1739982246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pCkHdx9LiuuyEfXsXgtMCMDq8bWGJ7vMMayCSWHOZo=;
        b=NssFhpwnUgV31sXlNU3cap9mikwrcJMcAnjkS6doo9ixELa1xMAvlHrCDIHYHeucP0
         QS/DX/eDM0GFDuxpDZkgg8MMuO6Px/u4bCRM9Hj5JZnHAP/12yzrGB4QSnldCLPNaZ3y
         kVqdaehwx5d0MkFcWIaquJU331+mcjTquDIxMS3cHKKIMOcbjTX7qrOQ2EpIw+7BUvh4
         n0CrBFfctZ4HGqgxnutu1XWPNk1oTXVcMOxgmnbpHj/EveCcmKXFHtHsSAh7gQBPJAmc
         sapMDXKAT51zE/nOPHKzAsfa0Zr6i5zC/uQhVZgWfLp7Z6VBgNqLtYazRKdLv03mPCzi
         MWXg==
X-Gm-Message-State: AOJu0Yw6N7u6KBATjJPLO7a/Z3U9jldt7FfxIeog2adMyAI4f5HczO8v
	phi3KvKf9uOlqe1N1lCsMu/k7xOHOki0GikRWXgzE+nIW9H9Js2z9TPGHg==
X-Gm-Gg: ASbGncvJVhhDF0ejH9BubW5e3tZhxyBqz1iy7kc8Rx+wCXX0c040u7wk83uKVM4gvb5
	M3JUfEBZf4HdHA+Rs8hddDqtI6ctm0r9bSBq1re0Nez2CZOMfQt7S7G5GnN3aoMC7hEtptLzeBf
	RFjkYg0lYSBBakry7lbN2GkCMCajF5jS+NHXPuTWqBmIkw3Clc7v5Mr8apRpljtGP6kMUhWiwu7
	u6rge7F87sBaAT+CS96O3bhvJzZob23PaF5FEoTcowOJUolvLWLN+/3GyHW/lG+JVUHdF7CeEVa
	s8OuPOQZAooGBvLETFHU8Zw6TKlObonYOFzOmTat9vfLy4W2+w==
X-Google-Smtp-Source: AGHT+IFyXqkZBgcAeRbcSOhTAT8QvVPoVbitEDdIEgFy8cszCEQmpso2ckI3FML2cjRJ5CAw82L9Vw==
X-Received: by 2002:a05:620a:192a:b0:7c0:7906:966b with SMTP id af79cd13be357-7c07a13ea7dmr3069385a.22.1739377446371;
        Wed, 12 Feb 2025 08:24:06 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0768e23casm73272685a.44.2025.02.12.08.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:24:06 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] netdev: don't set CQM thresholds for fullmac cards
Date: Wed, 12 Feb 2025 08:23:58 -0800
Message-Id: <20250212162401.130792-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212162401.130792-1-prestwoj@gmail.com>
References: <20250212162401.130792-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since roaming is handled by the firmware setting CQM thresholds for
roaming is pointless.
---
 src/netdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index ecf61823..e0a39851 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3827,6 +3827,15 @@ static void netdev_cmd_set_cqm_cb(struct l_genl_msg *msg, void *user_data)
 static int netdev_cqm_rssi_update(struct netdev *netdev)
 {
 	struct l_genl_msg *msg;
+	struct netdev_handshake_state *nhs = l_container_of(netdev->handshake,
+				struct netdev_handshake_state, super);
+
+	/*
+	 * Fullmac cards handle roaming in firmware, there is no need to set
+	 * CQM thresholds
+	 */
+	if (nhs->type == CONNECTION_TYPE_FULLMAC)
+		return 0;
 
 	l_debug("");
 
-- 
2.34.1

