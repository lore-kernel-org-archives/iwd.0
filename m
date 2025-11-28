Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013022.outbound.protection.outlook.com [40.107.162.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E3A3254AA
	for <iwd@lists.linux.dev>; Fri, 28 Nov 2025 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330915; cv=fail; b=BndWOrwJUD+YwRXaWL2jvu/noahyAsPfxP4PqPiSuxA5MRuf+bXJF4oyxZVKGtsWkGQZTszZySo0/Vj7KHstTRD2zwTQ4CT7QVKjD/i/sfE1DBuZvARODw8THD0srOsAJoRH3yS5gJk6GlW5VGbuguKrDLDN7VaJiLxjNzpWLTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330915; c=relaxed/simple;
	bh=d5CGysjF+t1y9YfjPyLLt813MePsxmdxmx+jSByZLII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=iE7NytL/pM0SHCSNJs6QzzwOTuqgmZXpbZ7t9oTDu8UZQGZ3wEj5ESWJBR5GtJ2CKKHIHV57dj0D2tCpEKZaqyq98zcbGHn/YMgdTDGj9QLiC1MuviAAgfJPDqrF16v7TBmLpCmDy5qZfNSmX996lFxG3VZqDuHzS2tk+YNtEKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=NBp/vth2; arc=fail smtp.client-ip=40.107.162.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="NBp/vth2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5CZHX/qD3sscDQ+lws3OZAYyFofD3nLOePD4QJ0e+ceE9YL/buRnsOGS/XyItaXYuiveNDHeiyt84zk3+nqqVIPfE9II/y4uNpx05DKKMNJ8mgdP4GmPFb8iuGJL2eq6bOW2ZulqT9hfTqFJPoMt+iVi/SOK+qi2fHFbNieuRnY8HxxOcFQpCB9Khy/K34dHuCxQwRxDhCFNVafCpqtWSfqxijleelbyHk+N1TbrZdPKOAx1O21jji4Q1viG5JAvZCzrzZVozzvhwLgNxoqCRATk/JHNnmlTo2nhAvgvVUx7cpVqyDYQuJj60qfzlJ488ohUJ2cj6bP8jxiwILDGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oiz4jsyjJOn3rtm87M6HxQJeINQq3tTlOEzP/WNXmwo=;
 b=in8Ga1eN8vx8iPUD6azXnxkv1h74embEBdkD5JgEfdpdcFvts2YBh250gnsKt1TDO6A5mf7DjqjJB8R/PKQvQrDL8VP2vdbnedIy+74ukMvFU2Sd5vNEV5YXq7uTySnTlIHeSAoh5qAaJu7tC1ItjfWEowUxQo8r/Pv/uIxQLyheL1an7EHGsh4Dg/v2GMNs8xrf8eF4TwGZoGqe91tiQjzOjKOoxBRYDWbDvhCObiWZZFIcO8q74IGF1Z8wFxaP3vypIysTuxqCcFiPKZvq2y3YTvoX066THbBHLBivP0M8SSVybxxH4+FvBJoSx7PzWsGkXeQ4QSoJbSqF9XxlWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oiz4jsyjJOn3rtm87M6HxQJeINQq3tTlOEzP/WNXmwo=;
 b=NBp/vth20wy3amsWwsg/a+/NQ/XRLuA/jUrLAID4VwWQN09ZFZCGLi5GT4CUtvUuL3oD0etWZh74p2ouqAQ+zFzaTQlSKSCc8SmTbd/zrJjBzwLtIZKNeR4tB/v7g7U9hzvOruO5v/gGpCn29R6InGrbH1FwhvEJCZq1xhBILgM=
Received: from DB3PR08CA0007.eurprd08.prod.outlook.com (2603:10a6:8::20) by
 AM9PR02MB7012.eurprd02.prod.outlook.com (2603:10a6:20b:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 11:55:09 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:8:0:cafe::38) by DB3PR08CA0007.outlook.office365.com
 (2603:10a6:8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Fri,
 28 Nov 2025 11:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 11:55:09 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 28 Nov
 2025 12:55:07 +0100
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 28 Nov
 2025 12:55:07 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 28 Nov 2025 12:55:07 +0100
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 7173BACE
	for <iwd@lists.linux.dev>; Fri, 28 Nov 2025 12:55:07 +0100 (CET)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 71937286516B; Fri, 28 Nov 2025 12:55:07 +0100 (CET)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Date: Fri, 28 Nov 2025 12:54:24 +0100
Subject: [PATCH v5 3/8] station: improve roam scan strategy
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251128-roam-scan-improvements-v5-3-285ff0104188@axis.com>
References: <20251128-roam-scan-improvements-v5-0-285ff0104188@axis.com>
In-Reply-To: <20251128-roam-scan-improvements-v5-0-285ff0104188@axis.com>
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|AM9PR02MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 66de71b9-be55-4ed6-3ad1-08de2e74fae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3pQU3YrQUswTGFJZHVEUXAzM1diRXhNMzBVMkgrWmxqaUhTZzJKYmhzTC8z?=
 =?utf-8?B?azkwUGZpbjZ4S3E0M05hNzdhRFdGaE9ISXB3bE9YTTh6cUpJc2pNQnZIWThE?=
 =?utf-8?B?QWdhMWxOUmhFRE4rUHdjbjMvakk5NW5SZDlVazNoT3FKU2tLUU9nL05kc1d1?=
 =?utf-8?B?U01ueElneldXZEVTb2JxTmM3Y01zOWYzUlMyTTJHV05NU0xBQ095a0ZySmVx?=
 =?utf-8?B?TFAyWFFqL1I0aVBKQktEanExSU9EdG1sdnIvdXQ5TTdKb1JaSGs0MWVDVnhI?=
 =?utf-8?B?azFCQlRUV0FhMWlSdWtmSUlFR2I3ZEZKZU1xWDhPZG1kVXg5REtZVndUaFp1?=
 =?utf-8?B?bktaK3VRMHdlWkFiWWhaMWlKYjFRVURXek5lbnZIb2VRZHlXRWFrd2xXbkRX?=
 =?utf-8?B?aXp3V0UybnBHMTlvak5mVkxlelltRXhyUDZsUEI2bmRaRVB2NDJGbTYvSUZ4?=
 =?utf-8?B?YVZvelBSTHVCVDVXcGZ6Q2s1blljakE2UitML0lzWGxDM281Y0ozZVFNSWli?=
 =?utf-8?B?bUt4eUJQZ0pHdi9NRVRLN01zdy9aWmhGYnFielhkeGR1cTNGZlk1eXJzMDB5?=
 =?utf-8?B?U3RYMEQ4MDhGeU9qUXJzekZtcVFITW5rZXlTdXc5ZC92b2RCY0pWRTdmcnhW?=
 =?utf-8?B?eGs2Mm82WGhyQkRQbXhOT29CMlhVekxOOUVjQ0g1VndrZ0hFcUNIb3VCZEtw?=
 =?utf-8?B?VkprcEY0LytGR3JyZ3pvOXJNY2kwYVpORFgzMWhBV2IrV3NkVVZZa0UzblRq?=
 =?utf-8?B?N2g1NmpEd010MmIrS3N3aE15MHlXMWFTNXh2ZkdjNlZodDNNdFNHT08yMmkv?=
 =?utf-8?B?MmVZcVFiLzFJS3NsZVM3bzI0aVV0L21oNjVTRGEwTmtnZ0dGSnVMV0VtYmM5?=
 =?utf-8?B?TnZxMjdheDFIYVQ0K05wN2k4eWllWHNWajBac3MvTjZpbVhOMXdCZWtvb0g4?=
 =?utf-8?B?THUwSU5wN3JmVUxSa3FVV2paSXZuNzcxcTAwdXA4S2dwejJ6a2RKTjVCVnZ6?=
 =?utf-8?B?QmtkdU1UcE5LVmZNUkRMWDU3Q2Vlek4wSVJEOS9CKzg3YTR1RHNTQ29xN2Qv?=
 =?utf-8?B?RzlrMXJaQzdHdElZZVRvU0NLVDNweEthQVF5Q1ZWLzVnNnFMVEc2ZHJsWmFs?=
 =?utf-8?B?Y0YrT3hOT3RLTGExVFgxaks4d3REaS9DRWtaQVArQlgvU2VEUGs0TDkvNm0x?=
 =?utf-8?B?eTJ4Q3AwRURPaVFjTnYvcTk3bExQV0srWk52c2krNktHaWo0QWUxOFpGUG43?=
 =?utf-8?B?RnpIN0ozcmtqWmpGSUMzZmhZVVRzd3d3OGdZa2dnWjhaWVNvMVd6L29jaHlR?=
 =?utf-8?B?TEg1RFA4UUo1U2ZjSjEvUGx3enZrbmY1c08zWDFuWnlpMkFvbWxmQ012R0pL?=
 =?utf-8?B?Wm5MVDNqdThMczRuV0xvSmJBZWk1dzN6ZDA5eUkxSU9kbWNsam1XVWdHZGM5?=
 =?utf-8?B?OXBPOG9aL2VIbVM4MyswSU03UmpudVgramxSWG96azdQemFMYlU1RE5Ud3Rh?=
 =?utf-8?B?UkJRa3RvYXZjWTVua2tGVjdaeldQaXBpeEtFSS9XUHc2NnJuRENVOU5xaGtR?=
 =?utf-8?B?ZzhiY1BKM2xOZkx0Wkg5VE1FLy9YRGs2SGlqaHJWZDlNYzRUbjJoclFEdjk4?=
 =?utf-8?B?QVhZbU1LYXpTMEE1aXBLbUVZVytNNldBajJsaE5aSWRRaFM5TXFpQlRnczRW?=
 =?utf-8?B?REZneHVpclhuTEM3bWErTGgwNTNhSllNbXo2b2owN09MSk5LTFh0VEpObkN6?=
 =?utf-8?B?T1BpaklZQ3dMd24rQkdwOWFBTHJEb3NrRUdBdEtUOG5hajIwSGRYYVV3WnlV?=
 =?utf-8?B?QTU5bktkNjU1OEJzeldGcGgreW0veXpIeFF3M3B3UVN2dFNOaXVCRnJwMzZM?=
 =?utf-8?B?ei9QNmtBUFV3dEVMOUloNFlkWjVFS2pvVVZaUVhSL01WKzBiMkh0QzFLaDd4?=
 =?utf-8?B?aEZrdDhqQmNBdkNRNjd0Sm0zMW5JeEJGdENxdFgyVWVxQ2g2YXpjYkRsOVoy?=
 =?utf-8?B?ZGRkSG5iSG1hRWhUTHN0UDlyUUlSOUNkU0pVblJ3dVNmVDFpNnZMNng5R05l?=
 =?utf-8?B?eEV3L215aU1HdUEvN2xidmtGUW90cDZaQ1h4djF3djZuUGRuZVFrWGNUSk1n?=
 =?utf-8?Q?cVuo=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 11:55:09.3142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66de71b9-be55-4ed6-3ad1-08de2e74fae6
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7012

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
 src/station.c | 250 +++++++++++++++++++++++++++-------------------------------
 1 file changed, 118 insertions(+), 132 deletions(-)

diff --git a/src/station.c b/src/station.c
index 15937fbe..05530813 100644
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
-	 */
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
+	 * Keep trying to roam if the signal is still low, or we were told by the AP
+	 * to roam but failed.
 	 */
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
@@ -3080,108 +3071,103 @@ static int station_roam_scan(struct station *station,
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
+	const struct network_info *info;
 
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
+	info = network_get_info(station->connected_network);
+	tmp = network_info_get_roam_frequencies(info,
+					station->connected_bss->frequency,
+					STATION_RECENT_FREQS_LIMIT);
+	scan_freq_set_foreach(tmp, station_filter_roam_scan_freq, station);
+	scan_freq_set_free(tmp);
+	if (scan_freq_set_size(station->scan_freqs) >= STATION_MAX_SCAN_FREQS) {
 		return;
 	}
 
-	parse_neighbor_report(station, reports, reports_len, &freq_set);
+	/* Add frequencies based on the prioritized subsets */
+	for (uint8_t i = 0; i < L_ARRAY_SIZE(station->scan_freqs_order); i++) {
+		scan_freq_set_foreach(station->scan_freqs_order[i], station_filter_roam_scan_freq, station);
+		if (scan_freq_set_size(station->scan_freqs) >= STATION_MAX_SCAN_FREQS) {
+			return;
+		}
+	}
 
-	r = station_roam_scan(station, freq_set);
+	if (scan_freq_set_size(station->scan_freqs) <= STATION_MAX_SCAN_FREQS) {
+		/* All freqs have been scanned after this, so empty the list of scanned
+		 * freqs to restart */
+		scan_freq_set_free(station->scanned_freqs);
+		station->scanned_freqs = scan_freq_set_new();
 
-	if (freq_set)
-		scan_freq_set_free(freq_set);
+		/* At this point we've gone through all frequencies, which is equivalent to
+		 * a full scan */
+		station_debug_event(station, "full-roam-scan");
 
-	if (r < 0)
-		station_roam_failed(station);
+		/* If we were told by the AP to roam, we've now made the best possible
+		 * effort to do so, clear the flag to stop trying to roam */
+		station->ap_directed_roaming = false;
+	}
 }
 
 static void station_start_roam(struct station *station)
 {
-	int r;
-
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
@@ -3395,20 +3381,12 @@ static void station_ap_directed_roam(struct station *station,
 		l_debug("roam: AP sent a preferred candidate list");
 		station_neighbor_report_cb(station->netdev, 0, body + pos,
 				body_len - pos, station);
-	} else {
-		if (station->connected_bss->cap_rm_neighbor_report) {
-			if (!netdev_neighbor_report_req(station->netdev,
-					station_neighbor_report_cb))
-				return;
-
-			l_warn("failed to request neighbor report!");
-		}
-
-		l_debug("full scan after BSS transition request");
-		if (station_roam_scan(station, NULL) < 0)
-			station_roam_failed(station);
 	}
 
+	/* Initiate roaming, any candidates will be scanned and roaming will continue
+	 * until successful if ap_directed_roaming is set */
+	station_start_roam(station);
+
 	return;
 
 format_error:
@@ -3624,7 +3602,7 @@ static void station_connect_ok(struct station *station)
 	 */
 	if (station->connected_bss->cap_rm_neighbor_report) {
 		if (netdev_neighbor_report_req(station->netdev,
-					station_early_neighbor_report_cb) < 0)
+					station_neighbor_report_cb) < 0)
 			l_warn("Could not request neighbor report");
 	}
 
@@ -5229,6 +5207,9 @@ static struct station *station_create(struct netdev *netdev)
 	station->roam_bss_list = l_queue_new();
 	station->affinities = l_queue_new();
 
+	station->scanned_freqs = scan_freq_set_new();
+	station->roam_scans_since_neighbor_scan = STATION_SCANS_BEFORE_NEIGHBOR_SCAN;
+
 	return station;
 }
 
@@ -5327,6 +5308,11 @@ static void station_free(struct station *station)
 
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

