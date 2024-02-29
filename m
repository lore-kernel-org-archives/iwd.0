Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1118316062E
	for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230345; cv=none; b=RdIj/4ESqB8hez/yG/ygGH0VUZ4KRmeBjLuU0h/8JT6B3xjASXGaYGLtdQ4R/29414HRVEaYrS725sjM+nFyfj8ToJcf0DF0OKKNLeVW23SExNMMoQKVDMLSgnMfdsaD3UFwfLb8XQc8kivyBGRFVTdzC89gDoMjLKuufC8mXP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230345; c=relaxed/simple;
	bh=l9orJplI/D/vl66mVZVSCCO5Tka1bOjCGi3o1gPFM8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GVe1fM/imz7ecencAk32QuxrfFaOkGAsQxG+Hwc0zk7jxHcXYsuxa9AjlzzdtGN2ZObmOgZtN9vEi1+31Gc2T0FhBS9Q9dz9iL5uXf67lVv9B7u0lmtaonx3loByyfkHVGX8S376+6bgJjmSNooU7/bJ3my/jMCVPAAVcN4UCPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msCbtiVj; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msCbtiVj"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-690508d70e3so2294466d6.1
        for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 10:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709230342; x=1709835142; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15I/CPKcuBVHku9lovFCh7EpGd8mdbZT2xvInBpTlNA=;
        b=msCbtiVjjOj32+neFSPTGz8sDQao37NlY5b2M/0nadY5L6ltMNwJMYioyXO+m8jmIf
         El+mbx/Y+MssP/ZJoSIEfAC1ZvWhUdTvSZbkqeq6ima9eMWRIhOYgZp38mVY7vpnx4zG
         t/TvUbxjb/exhbiOqHFVXT/oLnhcALvQtmCRu3tiTzzTOv9aMx8PwJZFycJeG7sE6RGa
         9PcpBRQwB/iSe37Q2R+7sgH0RIIeK0oCd3QWvBkMYo+DWAW4f7APygk5zTKFDUwxs8QA
         D5zSXdMWsdywGGYnsiP0FgNmGXSqfFy66A8bySk/hNJrc0LJ5NAgh2XbLDELsfcX7c0y
         9j6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230342; x=1709835142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15I/CPKcuBVHku9lovFCh7EpGd8mdbZT2xvInBpTlNA=;
        b=DYOgZhNG5Ki4DymcmnqvQm9NVYWMBmIzbrYbWIoWLV9Qb9M2P3H62I66k/KAr/C1YG
         hYxPadSCc6JQPCER4yVV82qdhgAcMYWk2t+/ZEDlZuokeIWkzxytzkaAT7VeYsz+7OiZ
         rZWmpQVs2SGU6pSuuo20K+qoXyxXi+SOciEYBLA5tEK3yPsqoq1A8caOWYwsWCi+H+6x
         IYu6KRpRs6F5siPXVg+9+/nLkGpMAQo/O27jkRzjEgEJHHXGYZN3ibjbJwFh17Po449l
         9do/2yOlGRWr9savDCog0qtC13oxKVVGOj5Znftfy33Qz/6bfqd+jac2gFNLkkKPfsEy
         DakQ==
X-Gm-Message-State: AOJu0YwBQrgEuJLz9BDF1wxeJmiTwr2KjHBkBpFIXSH+viH1VUt6reZu
	hGiq8Gmx/JuXTONgZR3xq3mEqtBhwcbNOG+FBfKmg3PIzhb0rPqa3kqX9gm/
X-Google-Smtp-Source: AGHT+IEIg6m1I1u/x8x+OO5JG1ZACQgtIkhDTSq+iokmbKdjPq5p+kde4qOU+wLZQwn3J0YAJSBivQ==
X-Received: by 2002:a05:6214:88a:b0:68f:e5e1:8464 with SMTP id cz10-20020a056214088a00b0068fe5e18464mr3065476qvb.20.1709230342473;
        Thu, 29 Feb 2024 10:12:22 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id mf15-20020a0562145d8f00b0068cc0b46682sm994209qvb.4.2024.02.29.10.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:12:22 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] ap: allow va_end to get called in ap_handshake_event
Date: Thu, 29 Feb 2024 10:12:14 -0800
Message-Id: <20240229181217.1503555-2-prestwoj@gmail.com>
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

Caught by static analysis, va_end was never being called since the
REKEY_COMPLETE event was returning early.
---
 src/ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index ee3c4dca..25d1b8a3 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -1484,7 +1484,7 @@ static void ap_handshake_event(struct handshake_state *hs,
 	}
 	case HANDSHAKE_EVENT_REKEY_COMPLETE:
 		ap_set_sta_rekey_timer(ap, sta);
-		return;
+		break;
 	default:
 		break;
 	}
-- 
2.34.1

