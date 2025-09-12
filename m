Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012010.outbound.protection.outlook.com [52.101.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F130B2E03E4
	for <iwd@lists.linux.dev>; Fri, 12 Sep 2025 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671773; cv=fail; b=piP4Znw2mDYNNW/UJJYt+KlDl2WQPuxXWaX3iGEOK0qGsXhB1+8J2gX0oh3tRQKKgXSla3HQx6Aafh70VvuBYpXjjzr+pz9+Zck2058Ee3nfggJ8JXx8+q5qxl8AZM4YteSeiHHuayBllpB6yo2gSB10V3EvlNXEcvBsdbpcIa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671773; c=relaxed/simple;
	bh=kzTXAzvuZ5JeGniy5lzjEbhe9uM/0sLGU/p4ddTB7zE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=Bq0A3iFZzmLH55pNsswG20MEw7u+XoqHA2N0bXyRGjnrWrqvGx0Lru1+Rmg6AL0YxASvHeEqidDE53R/UKmWoHiBQp3HmoOCwB8Oke4Pt7CrXqzZ0Xcc/PmIZcdWPZvk9gA72U8scoFLrFlXV77bJv/Jxh4eJBPytd7+K5JArss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=L2W40lHf; arc=fail smtp.client-ip=52.101.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="L2W40lHf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+rDxZd2JL6fWY66/wdZP8u654QVyL4ImtQOtm+P5XdQbY0BCLxoRNW/Eb1ei6V8IcenRgJUB4sUcco37+/g2V7wzSXOdhHu9U2pyIujSrJnRLERyRV2bVnqFd6JUhP1G5KnkBwuwHdQ4g6OEM5CjQWW1sHpeToLEz78VwO5cbMIdwGzIVKZnnZI26DYGlbIHZagQDgSUljjrh4oCm/WUQRUhOYQhOc2BZPmYhfclt8ofCjmXvamRn4nKqBWNyxKZtx5aKnYtVx6bFznv8XKLfVpkw13g8kZ1ivbxDlL49hCTCf9ZnO5/19Iro2ADx2T88F6jp6MdhBw1dOEkq0g1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qFKJXojW7beiNygSHq4mq4gsvPUVOBoBw5kLnpFihs=;
 b=mH3F9ak4PTwKMy/YlWzCqgkwIwhmz4ip14ric5fbsGRthEDoAx2KdFIlanijDeOCIR243CzSHBzrFAnbBcJylFEF0gzNfjsE9dbqaRU2DwPZ9x8HczQz/lV4MhsIIRJ+zMnTOLg2q9ZtUuymnDW9lvd7+wdVsfkRvf7VHkHQgHPVsU2sfYtdEMfT5oAaxMhEzdy0Ff5acN6afQfhth3zWuL3VE25VJyMB2I4gk2wE2leAD1R3c8w/X6pHLZD+P6AftZffgZ6FGIQcKJe+3rmOhhIkNu01nSe9Q17cUSf8MA5kUVbnHVChi+IxORbGk4K6iD/CT/zZZokkDeSpdRiLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qFKJXojW7beiNygSHq4mq4gsvPUVOBoBw5kLnpFihs=;
 b=L2W40lHfoYMvWyUh44QZda7KTMh03WJcVBajl+Fkwb5nSk/x9ULp3cuWjoslfXxp5FIbFvhcW2+bnUPwV/qbHCojnk9yQeO/XESBcVgz1bFPGQLFSb44gVZw85jkjARiHybHSXAY5x3FGh5GakgFIIOU+8YZ+BhJiJ8UzUUXBzE=
Received: from AM0PR01CA0166.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::35) by AM7PR02MB6465.eurprd02.prod.outlook.com
 (2603:10a6:20b:1bb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:09:22 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:208:aa:cafe::b6) by AM0PR01CA0166.outlook.office365.com
 (2603:10a6:208:aa::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 10:09:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:09:22 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Fri, 12 Sep
 2025 12:09:22 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Sep 2025 12:09:22 +0200
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 1B53B1791
	for <iwd@lists.linux.dev>; Fri, 12 Sep 2025 12:09:22 +0200 (CEST)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 141A8287A98F; Fri, 12 Sep 2025 12:09:22 +0200 (CEST)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Date: Fri, 12 Sep 2025 12:08:52 +0200
Subject: [PATCH v3 2/3] station: improve scan_freqs_order channel subsets
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250912-roam-scan-improvements-v3-2-ebfd61dc6239@axis.com>
References: <20250912-roam-scan-improvements-v3-0-ebfd61dc6239@axis.com>
In-Reply-To: <20250912-roam-scan-improvements-v3-0-ebfd61dc6239@axis.com>
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|AM7PR02MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: c63dcf94-df46-475f-995c-08ddf1e4724e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlcxRGh2WnVSSXBEODJzWHg5KzZUblMxazI0dk1ZemxsVHVSOCsrRDZMZXh5?=
 =?utf-8?B?VHZQM0hyWWQ1WDhCbHBHaFd0ZjBpanRNbFFzZ3dyOGJxSFlpWjlwazNuSit1?=
 =?utf-8?B?RlgvS2pvOXl5UHQ3cnYvckZqMnM2cGwvTWRWOUQva0s3L0pHd0x0MS9xRVU3?=
 =?utf-8?B?eGF6WXNoSEkyL25lU0hYUlRQditUaGVFdzZHZS9MbGdKOVF4ODYzcExhWGxN?=
 =?utf-8?B?ZDhqQUJQQk1oZWRzalRROVpsNitEZ2N6QnlhZmwwbGlMK0FzY29oR3UxUFBT?=
 =?utf-8?B?SzA4aStndEVWTlNza2FvYXppT3BoRGJ4ZU1PK245UlhjeVJSZllwaGJyWFNu?=
 =?utf-8?B?dk5VVXRUS3crdkJveG0yVjcyV04xWDh1RmE4RHJ5Z2ZkenZPdVRtUGdFbUll?=
 =?utf-8?B?OGRpSHJ0UkQ1R1Q5RFFieURmVG5jMFIyUzZXaEpEWW80djlENHJ2aUhsdExQ?=
 =?utf-8?B?UURlT0NTZkYvQk9EUUxrenpWUm1nR3F3NGxlUEhJTE8wYmFQMWJGZDdWRUJ4?=
 =?utf-8?B?TGdmTHFLM3c5WnFGTVRKUnJxd2VZeTIwV0gyNWYzYTBBT0xtdG9nLzBDUzlZ?=
 =?utf-8?B?VkhIUmZsdkdMd1c4cTU0Q3Uwc2xIdGF4NWJRcDdkeGdKRDN4WlJNSlZhTlBV?=
 =?utf-8?B?bTFWaEkvaEd3TUtFVTlid05VWjF2TGp4Z2JCQVAwellVRnZ2ZG4zK1VzNTVz?=
 =?utf-8?B?SVNEdzhTcU05WmxlRWZnSlRBNjRTZzdmd1pjcWszQlZYRDFEVVNzZm5QYk01?=
 =?utf-8?B?dUZCb3diMmN4YkVMYzJleXU4QlJ2Umc5Sks3VU55Wnh2QlIrV3FTekJmVzVS?=
 =?utf-8?B?RkRTQ2hmbXRRb05TUGJzaTlVZ2NaZk8rQUp3ZUgxVUI2dEdPZUw1d3ZvOTUw?=
 =?utf-8?B?citsOFlFMTZKQ3Bnck15b216ZE9mamFiWnZTRkcrM0xUVEkrekUxamhaUCts?=
 =?utf-8?B?MHZHUWVjWFhYbkxmaHkwYVJRRWkzdmErNll6MFNHR1d0b0V6cHI3VkpkRUNF?=
 =?utf-8?B?ZERJLzFMaGhzK05rZGcxUTU0QW5iZTNVb1ZIeVhrZys4bmpmSlhXMkxucVA1?=
 =?utf-8?B?SlBCVnE1ajVSUzhSblc5VGZIaXdNWnh2YUlxcUdqbGxkWkc0Q1JtYkpraE00?=
 =?utf-8?B?ZXdSbDBjQmF0OFFQZHRpRk4vdmZxYUp5RHd4R3BtcWsvY0dSWksyUVZyVFR6?=
 =?utf-8?B?aE9IeDR0bGF6ZjUzNkdld1daTGRvcjNOTEw5UDZBbEMvLzFHdE82RnpGQXVX?=
 =?utf-8?B?ZWhTVDdrOEd0cSt0VWFPTWtUUStzSGxubHRQRjBYTEQvZkFiOW4zZDBadDhE?=
 =?utf-8?B?NTNzWDJJSjYxQytvMys0dFJqKzRZYWJUSndkVWpCYzJsZ2kwQWlsNlVKYXBW?=
 =?utf-8?B?QUJBdkhRalZycjdEcFpQSituSUJQcHN2SnhDSUZ5MTJ5RzErTnIwYmN2MkJw?=
 =?utf-8?B?R1VobS9wczYwTXNRTTk5cnI5VWs5VEkxM3RZNkYvZDc4NExRL2laM200cEFI?=
 =?utf-8?B?TTJoOTh6d3RBQUxzZU5KYWwvQlVzdjhPd1ppYnFTR0ZMVGc2dXoxVXF4dk5u?=
 =?utf-8?B?d2NsVWg3aTFBejd2MllIMXNWVlAyNmtxYXJxaDZRN2c4NndMT3FCQUhSYzU3?=
 =?utf-8?B?YWY3K05MZHU1Nkd6WkJGNjBvR2ZsVWdYZVZ0VlFCMVM5NG1PTlZRczd2WUdo?=
 =?utf-8?B?dmpIcVk1cXpFRGhaOHhscEpRZFcvc3IzS2gwc2hvNFpua2U2TmU0ZWZSUXhi?=
 =?utf-8?B?ZkpjNjlYZGpLK05WK3ZBNXBkY2kxdVZlK0phb3pVUzVhMEh2dzNDdUVUUE50?=
 =?utf-8?B?ZENPNlh0UFNPZVlJNkZsOWtzeGdFUG1LYlBmb0ZvbDZxcElXZ2pTRVpMbWJS?=
 =?utf-8?B?RDRTNFhUcWZHdDg1MW82b1NCREcybU54U0ErRC9zSVUrRWNVZ1orODNva2FI?=
 =?utf-8?B?UU5UVVNqYWlIQWtJNVZqY1NJUE9ENlJYMmttQXk0bUkwY3FpZzduN01CSnVx?=
 =?utf-8?B?VWl1SFZsTUEzTmMwRk0wMURSd1owRCtjYjRhRG1FRzc5aWFlQWJMRFd1MUFh?=
 =?utf-8?Q?uOOXq/?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:09:22.8662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c63dcf94-df46-475f-995c-08ddf1e4724e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6465

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
index f8069d89..1b4dd1c8 100644
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
+	for (int i = 0; i < L_ARRAY_SIZE(station->scan_freqs_order) - 1; i++)
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

