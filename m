Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596A01CCB49
	for <iwd@lists.linux.dev>; Tue, 19 Nov 2024 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026290; cv=none; b=BcyHPDQW8ewYAcrnDxu4Di1iCV5fP96O1z0BndIf7H1dvqUY/72YuqM0mG1+T8GhD6UOboiMrhyF3W0XinbqU0hsllKocGzsaUo7UYiP/g73y5yUnLqFIh4WXsOHbpJ0siThau6Ja/8PuNctFGAd542IJn70Bi01bHIsx/1ipDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026290; c=relaxed/simple;
	bh=BiTPn8V7GCMEkkiqLNJDXuX66xFv9ryNc59hfIyX5Ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CL2GlsBkrBKsZhBsvMOuP/ErhhVGbDGcWdC0g7vbtYF62LoUuDcbcyOIQo+5t9YD6KmDA4O+vW4UBgHSdlJp/Vv0oBdT/Zp+brNmXI+N1dbfx6RLE+76Pawp5OXWLCMEzMru0xlmiAwBOst73hzQDAKGDpvM7vEcPfdUtlNpuuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TE7SwxTU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TE7SwxTU"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21210eaa803so25826835ad.2
        for <iwd@lists.linux.dev>; Tue, 19 Nov 2024 06:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732026288; x=1732631088; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDyQWJb3P+nou5ag+H+i6p2nhJWw2sD4+N0iPLIwRCo=;
        b=TE7SwxTUVjLm4nWtf3X+GAHyyvD71x54kx0naxgTiCxA909Nnp7Ko05tTJ9RtXPD8r
         w3qyLTuVXWiUpV4M/QBh2dXZLcXMS+uYMlaGACrBdldGDiSt/XM17+Zc3Ngto0Q4tEbB
         2vuUwlAUX8UUHk00vQpWBfGLEGFOA7rcYjakddUPx31ZPbJvk/JHg8UGQ9UYjjHhcg+1
         wXMVfj6kdhEomuX33sXqYKBF0x6QbWBNXVX8myXoTzpTFhMxYp2A16n+oiZ+N+z7jr3O
         QRrH1EqH/7fuMWJQSF0Hw/BIyyIgxFNA9LUFfMtrkcrT4pB42OBmja7x68JZtd6fu3Nn
         U6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732026288; x=1732631088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDyQWJb3P+nou5ag+H+i6p2nhJWw2sD4+N0iPLIwRCo=;
        b=GBZ+D3Bl4vHf6gnaMkhd3S7Stu4cJAPYzpLHnfeRRohABRNRXf7fFjmnJvdMeCrh11
         VuIJCc00ZNwTV0IVcfY3dTPqqSzWeZ/Ak/rWJFJNLKRn5qMsgi58hUhaMpejL1ra4KWo
         OqSAJKTXPFE8AGRfEKtSTRMlEyqOuJjbQ3RI/HUwRDpRlwHJTZRmIeNb5i1CJNHe5A4g
         D+KUihEQ6kyJvkDuiEkDSdLelw7Co0LjKiTr77lMHL0kIIH0cwwg1kyG05GfAOkjsbDn
         Ttpj1sf0lvHQSib+5cOXWIXjg1C6kKb8zLFRnPlvFzZoOQxEB6vIv9beKqHvUaKoeVJq
         GGcw==
X-Gm-Message-State: AOJu0Yyt6p6mMecfhRpL4oQtGy+VZxfttDFbimkiJ2o3vpaep/BkIS0g
	DJ1cnnl4A8wFCHkpft8AJ70Y0/T9cZu7os74ej1B0nZuXMRx6HYt2sU8Hw==
X-Google-Smtp-Source: AGHT+IHrddJW+HUJ8DTrUFy5GJDbq4qvT8aagyl4Zd+1VQHizsbl3K6x+EKoVW6pGDy/lNCzdD0Z5Q==
X-Received: by 2002:a17:903:22c1:b0:212:26e:712c with SMTP id d9443c01a7336-212026e857fmr144221565ad.26.1732026288332;
        Tue, 19 Nov 2024 06:24:48 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212389529b6sm29219115ad.236.2024.11.19.06.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 06:24:48 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 8/8] station: print client count in scan results
Date: Tue, 19 Nov 2024 06:24:30 -0800
Message-Id: <20241119142430.323074-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142430.323074-1-prestwoj@gmail.com>
References: <20241119142430.323074-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/station.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 71dc4c21..1238734f 100644
--- a/src/station.c
+++ b/src/station.c
@@ -425,7 +425,8 @@ static void station_print_scan_bss(const struct scan_bss *bss)
 		ptr += sprintf(ptr, ", snr: %d", bss->snr);
 
 	if (bss->have_utilization)
-		ptr += sprintf(ptr, ", load: %u/255", bss->utilization);
+		ptr += sprintf(ptr, ", load: %u/255, clients: %u",
+				bss->utilization, bss->sta_count);
 
 	l_debug("Processing BSS '%s' with SSID: %s, freq: %u, rank: %u, "
 			"strength: %i, data_rate: %u.%u%s",
-- 
2.34.1

