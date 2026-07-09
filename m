Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BC53BB13B
	for <iwd@lists.linux.dev>; Thu,  9 Jul 2026 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783633556; cv=none; b=GabXeUSwsGv/ctpXdZxnryeHfJwZ9ZZAfw4/C97R2Cv2a5LrG6Gna6WlKSjCnspy5SVsf1CoLIU3gLNn3+kJSdnW1PC6Q3gC4CLOyFFiqhGxj9dVwO+eIfsv3jhVRP6Dc5JMbshroyiD299V56kUQfPgjVBfmFSBQUMpDbntMj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783633556; c=relaxed/simple;
	bh=lSd8L1a+cEBhFRTOlFBPY9odjU52PqqdH4PVIcCZwiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dOGgk4+i2DZZBZH5mBuP6Dtdn3xdYBCciCTLOULjPyhwwIieYr8bFVmhuWAqBD3cUweG0+uykzGVjRTf8KxYoZjAIaSA+U3CzPvkNABrb4mhUK4tYwZDBs5qUbrzNbarPF8snLdEulpHoyULeu+3G0YNRHuzLb9AYsILPu5uVWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kx2x2C6U; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx2x2C6U"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51bfbe05683so1556351cf.2
        for <iwd@lists.linux.dev>; Thu, 09 Jul 2026 14:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783633554; x=1784238354; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6lNhV9UOsE/634KayC+285A+rWsnA0fJ2OSqV+vy9kw=;
        b=kx2x2C6UzXaBwPHmH2cn49OP68ollYsTKUtpDjyVktPeFcIexEj6ZIyAPHzHtv2D8y
         aWQaGNA65jLb1LBlYqAeR58fjW34YwRkh3gIHdX4JqgklnoNBDp1KJgBKk6nkSri8zh4
         Mc0p7/iIYEgOLxoDkcL+Tb+R7dDU75TFPhzyYONiWIBfC5DqyjywOFC2eKsVlFq8NU80
         cvk3LQ9ZJyaQIJucoJCIdetPQJkZ2wwtr1oXT4bquQST8AycAspf3blIjzk+8zcKxeFT
         09Jg3utODVX3vODd//yNpmBBhQfTXpp81cO3V1ZgvD8eOHj7Rd9upWaswB3X8i8QVz98
         znZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783633554; x=1784238354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6lNhV9UOsE/634KayC+285A+rWsnA0fJ2OSqV+vy9kw=;
        b=Q5kDfpHY7o/ejX3qE8bm688ExF1wb4MAjE+6zzVg+EO/X7bfhCnnbH5MDMT58wu7El
         zDfSNrZG9N0MUi2FjWfV6fXfGvO0uKxWG6DRhoXRRFaoCIjLmGATHRJFNMXci4YomR+b
         cefVsZmiG/48KT/U0wK3Ftv8HksBdeCLZdwSaI0rhdWbZK34mVpbNuFP0Xa7A6VdSaqj
         wQxkuu6EsLQZgSx4G7C+c1SU7Wf3rmklfJl0qqea8BZgveooo9wzwkItWHzEDDRsF80J
         HS1paxCywAOlb2KgQV882+xc9iDJJaFZgEcCrtr5rKAg/5TGQ2cin+jcFaRlZMwRAyyJ
         /iwA==
X-Gm-Message-State: AOJu0YygFNWL/Y50f/L7jTzPPBMMRSnhNpB9Z9VF5AEmp7EY6qR2SA5U
	LaqkU0/dRc1h1SpmUGV2hY9zapqiRY886wBq9xXKjkGbphL6YzQ79NKEZpBdfA==
X-Gm-Gg: AfdE7ck7eOTLJ/QVwbZlJvR5WQEKJ3Ljyg7H4SGP8ucYy919PblnMA+uDEb/IQFY7ux
	MgmN7o/QMeEJ+A6pf4OuSgxZ+eIL4Gz6fZ40Hnwn5Alzocy0D8vBCisyElPMGDglHf9DiDUswro
	LlCe5wiNsHRvLmtLp8kqEp/9mJYX9GG5q3rgN3/kWJkVwp1EOcGePcqfa9Jxj5pnV89BEZi8KiM
	4GSmoPVtA7tyymhKPyE3w4GCcaR9rgZhB0ugxx47XvYKu8amrxKwUaQCC4gL+AZasvt9DvdATLz
	E19zaAskaN2XPmFO15aJKuKkhgAb1Mxo59nvqDFX7y+8eusoT1wjXLmCffqDLx2smZWaH5G9ECf
	iXfxegZxwXuWvsmqGYHbn6Oy5ZlO0Zyxv93fZ+rCi1iDcpL4jrY4PxjrKUNufTKIOzcuiLjlda1
	R4QTk7NrPSrs7izKIW7afGBrUSuWDjykM0ms81K3AZIUAwDLGfZljT3yW/54C85N3qz89v2Wlk9
	Lvp1EI=
X-Received: by 2002:ac8:5f4c:0:b0:51c:164b:b240 with SMTP id d75a77b69052e-51c8b2addb9mr99973031cf.4.1783633554394;
        Thu, 09 Jul 2026 14:45:54 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caab6d574sm3857641cf.3.2026.07.09.14.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 14:45:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] client: support ChannelUtilization/SignalNoiseRatio/BssLastSeen
Date: Thu,  9 Jul 2026 14:45:45 -0700
Message-Id: <20260709214546.659971-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709214546.659971-1-prestwoj@gmail.com>
References: <20260709214546.659971-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for these new diagnostic values in iwctl
---
 client/diagnostic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/client/diagnostic.c b/client/diagnostic.c
index 2be8b724..6bce1671 100644
--- a/client/diagnostic.c
+++ b/client/diagnostic.c
@@ -97,6 +97,9 @@ static const struct diagnostic_dict_mapping diagnostic_mapping[] = {
 	{ "Security", 's' },
 	{ "InactiveTime", 'u', "ms" },
 	{ "ConnectedTime", 'u', "s" },
+	{ "ChannelUtilization", 'y', "%" },
+	{ "SignalNoiseRatio", 'y', "dBm" },
+	{ "BssLastSeen", 'u', "s" },
 	{ NULL }
 };
 
-- 
2.34.1

