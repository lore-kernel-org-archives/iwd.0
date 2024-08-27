Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE18F1C0DE7
	for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768297; cv=none; b=p/mizZ7aOpvK1bfXc39yP1Jq6HNT0GnxyByh1oIYep/ATHyve3KFM90xXLToDXsuTHMBdCrj6dxZUxXFfDaotsbIOqTOvDNlEBrsqluADz9zdraiTEQEUCG0IO3KBzU1eg4sqcaLg9lY+hHMjLbxcfbB/okcekfEc6SQUAiJNR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768297; c=relaxed/simple;
	bh=4VID/kGqmCQcPVG7TVG1VWXgAG/PR5NR1zATVo/nJek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oF3qO2lr8ymQS8rncvuy1cdqcwRg6PJ/lmHN1N0Q8TiQ/FiEykmkBAh2sshjHWOObqw/WK/XBw8bSMXoXNUZr4lAff0mn/tR+Y7AJgDPfuk3XXWZP+eUtRCMu0kxeIde4aEvfqbD7AZHXB5BsILqz9jsmkGEyFLPcCW61RTijmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkkX8aiI; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkkX8aiI"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7cd76b56e59so1913255a12.2
        for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724768295; x=1725373095; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4UOMSk3OX0lgTYpH28tD/6WWdd95RgGYYv9PtczXhYg=;
        b=TkkX8aiIRz4WWUfZiI9JQ5BCNUs5+yT+FXK2Zq4WSnTVPEjzhUpRuCRiBkhxfrOWlO
         mBK+r8JL+dzyIxx0tcLxZvq91gAm9B+1+boA/2gkqOv9pOaChwz4Lj6Gq4pTFIEZAZMv
         brU1UHp/jboh0H3UhXlbodM+VuSxC/d8hvb5oqogpBN3z5WxKIZU8DY73TOukMrIVXdp
         csQMvsvYUeC+NQax8ZE+9gNGhPue+m0A1CoQXJaMGebBxgRtGR3wqTk2KlMHKQgagaoB
         a0vEikBBEGUUttfjKc/RQzbfXtqSXPga+Qsk2a8dCkDiO/XGZrmkL8w/7kYd9JY0YIR1
         d2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724768295; x=1725373095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UOMSk3OX0lgTYpH28tD/6WWdd95RgGYYv9PtczXhYg=;
        b=Hufl3xlQED+WTxSs0h+JfjBrMLufdEa7hx6pbtvBIEzo9gPtnMrOWNU4b7q+M6Uspl
         0DGNovm+Z7NRGDcYeM0xCUyOFJvhM3hJItqRn92fdWNFF97dTUO8el3RbscPaqGen/X2
         QLjaoMVqh81hbaeq94VBpE6LikSMdOKT4ypaS/Em02RdJ1rvX/69qlusP4/23eS2En/T
         M0QzDI6MjMg089G9fqsmaFScFa4OLE0yKyuVWJgbmNDEZr0UjgRFrqtyhw+3o8fsWprN
         6pXNdyU6kvC1fsA1+26chZANmJEWuk59ABPrnWCiG0i7D2fvsvV05Kl1gh/lLPJ7+Piw
         MT+g==
X-Gm-Message-State: AOJu0YxHGpAteEYoKHFX3YoY5VpQsnlkOkqMcQgLBDSyJINRRNW0+Mhj
	oZ0P80rIqqU5QJrlgEo7+d3DIAr4ZaIC0kZidu0G+kiTO3JRi+3Crr4OoQ==
X-Google-Smtp-Source: AGHT+IG4bS2+ocjaqRvRyGLjJP01Sy52WmimWnPamnI64NXgRI8+n9naHTWfEfixcLGGzaIuhVVc1Q==
X-Received: by 2002:a17:90a:d204:b0:2c8:7330:68b3 with SMTP id 98e67ed59e1d1-2d646d70edamr14772946a91.39.1724768294843;
        Tue, 27 Aug 2024 07:18:14 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbb17d9sm14417205a91.43.2024.08.27.07.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:18:14 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] doc: deprecate UseDefaultInterface in docs
Date: Tue, 27 Aug 2024 07:18:09 -0700
Message-Id: <20240827141810.750603-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.config.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index a64e4f9f..448046c6 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -74,7 +74,7 @@ The group ``[General]`` contains general settings.
        ``[Network]`` settings for additional settings related to network
        configuration.
 
-   * - UseDefaultInterface
+   * - UseDefaultInterface (**deprecated**)
      - Values: true, **false**
 
        Do not allow **iwd** to destroy / recreate wireless interfaces at
@@ -84,6 +84,9 @@ The group ``[General]`` contains general settings.
        most users with an upstream driver it should be safe to omit/disable
        this setting.
 
+       This setting is deprecated, please use [DriverQuirks].DefaultInterface
+       instead.
+
    * - AddressRandomization
      - Values: **disabled**, once, network
 
-- 
2.34.1

