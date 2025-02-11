Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABEB2641E2
	for <iwd@lists.linux.dev>; Tue, 11 Feb 2025 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303945; cv=none; b=BCslB9Vcxk9FsVP3RZS/cUidW+iLQ3OZ2N1nQ4Ix6R3ASQ3+pLYyZhVpNjLD85njeNByJcdZDp6OWXkvvGohCoZC1ylYyWkxIi53JEyTHOLzAIEVsZQC1nusnZaM7ydrCCCF/X9e4nZtc6eq/tplE6Xb9XyaL8v0XuV+uS4fYoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303945; c=relaxed/simple;
	bh=SmMIHAX17Zrc8wmDDwGsd9SWC/y50usL3iErX4o08Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g3mXxcAtVkUl6MKacdnvETluY1ivrP1Q0EpX3PyLIlxpbhAH7QWEk1Xmnl1CFE11l967Bgk8IOI5KizDqU7zIfONbkYFkjH5C9EuRMbS4AcdD3OUTiO1zz6hdwvqVGj+WkkEpezF2hyCnBbCGWOEa+UrcGyd/SJE2o6MKRD1My4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yjc2+MCz; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yjc2+MCz"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e454a513a6so26630126d6.3
        for <iwd@lists.linux.dev>; Tue, 11 Feb 2025 11:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739303942; x=1739908742; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXINKhAqZ6pkPuZznZu5QodMlL06p6ADrLTv++i36bQ=;
        b=Yjc2+MCzR75/LAw97yDFtgIYBC6kCwXCy85HLsFphPQKU9fd2DGItk/KwfKdYtZ2k4
         Do9ZPO6hrUYhSbocgjhLZ+cXIJZX7KZ99VJxr0iOA+nWcLdsHqNCmoqGg2mb49uReOZ2
         Wanw8+Ot3dTJcbgu/Vs/OkkT4fWO14GgOJlo96btgUABAw6UhNzmyJFhsESrXDMT9LQu
         U4P/S0m72HZYN86Le/KwryRwd7mm/gVy760/mpKgDFmkFJYXhQ0x5J0f8RvO6YGkhB6X
         gcTkxJkRvuVfeN6pLyAVwzbJWti8pnsT6Xo2aM67t8dE3mtJ+o2pjCtnEjmo6+WUWdoB
         jaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739303942; x=1739908742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXINKhAqZ6pkPuZznZu5QodMlL06p6ADrLTv++i36bQ=;
        b=gxigdgRQFwigR3jxPSAOIkLxu53oPx8hPCHxiITWfISvwYEz616gaiubXMQXiOn7ar
         JizCdWVh5P6UnvSLugzkUSkrxbNlI+X0x0RCDOhUx/pDKgEboBREJCBBjyJoc5gncQQr
         i9vJ4rjGOCn5cHdzvWxAnRDjtWKsoiE/p6AxbO3H3uq/LBt+XvaA8ilm0M7WmG/cnP7m
         pjfif8B53OKlugaue74MiyxPFLYo0Bxq2D45WU/BCfVbzEgFPr3434JGR2qnNBpm5JyU
         9Z9loiHiRyJcm1gWNXrliqi16gpekNfGn63bcauv4bZuULZ5/MDdfKxCFhv5YjFDV4Ji
         Sr5Q==
X-Gm-Message-State: AOJu0YxvmhLiAvOroTa88uO87A028Iw+0aDjip6HXI8dTlihcrpUljjM
	NPIMTGJIoeATXB+EMyg/KLQQkMbRfuGi7YRDicFT6Xepa0KHEG6IsaW5KQ==
X-Gm-Gg: ASbGncvEpjuCNd7+HxG7WWCl0DgALCnmTeI1NhAJ8YZ7CZCFl53YGts3vgRLi1IpNOK
	9yNaa/Q+aylJXqVyjC8sScHNR7Tw4LZB/oMrn8SeKauwyB4OQzCMg9tNf+ndEbbkUDxkGiotnXE
	bw+pS1/Esgl3duIUyo1Vrw1j6v8kOqw+gWhmZaaDfIeo8PrcdgBkk9MiV4ocGIMSOdtjVjf7OU7
	rYBGiI7eL4XD+TkDpfkei0nPjNS4tLDzIyckPMfhl05MZN5kfCJ/XBQvPKT0V/saQumwgZ7ryEg
	7Lnf+PpuIKrVJsV8HytcLCT6X1L2jgkSIT/yitwc90+vxLLOwA==
X-Google-Smtp-Source: AGHT+IFCQ/P+9UIb9AOFBpHjxVJwA8/F9KaJ983fxUrFvNYhsj0hZ0BtsiTBQ/Y5ne7+mJVIHmpx0g==
X-Received: by 2002:ad4:5ba7:0:b0:6e4:3e5e:56d5 with SMTP id 6a1803df08f44-6e46ed77e88mr9422566d6.5.1739303940522;
        Tue, 11 Feb 2025 11:59:00 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e44df787e8sm49690426d6.113.2025.02.11.11.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:59:00 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] doc: document [DriverQuirks].SaeDisable
Date: Tue, 11 Feb 2025 11:58:55 -0800
Message-Id: <20250211195855.85360-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211195855.85360-1-prestwoj@gmail.com>
References: <20250211195855.85360-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.config.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 0dd9d978..4ba7b4e7 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -465,6 +465,14 @@ are buggy or just don't behave similar enough to the majority of other drivers.
        If a driver in use matches one in this list, multicast RX will be
        disabled.
 
+   * - SaeDisable
+     - Values: comma-separated list of drivers or glob matches
+
+       If a driver in use matches one in this list, SAE/WPA3 will be disabled
+       for connections. This will prevent connections to WPA3-only networks, but
+       will allow for connections to WPA3/WPA2 hybrid networks by utilizing
+       WPA2.
+
 SEE ALSO
 ========
 
-- 
2.34.1

