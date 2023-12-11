Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A1948CCD
	for <iwd@lists.linux.dev>; Mon, 11 Dec 2023 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd9IZNxg"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6cea5548eb2so4168350b3a.0
        for <iwd@lists.linux.dev>; Mon, 11 Dec 2023 11:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702323469; x=1702928269; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SV0S3WFNQluQTsScL4CpHk/TV4worelN0FxgQ3mUGIc=;
        b=Xd9IZNxgdyKRg1wS+nfgVma93RNVofVhNW2tGxKA1ykBngaCwQ4KqvdOSa/ci4Is/a
         8fPqF5IfBVYUsz/81LLaoY0BSw89yMMfkO13/NPMVhdThvTUbUP7BGFI+02xgsXJNaeE
         gwAKchlhUoCSR3niPBuADlXUamWmc/nR+zj8BJj/ur9o/8dI/Dx9DzouWtlA44g0MCrt
         hW1v+ix8nj4MThWcErOVmYm8qYwcmyPY33f/zxScfjD5BV7DDnjc1tQXBKWAmoLJH4Vy
         zeACRtKcfVwTf6O4iOFOh0dFuKTsmhzHyhBKswKa5nQAIqMDjTxGBB+rm6dIYx2XmdYM
         /I7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702323469; x=1702928269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SV0S3WFNQluQTsScL4CpHk/TV4worelN0FxgQ3mUGIc=;
        b=Q8z5Y1hCT+Qn3r6ZvgrfYuCNN3SQOpPZeJY9/iuGkSzNuQAe0UnFQejNsdXwEdax43
         acgNUEH/Fm5yAP1rL1T95cmlehGgmeXVOZAFo8NO5q6h2OPc/XpM/zD4ANWq0qV0iCGj
         9aJPYFFAguoI67US/+S8WShgAhkz5CIxgMfsRrgQQO6OdzwJEGX+wDQOsyK+4386MBRR
         Ztlj3/l4rNPRd4P83BK32XN/WGaq/TbHwf4un4U0Fu+h6y56hV0AtHSgiAD0zhSy44le
         +AsDX/g9N3k0jVkcuqMFnmDNaoNeMTQ8+ZeVq40uEviZ4ue8k/Rsf5QwHgcTZqZoPmPz
         FmSA==
X-Gm-Message-State: AOJu0YwzB8yTX1mTP6u++ts6Le52sZUniYJIYGSaR7NEu8nt5RP7CmAu
	x4BeIkVjQLa0NwxzcmTB/mZU25aO59c=
X-Google-Smtp-Source: AGHT+IFjzVsxM75x61x0VyiCbvJJoDz3mRlPaXEjwxFJl/uuYpiwqmWqT/B54T4hskTDLO+XvGI0ig==
X-Received: by 2002:a05:6a00:1742:b0:6ce:5288:f75c with SMTP id j2-20020a056a00174200b006ce5288f75cmr5941341pfc.34.1702323468787;
        Mon, 11 Dec 2023 11:37:48 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id k3-20020aa792c3000000b006ce77ba135esm81832pfa.217.2023.12.11.11.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 11:37:48 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] dpp: set "" arguments to Release method call
Date: Mon, 11 Dec 2023 11:37:39 -0800
Message-Id: <20231211193739.64318-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without this the DBus message does not initialize the message
correctly which causes future DBus calls to fail.
---
 src/dpp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/dpp.c b/src/dpp.c
index c7cd4bb3..1ff4b99e 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -391,6 +391,7 @@ static void dpp_agent_release(struct dpp_sm *dpp)
 						dpp->agent->path,
 						IWD_SHARED_CODE_AGENT_INTERFACE,
 						"Release");
+	l_dbus_message_set_arguments(msg, "");
 	l_dbus_message_set_no_reply(msg, true);
 	l_dbus_send(dbus_get_bus(), msg);
 }
-- 
2.34.1

