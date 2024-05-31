Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D5E134BC
	for <iwd@lists.linux.dev>; Fri, 31 May 2024 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717188354; cv=none; b=pd+2E54Or6/sHd1c3Ig45l9eJd3g3Z/8t47gocplTfOGblD4jQUlbxm0BxbS1iRUGApHHWfh5/toCMwZOML2GwTnD63G+k4oR4xITDNadiFXZC4cGopT/p+fbwcb75qaoeSNA0Mhb4xKuI6shLhndVvSlRUvqG0q/BoQIV1JH8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717188354; c=relaxed/simple;
	bh=m5h0YMNO5NS/+FekpJm/XnkK5Av+dJ5Y/fZywi61X4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S/Hx46KnkcjOrAnR8qOTNk3fYxJ+r++1kYyeF6UruZCwdIBT6W/v+MBfFCwZ2UbPjUsSvHJf718ZE0V0k7DKO3akwOclqEDZGmXOJD0PAUdJjuu4iYgNo3p3zRJsgYBLhVm2prfMLroPCdlN2BRwG6x8AdWRkt3t59QuXXzjKFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhX6euVI; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhX6euVI"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b9c7ae2c98so1403371eaf.3
        for <iwd@lists.linux.dev>; Fri, 31 May 2024 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717188352; x=1717793152; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A7+ELuxbLW5jEtTZuTYwUKppEQOUCOTqjDbJfpvV6ec=;
        b=MhX6euVIKHf4Ihqnn/h4lIge7inKeCPY0fKsObDRCBpPssKCVjskwphMdWI6dqjrjC
         QsvrmPAr3HSM7L+nws3CwN07Jtw3joD3Amm+vlvQZrXVS5V3u+cO84WgiOXcPyjtQBYw
         7Dccx+dEIX9F5+vVYLGtwokHjlLTPOPx0ju980GZ54d54BmVQgrXAbpoaQiLUdlA3g0D
         jgro1RfMexDEFTRKHTnl7/8/epL2w/CjbuuSFBPgDiG48FjoNdSC5exlLkvh1LMUULiL
         ynd8/hzOeQiTTBgofpF2r6ssaMrcZ2rs9EZeJw1B+mONmM0NLoUUfNNS2T66O9zGbopd
         h5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717188352; x=1717793152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7+ELuxbLW5jEtTZuTYwUKppEQOUCOTqjDbJfpvV6ec=;
        b=Rm5yasbvLF96JILC1U8C7qj2LLVst919MAR3EjQhw8uSOGM1xe8mOj71z/X45Ygr3A
         lqml6yGSJlTlsa6Ue/fnTIl61uW40sYdxd3/snvVlj32yuGaQgXyespjCP52hV/rAuZO
         GmurdjJ5tkaYPcrAZgolKtmOPuYdF30LuFaOjDzpEyUA/Xbmf30+1ab8CB+IVUGqypPY
         SmteWGqouVW9GtMJxMTN/ZSWFD5BE58IIy92eySpjdRuHz25VmCzQhLWtgBr2/vy7tip
         ozpEhdAawbUNBi/W/W4CGl3lO89eDRsyu2XmD8ZD/7GJtNwVmZ30JiJEheoSrws7izTx
         sH1A==
X-Gm-Message-State: AOJu0Yzu4QB2MbvA45GaHQpY4clTovvetMAIgtL900bjynAsKmI6K3Xq
	3ystKqUZOGzbYqW2V/mAqrtql8uvp9mJnJC3eP6ifHMRhfTCFD2Uc5/JVg==
X-Google-Smtp-Source: AGHT+IG3g6lgv0josEIoh3XoY7m7awbEqdSLT8sLnWsMxo8wj9IT49Px/zhKNLrCBS67aqJvMPIu2Q==
X-Received: by 2002:a05:6820:556:b0:5b9:f577:f528 with SMTP id 006d021491bc7-5ba05debd5emr3331118eaf.8.1717188352057;
        Fri, 31 May 2024 13:45:52 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba003994b4sm505256eaf.13.2024.05.31.13.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 13:45:51 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] build: Add notifylist.[ch] from ell
Date: Fri, 31 May 2024 15:45:48 -0500
Message-ID: <20240531204549.727842-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Makefile.am | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 3f7d444a7270..0ef4f965a372 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -64,7 +64,8 @@ ell_headers = ell/util.h \
 			ell/acd.h \
 			ell/cleanup.h \
 			ell/netconfig.h \
-			ell/sysctl.h
+			ell/sysctl.h \
+			ell/notifylist.h
 
 ell_sources = ell/private.h \
 			ell/missing.h \
@@ -145,7 +146,8 @@ ell_sources = ell/private.h \
 			ell/dhcp6-transport.c \
 			ell/acd.c \
 			ell/netconfig.c \
-			ell/sysctl.c
+			ell/sysctl.c \
+			ell/notifylist.c
 
 ell_shared = ell/useful.h ell/asn1-private.h
 
-- 
2.45.0

