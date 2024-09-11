Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D6C7E583
	for <iwd@lists.linux.dev>; Wed, 11 Sep 2024 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063251; cv=none; b=eZnAAMAHyNC7qNZV2vlrZOCRmouB3FzWGBWALvIGYSEXFJOGGR79Zqvb/2Q4O2laigOoauwJpEJo01DdUgAsge/3NkFWwV9WpwV0slGfh6HLL/kJBFnqp4fsKmhr299Fdguu3vKHS+fym+lwjyzUZcbvckcwgIg47/5Erfh+zp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063251; c=relaxed/simple;
	bh=OoNwOOO2TYIJtKIlSKe+BUefJQYyDXGs8+Mze5IOea4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pUe6dCLiwuT+UP/XlUKczSPGc/E0v2NzDYz5rU7JLeUUJJVSUh9cWFY883ZZAtJhuzIEPLLFE4MAIXRteo7SiBpvU7MQqFzSqNf7VdabY2Fm14ViTSJMab3bvM1FRzDSzgaZkwXA5mkQoSURhz3IChkt3RTrgYxvW9wcVQ26EPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEEcRIap; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEEcRIap"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c34fb4f65eso39955526d6.0
        for <iwd@lists.linux.dev>; Wed, 11 Sep 2024 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726063248; x=1726668048; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tto3Xp5/opbUWvPqsjPoU8ua+g1i/buPvEx6MZSssJE=;
        b=cEEcRIapE1VMS5rBHq0xipka6nel/b9+hgmwEIzm+OCyar1XvK1Iex5pRFbiAVCygj
         6oV/eFNyPjDoXQ0tJVMpAYfAOh+QTP+TLFvyuunU9i+PJkfuYWWmCVFFMjLlnAOzOwEb
         3nTP/O7LuNCDPKhd/XyCYgmDrDOOPfa9zXc/D7kFIb1C9Oua4Nne7RS2T1JZyKylPVtf
         17vlxoSPyubsFo8QBSjzei8ouTw0/mau76k4KwPd77o5LFJcDttPqpQUbg4vfDCJJgbo
         k5w2pcGBNoKcb/IN8tAMtjSd9KEZnu7ftoqB364eKzkrw0eBqAk0CPthg4kuJ6eMZmoH
         ACcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726063248; x=1726668048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tto3Xp5/opbUWvPqsjPoU8ua+g1i/buPvEx6MZSssJE=;
        b=NeyAubW27AGylaBJfKFuNW2rT4N3FSagJ5kE2w6fiseSqnFu69JHNU2YtdWyWvI6vj
         35F8LhxTSEPGCtwl/TP2HPlrXH+4HBrqPogSq42HHOznT/iaNmtd49aB5nhhxIJ1HPEt
         GsudKmOQ/ijfqJQ+2/DKrt0DTBexY51BlJ4tFJhh0NIw/2zySIleHY9lRcKXm1qL7qSC
         wjfT/91mBEk0I4vnosMyISCmgERUupBd+1o70RDXp1ZSMpHCsKzutUeZis8WB8J7AjkV
         Q6wHaceII4ey9+qtXfXQAv9jmDNmqV9z4tqIISd4ceMS/soesaIsAiBhRt0ieoEpRhvZ
         Gznw==
X-Gm-Message-State: AOJu0YwV74Vw7kYmMYeg9ZucCmfQJ5HS6FlZ6zYyq5zZ+Xdkw7jCdNUk
	TZ8FwA7+ZGkKAz/VacyClUHyK0mTey6fo5SFxpd7umjopaGPlnRdIyaIrw==
X-Google-Smtp-Source: AGHT+IEI/x8dyvCqxe1a+B9YumTZew9mc/xe1Vq14W6tGMKQ2ykEq8/FUASCGi3qCdfbxGoChu2QzA==
X-Received: by 2002:ad4:42c2:0:b0:6c5:5081:1491 with SMTP id 6a1803df08f44-6c550811d4amr101821626d6.12.1726063248263;
        Wed, 11 Sep 2024 07:00:48 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534347113sm41613156d6.65.2024.09.11.07.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:00:47 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: fix printing uint64_t by using PRIx64
Date: Wed, 11 Sep 2024 07:00:44 -0700
Message-Id: <20240911140044.164855-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixed non 64-bit builds. In addition the formatting for the
seconds integer was changed to %d, since its an int.
---
 src/station.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/station.c b/src/station.c
index 550ef745..9ebed8e2 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3094,19 +3094,19 @@ static void station_roam_timeout_rearm(struct station *station, int seconds)
 
 	/* Our current timeout is less than the rearm, keep current */
 	if (l_time_before(remaining, seconds * L_USEC_PER_SEC)) {
-		l_debug("Keeping current roam timeout of %lu seconds",
+		l_debug("Keeping current roam timeout of %" PRIx64 " seconds",
 				l_time_to_secs(remaining));
 		return;
 	}
 
-	l_debug("Rescheduling roam timeout from %lu to %u seconds",
+	l_debug("Rescheduling roam timeout from %" PRIx64" to %d seconds",
 			l_time_to_secs(remaining), seconds);
 	l_timeout_modify(station->roam_trigger_timeout, seconds);
 
 	return;
 
 new_timeout:
-	l_debug("Arming new roam timer for %u seconds", seconds);
+	l_debug("Arming new roam timer for %d seconds", seconds);
 
 	station->roam_trigger_timeout =
 		l_timeout_create(seconds, station_roam_trigger_cb,
-- 
2.34.1

