Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277397603F
	for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193898; cv=none; b=D3CxsAt9LjlF7+OeB5E1w333j17akbNKpC64JX5G7tMA+Fp7u6i5eAGUDhXq4i8AqyS1QnjoFHNdBTi9TxqgwoZpMj+VzuI0Utk9NF/5AamYbgHp9NSZ3rXpol8ntj8SLu5CjYOzkAEQszmNACbq431n4e3jywfLE++7MkQMOmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193898; c=relaxed/simple;
	bh=VTgaw65HvwKGSurjTpbMuTxVKF1obCgKYABcc0bnJVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vt7qp55jaFDr3dRPUuR5G+j4CENjlAiqt1SqjPOIhaGForvN4AtoqT0YTHO+tY4s+2smnv8Ddw5k5CjF3Cy7B7a9ldpJz5btmuhZflmJqwv2fQrTFxcBtLWV4574kYcoWAAatD+ryaiW7iUETh89mqlX4Nhqm7NzOqNd28HiZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhZ6/tkz; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhZ6/tkz"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78d543db3a4so252040185a.0
        for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 08:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713193896; x=1713798696; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Lrr3vgwpdRQh7vXRPL8MOUarMcr8vipoNmgP5njNXc=;
        b=WhZ6/tkzgUT4EyaittlNW8Qjb8LmQ+Qk0nx1KAGpRhJwySwnjAvhsf5aafGL7F8cAa
         Nhqcx2UxuTCOpBxWrqT4sx6FNXLf+zxP0KsA1Zv6EcD2y+0+2N9zGjkLZ7znX4PM0DKR
         jAic0hTBzgLz5paQp1Hg2BSjAYpc1S8gwmZ5T67GzjLlrY1Iq2vRGQI1nG7fi+tllswu
         yxGOIr/4aaG6IcB+1KkZHya1vNUumKWXeP1S/lXcnPO7k+tWpNtHxRszoG0clGhHotzB
         rOQPPltDXQiO7QI23ajeenzUSvXe1PCEVkZAsFl1taEguhdhRNL2MZi1esSuf7AdxLmO
         2Eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193896; x=1713798696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Lrr3vgwpdRQh7vXRPL8MOUarMcr8vipoNmgP5njNXc=;
        b=NLnOKsi8JB8/H6whE5mxOd3iMnsG7+V/pp+DJPiwJxQGLyHQyv0NscggCqj6uCgttb
         tW/YVSsf5x3Q+4+TpZ9OENzzmIVm/dIpBPg4sxD/hHNL4Lbzstg1WZoiqOL8TncEOUCP
         uoN/8HnZsHtiGBkZagLf4JLenuBvNzkvMRFtOxItynz8bUf5NUxIl2zCHB6YMIweyfPz
         LD+ljk6Vk4xp6IWNMqfQ65ZnbyMJ11TKSKsRBaRszbPKi27e74jmlXUvYJaja6W/dWPj
         vb4Vd89ZLzS0k8AoWMZLWDzYKYtY6PAi03YV2N1Sq63OQxf8dVi1oIktidClnRmLLpbP
         4Lww==
X-Gm-Message-State: AOJu0Yye9cLVRrtC99leR3tb/9j2VEZ/3q92VV8G+3We1398VgoUZK1y
	eO+heaQkF3M+LzYemiIApODFtgE8XdjHASw7kidtNM1RacGbreFe1cMz8w==
X-Google-Smtp-Source: AGHT+IHArMygy8AuVNTULaiQD/GAKF68VmIo3bmWVtZ7/LQcW+i0yGW0leQHf8RwzZS8NgYGSqwT8A==
X-Received: by 2002:a05:620a:663:b0:78d:63d5:7325 with SMTP id a3-20020a05620a066300b0078d63d57325mr11558752qkh.43.1713193895736;
        Mon, 15 Apr 2024 08:11:35 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id h23-20020a05620a13f700b0078ede2e9125sm2596549qkl.57.2024.04.15.08.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 08:11:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] scan: replace -ENETUNREACH with -ENOTSUP for rate estimation return
Date: Mon, 15 Apr 2024 08:11:29 -0700
Message-Id: <20240415151130.40389-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415151130.40389-1-prestwoj@gmail.com>
References: <20240415151130.40389-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rate estimation functions now just return 0 or -ENOTSUP for
success or if no estimation could be made due to missing IEs. Only
in the case of other errors (such as malformed IEs) should a
warning be printed.
---
 src/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/scan.c b/src/scan.c
index f48ffdef..a22cc27a 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1608,7 +1608,7 @@ static struct scan_bss *scan_parse_attr_bss(struct l_genl_attr *attr,
 
 		ret = wiphy_estimate_data_rate(wiphy, ies, ies_len, bss,
 						&bss->data_rate);
-		if (ret < 0 && ret != -ENETUNREACH)
+		if (ret < 0 && ret != -ENOTSUP)
 			l_warn("wiphy_estimate_data_rate() failed");
 	}
 
-- 
2.34.1

