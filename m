Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17BD73501
	for <iwd@lists.linux.dev>; Wed, 28 Feb 2024 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709124025; cv=none; b=bI5obTO78Zyi2VX5UwaKykc1Jh9vGxxjahlPvWBD9aVVrEmAdhpJ4TsuWNQPOfpOSpYjGXTHYqODe/cOocXDlc0u26HHcroQA1CST7c0W9nNbKllL8VXwBe3HGd2WTksQFdej4mh85M+pOKeOR+byUWALohuHclvdggUYGxCQuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709124025; c=relaxed/simple;
	bh=ypTRP8gTpueuVrlSjauMUnq3CPzcwAE0lYkjqAhGydE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BXfEzTx+kQBPhL6QDcZC64sUCdewIj+A+5/nmLB30iznhVQq+JuV1D7t/ND3kIqYbq4LKbgJv+TpueLxW4xY65rp0/6KsbXXzNSdOW0UziWoJS0ECcS0u0iLVOekPpq8cmTPJ2dsyjzAZToh3uRKekQLocQ7ZWTHp+Fbcyo+e6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgU0BqW4; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgU0BqW4"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-787c900af02so63671885a.1
        for <iwd@lists.linux.dev>; Wed, 28 Feb 2024 04:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709124022; x=1709728822; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d4WwcXiEXMb4/emcfeqW0euFLUsyLDDQMKBKRirc2PM=;
        b=kgU0BqW4zGKZfu4jW79K3K8FI8ziQlqLe0ZIS7OZFRwWEwrmmNRaC+BnLCt4WaH08v
         A51/aibCGcvPh+OJPgxoLHBPW2s+zQZXnhe7MytEIyMTV46m/PXk05DivHbXzWn0r6aK
         aFjlnBUly3vWlYVp7H8LYAyypZxsvu2SK/WzaWsKrCiU538bNGv09f0UDTXnpsJpCjgJ
         aESQozctRClacRzR5y0pcmlo/fWUyOij1lieeSJiqD0/GXpQRjSCc9zRv5FgJ4e8FvQM
         yTyfy6Jo0klwjtn7LMC0fJ48uikmlCttaOnGA3BFMRGkHqXIf10mnAyXINtZ44mkTOLe
         xeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709124022; x=1709728822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4WwcXiEXMb4/emcfeqW0euFLUsyLDDQMKBKRirc2PM=;
        b=lyrzr/RUjM8SWdPQJQJBu82XWPx+/7wufrYJhYKbYb4oXLVLaRHc4RMOmxe8eldxu8
         /No8F3FxeCzA1akw7q5LnXv5Bc1RUn7e2DJH8zbkkYf5dryOg7FytfdCxs7jrEqwi2s2
         //sfRXxS2Co3WRLs30himXKqjWFfcJoPESy3+jfl2Z7cQWOVOgcGXU3Z+M5+wuk2Wg/r
         fWebQQX0Tune25OWiOcnFEH3G0BgIBGqBJu8UuCyukO4H4TZpAZAGeGNHR/fk3WF26xA
         4BZ4n27c7h1m9FPyPdkQco5clmlz2rbyr3s7EZkxBUqaJxD7sM53UTWuVmbytenKQIfu
         FsAw==
X-Gm-Message-State: AOJu0YynzKkQjGIM+5FqHP7oF8o5xjPR/MHHT0qFxnOk7kY2kerrdo4O
	0NBW/bV3SWx8slZ6TW0hkiIW7fT+5vj/uuTU0D6eryGbpuE00VQ8uhfAJjW6
X-Google-Smtp-Source: AGHT+IEhuXZlN+9ryLi6h6jFAjzJh4No4pcsC8b6s8edKzG8/LKotkw5JrA53p7lysBomkY++H7b4g==
X-Received: by 2002:a05:620a:44d6:b0:787:ee7c:569a with SMTP id y22-20020a05620a44d600b00787ee7c569amr3583290qkp.16.1709124022429;
        Wed, 28 Feb 2024 04:40:22 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id f15-20020a05620a15af00b007874c78435bsm4532218qkk.112.2024.02.28.04.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:40:22 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] RFC: auto-t: fix netconfig to handle resolvconf values out of order
Date: Wed, 28 Feb 2024 04:40:18 -0800
Message-Id: <20240228124018.334892-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The slaac_test was one that would occationally fail, but very rarely,
due to the resolvconf log values appearing in an unexpected order.

This appears to be related to a typo in netconfig-commit which would
not set netconfig-domains and instead set dns_list. This was fixed
with a pending patch:

https://lore.kernel.org/iwd/20240227204242.1509980-1-denkenz@gmail.com/T/#u

But applying this now leads to testNetconfig failing slaac_test
100% of the time.

I'm not familiar enough with resolveconf to know if this test change
is ok, but based on the test behavior the expected log and disk logs
are the same, just in the incorrect order. I'm not sure if this the
log order is deterministic so instead the check now iterates the
expected log and verifies each value appears once in the resolvconf
log.

Here is an example of the expected vs disk logs after running the
test:

Expected:

-a wlan1.dns
nameserver 192.168.1.2
nameserver 3ffe:501:ffff:100::10
nameserver 3ffe:501:ffff:100::50
-a wlan1.domain
search test1
search test2

Resolvconf log:

-a wlan1.domain
search test1
search test2
-a wlan1.dns
nameserver 192.168.1.2
nameserver 3ffe:501:ffff:100::10
nameserver 3ffe:501:ffff:100::50
---
 autotests/testNetconfig/slaac_test.py | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/autotests/testNetconfig/slaac_test.py b/autotests/testNetconfig/slaac_test.py
index 26ae0e46..5aeb730e 100644
--- a/autotests/testNetconfig/slaac_test.py
+++ b/autotests/testNetconfig/slaac_test.py
@@ -81,14 +81,21 @@ class Test(unittest.TestCase):
         self.assertEqual(expected_routes6, set(testutil.get_routes6(ifname)))
 
         rclog = open('/tmp/resolvconf.log', 'r')
-        entries = rclog.readlines()
+        entries = [l.strip() for l in rclog.readlines()[-7:]]
         rclog.close()
-        expected_rclog = ['-a %s.dns\n' % (ifname,), 'nameserver 192.168.1.2\n',
-                'nameserver 3ffe:501:ffff:100::10\n', 'nameserver 3ffe:501:ffff:100::50\n',
-                '-a %s.domain\n' % (ifname,), 'search test1\n', 'search test2\n']
-        # Every resolvconf -a run overwrites the previous settings.  Check the last seven lines
-        # of our log since we care about the end result here.
-        self.assertEqual(expected_rclog, entries[-7:])
+        expected_rclog = [
+            '-a %s.dns' % (ifname,),
+            'nameserver 192.168.1.2',
+            'nameserver 3ffe:501:ffff:100::10',
+            'nameserver 3ffe:501:ffff:100::50',
+            '-a %s.domain' % (ifname,),
+            'search test1',
+            'search test2'
+        ]
+
+        for line in expected_rclog:
+            self.assertIn(line, entries)
+            expected_rclog.remove(line)
 
         device.disconnect()
         condition = 'not obj.connected'
-- 
2.34.1

