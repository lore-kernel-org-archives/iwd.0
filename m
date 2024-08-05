Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35855894
	for <iwd@lists.linux.dev>; Mon,  5 Aug 2024 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866849; cv=none; b=GfpaE3bLheaQy55WprgPa4axnnqLZNuJunE03EtJT1JmiV8aBdHXIEMW4lKL7U5EJyyGzteBANilCTjTWdyeulDNOudgjHeBIS/LteVKb5FxbadfN6IIkdbMZkcq4D8WyBH0pxqEFQaGg9Aqz03gx2DS7zVcmP3ZhDBE7qucmWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866849; c=relaxed/simple;
	bh=hSpK+Y7tLI/tno85wYSWEUNuO3TrOl8pVIG1mmp7zLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6CSoH5choqZ3zUzZh8s2Byzj3kwVdbZ+9Kx5LzVBgmwn968wk3Fvr8guVIO67lBTa09SaN9oYl7wDMrcyh5fOHB2ypOArmkOuPEYwe07Y1h8ElvUafOsxSKXqk9dECjJqJSAgixBlmBS81pe6DpL9BQWeeeDlq/PBToXm4WS/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCtu+sFs; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCtu+sFs"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db16b2c1d2so7587290b6e.2
        for <iwd@lists.linux.dev>; Mon, 05 Aug 2024 07:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722866846; x=1723471646; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNLTTywNlsr5MeFF1RgS9BCsopTj9oo062z1H32v7zw=;
        b=GCtu+sFs18LnA+u7ADOpITnF+lulufRR1QiMxhqufbRvXxVZ2cjYyrIdaxByCdRHYK
         alvfMHZkAQvKqb/rTY2wlu/hwAwi0Xtt1aW9LmdX1A3NhoA65XVYGoQaDqr1Hze5SNby
         KBNa+hQcWAeY8jGUw+TCC5JX9q0Uy+3SLM/noU3Tq9F9339sUlb6RbW8kAUEOvA2MgM/
         RhmKKsDcvvsyEQI0k+YAa9dqgvPcZTS5A2q0VhXY8xpgA4medoIL9LsFS6Lqw4OFj+MV
         8y67aj17AADEeIqrMaSY6rqWKa3o2/iyT7AwAT42fIzspXAF9Apl6E4/LmvcLN5qECM8
         qrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722866846; x=1723471646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNLTTywNlsr5MeFF1RgS9BCsopTj9oo062z1H32v7zw=;
        b=lzjafWvRrBjEF2aHQC8jlUTh+TGnDjAItkoC5NJcWUyKc41u98TX5adb83tnzbi6g4
         wPlewkcjY42NMXJ0NHqs9ZkqRg8Fu8fht6UhwrPPzXZich4SYHoyP7+5Tez1LNqhEnbP
         1nGf30x9JF2hyGyvKGwNR0k3hAfIX+2w0u6zTLlpwYwINvRInTeJXHbq10TytldqPNNe
         XX0WFxYc5cZTgftoATVQ67j1I25X+PEtmKC2LsQMkMoe+iBSfjjrK3wif/zKSp92iqGq
         JAKoKwGZw13qSA6n6VW9uhPHaPZmE+QjpfCKNRSPtpCNyiXrBNT4A9qna6Gs/YIbvyI5
         RNvg==
X-Gm-Message-State: AOJu0Yx+lvtIHKzyOJ6q9jlV01voXhC/tkOxfHx+f5Hs0hj8C9Um0eVp
	enk7T9zDoqJ2J3sH42xcIIx4LHjnVGETfkJSJG+ybXP1Do//3AzIsyNt3Q==
X-Google-Smtp-Source: AGHT+IFVpep5finbrgqRspubdR+5EsVFaz4EmwL9mmtCFp8Z1lSziX9nDgobgS308dhi4xxqIkgl4g==
X-Received: by 2002:a05:6808:d48:b0:3db:2865:ca41 with SMTP id 5614622812f47-3db5583cfbamr16514630b6e.46.1722866846521;
        Mon, 05 Aug 2024 07:07:26 -0700 (PDT)
Received: from archdev.attlocal.net (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db56361a88sm2654172b6e.4.2024.08.05.07.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 07:07:26 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/7] ie: Add IE_AKM_IS_OWE
Date: Mon,  5 Aug 2024 09:07:11 -0500
Message-ID: <20240805140721.57518-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805140721.57518-1-denkenz@gmail.com>
References: <20240805140721.57518-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to IE_AKM_IS_SAE, IE_AKM_IS_FILS, etc
---
 src/ie.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/ie.h b/src/ie.h
index 024eacaa987d..82945de676a9 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -361,6 +361,11 @@ enum ie_rsn_akm_suite {
 	IE_RSN_AKM_SUITE_OSEN			= 0x40000,
 };
 
+static inline bool IE_AKM_IS_OWE(uint32_t akm)
+{
+	return akm & (IE_RSN_AKM_SUITE_OWE);
+}
+
 static inline bool IE_AKM_IS_SAE(uint32_t akm)
 {
 	return akm & (IE_RSN_AKM_SUITE_SAE_SHA256 |
-- 
2.45.2

