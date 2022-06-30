Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C417469
	for <iwd@lists.linux.dev>; Thu, 30 Jun 2022 18:06:11 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id dw10-20020a17090b094a00b001ed00a16eb4so225985pjb.2
        for <iwd@lists.linux.dev>; Thu, 30 Jun 2022 11:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t0j8KSCwWKe6mk9SXRLFL6SSwxrrPJzGrzeVOKcwk6k=;
        b=jOUoGnRE3GM8JCU2/Pb0mT+EUC/Get7KQDq3i8jGq1xFu6f6snLG+yTvCj0gbLk4wA
         4lNTBaFxjcKBdrksZctmaseIizrlb01NmGYwvb+c+CeojqHuJb2uJrdwejn9GnW6BBHL
         0KUS2NycPQDND/iQqVeneQvOsGZhbRRqlXYh8FP2uO9nkOo5bstmP0M4ApYMPu1n4PXS
         RO/3x6+jr6J15sRY6gbb4rpMsrFSdBJ28BUOYwCsJQnCbo4FVI6BZL62M/ZMR79fpcUn
         U0vtU/j3cDZB8fn7l8J1MikrYKHllGXSiuD2DARBGelLUt1lnT7TG145LnT2gfaUJ4jU
         kZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t0j8KSCwWKe6mk9SXRLFL6SSwxrrPJzGrzeVOKcwk6k=;
        b=I3HXLt9WQXWMOuVC8ljtsZ869OqEVSS/ILcT1JoMfw3FrFU1g2JABLah0DBA+q42LL
         0hKG1R+1wAmGd33FwucGLy9afS6LEqI+fsgtxwjaLCfhcgYa73G5+6PqRo9WNATVJ2A4
         +gH1KqktdsqiouUhaJt0UEPg4lNlrSmKIgCn3Cz5Abj1CiCoSs5LY7pzspA/crOB3Jjv
         R0aNp1SUsmsq9CTY3bFyEO0jw5lEn5dS2jdljM1zBJPJavM2+977tuHh89gqdXPOW3ep
         ojI1b73ZG2KLEe4akTlhQr0dGRG7pOE1NEBb0dg1m1lu4tA936JXlElLYi/6LzzgNXdm
         3mOQ==
X-Gm-Message-State: AJIora+VYtFjzFP5ZEiPCcx1EoOqmZfuKtNe6YR33U1dTQIE2Gq8cuZs
	Srw6qcjXbb6LHZ46e9zf0b593mrNOKk=
X-Google-Smtp-Source: AGRyM1uQHyPq8rBs2F5gCGY9ix2RV7g3ZIIMLIUaAihzu29XvGv6bPv+r/i6C8Wr5XkT/2lZAP9IJQ==
X-Received: by 2002:a17:902:eb86:b0:16b:a453:9951 with SMTP id q6-20020a170902eb8600b0016ba4539951mr8097975plg.156.1656612370904;
        Thu, 30 Jun 2022 11:06:10 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b00163ffe73300sm13777187plk.137.2022.06.30.11.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:06:10 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/7] auto-t: add client test to testAP
Date: Thu, 30 Jun 2022 11:03:31 -0700
Message-Id: <20220630180331.206419-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220630180331.206419-1-prestwoj@gmail.com>
References: <20220630180331.206419-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests iwctl functionality with ap commands
---
 autotests/testAP/connection_test.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/autotests/testAP/connection_test.py b/autotests/testAP/connection_test.py
index 273c333c..dff415e7 100644
--- a/autotests/testAP/connection_test.py
+++ b/autotests/testAP/connection_test.py
@@ -3,6 +3,7 @@
 import unittest
 
 from iwd import IWD
+from config import ctx
 from validation import validate, client_connect
 
 class Test(unittest.TestCase):
@@ -20,6 +21,24 @@ class Test(unittest.TestCase):
         # Finally test dev1 can go to client mode and connect again
         client_connect(wd, dev1, 'TestAP1')
 
+    def test_client_start_ap(self):
+        wd = IWD(True)
+
+        dev1, dev2 = wd.list_devices(2)
+
+        ctx.start_process(['iwctl', 'device', dev1.name, 'set-property', 'Mode', 'ap'], check=True)
+        ctx.start_process(['iwctl', 'ap', dev1.name, 'start', 'TestAP2', 'Password2'], check=True)
+
+        iwctl = ctx.start_process(['iwctl', 'ap', 'list'], check=True)
+
+        self.assertIn(dev1.name, iwctl.out)
+
+        iwctl = ctx.start_process(['iwctl', 'ap', dev1.name, 'show'], check=True)
+
+        self.assertIn('TestAP2', iwctl.out)
+
+        validate(wd, dev2, dev1, 'TestAP2', 'Password2')
+
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_storage('TestAP1.psk')
-- 
2.34.1

