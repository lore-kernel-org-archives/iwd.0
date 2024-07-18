Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0F12FB0A
	for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303133; cv=none; b=epZWOIb3xWUQzcTsbgHkpnMGDvtTnQ6iR3t0Lh0gsWxhXoX7toEDD+jBUaIEqhxXThePdwQIZVoxe6q0dXKB9yrR/UVY2ibdOpZC6nZW3saVr1Qpf87K67bQ9/D+lEtMC1aiX8uM63HPSAaqDYgxUXbmXuTDXWWTVW+HFR00wsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303133; c=relaxed/simple;
	bh=/+Z1Y+SO9AcLbBX5Oaez6kGYH77bKDDld+2HFzNqhgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SBuW3WqGwhaTjhd3QVrm0htEpMp8h3wYmIzXQeNobe0+L5kb3kFvdLIoLA6QsCRSFP5hNUCnu18/7HjzRw0I5Si/N0NGyoSStka/+D0YI7o8OSHFLt/EuzupMcFdFODdgzQd79FWcGEQm+AMA9Dc8QouY5i9/2BVmqzA4bkMJq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJ+6iiw7; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ+6iiw7"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-79f15e7c89cso13829485a.1
        for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 04:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721303130; x=1721907930; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z555IW3K2UwJGIL0eaEBLlblD8EVnzQMK8WBPMH9mEs=;
        b=KJ+6iiw71jy0vdV1HdcyI8FawYFKQLEA1+es+I8GhSry3uMFQ+uGHO+oxXAo/Q9CYV
         3IhcUhr53uHhuDXSv11fxxWDYPibjVOgxBkUGdVd4SqmrA0t6fVnr8YLoimE1AYrotvE
         V7FlhcimNZ3ipDyAbKTwN3Y/mNo+Iai5LBxbn0QS3EVT4D6UqFIlWD3giuypRUhfgvVV
         +YuiTwrg/Z9LWVGI5IbzCalYJs2WamXqXu9/Kx6MXscyfDU5m60xz2NhviBQKkZ8oguR
         HaPNy+o0Kx8yg9WizgME4TUAOdYA/m6yQgHh7THQr2PRPpBMGVCKBpeCldH0xwW094Jo
         Qxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721303130; x=1721907930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z555IW3K2UwJGIL0eaEBLlblD8EVnzQMK8WBPMH9mEs=;
        b=EgsqU/2OaCvTCl7m/EMjqTFMK0fzzJaUmxj7B5z+yGEb7W2F2a4KF7t+4mragJlKva
         Q9nlc9uWmWhQ/uLzFNKosAmbTYkf6cLcNmillmqHAzlAn1TUAyrtRv3nVV5e8IGlzk90
         1y5XX21wu6Ys7AxDy518Wzlp2QsiABo1c+5LJtpVGHkqE1cJOcSHtUCGDz2WkQOqxHft
         Zip1NlexwiRQO6n8NURVCVCWbfiCrsFXa4VMs5/gsutmkaP8DHhYyjodHCeSITURUD5Z
         FsKDAXMb5023ROjzM40xzR/TAu+iDghTWvB4z2wlOUssF4LDtqn/fpK6csEvmpqrkUKm
         BltQ==
X-Gm-Message-State: AOJu0Yx5Bj8RfkReorVxq2YpsEXJbQhs31zl8huwggCA89KziKATtMVp
	X9NVCczxK8ugU2obqCnnbdK1rrFS267tnLfL3BhQkApbgpu19910zD0FkQ==
X-Google-Smtp-Source: AGHT+IG7xxov325wEJKg/+uqg03RPdNozP9SiCeyOwcibSzbLhTwFApe1g3fFIUhEJbrg6+834rCwg==
X-Received: by 2002:a05:6214:b65:b0:6b5:79:ff08 with SMTP id 6a1803df08f44-6b79c505428mr36186076d6.6.1721303130673;
        Thu, 18 Jul 2024 04:45:30 -0700 (PDT)
