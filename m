Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406C638A715
	for <iwd@lists.linux.dev>; Thu, 19 Mar 2026 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943532; cv=none; b=UtXx43gVMK/SbhSbDzfpP+W6L7KD4/WLqBINMvAIN5yTcOEDh1VCQvLkuktRrcoofIeYGm+2sVuugYMKAzfoiDd881UdUKwgTLKYH3xwylSqpFa4XSH8FRR9auOFTjQoRyPxJazTNQox/dYD3e2oBawFsZ1iSbpWlSsFoujui58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943532; c=relaxed/simple;
	bh=PAF1oMsE/B5Ryu9N0/dsKZk1CwxhJR5D3HGwd6+XPyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VfznQ2lYZ7wAmvS/Pa6Yck07t7+YzFYR2c4qzqA023A12ElaT7cBxXwTw/lru7USKLycgT4C9rLSGOOAfjfBZP1CgvlfIzEUY8c8UU3eYO25vst5/7Qea88k3sKefqrQJBOxVrIapesNgFt7TIBk9zTdkPoU1VodaaRiamgS9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDZ26k6e; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDZ26k6e"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8297310ce0aso463848b3a.2
        for <iwd@lists.linux.dev>; Thu, 19 Mar 2026 11:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773943530; x=1774548330; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6DoyeRaVF2liD/uoIkmBaP/uXKYX6VrU3xM/t1JJeww=;
        b=WDZ26k6eDc8yOlxiZIqtQK581kXUpzpHKvExpwy43Ox+UmCM+EF2wSh6bv0MLfaPtX
         8yorZLwV00tN8dxMVxyVYkCgYDbEXzNNtBkGA1FDxioEEEXvL4eqvShlN6vmLEH+1UO/
         JDWVkOtz2fa/lrHhXLs2MTVah/79CE2A3+IV1Ywvn38iQSRXuBWa9ZX2o/AWEwY3UoIa
         b9ITltWM6tLqxJt9o2wbmTzTBwAM6T3VdyRLpukDobCqnr4Nzpmg//naFu7IdrFNuFBZ
         uL/OPtWWzb05jXLH0FucJohM1hYh4dwyd3VEE+cxMA3bcOn+5N/E1W0mG/NO+AVAZw0x
         wojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773943530; x=1774548330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DoyeRaVF2liD/uoIkmBaP/uXKYX6VrU3xM/t1JJeww=;
        b=chMnPGfVjlnGwNHxau4KDZvSo2g4dxw1SU8cv0mSwVbIwT/YaK9Oty5jXF5iMZvt/t
         WIQxwyUVmkA4/9ypLlZVPIUWY9xUNpUunBA7flR8gBrbOD2C25PEGOLehnA0phrpjFfb
         dm3i7JBPNCf4XbZd7sq+F4o2K1XXy/IZFp6ULZRi4EBmCd/YckSaNUD8fUCqUSw8aIyo
         mSKlbrk2xqtnhaBuZAvW0IatSzXQFjv9RjeAEZPMDDmkBxNG3mW+YErz5jjTvN+6v267
         PxzOhFyL9/4FWSgkb8RnAxyWKNzMJUhmwkPU5YczXCw/evAfKcX0iloEme+2/jxcqU7s
         aqsA==
X-Gm-Message-State: AOJu0YyIFZani5JpcD7QmtxfFY+G2xnnZTx0SENBTBdP1+LdAeUz1T+I
	4ReIAXuPGRcP49rtDITAzxtbSGAAIRkWSZZeZlErJC+4HGATP5BTpU2++N2pAg==
X-Gm-Gg: ATEYQzwVqKQ/9ecVB+nXcwNxLZYyduQL4JL2bNU21opJQOQwSRzs65Nk/5kPEX0GTex
	zT51cReibbOtifxM0TGc0fsqM6ANXyTjryFCBRPPALqp3RAfDpShUeeaoj7JXz+5lj3wLw993Z7
	90tL5aD2MNAtUKgE0cBOKm906IlnJ3e3VDjXls/PJZd85eSd4r+82o54eZq265lx90p1Fmbj9r3
	Y3Fp1Ui/M+AsGeKmOwWzCyI3gXpPI2hn2gA5yhU69+xae9c80CopywnZ3I54e/0vaIqMY/cQ/GX
	P1AUFSN1kQDV+NFy5apONe+8sluLbF7T4mMSjWOUf/0XlRjH9AYRPkfb3wTwuAothal18t9JvCx
	5Ay1apQWOU7Z5Y3U38DXWCLYDlinbddsKoQ8X05zupHPH8mawi5f1/r8FXieh/x5tEURD/gjP0Z
	PSK4//g1q3GcMTJRUWZJu4RwqChhyqdZdidGqrIQbIutcbLzE/UPGyO/8rD3csMHYN
X-Received: by 2002:a05:6a00:1da2:b0:82a:64b1:bb6e with SMTP id d2e1a72fcca58-82a8c30283fmr151681b3a.35.1773943530137;
        Thu, 19 Mar 2026 11:05:30 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b541cafsm6699251b3a.12.2026.03.19.11.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:05:29 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 0/3] Fix for PMKSA usage after known network removal
Date: Thu, 19 Mar 2026 11:05:22 -0700
Message-Id: <20260319180525.136095-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Notes:
 - This will still happen on fullmac cards as the driver callbacks
   have not been updated to flush by SSID.
 - I believe its possible to pass an SSID attribute so it should be
   straight forward but I haven't had time to bring up a raspi to
   test this yet.

James Prestwood (3):
  pmksa: add pmksa_cache_flush_ssid
  network: remove PMKSA entries on known network removal
  auto-t: add test for known network removal of a PMKSA network

 autotests/testPMKSA-SAE/connection_test.py | 32 +++++++++++++++++++++-
 src/network.c                              |  3 ++
 src/pmksa.c                                | 27 ++++++++++++++++++
 src/pmksa.h                                |  1 +
 4 files changed, 62 insertions(+), 1 deletion(-)

-- 
2.34.1

