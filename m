Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013068.outbound.protection.outlook.com [52.101.72.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6272D2DF150
	for <iwd@lists.linux.dev>; Fri, 12 Sep 2025 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671770; cv=fail; b=bR/8gYMlIerCmeJh1jrSdoVtQkRx3pMb/v7ZWRgNOWOcRJTSLKK4TccmQ+AHzR5l5jBI0q4tfyRFbKdPd8kw0PFUNr4DT+uZwyLrv2Ypqx/BH0qa6J95MlchwTL3CD4C/6ymsXaYanWLVcG9x24b7sGmwLOa6kMoOYQY7WyFfpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671770; c=relaxed/simple;
	bh=8+MGEy4s+LsqP7PwKkvAaEro+qyD7nhB9rHovBM4C4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=hhWadPp6ZoDVjL4X+UwuvGpqhThtw0/4BRPXqNBp6du599mVMlO3mEhnaLp8zjWMIZpMJQ+von94DsMe4Aq2Kd42lg68zlxxmh0gfnqxdbAmcnF7mEQ4+DJ4fJVWxcHz323I0FUcVtvwyghnrT9+4om5Nsp+0TySzR9kiZTcDs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Qc7rnGrn; arc=fail smtp.client-ip=52.101.72.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Qc7rnGrn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agHiVYd47F+czLp+ypv3izVXoMUOLdSUb5L08oc1aSeGXXBK2lpzYfZLL6KqJbXDHrFxaGt4JOJEAsg88Cn8d3/EKUprqdlgXqLhLTLTLgww7UyL+rdXu2lBotbZiToe4tJbTjZINjh327s3ERmcPUFMdr0GShSdSSyrHsON80tn8jzRXtRAQnQ5sNVS8ueGzf0UFmvQa7fLP0S//BYZp3kvudVLB6/YQzmWxgiHYlfhJpp008ETB1PuQunF0lJbq64nVVdj+/L3wRorOd52gxFkIT83zqtsCe9+rSih6F34vUZQ3kKAOdf7FsTnbliUTY7fhJ+6dZZfVMrE9srGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyNiCFoJnISmHBUOiNH3J91qKObt4yQlhkdMXClx3OA=;
 b=VOk8U9RbuMdDqZUB0m1uDAUgfA7bD6GJ5r3QPxAo/dlvgYWnj88Wf2NeJR4faQi1jU13YeXgvbS/FUGNFW1TLOuzpWUzHdPbhv5tCtA7jqL5615v1lX8OV50z23TgCAPVSUff7N92yKLJVFCymXl7/kUne2vDFCWgWsj7FcgHbzAF3LZ7TSRO88lfVtzSmdWqkiYfRG9BuXF1iUWaqxi3rjeLlqQ66QBfz7QsK+jp1yl60Jtj75HkahR5C9s9vLE3D4kxKzSwQm/lWcgO8bEI97/ZI0ODE7WpabxeY+Ez3AUXsPZFk8CJXlYxsedSQKklFp2suJaidH/CTGMJJCDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyNiCFoJnISmHBUOiNH3J91qKObt4yQlhkdMXClx3OA=;
 b=Qc7rnGrn/TlAL6F1qU10iZzyZTalc6B+xAAkhqWvHCrQFjwQN2YI+3hNqFx5Nh5hDylgaBRITJe4WQi7yVNdkZx02Q4jsPiOWmeRYWllK6ub0Smnxs4vRuyQb6dXICegD6z/3GYKU+6S6u48cbyTYgh1hx+8/KbWng8YzPGCGHk=
Received: from DUZPR01CA0259.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::7) by PR3PR02MB6426.eurprd02.prod.outlook.com
 (2603:10a6:102:76::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:09:22 +0000
Received: from DB5PEPF00014B8E.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::9a) by DUZPR01CA0259.outlook.office365.com
 (2603:10a6:10:4b9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 10:09:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B8E.mail.protection.outlook.com (10.167.8.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:09:22 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Fri, 12 Sep
 2025 12:09:22 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Sep 2025 12:09:22 +0200
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 192E31E8D
	for <iwd@lists.linux.dev>; Fri, 12 Sep 2025 12:09:22 +0200 (CEST)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 160E4287A99D; Fri, 12 Sep 2025 12:09:22 +0200 (CEST)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Date: Fri, 12 Sep 2025 12:08:53 +0200
Subject: [PATCH v3 3/3] station: improve roam scan strategy
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250912-roam-scan-improvements-v3-3-ebfd61dc6239@axis.com>
References: <20250912-roam-scan-improvements-v3-0-ebfd61dc6239@axis.com>
In-Reply-To: <20250912-roam-scan-improvements-v3-0-ebfd61dc6239@axis.com>
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8E:EE_|PR3PR02MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: b417be55-e98e-4b01-5235-08ddf1e47219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTd5aVBSMENTN2lmUStBekpmTTFVT2NRVHE1Tys4QmluWXAyOFp1UHZEZTda?=
 =?utf-8?B?NDhlb1ZSeTdNNHk2RlpRby94R2dtN2RmcXhmakZDV3Q0YS9NRTArRElSK2J5?=
 =?utf-8?B?RWlHbHFTOUVXNlBodWxkOGZyNnVPbzJaSUdZVnlPYjZRMGw3UnFOTnVZL2xv?=
 =?utf-8?B?bG5OOC9vdUhaUmlFaEhpcjZxV0dWQTFHc1NvOWVUMU1vdGpaYmFOTitXRUVs?=
 =?utf-8?B?K0NLUXZEeHJRYVhtZkY0bnhpSEF4bkovd3FXUGRqRjN6Y3hrZjJ0d1JSaVhs?=
 =?utf-8?B?RkNEQzI0RHlTNXN6Vm5GdXhKdE5BcTlteEtTam15UkdienBXeDhnL004WXNv?=
 =?utf-8?B?TnRNQlNLTjI3Yk5SbnpsUUc5ZUs3NW92RCtvZXdFSlhKNWNZN0MrTXJXWUpR?=
 =?utf-8?B?bVdxZ2k4U01scDZkRkY4N0xSaC95R20wczBBZm54ZURra3NGTXVwSzdxa0NQ?=
 =?utf-8?B?T1pTL0lYakVBZFVmMHhLVkQ5WUwrUXJZbW00cktkRFpGYm8rajROS1NnUjFT?=
 =?utf-8?B?RG4ySGFUYVdlYXQ0OVcxSWhHRW45dXdJRFMyeURkeExYOG93YVlkMU1PYzN1?=
 =?utf-8?B?MVJ0Q29laWFmbTVwL2hOZ0EvTlMyMmM0d2VuVFVGemNLNHNWR0RrNjVuRmRr?=
 =?utf-8?B?cUxxQ09aQ2VIclV3Wk4xQWt5ZjZRTlcvVUtRdFkwM09PcjFKWEJXMEpaQjVa?=
 =?utf-8?B?UkU0Sm9hck04aXkvSEgzcnQ0MStEeDJVclp3TlhZNGFpWXhJTmU5SVhCRUlL?=
 =?utf-8?B?SEJpTWcyTGV2VTJoTExnbGNpKzhCUUdQelp6WnVjMHpBOEJnL3A0WkQwZHNk?=
 =?utf-8?B?OFFkZmlkeDM2NFVCQzdsWmhEaHBPNnFRSmRvbjgrWUJOdDdkQjJqanpyN0x4?=
 =?utf-8?B?eC95TUVYbGNQYzN2Y3poRGpyTEE0Q212bk5CNXZWMHZRSkJ1eG1kdFFrNjlL?=
 =?utf-8?B?SnNVZnQzdVUvSm5RSms1MGV3ZEVPalFpOGhOa2VPbVRVT25iNjF4ZEZxcTM5?=
 =?utf-8?B?V3N1NEtNYnFneDZ5MnplSk1OU2RQQnRQdldnOXh6MG1SZDhVT1duaVdnZk1h?=
 =?utf-8?B?TXJYazFiSmJjWHVENVlMMGRySGhsVk5UcEtRcDNHUFVhMWZkTXNOcVdhQkdv?=
 =?utf-8?B?UDdpSWl6UElQYS9GcjYvcXFDUmc3WWRvdUQ0RXY1RjU2TncySFRNM0ZyZ2lM?=
 =?utf-8?B?bytka2VnMU44QWRMOGUwUHl3RmVYMExSdHlaZGxKZmRPR3cwQmROTW5ENk9N?=
 =?utf-8?B?MklEVUgvQXQxNkdTWmFTOEZ6TlBkWGlrNkxhbmREWmxyM0xlOXBTQnZ6eTMw?=
 =?utf-8?B?S2FBNTdyL0hnanZwT1JQVTdCMDAwKy9tc2MwSFlya3c3R2RhVVB2WTk0cHhj?=
 =?utf-8?B?TTBYdXROUzhpMFBzOFFKa3d0Z1NLM2hkUTFSZkJYN050bGZoYWxGdWZEaWU4?=
 =?utf-8?B?eUhxS2hWZ0lXam1GYUcwcVZjNzlaYkEyY1ZucmwzZzFyYnZlejBDY1NVd0k4?=
 =?utf-8?B?ZHJiZmFSdGU5MHpuUWxlcGhBaFMxeWloV1VvVElrWDBLcXJIdm1GZWxLV3M5?=
 =?utf-8?B?cUFycWQ2eWRubXdyOW5WZ21lSlZoUXdrSHQySGpndDJZcFVGQkxNUTNxUXEr?=
 =?utf-8?B?eHRucS9hdDhqYVVERE5qQndwMS9qZHhJK3lmdXRZUGJZZXUrSkE2Z0p0WVo3?=
 =?utf-8?B?eGZCT3RNNXVqTnBnWFRMSlU4R2RQN3lLcFpYVEVVRHEzZ0F6V1dJWjNoRmsw?=
 =?utf-8?B?QklzK3pEc1ZkOTkvMW5tR0tuV2FZOFE0U1RMZDdUZlpjbjJmZDFSNDQrcWh6?=
 =?utf-8?B?QURZSFJRa2xXTlF5ZldkUVR1a0ZhMG5SVk9NR0tlNXIvajVhWGlRN1plWUpx?=
 =?utf-8?B?ZnhzYVRvcGxkaUFPWW5XdlRSUWpEZVQ0d3Q4NWx4aUpxL3l6dmRUdXhsclNx?=
 =?utf-8?B?blI0WnJuMXVLMXpxcEljRzJHZWkzUVM4UU1OVjlzYTBacjZST01mYWNremNU?=
 =?utf-8?B?NUFzcVVOM3IrSkFOWmdqd0QzYUxMOGhKWkNJRXlZWFFHTDEraUVBY2RacGZE?=
 =?utf-8?Q?jJvE2O?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:09:22.5045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b417be55-e98e-4b01-5235-08ddf1e47219
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6426

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
 src/station.c | 230 +++++++++++++++++++++++++++-------------------------------
 1 file changed, 108 insertions(+), 122 deletions(-)

diff --git a/src/station.c b/src/station.c
index 1b4dd1c8..523cfb0e 100644
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
@@ -3080,108 +3071,95 @@ static int station_roam_scan(struct station *station,
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

