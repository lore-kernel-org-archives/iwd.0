Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D38013D8A3
	for <iwd@lists.linux.dev>; Thu,  8 Aug 2024 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138968; cv=none; b=cXYI+bWUpLBGnp2gpOBf4l8Z/f993mJ945toMIISSkSAEO0yHUSvoRLzJOqwpO3dlBz9T/AMTfCMXzDzlUOdjjpwTQzpkyfpJXVZSUSmLbxHX/as6AawycXkvFRq5fbmkX0U4NYmLJBrOSSGI+jXRZoclwygfa4UTJIDs6OM2z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138968; c=relaxed/simple;
	bh=je2lKnZk7kH3dmAL7I38N/hHJqcA5JaTsiG8voPPEK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QcvevyBVLauPpIT/L2H0hPJ3Aj40PGkEVXeSRk+sIxUjo/7P6R9ysG9MwPMNejgQa/9hrx2DDPsY+WKju5i8Y5w03SFzF4YnLEuxT56arIKFTEoKylJeuBlV9e04WWsB5PG5yW+0nvMqDaRGCyKhyWQafAmN78+wmZsPj2FmpqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7zvRfkZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7zvRfkZ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc52394c92so12100015ad.1
        for <iwd@lists.linux.dev>; Thu, 08 Aug 2024 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723138965; x=1723743765; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMW23mZ6oxjsUd082UMfzQK+uh7dCMibsbp6keuPKJ4=;
        b=g7zvRfkZJrD1UjLOzmNJ0qRbjQqIxy3cPo+68wiI3US1YQcITPwRK9tEYwbEvkqVgb
         4csPSju6Jlop0nN3T+VEspICCSuZFv8hsIKyT9kYSHpEjmGZmHedluSxN/gsJIWu6Z+c
         L9TUTLaGGTdDCyvFj0+mlKeIPLgUTW7BE0XHqDw4DiMUBzbGm9bfVmvniNrE4LzDyxhU
         gUHYReslJsMQKCHGL0maLM2R8FfsGngmFEzxOJ/Wgab5zk/gk+IkjPBElH3EURhBT94S
         Mot+Aw2kHOeO1/LrUsQHcEbE/E9R3cOHy4letCdvCMHbI4g5kE0C8QqzRHQJqYN5Clyd
         Up4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138965; x=1723743765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMW23mZ6oxjsUd082UMfzQK+uh7dCMibsbp6keuPKJ4=;
        b=A7XCW21GKBdNQQbZdyqvub9GjTInpsUXr3KgLaMg3Me7yBy4VgUi8EwFK0e7qgm8VQ
         SpCG6CrGdokn3zOkkVXnJn+6/od276ODFly0mAzpV5LlFOal4uBqkj5JJaGNqPNKiVl3
         hOHcK961zddbrUluO6sfDFGRNCPRRHG4y0PavWLNBgqdGIaevmfq+t6P5RBCtFEX7syZ
         C1/B3JzqY42ARAYdwQyDPPTyDRq5/xlWDV/tGvxITeurIZ6Mi4Ne4W5l6CiPvfFjXVrN
         GSVRoH4Y3Jh4PMf2T6Ig9sPzIFMl6csyv7/k5SxlPnxUVR6Y7lm9pBOPG2IbYvQYgqHC
         rRyw==
X-Gm-Message-State: AOJu0YylB6lQPoIY+sBRA+tjHr9EG9T0wHmdP4xFRkuYodVXPhQ/qLFm
	YzvnbjQ2dMXaFhvnuLS1X5wqUXpurkyPFk5rE7j7f5W4ZqvFuyTO+ZJK1A==
X-Google-Smtp-Source: AGHT+IH6an9OKiMWOE7M0SPFadr8K2/KUwp1W++jeH18uuka9PN7xT3LDdGq1mxTtqiQacl5ee08sg==
X-Received: by 2002:a17:903:120b:b0:1fc:6c23:8a3b with SMTP id d9443c01a7336-2009526b4c4mr28087345ad.17.1723138964724;
        Thu, 08 Aug 2024 10:42:44 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53435sm127478355ad.64.2024.08.08.10.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:42:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 07/13] doc: document BasicServiceSet API
Date: Thu,  8 Aug 2024 10:42:30 -0700
Message-Id: <20240808174236.218750-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808174236.218750-1-prestwoj@gmail.com>
References: <20240808174236.218750-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 doc/basic-service-set.txt | 10 ++++++++++
 doc/network-api.txt       |  5 +++++
 doc/station-api.txt       |  6 ++++++
 3 files changed, 21 insertions(+)
 create mode 100644 doc/basic-service-set.txt

v2:
 * Renamed properties after review

diff --git a/doc/basic-service-set.txt b/doc/basic-service-set.txt
new file mode 100644
index 00000000..f827ca02
--- /dev/null
+++ b/doc/basic-service-set.txt
@@ -0,0 +1,10 @@
+Basic service set hierarchy
+=================
+
+Service		net.connman.iwd
+Interface	net.connman.iwd.BasicServiceSet
+Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}/Xxx
+
+Properties	string Address [readonly]
+
+			MAC address of BSS
diff --git a/doc/network-api.txt b/doc/network-api.txt
index e4a34411..8bc6eea6 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -50,3 +50,8 @@ Properties	string Name [readonly]
 			corresponding to this Network.  If the network
 			is not provisioned or has not been connected to
 			before, the property is omitted.
+
+		array(object) ExtendedServiceSet [readonly]
+
+			Contains a list of paths of each individual
+			BasicServiceSet object.
diff --git a/doc/station-api.txt b/doc/station-api.txt
index 05dd137e..84f1b7bf 100644
--- a/doc/station-api.txt
+++ b/doc/station-api.txt
@@ -164,6 +164,12 @@ Properties	string State [readonly]
 			for networks.  net.connman.iwd.Network objects are
 			updated when this property goes from true to false.
 
+		object ConnectedAccessPoint [readonly, optional]
+
+			net.connman.iwd.BasicServiceSet object represeting the
+			BSS the device is currently connected to or to which
+			a connection is in progress.
+
 SignalLevelAgent hierarchy
 ==========================
 
-- 
2.34.1

