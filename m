Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CFBAD5C
	for <iwd@lists.linux.dev>; Wed, 14 Dec 2022 21:27:03 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so595321pje.5
        for <iwd@lists.linux.dev>; Wed, 14 Dec 2022 13:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJRTddzG2ge1h1VC/cB5BfbGWrda3Uu7V+cJv3fhGZw=;
        b=bsjOx5VhuI7i7Auihrd93X5M9vsAzlBFWRB4lEt2sOoTK6IGdJdyOcOweI9tgVPRp4
         MDGYGojQxMvEdJN9stZJcc4ggGobg+TO7DRHk9klBo/B9SoOWrH3eLN3KJGgD+jMfpC6
         Z4riAeyHfg65s72gfKeTNGlDO/mwzY5eDptTY3N7PBJjQqf58viS6ABd3HSMFpmWw47o
         n2GfPzhJDqIm0Twb7oe1ygV6KL+Rqfjg09v8zNTmCZnU6sfR793R3HB0FWIh0bIRdJzi
         uzy9oOrTgVWTrld6i8acMRBb0vedo48jSpadEK4klRwo1bnuYYwcyfb4b8LzivcseflY
         wNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJRTddzG2ge1h1VC/cB5BfbGWrda3Uu7V+cJv3fhGZw=;
        b=zhcippcaqi2e6osCEgTqdLd8GhJxOXiIkAJOwYn5A7s4nZC8SQmd+DqceSiKzLnpQb
         ZtbFVvKrdD6OHrPKVNNrGg1c5hv1cAa7/YEn+7xSal0+yfOEx6gU3nXGMbMpQZuxfmiM
         QMF9k/5cyKV1/svRk7L/3mZBRFhmf6qC6abZPEJ7Gp0jyFl1lvkxvCjz03NY7VJcO1aE
         AF8tssajptXlhrnEcHUBwl1bTquLrVXub8ZB8gtOTykGvw2+Zm3ZJL2p8sr60HaVlzKo
         hR5+RKZpzrM+YoqteghbWC/Jd4fdmMSpRXT4jXPcbFrB+j6+qWfu8METC/W8S1DLgt11
         eL8w==
X-Gm-Message-State: ANoB5pmBFqKWAwYsAcT0dIvBCpuatQVyGfaJQoGZ8/RUO1hdEFDS23KX
	7BbfGxY6+abHv4DKDUIVPfFWbe2+aJI=
X-Google-Smtp-Source: AA0mqf56c+EFjl0dtVf7zPGUO5PvxXQ9lgJCogAmB0s9+F2Nx+Sh8Sn+oD13y0d5R8kAFbr0PcbwCw==
X-Received: by 2002:a05:6a20:9c8a:b0:a2:d594:6868 with SMTP id mj10-20020a056a209c8a00b000a2d5946868mr35518226pzb.9.1671053223016;
        Wed, 14 Dec 2022 13:27:03 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id a8-20020a656408000000b0047063eb4098sm287653pgv.37.2022.12.14.13.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 13:27:02 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] auto-t: update testPSK-roam with changed FT behavior
Date: Wed, 14 Dec 2022 13:26:58 -0800
Message-Id: <20221214212658.1578576-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221214212658.1578576-1-prestwoj@gmail.com>
References: <20221214212658.1578576-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testPSK-roam/failed_roam_test.py | 38 +---------------------
 1 file changed, 1 insertion(+), 37 deletions(-)

diff --git a/autotests/testPSK-roam/failed_roam_test.py b/autotests/testPSK-roam/failed_roam_test.py
index cac2ff4d..360c1de5 100644
--- a/autotests/testPSK-roam/failed_roam_test.py
+++ b/autotests/testPSK-roam/failed_roam_test.py
@@ -65,7 +65,7 @@ class Test(unittest.TestCase):
         device.roam(self.bss_hostapd[1].bssid)
 
         # Roam should fail...
-        device.wait_for_event('ft-over-air-roam-failed')
+        device.wait_for_event('ft-roam-failed')
         # ... but IWD should remain connected
         self.assertTrue(device.state == DeviceState.connected)
 
@@ -80,42 +80,6 @@ class Test(unittest.TestCase):
         condition = 'obj.state == DeviceState.disconnected'
         wd.wait_for_object_condition(device, condition)
 
-    # Network sets over-DS bit, but fails to authenticate. IWD should still be
-    # able to roam using FT-over-Air.
-    def test_fallback_to_over_air(self):
-        self.bss_hostapd[0].set_value('wpa_key_mgmt', 'FT-PSK')
-        self.bss_hostapd[0].set_value('ft_over_ds', '1')
-        self.bss_hostapd[0].reload()
-        self.bss_hostapd[0].wait_for_event("AP-ENABLED")
-
-        self.bss_hostapd[1].set_value('wpa_key_mgmt', 'FT-PSK')
-        self.bss_hostapd[1].set_value('ft_over_ds', '1')
-        self.bss_hostapd[1].reload()
-        self.bss_hostapd[1].wait_for_event("AP-ENABLED")
-
-        wd = IWD(True)
-
-        device = wd.list_devices(1)[0]
-
-        # Drop action frames, this will prevent FT-over-DS authentication
-        self.rule1.enabled = True
-
-        self.connect(wd, device, self.bss_hostapd[0])
-
-        device.roam(self.bss_hostapd[1].bssid)
-
-        self.rule1.enabled = False
-
-        # FT-over-DS should fail, and over-Air should take over leading to a
-        # successful roam
-        device.wait_for_event('try-ft-over-air')
-
-        self.verify_roam(wd, device, self.bss_hostapd[0], self.bss_hostapd[1])
-
-        self.bss_hostapd[1].deauthenticate(device.address)
-        condition = 'obj.state == DeviceState.disconnected'
-        wd.wait_for_object_condition(device, condition)
-
     def tearDown(self):
         os.system('ip link set "' + self.bss_hostapd[0].ifname + '" down')
         os.system('ip link set "' + self.bss_hostapd[1].ifname + '" down')
-- 
2.34.3

