Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8290F15E5A8
	for <iwd@lists.linux.dev>; Wed, 28 Feb 2024 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142472; cv=none; b=U+6oRFaNRusif+3AFDfmtBsb4xJ4+jPnn+x5kNcwR4EYJzrGwBnNB2WG6cidxG4QLQs5yHjk8wWVOrXVtHTSt/BfdJdi0lP9YN/GmQ61z5EDum+yURrTbBQt1ebz+XEbG5KBYVPYPp+Zy5BeRfb+gw+nYwKe/62BPmozeFiJ1Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142472; c=relaxed/simple;
	bh=4Yb25NGMARrQFs0xiWkQl7FY0yvFTAAoAyKJfXnfkeg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aiay1zkYOwzto4G471sWnILdOiRChntxviGag+BLGMkFLl0yKXrrsvHtCJL/5usNFkO5NBBnmFGSuKMirPiPIf4oRCncBhzoFJn2HtxDQif/LXbnUxiaK0NQMwOhWr7TFeudYD/sRadeL9T3SCvAfXjcU2YZLy2ncPbc2vtnTCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIIzxuql; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIIzxuql"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4d33d049cbaso285447e0c.0
        for <iwd@lists.linux.dev>; Wed, 28 Feb 2024 09:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709142469; x=1709747269; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jk3+gXj7X+WhF2Xp7C93vLRjCHHdn8oCGIybBYv41/Y=;
        b=RIIzxuqlWTKSN1+pffzcryFPiYp99rG0bf3e3q4pDppjtcLtfUFo5bq6F1uLwX3vyw
         As3RpyGL8jDRDQAOvDeLloLKtNI9RM70ERB8AjRA0qF0+Cv9S6iB1uSqqkv2boxfPiH9
         e9xXPupVNj+bfJIfqbehjykhpo+Ygq3tYHkXafDvKEXIl47Ag6cca+YODrhkSJ1z+TOF
         VN0nG7ovVVpYaGT4L8IlIynLD+CMa4ZCRsTHcqlXxDF3DjmsvHFlnjHeDXJo4TP/9tQM
         S9bgHLdFMQ1GV/KBkhebzHA1gJ04hnDKpqQR49IGL3FaHQhbG29dOrTyDuAEuZmDxHXO
         cgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142469; x=1709747269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jk3+gXj7X+WhF2Xp7C93vLRjCHHdn8oCGIybBYv41/Y=;
        b=Cy+mfTGYR8ArkVuDswd34p24Qg+NOan+ZkwvWI4aUnmbc+A0XRY/9fe8Ja7eiDVxDg
         StBWRLr4+e0pnXINnZbsfsEJ66HnwzsMN8Ir/+6vbrM3s13S86eKsXM2zk3L4h8dedvT
         XU4ckV5klJUKWYvcP3cYao6TCwVoiIarpXQfO6UGJvwL3/D6W2KxMrvHZUyQr7VG8n7w
         BUDm+io4mqGMoy2Pm1zHwzGYWwpH0zn6+5/vLG4F/BvjfaV2AX44hQWFvWNsbHnAzNtC
         JIOE79Oq2bj1DUY1DLNIATDswKW5QX4JWgz3JAt9to4SEy1WK2e7qYnLw9duJtsrWS14
         Kcyw==
X-Gm-Message-State: AOJu0YzndWY6NWrHNs0/iTsEqaVJUBYF4spQiTdbodXkC0VTNCNQdWGk
	ETTYsW1Obe7ohyOluodYM105hb+clhgEHJ+uN4OSvjZ4HK1R0hq5YZ91JMbg
X-Google-Smtp-Source: AGHT+IHaYBbVX78botknCvfwnloasWuyFeTCjr1s2tp4TVEplpMxNlXgn3BSGorL4jI3Bi+uCmsZxQ==
X-Received: by 2002:a1f:e443:0:b0:4c0:2d32:612f with SMTP id b64-20020a1fe443000000b004c02d32612fmr222425vkh.15.1709142468680;
        Wed, 28 Feb 2024 09:47:48 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id k12-20020ac8074c000000b0042c70c153f6sm4702559qth.91.2024.02.28.09.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:47:48 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: add ability to reserve radios not for IWD/hostapd/etc
Date: Wed, 28 Feb 2024 09:47:43 -0800
Message-Id: <20240228174743.1237719-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the test needs to do something very specific it may be useful to
prevent IWD from managing all the radios. This can now be done
by setting a "reserve" option in the radio settings. The value of
this should be something other than iwd, hostapd, or wpa_supplicant.

For example:

[rad1]
reserve=false
---
 tools/run-tests | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/run-tests b/tools/run-tests
index 11ad73c0..fdd0b989 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -73,10 +73,10 @@ class Interface:
 		Process(['ip', 'link', 'set', self.name, state], namespace=self.ns.name).wait()
 
 class Radio:
-	def __init__(self, name, default_ns):
+	def __init__(self, name, default_ns, used_by='iwd'):
 		self.name = name
 		# hostapd will reset this if this radio is used by it
-		self.use = 'iwd'
+		self.use = used_by
 		self.interface = None
 		self.ns = default_ns
 
@@ -131,15 +131,18 @@ class VirtualRadio(Radio):
 
 		self.hwsim = config.hwsim.Hwsim()
 
+		used_by = 'iwd'
+
 		if cfg:
 			self.disable_iftype = cfg.get('iftype_disable', None)
 			self.disable_cipher = cfg.get('cipher_disable', None)
+			used_by = cfg.get('reserve', 'iwd')
 
 		self._radio = self.hwsim.radios.create(name, p2p_device=True,
 					iftype_disable=self.disable_iftype,
 					cipher_disable=self.disable_cipher)
 
-		super().__init__(self._radio.name, default_ns)
+		super().__init__(self._radio.name, default_ns, used_by)
 
 	def __del__(self):
 		super().__del__()
-- 
2.34.1

