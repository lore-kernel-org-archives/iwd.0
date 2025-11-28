Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4140632572C
	for <iwd@lists.linux.dev>; Fri, 28 Nov 2025 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330917; cv=fail; b=CCHcaSO/zbNRBT+XF8q00neJdwnANzp3rp4kE9AYDdKyJyKY8YA/m70/LAq2xtPTVp+XrDDqfhBEdUmhnPwPXNRiRntR80abrv5cn3YkwBhOZa3KLKQN9ttjpQW6xbOUfs+CCzMe0NyhfERabw2yLiS37FOxVRkS7ecAxPy2Ssk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330917; c=relaxed/simple;
	bh=DXKSYT6x/8CSAYf+7jqVPGr2RI5H7hlhsLB2/0ZHJuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=UM0hqndk+ZqNQfDYWLk9GkjXxcDlZG1PGloAOLA3Og6U8h+yjFNmBENuLH5K5xxlogolmJkqNR8jjdxsxuTOwG3UWi98+Pp0LnD/NfB9i7AUjKuUL84Zq5qSIMt7h6AdzrAduMaA7lWVqXxtNEPXbQs2LM27VZkYRW3+8NbRr1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=PTVSwhMj; arc=fail smtp.client-ip=52.101.69.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="PTVSwhMj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnyBz5VqowHuXsgtngNg/2WL2SytwVEw36P0xahcTYPV7UM3sjaD3h4mH7D3B3TB65/KnbYXHYgc2Bm3Ra99vtInf9xwP/hVZV6wMxsxZDk+8WunzoNm+wNJtO8KCQjoXkuegUuQAZ8QTJ0urzSCUL7iGqp0ZeBPQb/GGpXF6FyNOU160Ii+KYATWfza8vFolvjTGNEwPcziArydbZjIS8xvFFqE2ZJWYVNHg9VPO4RqV6vCAPInscS3FC3SsaMbHhTRehcb1aCiEy3PoVRNDdR8d9pyF4k6xekH8RPCFbRuHf5jvFxgFbIiXFAJQBIaV/2fwCE+d/3HEAIZGMuGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPWqDnqRK7cAblFOfRt1wS6lCiTDHcpMjJ/pDIyAGME=;
 b=MXoiBLfgpUwtZjVQFeCXoJGNVDdaBj9mACGpKmE3OQn20WIxlM3d8/ABONCu3f6gEztAvYGldXGGNMtHcX10hPZHxge0xe47UwqeHWVDxdYNCr5TxaTIxG1kt4sqkaevwVZmyv0ufMzPMaLQLTXIltBZmNXID2vJWepXpq//3AM4iMRhSKoUO/CYxAZIPYp0R6BbSKV1AA2uMzXsMgjUz1wq2oJo/T96PJKJZR2oB/ZTiVx6snoksAYNJAkgkfqPcbq55TbZ5+xsKIojJyITfjhMD9LWqvt5c4ryyXbkb7/5wWpDIH9u3EF0RPi+EiA0u8Ll01Ep3Hhv6cYWNcnxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPWqDnqRK7cAblFOfRt1wS6lCiTDHcpMjJ/pDIyAGME=;
 b=PTVSwhMjC6uaDuUOHKFVg8MVfD3ZSJNEpKOqtO7sYC3HyF8+4TjL0QMKz8pgefu47pY5YzTSULLQxDzn/ApL7wivWLgcpyLmGzdUUFML19oUD/ISBiVOq3ITPePG/vg10OiktELv9VxVBgBybaGRGo6tL4aX364+/YMuDyy7oqM=
