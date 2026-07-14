Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39243F4845
	for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 22:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069458; cv=none; b=gpkC9/fjgivzODxKMEh4QcxLBU6LrXqQt5keRP1DPDxyWjlMKxR6i9tu5NNPIaamsVcDk2KavG16jOyTzuY9BApHVbn04SWnmZrU7O3miZnNvNbz+hNGUADDtqjtv65hf4gAe79nXbA3mxCPJ83Xz+/yAU/vAYOUg2v8xN/3Rrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069458; c=relaxed/simple;
	bh=HYrM5caICRUX+2rNRet/5Kgts34ZKqBnFlZMkzVitbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/PxIBpa9FqTrGE/dbJ7au/FjA6PyzkjF1i9foNcmK+Q3m3xM3ZvDfOT9c/zQP005KtinPzFnrAs0uwDBa9qz/ratHjA1yi9KQu2teobRsY7hHMdwJzwZiyVeUr5Cc0XZEYl/zyxAhKDi1Hdcp6rnJ6h2BXfZJIYsWiCQyD1Fhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjSWzfgO; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjSWzfgO"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aea0fff535so1601744e87.3
        for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 15:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784069455; x=1784674255; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PGfxpV0Aew9w4hKnbRVNd3BNYl0tMtQ8gNMKY988Zw0=;
        b=QjSWzfgOubsBooGEORpkWlF+29xCLgYaiILRiekF0G4RbYGM+HL+oiB8mWA3P2Qtpw
         6XzU1PbX7FlebGBkX0SuwranHmlH5FLAbpNeI9mAzYTyOPGzZ2pdqFYcYNXYqkRSxWDc
         XjnIPhtzAlZAT+BmdcCU2VKUeRPi7sT/HzSKrrtp+3oyrtWwaMbnpvJg9vO27eBbgJ93
         qyaCAnVMsDKJmm/mat3n+ZF+1OfCG5Nu1gWr3VQRwdEcELylkqkt1O8PnqojBVtvZQqC
         SszIy4dIWRtl257oXSarSG5OiGCoG0n0CRFG6NCb4XbCYHmRygol5ld++JpNnWR47WfX
         3Mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069455; x=1784674255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PGfxpV0Aew9w4hKnbRVNd3BNYl0tMtQ8gNMKY988Zw0=;
        b=j2L6zdcsM8KKxKUgTw5pwUwIbGm4LMS0bjDftpaeKRVQyBcloozkPgUCHQZhKhCjqN
         BVeYfZKxZ3GKAtV8bD1wzD2Eqe7xULiyaEYOUO9fbOEWAdQ+GPm9PVaZwl0z6MJ7bdnl
         geUHEEjND15pX/SiAPOtbE2V0yMf6274zdYkfjFoCIFqqTI8teU9VP4Csy0r61KseKZS
         JArkBSXLzuXICJTC3k4a8LLIKYV4XEasaRXS2obMeSVTrPjLMt5O0WyqPvrxAwSr3kx5
         fJMIq3wL/fhI3ncwgAuN9oadQtsnL8ykwPyBiqe8GOISYqZ8OcEFD6+cWWhcQr+kXmic
         DQdw==
X-Gm-Message-State: AOJu0YyLUZLv/V4fy2qMlatrS5yNXt6Pi9CD8j5sWUnkmE6DVkiAkmA1
	qO+mwssSApPLFTok2hs1snQEeknivrgHe6OoMiU6fyBOyounCBCWdd74/gRBSWRkMVg=
X-Gm-Gg: AfdE7cmzCkTkFOsFZDubHWVJh7+EL+vt+Gj1u0Z8X/C6a0lXLnATWS9bnNr6FoIjAFY
	MfliBruFBoKJHxYBuVO3v2Hgo2ALBU5XwWVDhs8NPptoI1uLf69IYnPGhdPu/q1Tkchsx4GEfli
	KdTOugDCVNoval+rS1KMwv6aw+IZ2Uv+y5ehTRT9/KQJFOE8xmYKAwb+/f1mbHZIUVXVm3Aa3Qv
	XQBRCpqfDB1Tp2BepM5LI0SeHEBWVkni+gTxZ2qZjbd9VvY3vvQGmMAj29D7m0Cacr1B/MnKMvn
	KL3pkvX+BZGZ2na0t/+ji84yXimIzco0cBN+LLo6V3bY+krFEN8O8BAraEI+aqEOopyAxcqDvVK
	phTPxM3QIy3NxQ9mCdtSjlXtrSV6A4rlhRvVcg2ime5vkx9qyd2tfSrnbqaQw8fo0LXDxf3j8U3
	oqda90c8Z4ZBKI0IH52D4=
X-Received: by 2002:ac2:457a:0:b0:5ae:bf95:38ec with SMTP id 2adb3069b0e04-5b0236bdcd3mr2397298e87.60.1784069454867;
        Tue, 14 Jul 2026 15:50:54 -0700 (PDT)
Received: from ultra-pc (s3.2dsites.ru. [188.187.190.12])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca9ddf0sm3791060e87.50.2026.07.14.15.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:50:54 -0700 (PDT)
From: Aleksman4o <aleksman4o@gmail.com>
To: iwd@lists.linux.dev
Cc: Aleks Man <aleksman4o@gmail.com>,
	prestwoj@gmail.com
Subject: [PATCH v3 2/3] doc: document BasicServiceSet RSN property
Date: Wed, 15 Jul 2026 01:48:48 +0300
Message-ID: <c7a98e94a67f06fef12078249983aba962e5cc94.1784069194.git.aleksman4o@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784069194.git.aleksman4o@gmail.com>
References: <cover.1784062938.git.aleksman4o@gmail.com> <cover.1784069194.git.aleksman4o@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleks Man <aleksman4o@gmail.com>

Describe the optional RSN dictionary and its KeyMgmt, Pairwise, and
Group entries.
---
 doc/basic-service-set.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/doc/basic-service-set.txt b/doc/basic-service-set.txt
index f827ca02..b4f2486f 100644
--- a/doc/basic-service-set.txt
+++ b/doc/basic-service-set.txt
@@ -8,3 +8,26 @@ Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}/Xxx
 Properties	string Address [readonly]
 
 			MAC address of BSS
+
+		dict RSN [readonly, optional]
+
+			Security capabilities advertised in the RSN information
+			element. The dictionary contains the following entries:
+
+			array(string) KeyMgmt
+
+				Key management suites. Values use the same names as
+				the wpa_supplicant D-Bus BSS.RSN property, such as
+				"wpa-psk", "wpa-ft-psk", "sae", "ft-sae",
+				"wpa-eap", and "owe".
+
+			array(string) Pairwise
+
+				Pairwise ciphers. Possible values are "tkip",
+				"ccmp", "gcmp", "ccmp-256", and "gcmp-256".
+
+			string Group
+
+				Group cipher. Possible values are "wep40", "wep104",
+				"tkip", "ccmp", "gcmp", "ccmp-256", and
+				"gcmp-256".
-- 
2.55.0

