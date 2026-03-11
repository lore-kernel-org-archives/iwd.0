Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6DD2E11B0
	for <iwd@lists.linux.dev>; Wed, 11 Mar 2026 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248538; cv=none; b=cMW4T4romXNhvi3XW3gg3/4RdIhejJLljRc3YNWBrgr0zZ5ILw9d3S5KivwmbTc2n3x5xqKRh9pQvF/IR4h9yDFvKc5EFcWKiIfzXFJCjDkQNDT3flgZTf3zYpqravxRKwhemsNrYUzrfu/qIPm0yCwyeVUV6wc5KB4ilNOh7z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248538; c=relaxed/simple;
	bh=oi5z34O9i/NgC35yTOVsEqi/AFquwfISi4xRLArQwG8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J6AkpC3itJlaN4C08tM1+B6PHW+qHIk3LkodGqSI08DJ14VMfMnh+gnkuxvcPGW5FLeyB7mxr9igYoUzlO9jr5SOrQqBIGuN2P3AJymTnO67PyOHuF6fMkP955ZrUvLB/FU3qCFHbRwmTHsrLWXBinC8dTPmxC3Oit00uF5Ohe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPU9nHhB; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPU9nHhB"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8297c035d28so56386b3a.0
        for <iwd@lists.linux.dev>; Wed, 11 Mar 2026 10:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773248537; x=1773853337; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WFDxARtku9V4gEk83OhYctH06MuEC+/PTmm4Prb4c04=;
        b=mPU9nHhBi8hlKYm+Kv/vYnXkLmJmJJlM60eCzEv/O/eLUEHXY8IxLZghthODA5CptR
         HZSy1h2W7AgMbBO4xR/1QOv8zUjaZnCZBX+2YDCbaIAHs7qxIehtp1yl/S/gVMTi3h/F
         j12V4jFeI8lVklIwitBXueJKFt9pRfxNID6YB7R1NOmRX552pLduEbUd1lpnrM2Iwggk
         bQXgKv1b278zq7e59r8skL5PuNshT4hNweU+lBx1GXNd/L0qb2crmn6gqyb2x9YCa9zq
         drQ/CObIikKg8EcD7KrraBAwHISdm96tY3JmfjW5UmiaEgm7eKmA1hvxz+6PJNYeXQVm
         otwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773248537; x=1773853337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFDxARtku9V4gEk83OhYctH06MuEC+/PTmm4Prb4c04=;
        b=YtMfbtFkMNz9xqQLdMopiZI9q2GBwkHbpxeqM5W0WGm2srHyCiBS+vx1s0xg6vr9AB
         3wfbH9e1QLunCKE6ohfOK+6euGeNHskwYJjEIr3CBI3UiGcDsUfOAv/Z67UDxvLFMzA+
         eL84ReFblg/BnoNaQBbIGfL0v0mhKzZ6QTDgYt0lGP6U5qbKt0oHpyp9G34Vlf9pwjnL
         vR9/ZygZT5n/oBmcFhhtCJ5WggVqpWsMGiV4b2MdPnsRxWrddmEm5PDiu+Y44ZNifvUJ
         wa+esYKbEFf8+DSlzpBRBe3aa3EmASWGhpRvwCt/2hoeAigu3tFzyMgos7ZxuGTBOgKZ
         i8Zg==
X-Gm-Message-State: AOJu0YyN9VmLupgzeEAxcAUYRgjankH00JTQ7peA9GEhJt02OJja/7rM
	qJmPuu1jPOigFcOl30/5UjekzYXaz6E/FBS0jsps+zVU0EFoqkNcxfYesD97TQ==
X-Gm-Gg: ATEYQzyy5kqkLxfMwfJfAlQ79QTkonkfDYFi6H9dEKG/huD6Ay1RmXCcMaMg2Nz61Sc
	R48saSQ47v6qEwXPWqZG3aRoQEY43HRzIBVMyqZdLRy1LssbW/zygkDC3XV5kUc8t185wgX0Whz
	TiS+2NG25F3k114OwZItFjxdeim3PlVOXEkKK9D6Qcg7PUMG5oulFRCvGO7mq4R5XJxLLTx/861
	SbEC2Ewna/31yZz1g561hsbZ4jn1UL+JXFgmIWHQCHNcIVPCftv8UvZcFs6mBy+ZmAThyLaGX/D
	6ZUG8LPVA7uwXTvw3yUhn40qGhXiDBeFSejN4V7TW2jE4LP1ffWQOgC7K8mDyGbYR+ny4ie9PZI
	5/dSZMt33JvE2DJhX2ay5n6NcVG3gktCjZtdyu55ggbFvP4DSsWV2o58EKRcHwAErQx4GAFNytE
	FrfEGXxdDrhkCwVQLqwxNAFRy8okLapUP02o3yFOirtGBbHi2edUAxeGCCe/WitiO9
X-Received: by 2002:a05:6a00:3405:b0:823:3079:7c7 with SMTP id d2e1a72fcca58-829f6ed6de2mr3097670b3a.29.1773248536826;
        Wed, 11 Mar 2026 10:02:16 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07242ecesm178968b3a.2.2026.03.11.10.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:02:15 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: fix two issues with testAPRoam
Date: Wed, 11 Mar 2026 10:02:10 -0700
Message-Id: <20260311170210.126610-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of the tests expects a roam to a certain BSS, but there's an
extra hostapd instance (use by another test) making it random which
BSS IWD roams to. This hostapd instance has been disabled for this
test.

The second issue was waiting for the no-roam-candidates event. The
default wait is 10 seconds, which can sometimes take longer since
IWD will perform a full scan after a roam scan. Increase this timeout
to 20 seconds to guard against that.
---
 autotests/testAPRoam/connection_test.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/autotests/testAPRoam/connection_test.py b/autotests/testAPRoam/connection_test.py
index 1f95fb96..b55b8455 100644
--- a/autotests/testAPRoam/connection_test.py
+++ b/autotests/testAPRoam/connection_test.py
@@ -40,7 +40,7 @@ class Test(unittest.TestCase):
 
             to_bss.wait_for_event('AP-STA-CONNECTED %s' % self.device.address)
         else:
-            self.device.wait_for_event("no-roam-candidates")
+            self.device.wait_for_event("no-roam-candidates", timeout=20)
 
     def test_disassoc_imminent(self):
         self.initial_connection()
@@ -76,6 +76,8 @@ class Test(unittest.TestCase):
             (cls.bss_hostapd[1].bssid, "8f0000005102060603000000"),
         ]
 
+        cls.bss_hostapd[2].disable()
+
     @classmethod
     def tearDownClass(cls):
         IWD.clear_storage()
-- 
2.34.1

