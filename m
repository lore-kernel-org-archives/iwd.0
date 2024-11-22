Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A231DFD82
	for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288579; cv=none; b=HGKQ3LxIazA2lDx5wu/TdTgnBV33ST1OPydSYTtFvueF0aPZUdWaiE9S9VORKtWqT7Tctbe6wDxF6+o1eu9d/2JSIEf2nIwx5zaQlU2kqdcMUpe8gpLXGfSjhGJpbH50lQ+jwQ9QTLOo92uDd6tDUovDuiMt2nObJdX7kqBi8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288579; c=relaxed/simple;
	bh=7v8Hwh12tAfXG/QCBDDX3k5jeAJphvtI3VBhMujUpu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DgRWchImXHikoE6tIf8SkMuvKiXkbTn6dhP0h0tgruoDoM1HLqDRCRfloo4zwgLHv3tMfQvYzxZsRhrc1dHSlAxJUD4h8n60XEObWKbGHbS5nTzTEmQZc7dh2Ye+NcUlVTYDlyeJVtZKbsuXbkoiVbEIxowAxV3S0oXNQGklgdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACyl9GjQ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACyl9GjQ"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d41b1e842aso11191416d6.2
        for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 07:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732288577; x=1732893377; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpxfYQAAiMUJiaqQWHacvkMcUU2odSK4tYwWww3Hs5A=;
        b=ACyl9GjQZ+kT0CPaQTPZAC0IQAwqIS9brO35ujgAoooSjan5zSEQUrUDY0uKE/hww3
         jX/YQhoz7svhC35oursIS8GmrS7Ugn9QdGYzPeznKYiRZTahYE571hZSTfg6XXb6zeGu
         zSDrCKiv+5nk0GreBLGGYPhZjyv7e7GGnY7b32drhIzorLYK47qFHFgwsEdKRsRTUdgJ
         lG+D4XXWtwq7XFseoRmBby2hk6fZaH+5YQ3CXoaLJ+eDdxLwaVmB5xzYCZQRCOh/8/Wu
         xXaYsUAebP/v1rw+o3T1kIsxtGPZgfMKu3VQvjH8p3sYrPECpluJSdy8x5HGQAUrgTsY
         bbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288577; x=1732893377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpxfYQAAiMUJiaqQWHacvkMcUU2odSK4tYwWww3Hs5A=;
        b=mikXt93HPezCVcOfgibdjuPTr5sn6z3EpplcE83ERrEOMh9YEaEV08uyNIl47GZrbR
         L9xkL5RS0Q3MpfkaUawQwb5f0JPBL4oBmFrn/uO8m4fnkFI+yKQXJdShUT95MMyh//Zq
         XQGNwAXS7BUO4rJ2kLzIjUuvsapQ4tmfdaRCCjn5pX0PVcCymoNoQ45FtnI2G8BLg1Gu
         990VQ0vVj37uLTRof667mGQEMvd6ozWTOYXLkvyKhpCddQLpz4uefl+1dmSPk7uqGmem
         l7mkUns3MJ2bcSIHlDfsyZ4ucPBaj1TbeLHmr4amA+5B/2u8a3i67I5VaZUCccnD1SVK
         pV1Q==
X-Gm-Message-State: AOJu0Yz3M7qeN2OuPUC9FZpyGqHWiTxRrKikk7/yzZ3M2S95xnEkAC3v
	ie6q1HndTUwaAZtXE+yL26TabCr4dOMWjSpTTTpYD9yfHg0CsQSCGCS4Qw==
X-Gm-Gg: ASbGncvaOlci2QxZzo3rAqasE+7TlN7E1+7KWIo704J8VPX3L6PDiDGCzZwJ1tFJcB3
	8j3MedvF8ScDLYMJh2sndO4J6VKMnmvf4BPGZH7bbD+VXq+QWAtkCxW5yyiEcxhW3vxHZboRS99
	tuAO9UbBmATovIAdqleMS+PdFwfZjz4d52fiUkk0REixIBJDykAS/iKR58nCxL7Uy21+Xsq5oTw
	yonLLpWcCJdfP+Q78+phwdvS/x+MfGgDtFu28oARGnMzegwbZg/0d6QXzQW
X-Google-Smtp-Source: AGHT+IEg+gQZezp3OFp8hyTuJ+AZb9kdX/Lln8j42vnJi0dF21cL3npB5zPBqRn8pFXGqwBICEvYMA==
X-Received: by 2002:a05:6214:cc4:b0:6d4:1d6f:8fb9 with SMTP id 6a1803df08f44-6d451362880mr59087186d6.47.1732288576862;
        Fri, 22 Nov 2024 07:16:16 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a9a720sm10722706d6.50.2024.11.22.07.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:16:16 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 15/15] doc: document DisablePMKSA option
Date: Fri, 22 Nov 2024 07:15:51 -0800
Message-Id: <20241122151551.286355-16-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122151551.286355-1-prestwoj@gmail.com>
References: <20241122151551.286355-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.config.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 1cb4b05d..7530aae0 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -225,6 +225,11 @@ The group ``[General]`` contains general settings.
        request is just a 'hint' and ultimately left up to the kernel to set the
        country.
 
+   * - DisablePMKSA
+     - Value: **false**, true
+
+       Disable PMKSA support in IWD
+
 Network
 -------
 
-- 
2.34.1

