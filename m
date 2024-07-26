Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840D1143889
	for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996293; cv=none; b=PKOlMYl818fqquUY0AcQl8UwlJ1DzrUBwKjYB6Tzha/EreZ0MJmJZT4/MmaV69fM6Y2VUE2xvNJ6vYWIzoWi1e5qQZzGzzHq83TIip4hzKLUqaM4Ig3fZ4EuN0fAVQAdLV2DJRasgjxSd8Sbr0U6vgk6Nd0UYqlBlAo89wqi4vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996293; c=relaxed/simple;
	bh=Kgp4m617AaTZemEfEgRZpzlYRv5H8qqGpgatMr5/yeM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EM+ktyyQcVQ84huIEh6rmEyTc5xrr8Lrs4kNPTzrfio+n42rtkh6La6zlNa8mHqHQUJwHbQQLt1+MiGJ7X1k0fhkh5pkbDsSkt0gBoANOxICGawsmX6X0b1F1HeS3CpyQ53I/Ssvd5BHNfwYs37/KNwX5kQrOm8C2Rt91Q5A+Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yvrds+LA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yvrds+LA"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd66cddd4dso5671635ad.2
        for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 05:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721996291; x=1722601091; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oH3jG5Ke1c9qd9z/HPd0gPHI2VHuSBfrlIuWmERfCTk=;
        b=Yvrds+LACXBMRGMAyD1uYwP+8z6xoU6dpdgEf0i73kU9iFgynNfAjFclIN/nWUbYMj
         lpAzA0CLSy5DrUhHMrz4zUqbx3CtIVtaR40lOR1NVXzKDQlXyzDGvDOsfYcUw1Ux/WIM
         dfRwVrEa8A2ePcYPPBvqfwwaf1u86VdhWNw/l/JAOm82qCJTogtjtV3P82H3nL/avKi+
         Gx4fgCYKlueR7Mhn/Ej5paR0TWxKp/MCo56BYwWr5qlpxo4K8zt6n7EUDX42x5sjhlxo
         oq/jNhALoAqs1+OU3PA8ZcT49waUcL+3yDsuSWu3MHoS2lFOMZm6EYWOvx6H7AQWfl/c
         ox7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721996291; x=1722601091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oH3jG5Ke1c9qd9z/HPd0gPHI2VHuSBfrlIuWmERfCTk=;
        b=BuDbrECAgpI4x2h39Ue6ysNe2+S2ZJIdRR7LfDBWye5iG/b43xzTo8tupLbgQK94gS
         Q6+RIVC2RdScpR+cYDDUt4g5mgdWimZ1xCjOIIiTPZ4D2dEkS4dy/m0+BMawUr8S2chj
         0sgBeA9EYUxHDAoKh5Wf/MHmSOJEzXy3QjoYV7GqMN1cQb5xzXWSso7q1xcd8Xluc1Gp
         XGcVRxK0zBojgDfTPblJyr+02AnNBPXudGx59e1i85gNpl4l/cN2IRLfp8lIyJDytvxc
         PtMjCZzL0VKC9k0FoQlqPs81NLdd9s0/j7eurL/d7yxYpk1OdiLw2I8ReJlf6bDMQhVW
         km7A==
X-Gm-Message-State: AOJu0YwWeVzFYRtOfDaXHqOxTXNhsIjneTXt1ZHglDfc1+LuH3VloGQB
	5yC8wMYoqRqZlA4fsd2V2Ya5uOolrMlaiTaBWXg+Rp5OPDjoG6BwN6geuQ==
X-Google-Smtp-Source: AGHT+IGlWwW4cD28tq7Gi6g2FVz8WEr6/OwMPAzQE7TfIRTJRUDKgjZ6wjv1QT5B93ztjhB5t0zoFQ==
X-Received: by 2002:a17:902:d481:b0:1fd:8e8b:b2d1 with SMTP id d9443c01a7336-1fed38c2e95mr82406065ad.33.1721996291418;
        Fri, 26 Jul 2024 05:18:11 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee134esm30823725ad.129.2024.07.26.05.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 05:18:11 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] monitor: fix the CQM RSSI threshold attribute
Date: Fri, 26 Jul 2024 05:18:08 -0700
Message-Id: <20240726121808.1629079-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This attribute is actually an array of signed 32 bit integers and it
was being treated as a single integer. This would work until more
than one threshold was set, then it would fail to parse it.
---
 monitor/nlmon.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index a900f7cc..e5cd5451 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -5618,8 +5618,26 @@ static void print_cqm_event(unsigned int level, const char *label,
 	}
 }
 
+static void print_cqm_thresholds(unsigned int level, const char *label,
+					const void *data, uint16_t size)
+{
+	const int32_t *thresholds = data;
+	unsigned int i;
+
+	if (size % 4) {
+		printf("malformed packet");
+		return;
+	}
+
+	print_attr(level, "%s:", label);
+
+	for (i = 0; i < size / 4; i++)
+		print_attr(level + 1, "Threshold: %d", thresholds[i]);
+
+}
 static const struct attr_entry cqm_table[] = {
-	{ NL80211_ATTR_CQM_RSSI_THOLD,	"RSSI threshold",	ATTR_U32 },
+	{ NL80211_ATTR_CQM_RSSI_THOLD,	"RSSI thresholds",	ATTR_CUSTOM,
+					{ .function = print_cqm_thresholds } },
 	{ NL80211_ATTR_CQM_RSSI_HYST,	"RSSI hysteresis",	ATTR_U32 },
 	{ NL80211_ATTR_CQM_RSSI_THRESHOLD_EVENT,
 					"RSSI threshold event",	ATTR_CUSTOM,
-- 
2.34.1

