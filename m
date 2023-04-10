Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677732F3F
	for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 22:01:47 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id o2so5878032plg.4
        for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 15:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681164106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHHCIa+REkf5NO0B3gbOMDtFmu+SyNSnD9c74Ql0EmE=;
        b=YqqEMnHTBkepv5oELsOot+meaEsFg8uIfrtEgt/u23GjFy0PLLZ+Bvuhdhs2Jmr8zr
         OFo8TAw7PJIIzPaf2YGxkWdIPN+N0uJygJm0f0nI/w3AUjPFX2lRNXHqv0mYPVLrmVTI
         FbRwpY79cAHCn+7NX9GjFVYgZucA19/yYGzmr4bGF75Ir/Knl/RJi0U8k6dQo9g6ZvY8
         DHWZvZ5/pZUSulQIHlNGFbTBo2fZwGcZ3/uTGxVNPPFTDONN7snU9hL1NYqrqBt1tTBr
         04ILWpDDhYrnFQPRW7pwQYK3GAj1rGkUxBMtkhOAmN7Xtxu4e8plGN8ZdOZ2gIrGY8pW
         7ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681164106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHHCIa+REkf5NO0B3gbOMDtFmu+SyNSnD9c74Ql0EmE=;
        b=ZF6s29tEaKsRsCML8i0NQjp/bSK1c2tgxSbWQXibnOcc5RC7Ttru1YhKftXqHAVYRe
         efJQO6wyEWmE00fsJJsBpe99vYqd1txZzhtso34BwvnLERm6+ANIrig6DOR1hhOdKpOh
         8+2JihTYFE1Dsr34YofrgydsDih7zcFAoz8caTP4Q8qKVLOUD+QsnDEracreLLxG8BbS
         48+FbY+n5YjH6MGEdwuiV43Bj6nQopNqxW/qlk8rHTjUzEXTKIvrBCfUIOZ8z5haSmoa
         vy4T4DaHCWA+tKlAZ4Pj1felaTUduLv4oriQCyj8ZRz7s0dnj97wm2qQdXo1BUbaVnfm
         eHKA==
X-Gm-Message-State: AAQBX9e8X9HrTW7MBZyTXT7hks4X43vJBT37CbycJ6h3cN3vnE5FxlZb
	smhBx1K2VS5085kxblorT7Ucw8RBpx4Ifg==
X-Google-Smtp-Source: AKy350YgKihs8rhvxa0oa5B4j52cY44ziK2oXqeczBRmHOpPRXkaxrBD9345SDem4tTrN/bf6BURTA==
X-Received: by 2002:a17:903:2344:b0:1a1:b65c:dea7 with SMTP id c4-20020a170903234400b001a1b65cdea7mr16791521plh.47.1681164106666;
        Mon, 10 Apr 2023 15:01:46 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001a2806ae2f7sm8263372plr.83.2023.04.10.15.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:01:46 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 9/9] auto-t: update testFT-8021x-roam with SHA384 test
Date: Mon, 10 Apr 2023 15:01:35 -0700
Message-Id: <20230410220135.373872-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230410220135.373872-1-prestwoj@gmail.com>
References: <20230410220135.373872-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testFT-8021x-roam/connection_test.py | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/autotests/testFT-8021x-roam/connection_test.py b/autotests/testFT-8021x-roam/connection_test.py
index 356a9af2..2a4fe9e1 100644
--- a/autotests/testFT-8021x-roam/connection_test.py
+++ b/autotests/testFT-8021x-roam/connection_test.py
@@ -10,7 +10,7 @@ from hostapd import HostapdCLI
 import testutil
 
 class Test(unittest.TestCase):
-    def test_roam_success(self):
+    def validate(self):
         wd = IWD(True)
 
         device = wd.list_devices(1)[0]
@@ -50,6 +50,22 @@ class Test(unittest.TestCase):
         self.assertRaises(Exception, testutil.test_ifaces_connected,
                           (self.bss_hostapd[0].ifname, device.name, True, True))
 
+    def test_ft_8021x_sha256(self):
+        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-EAP')
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-EAP')
+        self.bss_hostapd[1].reload()
+
+        self.validate()
+
+    def test_ft_8021x_sha3846(self):
+        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-EAP-SHA384')
+        self.bss_hostapd[0].reload()
+        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-EAP-SHA384')
+        self.bss_hostapd[1].reload()
+
+        self.validate()
+
     def tearDown(self):
         os.system('ip link set "' + self.bss_hostapd[0].ifname + '" down')
         os.system('ip link set "' + self.bss_hostapd[1].ifname + '" down')
-- 
2.25.1

