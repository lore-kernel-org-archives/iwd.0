Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B913A87B
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939030; cv=none; b=WXuq/bESv9nNr9+rI0EV5nPMzZCjce98s8o6NEbGf4kSzDl3f1K9m5WyCMgPt5gOnzNyfgbYDQtiLEBULu+cBdTVNK5PLzSizdAORoFqGlg8dI0QeuwEF7WMFKvfOJtNjWVQQP4VK/1Q0ul19QmpNkPFQjc93nj9BRo5plrHH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939030; c=relaxed/simple;
	bh=fpUhQHTVJUBTgZ8QWi8W0NEhG+GeVRD2i6J7xVV1Uvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XzFMjR6okIV8hk0p/uOiOrT/X5vYfgjI3Pf6aK7uk3+AkK2lrT8AaZc5OWXGCeDuqfxH2/QXCj4u+inYxA3a1Yf3utREV2aPknjHAcEnafUx5Om5hc8ZEYpE5ySpn47ZshGyECnGgCaeyq36Xn9hF3XWa5uy1ALC6HfvCbevqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWs/NGGX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWs/NGGX"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d934c8f8f7so713765ad.2
        for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 11:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707939028; x=1708543828; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RafitYr2Dj70DrmLktgtfBmI71dyspbC8oqI5KIOGU=;
        b=GWs/NGGXkyYn/ei8tFx7VVJKynIFgM2xpsYgReIl7hDZT0zPLKYwJxtyqCfAD9eXH9
         O+J3w58AIKHt4paDJSHmRofrHFP4NnWrmI0ATbBCFgNfn+VpNLZMPHYJovLv6A56HAZi
         dr/dSfBUCBpMmJcyhY5EAIAn0eBNYCfD4OYpLHmL7pKjLePE0+O31pLiWXVRMPTVQsLO
         5CeK+B6FhKeOB30on/miMbR+GuIyPLnz7kdXMMTYV1P4AWSxUsoCl5PE69pY9DMaIeHI
         HFUw0lwKG6kEQIxDhbk2TBHCpvI4KAqb8uSoJ6tHiRikubDwKL7Q5W8oXMUBDH/7Ge+J
         AMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939028; x=1708543828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RafitYr2Dj70DrmLktgtfBmI71dyspbC8oqI5KIOGU=;
        b=kgSbT0fG5Omua6oqZqkr8lbTwntsQC7zIFa0Z7MI5HPcZ8aXhDzEI0LDgaNSYxslu9
         biY4KL+tnKSUR9FA5BfP61OjYrwrm2s0TeLupCS8ihB0EDYjrVdfTECHro+xsWPJD7Pz
         MW0Ko60QO5pn1iId8FBx0UGim05btu3oeaPCb7XtXaLMPMvzlFQ7ypX485Z7fmXxJUcT
         0miGfljb0UT0V9zSU1Yddoqfl0yAUMr4+RIo4gwbBGYtGDLZykZ7Rpo+eJauUvj2nypg
         m/ZeqEpUQ83nqYtn0gGQ/nby39xRMwgelP87ov74igtWvgkbS4uromS68vlm0L1DtUWJ
         /x8g==
X-Gm-Message-State: AOJu0YyV9oq3ufNTxdfPUKtEmK5nF4ls3fwW45Mqtyh1JT2+N8+v8Ud6
	w3Q/THJZGOVDlMX8dBrxUodnNt7IZ8izEjDpC54PsN90aDkaR+tk80bPXLPiPpQ=
X-Google-Smtp-Source: AGHT+IGu28xbQYfUgv4Qkrh3YB8q/c2sc+zyqW+wl15YdoVbRIVlV2EoxHgNkrNfw6NIScyB+jE1Zw==
X-Received: by 2002:a17:902:7c15:b0:1d7:147d:6a1d with SMTP id x21-20020a1709027c1500b001d7147d6a1dmr3162942pll.55.1707939027786;
        Wed, 14 Feb 2024 11:30:27 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001d8e5a3be8asm4028120pld.259.2024.02.14.11.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:30:27 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] auto-t: timestamp log files in test-runner
Date: Wed, 14 Feb 2024 11:30:21 -0800
Message-Id: <20240214193021.963130-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214193021.963130-1-prestwoj@gmail.com>
References: <20240214193021.963130-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The log files become much more useful when there are timestamps
associated with each log.
---
 tools/utils.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/utils.py b/tools/utils.py
index 8219542e..5984fc69 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -6,6 +6,7 @@ import traceback
 import shutil
 import dbus
 
+from datetime import datetime
 from gi.repository import GLib
 from weakref import WeakValueDictionary
 from re import fullmatch
@@ -125,7 +126,11 @@ class Process(subprocess.Popen):
 	@staticmethod
 	def _write_io(instance, data, stdout=True):
 		for f in instance.write_fds:
-			f.write(data)
+			for c in data:
+				f.write(c)
+				if c == '\n':
+					stamp = datetime.strftime(datetime.now(), "%Y-%m-%d %H:%M:%S.%f")
+					f.write(stamp + ': ')
 
 			# Write out a separator so multiple process calls per
 			# test are easer to read.
-- 
2.34.1

