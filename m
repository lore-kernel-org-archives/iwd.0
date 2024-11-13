Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F352022E8
	for <iwd@lists.linux.dev>; Wed, 13 Nov 2024 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505339; cv=none; b=hacpLQ1J8xq2r/Ct0yAg7dHIbwnPVPQPazFgyoU2QyISN9KUdGK0g1a36cqSQ2sxhQOnp17+cVtTqzxYldscMHdqZz2kfgv6aCKm0LoZrBbRQeDw50NSumW9S69vtJ/qlMqGz0boCkrLSTpDIJhwsc+jpQ+ysJuRV/1/PM61VWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505339; c=relaxed/simple;
	bh=D4MZym/BTGnB/B2gbOnif8cOT3Yk+lxSfPCNZoyBz2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BJE5ekwTfASh+Bd9UoZ+dvwg3yc8u8pRey60mMwM+/KZB9NLp9pUt/hXAHbU90spWeeE3rwYD9oSTWkDunvRXGb/+hJ2tefDgZCNXZaRZDSbgexhxwDmrrM5HndWxizto/FfAe7zAycqij7MzDAJyW9IupSvH3pAuTA0NRJ2nDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qh/KOGo8; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh/KOGo8"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ebc9bda8c8so2990565eaf.0
        for <iwd@lists.linux.dev>; Wed, 13 Nov 2024 05:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731505336; x=1732110136; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg3YCKnPBFbECNLeUG5I+9/aiIbD/fNcSI6CocWa1l0=;
        b=Qh/KOGo8cyC7rz5VmKoZvDbcqkR49HLC6F4+71z4w7QYf2xqyUt4sLsh65WzbUt1x5
         AD0lJ9Y2JozBkCv1pVPM6jLnyoyNAn/vCM4oCrKqjDCtZz+H2o4j5WycSAIIOW/CNJUD
         BnI0u1ST3D26V9dbx27DD8XiOS7Nnu0tKvKaKHXTMru0IDYIr6Knxru8zP+JPkWlIsZw
         DmyEQzlE0Ohg/t6XJZOQ1BuidWnaMlE+/oi630GyRj2kmIq5loUa0eCwXwlvM0nKo9ee
         2N0ifFPMHrFoH6rUpjS7eDL6H0cRI+AQqda+JtW4x2Q7qjvLHYFBAux/hYA0pUVulvCC
         oA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731505336; x=1732110136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cg3YCKnPBFbECNLeUG5I+9/aiIbD/fNcSI6CocWa1l0=;
        b=FdD9qJQ6ljbrGZHfY6jdzKd4pkXaN3BH8EHdFA6Jwpj20aN+/sdAm4mqYcaL6JyFil
         btRE6DGbfvY4w65SOamVC3VW5pavKx3ybTJ7iCtKfbSXXgYNtcgnSAopFtFiV4PGmY0P
         10rmDxLtct604UvkS4Y6fwhy035o1dw1SPI10FFSz7HFwdyr3WTcsh4fXMLXV9fHwdYi
         cZlwQB4pTZ3IhWwWWJwOtWjaM0tVbLsPLkPvzxInmQm3GpnjWvBChw52ixGwDlXUcEBn
         gbliIYkg0YTJ2DgcOzEJrSQNr3xU7IlI8wjMfX1w+DReDBfaZHD5XcHX3iUTRmgFXRzE
         8fvA==
X-Gm-Message-State: AOJu0YwhJ70eBB3FBTOlMtUTkT+fLVhgWEXXngCNVfFvd0YXmCebhLLM
	Jh+Yeg0Cr0jw/Y1m+3HlYxtN4pqS0eaSyTrsbhcf5aAseGQccNEaOtA3Ew==
X-Google-Smtp-Source: AGHT+IHtmY/bfvmTcNlwJZ3cClzX8PkPDbR3/IQhVm2WdoGll875zfvUnfcidj//01HDjgRVpsYhGw==
X-Received: by 2002:a05:6871:d202:b0:288:33d1:a95e with SMTP id 586e51a60fabf-295602a5628mr18382898fac.30.1731505335698;
        Wed, 13 Nov 2024 05:42:15 -0800 (PST)
Received: from LOCLAP699.localdomain ([12.0.50.210])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e8fe5c56sm691620fac.27.2024.11.13.05.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 05:42:15 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] monitor: add better info about the country code IE
Date: Wed, 13 Nov 2024 05:42:12 -0800
Message-Id: <20241113134212.20698-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 3rd byte of the country code was being printed as ASCII but this
byte isn't always a printable character. Instead we can check what
the value is and describe what it means from the spec.
---
 monitor/nlmon.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index ac594c3c..60adddc5 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -491,7 +491,30 @@ static void print_ie_country(unsigned int level, const char *label,
 		return;
 	}
 
-	print_attr(level, "%s: %c%c%c", label, code[0], code[1], code[2]);
+	print_attr(level, "%s: %c%c", label, code[0], code[1]);
+
+	switch (code[2]) {
+	case ' ':
+		print_attr(level + 1,
+			"3rd octet: 0x%02x: All environments", code[2]);
+		break;
+	case 'O':
+		print_attr(level + 1,
+			"3rd octet: 0x%02x: Outdoor environments", code[2]);
+		break;
+	case 'I':
+		print_attr(level + 1,
+			"3rd octet: 0x%02x: Indoor environments", code[2]);
+		break;
+	case 'X':
+		print_attr(level + 1,
+			"3rd octet: 0x%02x: Non-country entity", code[2]);
+		break;
+	default:
+		print_attr(level + 1,
+			"3rd octet: 0x%02x: Annex E table", code[2]);
+		break;
+	}
 
 	while (i < size) {
 		if (code[i] > 200) {
-- 
2.34.1

