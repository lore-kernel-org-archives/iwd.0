Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D5B13AA5D
	for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303122; cv=none; b=UQ2LhJUCyP49L4v1iBptEzU2YanBDYQXu2LSJMiovJOvlSLLte7P1WjFOuRdz0yJ4scfEmd4poav9elq5uGRdHaN/OAsJc1cMDvx1GHDkFKpOQrUsaiZb44I9ig7xTaF7oIRd5nxNxbFDWhtGOzSGUVUvuSiPLbppar5LeF8dcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303122; c=relaxed/simple;
	bh=UrwEPTXWo7X5+8wjdxyu7T9hXlAnwefwROVAdXlnRrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BMSBcKVhAGDf/ofeNek5wyTwNp8FWqkIVjFU6ymG6s72grRAUipEu1MOWGPUGVClTNUg5OMe18OkOpmOIIiKYGpGkoPSYbb7mGJI26FGB/WOO+LW+PDN15tIi63PGMlhwTqZZnPm1ubEmfYlW2loqykTH9gn9ofmypA5AUUMucg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsjfdxqL; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsjfdxqL"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e05a2949284so697235276.1
        for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 04:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721303120; x=1721907920; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdisNiv81zFmrAFtxMDr6J899+B4KH4hNn79r3VP1ik=;
        b=WsjfdxqLtGsZ1Tz6w34VklIc8inG02wR+7xw6MIw0EThT/gTyE2nmvnYvKW8vN7wZh
         iSizqI5PTUu7wJTLNM8tMzZjRSp3+Lkr5cqDQyBmw17u5n22d6TJD/zqrvkmRQ4G15SG
         qeJDzsu1EEatsno0+uY2L5lL4I1bgpJ8xVMqBZ015N9gWLAizX4pMyCJFqApqsFGdQL8
         RcYJNlAX9ZR7v1X8kCZ1hbQpBetumfs+Nmi4xxL+pmjenctuUFYgpnkf9AV7pvfE3Rcx
         6r+6snuTovzQckmfBFwS9Ulle7VdJrISObvQ+2j7jUOINccW83U9ea1k08Hl9J81fBt+
         xlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721303120; x=1721907920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdisNiv81zFmrAFtxMDr6J899+B4KH4hNn79r3VP1ik=;
        b=sKgcRHleaByl43ja5lioO+Z+btpFkTZqZB0bKJdK1WSk/eI9euPa+mSYcjXoNpEO7P
         mbotZax07NvRDPWaMe9w2r8oq/PzoPkzRcHPdIKwgQGQwiyyr4QeAlnCJT78KMc0By41
         7+1OaocL1LwU7LhQISjYQ47HPfdnldMblDU5GGY22MpQgS8P1TgZ4NfTpOWo2FSiBecb
         ByUi3weD0xlhbKbG9wWFNvj/AzOUqiWIgYsmQQpGJWTycui+KZZSNVkIiN/SeykvG3HX
         XHyK8n8MXUVlJUUdInLVK5AeGVrwqDuGm082zBLb7iyqKq5/9NcMq68w7XE1v8SN+aoR
         uvkw==
X-Gm-Message-State: AOJu0YzBr30MRcFk55PRRT712WzRY3046gA5yo8wuKLECLqRWNXrZn5N
	QZdDilPMcCCwvwQrFz+Y5gXpxsaZupLV5flw4GXbvEJ85qIufTT/eDEwbw==
X-Google-Smtp-Source: AGHT+IEgZyy1cNepK5w7ssGtXZdFWLXWFjV/QiCldGJcAocYSHifUJNZs7r/cE77E6an583AQl8vMw==
X-Received: by 2002:a05:6902:12cc:b0:e03:9b03:f749 with SMTP id 3f1490d57ef6-e05feaf0295mr3018976276.23.1721303119759;
        Thu, 18 Jul 2024 04:45:19 -0700 (PDT)
Received: from LOCLAP699.localdomain ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c5138bbsm7292006d6.61.2024.07.18.04.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:45:19 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 01/11] station: print unknown channel number in neighbor report
Date: Thu, 18 Jul 2024 04:45:04 -0700
Message-Id: <20240718114514.2916258-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718114514.2916258-1-prestwoj@gmail.com>
References: <20240718114514.2916258-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the channel number resulted in a failure to parse the neighbor
report entry, print it for debugging.
---
 src/station.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 509d919c..3ead4326 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1835,7 +1835,7 @@ static uint32_t station_freq_from_neighbor_report(const uint8_t *country,
 			band = BAND_FREQ_5_GHZ;
 		else {
 			l_debug("Ignored: 0 oper class with an unusual "
-				"channel number");
+				"channel number %u", info->channel_num);
 
 			return 0;
 		}
-- 
2.34.1

