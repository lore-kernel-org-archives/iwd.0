Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013066.outbound.protection.outlook.com [52.101.83.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B67227B33E
	for <iwd@lists.linux.dev>; Fri, 29 Aug 2025 07:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453515; cv=fail; b=imW8umh5Ag+Pl+ias32PTbMPDKMPDTyXNTzXzcBpIP1FmM0VKb/wlTzFS9j+bVzdqAkLcX9avGdsEAryHJnm7tJ3aaGQFD2iA/eaKYs8bgNk+dQBVoFjxpOqUj2VRGq7k+2m+Z0TTxbJPVMpuyeXU9I5gMJx6t1sDcpLfM8kGYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453515; c=relaxed/simple;
	bh=vrWd5AFdzkc6ZlLN5ilfYD6b2WOvQ13F2dhl36CMFI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=r/bi7xGBZbj5zbfxJiYx2feG1X/L/kXtKO/cJtUzQ737+0z2Oo3oPSmZGhiiTy6X/JlaqrunbR8EBzBnTKhHi+luba4rZCbKOFXkmeDPkPGojZOb77BJWDraAFdfjZ2DAWu/fu2Y2L3ZTaxjV6uvlbKqu2C1ehpP7Thza9WhqMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=oNt5l0tf; arc=fail smtp.client-ip=52.101.83.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="oNt5l0tf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xsfz6EfJk2A6YwjKRZyFvwSFwafFmuthy78U9qg1+RYtdXSCXVcZfmoFcpLu6BnVfnMVVqZwPRPAOHngeUaDHD0EIZ5GH2WtLdirSWwcHo6ArjKcGUj1ItfPYTJs8nH9iDrgtacPdwn3WmkX85QeUlhWed+FjhDox09UHcbkHn6F2aMJMApdX+rWIIUGj4Cl0PAJsJKyPyX4h4pfn1Ok7xET8vFIe+tEg3nP7J2Sxg8UWqs1JdbPgnDSj56+LPxThS5KKCp1zrax7xyvnD7Qix2rQ87QNY66v13Zr1utnYFrlqGsUrYUw6FXuPoA10CAxLisE1BrGtwYEbK8TBFpfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kyjaopl/peaw7Go84VWjlvcXfNXIigx/ukbOdoKAVKk=;
 b=JZraHcnpQ3GGRVNi7xOn/1tvDiBq6CIvHN50r2rfNIcmSNOkKQR4KAi3Aunh3+dLJM1Ej1qzrZYqQoiTiN5bkl19l4JR/oSn88uJQy8lF4zQh9NRF/ccQv5xh/A7CumhY+sJjcBHy3BWPpKfOF4OgcgF9H/eyH5Hc2k46PiRm7lzYZ34lSCJD0ne3JLW7lpcsIvWpXkyFXrzWfk0oWA/TokjGoWUDN4AYf4EDGr2zmNHS+QObLI8IqmrN+Y/RK7WLkHImEaSNi7CG47oZsn+zUpt7+sGgpLvnzgD/tjVHFLU4uXBkqcH/dP3xu27dVhQozJHDJyudI/rOXOLVUs9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kyjaopl/peaw7Go84VWjlvcXfNXIigx/ukbOdoKAVKk=;
 b=oNt5l0tf9jtFmohSRw7MpZpxdC+FY1uzrFWRBBAWmEdl5sol/y5VieHLC1Movg4rOGG/39F28LHGYA5a+1rJoMOQ87BGI+qEOVZZzk15WRJlDCTPWL9NnHEXEAf9d0tEELbPo4JQ1i3p+8V5Dgz3OqJ9Xq9d5miK46c7QMDMR0s=
Received: from AS9PR06CA0507.eurprd06.prod.outlook.com (2603:10a6:20b:49b::33)
 by AS8PR02MB6693.eurprd02.prod.outlook.com (2603:10a6:20b:25c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.19; Fri, 29 Aug
 2025 07:45:06 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:20b:49b:cafe::9c) by AS9PR06CA0507.outlook.office365.com
 (2603:10a6:20b:49b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.19 via Frontend Transport; Fri,
 29 Aug 2025 07:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 07:45:06 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Fri, 29 Aug
 2025 09:45:04 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 29 Aug 2025 09:45:04 +0200
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 9F82284A
	for <iwd@lists.linux.dev>; Fri, 29 Aug 2025 09:45:04 +0200 (CEST)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 9A9E32856ADE; Fri, 29 Aug 2025 09:45:04 +0200 (CEST)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Date: Fri, 29 Aug 2025 09:43:41 +0200
Subject: [PATCH v2 3/3] station: improve roam scan strategy
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250829-roam-scan-improvements-v2-3-888c6bbdd310@axis.com>
References: <20250829-roam-scan-improvements-v2-0-888c6bbdd310@axis.com>
In-Reply-To: <20250829-roam-scan-improvements-v2-0-888c6bbdd310@axis.com>
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C713:EE_|AS8PR02MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8cfbc4-fd78-4e78-e4eb-08dde6cff8b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2ZxaFRmeVRFWFVtUFVueHhXWDlhSHEvY0JxelB5T09sYW4vRitLYzFaemlN?=
 =?utf-8?B?UHZFd1JhK3hLc1pWYkR5anNpRlRlZUR0R0VRbm05dnJxdjlHdEVIMEpVN2ox?=
 =?utf-8?B?ZEY2T2pId0tKMkxJNDNBd0Y3bWd2c0k3ekE5K0p0SU4zNjFRZWRROWNMZXRl?=
 =?utf-8?B?Z2E0YUluWFNPQ3hYcmFPdEFRTDZTMUV1cmRGNG0zTjhMTkxXazRhdGFXeU5M?=
 =?utf-8?B?bE9SREhxckFWcVNEQml1elpDeHQwTnNrYzgvUmxWcVBsWEVHL2IwOGxYcHMy?=
 =?utf-8?B?RVVZR1gxZG5SZ0gyVUJXWkd0TStrUm8rUC9wMko0VlBObURpbUU1M1ZiN3dG?=
 =?utf-8?B?MHRBL00zbkYwTGY2ekJad01lTy90UGdmZWJBTm5ZUVBrQ3V5bUIxVmNkTnVQ?=
 =?utf-8?B?V09LQWFSN1RhNmRWbnVsZ0RCOTB1blVKT2NXd2J0MzlRclQ3eXpqUjRlcTRT?=
 =?utf-8?B?dk9aeDM2SmZCUmZBZ3FWQzVFZEg0cFBMUEFwK29pMXUyU2xFMjEyVjlPbitj?=
 =?utf-8?B?ZWZ2M2huR3RhQko0d2Z2UFdwcjNGeUlKU29XWmo1RTZDZ29qWDQwNUFpVGhJ?=
 =?utf-8?B?Y1I3dkxjOHFYNVlWYnRIdVFlQklpT2lBOGpjcWdZYXpVaSt5ZEFudUNES0My?=
 =?utf-8?B?dmVkNjFHeHVxSUJraWY5VzhxUzd1OXk0SUFYQmxrTXczVGxZdVBESDFtMDIr?=
 =?utf-8?B?bldCT1JNUC9DWC9xcG1NVm9HZGtXdmRJVDJybkNaN2JrdW9Sbm9ZL1ZMNWlN?=
 =?utf-8?B?SmtKWi9iYURETXJYN0ZjL3ZsUzREYWJkWC91SGpRbXlpNXg3Y2lENGc4K3lJ?=
 =?utf-8?B?UXhlSjdHMHRvZ3Urbi9paWZBNDRVdTZtV1RiREs5bCtsczgwaHBiVnh3cWls?=
 =?utf-8?B?YTBsSzFEYjNicjJ0TlRmUzZMREMrUHZGeFZXbFhmQURYd25XR0NaNTVtTk1w?=
 =?utf-8?B?NUxiOTJWdUVaaUdwK3ZUMnc4MFk3YkNMNW5VNElpQzVuNXB0MHZDU2g0RGdh?=
 =?utf-8?B?b0VVelkrd1g2S0VOOG5rSDFuSXA2QjVsbEZzYmxSdjR2bThiS0d1Vm51QlpE?=
 =?utf-8?B?NVV2N1VJbHRwamU0OHN6anR4TkZMSDNwcU1tRXR2QmFCalVWRmhUN25CZnZj?=
 =?utf-8?B?VmkySjlyQng3ZkFBQXhDWDd4cGNTc2FjNERRUmEzbi9lUFVlZjM4VDdOV2Y1?=
 =?utf-8?B?b3hmMWpOVVZqN1EwNHNpYnNoSXJIdkZLaEY0bmpOa2Zsbm0rcFRzdDQrQzQx?=
 =?utf-8?B?R1FFQm9QcW5WMDFSZWZ4emx6ZTh2Y0EydGNiR21qVFdZMUE5OFY0OGZhdEZQ?=
 =?utf-8?B?dEVTT3NwZnpxYmpIWXJLSWQxN2s5dFdDQUQ0b1RpOWZlUWU0RGtkZldXNVVM?=
 =?utf-8?B?Mmp1bTE4M2dIT2xBMGZta2dvNTNIaTZKL2pqazhFVzZ5Rnd4VDdNT2dheXVn?=
 =?utf-8?B?S2FKajBocktXSnVwRXBhNHk2RVBtOXFadkVYNjY2eUJ5U3pmZ1dTVFdWZURD?=
 =?utf-8?B?WUNWRjgwYll6RTArZkZCTldoQ2V0Rk03aFlkNEYvSnl6U2VwK2hwQ3hxTWhr?=
 =?utf-8?B?MGZFdHRjNE5TR2R1eEQwMCthY3VpM2ptbW9XLzZ5S1hJL1d6MTJkTGZlNEs0?=
 =?utf-8?B?R2VOOUZVUERzRm5PU0tsTm1oNmE3bk5mdkhWT1pQV0RuL21Cc3A3Q3FvU2Zp?=
 =?utf-8?B?cGMwSTZzTWdBaUNiNnJyM2dVNmVYb3R5akp3VVBzMDBURmVKQ0UybFMrL0Ja?=
 =?utf-8?B?elU2bG1QMEY5VzVRamxkZDZSWVVlYkZjS3ZEMGhDd2pRZ3hpM0RjZTZWMzRp?=
 =?utf-8?B?aW45cURtVTBwYzJYMUlPTmJtcnd0Z1dxZzAyMXpDckc5S1hyUkNIdHJMdEt3?=
 =?utf-8?B?MXVVejRXbFZNMHFvUHBsWWhEVzlmQVVDTmxLZC9wZ1NyR1JvMys5TmNVQWJU?=
 =?utf-8?B?NktKK1FueWxnbHg3c3VCaDZ1S2ZNY1Fma0IwWEdCUlN3MU5LSGJxUUkzK3JV?=
 =?utf-8?B?MWtlWGx5L0tKR3EzbnZoZm5MYXFnNXJ4MUF0YjkwNGI0cTRDVmg4S2NMMC82?=
 =?utf-8?Q?vxBcbp?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:45:06.1261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8cfbc4-fd78-4e78-e4eb-08dde6cff8b4
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6693

From: Alexander Ganslandt <alexanga@axis.com>

When iwd decides to roam, it scans either neighbor freqs or known freqs
(if neighbors are not available). If it fails to roam after getting the
scan results, it scans ALL freqs. There's a high chance that both
neighbor and/or known scans fail to roam and we end up scanning all
freqs. This is very slow and if you're already moving away from the
current BSS, there's a high chance you will lose connection
completely before the scan is finished.

Instead of scanning all freqs at once, use the already-defined subsets
to optimize the scans. The subsets contain a handful of freqs each and
are ordered to increase the chance of finding a good BSS early. In order
to not scan the same freq multiple times, use a list (scanned_freqs) to
keep track of which freqs have been scanned in the current roam attempt.

When a roam scan is triggered, add the most prioritized freqs to the
list of freqs that should be scanned. The order of priority is:

1. Neighbor freqs
2. Known freqs
3. Subsets, starting with index 0 and incrementing if the subset is
   exhausted

A freq is only added to the scan if it has not yet been scanned in the
current roam attempt. An exception to this are neighbor freqs. They have
a higher chance of containing good BSSes, so they're scanned every 3rd
scan (defined by STATION_SCANS_BEFORE_NEIGHBOR_SCAN).

This approach results in more scans, but fewer freqs per scan, leading
to shorter delays between scan results. It also avoids scanning the same
freqs back-to-back, which is generally not very useful. In combination
with the subset ordering, this increases the chance of finding a good
BSS early and results in better roaming performance.
---
 src/station.c | 228 ++++++++++++++++++++++++++++------------------------------
 1 file changed, 108 insertions(+), 120 deletions(-)

diff --git a/src/station.c b/src/station.c
index c2e18fc9..0aef46ec 100644
--- a/src/station.c
+++ b/src/station.c
@@ -68,6 +68,8 @@
 
 #define STATION_RECENT_NETWORK_LIMIT	5
 #define STATION_RECENT_FREQS_LIMIT	5
+#define STATION_MAX_SCAN_FREQS	10
+#define STATION_SCANS_BEFORE_NEIGHBOR_SCAN	2
 
 static struct l_queue *station_list;
 static uint32_t netdev_watch;
@@ -123,6 +125,9 @@ struct station {
 	/* Set of frequencies to scan first when attempting a roam */
 	struct scan_freq_set *roam_freqs;
 	struct l_queue *roam_bss_list;
+	struct scan_freq_set *scan_freqs;
+	struct scan_freq_set *scanned_freqs;
+	uint8_t roam_scans_since_neighbor_scan;
 
 	/* Frequencies split into subsets by priority */
 	struct scan_freq_set *scan_freqs_order[5];
@@ -141,7 +146,6 @@ struct station {
 	struct handshake_state *hs;
 
 	bool preparing_roam : 1;
-	bool roam_scan_full : 1;
 	bool signal_low : 1;
 	bool ap_directed_roaming : 1;
 	bool scanning : 1;
@@ -1940,7 +1944,6 @@ static void station_roam_state_clear(struct station *station)
 	l_timeout_remove(station->roam_trigger_timeout);
 	station->roam_trigger_timeout = NULL;
 	station->preparing_roam = false;
-	station->roam_scan_full = false;
 	station->signal_low = false;
 	station->netconfig_after_roam = false;
 	station->last_roam_scan = 0;
@@ -2205,27 +2208,6 @@ static void parse_neighbor_report(struct station *station,
 	}
 }
 
-static void station_early_neighbor_report_cb(struct netdev *netdev, int err,
-						const uint8_t *reports,
-						size_t reports_len,
-						void *user_data)
-{
-	struct station *station = user_data;
-
-	if (err == -ENODEV)
-		return;
-
-	l_debug("ifindex: %u, error: %d(%s)",
-			netdev_get_ifindex(station->netdev),
-			err, err < 0 ? strerror(-err) : "");
-
-	if (!reports || err)
-		return;
-
-	parse_neighbor_report(station, reports, reports_len,
-				&station->roam_freqs);
-}
-
 static bool station_try_next_bss(struct station *station)
 {
 	struct scan_bss *next;
@@ -2360,9 +2342,32 @@ static bool netconfig_after_roam(struct station *station)
 	return true;
 }
 
+static void station_neighbor_report_cb(struct netdev *netdev, int err,
+					const uint8_t *reports,
+					size_t reports_len, void *user_data)
+{
+	struct station *station = user_data;
+
+	if (err == -ENODEV)
+		return;
+
+	l_debug("ifindex: %u, error: %d(%s)",
+			netdev_get_ifindex(station->netdev),
+			err, err < 0 ? strerror(-err) : "");
+
+	if (!reports || err) {
+		l_debug("no neighbor report results");
+		return;
+	}
+
+	parse_neighbor_report(station, reports, reports_len, &station->roam_freqs);
+}
+
 static void station_roamed(struct station *station)
 {
-	station->roam_scan_full = false;
+	scan_freq_set_free(station->scanned_freqs);
+	station->scanned_freqs = scan_freq_set_new();
+	station->roam_scans_since_neighbor_scan = STATION_SCANS_BEFORE_NEIGHBOR_SCAN;
 
 	/*
 	 * Schedule another roaming attempt in case the signal continues to
@@ -2382,7 +2387,7 @@ static void station_roamed(struct station *station)
 
 	if (station->connected_bss->cap_rm_neighbor_report) {
 		if (netdev_neighbor_report_req(station->netdev,
-					station_early_neighbor_report_cb) < 0)
+					station_neighbor_report_cb) < 0)
 			l_warn("Could not request neighbor report");
 	}
 
@@ -2404,8 +2409,10 @@ static void station_roam_retry(struct station *station)
 	 * time.
 	 */
 	station->preparing_roam = false;
-	station->roam_scan_full = false;
 	station->ap_directed_roaming = false;
+	scan_freq_set_free(station->scanned_freqs);
+	station->scanned_freqs = scan_freq_set_new();
+	station->roam_scans_since_neighbor_scan = STATION_SCANS_BEFORE_NEIGHBOR_SCAN;
 
 	if (station->roam_freqs) {
 		scan_freq_set_free(station->roam_freqs);
@@ -2416,6 +2423,8 @@ static void station_roam_retry(struct station *station)
 		station_roam_timeout_rearm(station, roam_retry_interval);
 }
 
+static void station_start_roam(struct station *station);
+
 static void station_roam_failed(struct station *station)
 {
 	l_debug("%u", netdev_get_ifindex(station->netdev));
@@ -2438,39 +2447,22 @@ static void station_roam_failed(struct station *station)
 	}
 
 	/*
-	 * We were told by the AP to roam, but failed.  Try ourselves or
-	 * wait for the AP to tell us to roam again
+	 * Keep trying to roam if the signal is still low, or we were told by the AP
+	 * to roam but failed.
 	 */
-	if (station->ap_directed_roaming) {
-		/*
-		 * The candidate list from the AP (or neighbor report) found
-		 * no BSS's. Force a full scan
-		 */
-		if (!station->roam_scan_full)
-			goto full_scan;
-
-		goto delayed_retry;
-	}
-
-	/*
-	 * If we tried a limited scan, failed and the signal is still low,
-	 * repeat with a full scan right away
-	 */
-	if (station->signal_low && !station->roam_scan_full) {
+	if (station->signal_low || station->ap_directed_roaming) {
 		/*
 		 * Since we're re-using roam_scan_id, explicitly cancel
 		 * the scan here, so that the destroy callback is not called
 		 * after the return of this function
 		 */
-full_scan:
 		scan_cancel(netdev_get_wdev_id(station->netdev),
 						station->roam_scan_id);
 
-		if (!station_roam_scan(station, NULL))
-			return;
+		station_start_roam(station);
+		return;
 	}
 
-delayed_retry:
 	station_roam_retry(station);
 }
 
@@ -3057,7 +3049,6 @@ static int station_roam_scan(struct station *station,
 	}
 
 	if (!freq_set) {
-		station->roam_scan_full = true;
 		params.freqs = allowed;
 		station_debug_event(station, "full-roam-scan");
 	} else
@@ -3080,71 +3071,68 @@ static int station_roam_scan(struct station *station,
 	return 0;
 }
 
-static int station_roam_scan_known_freqs(struct station *station)
+static void station_filter_roam_scan_freq(uint32_t freq, void *user_data)
 {
-	const struct network_info *info = network_get_info(
-						station->connected_network);
-	struct scan_freq_set *freqs = network_info_get_roam_frequencies(info,
-					station->connected_bss->frequency,
-					STATION_RECENT_FREQS_LIMIT);
-	int r = -ENODATA;
-
-	if (!freqs)
-		return r;
+	struct station *station = user_data;
 
-	if (!wiphy_constrain_freq_set(station->wiphy, freqs))
-		goto free_set;
+	if (scan_freq_set_size(station->scan_freqs) >= STATION_MAX_SCAN_FREQS)
+		return;
 
-	r = station_roam_scan(station, freqs);
+	/* Skip freq if already scanned */
+	if (scan_freq_set_contains(station->scanned_freqs, freq))
+		return;
 
-free_set:
-	scan_freq_set_free(freqs);
-	return r;
+	scan_freq_set_add(station->scan_freqs, freq);
+	scan_freq_set_add(station->scanned_freqs, freq);
 }
 
-static void station_neighbor_report_cb(struct netdev *netdev, int err,
-					const uint8_t *reports,
-					size_t reports_len, void *user_data)
+static void station_populate_roam_scan_freqs(struct station *station)
 {
-	struct station *station = user_data;
-	struct scan_freq_set *freq_set;
-	int r;
+	struct scan_freq_set *tmp;
 
-	if (err == -ENODEV)
-		return;
+	station->scan_freqs = scan_freq_set_new();
 
-	l_debug("ifindex: %u, error: %d(%s)",
-			netdev_get_ifindex(station->netdev),
-			err, err < 0 ? strerror(-err) : "");
+	/* Add current frequency, always scan this to get updated data for the
+	 * current BSS */
+	scan_freq_set_add(station->scan_freqs, station->connected_bss->frequency);
+	scan_freq_set_add(station->scanned_freqs, station->connected_bss->frequency);
 
-	/*
-	 * Check if we're still attempting to roam -- if dbus Disconnect
-	 * had been called in the meantime we just abort the attempt.
-	 */
-	if (!station->preparing_roam || err == -ENODEV)
+	/* Add neighbor frequencies */
+	if (station->roam_scans_since_neighbor_scan >=
+			STATION_SCANS_BEFORE_NEIGHBOR_SCAN && station->roam_freqs) {
+		station->roam_scans_since_neighbor_scan = 0;
+		scan_freq_set_merge(station->scan_freqs, station->roam_freqs);
+		scan_freq_set_merge(station->scanned_freqs, station->roam_freqs);
 		return;
+	}
+	station->roam_scans_since_neighbor_scan++;
 
-	if (!reports || err) {
-		r = station_roam_scan_known_freqs(station);
-
-		if (r == -ENODATA)
-			l_debug("no neighbor report results or known freqs");
-
-		if (r < 0)
-			station_roam_failed(station);
-
+	/* Add known frequencies */
+	const struct network_info *info = network_get_info(
+						station->connected_network);
+	tmp = network_info_get_roam_frequencies(info,
+					station->connected_bss->frequency,
+					STATION_RECENT_FREQS_LIMIT);
+	scan_freq_set_foreach(tmp, station_filter_roam_scan_freq, station);
+	scan_freq_set_free(tmp);
+	if (scan_freq_set_size(station->scan_freqs) >= STATION_MAX_SCAN_FREQS) {
 		return;
 	}
 
-	parse_neighbor_report(station, reports, reports_len, &freq_set);
-
-	r = station_roam_scan(station, freq_set);
-
-	if (freq_set)
-		scan_freq_set_free(freq_set);
+	/* Add frequencies based on the prioritized subsets */
+	for (uint8_t i = 0; i < L_ARRAY_SIZE(station->scan_freqs_order); i++) {
+		scan_freq_set_foreach(station->scan_freqs_order[i], station_filter_roam_scan_freq, station);
+		if (scan_freq_set_size(station->scan_freqs) >= STATION_MAX_SCAN_FREQS) {
+			return;
+		}
+	}
 
-	if (r < 0)
-		station_roam_failed(station);
+	if (scan_freq_set_size(station->scan_freqs) <= STATION_MAX_SCAN_FREQS) {
+		/* All freqs have been scanned after this, so empty the list of scanned
+		 * freqs to restart */
+		scan_freq_set_free(station->scanned_freqs);
+		station->scanned_freqs = scan_freq_set_new();
+	}
 }
 
 static void station_start_roam(struct station *station)
@@ -3154,34 +3142,26 @@ static void station_start_roam(struct station *station)
 	station->preparing_roam = true;
 
 	/*
-	 * If current BSS supports Neighbor Reports, narrow the scan down
-	 * to channels occupied by known neighbors in the ESS. If no neighbor
-	 * report was obtained upon connection, request one now. This isn't
-	 * 100% reliable as the neighbor lists are not required to be
-	 * complete or current.  It is likely still better than doing a
-	 * full scan.  10.11.10.1: "A neighbor report may not be exhaustive
-	 * either by choice, or due to the fact that there may be neighbor
-	 * APs not known to the AP."
+	 * If no neighbor report was obtained upon connection, request one now if BSS
+	 * supports it. This isn't 100% reliable as the neighbor lists are not
+	 * required to be complete or current.
+	 * 10.11.10.1: "A neighbor report may not be exhaustive either by choice, or
+	 * due to the fact that there may be neighbor APs not known to the AP."
+	 *
+	 * Continue roaming while waiting for the neighbor report, the neighbors will
+	 * be added to the roam scan when/if they're available.
 	 */
-	if (station->roam_freqs) {
-		if (station_roam_scan(station, station->roam_freqs) == 0) {
-			l_debug("Using cached neighbor report for roam");
-			return;
-		}
-	} else if (station->connected_bss->cap_rm_neighbor_report) {
+	if (!station->roam_freqs && station->connected_bss->cap_rm_neighbor_report) {
 		if (netdev_neighbor_report_req(station->netdev,
 					station_neighbor_report_cb) == 0) {
 			l_debug("Requesting neighbor report for roam");
-			return;
 		}
 	}
 
-	r = station_roam_scan_known_freqs(station);
-	if (r == -ENODATA)
-		l_debug("No neighbor report or known frequencies, roam failed");
-
-	if (r < 0)
-		station_roam_failed(station);
+	station_populate_roam_scan_freqs(station);
+	station_roam_scan(station, station->scan_freqs);
+	scan_freq_set_free(station->scan_freqs);
+	station->scan_freqs = NULL;
 }
 
 static bool station_cannot_roam(struct station *station)
@@ -3624,7 +3604,7 @@ static void station_connect_ok(struct station *station)
 	 */
 	if (station->connected_bss->cap_rm_neighbor_report) {
 		if (netdev_neighbor_report_req(station->netdev,
-					station_early_neighbor_report_cb) < 0)
+					station_neighbor_report_cb) < 0)
 			l_warn("Could not request neighbor report");
 	}
 
@@ -5246,6 +5226,9 @@ static struct station *station_create(struct netdev *netdev)
 	station->roam_bss_list = l_queue_new();
 	station->affinities = l_queue_new();
 
+	station->scanned_freqs = scan_freq_set_new();
+	station->roam_scans_since_neighbor_scan = STATION_SCANS_BEFORE_NEIGHBOR_SCAN;
+
 	return station;
 }
 
@@ -5344,6 +5327,11 @@ static void station_free(struct station *station)
 
 	l_queue_destroy(station->affinities, l_free);
 
+	scan_freq_set_free(station->scanned_freqs);
+
+	if (station->scan_freqs)
+		scan_freq_set_free(station->scan_freqs);
+
 	l_free(station);
 }
 

-- 
2.39.5

