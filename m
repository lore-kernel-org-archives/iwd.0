Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BF813BAF1
	for <iwd@lists.linux.dev>; Tue, 23 Jul 2024 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745949; cv=none; b=bdDOVO918VQ50W6w5aXzA3jgqJ7POWK951xSSy5wB69/nTmUx/axrc0ve8e44tD7LJw/eo4f77i9o7XHy6kLveJ5LFWSKxxfOtilLqseu+51aPNj9uMuh7uXLyyn58uA2rdkeb6xo2TIskbW5bxH6C7SornsB2v2Gy92RS4esUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745949; c=relaxed/simple;
	bh=8Ls0klZhqbFaiciC/Vypmg0MAvKaC+fQCqwqltt7tCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rjs2DKpuSpo9Kk2MvHm0XRNcTxDal8QfL2TxwXlU9tprW3koYkJn5/+I4OAnXUJFuLp9bj0iyoLp/p2ESvK3XFP/VWoiVGm9nvYv57nUPtXrpC453UWsRv3LLUTJvfSzxzXoBPaBE8rwlg4tO+x7csl2icomLaUGtCyR6qegpdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iv/qEoew; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv/qEoew"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b798e07246so40616186d6.2
        for <iwd@lists.linux.dev>; Tue, 23 Jul 2024 07:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721745947; x=1722350747; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jeWJ91ooDAFtP/GFcg8A/hkuvWyagdO69Ca0pK7pTCs=;
        b=iv/qEoewZHsXfo2Z01hJYH5WAeVMcFYcfQjApKDMNFBU4F1b+W6LwwaP/tj7MsFAoU
         RBX23FYB1KnYXXWPAZ8VwpYYOc8nKmN4+dWlfuUOKIT/TDhev9xcjqQ4COItY7bH6Kdq
         kLitAhJ5cF1IwzE1dDSF8kwzf6g6TAV1Sfja5bSrDc5K7cPuxOiEMmudHh5b2wToTwHW
         83Lpyx+C/isXFYuB61alQrRLL3CfCuGCSEbfmknn22v6yQveK4xOKJJx/SUmLLMCq4tX
         4DJjShKc4NwNfe0oNFeNIqat7bjxY76RjvAayyHN/j9LdXfcIPd5rOc/L4MMFVaw6I0B
         xGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745947; x=1722350747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeWJ91ooDAFtP/GFcg8A/hkuvWyagdO69Ca0pK7pTCs=;
        b=fM0DUTC9PuPIYPiy5RFlfAMzB8pHknUGjo51DybR6RkUC035/GF+iy0DiZeu+oksNI
         JdRWkTekIHUBAuK/f/b8KXcch24ERqFw73YFeTr9aYoquThzHRJeSk1TKtLCFIWRGshK
         8BFJiZLfoRVIpYvSP5oOGblTjPMah4MnWC+9rSAhDGR9Vm+kQ0CSgLRBSfZmGKD1x8xT
         OJM+sAz2H+SnYVQfNOAhlbR72Jkr29cok6mj9XEwgXaAVh3WD+OBJE66HJHCSRaHMqDO
         KpSydNZGRuUj7RBQjKM2I20bMK1OyPqOzlqtT03/AUuIvFSEyw1KD+qe8VKZpoNqP0ZG
         iCxw==
X-Gm-Message-State: AOJu0Yz4Mn5W/7jiqj8y+Ig1DMRq8hHS2TJ6mxG8Uuy5mwDo4GVFUIYQ
	gthrWUqdGRFMdgkSMCdXKiJQSzAhk70d+o1tX7L6GeLHx3OdvQCCvA8UQg==
X-Google-Smtp-Source: AGHT+IEk0Of4fe7/zCeGSzb5i5w10416jlsFGl5+Saq8gG8hOCPV9/FVRItOVNQputZ66EyoPsJGNQ==
X-Received: by 2002:a05:6214:4018:b0:6b5:e202:bd78 with SMTP id 6a1803df08f44-6b95a74df3amr128430716d6.44.1721745946664;
        Tue, 23 Jul 2024 07:45:46 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7acaf3bc3sm48374386d6.125.2024.07.23.07.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:45:46 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC] doc: Document new BSS affinity method calls
Date: Tue, 23 Jul 2024 07:45:40 -0700
Message-Id: <20240723144540.985197-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This documents new DBus methods that expose a bit more control to how
IWD roams. The new methods are:

SetConnectedBssAffinity()
UnsetConnectedBssAffinity()

Setting the affinity on the connected BSS effectively "locks" IWD to
that BSS (except at critical RSSI levels, explained below). This can
be useful for clients that have access to more information about the
environment than IWD. For example, if a client is stationary there
is likely no point in trying to roam until it has moved elsewhere.

A new main.conf option would also be added:

[General].CriticalRoamThreshold

This would be the new roam threshold set after
SetConnectedBssAffinity() is called. If the RSSI continues to drop
below this level IWD would (attempt to) roam.
---
 doc/station-api.txt | 22 ++++++++++++++++++++++
 src/iwd.config.rst  |  8 ++++++++
 2 files changed, 30 insertions(+)

diff --git a/doc/station-api.txt b/doc/station-api.txt
index 05dd137e..3dc2376b 100644
--- a/doc/station-api.txt
+++ b/doc/station-api.txt
@@ -135,6 +135,28 @@ Methods		void Scan()
 			Possible Errors: [service].Error.InvalidArguments
 					 [service].Error.NotFound
 
+		void SetConnectedBssAffinity()
+
+			Sets a high affinity/preference to the currently
+			connected BSS. Specifically, calling this will reduce
+			the roam threshold down to a critical level set by
+			[General].CriticalRoamThreshold. This effectively locks
+			the client onto the current BSS unless the signal
+			quality becomes extremely poor.
+
+			If IWD roams or disconnects the affinity will be reset.
+
+			Possible Errors: net.connman.iwd.NotConnected
+
+		void UnsetConnectedBssAffinity()
+
+			Unset a prior call to SetConnectedBssAffinity(). This
+			moves the roaming threshold back up to the default level
+			(RoamThreshold/RoamThreshold5GHz).
+
+			Possible Errors: net.connman.iwd.NotConnected
+					 net.connman.iwd.NotConfigured
+
 Properties	string State [readonly]
 
 			Reflects the general network connection state.  One of:
diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index e31b1ffa..232337ae 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -130,6 +130,14 @@ The group ``[General]`` contains general settings.
        This value can be used to control how aggressively **iwd** roams when
        connected to a 5GHz access point.
 
+   * - CriticalRoamThreshold
+     - Value: rssi dBm value, from -100 to 1, default: **-82**
+
+       The threshold at which IWD will roam regardless of the affinity set to
+       the current BSS. This is only used if the SetConnectedBssAffinity() DBus
+       method is called, at which point this value becomes the new roam
+       threshold.
+
    * - RoamRetryInterval
      - Value: unsigned int value in seconds (default: **60**)
 
-- 
2.34.1

