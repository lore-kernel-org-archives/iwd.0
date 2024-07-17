Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E83181B95
	for <iwd@lists.linux.dev>; Wed, 17 Jul 2024 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228135; cv=none; b=BYJQOWB56sb60XhsV803rMr0x8/muYR6h1s09Ec656W58zLNOeivhCoMGxS+RCL3J1/u9VqpReeR4eBD4ZgjiP7Rb2SalBE8yA3ulPjZgIt1o2lFetKwnEHiEVnL04j4WgaFCrz7R0W8ZfRLgQBXxw1rECtZMuJ8bGjcgfZjD8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228135; c=relaxed/simple;
	bh=OlwDQKwFC/ByBRnpX0xVvs24NfSuyYAHZ+AMsdfvDmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J27NwwpapCpqGUv3bnNubRS6fShQ61WeRD4fbquP3E5Dy+szO7Hr0d+KeCKAudBpg2yaNGVeIACeZB0vUeaGW1ngciXC3YF6ede1JdZDbiLHqbPubQeX5WkGsLQH3rlw27InUFKm91mz+i0SHYycywgL0zBPj5n6dQ9gYff2MOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZc8Fgcs; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZc8Fgcs"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d9dbbaa731so205738b6e.3
        for <iwd@lists.linux.dev>; Wed, 17 Jul 2024 07:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721228133; x=1721832933; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d//Q+wVntkq41Q+k/oiO3Y1C/TZAIgUS+B96eAH9Il4=;
        b=OZc8FgcszOK5WuyKWcpIFEklvNtHC2/A8Qx4tezGs0DwOkIzsHNMD8BzoZzlfOKycR
         /vHeWNgQS+8BfP7+7oaXF+EFjsCUPKG6C0qYjUexbQ9UNoIRRcwP5O5fEUcdKevLQN4S
         gYd3NvzyKBv7UzxA7rozBQLjkvKpSOtRa6PlkCk/YKhltEE4Jiw3XWl279W5mHz5WwL3
         8z1h02bZtNUfr1Vubnhzf3s1DEaYaIri1huV/Zv7qIaz/S8abDhs2IQE0F4koY6SUcEW
         DRyftnE44raYUeJfHh5rJ20uiqzkr5FpPLpPXFh4fdrof/wLFeogK/L2SSr1srmJ7uCd
         BmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228133; x=1721832933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d//Q+wVntkq41Q+k/oiO3Y1C/TZAIgUS+B96eAH9Il4=;
        b=wQ47gabEIbmRrqFIMJii1NyqHdvNQmr4B8soEc2e8JndlTiS22Xw6ECGSW/Hmm8701
         1fWsPiDkt4DMYoSXDZHk7QPhQx37KzHApfzRoTTLeEV0mD1tL7pPAEDhUGsv7KP2QKIS
         0Y8sJkClInGgDD1iIMMN8KHhTd0erLUMtT5bihpthYbcm5J/VxjzWnLJ/fWIV5lmuvx/
         kSA9vOUuOEywPco3WHqfK6a2BYZP3HbWWD30/x24wkNBrq1PyFqs9P8QztYsTu2pNkNJ
         ukn54ZOL5AXEUNbMWUZCK+uVaVhU9aFpYg8g15T25vP7Rqc04uniZa9McWAdioRxztaw
         Xl2A==
X-Gm-Message-State: AOJu0Yx3AntAaQtAbn579G0Q60J70GA+NbpCEmdfc64FbB8GP4zrJUEC
	xVYmg8OIwsjf7Y3s/mKGfqGCZYBzSpvkwLBcA3ocqIFsfZKZKwmaW//DBg==
X-Google-Smtp-Source: AGHT+IHzQgnw0AoDkPVLbBB64Zr5382sH/gFcQk1nmK9bl90XsJ+Cpze2deW4DrmdmCoELd4iIjtCA==
X-Received: by 2002:a05:6808:14cc:b0:3d9:39fd:bda8 with SMTP id 5614622812f47-3dad1f8b9cbmr2288342b6e.39.1721228133353;
        Wed, 17 Jul 2024 07:55:33 -0700 (PDT)
Received: from LOCLAP699.localdomain ([50.78.19.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160bbff41sm407195885a.53.2024.07.17.07.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 07:55:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] auto-t: add reason/test arguments to hostapd deauthenticate
Date: Wed, 17 Jul 2024 07:55:24 -0700
Message-Id: <20240717145525.2656306-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717145525.2656306-1-prestwoj@gmail.com>
References: <20240717145525.2656306-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reason code is obvious, but the test argument is actually a
toggle to send the frame encrypted or unencrypted.
---
 autotests/util/hostapd.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 2f92e330..e5e35a96 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -184,8 +184,12 @@ class HostapdCLI(object):
         cmd = self.cmdline + ['wps_pin', 'any', pin]
         ctx.start_process(cmd).wait()
 
-    def deauthenticate(self, client_address):
+    def deauthenticate(self, client_address, reason=None, test=None):
         cmd = self.cmdline + ['deauthenticate', client_address]
+
+        if reason:
+            cmd.append(f"reason={reason} test={test}")
+
         ctx.start_process(cmd).wait()
 
     def eapol_reauth(self, client_address):
-- 
2.34.1

