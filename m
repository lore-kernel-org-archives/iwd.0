Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB741D5CDE
	for <iwd@lists.linux.dev>; Thu, 22 May 2025 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747939318; cv=none; b=QaN/GeYonCTxRza5m5JpNtKdqLYgLmYYHTYu8Gu/ykOjbitddvcOX2ZFaoDO4i4uXwg8D6dp6LWjY5gBGa0VL8HCOaa5gx+/HriwV5aaeTgErkkhjDG8kK73h+5jvdULOFTbPUNWA4oxR0LpB4WC+w9L7n5JEwNPhBLORyabgIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747939318; c=relaxed/simple;
	bh=bKSVfV8s48iCA8872+4MaX4M2es+KJBs+wVT+EWEn/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IO4Qy2/VF+AE+0P37LhBzh9LwavIk+PCKKPc6ls3YZLeU9SlAsITsQ5QXTQrnJWrLPUf/9Z52naFGl0UyUYc0E41gDqE3Qoj8dGj74KvnYGrObHr/aDLJOx0HvmRZjsXJTa7VnVktGy9tcT8sCbtp/a04xRjnMhAswzOOWoJQA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8fRRuwv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8fRRuwv"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so170905b3a.0
        for <iwd@lists.linux.dev>; Thu, 22 May 2025 11:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747939316; x=1748544116; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3qdyvHnR1T2bmYKbozFzio6XOkWfzIpuEO7wzi84y8=;
        b=H8fRRuwvMALLLcc/hxfOUbK0S6xXMsL+emjfcbWUsqfXbpFpi1ha9xW1x9SAHAcilZ
         s7jZu7hNvj6YhPvIEwfLLeZJmd+bdZAKWQ54m0pvZ8Fxkzz15yNcWqsci9Fo5vFCjdZL
         4oPB5n8y3jHfu7XMQOb6xh58QQgf/Z9mAGpZOBvIo8poscvejGCPGG1CVvFKFCIULZfX
         ZOyCyLtfdfb5bbOILAplF/89OqqZvk0ltj90uf+qZKZ4QqP44x5lJ3s2tWT0T6OfZuWk
         rKClruwKMKtdfuhqVAVKnCnNLBeZfuSafsTUuWNl4UeGhCPGFAiOBCMavSb6a0a47tFL
         9mYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747939316; x=1748544116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3qdyvHnR1T2bmYKbozFzio6XOkWfzIpuEO7wzi84y8=;
        b=lIzY7JkWoCbm1ZAMoEeWiw5zp4KUGuDKa8dF2Ik5cOMbZ0kmvcHO4k1m9EEJYopDxq
         Y2amnMiTmRct7OX+LTjZ0NHPeBzPhlh4ZmgnIRzWiW5FnXTzloJZvAZ0efGoOJ/1kjsg
         RGJXClMPSwrQQePsdwlEldRuCBQLMdztWF/QQUVKJGFliKgUnulftVQ3lHbbX6IfA6Gu
         /l6rUbw2iLj60TvwD88+nur60Zo02F3RqLsteAIx/Zz9df0lBhzBXoi7oH0E35/N0S9U
         nFkB6zgJojGwqefWg4KBcUA164PyBqW+Jk7WVpu3zAQj3CCIdghcIlbUj4h+yz1o/rod
         Vnaw==
X-Gm-Message-State: AOJu0YyjBQATXFJpX98WmfFVIz1r8G/OlA0PnuOjvednNn7NocDGGJ37
	bd0vnzuhs/ITNJq2u/XrZTSXd9yr5PeB498L19rjaERPPqk5+zOPFtnLUviyrg==
X-Gm-Gg: ASbGnct3n8PdGOUoLKKZWyrWfn+MTRcbeQk3Q5ljtIhRm6sqLpDfaubzI78cqeWt2v/
	Uu5FtqKI0y0ptST/dowkhW/+ZiQBcZmf1HRHabfaWx88tAwiEXReWDGJhpZW5Op2h/soXjw3DtU
	SdYyadQmhnmTRLTRQyPPN6sg/Sr81AQSecQMCaZOMSq+0ycliPQBk/2qK20MXc5sUgrsbBYqW/W
	jgkLVQX5GU11YnoeMphSDZREiUk7FqBSAMjf5wcc6nJ8sZx1o4h0Uyw7z00LkFD9Vr7HmNERH26
	2X3x4im81rDVqIlylZChtd1TdrJB1cxlWq2gQ1L97DOA7oHggVTxtwlBQLDp7ny6b22PSx7EKP3
	TO/OeZDzJ3opucFEeViRiMPBsc0l/tm64bdjNjVOTR6W8Wm/q
X-Google-Smtp-Source: AGHT+IGs9d31SKsdnWwRyZ+neGZEGK1i/eKoyskKylFzIoxCQSmDEnq/xSqRPKCg13VL7hTB7OQrnA==
X-Received: by 2002:a17:90b:2ed0:b0:310:8d73:bb27 with SMTP id 98e67ed59e1d1-310e8900917mr825979a91.13.1747939315764;
        Thu, 22 May 2025 11:41:55 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365f3487sm5829492a91.42.2025.05.22.11.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 11:41:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] nl80211util: support parsing NL80211_ATTR_TIMEOUT
Date: Thu, 22 May 2025 11:41:51 -0700
Message-Id: <20250522184152.29950-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522184152.29950-1-prestwoj@gmail.com>
References: <20250522184152.29950-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/nl80211util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index 0fdefddf..60cab7ec 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -190,6 +190,7 @@ static attr_handler handler_for_nl80211(int type)
 	case NL80211_ATTR_CENTER_FREQ2:
 	case NL80211_ATTR_AKM_SUITES:
 	case NL80211_ATTR_EXTERNAL_AUTH_ACTION:
+	case NL80211_ATTR_TIMEOUT:
 		return extract_uint32;
 	case NL80211_ATTR_FRAME:
 		return extract_iovec;
-- 
2.34.1

