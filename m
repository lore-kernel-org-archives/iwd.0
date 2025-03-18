Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5872420D51D
	for <iwd@lists.linux.dev>; Tue, 18 Mar 2025 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309113; cv=none; b=dKqYU6s//tYbExZ7WR9UwEarOs39K4JjjycOjc9Sci7os5NunKoEquLy/g1CwjPFcP2qCbILWSlYX7Fq164n6AxV1eePyDDyiLLyRU0Ncv07QmYW/uTaDl0EiZZTPF+dyxC5/nGodmmSyjtClPyBY7kLejFHElDe98HOHqLH9rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309113; c=relaxed/simple;
	bh=vDMF1T7eOH6GKRhUt+QPWTp09g7OL2BHBiDtBRsFApw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ljjC4yJzL5GLbx4YJ82jQ7kZMrMU3mkfBEKHpyBfdRuUc/4BtC6gpFm1NExNtU6Fg/yZJRCV5di5ZIloyylNKqyRab2Nybk75jUkRph/KXZC48vpOD9pdYFN62rVvneuIu5Ad0pSY46q9R/16R7J6Spr9poFeBEnPD41vhyqxe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4Eu+DXc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4Eu+DXc"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224191d92e4so110132355ad.3
        for <iwd@lists.linux.dev>; Tue, 18 Mar 2025 07:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742309107; x=1742913907; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fo6eEo8vd4Ttv2jHt80DI0ch0RyPh6KEYVVJ7ym4bGI=;
        b=D4Eu+DXczYYFmonmcGTQSXX+pEfEQNZQrRALjGaog3xKanpTxj80aSWTqs26yUCd0W
         fdaUy6/vFz5LjUC1jGtfpjDwBSbZYZCEjT5F3FV0GGly36wo2foybzPC8MVPjkJmOIno
         LNTSxKaafMCjHmAUHtBdijQicJXuKZwWySeTbpX5F1VGX/6y2Kgk8nDIpyvz7Wm2R+sM
         0hl33RLjDckpe+x4u8Cwp6hixg1ITbmBqQjCeRY0bOYuUmwrNxvsP+lMXCkdaLLbXu4E
         5HuT4cJAUSEqpAf3/uGk8zgQPelz2+NhAJ1k1cK8dwTW0AGUVXwNveezyy8NO9mX9Z/Q
         rdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309107; x=1742913907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fo6eEo8vd4Ttv2jHt80DI0ch0RyPh6KEYVVJ7ym4bGI=;
        b=KVOc/ygyX9jfOZtLG4iDE9CPjukD/NhmMqyDNawpwWdFKZsT0d6FI0V1TLWKE6OVO1
         9Lj89t5Ol/aKy5le1uJ82Sv/LK1SAZYSamy25hZY8Rwq2bB7uHAASRv2XdA3KMy/g8C9
         3nYbxrW3ad4k0h3zulbwKg/V4EeftY51XpwHedlUn8Gq8oHSdDAWeEpk+kX9uxtHpMhI
         KffHQYvu6Mq9pftEOiidhyoiIRWTNE3QZfpnPhfAjYUKjyW+TCTrrgTgs7Zsv30+nJh7
         K+u+1707vb/w1n6kxtWS5Q8lMCChLIGX6EkdQnjtxSMFH49pINSDmr7omT08jeq4YjEg
         j9Ow==
X-Gm-Message-State: AOJu0YzZE2JPE8joVEESIKupmxzqYe9u1NYoan0b49gX6ucyBh76rHCN
	icMfOq8Jre8pBZ6RVGqQM5Pnn1h27B/mPdvZGs4pGH4bNsOpNQRFeBrFog==
