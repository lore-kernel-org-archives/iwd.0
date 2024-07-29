Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F82D1487C1
	for <iwd@lists.linux.dev>; Mon, 29 Jul 2024 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257061; cv=none; b=urXvzaEk/68elFU8DBCOVaJQ91xY1UgG6HBmTIshtcPHm1W9EQEHfQl9SynfUcBeTjBfLk6GCwmaUmhpxxWPN1+BSSFv8dOnDgAa72n+YUgyjDX6TUfe10Yh0pu2pqGRQxxPcSeCBJgXi9XDcWck9JK30mpJ03y6CYJE4Hx2M9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257061; c=relaxed/simple;
	bh=G/Y/HSk96c9KUFcvJUJi4rWgvQ1ijUr/fOHBtIyaX9M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JOkUdr8GKHl3sWYYD8fyU+yhdiURNiwpUR2JRQfn/JtQbSlmVZtVQxJ8mebwosml0m5jTBo2jekOzzunrgXxyYIFa4k4OZUEKaxl5QFbjqyVRHwTXVRNvy5Eg6jnLnUHBOM1Vh2vIheysS3mGgIswnPZaLRPPQc9S8Rmawa+SvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEqJK4TW; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEqJK4TW"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b5dfcfb165so18829076d6.0
        for <iwd@lists.linux.dev>; Mon, 29 Jul 2024 05:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722257059; x=1722861859; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cpwtonmqs8Ssr/b2jzuLXc+ajd8QJ2pra28el9tmM2g=;
        b=aEqJK4TWnUFuA2Bhmf/2ZtNlVwCdOLWLlfYQfPUrwTlUPlAJ5t967RiD6zsJO+8V61
         Id0ppqHzKb6D7KJ2IRamJmiy2iWh0dfJ9LxKZ8J77wum9S/UsgkbGk7HcBLOoQfTG9yM
         yB3dm5EdB7WR27JJpUqIxGDUhRJBORBhTP8qNkTBfVpAv67iXv6W5bJY1sJk1CYfIDRy
         g+FcExJCZMjuE/Q1sP5GjZauDvdKGtAPEF/SOu0OkeuULDDWLDKq/DVWBvT7DQVgCBvO
         MEylSxwP8qNniZjhg/JuEBx2IfPcMEOYxrhedfV36qpKfJY7uyEVzd0XJS9v58bV4g8S
         m9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722257059; x=1722861859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpwtonmqs8Ssr/b2jzuLXc+ajd8QJ2pra28el9tmM2g=;
        b=Zk1pu6J6BCNrH8mC7KiXg8bU2J119Cx78cnKWcTZt0s5wYwT1lYCDlcol6RGSJVvmQ
         KNXGxIiJrsgPPkA+wCW7roLWLMV52qw3EQ6qf01u/q+iPYepr21GJaYRpjDpRFX9/Hj5
         PQr4Lm/pc83kk5498OwfyR1PdJU51dW4cACttpTgptRQfSz/DXSZY1+KsdHH//P/U3TM
         tCnOhb47nQGAPRw+yL0O08E/KdC+jRBMZ4O/6Es03gSGQpjIG937P/wi0wl+L42sc9Bv
         wQ83QJkz9ZQNp4vxQtm2rKENuCm96+LEgehqIppoYpRIAj6DbDIgE7e+fX3lQF86RPV3
         VZ9g==
X-Gm-Message-State: AOJu0YwH/PkdmpzBOulyxAjaPs6hzkAqdCnrWkf1imHoT9iDXa8FsTQ4
	ESuB8WFEYO7mbDLuZdJqxOOIz3gz8B0wZagEqTKjMQhWkKLkeaDPkiMtCw==
X-Google-Smtp-Source: AGHT+IGwi6PLyyX+M/IczzB9+eOq+gUgX1ws0JgJbJgMbbER1UayBKuUKz0SUx4ncI+Z5DcqDJk98A==
X-Received: by 2002:a05:6214:29e8:b0:6b5:e51d:441d with SMTP id 6a1803df08f44-6bb55b154f5mr92553676d6.41.1722257058766;
        Mon, 29 Jul 2024 05:44:18 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8d84edsm51171266d6.14.2024.07.29.05.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:44:18 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/6] doc: Document new BSS affinity method calls
Date: Mon, 29 Jul 2024 05:44:05 -0700
Message-Id: <20240729124410.1763549-1-prestwoj@gmail.com>
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
index d9c94e01..31f43bc6 100644
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

