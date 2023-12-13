Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ABF54BDF
	for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 17:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0ZMU+SF"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-67ab5e015aaso46050936d6.0
        for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 09:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702488363; x=1703093163; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfSjzJXTaxeEhvm1B7MBmwyuYo5Vc1z83FjL0XeTyFM=;
        b=e0ZMU+SF6DMtnFjv2W4RPSwhnJ1TxZ2QuucV9qVwOpA9RbsG+4u3ZFtAXtBIjIM6VO
         0HYg9a6ofgn4bv2F6kOmOdRt6sOO5lCoLwKVA2aJKDlP/ivPWA5XivOk6iwrtBIg31vq
         hfnxVELr7UMpHTREGnxtbe+SPjlffGrNP8dJcrtXIxMinyxwRGOqSXhg0KdmcbHpOsVF
         sA0lvoZlvbPLv21mboJJv8lJbVvsywWQIJdU+tZlHJSpHjcz8BbIckpy1IxfRQSCmjva
         6GtiXufXWfTaVBHfkEJCuMQaI/UG/mrok/LA8m5U2kXTgCBfvpPoBAore2g+0KagnBbs
         Q04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488363; x=1703093163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfSjzJXTaxeEhvm1B7MBmwyuYo5Vc1z83FjL0XeTyFM=;
        b=nFPa1fZQi9rLXL8E6CJHL8DMT0h7g8HGGecaP2AUsokDBTS1p+jr7q2KUTJpsVWyt/
         Myv5bChYvXK8DXBXKS9/RZxebq2JRLhg2QQmtImf6FtXjbAdtJ4gm7dE0Uyh9223PLMi
         iS5RpU4VO0GpJ84uAYTRNO4us4c/ZR4HeFhdkvY5cOZmpaxy5crR1BzMdco0yccbNDpc
         LPT5um0MwzjwhPnwUdJDi7ePuVRvBog9SBUdUq7JXD/0ydyKhWq/Lnd2+NJjq91w4i0X
         v9xBbWH7jXCPOMDtavaqlQ6LGLFUKcR647YMbnJLi1zxr5SHcW+77hXTtGa5KYWrM6fr
         ObFg==
X-Gm-Message-State: AOJu0YwLf/9b46eC9Rp7Wq79RmaejO7gt/cIsxkYh7IO8gOQPVzn0yS0
	zXkCW7WtF2FNvKEn5KFVg7eg4xv0NN8=
X-Google-Smtp-Source: AGHT+IGo+MTDaDuhpiKl809WOHCxpyPg2Ypou7+cjgVHD2r6eJ5+YKkfmOe4ivSijhEi/Qw6Ux7FIQ==
X-Received: by 2002:a05:6214:5c3:b0:67a:a721:7848 with SMTP id t3-20020a05621405c300b0067aa7217848mr9225980qvz.109.1702488362884;
        Wed, 13 Dec 2023 09:26:02 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id hh12-20020a05622a618c00b00425f0ab0393sm556914qtb.17.2023.12.13.09.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:26:02 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 1/4] knownnetworks: set ops on info in __network_info_init
Date: Wed, 13 Dec 2023 09:25:43 -0800
Message-Id: <20231213172546.145998-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213172546.145998-1-prestwoj@gmail.com>
References: <20231213172546.145998-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function was only used by hotspot as a backdoor to initializing
a network info object. For the hotspot case it has its own ops
structure which is set after calling.

DPP now will need a way to create/update a known network from a
receieved configuration but it only needs the default ops structure
from known networks. Set this automatically within this function.
This won't pose an issue to hotspot as it will just overwrite the
ops pointer to its own implementation.
---
 src/knownnetworks.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index e2d0d515..b8f13cbc 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -125,21 +125,6 @@ void __network_config_parse(const struct l_settings *settings,
 	}
 }
 
-void __network_info_init(struct network_info *info,
-				const char *ssid, enum security security,
-				struct network_config *config)
-{
-	if (ssid)
-		strcpy(info->ssid, ssid);
-
-	info->type = security;
-
-	memcpy(&info->config, config, sizeof(struct network_config));
-
-	if (info->config.is_hidden)
-		num_known_hidden_networks++;
-}
-
 static void network_info_free(void *data)
 {
 	struct network_info *network = data;
@@ -815,6 +800,23 @@ void known_networks_add(struct network_info *network)
 				KNOWN_NETWORKS_EVENT_ADDED, network);
 }
 
+void __network_info_init(struct network_info *info,
+				const char *ssid, enum security security,
+				struct network_config *config)
+{
+	if (ssid)
+		strcpy(info->ssid, ssid);
+
+	info->type = security;
+
+	memcpy(&info->config, config, sizeof(struct network_config));
+
+	if (info->config.is_hidden)
+		num_known_hidden_networks++;
+
+	info->ops = &known_network_ops;
+}
+
 static void known_network_new(const char *ssid, enum security security,
 					struct network_config *config)
 {
-- 
2.34.1