Received: from DUZPR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::7) by PA1PR02MB11617.eurprd02.prod.outlook.com
 (2603:10a6:102:557::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 11:55:10 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::b3) by DUZPR01CA0028.outlook.office365.com
 (2603:10a6:10:46b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.16 via Frontend Transport; Fri,
 28 Nov 2025 11:55:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 11:55:10 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 28 Nov
 2025 12:55:07 +0100
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 28 Nov
 2025 12:55:07 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 28 Nov 2025 12:55:07 +0100
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 6F6D72DB
	for <iwd@lists.linux.dev>; Fri, 28 Nov 2025 12:55:07 +0100 (CET)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 6FAD6286516A; Fri, 28 Nov 2025 12:55:07 +0100 (CET)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Date: Fri, 28 Nov 2025 12:54:23 +0100
Subject: [PATCH v5 2/8] station: improve scan_freqs_order channel subsets
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251128-roam-scan-improvements-v5-2-285ff0104188@axis.com>
References: <20251128-roam-scan-improvements-v5-0-285ff0104188@axis.com>
In-Reply-To: <20251128-roam-scan-improvements-v5-0-285ff0104188@axis.com>
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|PA1PR02MB11617:EE_
X-MS-Office365-Filtering-Correlation-Id: 197130ec-ef15-4416-36fa-08de2e74fb7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVgxRGdCUkFiMFduQ0FEOU53TjByZ1I3TzcvMURTMStvYUxEelYxdzI5aEdl?=
 =?utf-8?B?SVlEQ1VJMmVaTnBzbDEyNlJrMWtrNllkcG1tS2FWVTRhaUFQY0YyS0Q4WDNh?=
 =?utf-8?B?RGwxTlpnanJnTGE1SEQ4d1hSemlQeTZiQ2FmQ0ZhYVZGZWlVUXFiTEl6WlBn?=
 =?utf-8?B?SmVBbDBwWEU4ZElreTg0NnBlV0hLc0hTS0ZvTnhSaVcydzhHVStvTFBhdEEw?=
 =?utf-8?B?eURrNEFNWkNxQjBkQUFZWVdoR3BCVzFFWUZLc2RnYjM2eXhhMGNrN1pQRFpu?=
 =?utf-8?B?eUZMUDR4TWxwbDVSUE9peWIyREJTWmNLTVdmREVsU2VCUGVyTWlBWDFpT2tD?=
 =?utf-8?B?VXJHWU9ybHNQdDlpNjVXMmk2OVNSQm1RcmwyaU8zc1FwMVJLNmd5NTVYbGRK?=
 =?utf-8?B?V3U0ZkhtQmF6YkduU2p0TWhDTDFmQ1RsMTA3Ti8xUWlTMEJNZjhlemJVMW5E?=
 =?utf-8?B?YUlkYWFnNUdOOXpZL2pwTXZzTVpaV3FyeXpITnRFbGFBWC9CR0kySzdKT0Fn?=
 =?utf-8?B?K1dKQkZBbkhOUFcxbFV0ZEsrbEF4c1lCdTdaYnQ5eXNCUGFRWnAyZXlwQmND?=
 =?utf-8?B?dkJkZklYRzI4VVJlbDVsVnMzMDh6T1JHZjB3TnViNEhGU3JYK21ZUC95LzQ4?=
 =?utf-8?B?QVVFNWlzTEwrbmlNMkFqa0tPNmE2SStnRDM5Wlczd3JLZnlZM0V4czFEamV3?=
 =?utf-8?B?WlZpVGJ1bUU3TGY1MVgxVVd5L0dxazdZV2hLb1F3ZEVuRkU3VmRBaW1GT3FC?=
 =?utf-8?B?Rjl0cTh1c2xTaEp0U29tUncwTlkwcGo1MVVFRDJoaCtDQ1hkbk9JOXdTMWht?=
 =?utf-8?B?L1pvN1NOSEI1dXYrclhxckNYZUlpb2J1OGk4Z3NZR1Zlc3NVb21zZTZBZysr?=
 =?utf-8?B?dHJlVlR4SE9oaDJ1SUJza2hsOEVGRmVEUGNCbENhUE9uV3VlZHdvMnNjdVF6?=
 =?utf-8?B?VFcydnAyaW1lS0wzODlRcFdPa0ttVVNtVzNFeDBkeUZvY1I2MEFUaE90QmVS?=
 =?utf-8?B?R092dVg1NnE3MVM0blUzTEVBUjJVSnkxNEJXYzVQTkJZWE5JQjZnQ3p4RDdV?=
 =?utf-8?B?dmtqQXlvc00rOW9YOXBlWHBMcW9GSzI5KzF1RWs1TGExY25sOXdyNER1N1Nw?=
 =?utf-8?B?bTBvUzZGL21uYVFNaG5nK2ZlcjVWRURTZXpmK3JQOUZjeHpOS2RTNWRiblI2?=
 =?utf-8?B?Q29wMUorZkR6Si9xa0VqR1ljbFVxUFhMa25RdWQyWTN3ZDZqNmd1R05sVFpC?=
 =?utf-8?B?WE5RVyttQnBhcDc4TU5tYXhQdWI3QW5aMFNSZXZaVzM3UWxpdFNwNG1hZFRT?=
 =?utf-8?B?anNQRnNqVGwxYzRwM2pUUlM0SDJiN01XTW1FQUpZUnBRODgwc3NaQktqeWky?=
 =?utf-8?B?MndPdW1xVitDbW5UTytmTnVhS3FzZWcwZjV6c0EzdVVIOWxJdGE1V01qQXlD?=
 =?utf-8?B?RC8yY3gzNTlMakxkNThnUHdPVzUzNnNkUEthYU01c1pCZmpFYXphRVZiNEhu?=
 =?utf-8?B?QkI1ZzBvN2libEYrUTNpNnJNWFhVeGVTdkMycGpPVm1GSGw4bHFCVHZqTG11?=
 =?utf-8?B?eXdvS2huLzdsdERxd2g0U3JTOCsreWZjTmxYTGVoVDlYanU3K3V3TXNUaVc2?=
 =?utf-8?B?VEQ1a0YycUxUUUZBdGtGd1lxVmtHc1gxQVZrRkFWYmZIemREOS9nRzZhTEJI?=
 =?utf-8?B?YnVwR3h6M0NBcE9VVjZUVmZrMTBlVjhHazRVYys2TjFMMmFaOVhnREVrSElI?=
 =?utf-8?B?SXkxNGgrRGNLZGdZRVZLQmtqdHkxM2p1RlFWTXdxek1vTHpINTh2Qjl3cG5l?=
 =?utf-8?B?bVZSVU9rcktLWnMxQkpWeGZ0WVdESUh0b05uZnpDcFA5YTVaeXJZT2oxVG9Z?=
 =?utf-8?B?eEcwM3IxMmxiSEJRbnEvL1R4Mm9TNzYwVVdkYUMwcmN4TWpaWTBqeEc1OEtZ?=
 =?utf-8?B?QjNYdlJISDlteHpqZ0N2Nks2dzJ2R0FQVk00TGp0T0ZrTm1ydmxlZ1NMOGVn?=
 =?utf-8?B?MW90dFNvZ1MzMng4NjlUbG96anB2bDJNVnhQaWJ4N1EzOGtYWVZvazVCZVpI?=
 =?utf-8?B?NmsvZ0NIaUl5V2h4OFJMK2lIYmZYVk9CU0U1bmtXaHU3R2U2aEM0SHRscS9W?=
 =?utf-8?Q?u3bU=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 11:55:10.3119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 197130ec-ef15-4416-36fa-08de2e74fb7f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR02MB11617

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
 src/station.c | 137 +++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 88 insertions(+), 49 deletions(-)

diff --git a/src/station.c b/src/station.c
index f8069d89..15937fbe 100644
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
@@ -5046,67 +5054,101 @@ int station_hide_network(struct station *station, struct network *network)
 	return 0;
 }
 
