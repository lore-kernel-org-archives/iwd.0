Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AEA13C9D6
	for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236627; cv=none; b=h0LSmrmmkwOaXUDIFkf2JGD5tQw5YFg1XqPfqXORB75yO87SpKSd55uwyzfVUrb39rMuknOTaDooR93Zm/+qrNvzFgTSwiRTAlJJfXx8TsirxU3KTg8A9g6//OAflfNxXJ9iyaYsKXdglPA+mxdONTfi955WYYyScZNhf6K0iWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236627; c=relaxed/simple;
	bh=4ZPHYtF2lZp8KlJh20QDp9KyPYsVommORINWSAsimjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R1yDlVHNiyOLXICAvyRKaqq2iVICHFi0lHzba1F1g5VH/7n5Q5FcVjG8phpl1vJSNnOIEYaFO0aclO5QolPg3YHeDLf5sbboAjBhDOMxW9qe1seI1ly27u077nx3yhfW1m22l7Q8IEYKjhKBGV0ZKmYyquW8ch0iOLVsGtQD7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/v76ctT; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/v76ctT"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-690105304b4so5939896d6.3
        for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 11:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709236625; x=1709841425; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rAP58aQhdTqjdso4EZqlUDeMAq4mYbwCGtw+edEHokY=;
        b=F/v76ctTNkBeppJr+LOFN5wDZsQHtnK19JZVvq/nJMcfkaprObnHIAi3qPIBq7MNYS
         H+yUQQITjMTmI84R0m8FhqLw81h5looMAJd0LLg4qK3zrcqR6bJBhpflGomWcSiJrI7c
         0xvu/S0+6QhYXBj+QL38nqOSPmvswDyR7wLLG/Pn3qKOYnSMkmBlxsgzb8N1meAsYlHC
         p5gofpkxKPGKV/p28oBp202jlzFffACwCAZlbFRSmJyGe7KQVjR1MIs0WH+dyUKSfiUn
         tjwNhtSktc6wwLApOyKQ3lkHfaoBoFRHyBZ5gaNShj7G0uBX6lbi447lY/a/GIU7wJFk
         AhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709236625; x=1709841425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAP58aQhdTqjdso4EZqlUDeMAq4mYbwCGtw+edEHokY=;
        b=AFc/MnT9HhmeZEwcciNaF2OiXW/0rb9RopK3dlVaRuDx5jLHR+nKzqkEBtcpY1wDEv
         T4f6x6LK2GIQzhDKjePd75LeVrljLYrYGzLfXhxM2Itr0iF9vMhZVv3ZjuA0ltCNdD80
         DgGstlL7ZZWgLSGwQVZAG062QhVdr8q+m1snlLF1DIJboNWk3C/88HkSWhVrLUlYzf27
         l+86pH3qxmArKAUCU4BB/lI3B2VHD4HF10wMkW742v1GcyfFyQGu7rwTnCwyHFkYg/jP
         1/mgj+O4j0guOrWL/RdVSTFkK6NGR/QlgA4zINYYeCSvuW98pgwMvK7OaId5F7kfYSbN
         haLQ==
X-Gm-Message-State: AOJu0YzDlWvknRFMzaVqFTVgOGRP6XqB6GMISYNT3oN9Uzi7DRx+qnLC
	Ngt8Ykb3RU6D8u+ecIS3ND1pASW8NrQOWNHIrQ0+zn11mOPIEGh4EUYLwhKe
X-Google-Smtp-Source: AGHT+IGcIOKtWQTQcnYAwxgIEijH6oYfdVP44B4g/jXIwa7KY6so2o0z40xU5ccsiDZBM9ZBJGSmHA==
X-Received: by 2002:a0c:8f19:0:b0:690:524b:8d2a with SMTP id z25-20020a0c8f19000000b00690524b8d2amr913321qvd.52.1709236624901;
        Thu, 29 Feb 2024 11:57:04 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id qo17-20020a056214591100b00690459b2271sm1064468qvb.24.2024.02.29.11.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 11:57:04 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] build: Create ell directory for ell/ell.h target
Date: Thu, 29 Feb 2024 11:56:54 -0800
Message-Id: <20240229195654.1579749-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both ell/shared and ell/internal targets first create the ell/
directory within IWD. This apparently was just luck that one of
these always finished first in parallel builds. On my system at
least when building using dpkg-buildpackage IWD fails to build
due to the ell/ directory missing. From the logs it appears that
both the shared/internal targets were started but didn't complete
(or at least create the directory) before the ell/ell.h target:

make[1]: Entering directory '/home/jprestwood/tmp/iwd'
/usr/bin/mkdir -p ell
/usr/bin/mkdir -p ell
echo -n > ell/ell.h
/usr/bin/mkdir -p src
/bin/bash: line 1: ell/ell.h: No such file or directory
make[1]: *** [Makefile:4028: ell/ell.h] Error 1

Creating the ell/ directory within the ell/ell.h target solve
the issue. For reference this is the configure command dpkg
is using:

./configure --build=x86_64-linux-gnu \
	--prefix=/usr \
	--includedir=/usr/include \
	--mandir=/usr/share/man \
	--infodir=/usr/share/info \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--disable-option-checking \
	--disable-silent-rules \
	--libdir=/usr/lib/x86_64-linux-gnu \
	--runstatedir=/run \
	--disable-maintainer-mode \
	--disable-dependency-tracking \
	--enable-tools \
	--enable-dbus-policy
---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index 5ed6ab37..be287572 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -710,6 +710,7 @@ ell/internal: Makefile
 	done > $@
 
 ell/ell.h: Makefile
+	$(AM_V_at)$(MKDIR_P) ell
 	$(AM_V_at)echo -n > $@
 	$(AM_V_GEN)for f in $(ell_headers) ; do \
 		echo "#include <$$f>" >> $@ ; \
-- 
2.34.1

