Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9DF39C
	for <iwd@lists.linux.dev>; Thu,  8 Sep 2022 22:33:11 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so3648810pja.5
        for <iwd@lists.linux.dev>; Thu, 08 Sep 2022 15:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Ss8uPTtO12c86isVwc0Me0iUKRBckjutuzWpQta6A5g=;
        b=HyMQlhDT54bG8596CdUM+U8Jj0fiqbIXasJxriC47Ho09Gl8ro51uu+zl5aml54B/A
         l+tTjCtzva5cuMbc6iD5+SZZiyQexJ3qDCpVtONPmV+kFGRpqZSbd8QSV+E8rvsP9WPN
         Vb1G5KDosHbHef1vnYCK33jyOKONmQqUFzSnEfd4Gl035LAiS/JJJjf/eZtFZua3m/9E
         yUuo8TjcoX8/jTjc7EQ9414tGibqARQdMCHH/TB4cYpanB1SQUYQfvhTtTzRPzEvIS4J
         +APVXhd4H9tx4NJwcZUp4uFMLqmDEortU1iTCqEQC4PnNTZXVQ2TjRrzFIYTUrskhqEa
         yumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Ss8uPTtO12c86isVwc0Me0iUKRBckjutuzWpQta6A5g=;
        b=HeZ205sZYepBZnM8ikPqu5WPJQSv2yk/KVjMFSmnRVUsq70GY5bSjJNIg0ipkvEn9e
         fYvVRpHNzoMzThrKecWhTrLNE51mo4iWJrkP5PltsrRw1Xkxthef2h/Un6kwEsWy4eUl
         LJZF15//K4hTQesZFPZKUisFG4PHcrMV/i/HMHW/pHCEXcRH+10gyHOdje0aveaVQiaU
         TeyTLUW/G+QUzXmJBpfskwq8cSn6NvZq1yVP6H6ZgP48zx/yfdMwFGhbFvLRhcAKEFLt
         CQKikQSunJHsqBrojc7uInCZObxNb/bRhy7gAU4BL7xDu2Mudy/6QOIGrLbJ4TGjK+Gt
         SB/Q==
X-Gm-Message-State: ACgBeo3UHrgeGXZtFkWjHgX3zMl0G1r4ARpzBo4Y5cID06Jbq1d5WvyM
	cgo94o9+jHLam2445yQHykfo2hrbISA=
X-Google-Smtp-Source: AA6agR4BF03wUnXo+Yr26JuYa2wPm4wil4PWaFTJQgZbTRn3UUHbPN1OImxw5De6M4D4/OB9XbOKsw==
X-Received: by 2002:a17:90b:3848:b0:202:5d6d:37a5 with SMTP id nl8-20020a17090b384800b002025d6d37a5mr6492608pjb.115.1662676390317;
        Thu, 08 Sep 2022 15:33:10 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id p62-20020a622941000000b0053e7d2b2c74sm128749pfp.95.2022.09.08.15.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 15:33:09 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] auto-t: add more checks to testRRM
Date: Thu,  8 Sep 2022 15:33:07 -0700
Message-Id: <20220908223308.439085-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hostapd events for RRM come regardless of success
so they need to be checked as such. In addition one more
RRM request was added to scan on a frequency which is
disabled (operating class 82, channel 14).
---
 autotests/testRRM/connection_test.py | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/autotests/testRRM/connection_test.py b/autotests/testRRM/connection_test.py
index 4d894958..508d7119 100644
--- a/autotests/testRRM/connection_test.py
+++ b/autotests/testRRM/connection_test.py
@@ -21,6 +21,8 @@ beacon_passive = '510b0000000000ffffffffffff020100'
 beacon_active = '510b0000000001ffffffffffff020100'
 # Passive beacon with duration set
 beacon_passive_duration = '510b0000c80000ffffffffffff020100'
+# Passive beacon on disabled frequency (disallowed in US)
+beacon_passive_disabled = '520e0000c80000ffffffffffff020100'
 
 class Test(unittest.TestCase):
 
@@ -57,13 +59,15 @@ class Test(unittest.TestCase):
         hapd.req_beacon(device.address, basic_beacon)
 
         for e in ['BEACON-RESP-RX', 'BEACON-RESP-RX']:
-            hapd.wait_for_event(e)
+            event = hapd.wait_for_event(e).split(' ')
+            self.assertTrue(event[3] == '00')
 
         wd.wait(1)
 
         # This should return just ssidRRM
         hapd.req_beacon(device.address, beacon_with_ssid)
-        hapd.wait_for_event('BEACON-RESP-RX')
+        event = hapd.wait_for_event('BEACON-RESP-RX').split(' ')
+        self.assertTrue(event[3] == '00')
 
         wd.wait(1)
 
@@ -71,7 +75,8 @@ class Test(unittest.TestCase):
         hapd.req_beacon(device.address, beacon_passive)
         # TODO: See if we are scanning here (scan not initiated from station)
 
-        hapd.wait_for_event('BEACON-RESP-RX')
+        event = hapd.wait_for_event('BEACON-RESP-RX').split(' ')
+        self.assertTrue(event[3] == '00')
 
         wd.wait(1)
 
@@ -79,7 +84,8 @@ class Test(unittest.TestCase):
         hapd.req_beacon(device.address, beacon_active)
         # TODO: See if we are scanning here (scan not initiated from station)
 
-        hapd.wait_for_event('BEACON-RESP-RX')
+        event = hapd.wait_for_event('BEACON-RESP-RX').split(' ')
+        self.assertTrue(event[3] == '00')
 
         wd.wait(1)
 
@@ -87,7 +93,15 @@ class Test(unittest.TestCase):
         hapd.req_beacon(device.address, beacon_passive_duration)
         # TODO: See if we are scanning here (scan not initiated from station)
 
-        hapd.wait_for_event('BEACON-RESP-RX')
+        event = hapd.wait_for_event('BEACON-RESP-RX').split(' ')
+        self.assertTrue(event[3] == '00')
+
+        wd.wait(1)
+
+        hapd.req_beacon(device.address, beacon_passive_disabled)
+
+        event = hapd.wait_for_event('BEACON-RESP-RX').split(' ')
+        self.assertTrue(event[3] != '00')
 
         device.disconnect()
 
-- 
2.34.3

