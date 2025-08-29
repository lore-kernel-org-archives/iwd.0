Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF327B331
	for <iwd@lists.linux.dev>; Fri, 29 Aug 2025 07:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453515; cv=fail; b=OGJkufFhXY3kVqza16djmQFgsYNaneY3oT+VN/U9TzG0wJmSr/oubMxIJ2Qe85X8txB+pGSzuzTl7ZAb+8D++1/FDJ4Aqg7wKMax86N7TJBRNckra+ATwctfWNjTMhqf2mVwuQdxvApNVgUN957tfBOvyr1PR+ZD8fHtipGq+Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453515; c=relaxed/simple;
	bh=bCCuEZO2C3G+f7bKe4U14btKOYlAEX+PZtvQKBIjAjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=j9eZnIn4ZczvtNzSqH72GcD2yPQsogkjBPTCn+bnVLhO4eaAVnd6uoZ1Ofa24tad7YChjdu1tm0Yu8slmkmRy/4yAqA+4w8w8QS0jQawgdiTRKdJeVl1bmBe/eTUOFtSfbZisTMSC4CyEOS421BKdA4WFbV6Dk2i5gig9GsPMIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=IfT00xY1; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="IfT00xY1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5TbNYnIRYN6kt4bDqQSGsUcDX1j4Fqv9k0m+AWOvjo3t4L17E27hHQ6SBr2IAgrdfYzXF+XACxcMISwkXwJIq9ValVtyr7wMY5EgZvJ9jthjpcTY8GYJFZHY9x7FGy5fZnCu1RUDmjP9VIc0N+zARymBgsBzka5YZcsrjKx7Qxddy6cp1lZ1851tjWbCH6mM81EDw+j+0JvyLgIhiUg4zYVyUPy9qsqXokI3B2j5Xja2NhWvfdrvfXTgC6SFpMY13sURfPY3zXeXtOpN2+5KDFLFsP2FEfewtDNydxCbmeIwvDSdLiZjUhkzhICUKlzRZ4q4tELBUPCcByTDic4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhcHufAY8NeqTW/ueQeyH/DrAwiMFCymS4KgUYCfyoY=;
 b=HcZ+KX2QA7TMDU7NgL6ir2wFpeUVh1Xlog4UYKIUT+RPSvH2j+Si6PXZ2z+s/eL8dYtkwiMc21+3n227NVoXDlQ4upiv1LRMIV3ggV4A945uEKxFj/LUOIdOOY3OEkHt38pjnkwld++pyNHQErwKc7mAXxSfjROHlm+wfPhCG2vRtTBJNB8GU+Rr32UK9BHDiT7SbEti23HqrbtwucqcmINfYYig0YvGgf5czj60kLBGJ4GjYnhqOtZmQwuNyHwx1Zio4rebykrm6Tp5hE8/sJ5KLRkU2NvfBB7URdnlqRoc++DgZ+HgniPr4u8I/Z+GwJ0hXbNwHxPhA4/HtKxW7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhcHufAY8NeqTW/ueQeyH/DrAwiMFCymS4KgUYCfyoY=;
 b=IfT00xY1QOgsTiwMSY4PJ+3R/KNiuyCSvEJE5voWjVhpq19DCwFFbkiNnAlFkJiZwfbV2bNT6o9XfuVnDzqFYM/M5ahQhF+Fxsatb+ZSzSfd2TkV6Lr37qAwmJia1mqFpB1vmMctaZwXoCesoqZMj0YYkTByu3v4ZD8PzbqUV2g=
