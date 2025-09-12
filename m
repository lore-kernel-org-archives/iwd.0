Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E7925A2C8
	for <iwd@lists.linux.dev>; Fri, 12 Sep 2025 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676328; cv=fail; b=Z85PNvLPEPg1aEPTAmh3D6K+ztfh9NlxgFfj8mQg17dRV65pO7yxM9pHjcPHVX9q/nr3ZeZ03Kaw06Hme7PPllGvrzGVjUPN4hlo4zwUKc42sj0YZIOxjRcvjpOWdgLRTyOh5fKF0gABfk6L7cEl3bHzoJX3ZZMinYClYIWBXYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676328; c=relaxed/simple;
	bh=DXKSYT6x/8CSAYf+7jqVPGr2RI5H7hlhsLB2/0ZHJuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=N0/hoUzw9YBVbs8cMwe97E+F3Dzr8m8NgLrCQJtXAnu5XzL34+2p07PX0ZKh9Ob1w35EqDFUc+BOHY6K6b7mKYuOVSmYyS0Iu4gF8XKaVFk4PDP0b68eF+iDwYlFn2L/e+tGTPw6gv9haWuWs+HGDUbWxykqOfin4B+D/pH8ZiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Owg2qcyD; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Owg2qcyD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3Q+iYx+TpwF7YRj2MZjlzGvILjURM33XmVjDqjmalt0JqKtDIq+nS2TXwvqLuHHnFOpAJB2/Sgg/7saZiXRDF+7iKVNNdT0AHZRjaolvNAi/YE7OjHNNRPsL1dZeHv9xvyAExHBBlp3ZmaePfilCkZhD4DgmUxoFYhT1GbQAHLLlNi5gezeXL2vhJvJpuBV798jWgH6UBtX89iLG0SLd5vnkGTPWMXYpK5jFNDrPrknUunVV2R2JvCBXCB3E/nf/JsceKtKoi/bPOfjdZPvBWhmR7OoumNS6wkMoKhnoEbkS2RA+skOLwxHXHbS9crLz4XEEW05X+PqiXnz+CBa6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPWqDnqRK7cAblFOfRt1wS6lCiTDHcpMjJ/pDIyAGME=;
 b=kvUCnd8WV/EoLkDVffeq3DElt0sreujkkB853wayUdygxybmF3Aq1jLb9/WO5OfQv9teK30VSRxldQj4SLh/8sG6AJnHJQVfjJGJDBuA9f1mrFWJVmUBfR4wHi8bXeVFWN4GGmjOYei26X2VVXQ9auFVN5cK7eTCMsWgi/kUWz/IC9eLFLRE+HvJvvPqWgxmQ7NkvKSTBhGb5H3fl8vcm4HKjCylpLfcAeXLwlssmtoHvdAtFqTDlEMNKo6EyWbC+JJbSMJ4XYLgGCsUi5kPxD94T0F9SW1GQcbhDvu4qyR7sRaDp7g5VmkS3YaIAa2gzpeO0V3de1tLAZmBSgzPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPWqDnqRK7cAblFOfRt1wS6lCiTDHcpMjJ/pDIyAGME=;
 b=Owg2qcyD5fAulnf2ZDbT506WIAMIAJunCTYQP69NC2JrOXZrLeqpZ/pjBX+FyLjUk0RqFe1cPDXUisFBjEfVVZK42W9rBpnmGG1mDpaukw/dTbqWgEmJZEAw2tLArzRzcpdNVY+5juq6gRApie9vShinVUXUnlJOGmaJwwuz22o=
