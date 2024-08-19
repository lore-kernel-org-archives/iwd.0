Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561916132E
	for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089923; cv=none; b=Q2vkIsAJ/fL6GFvXFchVcL9lpl4qAOXnCZjRYDoXguZIoRKWT4SzlIV038LAWmDQCnVPJogAI41vkKIHtWneWEucQCY1ADZs4pryyn/sIaHX8MNKrwTn2otM7XVxCRmzitSK00+tDMKO77kJmhxQUv0RbW0aAJLO7D4GTrm7TCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089923; c=relaxed/simple;
	bh=Z6IkhHPQnWeBp9c3xiuNWrGHPS/gLeJBla5KA88xJ5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=duwKKfG/Xm/+OM3ZRZRsF7NiLdmQuCxyhgN4TSqVJFop8pZ1Ye4lSBygWGDmmChTfBlVQPw3IxVe03epcGm3ULIY1nIudyxKisv9oKRfdhGl5vTb7cdWD4ZFTpiAt2KO/CTmgy9Z+W88cdVN8cTo9pfreHgld1FqGZij315JpyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g54Rd0xm; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g54Rd0xm"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5daa4f8f1c4so1860936eaf.2
        for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724089920; x=1724694720; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qXLmf3Gv32nod+sT07WCwPlTlNJqI38EpO2w78hZtGo=;
        b=g54Rd0xmRO+/6GL/BvmM5iRM9jKvFv9KW+3Diw7fVnVDZorTTr1zu12seVjzdVW39H
         1eZ1/F9F6v3klQwmnblyGkDd3ufpgfL6ji+7GahlFWYf7vRxlTaF3vpJMWbYM1RMbM78
         DAYZG7amDTPWHbwrmoH5aO5o6vBrbGls+N82B/88DIQJ2dHZjuXdyljDjjEHypqJimNV
         Wu/vAgU4/V+fXukgUaiunqqjgiW7IFf72YI4SqrcyEYXiAKQWbfoQ9eUyP4A5h/PjlQ1
         K87QHBl0+eAZTK7TJFITcEhZc8GOA958p2nJzWn9yjFcWwX/bp4WEaCKYS8Y3i5gFfLd
         Wf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724089920; x=1724694720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXLmf3Gv32nod+sT07WCwPlTlNJqI38EpO2w78hZtGo=;
        b=TianMEwKQ3S8LrdVEBdLH+4HbwUwZeRuGG6qyPJZDz8MReAZjjt1w0IhUHBP+mZXND
         0XsalBNXZjA+VS7UEUzfeI321ueU2E2O86XUP0MUQeFfrnqfzSe5Lypzmrh2hIy79z1K
         xNIXNBTC6Bq5+onPdkhAKv5ez1aNn3Ae/g2e+XrTvgAXgB1+GOWyUcgtG9HVl6REoL7X
         +4xi8olMgXyMPgWyyzzUQZK2Wlw9RN6WlJfd9AAdx1eAF+04gUHURpi4y551SpkglQpl
         5OOL6HDDXl1HBWv4fci4mbw0G5zJ9Gu0EVVkgeWqZxu8tQnOyilydvdotkmEFEIeUn3T
         cnaw==
X-Gm-Message-State: AOJu0YyLhY4CCam8GOGMSa59xu/UDPixyvbYMQR51EDzd1HG9TlSwD4e
	4taAmLSVHIR+gew6nBMFfQM+JJzTnYC/mng0Sj3ej+euxlc+KzQ1XRhQMA==
X-Google-Smtp-Source: AGHT+IHyna3QlJkj7jfNzL3jgTtkVcMw1E1ygaDfGOmWGejhN5hZLhwGu3oLiQ5gIUvLrd/vOxtowQ==
X-Received: by 2002:a05:6358:7594:b0:1a5:4b74:2214 with SMTP id e5c5f4694b2df-1b39312b07emr1682178155d.3.1724089920286;
        Mon, 19 Aug 2024 10:52:00 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e5a1csm451854685a.74.2024.08.19.10.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:51:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/8] doc: Document station Affinities property
Date: Mon, 19 Aug 2024 10:51:44 -0700
Message-Id: <20240819175151.1310546-1-prestwoj@gmail.com>
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

diff --git a/doc/station-api.txt b/doc/station-api.txt
index 84f1b7bf..0bd4a352 100644
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
+			[General].CriticalRoamThreshold{_5GHz} at which point
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