Received: from AS9PR06CA0503.eurprd06.prod.outlook.com (2603:10a6:20b:49b::28)
 by DU0PR02MB8595.eurprd02.prod.outlook.com (2603:10a6:10:3ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 29 Aug
 2025 07:45:05 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:20b:49b:cafe::17) by AS9PR06CA0503.outlook.office365.com
 (2603:10a6:20b:49b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.19 via Frontend Transport; Fri,
 29 Aug 2025 07:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 07:45:05 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Fri, 29 Aug
 2025 09:45:04 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 29 Aug 2025 09:45:04 +0200
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 9D74CA1E
	for <iwd@lists.linux.dev>; Fri, 29 Aug 2025 09:45:04 +0200 (CEST)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 98BA72880BD5; Fri, 29 Aug 2025 09:45:04 +0200 (CEST)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Date: Fri, 29 Aug 2025 09:43:40 +0200
Subject: [PATCH v2 2/3] station: improve scan_freqs_order channel subsets
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250829-roam-scan-improvements-v2-2-888c6bbdd310@axis.com>
References: <20250829-roam-scan-improvements-v2-0-888c6bbdd310@axis.com>
In-Reply-To: <20250829-roam-scan-improvements-v2-0-888c6bbdd310@axis.com>
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C713:EE_|DU0PR02MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dccbd11-4318-40e7-b69d-08dde6cff86b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|30052699003|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGZyYzVXVjJOOE1URmN2YzhMcWtTaEQ0U08ySlhIVDBjQ1k3eVYyVndPRU1F?=
 =?utf-8?B?STE2YjhHKzlJRytXNHdyUTJrVGIxZlU2TnZEOTVWaWp0OHlRcFlEVU4vRSta?=
 =?utf-8?B?S3pjUHAyc3JKYTA3RksrVEFBUnF2andUTWFSelBHVXdUTnNGQzJXVEx1Z2li?=
 =?utf-8?B?R3JCQ0ZrMU1Fc09lTmtMOURXUytKZXhZUVltVnV2R1ZrSHFueXZBUWNEU1k4?=
 =?utf-8?B?YlpreFNVd3BjZWFCcGZ1a1B5Z2FrRWJrbEJkZGV4MmZSeFR3QUlIZWVLYi9V?=
 =?utf-8?B?OE5vZkpNSE4vN0NyS3VWVFFYVUMwMDEzdTV4UzBaVE9KeE44c0s3U0ZrUy9u?=
 =?utf-8?B?ZmJQQmg2V2pFTm85L3RwWm1janRlZ2w1VkdobE1tQUt5dVg0enVkWGpPUHgv?=
 =?utf-8?B?bDdXWDJpRk9ZWE9OQ2c0OUtobHFuREgzL0lQVkdIaFBxcVFHU3FXTGtiMkwy?=
 =?utf-8?B?NjJ3MnFlZU9rc295bE8vNjJ3MG5YR2lvYThvR0lNV001RGxML2FRdDBLaWw3?=
 =?utf-8?B?SUZMakUrMUx2WDQ1K3NzM1EvcEt5SU9Ybi9tUmUyQnl0cmdrK0tXSnA1d2ta?=
 =?utf-8?B?QTVQL0xOZUxyMlpoKytOZUpEdXJUaWVYenozVlNQaVpGaW82KzZHU2gwNEE4?=
 =?utf-8?B?NFd4aE9hU1A5M1EvcE0xSzhZVjNUTXRoNmRYZ1ZBb1Q3NFh2dmR2bFBYSkh2?=
 =?utf-8?B?UVUyYTNGTklWSkgvSG5WNEdEL2FFWTdReGFVUTNISGdJaDVzVlFhS0pVd1hj?=
 =?utf-8?B?QVdHVzVGMGpHbW5pMlNvTjBtaWhCVk9CaGRqTFRDa1BDYzFveVV0VWdkZHVw?=
 =?utf-8?B?elZBTWoxL0ViK0FPUkhjcWY4R1ZGRW9yL0NFM3lUQkpvL1ozdG1iQy9DZVE5?=
 =?utf-8?B?RWhYSjlvS0YwbDlQZ2dVM2tKd0pnRWh2OUhOUEp1bWxOWk9PRTh6TXdRYXdI?=
 =?utf-8?B?dXlZUEl6VzNOdDFweGFmeWlMdU8vc1ZndnNtQWNya2tYUXBBNVM2aVlHRzZ5?=
 =?utf-8?B?aEh0SjNoemc3citKeFdCaDNaQWFiMGJqSzBBZTlveGk3ZWVUMC9aTFJFZHRF?=
 =?utf-8?B?bVlJTFVlQnU2aWxnKzg0bEFOMTZ4czR2c1FWblcwcHkxdUw5a0hTd2pjNTRN?=
 =?utf-8?B?ZCtIcGpwK3dEWmZER2lmSWtDNTNlWG1nSmxJQ205b1lyTThzaHpBU1FVbTVD?=
 =?utf-8?B?K3Erdjc1RDM3eDdZT3JtM2phcWxuS21FdVpNTWhTOXpVRE1HRldlU0MwV21w?=
 =?utf-8?B?NVRwUk9RbFd4Nkp2K1JqejZmb1NqNlpXYTZ5U2JJUDQ4OWJ6Z2w0WFZPRDVu?=
 =?utf-8?B?cFdDTmRZbGpBOFk1UWtHVmRrUWxWUjRSbzJ4U2s4blBNT3VqdXI5YXd3WDRI?=
 =?utf-8?B?bVc1cFJYRW55MzdIQ05TekpVQ0YwVUJVeVlNL0g1OXVYUE1vRHZhV2ViWEtp?=
 =?utf-8?B?VHc4Z0gra0RScjFJRVhyMjVTbC9FYlBDN2JZVmQrQnRZQ1JOT1dEWHBPcDZO?=
 =?utf-8?B?UlJFVDhEMThUc1BYMUk4UFlXNDdoSldoTTJEUjIvekpzTE12N2FZN28wekU3?=
 =?utf-8?B?N2RxanV2c1NCQm1KbmdFWGVsOWxKRGlibHBSNWNsUWc5L0hMTVFZZDVHYi8w?=
 =?utf-8?B?NmlHVmxOaE9JeEhnRUpYUFZIVHpiTzZ0K0hmR2diSkdmRVYwbDFsRm5OeHoy?=
 =?utf-8?B?UkNGRndBWmJnU2xaa0RMRWQ5TWxHZm1INlZ5L3h2cVJ2OFBqYWNTYkhjQWQv?=
 =?utf-8?B?ais3K0VDM0ZkcjNtNW1YOFdYYlZRQkJqU0xvVHVVL1pzU1BKOTFrNGVZWVdR?=
 =?utf-8?B?Rm1GcTZtTlVmSGhyRi9WbkVRd2hFZCtraFRhTEpDVzMvNFRhTlZGNDBNQTg2?=
 =?utf-8?B?dUJLTHN1M2E1ZkMwZVJJbGx4OFRqUWE5NGNXVm1FclNFNEFaN0ppWTdzTlFP?=
 =?utf-8?B?YnBuYnIvaC9ZOU95azZ3VUZoZ28wdWE0aDhUMlVyT1hJSDk4WjRIck9pdGE5?=
 =?utf-8?B?KzRXc3oydzVDSFlYcFN1c0JkcSt6K3VWMW5Fc1ZseG1jSG81RE1QR3ppNFgr?=
 =?utf-8?Q?RpqfpJ?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(30052699003)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:45:05.6476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dccbd11-4318-40e7-b69d-08dde6cff86b
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8595

From: Alexander Ganslandt <alexanga@axis.com>

Splits the scan frequencies into more subsets that have been ordered
such that the more common frequencies appear first, and the more uncommon
frequencies last. Non-DFS channels are also added to the earlier
subsets to prioritize fast-scanning frequencies.

This approach allows iwd to scan the frequencies with the statistically
highest chance for BSSes first, resulting in shorter scan times until a
good BSS is found. In future patches this will also be used when
roaming.
---
 src/station.c | 122 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 89 insertions(+), 33 deletions(-)

diff --git a/src/station.c b/src/station.c
index f8069d89..c2e18fc9 100644
--- a/src/station.c
+++ b/src/station.c
@@ -125,7 +125,7 @@ struct station {
 	struct l_queue *roam_bss_list;
 
 	/* Frequencies split into subsets by priority */
-	struct scan_freq_set *scan_freqs_order[3];
+	struct scan_freq_set *scan_freqs_order[5];
 	unsigned int dbus_scan_subset_idx;
 
 	uint32_t wiphy_watch;
@@ -4500,8 +4500,7 @@ static bool station_dbus_scan_results(int err, struct l_queue *bss_list,
 		return false;
 	}
 
-	last_subset = next_idx >= L_ARRAY_SIZE(station->scan_freqs_order) ||
-		station->scan_freqs_order[next_idx] == NULL;
+	last_subset = next_idx >= L_ARRAY_SIZE(station->scan_freqs_order);
 	station->dbus_scan_subset_idx = next_idx;
 
 	station_set_scan_results(station, bss_list, freqs, false);
@@ -4516,6 +4515,15 @@ static bool station_dbus_scan_subset(struct station *station)
 {
 	unsigned int idx = station->dbus_scan_subset_idx;
 
+	/* Find the next non-empty subset */
+	while (idx < L_ARRAY_SIZE(station->scan_freqs_order) &&
+			scan_freq_set_isempty(station->scan_freqs_order[idx]))
+		idx++;
+	station->dbus_scan_subset_idx = idx;
+
+	if (idx >= L_ARRAY_SIZE(station->scan_freqs_order))
+		return false;
+
 	station->dbus_scan_id = station_scan_trigger(station,
 						station->scan_freqs_order[idx],
 						station_dbus_scan_triggered,
@@ -5061,40 +5069,91 @@ static void station_fill_scan_freq_subsets(struct station *station)
 				wiphy_get_supported_freqs(station->wiphy);
 	unsigned int subset_idx = 0;
 
-	/*
-	 * Scan the 2.4GHz "social channels" first, 5GHz second, if supported,
-	 * all other 2.4GHz channels last.  To be refined as needed.
-	 */
+	station->scan_freqs_order[subset_idx] = scan_freq_set_new();
+
+	/* Subset 0: 2.4GHz "social channels" and low 5GHz non-DFS channels */
 	if (allowed_bands & BAND_FREQ_2_4_GHZ) {
-		station->scan_freqs_order[subset_idx] = scan_freq_set_new();
+		/* Channels 1, 6, 11 */
 		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2412);
 		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2437);
 		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2462);
-		subset_idx++;
 	}
 
-	/*
-	 * TODO: It may might sense to split up 5 and 6ghz into separate subsets
-	 *       since the channel set is so large.
-	 */
-	if (allowed_bands & (BAND_FREQ_5_GHZ | BAND_FREQ_6_GHZ)) {
-		uint32_t mask = allowed_bands &
-					(BAND_FREQ_5_GHZ | BAND_FREQ_6_GHZ);
-		struct scan_freq_set *set = scan_freq_set_clone(supported,
-								mask);
-
-		/* 5/6ghz didn't add any frequencies */
-		if (scan_freq_set_isempty(set)) {
-			scan_freq_set_free(set);
-		} else
-			station->scan_freqs_order[subset_idx++] = set;
+	if (allowed_bands & BAND_FREQ_5_GHZ) {
+		/* Channels 32 - 48 */
+		for (int i = 5160; i <= 5240; i+=20) {
+			scan_freq_set_add(station->scan_freqs_order[subset_idx], i);
+		}
 	}
 
-	/* Add remaining 2.4ghz channels to subset */
+	scan_freq_set_constrain(station->scan_freqs_order[subset_idx], supported);
+	station->scan_freqs_order[++subset_idx] = scan_freq_set_new();
+
+	/* Subset 1: Remaining common 2.4GHz channels and high 5GHz non-DFS channels */
 	if (allowed_bands & BAND_FREQ_2_4_GHZ) {
-		station->scan_freqs_order[subset_idx] = scan_freq_set_new();
-		scan_freq_set_foreach(supported, station_add_2_4ghz_freq,
-					station->scan_freqs_order[subset_idx]);
+		/* Channels 2 - 10, except 6 */
+		for (int i = 2417; i < 2462; i+=5) {
+			if (i != 2437)
+				scan_freq_set_add(station->scan_freqs_order[subset_idx], i);
+		}
+	}
+
+	if (allowed_bands & BAND_FREQ_5_GHZ) {
+		/* Channels 149 - 177 */
+		for (int i = 5745; i <= 5885; i+=20) {
+			scan_freq_set_add(station->scan_freqs_order[subset_idx], i);
+		}
+	}
+
+	scan_freq_set_constrain(station->scan_freqs_order[subset_idx], supported);
+	station->scan_freqs_order[++subset_idx] = scan_freq_set_new();
+
+	/* Subset 2: Uncommon 2.4GHz channels and 5GHz DFS channels */
+	if (allowed_bands & BAND_FREQ_2_4_GHZ) {
+		/* Channels 12 - 14 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2467);
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2472);
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2484);
+	}
+
+	if (allowed_bands & BAND_FREQ_5_GHZ) {
+		/* Channels 52 - 68 */
+		for (int i = 5260; i <= 5340; i+=20) {
+			scan_freq_set_add(station->scan_freqs_order[subset_idx], i);
+		}
+
+		/* Channels 96 - 144 */
+		for (int i = 5480; i <= 5720; i+=20) {
+			scan_freq_set_add(station->scan_freqs_order[subset_idx], i);
+		}
+	}
+
+	scan_freq_set_constrain(station->scan_freqs_order[subset_idx], supported);
+	station->scan_freqs_order[++subset_idx] = scan_freq_set_new();
+
+	/* Subset 3: 6GHz channels */
+	if (allowed_bands & BAND_FREQ_6_GHZ) {
+		struct scan_freq_set *set = scan_freq_set_clone(supported, BAND_FREQ_6_GHZ);
+
+		if (scan_freq_set_isempty(set))
+			scan_freq_set_free(set);
+		else
+			scan_freq_set_merge(station->scan_freqs_order[subset_idx], set);
+	}
+
+	scan_freq_set_constrain(station->scan_freqs_order[subset_idx], supported);
+	station->scan_freqs_order[++subset_idx] = scan_freq_set_clone(supported, allowed_bands);
+
+	/* All channels that are both supported and allowed should be in the subsets,
+	 * if this is not the case then some new channel has been added that we are
+	 * not tracking, put it in the last subset to make sure it's scanned */
+	for (int i = 0; i < 4; i++) {
+		scan_freq_set_subtract(station->scan_freqs_order[subset_idx],
+				station->scan_freqs_order[i]);
+	}
+
+	if (!scan_freq_set_isempty(station->scan_freqs_order[subset_idx])) {
+		l_warn("Final subset is not empty");
 	}
 
 	/*
@@ -5273,11 +5332,8 @@ static void station_free(struct station *station)
 
 	l_queue_destroy(station->anqp_pending, remove_anqp);
 
-	scan_freq_set_free(station->scan_freqs_order[0]);
-	scan_freq_set_free(station->scan_freqs_order[1]);
-
-	if (station->scan_freqs_order[2])
-		scan_freq_set_free(station->scan_freqs_order[2]);
+	for (uint8_t i = 0; i < L_ARRAY_SIZE(station->scan_freqs_order); i++)
+		scan_freq_set_free(station->scan_freqs_order[i]);
 
 	wiphy_state_watch_remove(station->wiphy, station->wiphy_watch);
 

-- 
2.39.5

