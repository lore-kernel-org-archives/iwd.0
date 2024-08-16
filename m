Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6F1156F34
	for <iwd@lists.linux.dev>; Fri, 16 Aug 2024 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812746; cv=none; b=NH2E0QNKCr9WQd5Qe/43rP0Q85H3zi6+LW4yjKHdNMizxLQQhVsSAUxHK9Ee8Sl7SCPH5qZ3+yGy6PNcy1gmnPdbMszL0g9xbUaR2ZAsjMVlcdXElfys+/VtC1Lg467r8Gy0gJsE929tnGH+c6o2840g6Ztl/09gjU22K69pzjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812746; c=relaxed/simple;
	bh=dGvS93TLppkCHT7FkE+RNSg4owaFpHKRYvuTu3q412U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L3RNAZoTfC+nL46A4NJ8/xg8Hcwlf0r63E/AaRFbv+e0U1mUAMzF6FnTfZYM12YhJXFApi1xGYzUd2mmYlnPM0HysBZd6HmhZ/b66WlItsuJWTFGMro7UI9fOzOITnORPe+CF1SHidyo2aiAGLFVaF/zbCvhxYyopvar1M719vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvtq7fEv; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvtq7fEv"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-450059a25b9so18401371cf.0
        for <iwd@lists.linux.dev>; Fri, 16 Aug 2024 05:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723812743; x=1724417543; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5avM1BXirhrk1+l4IoOpkNGQh9n3oULhwodONX2WEJs=;
        b=hvtq7fEv1pznQ6xkN5QQotgLO4Epwbl519DlIXMNmkj1KpM4SMwUeiFCZ52Wi3ousf
         /9Z2+80SC1wTK9nRtRQbG5xtCtPL1jXsZ8z4wdzMZmHMbeOmeuvqmvyZK1zN49pKfXgj
         gKUvasr1SH68hfkeMPCjltZ6pGf0MNNEj6wb13kDJMhUxi7/o3HAzfV3OhwUzC5N0Rri
         5XkZ6L7yTi20rt6sVWbxNNb8As0ThidzAqoV9DH1f4/DmfCKJdrfwuakN9ZmT2NuaCYM
         1epEwBrvKKE/i9kqgSutzfKVyD6W+Tx4l8XQMbB114WJKRtZqnkTq/29/hXikGAAc5WN
         JTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723812743; x=1724417543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5avM1BXirhrk1+l4IoOpkNGQh9n3oULhwodONX2WEJs=;
        b=ojnoKPNJ+WVZZajTogXlV/UGCCqHZPFYqPBuiqVtOK64UgH5BUI0cUnIPwCT18HNaa
         KLkRmIMPW+nNQPnvJGKBCiTBtfAQ7oNmqfmsBPNXJ9/SoGwXvN62eitzP8HGpbMZTyYj
         awqwsJ6r3XOeXLdkgTEe1P6Y0+j74U+Iy5Tj7sXeIliq7w5QI3wfljkdaZtE7bWD7dD8
         i8TtmjaPmSZQAkO7dYjx48WC2UHJE1BeDhc3CRYi4X6ggJ29OgpjvrpeKhk2hvv1lN0n
         LcJfh15+VWTf/QG/hJ5vEPceSrHg8AYJZOcpuwewjeS2bVdLzN6/OYZG3nxRT6liAmur
         l16w==
X-Gm-Message-State: AOJu0YyjiBWudYeDiEhp6wWPyU6hYNB98OVsMTd2zqlR/AH5S6/QUHvg
	EoLWInNIBhC4GqkwZBSes4XUcwGgfioORzpHLbSJhi6RHpYKQSjr2y35jA==
X-Google-Smtp-Source: AGHT+IHr4FmCmxLEuLZuiD5qvEavPzrgoUCjN1/gDCfUCfmITz2+t4XIkQFbdz/EynGOdaGjQd0dVg==
X-Received: by 2002:a05:622a:518f:b0:44f:ea31:cdbd with SMTP id d75a77b69052e-45375268e21mr45903541cf.24.1723812743032;
        Fri, 16 Aug 2024 05:52:23 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369ff54ffsm15921931cf.36.2024.08.16.05.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 05:52:22 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/6] auto-t: Add ExtendedServiceSet property
Date: Fri, 16 Aug 2024 05:52:13 -0700
Message-Id: <20240816125214.1162415-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816125214.1162415-1-prestwoj@gmail.com>
References: <20240816125214.1162415-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/util/iwd.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 1d4a5472..74bb25c0 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -975,6 +975,10 @@ class Network(IWDDBusAbstract):
         '''
         return bool(self._properties['Connected'])
 
+    @property
+    def extended_service_set(self):
+        return self._properties['ExtendedServiceSet']
+
     def connect(self, wait=True):
         '''
             Connect to the network. Request the device implied by the object
-- 
2.34.1

