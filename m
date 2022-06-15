Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A490C2902
	for <iwd@lists.linux.dev>; Wed, 15 Jun 2022 22:52:20 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id 123so12697592pgb.5
        for <iwd@lists.linux.dev>; Wed, 15 Jun 2022 15:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yCcBpF+YvPeCBecxmz9G9P4nU5CJiJy5WnTlSLB3XZI=;
        b=FjeriXNWsBB8gnyajEnNMuEw22CDEANw7U9iN9XtDnEG9g06SnLXwMWHfX6h9oxRPu
         4JvEBxHIwecrNWClGqrD1/CbYK8dLVNDphot/3TSHw76D1Je901IzyWKZDhITGrT6e5U
         ZeZls3ciWpaCpsg4Y+1Vn8btkbRfBeYppVP5ukEq8wsLRpFZxO+KIoayvQkLvaXCvs51
         iMaVafc+p4AySLH9Ljn5x4o6VoyqSbsV0Di3k8kF6Txl/5fzYI6J5JPbpGo1/WmyreL4
         xc191RZ3laRH1SHcJU9zD9jLi3CA4vY6D8+p5iJTKGkM9AVJxWgzJ7GHNZukYNnExrqG
         lwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yCcBpF+YvPeCBecxmz9G9P4nU5CJiJy5WnTlSLB3XZI=;
        b=S5Jlt2cUxtZ7NI9im3a7GaHWbdGgxVW4TWlnFlKt3W43LAdBsF3wNC/qZZgn/dtnSl
         Izu2i5f2rFqfSYRR7WT+ERFKHuSITxLOxXx7CZUEPNffIyA7U2R1Jfky3Kmy6dfcibBa
         2lWbHJrfAVYHqSYVKq+whRQXke4KTQSIEv0wqgEEJaYntx070Rc/jkJeaqe6q2gholKE
         JtPLilOZPI93MSUvR1EfLGuAWJFs64WkARbYl64A+U4xNk3sRnPbEo8K+x7AfSPsY/iD
         kRZGQlJDylXEKMuqGrV40/I53akbHlWGReldyj4z3f1OiZfIG4iy0TYxw+0HKXoeZDDH
         ngNA==
X-Gm-Message-State: AJIora+RyHOw5bHdgeSYoodpKng7p3EAF3f0RDXr4+KdBMdtzcHot+W6
	kW6ZAGy9wHXYEqV2Th+42vtLaAUWnD4=
X-Google-Smtp-Source: AGRyM1twYwzbTwCwNUG6Y8IuNUCgKwgntFPW2TY/qIwgsxQ9prhRBWmXZ1B18MUivrMziUPNYh99nA==
X-Received: by 2002:a63:130f:0:b0:401:ce98:24eb with SMTP id i15-20020a63130f000000b00401ce9824ebmr1783681pgl.217.1655333539647;
        Wed, 15 Jun 2022 15:52:19 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id jb21-20020a170903259500b0015ed003552fsm125466plb.293.2022.06.15.15.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:52:19 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: fix timing issue in testEncryptedProfiles
Date: Wed, 15 Jun 2022 15:50:12 -0700
Message-Id: <20220615225012.932391-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_decryption_failure is quite simple and only verifies that a known
network exists after starting. This causes the test to end before IWD can
fully start up leaving the DBus utilities in limbo having not fully
initialized.

Then, on the next test, stale InterfaceAdded signals arrive (for Station
and P2P) which throw exceptions when trying to get the bus (since IWD is
long gone). In addition the next IWD instance has started so any paths
included in the InterfaceAdded signals are bogus and cause additional
exceptions.

At the end of this test we can call list_devices() which will wait for
the InterfaceAdded signal, and cleanly exit afterwards.
---
 autotests/testEncryptedProfiles/connection_test.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/autotests/testEncryptedProfiles/connection_test.py b/autotests/testEncryptedProfiles/connection_test.py
index dd4892ca..2b846596 100644
--- a/autotests/testEncryptedProfiles/connection_test.py
+++ b/autotests/testEncryptedProfiles/connection_test.py
@@ -115,6 +115,12 @@ EncryptedSecurity=aabbccddeeff00112233445566778899
 
         self.assertEqual(wd.list_known_networks(), [])
 
+        # This test starts and stops IWD so quickly the DBus utilities don't
+        # even have a chance to set up the Device interface object which causes
+        # exceptions on the next test as the InterfaceAdded signals arrive. This
+        # allows the device interface to get set up before ending the test.
+        wd.list_devices(1)
+
     def test_runtime_profile(self):
         wd = IWD(True)
 
-- 
2.34.1