-static void station_add_2_4ghz_freq(uint32_t freq, void *user_data)
-{
-	struct scan_freq_set *set = user_data;
-
-	/* exclude social channels added in initial scan request */
-	if (freq < 3000 && freq != 2412 && freq != 2437 && freq != 2462)
-		scan_freq_set_add(set, freq);
-}
-
 static void station_fill_scan_freq_subsets(struct station *station)
 {
 	const struct scan_freq_set *supported =
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
-	}
+	if (allowed_bands & BAND_FREQ_5_GHZ)
+		/* Channels 32 - 48 */
+		for (int i = 5160; i <= 5240; i+=20)
+			scan_freq_set_add(station->scan_freqs_order[subset_idx], i);
+
+	scan_freq_set_constrain(station->scan_freqs_order[subset_idx], supported);
+	station->scan_freqs_order[++subset_idx] = scan_freq_set_new();
+
+	/* Subset 1: Remaining common 2.4GHz channels and high 5GHz non-DFS channels */
+	if (allowed_bands & BAND_FREQ_2_4_GHZ)
+		/* Channels 2 - 10, except 6 */
+		for (int i = 2417; i < 2462; i+=5)
+			if (i != 2437)
+				scan_freq_set_add(station->scan_freqs_order[subset_idx], i);
+
+	if (allowed_bands & BAND_FREQ_5_GHZ)
+		/* Channels 149 - 177 */
+		for (int i = 5745; i <= 5885; i+=20)
+			scan_freq_set_add(station->scan_freqs_order[subset_idx], i);
 
