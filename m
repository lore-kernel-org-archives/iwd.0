Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EAF2E85B
	for <iwd@lists.linux.dev>; Fri,  5 Jan 2024 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFSxr/Ec"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68015293aa3so7305246d6.1
        for <iwd@lists.linux.dev>; Fri, 05 Jan 2024 08:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704473231; x=1705078031; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9oAst9urZa4o9H5Zt3GkZAIAqgHEw+l5YMumZ4li3nM=;
        b=jFSxr/EcJfqg+FsnKsNFvKkrhikWxVALItA2h7F977udRSpOKjRu/41oQ+qiaqctxV
         BrD0qbISqNPK1s/vPVc5JJPgX3hfIamfDgVz+gYHk1cZ+IRVATVlFjSqggjsRWqpvaRS
         ljBJfwkfN0wCakuxXiA+anzBrHSHj9gdsEHAGrhmOESSABwpQsAun1JdyTaR6IMDxj3w
         r5Feni2iJjRuucQLmczDFCG1waVhvYo+91zzcdH/1lUXw4bORlECo2KGuSSC7dsY9foj
         0EV5F6rOy6y3tp9SlrqMHkl0wOm2YXv5oF2g90o5y9biTQT5Lex0tZaGTW99q3g8vJ1t
         wYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704473231; x=1705078031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9oAst9urZa4o9H5Zt3GkZAIAqgHEw+l5YMumZ4li3nM=;
        b=ko52ZKafVLwTQfchQuITHn/6/Z7iF8ZJGQ6cyKOCP7RzBAOI0Tl+dqB7XHFJ5dzawU
         75E5G9eDvmVhUb5OW6s77mP35FVPNwf8nWOeWQLj0tZejd1StV/kBhaj24ujH4pAeBrK
         sJFPlkPCDa2WqC4YstD7podZIG50sa2M9ZI678/0rQw+jUxogfq8Pcb4fMxq6e8LE9O/
         +tcHTMLgA0nSsyB/Hgbr7nZKRmqhjLjHdpGxi2+14FxU8aCpqG//pU0X/ZwSFV/0i5FF
         qPTiWDAqYlU1Kwa9BZe7jcIzs9E2w4H31xgM9TAAKmJxb5lAReArVuU6lkU9kqr1uI/X
         7wWg==
X-Gm-Message-State: AOJu0YylkIo7hA3Pf1OK2jJMC6sWQtC/Xto0u/swuHPLr3Z5Gx1xtc7I
	sZFJH18UkqGGBHA59P6MFa1UjDizG90=
X-Google-Smtp-Source: AGHT+IGvJtRM/PdBfJb+uk4TI3vp12JxMc4Bj9PjiO5RSQTfVe6H4iGgYbmJZgimDX1XsTXrNImLsw==
X-Received: by 2002:a05:6214:410f:b0:67f:48e0:6725 with SMTP id kc15-20020a056214410f00b0067f48e06725mr2489634qvb.43.1704473230677;
        Fri, 05 Jan 2024 08:47:10 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id v13-20020a0cf90d000000b00680c50735c6sm731859qvn.88.2024.01.05.08.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 08:47:09 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] build: make missing rst2man non-fatal
Date: Fri,  5 Jan 2024 08:47:05 -0800
Message-Id: <20240105164705.1071723-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The configure.ac script does not fail to configure if rst2man is missing
but instead sets RUN_RST2MAN depending on if its available, i.e. makes
it an optional requirement. But then in Makefile.am if RUN_RST2MAN is
not set it fails fatally and will not continue with the build.

Instead remove the false return so the build can continue. Another
option would be to put a hard requirement on rst2man and not allow
configure to proceed, but based on the existing logic it did not seem
like this was the original intent.
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index b634b730..c8a59f50 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -725,7 +725,7 @@ RST2MAN_PROCESS = $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
 			--no-generator --no-datestamp $< $@
 else
 RST2MAN_PROCESS = $(AM_V_GEN)test -f $@ || \
-		{ echo "Generated manual page $@ does not exist"; false; }
+		{ echo "Generated manual page $@ does not exist"; }
 endif
 
 %.service: %.service.in Makefile
-- 
2.34.1

