Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB58613C697
	for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729942; cv=none; b=aj07x5iCYEphTO/mfhV5SBuwsrCVopNUysOmTvvaUuRfDO6epRMDf87gEb18cxQL9nJtOtsebDBxdkCUpfDkaCWkrG6hWVGVxMOdj1pdJGO6PmB2PY0YtTfdJTN8+n5E0APZzVuvzBeysUdkZ4opDy9s0W8lfC7pLsNaJyIdPuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729942; c=relaxed/simple;
	bh=FY6UPEShqvDyoyXcx0u682D4qTTz5UU+Z9Tx9PfyozA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I5sQIZXxwtYkd6F8hAM1oOlx5jptW4+NDRTbDWiqGzQk6+j0C7hVw0T05IYJcxAZwDkv8/NyZufGun9BMywhlbuB+h5r7hu8pD72ikQyucKHxxK8VUvZCmV1tffBCqVK2x4WJGdtcNx0ZTloVWqKAlVVdjf9Agtpmpkw3VcMP2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDe3VpSD; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDe3VpSD"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-80b7699abcaso1574725241.3
        for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718729939; x=1719334739; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=abMytJVtQ4ZdUltEYUT+QWW86G/3e5WAqgPv7RO4xPQ=;
        b=PDe3VpSD0JZGB+bGuOR7F8HxbOQWBIMUOFHW7IguqGYd7hzFXzsoFLSh3YT0xp9TJs
         GMZzkatU0Gygw6i1j9KIVcM4rmMb19zP0dKT1xzA53PFpbKAJS3icknwVWIyn5BDCqWE
         clzf9vsmZmlIlyTZmKtKQ9Z2NmGSur6/JDrTFzXYHsjbvp/xE9yxY0kfj3JMGIw1+okA
         zTEsJ/sTI97K8wNXqc+L0eXv8TbmKqTXM3hAlXWOXzHMGHvcxEdN5OPhYaH2Gf9j+c0O
         T15AfFnLBI+Bf+huUMEipvXNVd4KLhirPheQSwMh/nC9EEYBFyHCxqitGcZ5ZR7tsoEp
         jkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718729939; x=1719334739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abMytJVtQ4ZdUltEYUT+QWW86G/3e5WAqgPv7RO4xPQ=;
        b=vKLA2iatNn0eXsnXsOZLarkCtLbsGcRhJvoIeYALneHsfqWbGZl9UBnzcnT5TW0994
         XRrjbOs77RBt+/Qp1ZFUJ8hedS0Epza9ekknTkttjH+J1DZgqGM6VWni5+0l0mGVDLhW
         5r1IxEB6qfLoQBHCay7Nlm2/6UN7cK6zBD56SZuw2qA0GBlF68BoLIJwK59vnrw/tXmy
         BkqQOv4lLMEw/pcFmfCByGhH4cRcdokpc4os4uMwEMAFH9Tg4dN9hof/T4yt0dc+CbBC
         luvjeeYsg4VIztD5KWmHFdJnq3UGVMHV0IP4eEssBHWxnE3rAaoVyBTdpyrYXliXwKHp
         6LnQ==
X-Gm-Message-State: AOJu0Yzc2RQdt4z7HLfAk8rla4qdQj5ysPut8fGZxr5f+oFgnYmag71n
	+6by/qL2GVL1oGbsHxkcQN5JAc1f+CcJbD9Su6l7IjPb+TpKQqmfKBeohg==
X-Google-Smtp-Source: AGHT+IGRX5qJuMHkeGxIBIqqAHTmtQQRR2SY6GT1ilz4O8aT/cEicw2JbvFiOy42280wUh9F8ZuAMA==
X-Received: by 2002:a05:6122:1799:b0:4ec:fe80:ca3f with SMTP id 71dfb90a1353d-4ef277c5fa5mr578426e0c.13.1718729939181;
        Tue, 18 Jun 2024 09:58:59 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798b49e4c82sm533688785a.88.2024.06.18.09.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 09:58:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/10] netdev: downgrade L_WARN_ON for ensure_eapol_registered
Date: Tue, 18 Jun 2024 09:58:45 -0700
Message-Id: <20240618165854.113598-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This warning is guaranteed to happen for SAE networks where there are
multiple netdev_authenticate_events. This should just be a check so
we don't register eapol twice, not a warning.
---
 src/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index af069724..5b79d267 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2898,7 +2898,7 @@ static bool kernel_will_retry_auth(uint16_t status_code,
 
 static void netdev_ensure_eapol_registered(struct netdev *netdev)
 {
-	if (L_WARN_ON(netdev->sm))
+	if (netdev->sm)
 		return;
 
 	netdev->sm = eapol_sm_new(netdev->handshake);
-- 
2.34.1

