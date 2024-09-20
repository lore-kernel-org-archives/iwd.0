Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B130149E17
	for <iwd@lists.linux.dev>; Fri, 20 Sep 2024 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726840543; cv=none; b=V0XPr89BKn2bzcUHcWFjyVK4voKvmrefDyRshKbkuD86/b8KgGMy4P0+UYG/l2iNM2SQ7eqX94zUHlh1MDfPQu8EO8hgvi/1AK+fpcEEZLybkU5U5Yy958IdSKtYfgkf8yZLGGu+frbBsInmdkvmqSx/8DFNxewpgJp0PmNSfMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726840543; c=relaxed/simple;
	bh=a5NJjlNkqRM+8WXg21u05Twz1v21WcZuXeFNP7qm9ss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ldymqYF/KwWpeV3UjPOjiGypD5uNEWzsQVUs8aN+r6BEi5m2PD5Di+zAqZvaiQmGpcJsXVMmpwLVxN4jG6EpQd/bPgPKDjxXz0PMLBsXeuZXJPcrS7mgWM5d+Xvc3Y4SKDyp6cUdXCPkrOSXM6CRR2jIbowbHGl1Qfbrn1UjA68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKxfY4yz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKxfY4yz"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20696938f86so17423325ad.3
        for <iwd@lists.linux.dev>; Fri, 20 Sep 2024 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726840541; x=1727445341; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylCRL/bA82oYS+NzWPfEZR2ZVUm1BVChdBG1jEiWfwY=;
        b=GKxfY4yzFdWNckhto7YJsztdyvoqg4y3D0msK+KdT1SZlsXFLdp5oGi6qSkv83U4bt
         gJcOofPZEsh88LngbNfBui33VOuDJ9YVV5XtfcY3H377MJMN2P/IKR9OmrWL1qSDu7U1
         MaX8cVgd+4B94HsOQv6OZZ+/hi3DGN8JUcHJOGa4ECAuHuDx2rdsY1Nu82ylD4yVvn3i
         lYRxPq6s7l5xL1kwm3RI9y0bAyBe/fxj/IlxGafYaArTz6YNgf8LxuNmMZwOtvWEE6cW
         tYvGeEsBh4FpzD+GDW0oKo0aLkpkT40d9ZdR85Kbz9B+OwCQRBJvV1SBtW2XbgkvGFs4
         vC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726840541; x=1727445341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylCRL/bA82oYS+NzWPfEZR2ZVUm1BVChdBG1jEiWfwY=;
        b=T40wF63fahgXWGi0Kq+DAo97bQ+g8dP28EHe/OZNmS7ETGdWIMkjgd4FoQLbiAYK1U
         cPBWFIjseXwnyyFGesFJ9dh4eWO7S0DGCMGtVsUXsImY/t502t/tchVWm4ktW1GrSGcs
         erlXu3ltb/L6Kel9n0OSpnQnPqflQVByTN11Vx96+1jvynlFpd0vcLkPsj5HMA+HXitR
         JNbyiY5wI5py9QeTVE5Y4pEnNhWYUKZh2QrD50CTPaNG0tq1BBuEZWkp3YdNj7piskMr
         577dTPY2tkxD3qP37s4QP32NosX7X/lKqJbpBKlBJuvwYDowH2Is/O8Bvv6a4wt+97z8
         YOYQ==
X-Gm-Message-State: AOJu0YwBTEid4gd2XqErfu6fp2lRZ9OlrW47Fzbqje+/4seILhTUjNAE
	T+Y/zBHzCzWYo6kiDKPSOAgLf0N9S0Vc9yXhQfTBOyXcQeyWanjCBMSb/w==
X-Google-Smtp-Source: AGHT+IFBnuL32dywPsqS5hxash1ARawOQHxvo/mJsCkGf1ZDrZ8hwXKW8QWDz/gbNTBeIe6xoO8D4g==
X-Received: by 2002:a17:903:32d0:b0:202:3711:6fe9 with SMTP id d9443c01a7336-208d9880518mr27848825ad.51.1726840541126;
        Fri, 20 Sep 2024 06:55:41 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d280csm95104285ad.130.2024.09.20.06.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 06:55:40 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] netdev: allow empty TX/RX bitrate attributes
Date: Fri, 20 Sep 2024 06:55:36 -0700
Message-Id: <20240920135536.203657-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TX or RX bitrate attributes can contain zero nested attributes.
This causes netdev_parse_bitrate() to fail, but this shouldn't then
cause the overall parsing to fail (we just don't have those values).

Fix this by continuing to parse attributes if either the TX/RX
bitrates fail to parse.
---
 src/netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

v2:
 * Retain the other "return false" lines as these do indicate some
   kind of kernel bug if the lengths don't match up to expected.

diff --git a/src/netdev.c b/src/netdev.c
index d95a2a1e..1e923805 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -602,7 +602,7 @@ static bool netdev_parse_sta_info(struct l_genl_attr *attr,
 			if (!netdev_parse_bitrate(&nested, &info->rx_mcs_type,
 							&info->rx_bitrate,
 							&info->rx_mcs))
-				return false;
+				continue;
 
 			info->have_rx_bitrate = true;
 
@@ -618,7 +618,7 @@ static bool netdev_parse_sta_info(struct l_genl_attr *attr,
 			if (!netdev_parse_bitrate(&nested, &info->tx_mcs_type,
 							&info->tx_bitrate,
 							&info->tx_mcs))
-				return false;
+				continue;
 
 			info->have_tx_bitrate = true;
 
-- 
2.34.1

