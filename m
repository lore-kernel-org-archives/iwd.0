Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53324538E
	for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 17:09:28 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id bf13so13645746pgb.11
        for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 10:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZ33mqc4s3Kyho1buRy7IzFhZ6EuFHERV7589daBLLA=;
        b=mZt26apydJ6COQojp/srCy4dNERTNIR/CfiOoG/PlQyBfbSZh5mD1Pl14YzuTQ+sFz
         hP+lJREqlcDoO55LpBdz8nvF9TQjpBL7GX/q6CQiZyPI0jMD9ytmy6lX2ZwPFcoNP2Hh
         jp2q/6yqeVF36bRzHKtxNsZ1drlnZeMkziy/BLPiVOpqxRpi1j37WGokMJYtkZ5Mi/z8
         q7mXpNQHHjXqKTxS6XX45ZRgwygFi3pOrgRFkgw5BtTnRJ8Qhlj6SSy7LzGBozZP1/Xp
         6rQ510XVeABGsd7QhEgjEolodksANAGBOh52ZS4UdVQgSKP/IRUdZsIdhSEUNu34i4kX
         S3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZ33mqc4s3Kyho1buRy7IzFhZ6EuFHERV7589daBLLA=;
        b=styScSMIncdNc53cUt+IxPiC7Iu7FnI95GmtRj2AIj0vX3mcCefHfZXm2uukKxHpUq
         Cp+RQS48iN/348SQrcU6wHaAWCLul1WcTZ6QS/OJOt5dPoOsh9qcjaRpunCGFhi1NXSP
         3kidQx4xUvSQL2OpR3wD13kUFHuZL0eJqN8LOn54dOBIqATFJLzZcf/wOSVR2Qmv+0H4
         21/mR4rH8RSN6J69A5KCB62PlsPMLUY+WPVzNHrm5vAwftCzAKZfMt+P40LM88GavN6H
         03ykJ5jjFbL+s3u9Y2KhN9RCmCv725MDyY3Qo1jVklc2DBihR/pAy2fnd6nqroCEzBN3
         9C/Q==
X-Gm-Message-State: AJIora+zLTRfCx2ThVgDtFrUXAbfstx8NKpqxscQ2poR8umH2/dEZw60
	Vn5/YBFZ8Q9banIDZA2pPgMvLiqgSPs=
X-Google-Smtp-Source: AGRyM1tmWqLAEKN/sBoEBJ1PQMuW2mgQNerRBgTGevHG1fX0p1b6pesgPvkxnXfXamzzhGERPfNOaA==
X-Received: by 2002:a65:60d4:0:b0:419:9871:9cf with SMTP id r20-20020a6560d4000000b00419987109cfmr15801634pgv.214.1658855367576;
        Tue, 26 Jul 2022 10:09:27 -0700 (PDT)
Received: from jprestwo-xps.none (h208-100-169-68.bendor.broadband.dynamic.tds.net. [208.100.169.68])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b0016c09e23b18sm11778694pli.154.2022.07.26.10.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:09:27 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/10] auto-t: iwd.py: let IWD class specify developer mode
Date: Tue, 26 Jul 2022 10:09:13 -0700
Message-Id: <20220726170920.15929-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220726170920.15929-1-prestwoj@gmail.com>
References: <20220726170920.15929-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/util/iwd.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index db91ab8a..b17fe163 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1098,7 +1098,8 @@ class IWD(AsyncOpAbstract):
     psk_agents = []
 
     def __init__(self, start_iwd_daemon = False, iwd_config_dir = '/tmp',
-                            iwd_storage_dir = IWD_STORAGE_DIR, namespace=ctx):
+                            iwd_storage_dir = IWD_STORAGE_DIR, namespace=ctx,
+                            developer_mode = True):
         self.namespace = namespace
         self._bus = namespace.get_bus()
 
@@ -1107,7 +1108,8 @@ class IWD(AsyncOpAbstract):
                 raise Exception("IWD requested to start but is already running")
 
             self._iwd_proc = self.namespace.start_iwd(iwd_config_dir,
-                                                        iwd_storage_dir)
+                                                        iwd_storage_dir,
+                                                        developer_mode)
 
         self._devices = DeviceList(self)
 
-- 
2.34.3

