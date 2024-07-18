Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA08B12FB0A
	for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303131; cv=none; b=B7xbZNZLziO9po5ZP3yXJQnBvoVYab+SIDp+YmnNI8gUCPEAyrz+uuX8SwuFy0hI+OH0YQThQMYqEhA4mttOglJ6lxzCotqz2Ei02mcOmgbt02pRdkbjlrMh7S7CUhn+2e3MQLFIJUwp9P/yTT+qR2xLrgaRkzI13uWNtqjlZiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303131; c=relaxed/simple;
	bh=OlwDQKwFC/ByBRnpX0xVvs24NfSuyYAHZ+AMsdfvDmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HV1havD1RxkPhL/NYKMsl6vMujIqLNhruVdWbXo+AiopF5r3yQvwSg1pkUp2dGTrmtbGNqv8TyQhLs0+p3UNzU1cBiYIdcfLOjSg3QScz74DzYIyB5KAx+4xPMB3T7hqrxSzvxwsEN4phLT4iTEZUcdamOfQ6K9b6YQi02gqQHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCA8O9Xi; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCA8O9Xi"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4f2e147ee98so317506e0c.0
        for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 04:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721303128; x=1721907928; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d//Q+wVntkq41Q+k/oiO3Y1C/TZAIgUS+B96eAH9Il4=;
        b=bCA8O9Xil6Npk0YUo3vETN8+K/D+0fRsW0lby+ClkryWrPXRjOAHSM8BgTwPLApsIG
         Wq94TKXLhmLbU7t/8cUsyke764Us1pg5lpHBUOuqF2seSxpbRZYeFL5XP2s3O7EQl7ck
         dsguSPIS9XcZmNenD1G/j/dKvKvmLdtpGM5kxYd2UqTEeF34K+AW0bKgFD618BENB/gT
         IVEZBR7pouvPImWzWHmvU2nwdntx/YACukkCjtpyslsv5QFW2Z71t++gtRGNcVl2D/FY
         zP9PL0HqHqOZvZr7v4+IDIAVM+AC8l8VUvtMxD5ap0pkTdi3esVb5MRvgf02RF8ZmtMm
         xqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721303128; x=1721907928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d//Q+wVntkq41Q+k/oiO3Y1C/TZAIgUS+B96eAH9Il4=;
        b=gx+VBvv4fHcsDXvVFMSHCqqtc6vz1AzBYKbY8LMh9HGBdGV5T2kQK9w7PQftBponVa
         T671tP6V1LwO8nOJrQ3gCInRjqQL4XNeKcvoPcmk0yEth//cB6gMU7wODbLKrPlrVEC8
         eA2z2+UtPJJcoVc1myBBR3y5lMwdGIJHP5Kxf3C5tliM0FbQwQnFvOJKPTLjFy9hxhAf
         BbIADXokgQNCt1H55MoZxZdiJVjcKlJqVAFqXABDeZrD+SKpTCm03Ln5lFmOqY4P7MvO
         SgqSfv6m1HlA3dZI+6I0ngUAPpOSvKEVYuwyYLNNkaFnJwB9OWg1CcoYmuES9cPAoG3q
         c8EA==
X-Gm-Message-State: AOJu0YxeD29SCP8l9WDjeKGGx+q69aXuyxlVnj3dCtpBF5RabJPWqPNS
	TZzz1Q/iBTmHSsaDLryn7meOpsAye8gGV98N7OoWV9JSoRsocPHqFQwgdA==
X-Google-Smtp-Source: AGHT+IGIeX/8GVMeRA57uF6eQuCKr+1nnx69tzWl8i3pv0MKue87apEQr6nsNmvje9ZRM38wmSqFpA==
X-Received: by 2002:a05:6122:1818:b0:4ef:64a2:8e18 with SMTP id 71dfb90a1353d-4f4df89f9eemr6022569e0c.12.1721303128506;
        Thu, 18 Jul 2024 04:45:28 -0700 (PDT)
Received: from LOCLAP699.localdomain ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c5138bbsm7292006d6.61.2024.07.18.04.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:45:28 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 09/11] auto-t: add reason/test arguments to hostapd deauthenticate
Date: Thu, 18 Jul 2024 04:45:12 -0700
Message-Id: <20240718114514.2916258-10-prestwoj@gmail.com>
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

