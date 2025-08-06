Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075A41DE89B
	for <iwd@lists.linux.dev>; Wed,  6 Aug 2025 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471889; cv=none; b=LuG7H9bfeVmv9I4b/1z+C54e1W+wZ+OgRQcKe6DfMgtDb5VrWDpbZz7LtkmX/4vPLgStG36UgkPOOdowExlhEqkItxNuRZRlLqQm2+sBGhCuUcf9NmjeeI4pQlSdViRFGdivd43EK7RuD5aCNu30kenVaMMfLYO8bm5bLdj+mdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471889; c=relaxed/simple;
	bh=4TETj0rwg3qzdrp3KjC//+WnJkChZdSIH7/vpNlXEBU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZOZQsLOgofzho8qbTre3SbpyA0Dj5/yv/a0DWzqRZKg9Tbq4qFHKKVfWnDLy8jRgq8u04IXzFKYRAfjYoNpgkzHqRcZw6hpBBPvaQeF+z57D9RYwHRE+H5Q7kgnJqvzQaO2UuezKmwBfxenq1SF92XjwQn37ilq27LZe+l9SZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=Tp9yHnNd; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="Tp9yHnNd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1754471888; x=1786007888;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4TETj0rwg3qzdrp3KjC//+WnJkChZdSIH7/vpNlXEBU=;
  b=Tp9yHnNdlXsZSrFYP/h2mehM55jTQk3JMGK4Ry6LhjvrtrUGliKuznKy
   e5+uJzonyM+uxgHVjWse0BxMsarHfMki5eKoYS2Fd+ssaSV2ZIaTJg8xU
   5vDKaDEJGTUIoUUoVt3OucmPMK7ejK0EWod00zrrI3C2F7Gs7il5Hk8w/
   U=;
X-CSE-ConnectionGUID: xhzgy839SuqsUDSdNxnNnw==
X-CSE-MsgGUID: iRhhOMr+QSik6QnispOJeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="105141881"
X-IronPort-AV: E=Sophos;i="6.17,268,1747692000"; 
   d="scan'208";a="105141881"
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 11:16:56 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Wed, 6 Aug
 2025 11:16:55 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 11:16:53 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <iwd@lists.linux.dev>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH] netdev: parse INACTIVE_TIME and CONNECTED_TIME in netdev_get_station
Date: Wed, 6 Aug 2025 14:46:25 +0530
Message-ID: <20250806091625.1277-1-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE815.infineon.com (172.23.29.41) To
 MUCSE827.infineon.com (172.23.29.20)

These two newly parsed station info params "inactive time" and the
"connected time" would be helpful to track the duration (in ms) for
which the station was last inactive and the total duration (in s) for
which the station is currently connected to the AP.

When the wlan device is in STA mode, these fields represent the info
of this station device. And when wlan device is in AP mode, then these
fields repesents the stations that are connected to this AP device.
---
 client/diagnostic.c |  2 ++
 src/diagnostic.c    |  8 ++++++++
 src/diagnostic.h    |  5 +++++
 src/netdev.c        | 17 ++++++++++++++++-
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/client/diagnostic.c b/client/diagnostic.c
index 92a6126a..2be8b724 100644
--- a/client/diagnostic.c
+++ b/client/diagnostic.c
@@ -95,6 +95,8 @@ static const struct diagnostic_dict_mapping diagnostic_mapping[] = {
 	{ "Frequency", 'u' },
 	{ "Channel", 'q' },
 	{ "Security", 's' },
+	{ "InactiveTime", 'u', "ms" },
+	{ "ConnectedTime", 'u', "s" },
 	{ NULL }
 };
 
diff --git a/src/diagnostic.c b/src/diagnostic.c
index b928c2c1..9dc61deb 100644
--- a/src/diagnostic.c
+++ b/src/diagnostic.c
@@ -110,6 +110,14 @@ bool diagnostic_info_to_dict(const struct diagnostic_station_info *info,
 		dbus_append_dict_basic(builder, "ExpectedThroughput", 'u',
 					&info->expected_throughput);
 
+	if (info->have_inactive_time)
+		dbus_append_dict_basic(builder, "InactiveTime", 'u',
+					&info->inactive_time);
+
+	if (info->have_connected_time)
+		dbus_append_dict_basic(builder, "ConnectedTime", 'u',
+					&info->connected_time);
+
 	return true;
 }
 
diff --git a/src/diagnostic.h b/src/diagnostic.h
index fd965839..3a3b65de 100644
--- a/src/diagnostic.h
+++ b/src/diagnostic.h
@@ -43,6 +43,9 @@ struct diagnostic_station_info {
 
 	uint32_t expected_throughput;
 
+	uint32_t inactive_time;
+	uint32_t connected_time;
+
 	bool have_cur_rssi : 1;
 	bool have_avg_rssi : 1;
 	bool have_rx_mcs : 1;
@@ -50,6 +53,8 @@ struct diagnostic_station_info {
 	bool have_rx_bitrate : 1;
 	bool have_tx_bitrate : 1;
 	bool have_expected_throughput : 1;
+	bool have_inactive_time : 1;
+	bool have_connected_time : 1;
 };
 
 bool diagnostic_info_to_dict(const struct diagnostic_station_info *info,
diff --git a/src/netdev.c b/src/netdev.c
index 3bdc3e69..c5ab9105 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -637,7 +637,6 @@ static bool netdev_parse_sta_info(struct l_genl_attr *attr,
 				info->have_tx_mcs = true;
 
 			break;
-
 		case NL80211_STA_INFO_EXPECTED_THROUGHPUT:
 			if (len != 4)
 				return false;
@@ -645,6 +644,22 @@ static bool netdev_parse_sta_info(struct l_genl_attr *attr,
 			info->expected_throughput = l_get_u32(data);
 			info->have_expected_throughput = true;
 
+			break;
+		case NL80211_STA_INFO_INACTIVE_TIME:
+			if (len != 4)
+				return false;
+
+			info->inactive_time = l_get_u32(data);
+			info->have_inactive_time = true;
+
+			break;
+		case NL80211_STA_INFO_CONNECTED_TIME:
+			if (len != 4)
+				return false;
+
+			info->connected_time = l_get_u32(data);
+			info->have_connected_time = true;
+
 			break;
 		}
 	}
-- 
2.43.0