Received: from AM4PR07CA0012.eurprd07.prod.outlook.com (2603:10a6:205:1::25)
 by VI1PR02MB5902.eurprd02.prod.outlook.com (2603:10a6:803:12e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 11:25:20 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:205:1:cafe::8e) by AM4PR07CA0012.outlook.office365.com
 (2603:10a6:205:1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via Frontend Transport; Fri,
 12 Sep 2025 11:25:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 11:25:20 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Fri, 12 Sep
 2025 13:25:19 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Fri, 12 Sep
 2025 13:25:18 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Sep 2025 13:25:18 +0200
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id C84EC1E5E
	for <iwd@lists.linux.dev>; Fri, 12 Sep 2025 13:25:18 +0200 (CEST)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id D59B7287A98F; Fri, 12 Sep 2025 13:25:18 +0200 (CEST)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Date: Fri, 12 Sep 2025 13:23:21 +0200
Subject: [PATCH v4 2/3] station: improve scan_freqs_order channel subsets
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250912-roam-scan-improvements-v4-2-761a92734603@axis.com>
References: <20250912-roam-scan-improvements-v4-0-761a92734603@axis.com>
In-Reply-To: <20250912-roam-scan-improvements-v4-0-761a92734603@axis.com>
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C717:EE_|VI1PR02MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: c06175b2-518b-44e2-2993-08ddf1ef0e9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWk5V3NRd1JCV2NzcWpxbzZYV2VCT3NReUNaRnVDWTBqeW1pNWk0RW9YNEhi?=
 =?utf-8?B?NDVOckhoVnlkM2JaSGozUlMwQ2swRm41UmhDbEZRRUVuSUMvNkt2SXZSNVd5?=
 =?utf-8?B?bHJwSXMyZndKMkV1WVpObnVFSWlqUXh6YWZTbHhuaCtXaWxneHFaU0thNmxK?=
 =?utf-8?B?dXFPdzdhSm02VFNKUjVQYnJWM0xkOHRqRFBCNmJvaTlpVHBmRzN3Nzc0M2Zj?=
 =?utf-8?B?alRxRnV2bFBuMS9SUGYvMXQvWjJ1amVQd0NwSUt5ZmRRWVVXNnFWOWxoaDNG?=
 =?utf-8?B?UFdmUnFSeGN3eWhYeVRwTCtpYlc4M0NpY2c4RWUyZXhhdlM0MFZQQlF0bHFN?=
 =?utf-8?B?K3djaDB4UnJrY1dYZVA5OGJLZFRnSm02dzk1UXkxNUd2eWVPMzQ4QmxQd0x0?=
 =?utf-8?B?TDBBN3Flb3lYcXBlaFQ1dWliNmRxaDFFM3gxRVpoL2RsY2NCaDBOdUR0L1lC?=
 =?utf-8?B?cnlOc3ZNNTU5QXExZWtuNTZwYzRSUHBaOXRXWVYzNjBSN285RTR4cmRCZjdp?=
 =?utf-8?B?SlNSaUJZaC8zVlp6dGlMUnN2RTA1RTFETGZNRHN1VllkNFhLQkRvT0ZXZGM3?=
 =?utf-8?B?aklqRVV2Mi9hdEkyaXU5R2hmQk5uTWxiU21lVWswV1AzUThHY2xhYW5ERjVU?=
 =?utf-8?B?OHlXdFpkTHNKbFAxbXMvVHV3SHlDVjBVQTZObWRSdVJ6TXp0bmJKQVdBanJh?=
 =?utf-8?B?czlOSGRYY3d2RGdoVVl2MGw3Vnh0ZXBzdDV0dWpwem10cXV2ZDVhZkVwMC94?=
 =?utf-8?B?SWxidVhVT0N4TXR1VFMxbWdkSEUzdU9yUmpNTk54NWo2U3V0a0dMTTFUbHZy?=
 =?utf-8?B?T3kvZlVKckduei84dEhicmhlZmplS2ZsMkJwb0dNSUpFYThDalVTQTBJUFVK?=
 =?utf-8?B?bURHVndmZzl6TzBsNU00d1hSa21XU2Jhb0pUZ0pIeTJPcTJmZkFIck9uYldX?=
 =?utf-8?B?NllOVmVhVGtXLzNabU1mL3dJLzFzYTFoSHNscnBvYnczRkNUNHpjWmJWK3RH?=
 =?utf-8?B?WHNYNi82anR3cEE3SmxSNXErRDZwNEpWWEVlcXdnQzNmOUlHVmZ6NnhLeGsv?=
 =?utf-8?B?cHBtaHRDNEFSa1RnZldPN2pzTmhlakhxOHVkNGwyT3o2Z3pFeG8zQVNIUmZY?=
 =?utf-8?B?c3Y3RDV4QXNYMkE3aHBiYWhxd3ZmTUQwRDkrTGhqVFphY2lGSlFWcm04WjNy?=
 =?utf-8?B?R21tb0wyZTBhZkxSdS9yTm9LbElBSm82WVlvRWxadm1lU3d5bVFiK3hpYTMz?=
 =?utf-8?B?d2l6bGFKTlU0dy8vb1Ird2MxMzhvRWs2eE9lTjdvUVE1RzJqVXQ1T2Y0V3Mz?=
 =?utf-8?B?Tk9NUEhwWVdMemFWNVBEMzBZelRoVHFXalhGWjJBUlIyN0ozQlI0THlUUFRo?=
 =?utf-8?B?cmdqRENaTW9sVWhWNlJoR3YyQmthVGRJK2RVaEZqQm5sbzA1Zy8zdzVzQ05u?=
 =?utf-8?B?cTY1TVRub0lRTWlTeU1hZk9BbERaOW5BbjVmTU9KV3ZxYlo0dXdNNEh4MVRO?=
 =?utf-8?B?Z2tDZTZoamdOOTgvSkFRSTZVNDJtWTRYSEtybmdGQ0NHSlZOazhIRXJMUlI4?=
 =?utf-8?B?a3dXSGZVMko5ZS9ob1VaOFVRWFlLT2lZWDJDcUF3TFc2UFVaYnJIdmVVZ0NZ?=
 =?utf-8?B?UnFPOGVDdU9sZitZY244bis4MFA4YWxzUjJXTmtES0piV1ZNVTFUZU9hVWMz?=
 =?utf-8?B?T1ZlUEVLM1drRk12Qk1uU1pyUkEzNzJ0bXpWVTFaOVVFeWt5eEp6TTZMVmJr?=
 =?utf-8?B?R2dyZ2prTzNDS1MyUjZ6U01qR0JkcW1WVm4xYytVTnVTUGxaVENoMVZOQVJI?=
 =?utf-8?B?YzAyWGJDWjAvMTV4ZGxCamgrWFBERk5PS29LbFZNRjZ5bmhBYWQrRjkrMWYy?=
 =?utf-8?B?WnN6TE4rZ3RGQlBGKzR5bTg5SGN3M1NVMUxYcHhKMHErOC9MNFUxM25rWmZZ?=
 =?utf-8?B?SlhEYTY1TGE3YjdKNXFNWHoraFFRU1hyYndtRktBcW15akpVYkxoS28yckxD?=
 =?utf-8?B?UkJvVmttQmZ3RjlnZmI3SmM4UHI0Q0xlVDJ6UXpiSGl3RnRISEx0RGtsQ3F4?=
 =?utf-8?Q?xr+iYx?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 11:25:20.0817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c06175b2-518b-44e2-2993-08ddf1ef0e9e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5902

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

