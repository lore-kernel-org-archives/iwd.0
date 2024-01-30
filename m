Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1062A7AE52
	for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642039; cv=none; b=PNM2SpAIgpW1EPdil0/FYZ1hdTLBmlpDqR37InUD7N8ASjU4a3yAhbvROcY1DsQ7F2twTV3Fu7E/F/4EkpD4VNoYJDSb1cFZu4/YHmCLX8aqt3KtoPjkR6NdvoT62Ju4RaBTwdD6VsofbAK1pLx5TAy1Au0qCP5a0XMLeqeoCqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642039; c=relaxed/simple;
	bh=UZlEPLn8+yb1k9gpTegsEDpfbbF7+g9FEpRPW8V36D0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KtGeqaepOI+nPmc1dxZtXFAAJP04XQN6XLiagz5tSAEteomhsNSbXmC4ycawBthhp9T1rjdX4WLQXY/tA5TuRL4qSZy9RV+O5TDGNr7q4R7/0Bg2WqhenKJebLwpoinP1NBot7EqPiVK6Zf80JNQWKz16hBhJeASu6X3410BUe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3sv8AGv; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3sv8AGv"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42a8900bb93so43205371cf.1
        for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 11:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706642037; x=1707246837; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/b0QAd+SwK8v5sNS6/hPJzjxAZkGnROv0+O7vE8+aE=;
        b=K3sv8AGvsZrgTVKIaTdHcRiW/9vj2pb719v1alHBqvJ2GYBrNW158Dde833jHNq21H
         u3VFBrrmEOrtr10qNxy1ubTYj+Y/A105Yd+cVdt/52JplclZBCW94H+3cISjPWSEw00Z
         J/q3F2eNKLJtOIj3+w/ssrLIV3eb2kJij6OC/T+WPLduUan5PMKFdYwfkp2LHAwaLGpE
         93iP8SIeAtK1FN+6rZEUeRIFcYjFoLLyT7gFnHRFmimmG4ptlSew5fuM2QyPcWxQjT88
         iTuijsgsQOK7Nhj85wc13nKZl5RRPKpfCRrF/rkB6920ZtedjB8esEToiUue/WFDfjk1
         kZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706642037; x=1707246837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/b0QAd+SwK8v5sNS6/hPJzjxAZkGnROv0+O7vE8+aE=;
        b=w7F1DSFy81ty6b/FQFiBTCpYmp6GZKFOtre/3Wui0vyyTNfRrYutaNVnuaGd4N/c4U
         q0zfrTk5yQwZEz1TqyoCdCh8jJn0yG01IiLZij+RikiaKou55DljwPvPWYKMixIOVpQr
         EprMq/f9AoAyy5p8hmu0cg7kIQG13INFwexLq6q+N9fsL/XbhUUsJdlU2pkI932lsMAq
         V6gxI0T64HVPknc/Q72HZwW/0oOmgY0qUFsXoNO/U0vmx2sMvLsKaDlyRSKAv+qXU6FX
         mPITiwRqTZWTwF4lpAP2xiGuqUCxqwG5P7HxnAlIMBXPp5NnEFteioymMxniX+Le02Af
         5QRQ==
X-Gm-Message-State: AOJu0Yy34PW5+m8FfUu6XXNP50OtqP75tqWCphBF28ICReq2nbzGDq8u
	DXB9kRF4kwXxe5rIf0agRxWSWX9JzyRi44WMICf0QBRGxG8YolAiZktSdiB05lQ=
X-Google-Smtp-Source: AGHT+IFdt0mC5XAYGB3FnOOU2pFdLuKU85ummNO1wG8wT89ogwrnEnYomyFTHzFVx4H8y7i7p86llw==
X-Received: by 2002:ac8:5716:0:b0:42a:b649:ffb1 with SMTP id 22-20020ac85716000000b0042ab649ffb1mr2373043qtw.14.1706642036481;
        Tue, 30 Jan 2024 11:13:56 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id ie7-20020a05622a698700b00427fabefe3bsm4716110qtb.52.2024.01.30.11.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:13:56 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] netdev: make unprotected disconnect debug log more clear
Date: Tue, 30 Jan 2024 11:13:51 -0800
Message-Id: <20240130191352.85852-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130191352.85852-1-prestwoj@gmail.com>
References: <20240130191352.85852-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The debug log was just saying "disconnect event" but we should
distinguish between unprotected and protected events.
---
 src/netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index f62a97cf..2b3925dc 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4762,7 +4762,8 @@ static void netdev_unprot_disconnect_event(struct l_genl_msg *msg,
 
 	reason_code = l_get_le16(mmpdu_body(hdr));
 
-	l_info("disconnect event, src="MAC" dest="MAC" bssid="MAC" reason=%u",
+	l_info("unprotected disconnect event, src="MAC" dest="MAC
+			 " bssid="MAC" reason=%u",
 			MAC_STR(hdr->address_2), MAC_STR(hdr->address_1),
 			MAC_STR(hdr->address_3), reason_code);
 
-- 
2.34.1

