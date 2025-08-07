Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA5E218AAD
	for <iwd@lists.linux.dev>; Thu,  7 Aug 2025 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754557229; cv=none; b=eyd+kpV4l7cJNBTZlC4FJr1xog106su/CIW3uGv15r/KvnQWu/x3cQe3EsYW/N/09ACtOrmHL+HWhRkV7ClzaF6tN0bk/RA3aO2gmWwCsyPnFCr0Q4rUqKmqEXXi+VRqLY9f8JEmMyL4IawF4baBYXdhEjAcMJD4LDQseJfnYQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754557229; c=relaxed/simple;
	bh=SF4SAr4Nj5fdEeZVpgJp/y2ZKXxk8JnHdIXeJPJtHLw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UWoenPN7D0++rIplvj6ZhQCzhtYNIsvx/qBPMqANNJWz/JGfW4CcnTHLSb+kvA29sRDZwt5mgi/caFcZAn5GB1QDI9SLSHfuZ6/ky3BRlZzkDPcuYJgmB3S/ZPQLi6YKrBuUg4q8ZBXaulym1S2acWBZyQgYEn35ADfoRfYgi2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=Uup/Ofnu; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="Uup/Ofnu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1754557228; x=1786093228;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SF4SAr4Nj5fdEeZVpgJp/y2ZKXxk8JnHdIXeJPJtHLw=;
  b=Uup/Ofnu45gj5r96bf7/59ZC3P657skfJpAIHm/ZVDqQzpj9qB+D/BTA
   iXY/WApWBidOJQ/Wc8OZCkV8OGXrSp/O8IrITmaOt40B4nt//vw+mISPK
   ShT6+CnNm+OGldRx8EPpsOTavWrRY5S7rH3UxGsf/iCiJLM2srHdxbIBB
   g=;
X-CSE-ConnectionGUID: kn6HU8GLQ+W35Lg5EsaX4Q==
X-CSE-MsgGUID: 6NZi2ejUSUKNuhh59yuGeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="93957061"
X-IronPort-AV: E=Sophos;i="6.17,271,1747692000"; 
   d="scan'208";a="93957061"
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 10:59:16 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Thu, 7 Aug
 2025 10:59:15 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 10:59:14 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <iwd@lists.linux.dev>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH] doc: add STA inactive and connected time duration info to diagnostics
Date: Thu, 7 Aug 2025 14:28:57 +0530
Message-ID: <20250807085857.4170-1-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE817.infineon.com (172.23.29.43) To
 MUCSE827.infineon.com (172.23.29.20)

---
 doc/access-point-diagnostic-api.txt | 6 ++++++
 doc/station-diagnostic-api.txt      | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/doc/access-point-diagnostic-api.txt b/doc/access-point-diagnostic-api.txt
index 9b293b6f..c2d70826 100644
--- a/doc/access-point-diagnostic-api.txt
+++ b/doc/access-point-diagnostic-api.txt
@@ -31,6 +31,12 @@ Methods		array{dict} GetDiagnostics()
 
 			TxMCS [optional] - Transmitting MCS index
 
+			InactiveTime [optional] - Time duration (in ms) for which the STA
+						  connected to this BSS is currently inactive.
+
+			ConnectedTime [optional] - Time duration (in s) for which the STA
+						   remains connected to this BSS.
+
 			Possible errors: net.connman.iwd.Failed
 					 net.connman.iwd.NotConnected
 					 net.connman.iwd.NotFound
diff --git a/doc/station-diagnostic-api.txt b/doc/station-diagnostic-api.txt
index 77651366..9b51d4b7 100644
--- a/doc/station-diagnostic-api.txt
+++ b/doc/station-diagnostic-api.txt
@@ -53,6 +53,12 @@ Methods		dict GetDiagnostics()
 					- GCMP-256
 					- CCMP-256
 
+			InactiveTime [optional] - Time duration (in ms) for which this STA
+						  is currently inactive.
+
+			ConnectedTime [optional] - Time Duration (in s) for which this STA
+						   remains connected to the BSS.
+
 			Possible errors: net.connman.iwd.Busy
 					 net.connman.iwd.Failed
 					 net.connman.iwd.NotConnected
-- 
2.43.0

