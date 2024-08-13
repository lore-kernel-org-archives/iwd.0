Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6145C2AF0D
	for <iwd@lists.linux.dev>; Tue, 13 Aug 2024 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564610; cv=none; b=mAorqufKfGE+nzcqTVIFVL371sfOa5Fq6UYJGxdUkShmel4b+e2vZVij5s+izUZQ92KwziwiLfdccRR04uFDb8MhlmouF4RDBbb+ZnlUaL1iZvCJ2qyPxTv1Zt0zjTW6BCHaiXmZ+6RSMMaj3qpaJRIF6ObtQjzEjQiRliJ1bCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564610; c=relaxed/simple;
	bh=byiZLcV6pA6id6Gy+LKn5EwNdxbROpBsMc+Yi3++VNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IODIbNWkgUQjZK+4N1zSSgrlpijEBqXLuOp0a7Kgehv9RHM8IUNyzzGcDyczrg1EHfOho/cxoZI5xpu+reA4CQNLigocCK5DCU4pZf2dipKAZRRE3OC3GUXZTdPiSkC3uuhGyt1rFIaqLDPxkL85FECWQcYx1dty1Y3HILdU+B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMqbSXNY; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMqbSXNY"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b7af49e815so33538606d6.0
        for <iwd@lists.linux.dev>; Tue, 13 Aug 2024 08:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723564608; x=1724169408; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7V8k437GCDQwUFghUh4TPRC2xNSXCkrUBYe4l/5vTxo=;
        b=mMqbSXNYL22mjWwhqHksL2ic9b+XWGz/gc43pa/c4kVUtTywsLgM8Rz0LZ5paAhcU6
         gwG1oAJFMHTHCMOubC7FcV88z9HdmjRmqzBOzUWicr5gaBYDlT//s46KSOo3VsTIcVLP
         gnLb99lw9hcSXK/0FroJMuu0PvZIyGdrfvu7T6fsDFqV6bsddxi9l3UD3W9DMn3bLI68
         FQrTuVkOhgWFBswZthyD6aXmkFezVdtXrroDGOWCv9DJHPEptLiif8eS84vXwNd4jOac
         yWxYbNJmnUkaN4Kp7oFgD3D/LKbpE1+Ubp4NtO/2FJCiVBb0OAz8znii8Ooy7GPuWyMu
         eNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564608; x=1724169408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7V8k437GCDQwUFghUh4TPRC2xNSXCkrUBYe4l/5vTxo=;
        b=Wu7MrAGxA2gdrNwSJe+N8OhgQbCZh7rkE4FCi+Mq9K4qfDWxraED++HVda8ilxk/sF
         fk1kJymWtA7BoP7LCQppH5Ssr2SsCbsVmDAxuH1jjtL/yM1HzJnbfYzDZJtr3Qdd5ekU
         uflx4avBj++ZnrvZtb/0UAGTf16hLS186Zy0R8LqR64C0YZcZirdgOoNdrZqHho06K81
         y16VC9tfj2SdhHDxR3hrmgAQ8Eybrq6EAmlijtUXsrg5tPMnzx27fMs2NtJ+ExExHHt4
         wyppAB3q8pErKnWJz6oEFFoC+V4meVyQS9CAoVxUcQKnaXA98okaS4z4ZIROHaEO77rc
         a6rg==
X-Gm-Message-State: AOJu0YyUzpba3aVolAaNkta5jtwF+aAZtvCkrzmLgsqeu5DbUu7dKHz3
	vf8u1wslm2hprPSBX2Uuco2hsZgM09d6XaVHsGaXz0mjBS2ZlFjd9TmQ6Q==
X-Google-Smtp-Source: AGHT+IFs7CcRWhBgTY4hxsz2kM/AaNxCt1c6EXZmpuOhdgCP6jdV7ttNzbOH5NtCZuvi5e1msvX8dA==
X-Received: by 2002:a05:6214:2f8f:b0:6b4:ff80:ee0e with SMTP id 6a1803df08f44-6bf4f44398fmr54783856d6.0.1723564607953;
        Tue, 13 Aug 2024 08:56:47 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82ca2024sm35825706d6.72.2024.08.13.08.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:56:47 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/9] doc: Document station Affinities property
Date: Tue, 13 Aug 2024 08:56:30 -0700
Message-Id: <20240813155638.74987-1-prestwoj@gmail.com>
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

Setting the affinity on a BSS (regardless if the connected BSS) will
also cause a modified ranking factor to be applied to the BSS. This
could be used to push IWD to certain BSS's over others. Similar to
above, the affinity ranking factor for a BSS will only be applied if
that BSS's signal is above the crtical roaming threshold.

A new main.conf option would also be added:

[General].CriticalRoamThreshold

This would be the new roam threshold set if the currently connected
BSS is in the Affinities list. If the RSSI continues to drop below
this level IWD will still attempt to roam.
---
 doc/station-api.txt | 19 +++++++++++++++++++
 src/iwd.config.rst  | 20 ++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/doc/station-api.txt b/doc/station-api.txt
index 84f1b7bf..c22c57d4 100644
--- a/doc/station-api.txt
+++ b/doc/station-api.txt
@@ -170,6 +170,25 @@ Properties	string State [readonly]
 			BSS the device is currently connected to or to which
 			a connection is in progress.
 
+		ao Affinities [optional]
+
+			Array of net.connman.iwd.BasicServiceSet object paths
+			that will be treated with higher affinity compared to
+			other BSS's. The affinity comes into play in two
+			scenarios:
+
+			1. If the connected BSS is in the Affinities list the
+			   roaming threshold will be lowered to loosly lock IWD
+			   to its current BSS. This prevents IWD from roaming
+			   unless the signal drops below the critical threshold
+			   (i.e. main.conf: [General].CriticalRoamThreshold).
+
+			2. A ranking factor will be applied to all BSS in the
+			   Affinities list while choosing a roaming candidate.
+			   The only exception here is if the BSS's signal
+			   is below the critical roaming threshold.
+			   (i.e. main.conf: [General].CriticalRoamTreshold)
+
 SignalLevelAgent hierarchy
 ==========================
 
diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index d9c94e01..7221c149 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -130,6 +130,26 @@ The group ``[General]`` contains general settings.
        This value can be used to control how aggressively **iwd** roams when
        connected to a 5GHz access point.
 
+   * - CriticalRoamThreshold
+     - Value: rssi dBm value, from -100 to 1, default: **-80**
+
+       The threshold (for 2.4GHz) at which IWD will roam regardless of the
+       affinity set to the current BSS. This is used in two ways:
+
+       1. If the connected BSS has affinity (set in Station's Affinities list)
+          the roam threshold will be lowed to this value and IWD will not
+          attempt to roam (or roam scan) until either the affinity is cleared,
+          or the signal drops below this threshold.
+
+       2. The affinity ranking factor will not be appled if the BSS's signal is
+          below this threshold.
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

