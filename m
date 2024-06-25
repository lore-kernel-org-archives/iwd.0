Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A1714D28C
	for <iwd@lists.linux.dev>; Tue, 25 Jun 2024 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320805; cv=none; b=g5i1p1pZccTXazeSMhs+GIcEGmct48KLPaYcM5XR2tw6G20KuR/MbY37lnndqcipDs6ObABCZeZb3N3y3ZLsskTfgrMFhMmVHaEvtD7IyMEAL7nnIwn7+DLY9JK/MGlJVnm+7PEfJGHuMlZtjjygDeNCp+QXOlEYZH9oC2HJ/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320805; c=relaxed/simple;
	bh=S5h0/COxgm0SpL29UrN3tnd96ZIrTl+ZSzPBft+cC+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nJq6QeSjosimR7h+wzu9rpVtRvsfpBXficXcx/EbpwGu7dy1X6gXAOfmrxmjDNBZuQUvy9vGZwti9JWX7JO67mfkRb6SzXEn5ONkbChM6rw6hpt0P/1Wo78pKpGGFUHD/ofnHmMlaesCq+4+XPq0PFsQul2jAbVwXcgHFUA+wt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbnIqs/3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbnIqs/3"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f4a5344ec7so37383655ad.1
        for <iwd@lists.linux.dev>; Tue, 25 Jun 2024 06:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719320803; x=1719925603; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8CBQYgpPSbhoWM3/U9KW2bBBLwbvBk02G8XBXzJ5KI=;
        b=KbnIqs/3HExu/tqM14xFQvxVTbyDRSS1yhp6LYQwM8E5eyR19XS2HP29jxvqAzuXaJ
         USW4f5abMczUlrFx639b58lB7bimdiwAcy6YvaKMLX8q2ECPhmTepMg307YlRG5vPaWQ
         Isav8CQ7L6xwC6xQsM76sxU0dNhmrpr7nNLxpcv6Yuv6juSXH0FStlHVvvWF0Xx5Lz9d
         0xcYGlxu+1ZyE25p0GAhWXRkQnJ68mlJQO+6+cMfiYXWP0Sge2H1NjxGDdW1nK2VA+b+
         iuzEE8fDB7sNbuuyNY8fY5CFKcHA/dB1gNuJZ8wTQ/jL+5Sk+SR3I+Btd1DV+i5oDArv
         3Ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719320803; x=1719925603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8CBQYgpPSbhoWM3/U9KW2bBBLwbvBk02G8XBXzJ5KI=;
        b=KBoPS8RptkMf2cpr7LhYPSp8Nc+ZfYawBaA3Zb9Ygxp5J6039wADYnYPuxxiXjZPcL
         RTJ4cKqr0Tuo5moF3EWUC21h+RP1e0BpkjxEG73CYnE4V5fpAjxY2ujkOOZIFM+BDc05
         vDacZ1sEXsMIWTtbDdxRTTlhXESjvS78phenIfdQ4sQh2h1+gZGOIcR7LhtN1tzgulqK
         ROyNeNobWh276PHWd90ZEOdp5XWZ7N78Vc6fq6nFH4TupH53ub+PZVIDyLYy6f++hgd7
         SBj2iYdZD3mN/tV+Cemiq7kaPuvjC7nno8GgZsMpuqQnV3RTZzv34G/OKoN09oT8vllg
         dIgw==
X-Gm-Message-State: AOJu0YyJ0UG/QDSr4uSH8+BoIcP/Z7MfnBmrLry5U54LHFRajxMtkrYa
	Tc5ET3hQZp05+HrvXN4H5wFkkFdkxCu6jWxIfvHOkRDes2udlLhvtqEEdg==
X-Google-Smtp-Source: AGHT+IEuxsQFux/lhjtSIB6EbP4rTAbosXJ62BV9V/nk9iyOtSbLVYD5NYObOQ17ogr5/i6JnUHnrw==
X-Received: by 2002:a17:903:1cb:b0:1fa:3b97:c93d with SMTP id d9443c01a7336-1fa5e698394mr45490855ad.15.1719320803385;
        Tue, 25 Jun 2024 06:06:43 -0700 (PDT)
Received: from LOCLAP699.localdomain ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5bf2sm80778305ad.189.2024.06.25.06.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 06:06:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/7] netdev: reuse NETDEV_EVENT_{AUTHENTICATING,ASSOCIATING}
Date: Tue, 25 Jun 2024 06:06:20 -0700
Message-Id: <20240625130624.385553-3-prestwoj@gmail.com>
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

The authenticating event was not used anymore and the associating
event use was questionable (after the CMD_CONNECT callback).

No other modules actually utilize these events but they are useful
for autotests. Move these events around to map 1:1 when the kernel
sends the auth/assoc events.
---
 src/netdev.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index bada1ab5..153001ab 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2422,10 +2422,6 @@ static void netdev_driver_connected(struct netdev *netdev)
 {
 	netdev->connected = true;
 
-	if (netdev->event_filter)
-		netdev->event_filter(netdev, NETDEV_EVENT_ASSOCIATING, NULL,
-					netdev->user_data);
-
 	/*
 	 * We register the eapol state machine here, in case the PAE
 	 * socket receives EAPoL packets before the nl80211 socket
@@ -2919,6 +2915,10 @@ static void netdev_authenticate_event(struct l_genl_msg *msg,
 		return;
 	}
 
+	if (netdev->event_filter)
+		netdev->event_filter(netdev, NETDEV_EVENT_AUTHENTICATING,
+					NULL, netdev->user_data);
+
 	/*
 	 * During Fast Transition we use the authenticate event to start the
 	 * reassociation step because the FTE necessary before we can build
@@ -3040,6 +3040,10 @@ static void netdev_associate_event(struct l_genl_msg *msg,
 	if (!netdev->connected || netdev->aborting)
 		return;
 
+	if (netdev->event_filter)
+		netdev->event_filter(netdev, NETDEV_EVENT_ASSOCIATING,
+					NULL, netdev->user_data);
+
 	if (!netdev->ap && !netdev->in_ft) {
 		netdev->associated = true;
 		netdev->in_reassoc = false;
-- 
2.34.1

