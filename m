Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DC82943C
	for <iwd@lists.linux.dev>; Mon, 13 May 2024 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715623252; cv=none; b=R+P/9N4heBnu74d1TGMraMHgjCPzUaWwdIRnzQzSsU6FRxVaEukyfvj5C42XIpUfnbIinqpFRJuw3IwUT7uPP5w3XdcFzxPkwDKQLBK7SMetuMoMZKcN/GvtOLyHgmzI6N4oJu9xKKwT/MaW26JsjPEEC0zCBL0H+DPOq/FyJP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715623252; c=relaxed/simple;
	bh=Ewuy0Wcev3lyoyxQwNdHLbhw+LeMtSPElpSYBESyFFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kewjqUyUGlZPtSu0hA6Al5QzN2ClCW3rBsWkutPxp1WPKR51WqScEQM/smZRdj0Nu91aZloWShhHCYouZYcXIw6hFZ2vU76eetNVJmFom+zkzPksSN0DhV7Wrghuyua0gUtbto5NqpbAI86bDPlbhJuR/MAV7ir47gExFhphObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPrpKZS6; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPrpKZS6"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b277993a48so2682784eaf.1
        for <iwd@lists.linux.dev>; Mon, 13 May 2024 11:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715623250; x=1716228050; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvuWI6sqPVihnirRlEtyFP27P6IeDVRAKOxVUGXaxP4=;
        b=VPrpKZS6Prb2kgK/PwwaC3lDUfOHm3kUgIc+kdWp7dSm15+ERnc61dQw7PeFiNuEWa
         N4D/jUKZVsXfUXKO0IxCT8dAnP4P3g/FYJHaPHmvC3B2Vo0Oh4XYgQL7uPDQppPuEvHY
         aleJFLFwWYA+SLlTbITvrIaOPKDJkEyQKdmq749hts2NHVGNO9jUKHLl/8Xw3aKc7tfr
         NWqqLP2jd6A7EV/TYWwCFGG5G8SQiYAXjdP7zFd5PX449n2O4B/Pjbc3ZAXZJAn8HXmS
         zH8VRZaTi42C55PdPBlYWqO3kKHbERCBJRnHsr252RJPOjPISwO0Ds4ps5ILIq80FEUM
         s2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715623250; x=1716228050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvuWI6sqPVihnirRlEtyFP27P6IeDVRAKOxVUGXaxP4=;
        b=uncd4IlDnWHEcSVwX19Co3WT+OI5tK8Yv+9S3eVBQFpvubgx3lJlB4JnIh43yz+VZ4
         6F4Y6gWpOoMDBxTg1oQ1ej9jQZWcQqe5yjzEFRbJTmvads+j7dGrqrRzBhQ0bsn8Wkak
         KyjCgch2t93vTRrVc+i/38S2pODe4RBOnZElRXammohSMK6msFRAXLntM7l8+0GWoCWK
         HQyriXjqSKBeXUpXzx+4qIaCdOhKoIUq53W0Wat33If7LZnwkdcnwbWkSkjTWJgCgGdH
         /KvKNIY83bgMDAzv/gna5l2KQpVVBWYaS5w++MPMgLY7CzF9Ep+8dEzeeQHUH7AX9VPs
         xn1A==
X-Gm-Message-State: AOJu0YwXvh5Mmoza+yUcYIEqtpERvqqt47wPH+ajVkqYtbp1hPevCWPp
	V8XSfvv8dm8z47vsD02PKZUo5gFRqjwel3FLtMyPBFjwXUT8F/i+dbJa+A==
X-Google-Smtp-Source: AGHT+IFqxIHXTh9MkVDhKAU3864xp1d3H9E9T6Xzk7EvWcuTo4CqItIOYHtNtox+sUMQLQN6NCkNPg==
X-Received: by 2002:a05:6871:878a:b0:22e:7040:3e00 with SMTP id 586e51a60fabf-24172a23576mr13483712fac.8.1715623249845;
        Mon, 13 May 2024 11:00:49 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2a4b38sm479404385a.66.2024.05.13.11.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:00:49 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] auto-t: remove default group SAE test for specific OUI
Date: Mon, 13 May 2024 11:00:42 -0700
Message-Id: <20240513180042.257401-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513180042.257401-1-prestwoj@gmail.com>
References: <20240513180042.257401-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are already tests for UseDefaultEccGroup and this test is
not longer valid as the static OUI list has been removed.
---
 autotests/testSAE/connection_test.py         |  7 -------
 autotests/testSAE/hw.conf                    |  3 +--
 autotests/testSAE/ssidSAE-default-group.conf | 12 ------------
 3 files changed, 1 insertion(+), 21 deletions(-)
 delete mode 100644 autotests/testSAE/ssidSAE-default-group.conf

diff --git a/autotests/testSAE/connection_test.py b/autotests/testSAE/connection_test.py
index f7776385..107daa55 100644
--- a/autotests/testSAE/connection_test.py
+++ b/autotests/testSAE/connection_test.py
@@ -52,12 +52,6 @@ class Test(unittest.TestCase):
         self.hostapd.wait_for_event("AP-ENABLED")
         self.validate_connection(self.wd, "ssidSAE", self.hostapd, 19)
 
-    def test_SAE_force_group_19(self):
-        # Vendor data from APs which require group 19 be used first
-        self.hostapd.reload()
-        self.hostapd.wait_for_event("AP-ENABLED")
-        self.validate_connection(self.wd, "ssidSAE-default-group", self.hostapd_defgroup, 19)
-
     def test_SAE_Group20(self):
         self.hostapd.set_value('sae_groups', '20')
         self.hostapd.reload()
@@ -88,7 +82,6 @@ class Test(unittest.TestCase):
     def setUpClass(cls):
         cls.hostapd = HostapdCLI(config='ssidSAE.conf')
         cls.hostapd_h2e = HostapdCLI(config='ssidSAE-H2E.conf')
-        cls.hostapd_defgroup = HostapdCLI(config='ssidSAE-default-group.conf')
 
     @classmethod
     def tearDownClass(cls):
diff --git a/autotests/testSAE/hw.conf b/autotests/testSAE/hw.conf
index 127bbb31..cc0836b7 100644
--- a/autotests/testSAE/hw.conf
+++ b/autotests/testSAE/hw.conf
@@ -1,9 +1,8 @@
 [SETUP]
-num_radios=4
+num_radios=3
 start_iwd=0
 hwsim_medium=yes
 
 [HOSTAPD]
 rad0=ssidSAE.conf
 rad1=ssidSAE-H2E.conf
-rad2=ssidSAE-default-group.conf
diff --git a/autotests/testSAE/ssidSAE-default-group.conf b/autotests/testSAE/ssidSAE-default-group.conf
deleted file mode 100644
index 752e9c7b..00000000
--- a/autotests/testSAE/ssidSAE-default-group.conf
+++ /dev/null
@@ -1,12 +0,0 @@
-hw_mode=g
-channel=1
-ssid=ssidSAE-default-group
-
-wpa=2
-wpa_key_mgmt=SAE
-wpa_pairwise=CCMP
-sae_password=secret123
-sae_groups=19
-ieee80211w=2
-sae_pwe=0
-vendor_elements=dd0cf4f5e8050500000000000000
-- 
2.34.1

