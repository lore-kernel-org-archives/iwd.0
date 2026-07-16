Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB99C2DF13F
	for <iwd@lists.linux.dev>; Thu, 16 Jul 2026 02:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784169383; cv=none; b=OrBbRLFaVB9kg4SrGteB2OVrP1WLGh9LLzTMKrcqKfhGsSS4a9wi6AXS4Y9hujrCJkHiJrf7DdWS1RddzXrk7wOFMWNhrjqQ8qqSUdDrOg/u9h9ZKlTYbTCSF1db0R76BjAlPeUhxwKHhcKw5TESLvbfoOc0fAs92VuTQWFGvJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784169383; c=relaxed/simple;
	bh=sQrVW7djk4X2KDpHKBGcSCGAfIwDjjVUClGZdYLb0Rw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiwXvQV5Yn+A+FgSHms8Gq32dv8NT6qffI39iOIn1DXJra8Q0coRmK2TdBwXkAIlAM8a/ChQx3ywj4ixgqEGk22fvEif+VH80Y9hnE/+26YYouQT6ii/nVFRqQtIk3EPx5kpKHcU6yEshhjx7XvxJc9ixn6KD/3KwNjOlzOQAok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOnBy62M; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOnBy62M"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca913a601fbso4237955a12.3
        for <iwd@lists.linux.dev>; Wed, 15 Jul 2026 19:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784169382; x=1784774182; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZyBw/g2+AKDJbwL/LAVjexYI0CsEEln76lujD2+5tig=;
        b=JOnBy62MY+5J8TdqZBKMV4tuIWkJuKxbVUNpKUG9rYjLqL1O6Uid+DcaCTYWwOErpz
         /Mk4yhzs8POhB1oVF8zJCN7PQD50u0jOyeqFuUi01CP1OsQIF0wT6OLoCuGPQULxz51M
         V+n/LrAiiY1LOZkOXyBp0/iPiiZQTSu0H1FEJYahaArvWvqgUBYV8kKrdZobXB/V4lTz
         u2n64GJQMB1Ne4ldag13gxzwpyr31oSQcppxMHNg6HGlaZneEAfK7/ZwR2eT+Myd+7M/
         PXB8mtcrNJqHxiT+z3gweHmLoGWCEbR15gmmtLYdfzKczI6si0FsOdnyxkVkkhQfFSVp
         5NTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784169382; x=1784774182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZyBw/g2+AKDJbwL/LAVjexYI0CsEEln76lujD2+5tig=;
        b=QPcAPQzlC4P00AE1oL9FloMaJcMBeONNc3RLquf86XUIdmHdT1xWZ1csWOf+uf7ZTE
         L8sCOilDX32uziKYoUAX62uX/5DgYihAizAQ7o+bUOSCmLjcfoROSNAIeLy4IX8xOyG4
         w7OhZuq+0Y9oA3S5Kgr3UPv1CbNhrOThUOAm9OqaupbgTmMGFo2nWza6wMd8r1dTO/AY
         fRCf2xSYZqKGT/ThPJIWjxKckdFv+bnGQCb7DsNXaaxfchZMxSJTdP6ekoz3hjTP8yY2
         mEluDxeIggXqduGRH47xjC2/QX6/d3f8trzomZ84vv5EV+yVhcVQ4TRGUPwxzJCvokk7
         j7HA==
X-Gm-Message-State: AOJu0YxSMCK7xDkJthUnIV3YNI16eTkiV5rqtf5iTDC13gG/1hHkT1sD
	qdVGQwpm2GuHPbN+f4ni49ykxshckAPQXHBpHpJXNoBDW8WIB/z+iGcRLYLoQ9k=
X-Gm-Gg: AfdE7cmcZxN6tNWxlYnQRfPrOdnmQ15n/EdqPZxDGxcFSgixqvCr/CN24V8S1y+8s7q
	ur/s9Rk9ga7lpsNNfdwCn7HlJdUGFFp0ul+tUaV8iozg2yQkBIFhZDpXkwb2Zn0VqYnl8ngbNNe
	e9AXekx/tGN9I81plens103eJ46gsMUdbpAcQrlFscjFS/aQJz+kqlU0+m+fxHIinOeAFCcKPtf
	0lm+FDATJ1kwyLDv9IaZzjAz/u6V5IGTAtIjJlap+HNPy0cYvOtLr3LxQCCiVpNL8/nHSQhNQP0
	jEJa099gS2X3SaXtpiqx9dBPVdFOvhwVb7doc3mRzOMwCeV+aWyq4+7ka5F9M2Ngd0UxjTzOhL5
	ASEc9tCRqsNZTF0ob+r3q4x1EZeL71+zb0zBnWD/Oog6zcysoIg0HyM5QZN+2Eggo6GZBar8lwy
	mPGuQCFNoAbF2n5uHyDXdp9ob5yoKsHpMjtlYjxw==
X-Received: by 2002:a05:6a21:b88:b0:3c3:7f50:fc3a with SMTP id adf61e73a8af0-3c37f5106eamr2721846637.33.1784169382155;
        Wed, 15 Jul 2026 19:36:22 -0700 (PDT)
Received: from matic1.1020marsh.offices.matician.com ([2600:1700:471:807f:aff0:107f:e34:fd6e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e5306afsm6060595eec.9.2026.07.15.19.36.21
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 19:36:21 -0700 (PDT)
From: Suchir Kavi <suchirkavi@gmail.com>
To: iwd@lists.linux.dev
Subject: [PATCH 1/3] station: fix use-after-free in preauthenticate_cb
Date: Wed, 15 Jul 2026 19:34:42 -0700
Message-ID: <20260716023444.3512595-2-suchirkavi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716023444.3512595-1-suchirkavi@gmail.com>
References: <20260716023444.3512595-1-suchirkavi@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

station_preauthenticate_cb() falls through its error branch: after
unreffing new_hs on a failed station_transition_reassociate(), it
proceeds to swap station->hs to a reference on the freed handshake.
Return instead.

Assisted-by: Claude:claude-fable-5
---
 src/station.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/station.c b/src/station.c
index 8fcf8c70..0b2d7dc6 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2598,6 +2598,7 @@ static void station_preauthenticate_cb(struct netdev *netdev,
 	if (station_transition_reassociate(station, bss, new_hs) < 0) {
 		handshake_state_unref(new_hs);
 		station_roam_failed(station);
+		return;
 	}
 
 	handshake_state_unref(station->hs);
-- 
2.54.0

