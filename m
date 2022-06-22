Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A551C26
	for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 23:04:32 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id d5so16612639plo.12
        for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 16:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PhyFgYJMib1r+sn6iBZbjKCM1irtidU6HBjh0Q4XXVM=;
        b=iEx1k5p7/UQN1bba4GcyqSoNnzk6v+7FGDJrElawZOfntM7A5rWPB0NLh2Ktfjg2fi
         XeZsa4i0EczgksyVrdqovjlv4TohUFUdeU7CQA6fYqMFCF+CMBHm8JxgVFLGsIOzoNca
         T6kymCh2yIktoVjVgr4lK0YPx+xT5zWVSz8jKkvNorpoMKZTqGk7rvmioTXVvvj9WI4v
         BZ7fd8lU3j7UrHD7r06tJ4tGq/n3k6X78pi1k3cecss+G9svyHpbD2TOk0qs4WSQms+L
         yqrdSn8/kj8VR+aSjpLKIFkcIJlqiEezHpqtehyRKNNGTid/sFM4NnS6tjXVlOB2VnUc
         FHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PhyFgYJMib1r+sn6iBZbjKCM1irtidU6HBjh0Q4XXVM=;
        b=E6Syz9OXqX9deVexvPcG8iCzXWgPyZys9KOPZhE1iM25+DyQ9SbRKOY9oC0e0VXQFY
         V/dRkl85ojGXFQJO1zvZeVGZBMeyUEQrlT/Xf12LN9uVAoOzmlvupAUgsGOxX3uOMmC6
         4i3nAROVqJ800P6c3V5IBMXt8HtUNYQHgYL2cDguSTKjsebmtA4/KqgQ8frW15XJhg5y
         gO6eTtFOJz0Qdo6EAh2CAEA8jW83KIeST+zEN/1gDc2jd1iPG3RW2d414bcCKHEs0FGp
         NxYtnhW1KrZvQpfTIKkF7pMYPCnpKvTaVMRbZ3zGCJf2vSYrbD0d1jTi4eKhRYW9D7tI
         0d/g==
X-Gm-Message-State: AJIora9bA20JeoxUazhS6OfXX2jE2tg30nYsp5dex3XtGD/oRx5A3kjo
	VO3NXW8yr1p5J+Kl643YiSrhTOUXAkM=
X-Google-Smtp-Source: AGRyM1s6QmfIDH8S6WvpApP3bONVFm4v3xzR9n2WSC8SLa836Dz8VDjewEfDbhcbiEk04gf7Bjvwfw==
X-Received: by 2002:a17:90b:4b02:b0:1e2:ff51:272a with SMTP id lx2-20020a17090b4b0200b001e2ff51272amr763475pjb.56.1655939071497;
        Wed, 22 Jun 2022 16:04:31 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id jb6-20020a170903258600b0016a12571537sm9107052plb.299.2022.06.22.16.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 16:04:31 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] auto-t: fix hardcoded 'wlan1' in testNetconfig
Date: Wed, 22 Jun 2022 16:02:19 -0700
Message-Id: <20220622230219.1557695-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220622230219.1557695-1-prestwoj@gmail.com>
References: <20220622230219.1557695-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This works, if testNetconfig is the only test. Otherwise it will always
fail since the interface naming increments for each test.
---
 autotests/testNetconfig/connection_test.py | 2 +-
 autotests/testNetconfig/static_test.py     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNetconfig/connection_test.py
index 4b05c745..e73ab335 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -80,7 +80,7 @@ class Test(unittest.TestCase):
         rclog = open('/tmp/resolvconf.log', 'r')
         entries = rclog.readlines()
         rclog.close()
-        expected_rclog = ['-a wlan1.dns\n', 'nameserver 192.168.1.2\n', 'nameserver 3ffe:501:ffff:100::2\n']
+        expected_rclog = ['-a %s.dns\n' % ifname, 'nameserver 192.168.1.2\n', 'nameserver 3ffe:501:ffff:100::2\n']
         # Every real resolvconf -a run overwrites the previous settings.  Check the last three lines
         # of our log since we care about the end result here.
         self.assertEqual(expected_rclog, entries[-3:])
diff --git a/autotests/testNetconfig/static_test.py b/autotests/testNetconfig/static_test.py
index ac525b28..d9f0b9cb 100644
--- a/autotests/testNetconfig/static_test.py
+++ b/autotests/testNetconfig/static_test.py
@@ -75,7 +75,7 @@ class Test(unittest.TestCase):
         rclog = open('/tmp/resolvconf.log', 'r')
         entries = rclog.readlines()
         rclog.close()
-        expected_rclog = ['-a wlan1.dns\n', 'nameserver 192.168.1.4\n', 'nameserver 3ffe:501:ffff:200::4\n']
+        expected_rclog = ['-a %s.dns\n' % ifname, 'nameserver 192.168.1.4\n', 'nameserver 3ffe:501:ffff:200::4\n']
         # Every resolvconf -a run overwrites the previous settings.  Check the last three lines
         # of the log since we care about the end result here.
         self.assertEqual(expected_rclog, entries[-3:])
-- 
2.34.1

