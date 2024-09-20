Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A2424B4A
	for <iwd@lists.linux.dev>; Fri, 20 Sep 2024 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726832205; cv=none; b=YbkAWCFG7umr+4danJjsOVfpGQDU6iyPfxcQmV8uv1MovYzWiyJKljYaDTEApB8eWZ7TEMWgSgwEJjEGCq9U1a8zk8sr/5gm5njRmjMDIawteuqxu3m+tEiO3AiAEIvmmOQh7fitR03cxK7CE1zhxIXg8HbWcbVIaOTtbJXQH7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726832205; c=relaxed/simple;
	bh=lArIlRPHthyP1sYiudCpS1kQPjAbdEokkJsv4QpvyWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D1+jMWoUGlyqEURaWDXx661eItpylbOfHb3GBrK/qFS/vMS7vBFq3FCO4NNUxGKRs18l/rCXcvzYdd93R/Io8jsI97QnYYstJ/G9beOe0uCa4eXxb1gQu+QPnMF6wrlfwPjxFpdUfQzl3GzOP1fVuzEDuv5iyjXdfeB4C8uv9PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOSE3bbb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOSE3bbb"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-206bd1c6ccdso19728255ad.3
        for <iwd@lists.linux.dev>; Fri, 20 Sep 2024 04:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726832203; x=1727437003; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v3U2KhjOhdE37J9L449qWV/8vamEUGCkoBZ9eZuFkNM=;
        b=QOSE3bbb8g56uxrLZgCXvUwUdS23iuP4k4IcZPeCFCzB624Ewv8toa9NokcNB4WQBb
         Nkd90US5sWHzPji/f83tXPF30o5dzdMIlnXFbIchxkyAe99GbIYGD9IxpEJJHF0p0xdV
         UI7SAEGEhnwMrCGTENy8rzsa4uaF5NrzbMumBnUlkfAVYMsEe5rutban64psQQVX+Fh+
         9U3U3jixB7eLw1ThdVjrsnLpTFU+i9LaIcVhLk/4PkgBlBIKkWhHCcIta2anDEflQloT
         T826jUbQmTDfbQUNSgJaILWex12F3i+FXu1rjSVnfj78ywg7ZeEU9tUY/7dMLJdRCClz
         QGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726832203; x=1727437003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3U2KhjOhdE37J9L449qWV/8vamEUGCkoBZ9eZuFkNM=;
        b=kh0W/tpW8u0kUpbNY57T/5OzHoyVcm1Qj49zbp5UT/8ZmXK5lYaUdJOHqF0bvH27u7
         C5V+AT+OCK/juOAJ1dzOdM/oJkGHNmEEFGV7lGhVHMINz6B6ENZLvPHTWSI8xoMZjalF
         WZQmzV8SMKkdyNGjgegYN8KEq9ShBP+TfPAexOsnWSKuaoqYckBo1woa72SbTDS7CXXN
         v94Rm2yO7gc4mVMynu0373b1hM7YxWE82VSdKoHqMxZhOI16LsYQwUpex5uWES8L4vID
         qr0vBP/LC7G7gOY5V15BCwq1Z/SEHITi9An2S15kghurYMCNc+quspOXU6HOdu/3m0Un
         OYiw==
X-Gm-Message-State: AOJu0YzHuzSNcUl9GV1u9KkDGhIvjgYRGV1CqTfoII8SloDWJE8Wxtq3
	CLmzpW5SCZ4+64DhUeHRvcbdVg9iVS+0lihX0c0IqLAR4Sff5b8jJ1lNag==
X-Google-Smtp-Source: AGHT+IE50JhIc+qeZPcNvGizi+0FfgfWIL5FRejdBEHVXUlRAV713d/w4AnDhKUP1TK6cjQjFDbfXQ==
X-Received: by 2002:a17:903:1c2:b0:202:348d:4e85 with SMTP id d9443c01a7336-208d8441977mr44313005ad.39.1726832202951;
        Fri, 20 Sep 2024 04:36:42 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794601384sm93233065ad.94.2024.09.20.04.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 04:36:42 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: loosen parsing requirements on STA_INFO
Date: Fri, 20 Sep 2024 04:36:36 -0700
Message-Id: <20240920113636.201189-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If one of the nested attributes in STA_INFO isn't exactly what we
expect in terms of length or content skip it rather than fatally
return. Each of the diagnostic info members uses a bool to indicate
if it was found, so if one is unable to parse it just won't be
present in the diagnostic message.
---
 src/netdev.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index d95a2a1e..995918ab 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -581,7 +581,7 @@ static bool netdev_parse_sta_info(struct l_genl_attr *attr,
 		switch (type) {
 		case NL80211_STA_INFO_SIGNAL:
 			if (len != 1)
-				return false;
+				continue;
 
 			info->cur_rssi = *(const int8_t *) data;
 			info->have_cur_rssi = true;
@@ -589,7 +589,7 @@ static bool netdev_parse_sta_info(struct l_genl_attr *attr,
 			break;
 		case NL80211_STA_INFO_SIGNAL_AVG:
 			if (len != 1)
-				return false;
+				continue;
 
 			info->avg_rssi = *(const int8_t *) data;
 			info->have_avg_rssi = true;
@@ -597,12 +597,12 @@ static bool netdev_parse_sta_info(struct l_genl_attr *attr,
 			break;
 		case NL80211_STA_INFO_RX_BITRATE:
 			if (!l_genl_attr_recurse(attr, &nested))
-				return false;
+				continue;
 
 			if (!netdev_parse_bitrate(&nested, &info->rx_mcs_type,
 							&info->rx_bitrate,
 							&info->rx_mcs))
-				return false;
+				continue;
 
 			info->have_rx_bitrate = true;
 
@@ -613,12 +613,12 @@ static bool netdev_parse_sta_info(struct l_genl_attr *attr,
 
 		case NL80211_STA_INFO_TX_BITRATE:
 			if (!l_genl_attr_recurse(attr, &nested))
-				return false;
+				continue;
 
 			if (!netdev_parse_bitrate(&nested, &info->tx_mcs_type,
 							&info->tx_bitrate,
 							&info->tx_mcs))
-				return false;
+				continue;
 
 			info->have_tx_bitrate = true;
 
@@ -629,7 +629,7 @@ static bool netdev_parse_sta_info(struct l_genl_attr *attr,
 
 		case NL80211_STA_INFO_EXPECTED_THROUGHPUT:
 			if (len != 4)
-				return false;
+				continue;
 
 			info->expected_throughput = l_get_u32(data);
 			info->have_expected_throughput = true;
-- 
2.34.1

