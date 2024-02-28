Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CBD6EF02
	for <iwd@lists.linux.dev>; Wed, 28 Feb 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138185; cv=none; b=KztgUnfBHrQicMM7BNK6aQa222fWAaoZIBdsWW32Jl9c8zsxUq1TcX3jyko6YRkMsPeqmObXO9p7ciabgXRkq69EGVvcD3ysAFY6j66EHnpuCD73NPb5U7JeuzN7Yq8Pv3SEY8LEF6dJC8DOd+FeK3b3T7y4ojWf96UPCSd9bYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138185; c=relaxed/simple;
	bh=ypTRP8gTpueuVrlSjauMUnq3CPzcwAE0lYkjqAhGydE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XaSvROAtFZpRFZ1lcJES3rYndvkGeOmhFQPEaYLSAqMPiutuV46HWXT0QZ2u6B8VkV7R/03E4Upbee6heppaXappgjamFSypQdzRTP2l2hEnX6aZqwEHYJOU6EGD9BTjvYx1GRN6z8gnm++pzvvJKEzAE7vAx1n5epT6IvT0TU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrWc6lQo; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrWc6lQo"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-787bb0d85eeso354562585a.0
        for <iwd@lists.linux.dev>; Wed, 28 Feb 2024 08:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709138182; x=1709742982; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d4WwcXiEXMb4/emcfeqW0euFLUsyLDDQMKBKRirc2PM=;
        b=LrWc6lQorFQ8S99cdrxp+ZebNjjtI+gYKQa93dKDl97BArAV9ayMYHwHQPEMnvETLv
         GrsJAqUd3jIWMMeklRkRnxUtZzhztPIh6jFe6IuBIky0SEkrWZPyKL6TFG3n5d39+r2A
         pla9cSBrNa+Dtx50hPYQJBa010GCh+JSnzVK6uBhGTM9t5MZuPwPSG8t8sGKdUnvig9N
         q9sF54Xe/AkbpuM7QjDDOSKP8eWvWmDDmJ3z47kAjw1DrbzvVxYWxW00HzP+qSxp1hrc
         Ffg3OeVA6jDXNFt9Zl1Oa+IF201Qq5j0BslMnk2D+ucr+q+fRF94tCGCd7YWFJcUIcb7
         qLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709138182; x=1709742982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4WwcXiEXMb4/emcfeqW0euFLUsyLDDQMKBKRirc2PM=;
        b=YlIR78d7zet5pFnij5Mb5i7tiFNU7+ve4Tr2R0b8xGSpn40revtt8s/qKCXNtHKVKP
         1FN0JadqGmnBTdvG49QGLflYXjHD6m+yNm+NG8ZFGEn9DzwiMP0XTc05uvbMGAlLs7wc
         h7XIJJLp40xOZGtFi+Q+p8gDKQUbhkpg75cbWBZJ+Hq8WVjUEwBVs9vxKuz+pLnFqtaZ
         AV2NMNSSN7boynmbFEb1BY1JKabTay27OdxxsBzEFaset8IrrN0DJetZsYCWd1TKw5jf
         2ZMulDxe4LY3vBw75p3rGNgrrRql2XNeCBEHwnXaqEzp6ypceBTsSFVHtj87udHAzCUp
         ZBfQ==
X-Gm-Message-State: AOJu0YwRIQZntWcR0phQNaxF8xVsUdUf3OcrS0IUhJ+iBM2BlGeUJRbV
	sstvl2k6rEyaP4VhMmF5iPvLeWNt/nKjhc4V1TO3zcDo92HH4WSn5j0YT4D8
X-Google-Smtp-Source: AGHT+IF2JYSlgBZSHMDjTEaQsItgFoC/77ACUGjkpjg86XzDURab2lJZhzRy/ua86V60qdoL2nmEMg==
X-Received: by 2002:a05:620a:5dc5:b0:787:d4d7:6068 with SMTP id xy5-20020a05620a5dc500b00787d4d76068mr5965404qkn.66.1709138181727;
        Wed, 28 Feb 2024 08:36:21 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id ow7-20020a05620a820700b00787b8e49d9fsm4722261qkn.14.2024.02.28.08.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:36:21 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] auto-t: fix netconfig to handle resolvconf values out of order
Date: Wed, 28 Feb 2024 08:36:16 -0800
Message-Id: <20240228163616.1231620-1-prestwoj@gmail.com>
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

