Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83C212FF72
	for <iwd@lists.linux.dev>; Thu, 15 Feb 2024 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005213; cv=none; b=NCvcEZN83HVFyXvkq00aRduwtnPcNM+tQ4pKEIwecfZf8zTdXGECDWfBPbYU0ifjLmknsLTTaO6Ki68cBXKhHOmlpyze0sF0laLfCKJ9J4Y40Ba+EieXGKpeUQplwS02Yq/T6s5S/aAMPJJfy8ZQyFmuu5xg5blOlx9cXuTHk5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005213; c=relaxed/simple;
	bh=OPTjDuDsRK7620EYtq3/5CDRjuN0n7CJU5rBzGMT2JA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dq0U3Yk1ZCXw7CWVoaqiWRo/QhQY8EJ3+760YSAeUkwXWInKXjUqGZNfHPZOkSa5xb7oo69dOvsrdQtIdf0zpw8cnsodlosH8L0Oltqkr1rhA6w2t49/nh6NkB0kfNgm21NyNiLYK9P1pakPv0JSLKIbr7Rtmh1utWHz2FlC5Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXtqQxKd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXtqQxKd"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d51ba18e1bso8759235ad.0
        for <iwd@lists.linux.dev>; Thu, 15 Feb 2024 05:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708005211; x=1708610011; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JypMPKGmXYBsDH+kYyFeMEQU9sI1BHdfLWt+nnqgLz0=;
        b=AXtqQxKdvrs4hSQypJbpaBKgHxbgpo16zxsjtFppAKFsnlhrXOubfY1SkrtGVzb8gO
         0syvBWnectJJ9A7hrpjs0qGgwHBZBpNe0Okecy8p/H4yZmbrSRkqVyJL9+JCIhPnyDOX
         hP0FwmbtNamTi0w5P2LLf1TXBboj7zl16ceiIIIOuRaNbYZV9LKiRI733/DvqkAEpx9V
         GGzlY2N5bKBIJ3xllulo1TqBafssIpv0NZPzAGci4GUDwuTHCNgd3Mcm1U0bLWfz2ne1
         Z1So/p8usoinBaccPzdjZFFJQKQpknS7P/3/gzv5jT+UCbTrSWlvP5jqA9wESCNEeqrZ
         fbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708005211; x=1708610011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JypMPKGmXYBsDH+kYyFeMEQU9sI1BHdfLWt+nnqgLz0=;
        b=DixDLmI5BV1MLslhwxANxb8CJ0Kwaz4x/GyyURGlBrujGdi3FujdSKrkj2sA7dxjBh
         z+PyPZGWuCssQdcsZ7YlZe7pm4/M0cCQb+brYvsaiJ4BkygaamS0F/t/1HsGN2mNGFWN
         zY9dmokfAM842fO3FVMi5M2Y4XI2XwrcUYEGbXIxO0nrCEr9GU6Wl3KqW4j5HAj/6784
         V+PbAGse1phBfh3+cNGl1FeGSljcOZ0I4axguUPdwOnl6YTGxDZPqy+obVCTLw7NhcEu
         PEUdVe2aTWKJcqtGroV+AMImHKeDBNGPDP4O5qOc71xNWgINXa8/nlXYo9s66qDwq5jW
         h98g==
X-Gm-Message-State: AOJu0YxNe3wkP26UqULWoWBMl44pweU2gaBscO9Yn/JzYMNTxKD1TlGf
	4qddC2J1M14hYG4cZEM+0qsEvJw5xPMbDkSOL0gIcOBus7+JMQyuBLqdFZfYSdk=
X-Google-Smtp-Source: AGHT+IFLcwf8WP+1XA1K5EqgBGrNIy/C5U8AVvH+q7DMyi2vdUuIMmtLcwTQHR+TJuqW+CJnvVIImw==
X-Received: by 2002:a17:903:124f:b0:1d9:90d6:bed3 with SMTP id u15-20020a170903124f00b001d990d6bed3mr2092363plh.43.1708005210959;
        Thu, 15 Feb 2024 05:53:30 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001db55d2e1e1sm1284787plq.63.2024.02.15.05.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:53:30 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFCv2 5/5] netdev: add notice events for connection timeouts
Date: Thu, 15 Feb 2024 05:53:14 -0800
Message-Id: <20240215135314.1017081-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215135314.1017081-1-prestwoj@gmail.com>
References: <20240215135314.1017081-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The information specific to auth/assoc/connect timeouts isn't
communicated to station so emit the notice events within netdev.
We could communicate this to station by adding separate netdev
events, but this does not seem worth it for this use case as
these notice events aren't strictly limited to station.
---
 src/netdev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 48fb15df..8a7ff092 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2639,7 +2639,8 @@ static void netdev_connect_event(struct l_genl_msg *msg, struct netdev *netdev)
 	}
 
 	if (timeout) {
-		l_warn("connect event timed out, reason=%u", timeout_reason);
+		iwd_notice(IWD_NOTICE_CONNECT_TIMEOUT, "reason: %u",
+				timeout_reason);
 		goto error;
 	}
 
@@ -2931,7 +2932,7 @@ static void netdev_authenticate_event(struct l_genl_msg *msg,
 	while (l_genl_attr_next(&attr, &type, &len, &data)) {
 		switch (type) {
 		case NL80211_ATTR_TIMED_OUT:
-			l_warn("authentication event timed out");
+			iwd_notice(IWD_NOTICE_AUTH_TIMEOUT);
 
 			if (auth_proto_auth_timeout(netdev->ap))
 				return;
@@ -3032,7 +3033,7 @@ static void netdev_associate_event(struct l_genl_msg *msg,
 	while (l_genl_attr_next(&attr, &type, &len, &data)) {
 		switch (type) {
 		case NL80211_ATTR_TIMED_OUT:
-			l_warn("association timed out");
+			iwd_notice(IWD_NOTICE_ASSOC_TIMEOUT);
 
 			if (auth_proto_assoc_timeout(netdev->ap))
 				return;
-- 
2.34.1

