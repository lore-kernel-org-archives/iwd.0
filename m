Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADAF7470
	for <iwd@lists.linux.dev>; Thu, 30 Jun 2022 18:06:04 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id c6-20020a17090abf0600b001eee794a478so3952819pjs.1
        for <iwd@lists.linux.dev>; Thu, 30 Jun 2022 11:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ifmvu/3OAmxrsLKCRk1xJt8prGQIkSPVeh0DwVekLyc=;
        b=eJzXdK1XvmxlEikFib2j4vTPSa5e/sXyCLlOiKpd3xb9CjoN9nQ7UyTi/U6lFoiTLu
         U8Pf9U7HtlJN/S8q1RrQOfYIn2vebQKKpqlxwQpnhQcx2wrTQcKJ/TysIIKU7YY3YTUi
         zHBPXxMZ1ZK5496Xk5szxn6o1Srl6+30CM6aYIqZy/Vt7wg/TjuYgNjS4QtuEvEMUE+W
         nogsvn57i6Yi4XFjQc5VKFKgAOmGSKgJWN48y4rK51a5Sgk3B35p5LQgO6MUpDNpuhRo
         OGd/QzDzYeERnHN+NzCSWaYWpzh2Bg26Y6EkuZIRw3MgFxlj7H6fSr0oKzZe4EDGsE5V
         ANGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ifmvu/3OAmxrsLKCRk1xJt8prGQIkSPVeh0DwVekLyc=;
        b=efqI2TpBsbidR+98mkvBvrKpGkUyuxCio18jWWyIhQPZh2aqPAq9iq9UyPJytrpU1+
         kcs34/9b5puv+8OnJgPjGhGc1ZJW+kMo9cyYaUOGNyxXWSnSCIAPxZOn9MVpwc5k9TV6
         ZxJV0STRHqRs5+b+1v9/7vtAIZIFds5cHa83TD7/LAOuYO7IR7Nv667rLkloeqYiu6c5
         fEG8GV5mN77ZfI6OK+nnM1ODE/4ubyELjwyGgaPmrBMeW9qSkAbOUVyWlLw2k6C/K0VT
         g9P1muA0BNPO64zzZI8IkeEGeEOXYw7gPxfvz/nbUkhnZuFASYzfTqDj7S3Q6QJI6pNa
         bLUA==
X-Gm-Message-State: AJIora++AAf3yffComnvaV11toLJvdujsG5SkDBWC6hjtxElTN6VkV+c
	kErsmqW2Whl/sdKpPgR4JmLhYCErcME=
X-Google-Smtp-Source: AGRyM1vpeEXTw0vg+xlTWtYL5x7qLohsl+0seWxSrKyiXEYeNB+7QqBSM7YIgm8LnkDpRe29Jz6pxw==
X-Received: by 2002:a17:90a:fd13:b0:1ec:7a40:3b5 with SMTP id cv19-20020a17090afd1300b001ec7a4003b5mr13443985pjb.8.1656612363814;
        Thu, 30 Jun 2022 11:06:03 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b00163ffe73300sm13777187plk.137.2022.06.30.11.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:06:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/7] auto-t: add client test to testDPP
Date: Thu, 30 Jun 2022 11:03:29 -0700
Message-Id: <20220630180331.206419-5-prestwoj@gmail.com>
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

Tests iwctl functionality with dpp commands
---
 autotests/testDPP/connection_test.py | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/autotests/testDPP/connection_test.py b/autotests/testDPP/connection_test.py
index 0f9b8f1c..0cab5ff1 100644
--- a/autotests/testDPP/connection_test.py
+++ b/autotests/testDPP/connection_test.py
@@ -5,9 +5,11 @@ import sys
 
 sys.path.append('../util')
 from iwd import IWD
+from iwd import DeviceProvisioning
 from wpas import Wpas
 from hostapd import HostapdCLI
 from hwsim import Hwsim
+from config import ctx
 
 class Test(unittest.TestCase):
     def test_iwd_as_enrollee(self):
@@ -98,6 +100,38 @@ class Test(unittest.TestCase):
 
         self.wpas.wait_for_event('DPP-CONF-RECEIVED', timeout=30)
 
+    def test_client_as_configurator(self):
+        self.hapd.reload()
+        self.hapd.wait_for_event('AP-ENABLED')
+
+        IWD.copy_to_storage('ssidCCMP.psk')
+        self.device.autoconnect = True
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device, condition)
+
+        ctx.start_process(['iwctl', 'dpp', self.device.name, 'start-configurator'], check=True)
+
+        dpp = DeviceProvisioning(self.device.device_path)
+
+        self.wpas.dpp_enrollee_start(dpp.uri)
+
+        self.wpas.wait_for_event('DPP-CONF-RECEIVED', timeout=30)
+
+    def test_client_as_enrollee(self):
+        self.device.autoconnect = True
+        self.hapd.reload()
+
+        ctx.start_process(['iwctl', 'dpp', self.device.name, 'start-enrollee'], check=True)
+
+        dpp = DeviceProvisioning(self.device.device_path)
+
+        self.wpas.dpp_configurator_create(dpp.uri)
+        self.wpas.dpp_configurator_start('ssidCCMP', 'secret123')
+
+        condition = 'obj.state == DeviceState.connected'
+        self.wd.wait_for_object_condition(self.device, condition)
+
     def setUp(self):
         self.wpas = Wpas('wpas.conf')
         self.wd = IWD(True)
-- 
2.34.1

