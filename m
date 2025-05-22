Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15451D5AB5
	for <iwd@lists.linux.dev>; Thu, 22 May 2025 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747939317; cv=none; b=GOVhMuUMo/XqgOWJPT2+vYTaN7PxjRpOkG8bs117/pbUFIu8mKAG0P7yygwR9UgFTPQl8pOwRLiT3H0SYA34Vm310cAwQ8KfCXbZYlafw44ffqG+tYMDRrqZCYkMe2wfegJOw4ADfYA/IAgans1RF/Q0d2zApre6WXDVFAzRABQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747939317; c=relaxed/simple;
	bh=q4lKwypnjqJYX1y56x5tzaN+AI3Uevn6fKfJqSARmc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K+0zmV+1iNf8unVTjN69WeHsj52X7tcPV/jiEtRdaYQPsuS/nxzMcLt/ojW7XawDg0g3CNpFwMe9vXU9Nbfw5nAfjQSZiMdYwjiL11a0OalTwNevDhuV6lGmNneLww2v9KXtIyKgI+lYfxOcxfNIAnYNJZiljbTEqWFaeokdcIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqBbMwv7; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqBbMwv7"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-310ce23a695so814556a91.3
        for <iwd@lists.linux.dev>; Thu, 22 May 2025 11:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747939315; x=1748544115; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JBdb+Y40gt9b6Uha/w3VUSxvgG+7d25rF9KMCqro5fE=;
        b=jqBbMwv7VSAbIpcFEQXk7ltLcSj4D8OAHmiwPwxHLsNgH9ALyPaSOwTpzurN5tZro3
         3NQt0K87DXfyro5J/nCVaQlLrQ1SQzO5Pe3oGioXT2sjeqrbLlm0zp0BWTgPk+dtDtR3
         wR0i8B7qrwMO0ZdzN+IB2ONWKbcgThjAkPbfvwRBjO+LIW5nDpqXRRvCnxEQMA/nvTT5
         wkzyNp6ONCMuHACcAWcMu4JJ/nW3N0W55CQEtqJRGR4kfpk27JDksbtIp3XPzdEKPrru
         YBLIgW9iuIkukgb7v95rJzWEYc6ExOAQ9yapaC4uQfznnG4UbA2Q+G1SGlC5zHRxYrt9
         5p/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747939315; x=1748544115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBdb+Y40gt9b6Uha/w3VUSxvgG+7d25rF9KMCqro5fE=;
        b=KW38QpytQMzeX+eEGh095jQbfesst/zttrSL3BWZj4Zf9cfgYqms/GGub+cbcL1igi
         QEQ4xHfNErv1VReFD2EE4itIqLN4avaxLbdns1qkKvW8Dx/vc9v/oQ+S3Gxd/sxaLKgU
         iX3i6iMIz2IvbVJniVuEu3vha9m0vuOTLbXmpYod2T9roq6iuQa7xq+SykwLjnreGTQt
         Ja8D+p1heQxpflV6cST/qoxFuJkPTjOu7kNlcNcdsQaRXGuzyj1FYb2H2C1Cb2rqbSqo
         FT1e7tugd/C1g+ukQlFJIo2eDynDHKG65+Y6qbpf5yzp85B46FPixxjvvvwQNqapXD34
         laAg==
X-Gm-Message-State: AOJu0YzCzCHHPwod88D4gnxvNsWvc/tmbq8aIA5IFGROrhWhBQoZonxK
	jVibX2rThwIAlN98IIVWB/qnKk6sFaTB++ynrFm9EA1PEF7wHw2e0doYK1TNlQ==
X-Gm-Gg: ASbGnctle+uXxLIQjkYrjhMC0nLKOBnn5AyQ9x/dx3o5U/5c/r3gpZwURBcUTH9UM7A
	9HOH1/j2UrdX3Nf3kBeTBCtDwjgJ1UVJV3RGGJgYy0dwlt32+vjP98BVm7Id5zTnNt4oJ2Tya24
	ebtSN/U/YOxc4h5GscatQw4c3FrUmv00fQJNesY9V5IZO+F9pDZ8W23BXVNAApvJBrY2q8iCPZt
	r1YUunGZ+dMowahnOe42H47AVhzNJu9cWb6V5BF2v650h9/NavanCviXdc7aPAyWw018KaPZ06R
	IJ+hv5lZOBE90GYVfph7kY8OsqmXOUwCOmG59YXWPfDzt6agcQ1B1sb97ov8c3rTtRiIxXrVZ5p
	v4lVvatBeH+a9YOD4rJpeVL9NkRrgm04mjUI2sg==
X-Google-Smtp-Source: AGHT+IFByK0Wudwc9itZ0uGm9pDNTz66doX0VnI8sVcPbJh1JTsdYtuPCvVlE1xLoueE0SynrDz7dg==
X-Received: by 2002:a17:90b:3b8c:b0:30e:390e:c24c with SMTP id 98e67ed59e1d1-310e96e7476mr413234a91.18.1747939314815;
        Thu, 22 May 2025 11:41:54 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365f3487sm5829492a91.42.2025.05.22.11.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 11:41:54 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] nl80211cmd: add NL80211_CMD_ASSOC_COMEBACK
Date: Thu, 22 May 2025 11:41:50 -0700
Message-Id: <20250522184152.29950-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/nl80211cmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/nl80211cmd.c b/src/nl80211cmd.c
index 065d52af..65a948c5 100644
--- a/src/nl80211cmd.c
+++ b/src/nl80211cmd.c
@@ -177,6 +177,7 @@ static const struct {
 	{ NL80211_CMD_UNPROT_BEACON,		"Unprotected Beacon"	},
 	{ NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS,
 						"Control Port TX Status" },
+	{ NL80211_CMD_ASSOC_COMEBACK,		"Association comeback delay" },
 	{ }
 };
 
-- 
2.34.1

