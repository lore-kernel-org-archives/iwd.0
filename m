Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC7A14885C
	for <iwd@lists.linux.dev>; Mon,  5 Aug 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872244; cv=none; b=LpojtOY8U5+zG13+isaP2fQLnzhfX3eyCeFRpoIv+cM5VqiDWKIQuveCzsW0hhN1J1lmOBbRXWHdNJxPJ9+blV+0SdCfki6qS0PMlrQyGZLx/MEpghqOMNh1xOD1LynVv33pGWi7S5TEmR9XQioxF5AfqQa4ZlE4NObz5rspuEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872244; c=relaxed/simple;
	bh=k2bW68bx64Eld19eqHWS4Mb5+GaLQ22iwFrb+S1QZ90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ha5OkZayV50m6B2is+Xys3aHENHp/nzb/hcqFD25Xew9JWWGFrpYh1SNNIejo7nOQfdmYMz9CBVutZK/bztc/8/9Jrmiuhnqx139IjglNNBTgVFusAsSy4l79pIxQk26PXbHx0wKEgvb8Utd3HHT5EbQG+e+9uGeSeZZwIRPgos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JweZNMag; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JweZNMag"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db14cc9066so6731862b6e.3
        for <iwd@lists.linux.dev>; Mon, 05 Aug 2024 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722872242; x=1723477042; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mw3kUMx9OXuJ/DGORkP7ehDfmDdiW31RWubzCddrmoA=;
        b=JweZNMagjB7R8EDx3UVN44nFo25LJ5SGLJipjGCeP+uYnUjvCvjqXKFWKPI5bcQOal
         8E29mqIAUSiovTf+bCDeHZvl4wse9ghPA+5TFxdLriloyXM8eoVWHtOw1c0G4hXuM3N2
         qAkKeh/cNC3hkYSTo/Nu63XmURRu3ZrPhv5V37ah8JR/Dp2Ms9+0EN2GeI5bSKhfbUBz
         TFNqe9+UKzaZZGLv8k5zV4M1iPbq/fQ7TE/MPl9L1qHrkGWUV2kOqyZFu5wCZxzn6goF
         mTVWN559M/1c4XlygtVsApPlfLwinRsEqBVm4zeSGsf7xqmzn9nGpHZ1Bt84GeNOCeM5
         aKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722872242; x=1723477042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mw3kUMx9OXuJ/DGORkP7ehDfmDdiW31RWubzCddrmoA=;
        b=tMzKG2UFBX/FasQAk5ZH2lW2P+yIBQypenBtffpbFZ7MuOs61Fs4vfI8Y8MufPdJnn
         JKl2MOwW8Ye36JLqyo0FBy2/kh87r0lt/H1D9p2s6LgHpEL2rCBMdRL7T0CfL6RavXPN
         BpbX58FhUDYQguyB4Q5oVppFYV6x5suRV6gdRWQ+DGOlLNOEBS4IGfjW3xOFVTDSdVeC
         cEIlS/hHD30FoKrBfZbZyee4jXfqlRDT68NOYjjUx1ZlWgsUVd1tO3+MK+luXA/s0VB1
         /lR/eF840p9V0SyVwZFjKN2MlN69bfQKIOaU7uCaDMdiH2T5r/VYrXlcFQ90Kkj0RoB+
         UseQ==
X-Gm-Message-State: AOJu0YwXKXLnkYx/4uce7ZltVgJ3OK394ts7zmBXPiY9tip3iDBCYk9g
	uv5+8h1/smq7QI3Adj8VkthS71Z6viQoayFnf+2mEjqypLL0mrpX8MVoZg==
X-Google-Smtp-Source: AGHT+IFJMXx+mnin/nvob45LwvRNP04w7/5ObzBJJs/yMfki82l2XbWnq8mufz11wIOY8oPwXORWhg==
X-Received: by 2002:a05:6870:212:b0:261:1ccd:358c with SMTP id 586e51a60fabf-26891d9a971mr15075215fac.24.1722872242068;
        Mon, 05 Aug 2024 08:37:22 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6dce75sm362617385a.14.2024.08.05.08.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 08:37:21 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] wiphy: set neighbor report bit in RM capabilities
Date: Mon,  5 Aug 2024 08:37:15 -0700
Message-Id: <20240805153715.1049286-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/wiphy.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index fb36ebb2..19dbcac3 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -2121,8 +2121,12 @@ static void wiphy_setup_rm_enabled_capabilities(struct wiphy *wiphy)
 
 	wiphy->rm_enabled_capabilities[0] = IE_TYPE_RM_ENABLED_CAPABILITIES;
 	wiphy->rm_enabled_capabilities[1] = 5;
-	/* Bits: Passive (4), Active (5), and Beacon Table (6) capabilities */
-	wiphy->rm_enabled_capabilities[2] = 0x70;
+	/* Bits: Passive (4)
+	 *       Active (5)
+	 *       Beacon Table (6)
+	 *       Neighbor Reports (2)
+	 */
+	wiphy->rm_enabled_capabilities[2] = 0x72;
 
 	/*
 	 * TODO: Support at least Link Measurement if TX_POWER_INSERTION is
-- 
2.34.1

