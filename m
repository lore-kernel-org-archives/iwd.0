Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECC02D6619
	for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892303; cv=none; b=Hqr1/vX0uTJIM5Fn+ZfIPcy1s4griYZjQpgY1IPn2mxfwlC3EfXVSwyRvQAnugae3TBykVuJNd02p3J7TkhadWEyjh6WlaViFyhavblb+QUwj9rUR68WrYFFbP0U5rZBph7A4At5JAlLfxNATwGc7EO7UyKFHfK520F+zoB9PsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892303; c=relaxed/simple;
	bh=7VlNY/851JRO4RvwESB27kQxwaGJL0z6s/t27dLog7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F4lJZ5fUWnn533YfMRudb4fPd1MYgoeWc8a3DmBFycwEIaBNhXXDxX0BN4QXlfyMRBwoTCribwDkLxVOwbOG4D80x8PvgnnmEgjW+DZv83ikB4kvcHGtJ1pKWZ17ISpKlV53HX/X6TBCrRBa8+ezcLLIXDR9ApiK/Mg3VbZvZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjUsRFiR; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjUsRFiR"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b2b859ab0dso4322721cf.1
        for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 12:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755892300; x=1756497100; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUKbYEpSS4YycBHtvd76BDCBoxH58/4gnu2INf/V0Lg=;
        b=bjUsRFiR6L/L2is0KIkpkFrVuMwpqvquAz+qdEgDBJUnESr9UU2S3BMopXlKH/HElR
         2j0EMW8uv0h58tXR4amM47r2zLdgXpCNL1csRDZRBtfCX17iEYZ6fUUXk83KvHAWNjj/
         nDltqVEeuYIzi2PyxQ/8dr5fK1YRT12dppwYrz9mSqFBXmv2G6+PUIkdlbWoQ7j5qNoO
         GqaPwA91ww6xCriKGBRpDnQab+zshJRDeKg+oyvoOwahT+9miNwLQum7l9gME5r61rjR
         N2BLN2GbgY1q/UL6Z1TfKNrk1mq443mgbw1XadyMOsivyNbz4lg2NQxR9qF7y8NTNf7I
         S+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755892300; x=1756497100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUKbYEpSS4YycBHtvd76BDCBoxH58/4gnu2INf/V0Lg=;
        b=G+6In0AWnLbdp+i/LQjOYQ+qCQUNTnfSLdrAUjQKBcAAqke8vtmR/DsRDbAD0R4NGL
         JEdH+QPEBEZM4iuk6/p2RFqN+iB4zC3knMhAA67S3G4seTEhX/E9mDZlghaRuyoXtSPX
         xXNr4Jkda9a7dH67rOhn8F0tRp1EFbuRyCQrI+oLzYVbkakIysvVzkr77icGKpzQhRc4
         5Oas/we5vjYUCKgbQmG4LetdnaatJ+JC6V2F5GfVFeyo0AbwNKzAH6ZEV8cIdAmXS0Gb
         PYCzLUPTAR428K5jPgL7RmpOEPoP7GteZ1j/rgzua2X6hXLJz5OHL5FMApflxR6WPcgH
         Skfg==
X-Gm-Message-State: AOJu0YwyvlQXxa/xeCTb0rCfCP6tVRNSKS1J2CfHPHw1KSudfNDhPZ+Z
	VY29bwqiyrJnGF8/rSx4Bz+1UsHDyRpneJHB9YFA9/rvVOrfb0dU36foQDvVpQ==
X-Gm-Gg: ASbGncsUhWbrrCWe3pnKcxaTwAsZnfEfMjSoWg6Hn159aG+2jCAiANv9pTmhYB8xjkc
	jcKwg5sAVFIBp5/JVbJXtYvDI3g+BA/c1fe0BercFsUQtpnPGrz4gK0NFDypSmPDt7TwGjqDuKo
	jkzIhSGcbOdYdqWUCqhEW+az6vVgeqDBWyUV5LJP5Wrms82AduFwM3DYwh5k7WPo3HfpVgNRwxt
	0zKv5R/i2A+8S60PoaOfoWWfuI01dpSLZOeVPNt0GmVj26TJH0+fL9BYGVZWszXHCq6Z1AX/fq8
	BCuido2YNk7NpEnj9g/jyXiIt7czPljgnIZEl+T4ta7SEP8ejBkqJ2TVTmX5+6Hz3R45EARwQ5f
	ZDN/sQsbm6x/rZKJmpOyFkdfFOB3FIds2
X-Google-Smtp-Source: AGHT+IFhtdvC/TWhPfYooy5X8Tyhlxbqp+69J+U6/4z3EKxOMtJX+iExvcwqk63izBQoHjaTAYx/1g==
X-Received: by 2002:a05:622a:2512:b0:4b2:9b6b:3e with SMTP id d75a77b69052e-4b2aaaa4fd4mr50360191cf.36.1755892300010;
        Fri, 22 Aug 2025 12:51:40 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e45c4asm4913221cf.46.2025.08.22.12.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 12:51:39 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 14/15] station: clear roam_freqs on delayed roam
Date: Fri, 22 Aug 2025 12:51:17 -0700
Message-Id: <20250822195118.271122-14-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822195118.271122-1-prestwoj@gmail.com>
References: <20250822195118.271122-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there were no BSS candidates found after trying to roam make
sure the old roam_freqs list gets cleared so IWD doesn't end up
scanning potentially old frequencies on the next retry.
---
 src/station.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/station.c b/src/station.c
index 3424964d..968aafb0 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2407,6 +2407,11 @@ static void station_roam_retry(struct station *station)
 	station->roam_scan_full = false;
 	station->ap_directed_roaming = false;
 
+	if (station->roam_freqs) {
+		scan_freq_set_free(station->roam_freqs);
+		station->roam_freqs = NULL;
+	}
+
 	if (station->signal_low)
 		station_roam_timeout_rearm(station, roam_retry_interval);
 }
-- 
2.34.1

