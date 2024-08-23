Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C518BB83
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436018; cv=none; b=o05dSSoodz6Sz8VY511v/CpVgeBn/wkaAbWUoEKkLLwHcZFknN50+mUaZ9bouQDuV62SvL100Ivq0o3oUpkGQ8eOVIryIb9QYrNnIs/2zDJP+8JpA+Q+tXUdX/sdTNspkqNN0AyV77u3kGN38E+UTn7VBr9xnsL5YVYalXY+lmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436018; c=relaxed/simple;
	bh=n+J0VgqPpR4EeYOrZu01+32SQDmrML3IpcCjqcqRtJI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iAOqMxtW70BGCz0Jt2EBhYXlIEa5EDSKDrYHsYTSl5JiGY3tvHBa4nmhuA2OGSsq0+N1MYBJtI6IiKE3w1m5ETBFfJ52k+6DoDc0RxnPDIbhtMdpj7pGDv6s2WTeufstmx34jfWK2bZ7LtDC9iX9UiGNZIeNfrQxh30mG8Ento8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+mXmm6O; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+mXmm6O"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44ff99fcd42so12889431cf.0
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 11:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724436016; x=1725040816; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9aFfc/G92BSYc+ccc7FukmxlIFRNIq41Om4fmsWhHOE=;
        b=h+mXmm6Oq60mFg2F/jh886U7CocRD5zSpUIZ0uDtHwP1R49ozmvX/7XEA8e9oBJg1H
         LW4ZSs4pWeV09KTdAbrF2ovp6Pc/WXmoP16QxVU0exT9ngfG8lkty9WKrpJXiXVBn4kE
         KJtfCwU5palrHs3TVAYHQzJDJ0hAOAED/3koHVh4aw2Qzj8M+g29JmFVS6dI6hO0gtI4
         fIiKC0eDIKX7iRN67l1h+8TXYqtgnalrYrP121TqOJPRsMdZX+IIsRERwG0enP4l07eB
         B3SulAazwFuaaMsTsUblTnaz8Yf8J0SkUBQmFUy2CL+t6SYUzTgDjzCPZm62iVNTy/vY
         Nsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724436016; x=1725040816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9aFfc/G92BSYc+ccc7FukmxlIFRNIq41Om4fmsWhHOE=;
        b=VusdKMY+fQZLYrPCEr/kFS/uKm39v5w7H0Atfy3pm0X50hX1hTMHxUZcNip2W59GI1
         paCzxyKS6tbqf4bDKvI2fXKlaJHeZfKL2Jl7h6+Eme3Y0T8LJ4NPIMJQZi0afYVnr/AC
         hAfAQyqIVm5IdKDwLbrn2YPfEn14JSdglfv3Ie6seDL8vIhN0epl7I18wS5brkUHBfpW
         6e3+k4EbiE/mMNFRWv6JHMfWpvsWh+K5d3S/E+Php4zFkAuh3hU+HnhVaNE/tmWb0lEb
         jFst2nYMXCjcbXyneTamcKejzys1FyTSASo7KhJ5NzUnCcOOKk+8WeGTvOa4vQ36t+tl
         0IKg==
X-Gm-Message-State: AOJu0YyL6qohZpaNQpdONVq5p3Ompl25MfN7Btt+tGMUEKC9DDHxtq71
	/ac+I/m21yOVGR85IuMNTN98KKwOTA7BL0VRYd/75d746pSPkMz7iNZgmg==
X-Google-Smtp-Source: AGHT+IFLNh2JTAgQTK7VuTjRfWW4212YnCCnIyzMXPKSvfxrSPk8TqvD+aCMV1SN56Yl06Rw+UYVBQ==
X-Received: by 2002:a05:622a:6091:b0:453:767a:183b with SMTP id d75a77b69052e-4550967870bmr26144801cf.30.1724436015815;
        Fri, 23 Aug 2024 11:00:15 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe0f0507sm19683131cf.47.2024.08.23.11.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:00:15 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/8] doc: Document station Affinities property
Date: Fri, 23 Aug 2024 10:59:59 -0700
Message-Id: <20240823180006.317353-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This documents new DBus property that expose a bit more control to
how IWD roams.

Setting the affinity on the connected BSS effectively "locks" IWD to
that BSS (except at critical RSSI levels, explained below). This can
be useful for clients that have access to more information about the
environment than IWD. For example, if a client is stationary there
is likely no point in trying to roam until it has moved elsewhere.

A new main.conf option would also be added:

[General].CriticalRoamThreshold

This would be the new roam threshold set if the currently connected
BSS is in the Affinities list. If the RSSI continues to drop below
this level IWD will still attempt to roam.
---
 doc/station-api.txt | 17 +++++++++++++++++
 src/iwd.config.rst  | 16 ++++++++++++++++
 2 files changed, 33 insertions(+)

v3:
 * Fixed typo

diff --git a/doc/station-api.txt b/doc/station-api.txt
index 84f1b7bf..707c6834 100644
--- a/doc/station-api.txt
+++ b/doc/station-api.txt
@@ -170,6 +170,23 @@ Properties	string State [readonly]
 			BSS the device is currently connected to or to which
 			a connection is in progress.
 
+		ao Affinities [optional] [experimental]
+
+			Array of net.connman.iwd.BasicServiceSet object paths
+			that will be treated with higher affinity compared to
+			other BSS's. Currently the only allowed value to be
+			set in this array is the path to the currently connected
+			BasicServiceSet object, i.e.
+			Station.ConnectedAccessPoint.
+
+			Setting the affinity will lower the roaming threshold,
+			effectively locking IWD to the current BSS unless the
+			RSSI drops below the critical threshold set by
+			[General].CriticalRoamThreshold{5G} at which point
+			IWD will proceed with normal roaming behavior.
+
+			This property is cleared on roams/disconnections.
+
 SignalLevelAgent hierarchy
 ==========================
 
diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index d9c94e01..2d1f6dcd 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -130,6 +130,22 @@ The group ``[General]`` contains general settings.
        This value can be used to control how aggressively **iwd** roams when
        connected to a 5GHz access point.
 
+   * - CriticalRoamThreshold
+     - Value: rssi dBm value, from -100 to 1, default: **-80**
+
+       The threshold (for 2.4GHz) at which IWD will roam regardless of the
+       affinity set to the current BSS. If the connected BSS has affinity
+       (set in Station's Affinities list) the roam threshold will be lowed to
+       this value and IWD will not attempt to roam (or roam scan) until either
+       the affinity is cleared, or the signal drops below this threshold.
+
+
+   * - CriticalRoamThreshold5G
+     - Value: rssi dBm value, from -100 to 1, default: **-82**
+
+       This has the same effect as ``CriticalRoamThreshold``, but for the 5GHz
+       band.
+
    * - RoamRetryInterval
      - Value: unsigned int value in seconds (default: **60**)
 
-- 
2.34.1

