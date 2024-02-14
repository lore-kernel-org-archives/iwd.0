Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC8C5C905
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939539; cv=none; b=Y7pjR7XFlU53OsZOCIKvYOzj5TaejB3D/rCBMBI1UmbA+7vwpVtBOxwzS1AqrYchSje7gQGy3TuDEfpLslq8JxbEolh6cye9ZeP0tIaFxqvXGrQRbKtiS7lid8b/PPyuRv22RufnVyCw2AsudA0c1HneBaRZkRKEj+7fuMhcn6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939539; c=relaxed/simple;
	bh=maL4fwIRXzzNZlSLRxDll4JrkGtQ2cJKwVr7KHntFrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RTZM1oe9f+r6W2ivYKKtlwJvNRy9V8CcgKKcVN2o4j9b0z0PqXAUQaOJ64cbvTUKWm8v5NA/gJn05roxSs0Q3BQeocksdwuZVLaiZLtOlc+bAq9KYwNd5CZYVJfH7HBKcidK40PkwcEqvQHKsG4vjDB1CFi9nbUJXI2oPcdkivM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJDEfDGu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJDEfDGu"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d932f6ccfaso893175ad.1
        for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 11:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707939537; x=1708544337; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcsB0D0Znm1KShBRPj68Fl4RcuiUzTTN/UICyWBNJ6I=;
        b=PJDEfDGuLDp8eY93t+YbMm4DbjvU89pHElAezHngw5c9J1ZRXtUpSFhH2sF5DtpwYL
         stW3h4At6YxaEOSLG6pKCz3p0S5b82S8hu8WU8nSM0OnZBSiU6mzJuWhL47wu5p0qOf2
         fQbT6pS1gynWHG1noQIRiq0OOkLL1Bl0e5Qy300qBw97Ey1zziA8gVjyYg9ZTBd/pYbf
         jis0ooNbTxN64Gmni2SAuVG6fgjUFdN00THvhM2u3bzyZSxFxN0TJms47AeeyKTV84DF
         AXhcw5eVXCdjOkG02vP0DAIzqFnNdGBhfBPaOLFTV4HZ1PhVk5RVnRNRFKBRrlidVrOe
         cU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939537; x=1708544337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcsB0D0Znm1KShBRPj68Fl4RcuiUzTTN/UICyWBNJ6I=;
        b=pI88xz7lalaIWN6tci2wxgj52aqMRSRCNh1fCmGLn1HJINh3m4khp5UB04/iUfElGu
         KPydcoudVj7vt0YfkAjd1dmSz0fpvJ39jABZinfAN4s4z65j7VV5pQ3jJWRp57bBdV5g
         v+HAavgeBuai5mUkPO2KbqLYc60VXXySHBCRxxjeSZ8xeOhEcfDbB1FqrQrzpbY943qt
         kkjfSZMfHQ0XH9gwZ2umOVv+RKpGqQnTAeUht58XF/WeAhJocjJdhi7WMl/09CoQPlFT
         r4QuySmkQCScCE7SCz2mqqzKdtTq6joR+sUis9ZksRjHDhsiruv3jiHyHigLP6wobz+n
         0H0Q==
X-Gm-Message-State: AOJu0YzlSVNyO14obY45vmnft6J/Af7joG66nKakcpBQWbI0YRXED+Ab
	aOpTVQ7RX05strWyvByKnbQ71O7FPkfibKuf9MJnm4Mp+gKcVPGik/kupLsfdo4=
X-Google-Smtp-Source: AGHT+IE0NIwC3IakL+8+lpigUg/FJNtUke0CprXx64UxGlf5Tdo0wtqi6Po0HytIoDe+1g6yNKGEyQ==
X-Received: by 2002:a17:902:c94e:b0:1db:68a3:86e7 with SMTP id i14-20020a170902c94e00b001db68a386e7mr2153871pla.60.1707939537508;
        Wed, 14 Feb 2024 11:38:57 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id v2-20020a170902d08200b001db53ccb856sm1761606plv.108.2024.02.14.11.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:38:57 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 4/5] netdev: add notice events for connection timeouts
Date: Wed, 14 Feb 2024 11:37:42 -0800
Message-Id: <20240214193743.963349-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214193743.963349-1-prestwoj@gmail.com>
References: <20240214193743.963349-1-prestwoj@gmail.com>
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
 src/netdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 48fb15df..a213b606 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2639,7 +2639,7 @@ static void netdev_connect_event(struct l_genl_msg *msg, struct netdev *netdev)
 	}
 
 	if (timeout) {
-		l_warn("connect event timed out, reason=%u", timeout_reason);
+		l_notice("event: connect-timeout, reason: %u", timeout_reason);
 		goto error;
 	}
 
@@ -2931,7 +2931,7 @@ static void netdev_authenticate_event(struct l_genl_msg *msg,
 	while (l_genl_attr_next(&attr, &type, &len, &data)) {
 		switch (type) {
 		case NL80211_ATTR_TIMED_OUT:
-			l_warn("authentication event timed out");
+			l_notice("event: authentication-timeout");
 
 			if (auth_proto_auth_timeout(netdev->ap))
 				return;
@@ -3032,7 +3032,7 @@ static void netdev_associate_event(struct l_genl_msg *msg,
 	while (l_genl_attr_next(&attr, &type, &len, &data)) {
 		switch (type) {
 		case NL80211_ATTR_TIMED_OUT:
-			l_warn("association timed out");
+			l_notice("event: association-timeout");
 
 			if (auth_proto_assoc_timeout(netdev->ap))
 				return;
-- 
2.34.1

