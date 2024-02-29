Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0BC3771E
	for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226463; cv=none; b=mOEacUUKMANej/nvDSvsbD9ZHt2bnIZ7uS7jflTE+Xl7vdO1Nvm5y6hXcALUsyGsu/0XBeJhqhSb4gz9kYpPeUVc+Aei0xKc6SZRR1s3GsYNpVAat7XDOnJOnFbFoErm598aj3erTLUWIhM6pfPE0gKjggU9dDFcKKRnlp6UahI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226463; c=relaxed/simple;
	bh=+cri8Tocb7xOC0dqaklP9dxc1R8YhiW73j3UN/AR7wY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s9CRzq/YS0lDvD5cyYnztcrnVbYnQqkMa7FS0yTgQbbhlJBmnv7ij6nMzdTZBlCYBYHKzTN0jQ/sOOG3ynRpHMR9nrBMWPRDlVRC01NAgzUhcceLl0TqUiMDuUPK9BcrCI0767WYxZ+aclY/HawRM7bwZfJKpt5ebaFEBR3ltGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9ZSP3lH; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9ZSP3lH"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c15b7b36bbso359473b6e.1
        for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 09:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709226460; x=1709831260; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kPwWmARM0SI9+Vv1UdP2ERP4muSd2xS3PQaAtufBuYA=;
        b=P9ZSP3lHr+C0xbYIaRa3QvbnEVY0D3FM8+cUzp9S01F64tMWHkwfPVC329jA6KFTkB
         EqX5TBsZl3sBxMpTB9gReAgFgJohcYPGmSqLUTnA+ngc4UHfDNzMAVR/m9W+fdJkAC/r
         f51YijJoxDLRx49ZOFm9LEnhsIsjtRAYAnr9sD4NfKQ/Lrp8B/K1FrpdvYasMeK8S1q/
         5LXt7h+dOS8R4YMtgLPT1nNSuNT2Ta+p9Q5ZN65kkqf8i2h6EIJ2ETmha0FCkvi6HTpB
         ggHyZsOd79/d+/hrTN8BsSaurpzCkaT2KIU6GN1fam8xFdapMM/nNiJr9kavAYdf6aUA
         l+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709226460; x=1709831260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPwWmARM0SI9+Vv1UdP2ERP4muSd2xS3PQaAtufBuYA=;
        b=uXrQcI0JYkuo3pVX0sI1z0wnpXugPVxNXZXeVR0PGXJDf1mrNxStxIU5C/bx1zlzOV
         0aI2S8ExkZza7+kLdjM2zClYHxAgLmOPBus4+/VwuLP4YnII56zXH0+r95wtH2j0LVEA
         1h6iyjzGKuEg99Fpd26Ro5NttnxkhbWp5V8sxX7xga7zNG+uNDTLCmvYb0we8Tout4MC
         8ISS9In39GvCLK9BMYs4FoRdHLqvSMnZig/WAPZaMkdogHX6o8usFh77TIhMzKj2p7rE
         NBzvMLgtROYyrw8f7OhA54RQvvv5p1/NVpA00y85l7FYNDnNawZhaVCCQIzxfF5ghFXF
         sC8w==
X-Gm-Message-State: AOJu0Yxptw/NWmCzsjrHfcgkIh8KUij/Qu2O+tc+5iUJXLJgBx49hDJ+
	r+Il8Fkr0rDiAG5EVr20ZCwTdktHa9BE3eerIpK7SgiBL/IKVN5S90eloP7o
X-Google-Smtp-Source: AGHT+IG0YwcBqwjm4Cr7GWA+o4uhZW6I4Wk/M5aDmx/0W29F5cElZUf714uuNIAcL8EoQ27pmE6HUQ==
X-Received: by 2002:a05:6358:3a14:b0:17b:8830:628c with SMTP id g20-20020a0563583a1400b0017b8830628cmr3548399rwe.2.1709226460033;
        Thu, 29 Feb 2024 09:07:40 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id pj36-20020a05620a1da400b00787fd080d28sm697415qkn.74.2024.02.29.09.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 09:07:39 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] auto-t: end process_io on HUP signal, detect process crash
Date: Thu, 29 Feb 2024 09:07:30 -0800
Message-Id: <20240229170734.1498918-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When HUP is received the IO read callback was never completing which
caused it to block indefinitely until waited for. This didn't matter
for most transient processes but for IWD, hostapd, wpa_supplicant
it would cause test-runner to hang if the process crashed.

Detecting a crash is somewhat hacky because we have no process
management like systemd and the return code isn't reliable as some
processes return non-zero under normal circumstances. So to detect
a crash the process output is being checked for the string:
"++++++++ backtrace ++++++++". This isn't 100% reliable obviously
since its dependent on how the binary is compiled, but even if the
crash itself isn't detected any test should still fail if written
correctly.

Doing this allows auto-tests to handle IWD crashes gracefully by
failing the test, printing the exception (event without debugging)
and continue with other tests.
---
 tools/utils.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/utils.py b/tools/utils.py
index 5984fc69..d5445ea7 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -175,23 +175,27 @@ class Process(subprocess.Popen):
 	def process_io(self, source, condition):
 		if condition & GLib.IO_HUP:
 			self.hup = True
+			self.wait()
+			bt = self.out.partition("++++++++ backtrace ++++++++")
+			if bt[1]:
+				raise Exception(f"Process {self.args[0]} crashed!\n{bt[1] + bt[2]}")
 
 		data = source.read()
 
 		if not data:
-			return True
+			return not self.hup
 
 		try:
 			data = data.decode('utf-8')
 		except:
-			return True
+			return not self.hup
 
 		# Save data away in case the caller needs it (e.g. list_sta)
 		self.out += data
 
 		self._write_io(self, data)
 
-		return True
+		return not self.hup
 
 	def _append_outfile(self, file, append=True):
 		gid = int(os.environ.get('SUDO_GID', os.getgid()))
-- 
2.34.1