-	/* Add remaining 2.4ghz channels to subset */
+	scan_freq_set_constrain(station->scan_freqs_order[subset_idx], supported);
+	station->scan_freqs_order[++subset_idx] = scan_freq_set_new();
+
+	/* Subset 2: Uncommon 2.4GHz channels and 5GHz DFS channels */
 	if (allowed_bands & BAND_FREQ_2_4_GHZ) {
-		station->scan_freqs_order[subset_idx] = scan_freq_set_new();
-		scan_freq_set_foreach(supported, station_add_2_4ghz_freq,
-					station->scan_freqs_order[subset_idx]);
+		/* Channels 12 - 14 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2467);
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2472);
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2484);
+	}
+
+	if (allowed_bands & BAND_FREQ_5_GHZ) {
+		/* Channels 52 - 68 */
+		for (int i = 5260; i <= 5340; i+=20)
+			scan_freq_set_add(station->scan_freqs_order[subset_idx], i);
+
+		/* Channels 96 - 144 */
+		for (int i = 5480; i <= 5720; i+=20)
+			scan_freq_set_add(station->scan_freqs_order[subset_idx], i);
+	}
+
+	scan_freq_set_constrain(station->scan_freqs_order[subset_idx], supported);
+	station->scan_freqs_order[++subset_idx] = scan_freq_set_new();
+
+	/* Subset 3: 6GHz channels */
+	if (allowed_bands & BAND_FREQ_6_GHZ) {
+		struct scan_freq_set *set = scan_freq_set_clone(supported, BAND_FREQ_6_GHZ);
+
+		if (!scan_freq_set_isempty(set))
+			scan_freq_set_merge(station->scan_freqs_order[subset_idx], set);
+
+		scan_freq_set_free(set);
 	}
 
+	scan_freq_set_constrain(station->scan_freqs_order[subset_idx], supported);
+	station->scan_freqs_order[++subset_idx] = scan_freq_set_clone(supported, allowed_bands);
+
+	/* All channels that are both supported and allowed should be in the subsets,
+	 * if this is not the case then some new channel has been added that we are
+	 * not tracking, put it in the last subset to make sure it's scanned */
+	for (unsigned int i = 0; i < L_ARRAY_SIZE(station->scan_freqs_order) - 1; i++)
+		scan_freq_set_subtract(station->scan_freqs_order[subset_idx],
+				station->scan_freqs_order[i]);
+
+	if (!scan_freq_set_isempty(station->scan_freqs_order[subset_idx]))
+		l_warn("Final subset is not empty");
+
 	/*
-	 * This has the unintended consequence of allowing DBus scans to
-	 * scan the entire spectrum rather than cause IWD to be completely
-	 * non-functional. Rather than prevent DBus scans from working at all
-	 * print a warning here.
+	 * Loop through all subsets to see that there's at least one non-empty
+	 * subset, otherwise iwd will not function as expected and the user
+	 * should be warned.
 	 */
-	if (station->scan_freqs_order[0] == NULL)
+	for (subset_idx = 0; subset_idx < L_ARRAY_SIZE(station->scan_freqs_order); subset_idx++)
+		if (!scan_freq_set_isempty(station->scan_freqs_order[subset_idx]))
+			break;
+
+	if (subset_idx == L_ARRAY_SIZE(station->scan_freqs_order))
 		l_warn("All supported bands were disabled by user! IWD will not"
 			" function as expected");
-
 }
 
 static void station_wiphy_watch(struct wiphy *wiphy,
@@ -5273,11 +5315,8 @@ static void station_free(struct station *station)
 
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

