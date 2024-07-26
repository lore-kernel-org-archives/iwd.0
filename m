Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841C176FDF
	for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006532; cv=none; b=h0ffZSfIbAChpttlU2MPvFzmaIUCTg/N6sACkjeBQowflEoyNmigMoraWRMCs8daU9Ui38+Fegm4fj8JZ3eDDEyEU01HqCd92AwXAscRMtK3voLl8LsAw8gGQNWQcobi9p+xIhrV1Aly607giSdDyHxu0wr7g1qvcup8sakKF/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006532; c=relaxed/simple;
	bh=zQcaVz6v/TOFR/W8vs7LZbiAzuBq92+BmEhzJisTEhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wpt6p+sQdylYdbQDK1AeguBqdKEIxbXQ7ftz9LhFsDVWCU27mwkIqsBT0SNTTOyNQkeJEzDqAukId1FCDWx4NKievI7mGhSYLmK7fS3pSFzUyvTr/xc4F+EsFnUHkluhhoj7Akq5QnZJWTtTLLygqWG/IDk+MX+GRS0VBEliafs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDnbhqKr; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDnbhqKr"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7036815bde7so636793a34.3
        for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 08:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722006529; x=1722611329; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZMqtBI8bISuJwSVhDaRGMAJPcJ6jhlT29KEC0lRhdc=;
        b=jDnbhqKrmyEchmPaCkw98TdlV3KA5UE89VvanlVm1/FBgc4GgU87ggRkj4yhkYG3N/
         A8wfHgfF5eG7VBKF0cJs+MHTuJqiQNi6B/wErKLPLqHNJ4aRDIZJcFagRJB0N7oBhYB8
         F7cERzegD1oVeseyI68QCxhk1NnZZ25neG1ONCYlcN1pRTpOOeAoOQDl1uBvh1UbixVK
         NtlImGU1ZEFutTdsQOSA/m3ndFhZxaFKa8643JAli10WabTlXeOqadyIIm85qoVj6Fzd
         wG6KtotDqmxOv+3GMMP6h8lfjdjaGV3ogeH/oayRw7pgrGndXzqezanFFJrzSv3kcX3B
         D+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722006529; x=1722611329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZMqtBI8bISuJwSVhDaRGMAJPcJ6jhlT29KEC0lRhdc=;
        b=dsBEgUL3lZnzvbN6ncHKBheryipDnr0/ZOJBwooMHqpclxG6GSpcL4b5Q3W8GbuuZ0
         S2Gul+T9SWDeRiL5vkZ1n+Acc8mLcL7AZGK/jqQ4E+5EZlTlM6a1bWKxHtVhKNE0Y1jT
         ui4lGQtR74madoP7/hlEKHc/7gYrQuuNpD9bmrvrQ6HrxCFNuBHJNuq0LaSklhT3SY6h
         Wx/9+L4UGLCdR1mxmdEfPNikG/R8zHHFSV7Pzyx4SV/aAMXfZZxTkPhgveygSBQnoGcj
         2aQVbWCWMVImpHXG664vSxX+Gx5ybhtuZRj+Y7eQHMCuUPglcczIXPVnOJTiMtvYvPo7
         zDiw==
X-Gm-Message-State: AOJu0YwISd3sCCmOk4Ybdr05sVcBWIHI8lrEkgsDAn0B01sDNH1JbmGq
	Bc0ETdNbCzTAu6fbTy3v3QevEjpd6hXr45sxU0dz85TJ3CL/2T+nUclUNw==
X-Google-Smtp-Source: AGHT+IH3ajkT37JTTmfTQlZa8HWdasQL2BXtzmsJq7v4kouGSFEbIEu99uZqKfLotjeB6uEng57vWQ==
X-Received: by 2002:a05:6830:658e:b0:703:5ab1:64d4 with SMTP id 46e09a7af769-7093251b313mr4999087a34.29.1722006529638;
        Fri, 26 Jul 2024 08:08:49 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70930785d17sm762842a34.67.2024.07.26.08.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:08:49 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/2] qemu: Remove unsupported command line arguments
Date: Fri, 26 Jul 2024 10:08:28 -0500
Message-ID: <20240726150846.146628-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726150846.146628-1-denkenz@gmail.com>
References: <20240726150846.146628-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[denkenz@archdev ~]$ qemu-system-x86_64 --version
QEMU emulator version 9.0.1
Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers

QEMU now seems to complain that 'no-hpet' and 'no-acpi' command line
arguments are unrecognized.
---
 tools/runner.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/runner.py b/tools/runner.py
index e50ba9c08d20..6b27540b8cb7 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -414,7 +414,7 @@ class QemuRunner(RunnerAbstract):
 			'-machine', 'type=q35,accel=kvm:tcg',
 			'-nodefaults', '-no-user-config', '-monitor', 'none',
 			'-display', 'none', '-m', '%dM' % ram, '-nographic', '-vga',
-			'none', '-no-acpi', '-no-hpet',
+			'none',
 			'-no-reboot', '-fsdev',
 			'local,id=fsdev-root,path=/,readonly=on,security_model=none,multidevs=remap',
 			'-device',
-- 
2.45.2

