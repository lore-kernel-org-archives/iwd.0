Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247D914C5B7
	for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615511; cv=none; b=BFRvuxtZif9NXVI4SFIQurbsE1QgBrKAUH/2gysRP8TwzZnhyOBW/wpOHbNN9V7RmKbOsLrbOT+WktjUwNsjsG0ZriZ1tJd8ekfIEq3mgau2nAlnQfBzeIpL8ORaTpAL/QxQVGhUwzPuQDP7HlSM/2RlU9VK7yLLVv//HEAhN1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615511; c=relaxed/simple;
	bh=OPTjDuDsRK7620EYtq3/5CDRjuN0n7CJU5rBzGMT2JA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kfQqYgu9vx9fVYLQGRAD3RXvYaJ+y87jab59t0vjRK0JPzelRP5UziYrGJHpPtlF8i4Wi3Xw6EIheTlCtCIvnLbXzgm+LlxoxTvE6Xgtb8tMzKu3AcVY+oGu3YDWYvsIMszs8KJoQEWSVDTgT7duXtAkR/xo951UxGWasV/Mods=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbdlhEZG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbdlhEZG"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7232dcb3eso49160885ad.2
        for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 07:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708615509; x=1709220309; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JypMPKGmXYBsDH+kYyFeMEQU9sI1BHdfLWt+nnqgLz0=;
        b=FbdlhEZGAkjIUih/NOlGREyHs+IXdHjpkktY8HEu01sFnTop08E3jsRa5mLTEBiPWS
         +lcgzaWw9GE9NSUBSNgSes0l1ajvbn+/hJLYlIRuEOVWwAIiCwBZC7m2at3+BHpGVmaE
         P54nA0mdVlaGrXpc9q9fnmcDs5VvmFiFvRV+q28r7Hij90A0qj6cxb9WbsAUTjLi0j3Q
         YO0zhfCfU5KDB9tWlnl0eeTpq+3uebyOfh/jKDoDMx5Jy3qBdshEW0HCNOdJfL20feFZ
         /Hmcr0E4ZwQ03/+m6A7AKS50TyVLmmAX5a0bnOzxO1UtS4wCzlVm8Vevm/9FLhyTsah4
         sgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615509; x=1709220309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JypMPKGmXYBsDH+kYyFeMEQU9sI1BHdfLWt+nnqgLz0=;
        b=EJu+Xq2srOBu+fTufOaiJVAcIe88GxQiqIb5Ll+1K6sUzWA53G1EAgdbW/56jxXGq7
         tpnJ85MhuZkcqI9xou1fiVjCJhsLsMw4JRfAPZhJax435YIy3LwpPjSZRH4NydnpnFq8
         ITj0t3DFsiZ9eS6QHa0Pa+pfZXO6W+cSG4VP1xBdufhvLTLd21vUwgRURiP0A3a1YaNM
         hqU7ET9XFZaNaU9LKX7f+lZVt4KX2u8fIf1ammTcOMnHA5lLNDqmQkHJnfDJ+dLdzcmI
         dOhax+eJF5zFXvePjYRdZJRXfVuauOKDXKOtOsoN6Up7RqGfApec37tHUI+KeYPoCLOv
         9oww==
X-Gm-Message-State: AOJu0Yxv5LrGYzx0qsc+RbAuFnGCeAkp4cZ737/BEgTfxsxNWKe9HKIi
	63JsqkMPyik8hu9vpIdzAjORiS9QqSpAGA77tteQ/JjCt71yr+51IWDcwyQS
X-Google-Smtp-Source: AGHT+IGIC45DWrRJsqvdscCMDaKiWyj+jR8pt4UeIvNNezrt56NilewpKlvjzDn7HHi++bBSPG/s4Q==
X-Received: by 2002:a17:902:7243:b0:1dc:49ab:98b0 with SMTP id c3-20020a170902724300b001dc49ab98b0mr2004720pll.35.1708615509260;
        Thu, 22 Feb 2024 07:25:09 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jd20-20020a170903261400b001d94a3f3987sm10044873plb.184.2024.02.22.07.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:25:08 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/7] netdev: add notice events for connection timeouts
Date: Thu, 22 Feb 2024 07:24:51 -0800
Message-Id: <20240222152451.1541682-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222152451.1541682-1-prestwoj@gmail.com>
References: <20240222152451.1541682-1-prestwoj@gmail.com>
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

