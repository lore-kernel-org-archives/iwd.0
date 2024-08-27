Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6841A072D
	for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767846; cv=none; b=qlUV4pMxzReOLB97die9asBDq9HycSMPQkyl3IV0HAouMPYJ5j4DdA5pmCrITvCkKb2xa4L4vXBXblkY4EdHFnxIb+2AgdvyfH6g1SRB/f5P8Fp9lZ33xhdM4f0MXl1VW1Y6mQGHgqaHR2qwRTovj/8qeX99f7TkacoijdmwlI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767846; c=relaxed/simple;
	bh=s5iDfzyIpkOt2KbP96kfQfcLB4StV0+pHbjyBcZ0b+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b2MPWLgT/VLBelJwewJ80RJlitpmYx7Q05WVpE5VcAqVK7KSb2uypyVYKl0nVft+G/N0VNGctaXh8AgruWaK1LgyNx61C/9w6D1wi+F2gEXDC93QOPfe1LMBAiVaNBbCRv3KYOMDQrUTLhXkCOsMBbFe/wFJVr1HjFNNEO6uM1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbn65YMH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbn65YMH"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2021c08b95cso49383235ad.0
        for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724767844; x=1725372644; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=drs346Uc7AaMBHitwNVhpcRUUhbv8Ayd+OmUGyWtFR4=;
        b=cbn65YMHYsTM8xhdscNu6gDF03XyQTq+rnEEFxjYaZHUVlx91Jm3uh5KTmmyz+o14d
         mQYVodCeD/vJycCvpeKqPpRvotDCNtX23/lM7F4QMJ5j4P/vdGibG8LnIbJKLLf/Gl/X
         hv+FWBnBZZBfjiA7CqYQMJHTd/OJC3BtWlYoyPgXsgy2WjKA4yo8/Gg5ZTmaYoDcqKUK
         soypnDqs0FpCvIMZMHdRs1CbsJQ9/BDgjruhwZlt7L/Vr7V7YP0fcG8tT+JU0gKwz0k9
         UL1aMiyTpLcB1rbBsZNXJnXz77atsrBCOUFnfrDWyyjN6MH4RATgDFweEZf65g788npW
         S9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724767844; x=1725372644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=drs346Uc7AaMBHitwNVhpcRUUhbv8Ayd+OmUGyWtFR4=;
        b=Gf9cKIEyrm+PzuBqCrWuQ3Z4gxB+/x8PZu85oIt3Qsm1dDy7Q0idBTuAALZdto8co4
         HTtmqc208QzKQ3KV1o97Zn9xEB5GqOc+ZEB9BqaWUoEyNHbWqT6FoB+XHESuFTavuX4J
         sGoDnn3+dLmoWIdiUVsfJJCYVPoNQcv3zmL6elAP/ukoNZiEgfwq3fpqku5Nh/mqwPrN
         hMjXMUNFWQuEowvEISAG0YwPAtJkwRNYXALzN9COz/ksA7t0xPjd3dVhH9lW9Otymn17
         wvri00YAoQci00/vBKvBKA4ydpI4/NdjJQxYgcmQ5JaGwRY4WD5tP9DcL/fBuQjIGKTx
         /NoA==
X-Gm-Message-State: AOJu0YxLby+/8/kUxJyhUDnSPmXM9zMDSarWDgJmvdFZngEc3TwIG2yh
	azV3lXpekn+SVcdXcJRzdKym8tZwOFU45Iqx94vYt2Y8Btb+Mszavi8L6w==
X-Google-Smtp-Source: AGHT+IHIboqmVEozkushlgih/6dp1YAs77DXHR8DBc3nm8A3jQ7qWKmHORY25GhEb3SYQsGldAZLdQ==
X-Received: by 2002:a17:902:d4c4:b0:202:21:eb2a with SMTP id d9443c01a7336-204ddd2cbbdmr47975735ad.19.1724767843597;
        Tue, 27 Aug 2024 07:10:43 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385be0470sm83049175ad.260.2024.08.27.07.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:10:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: check for roam timeout before rearming
Date: Tue, 27 Aug 2024 07:10:37 -0700
Message-Id: <20240827141037.745738-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A user reported a crash which was due to the roam trigger timeout
being overwritten, followed by a disconnect. Post-disconnect the
timer would fire and result in a crash. Its not clear exactly where
the overwrite was happening but upon code inspection it could
happen in the following scenario:

1. Beacon loss event, start roam timeout
2. Signal low event, no check if timeout is running and the timeout
   gets overwritten.

The reported crash actually didn't appear to be from the above
scenario but something else, so now all instances where the timer
is rearmed we also check if there is already a timer set.
---
 src/station.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 30a1232a..e188aed4 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2221,7 +2221,7 @@ static void station_roamed(struct station *station)
 	 * Schedule another roaming attempt in case the signal continues to
 	 * remain low. A subsequent high signal notification will cancel it.
 	 */
-	if (station->signal_low)
+	if (station->signal_low && L_WARN_ON(!station->roam_trigger_timeout))
 		station_roam_timeout_rearm(station, roam_retry_interval);
 
 	if (station->netconfig)
@@ -2260,7 +2260,7 @@ static void station_roam_retry(struct station *station)
 	station->roam_scan_full = false;
 	station->ap_directed_roaming = false;
 
-	if (station->signal_low)
+	if (station->signal_low && !station->roam_trigger_timeout)
 		station_roam_timeout_rearm(station, roam_retry_interval);
 }
 
@@ -3202,6 +3202,9 @@ static void station_low_rssi(struct station *station)
 	if (station_cannot_roam(station))
 		return;
 
+	if (station->roam_trigger_timeout)
+		return;
+
 	/* Set a 5-second initial timeout */
 	station_roam_timeout_rearm(station, 5);
 }
-- 
2.34.1