X-Gm-Gg: ASbGnct7vnOAN2yP9dNgaOe3j7qtk3haWp8ENAPtI2Px7gq4U+d8PMdEX7bd9X6ppNC
	ZTJw4qgwKlvo2/3WQ2b8inKRFPzbIBoMwYxRvnXs59wcST01xd14n1oqngtT8pMJsR1EIsVZ35B
	VaYE+iceSYfQDS7idcEPv7kA0Wgyh2ayo0iSkk7gVzofJqqGoS/9Tkzn+DC6xX+9cBLt9iVRQdJ
	xdlLreiWa+W91uHdi0LoZGv+mCc4+iVvKN8ixlpQlDK/4KhVMp0bfi5s6nrxxQDvDEdhP18P7X4
	Q94gXEO0HvqhFO6IJljthfAZ8fvHWqMqDcAPszBC/CfCzhzYPgYVkY+NYvZlyIp+wQ==
X-Google-Smtp-Source: AGHT+IH1Y2RORa/Nkjo1g7+5mx27MD9cYJFI2bHhghsnOgzT8eEBQ4jG+CXlIreLx1sUgO5qo+C2eA==
X-Received: by 2002:a05:6a00:929b:b0:736:4fe0:2661 with SMTP id d2e1a72fcca58-737223b8f6dmr19202349b3a.11.1742309107085;
        Tue, 18 Mar 2025 07:45:07 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371154b0e7sm9597144b3a.38.2025.03.18.07.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:45:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: always network (temp) blacklist on failure
Date: Tue, 18 Mar 2025 07:45:00 -0700
Message-Id: <20250318144500.50101-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allowing the timeout blacklist to be disabled has introduced a bug
where a failed connection will not result in the BSS list to be
traversed. This causes IWD to retry the same BSS over and over which
be either a) have some issue preventing a connection or b) may simply
be unreachable/out of range.

This is because IWD was inherently relying on the timeout blacklist
to flag BSS's on failures. With it disabled there was nothing to tell
network_bss_select that we should skip the BSS and it would return
the same BSS indefinitely.

To fix this some of the blacklisting logic was re-worked in station.
Now, a BSS will always get network blacklisted upon a failure. This
allows network.c to traverse to the next BSS upon failure.

For auth/assoc failures we will then only timeout blacklist under
certain conditions, i.e. the status code was not in the temporary
list.

Fixes: 77639d2d452e ("blacklist: allow configuration to disable the blacklist")
---
 src/station.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/src/station.c b/src/station.c
index 5403c332..0b20e785 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3402,6 +3402,13 @@ static bool station_retry_with_reason(struct station *station,
 
 	blacklist_add_bss(station->connected_bss->addr);
 
+	/*
+	 * Network blacklist the BSS as well, since the timeout blacklist could
+	 * be disabled
+	 */
+	network_blacklist_add(station->connected_network,
+				station->connected_bss);
+
 try_next:
 	return station_try_next_bss(station);
 }
@@ -3449,6 +3456,10 @@ static bool station_pmksa_fallback(struct station *station, uint16_t status)
 static bool station_retry_with_status(struct station *station,
 					uint16_t status_code)
 {
+	/* If PMKSA failed don't blacklist so we can retry this BSS */
+	if (station_pmksa_fallback(station, status_code))
+		goto try_next;
+
 	/*
 	 * Certain Auth/Assoc failures should not cause a timeout blacklist.
 	 * In these cases we want to only temporarily blacklist the BSS until
@@ -3459,12 +3470,18 @@ static bool station_retry_with_status(struct station *station,
 	 *       specific BSS on our next attempt. There is currently no way to
 	 *       obtain that IE, but this should be done in the future.
 	 */
-	if (IS_TEMPORARY_STATUS(status_code))
-		network_blacklist_add(station->connected_network,
-						station->connected_bss);
-	else if (!station_pmksa_fallback(station, status_code))
+	if (!IS_TEMPORARY_STATUS(status_code))
 		blacklist_add_bss(station->connected_bss->addr);
 
+	/*
+	 * Unconditionally network blacklist the BSS if we are retrying. This
+	 * will allow network_bss_select to traverse the BSS list and ignore
+	 * BSS's which have previously failed
+	 */
+	network_blacklist_add(station->connected_network,
+				station->connected_bss);
+
+try_next:
 	iwd_notice(IWD_NOTICE_CONNECT_FAILED, "status: %u", status_code);
 
 	return station_try_next_bss(station);
-- 
2.34.1

