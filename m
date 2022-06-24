Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5135346B8
	for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 23:09:57 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id 65so3728474pfw.11
        for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 16:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/kXefAtho8jfxO7eiKKlDAV+3NVY1UBpBGDU8pZOKM=;
        b=DS6h3sZ/vDP65fF5NC9ZLvJ3xPQpWi19RMZWun8PUEGBexBL5BK5taoQBqrNl8HBJa
         t7jnqv6T9PUlpuHMlNQDfBCfhzS45vTwrYNXIBbUoXhGnNaw79P0Qv3Y4qnJrJRAAWVV
         AF9WlpL5jzYpSzp08126P+xEnVCHdqVek8dyu+2gep+EZVNFpus8/KrIKAsBDqPEO47n
         WzQh/jBTpgh1aUn0qHHZ57VJ7hwFUQf56JAP1YfFmeQ5yUz0LLiUeY598adXd8RURkUf
         qoM9tXWWRf4Q3Usx/79BdXQ1hmPoTEqbUiWZP37PkZWUaUcOs2nkn2OYe7dkfhI1Fdzv
         opdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/kXefAtho8jfxO7eiKKlDAV+3NVY1UBpBGDU8pZOKM=;
        b=GwtXssBjadRmnKrQYTTSl3n8UiJuYD17joWTzuk+qfKTdU42cgGmgO7cDPV+OfYyEV
         FnukPut/9MnJ7P+2dASQmXr31aqEB2CmSOubtOqKSZ5MX9E/pqKtKC9IRIMh0kT3c6Gc
         GPF8aEHA7SgsMAq2aM9wWKyf067psQa/YLiVyxNAY6MRbnALpMbZ3sW1Hx8bF0/5EZDX
         ZATwLfYVc5eXxopR4HX7qhv+BQgRgf24rRaz3n5Z8HBonSDCjthBurK0DH2xMUc2NB9Z
         0RjwhG4pClVvehIyVffOZ+a16s7Rhc76wQkH9uW5OnpjA7PWbk5XE2IRKyUyku5Rwfbk
         uLYg==
X-Gm-Message-State: AJIora9GM2siNzeRhWOr2Rx2YQ+pGbUZd9MLjzwEgcciwitAxiditNnb
	5fza7U9fYysJDHaTaegqVzFdmB4HwN4=
X-Google-Smtp-Source: AGRyM1vjnxmvza0YPBO4pgpxbY1w5io3bdqH3b47j3jrdOuRhDMugbJVCu6/+r6bgv4K4QZJqyOt5A==
X-Received: by 2002:a62:6410:0:b0:4f3:9654:266d with SMTP id y16-20020a626410000000b004f39654266dmr1499602pfb.59.1656112196551;
        Fri, 24 Jun 2022 16:09:56 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id 64-20020a17090a09c600b001ec9ae91e30sm4449767pjo.12.2022.06.24.16.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:09:56 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/8] auto-t: fix testEncryptedProfiles mtime check
Date: Fri, 24 Jun 2022 16:07:37 -0700
Message-Id: <20220624230741.1957863-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220624230741.1957863-1-prestwoj@gmail.com>
References: <20220624230741.1957863-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yet another weird UML quirk. The intent of this tests was to ensure
the profile gets encrypted, and to check this both the mtime and
contents of the profile were checked.

But under UML the profile is copied, IWD started, and the profile
is encrypted all without any time passing. The (same) mtime was
then updated without any changes which fails the mtime check.

This puts a sleep after copying the profile to ensure the system
time differs once IWD encrypts the profile.
---
 autotests/testEncryptedProfiles/connection_test.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/autotests/testEncryptedProfiles/connection_test.py b/autotests/testEncryptedProfiles/connection_test.py
index 2b846596..ab5a0ae7 100644
--- a/autotests/testEncryptedProfiles/connection_test.py
+++ b/autotests/testEncryptedProfiles/connection_test.py
@@ -6,6 +6,7 @@ import sys
 sys.path.append('../util')
 import iwd
 import os
+from time import sleep
 from iwd import IWD
 from iwd import NetworkType
 from iwd import PSKAgent
@@ -48,6 +49,8 @@ class Test(unittest.TestCase):
         mtime = os.path.getmtime('/tmp/iwd/' + 'ssidCCMP.psk')
         self.assertFalse(self.profile_is_encrypted('ssidCCMP.psk'))
 
+        sleep(1)
+
         wd = IWD(True)
 
         # Make sure profile was accepted
-- 
2.34.1

