Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4BE1ABEA7
	for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724873076; cv=none; b=KroxowpuuDBQXJr6mDJuCsmZbJ+iDMnavE/UEj233ZV+5glXl3NdhjpvyGwTGWa8eDEgPYZ/eO7B7zDWnEbwBAf6HGl5phZsxvoWK3UJEEvBsuxPfERkIUSRs/Lg/19G8oD+Of+iQ2QFBwEE7rve/DhrXnc+uJLu7FECkTA24Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724873076; c=relaxed/simple;
	bh=6sPDRJOD0zxcNzux6fRSpLWWbyFPNTzxv1nmN/eSBX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IxTeh3OawWwKo8eqIVq7LrSOAgEl1mYp+PIE/b/+i49awYfE2w0uZ4IRvH7BFZngUcbs8i1/QpN1OHtSxTyeefEzAdF9Zd0wk29JiXTBYosbN9uz3iWfFIFOc8Xbg2yzrnyMCgDgikfuEoQJDYIIP89lLtLVbGWtoe9JI5uZiQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Id7GYZNQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Id7GYZNQ"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7141285db14so6073670b3a.1
        for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724873074; x=1725477874; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tio7v8U3brCXEVpg4JvgYJu9CPfPEeJf/Lf1dRgQjuU=;
        b=Id7GYZNQM9lJVLaTaHIqhyuAWII8fxxdWDUFkOoMikSYcETa9a1MYSvrNdGrq1jACl
         pFjQo2Bolz79/z1aGimP1I8m28hUSHOOLmD0DU6f+sgvO2OXVLgv/PhzXeK6oJMy7Ebl
         Np7E35hrY2MIBZ45TKTuJWl+vgXoHQGQmLS7MsX7to4svPnCJST9Fw6T+b2v4klspgzR
         OPl11S/VoTvCqW8uMKhEf6PqfdU5BASfo25BNU1AClyMvlaMzjbW5LPjQuTuYExxTqO2
         YWyrpp2Sk5yz5NqdpRKNT2dy5XFjDXm/3D9VAT71xcPHFG+70gCXHr6caUYrRdkHLuMN
         luLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724873074; x=1725477874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tio7v8U3brCXEVpg4JvgYJu9CPfPEeJf/Lf1dRgQjuU=;
        b=LHHVZ/KrwxSpRsfcn7ksYL0+lI6Cm8gJM9BwccmbD4NI5Hzk3Fcr+9H5R0HIT20CHp
         s+oMCHDldCxql9Pyd90F3fcPBpMH8C9lM179KtCYZyhH0fLcqFn7v+8bjiiXCoLb5/Px
         eigk4tNPoO7kxuJMXtmyN0OVFu/+bPmi9vQStQZc8jrokRMeGgrFBxB6dC+nhhWXISaJ
         xTJPXEgJfFzDTdy28EL1oS0BVxSc37cdv3Z00k4VE6Da/t7Oi8Ryo3zT40BctDzlNdao
         Mc8uCjpxPhUX67WzacKHM1rrWlRWKhz/il3Tlkp8okeRHmeoYT69/q1TkVVw6AUxMx3S
         dAtQ==
X-Gm-Message-State: AOJu0YwahXZ/rL+ifI2mCAxMrJJQ5uSNFn9HB1fQbUWyhqXVeb6GYIg9
	p6I4IaI6uqkziqiGymfWDvA3Bypq2TaljTL0wDAQ2vdb71ZtogoXmELKtQ==
X-Google-Smtp-Source: AGHT+IGN3nd3qoEf2obHGzQMHVIXaRD0OR9wxz54GXq0Pt8Re59XghN5krTLY3F0+s4yF5tWUl35cQ==
X-Received: by 2002:a05:6a00:3911:b0:70d:2693:d215 with SMTP id d2e1a72fcca58-715dfb77efdmr682228b3a.16.1724873074141;
        Wed, 28 Aug 2024 12:24:34 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm11081635a12.16.2024.08.28.12.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 12:24:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 1/6] doc: Document station Affinities property
Date: Wed, 28 Aug 2024 12:24:23 -0700
Message-Id: <20240828192428.902761-1-prestwoj@gmail.com>
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
index 0b2878b8..9dc0fe0c 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -133,6 +133,22 @@ The group ``[General]`` contains general settings.
        This value can be used to control how aggressively **iwd** roams when
        connected to a 5GHz access point.
 
+   * - CriticalRoamThreshold
+     - Value: rssi dBm value, from -100 to -1, default: **-80**
+
+       The threshold (for 2.4GHz) at which IWD will roam regardless of the
+       affinity set to the current BSS. If the connected BSS has affinity
+       (set in Station's Affinities list) the roam threshold will be lowed to
+       this value and IWD will not attempt to roam (or roam scan) until either
+       the affinity is cleared, or the signal drops below this threshold.
+
+
+   * - CriticalRoamThreshold5G
+     - Value: rssi dBm value, from -100 to -1, default: **-82**
+
+       This has the same effect as ``CriticalRoamThreshold``, but for the 5GHz
+       band.
+
    * - RoamRetryInterval
      - Value: unsigned int value in seconds (default: **60**)
 
-- 
2.34.1