Received: from LOCLAP699.localdomain ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c5138bbsm7292006d6.61.2024.07.18.04.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:45:30 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 11/11] auto-t: a few random autotest fixes
Date: Thu, 18 Jul 2024 04:45:14 -0700
Message-Id: <20240718114514.2916258-12-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718114514.2916258-1-prestwoj@gmail.com>
References: <20240718114514.2916258-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

testEncryptedProfiles:
 - This would occationally fail because the test is expecting
   to explicitly connect but after the first failed connection
   autoconnect takes over and its a race to connect.
testPSK-roam:
 - Several rules were not being cleaned up which could cause
   tests afterwards to fail
 - The AP roam test started failing randomly because of the SNR
   ranking changes. It appears that with hwsim _sometimes_ the
   SNR is able to be determined which can effect the ranking. This
   test assumed the two BSS's would be the same ranking but the
   SNR sometimes causes this to not be true.
---
 autotests/testEncryptedProfiles/ssidCCMP.psk      |  3 +++
 autotests/testPSK-roam/failed_roam_test.py        |  3 +++
 autotests/testPSK-roam/roam_ap_disconnect_test.py | 12 +++++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/autotests/testEncryptedProfiles/ssidCCMP.psk b/autotests/testEncryptedProfiles/ssidCCMP.psk
index abafdb66..a82ae05d 100644
--- a/autotests/testEncryptedProfiles/ssidCCMP.psk
+++ b/autotests/testEncryptedProfiles/ssidCCMP.psk
@@ -1,2 +1,5 @@
 [Security]
 Passphrase=secret123
+
+[General]
+AutoConnect=false
diff --git a/autotests/testPSK-roam/failed_roam_test.py b/autotests/testPSK-roam/failed_roam_test.py
index 60bcf366..e0b2f955 100644
--- a/autotests/testPSK-roam/failed_roam_test.py
+++ b/autotests/testPSK-roam/failed_roam_test.py
@@ -247,6 +247,9 @@ class Test(unittest.TestCase):
         cls.rule2.remove()
         cls.rule3.remove()
         cls.assoc_rule.remove()
+        cls.rule_bss0.remove()
+        cls.rule_bss1.remove()
+        cls.rule_bss2.remove()
 
 if __name__ == '__main__':
     unittest.main(exit=True)
diff --git a/autotests/testPSK-roam/roam_ap_disconnect_test.py b/autotests/testPSK-roam/roam_ap_disconnect_test.py
index 76c62ea0..9c660016 100644
--- a/autotests/testPSK-roam/roam_ap_disconnect_test.py
+++ b/autotests/testPSK-roam/roam_ap_disconnect_test.py
@@ -81,12 +81,21 @@ class Test(unittest.TestCase):
         cls.bss_hostapd[0].set_value('ocv', '0')
         cls.bss_hostapd[0].set_value('ieee80211w', '0')
 
+        rad0 = hwsim.get_radio('rad0')
+        rad1 = hwsim.get_radio('rad1')
+
         cls.rule0 = hwsim.rules.create()
-        cls.rule0.source = 'any'
+        cls.rule0.source = rad0.addresses[0]
         cls.rule0.bidirectional = True
         cls.rule0.signal = -8000
         cls.rule0.enabled = True
 
+        cls.rule1 = hwsim.rules.create()
+        cls.rule1.source = rad1.addresses[0]
+        cls.rule1.bidirectional = True
+        cls.rule1.signal = -8500
+        cls.rule1.enabled = True
+
         cls.bss_hostapd[0].set_address('12:00:00:00:00:01')
         cls.bss_hostapd[1].set_address('12:00:00:00:00:02')
 
@@ -95,6 +104,7 @@ class Test(unittest.TestCase):
         IWD.clear_storage()
         cls.bss_hostapd = None
         cls.rule0.remove()
+        cls.rule1.remove()
 
 if __name__ == '__main__':
     unittest.main(exit=True)
-- 
2.34.1

