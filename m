Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F8CC133
	for <iwd@lists.linux.dev>; Thu,  4 May 2023 21:52:55 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-61a35fdf61dso4969926d6.2
        for <iwd@lists.linux.dev>; Thu, 04 May 2023 14:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683237174; x=1685829174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVEzcMbtCFwrxQbeXo/PeVPLuMaklYLmcNuMwDsP/3I=;
        b=FoMZ2dVq/18D3MPB98A9IjKft1sfjtfj4+JWokPgfxVf97Ofg1zgJkFC+USgXtW4eh
         CBt5SsLuouKO58hT4DF9l4ziWkyafHKr/nKwBtpO7cJHH/pWT6+bpjubVrQAiano10d5
         lMjBvNI7jbz1VhD9JmzEvr6EpfiIna0E8MMqqVZSm1USs4anvefxwDDu1VEyBmieZ/4I
         q01+eS+2Uo9L+HsKbCO0CcS39i0ozomRNfpVMGckubLxYywyz+FP2BkXEj9CBz/ZjUW6
         59IuBOOy33s58/ACVv+C513up7aFi28bAZI2Z+2p9OTcHAGX7nT0ZXAq869UXz5hXaoy
         o9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683237174; x=1685829174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVEzcMbtCFwrxQbeXo/PeVPLuMaklYLmcNuMwDsP/3I=;
        b=KOU83LbYYezpb59e9L5oH5XH1slBsrTiu8OnAxyz9HsD1ndixHe/2+zHNDD7jO2QFT
         /nfbH4ldt6EdyngiaQxII/oCbAPmcv5W8qixeAIeoALgzzgi6G+clW6jINRKTaNikWmR
         do6nYyFoka08+XTPDv1+xZXPo/wi5pmuvK55UXNZJ2DIYv/h2R6anWdAT5EuIOByCQuX
         L/w1t9R0GPu3xfY9Af4KVB0urwD/xRwzUiu4TDKbyhDoKrlVK1pfPbA54KUyNADp2Akz
         a/983Tcg6WFa5Dn4niw0XRNFNvZqrndNv0sgE/HUJaSGGMTvxWT1DZ/+bKFuktac7Rpn
         o2RQ==
X-Gm-Message-State: AC+VfDwDKSSh+AesbmGeb+P5gAdHoMaVURX5SZTHKO4lynrmZY14ZNOM
	VOs17LrlZmg/PmyTvUEg5Q9EWTpz/J0=
X-Google-Smtp-Source: ACHHUZ4Ptfpt3hDZkl0hXnVlkMXA/MeQf+/lwbDohb7gSTmBMgT4rRLro7YfnyBNF5CIH0n6K2PluA==
X-Received: by 2002:a05:6214:3009:b0:61b:65f9:c1e6 with SMTP id ke9-20020a056214300900b0061b65f9c1e6mr16641624qvb.17.1683237174135;
        Thu, 04 May 2023 14:52:54 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id v9-20020a0cdd89000000b0061b5b399d1csm52262qvk.104.2023.05.04.14.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 14:52:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] test-runner: fix __str__ for namespace processes
Date: Thu,  4 May 2023 14:52:47 -0700
Message-Id: <20230504215247.581443-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504215247.581443-1-prestwoj@gmail.com>
References: <20230504215247.581443-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printing out a namespace the Process.get_all() call was
returning all processes running, even those not in the namespace
being printed. Modifying get_all() is tricky since its a class
method (and used elsewhere for ALL processes) so instead filter
the results to only show processes in the namespace being printed.
---
 tools/utils.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/utils.py b/tools/utils.py
index d2e1c33b..48d5d219 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -529,7 +529,8 @@ class Namespace:
 		ret = 'Namespace: %s\n' % self.name
 		ret += 'Processes:\n'
 		for p in Process.get_all():
-			ret += '\t%s' % str(p)
+			if p.namespace == self.name:
+				ret += '\t%s' % str(p)
 
 		ret += 'Radios:\n'
 		if len(self.radios) > 0:
-- 
2.25.1

