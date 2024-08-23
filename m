Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39419258E
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451828; cv=none; b=m/gE4yNNrfSILyQBU/DteiW4Kx1pKJoKplzGPDtDpZOeRPnifI2ZFO5C9/Vgye/9VTLc+jTOtlr7KIAFreHF8CZ7TaIjzxcNELW1mm5uOITIQZM0QTIrH/x4ThuKCecy25oWO5tkZOdpGRCvCfillE7b3p2+ufL2rdGVCPRQ9NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451828; c=relaxed/simple;
	bh=dS0tyOjSd4TPPSvvYfg8CAQBd6kK7xkQ5caCa/Or0ZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qe7PJZfsv+QeyfW50dAH+MJB8AbtRkmTfKWVoaHUjajewfBlYMUFQs6by+q4LaswIAfWs6xXcDwqpBrq17IiI0Us8t07XYSOAR7UGtfkXV+xcroYYNyPHN6fPZMHdpHMlvBXS2XnqtDDeoT/tBXJQ5TYOfo6mOEDx3qBq4y0FM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbbiBIG0; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbbiBIG0"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1d6f4714bso234190585a.1
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 15:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724451826; x=1725056626; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6eVTC1Aym8sF7ndRgQcB/wj5IW7I/Jj97dqCANyEsNk=;
        b=MbbiBIG0o0CHhSooDF1g2utnlIbkQV9/yjfI74wFilbbQiIZvDAfkuORqou3J4tO2p
         ba3DXkRY4GBH6MI2ugMuBGfbWzfCrmp9eVtlsQ9jq66eO0dkCNKaXqcszAZ4IPYrGcg2
         TXzcqEfY1wIfYc1ck32MpAoqxaidrvoIoiY+UkrZOZZLutFnubZ0F1dZuV2Pfwj8n+5l
         NXVUsmsHOey5om+qAivBSkIlBamlBzjvm2E8dn1Zz+ZQaOXClGRc+n4hnuyb04gWAAcE
         3t90GNb3GWa+AzQ/USHklQUZYVVCj61dAWekj0/Gd9RqarQkwN72YAMG56+HKZwQrRZj
         y/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724451826; x=1725056626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eVTC1Aym8sF7ndRgQcB/wj5IW7I/Jj97dqCANyEsNk=;
        b=pWuUx/7LFeLjKPkGuk3u+JiiV6Dbya47OJ8rOo52RvfDL64S11lofs+kfo7ec2C7Kl
         Xx/kPiGXyhokz4xGdo1rVbSAja/Ijrq7cB3CIuEGc1agyNlbhAKuviNbXmJroc2Wm72p
         OAHLGn4X8oCVwQAXgboYWGbwKj7mLlH85CMKECza1gLpbyMw66EwcZagvCxi8HgdZLii
         H245m9l86XHOt0f1dTFBHzPx1WTPbXwDr0S1vLxPqJdkV3HEsZlLgXwnDqFmENJxySIU
         kMj2LoFazM0fweJ2YtpOC72CVnTwKziOcareLGKHhaUI9d1kWcR9Y4C5Bu7W2bpYwGFS
         0ifw==
X-Gm-Message-State: AOJu0YzGDJ2MWUqcc1Im4G5+mFq2bxIISsx37rrQXw0Gpn7pkt7pg/z+
	WUF0lUWwpDtNxdpAI0+VA15IXWKD+7NSc1l13Qv8wE5MMTSOi17xW10KNg==
X-Google-Smtp-Source: AGHT+IFlXucXrk6/krEUD7rPL54Ycn5IEKM5aN5Y1yXLrftsgdCQnJsu7DLqNkm+KtkkO2PfBMhn2A==
X-Received: by 2002:a05:620a:2994:b0:79e:f878:7ffb with SMTP id af79cd13be357-7a688d2fea1mr734844885a.9.1724451825830;
        Fri, 23 Aug 2024 15:23:45 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f41f507sm218860385a.132.2024.08.23.15.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 15:23:45 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 1/8] doc: Document station Affinities property
Date: Fri, 23 Aug 2024 15:23:32 -0700
Message-Id: <20240823222339.328006-1-prestwoj@gmail.com>
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

