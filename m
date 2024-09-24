Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2931A7074
	for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179509; cv=none; b=oXrneBPHjjqqfIpqXjv3ScCDDKonu1HI7Tgl3mRsGJWH9EFXGpg4/cmlisfHB+zlvFl9LW9lXLfcbLmOy2Q91ZlhgQtq2cP5v7W9gctszXraJjQk5oj2JQQUEA5QGAFtKrOUZ/0HLdVIJGqt+YkzfUDQv1wXlp7ZeE71Obv3kJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179509; c=relaxed/simple;
	bh=OAfu/qDdOQsS3OM+bhmz51/Y7uJGodJl++uWV64wVO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WpZTggnK9mO/V72652NMOM877Z1w4KDkS4rLvEYcX82dpG2nQOGv/l4czx3zxpOEUCbZV5i3S/tmckfEN/AXgjkMQJMhnaad52SJVhKCp6o8QlwRJt8BJtuY94Q+9J5qx9MFm6PAvvmKwDXEHp1OsgPHkKe4Xb5iXQn5JayGAcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YR5diTST; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YR5diTST"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c56eec7fccso37924696d6.3
        for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 05:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727179507; x=1727784307; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1zHCE/94UDb6MPRHs3iH1FHSfY4CLhcuJl5Wcvam9w=;
        b=YR5diTSTYUehwXR5mjA2ogEBp/vnev4ye1VDxj6pnI7oaVNp4x/svdPSIhwd2aDjYz
         uRvKd3L3i4pX6buI0kiTsx7gr73k7KQZ3OqtjtGbzyQxIL5krloVzeIr9P6UJ9Vi0G6A
         t0p1/YwT5/Hk5gWzQ/Cd7LBnLM3F6f5MxwCPQIwAgqEEyPbsW7IUs//0lJywwFQzTwx2
         y/5N9SijcZmAGmU9JViqHK9N7U6EAg4dT/eSsjNpdE4HAYMmTELYe/rdhjyLEoTIlmHc
         ypB/YSwj6gAaGn6+U+N1aGQLhFLSPLKfu2CnGVCYvNu44t9PJXyg2aXOQgR3zPUeqjWX
         ZEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179507; x=1727784307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1zHCE/94UDb6MPRHs3iH1FHSfY4CLhcuJl5Wcvam9w=;
        b=Vom53wjg9dvOj6e5upLpn3fNuZxA0IBhmzOeE8zQHf4lSUHXMElkWH8S9MQ4G3THHz
         tJ2O2uSlBAZz/IpwiTq1e7p3j6//ftvbxfBjh2t6GVNknCyLLNv+NDK/PkoCfOjQ7mTk
         J/IZITGu0a5uU8kyCdPhMnT1/vSY+M487S/j/Zo/3D6egFCWtx7JdpbGAVRuNmgmvULp
         EvNvoDoCwBSbHv0fJ0c/E9VT7+NC9eP98HNPUG2d2FH3P7Uq0q6guwIEIJzVDbBO9yNz
         b26lzrQtYR17TNK8qW7+P4L4gQuw6SmPkKMIzGjIbtMTEcEZl9coGL66NVDVmBqc3s5C
         Cu5A==
X-Gm-Message-State: AOJu0YxTZoJ/rkQNG0pQC6YnF+d6QDwz5IrKywcvl/botoocbdUyqFAk
	dRcG8pF5ORqxgfVsn+Mu1LuHbJBnOTdX/ZoVqKRpIcz/c9SaQfG0VI+OQw==
X-Google-Smtp-Source: AGHT+IFruA+DfeComHtww/s+ZiPnmgLdWWwnxGx/U6xzm0hJVfzBdp0qF1KpFc9FcKJlr641svnV0Q==
X-Received: by 2002:a05:6214:319b:b0:6cb:f8a:ba8a with SMTP id 6a1803df08f44-6cb0f8abd80mr24582916d6.25.1727179506864;
        Tue, 24 Sep 2024 05:05:06 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4a6178sm5948056d6.7.2024.09.24.05.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:05:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 09/16] dbus: add generic DPP agent interface
Date: Tue, 24 Sep 2024 05:04:40 -0700
Message-Id: <20240924120447.251761-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924120447.251761-1-prestwoj@gmail.com>
References: <20240924120447.251761-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will handle all DPP related agent requests.
---
 src/dbus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/dbus.h b/src/dbus.h
index 6d7074bf..d667cb23 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -49,6 +49,7 @@
 	"net.connman.iwd.NetworkConfigurationAgent"
 #define IWD_SHARED_CODE_AGENT_INTERFACE "net.connman.iwd.SharedCodeAgent"
 #define IWD_BSS_INTERFACE "net.connman.iwd.BasicServiceSet"
+#define IWD_DPP_AGENT_INTERFACE "net.connman.iwd.DeviceProvisioningAgent"
 
 #define IWD_BASE_PATH "/net/connman/iwd"
 #define IWD_AGENT_MANAGER_PATH IWD_BASE_PATH
-- 
2.34.1

