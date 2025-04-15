Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5811627A133
	for <iwd@lists.linux.dev>; Tue, 15 Apr 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705317; cv=fail; b=J2ve+wBbPBjeycqb+X33yEI3Wh8AXCmxp3uP+z36gzbXSI+n5kSAOWL/MA2jnMVUoMDIyT6/2dND6vBTZhb9kefjU2E+qRVbIMISOeIZxoataYaJTttnNBCJeoR7dtwJAvZrs5WzXADkj20G41se4S81U2JkidzUG+TgeOy4YYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705317; c=relaxed/simple;
	bh=Tx2ERqwkypp3wGKo2VDmxn9OD1srP9VUMfoSc71356o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=HAr7QLkL/iucHivglXjoCj/NmV4tuREPsQSg37H84D/Fmv0Di+SWl4TSilRsy07dlKloLbp8Wqznx1AVAX115sUtMieF/OTe0xgq56hL7mZNNoFJEdsV0adP4jIs9cANsewFjCCEenLdZYsiSvH7FzcbBR822sUY3PV00C9Y+1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=TPgadHx6; arc=fail smtp.client-ip=40.107.105.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="TPgadHx6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAInrBN2BPgQCGpkQGAjIvTGmBq3sHW5vzDn5e8abvR2SK0AqAu+1+AIsYf4cK66nT5pM0LCpepALIwSSoVZgYlAqOfcMkA1dhe87YPPaOkqwYlc1N1T3BiXgOv+PkmVfAeMEVbU6aEYrPYa2vpifcNlW441lZER3lpL8jCwfdvjD/7GCB0dKAqnmRierUbvlOVNJis2T8VGjMMTCyZhVHtz1AmbLcQS9Y7WgX9+1nbmdFE5pTHNrAVJTWuv9VOGSgfbbOq2hcp2ZS2/rc9GP5NN7U/abGX9SuEpnfpBhXUobdPYsOnwbmUpKTqqqXlM0HQ/T5J5E1xaQMRsS/4oGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pRaPY0YDpey6Qq+y+X2TRigniikGM1EVIdjCvvvH/M=;
 b=x+4M05SvhQbqZ6lMlp4xBRQ73FNgKiyS6qSXuXieyr59L0DfOzktfBvOGztM4htEaXM89JidQcDoEoXk6+0EWLXqJrS7NZPPjxV7QzXlH26USQRHzTXlJiFtYQAarKCF/k3quFFEsFXMor9MK87IORvVVKSEEdLFhcKWwjDaj+KuWpdLvqeu3ofALAkmtM63vGecGcCGAgWT0UAX8/xki9QiM/fwpMn/3MuCp+1/plEKOcQph7XuBeJu0SOiIGg4p4UOnJTPtSO7ZK7zgUhBahrECV5VHdqe3YHbKeDht8eQuPeMwEuq6f3dMO2EpujdHtgDidpApwBRwaQJ5IcNBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pRaPY0YDpey6Qq+y+X2TRigniikGM1EVIdjCvvvH/M=;
 b=TPgadHx6sfjOXwlEGD+9jM1pGFXJn+oP3Xi7x1ZoLNqyT+VJsaBnXaPjiLlvj7Ny1xcPJtzDV1BEQ7XeMcUe5abPNSE26eCcbBXg0qk07Y/h/VMAkLCKtR5/Lrgc3WLTPMz91cwZhC1KwlEuJs0KrNMASegn9TeHW1IpA5aPc7k=
Received: from DU7P250CA0026.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::9) by
 PA1PR02MB11126.eurprd02.prod.outlook.com (2603:10a6:102:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 08:21:50 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::a4) by DU7P250CA0026.outlook.office365.com
 (2603:10a6:10:54f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 08:21:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 08:21:50 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 15 Apr
 2025 10:21:49 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 15 Apr 2025 10:21:49 +0200
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 8288913B
	for <iwd@lists.linux.dev>; Tue, 15 Apr 2025 10:21:49 +0200 (CEST)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 7D801287A9A5; Tue, 15 Apr 2025 10:21:49 +0200 (CEST)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Date: Tue, 15 Apr 2025 10:21:13 +0200
Subject: [PATCH RFC 2/3] scan: add scan_freq_map
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-roam-scan-improvements-v1-2-12827e086895@axis.com>
References: <20250415-roam-scan-improvements-v1-0-12827e086895@axis.com>
In-Reply-To: <20250415-roam-scan-improvements-v1-0-12827e086895@axis.com>
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F3:EE_|PA1PR02MB11126:EE_
X-MS-Office365-Filtering-Correlation-Id: ecad7627-0a37-4b5b-32d4-08dd7bf6929c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1Y4YTFkZ0FVR1ZOc2JRenR1TUhjYWNSZURsOWFMK3J3eXpmeGxNdHFoK2tQ?=
 =?utf-8?B?WWEwdmZwWFRkV3dpdkRpS05MblVVblZnTCtiRXlObG01M3J1R3BBQjlwZmhX?=
 =?utf-8?B?TE9DbW5XWVh6MHpQYW1pYld0ZDBvQ25iaU5qTVkwSU9VakwzMFFDcEJLVFc5?=
 =?utf-8?B?bFBmaVFENEp2OWh2bm9oZmNUTTNBV3JjejF0eTlvTUFsS0h5MzFmK0JaMmFS?=
 =?utf-8?B?RW54NzZaeHNDQnI5RTR5czBnOE0rWDFsMlpkcTMyYVFzTHJVMlhseTVyRGF0?=
 =?utf-8?B?UmJ4WW50YVlTbTVzczExQkVQQTIrMnZxTjNJOE9EVXpVY2E0RTQ5UGdlck50?=
 =?utf-8?B?SDVodmZGamMxNy9zVXJwT2Ribzl3SEpyMGRQTDhwb3lJNy9rSHo4bXpJS0xQ?=
 =?utf-8?B?UU4xZzUxQmI5R2dWTVpnNEpDMVdBR0hSc3NmZmhOampCL3VEcGpjRmZGOUls?=
 =?utf-8?B?OVBZM1NyMGEySldtTWNBaThHY3R0bTVYaTl3NElYbUR5OGtMdnpwZTlUQU0y?=
 =?utf-8?B?bmJhb0VBYm01T2hqWTMyV3VabnhRSHhXMFZWOWdVZDk1ajI2RUgzR096Wjhz?=
 =?utf-8?B?eDJYdlZyaVFPQ2twQnJhU3YzUktMZUh5eHMyS0dScjE0TnArRGtpS29QV1Jv?=
 =?utf-8?B?bExBbW5IN1FqU0dJRmIxcmQzZS94eUtsV0lBZkxkT25HNHB4WmQ4Q1Znd2FT?=
 =?utf-8?B?cjVTbkVoQjk0cEVjMFhyODZOc0VkN3l4OXVYcmRlOXNJSmZlR1crOUVFV0FH?=
 =?utf-8?B?cmxvdFd6WFc0VWR0cEZ0Q1VUbCtsdUVQczZBZmpmdVZWTTducldLSm1hVDBi?=
 =?utf-8?B?dXFKRlk4Z0hVd25LVmVURnExZC81U1pnQ0dlaWNpTllYSmk4My9RNTFEYlVE?=
 =?utf-8?B?bys3TTVOb2NjVDBtbVNBdzhoTnJoOE1NNHhrYzlWK1BvazhldjhIU1gzYmJz?=
 =?utf-8?B?KzZkblNmallmeTNueEZJUUNEeHNuRUJ4Ykd5ZWFZdW5kSU11U1lWdFdhZ0xL?=
 =?utf-8?B?UC8razdCYk5ieDZUby9peXlMemc0eTY1SVdjN3Z6UURVeFJ2aWVweUVudi92?=
 =?utf-8?B?SzVwOFdadVA1ZWM3Y21mUGVYZXE5SHZURTV4ZjNTNTVaYm5VMFhEOXJ1WS85?=
 =?utf-8?B?UmFHdmEwY01xbllEQ0pHZlAvSnlXVzdaRFJZNVRaV2haZVY2TzJOdEJlb3Rt?=
 =?utf-8?B?K0QvaDhkbTRjRlpUTGdVemFXbm5uNXRtRksrUURRTnA5cjg3aDhTUXJ4a2hv?=
 =?utf-8?B?bGliamluZUJnTUt2N1B2N09SZVhmS3UrYVYyaTQ3ZWRPNGp5QkJObFE0VS80?=
 =?utf-8?B?ak5UelUrRUhRVlBickFkVmRSRVh3TWoxRkVYVjFsRnNUQnRjYWFMdG9uQ3NE?=
 =?utf-8?B?SDNPSXlONGM2YlhpUVRYL0FUTGQyTzFzWTVlbTVZb2U3R0ZIWDIrQW9BOEd1?=
 =?utf-8?B?Qk5tZUVGdUlTdDM5QnJSdHFmVnhxM3IyWHR3dTJtMDdGeXRiMmthdDVQMFF1?=
 =?utf-8?B?cXI1VXVHRTZFSU1PZVd3TVZnelJGcDJYTm1sQWptaktqcnNNeWh2eFlDcVBP?=
 =?utf-8?B?K2tJL3BvZFpoSU5LRUxubzhldFRnT3M1ZXhOM1hXYllrVGMySUFCUDJtdGVj?=
 =?utf-8?B?NFVMTjluam5tcGp1bmhvV0c1cmdBMDRpNHhydGJ6VjVMc0RKdXNPcjQ2N3p6?=
 =?utf-8?B?OFk4a0dTOURtM25zZUxoMCtNSUhaV3FzUHJCNDNVRW5KclQ0YlJlbjV2SkdJ?=
 =?utf-8?B?Q3pJcDRqZk9YQnh2Ymd1cGJSVTRRVFVOeStzZHhCU20xNllCTVNpNnhobktZ?=
 =?utf-8?B?dnh4ZDNsUGduNTdDaWZjV05QQmtaUGNhczc0MWQ0MmhvaVJVWFloK2U3Q3hV?=
 =?utf-8?B?YzM5YmsrdGZId2RXK1BJVzFTcXZaRWxuMjhWVTA2OVpRWDZpaUMyb3UzTmRC?=
 =?utf-8?B?MU1uWFJwUERpTDFNR2tFWnVGVERXT1ZhSDhQU0xHU2pWUmJzakZ2a21IUFdT?=
 =?utf-8?B?Zy9lVEwvbW1EVUZDTTRTV1dXZkFPQVRLenY0cEttNFB1MTJSd09rTWVGS3lI?=
 =?utf-8?Q?zV6J/S?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 08:21:50.7891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecad7627-0a37-4b5b-32d4-08dd7bf6929c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR02MB11126

This is a hashmap where the keys are freqs and the values are
timestamps. When a freq has been scanned, the timestamp for that freq is
updated to "now". The function scan_get_freq_age can be used for getting
the age of a freq, which is how long time ago it was last scanned.

This is useful for deciding if a certain freq should be scanned, or if
it's better to spend that time on scanning another freq.
---
 src/scan.c | 36 ++++++++++++++++++++++++++++++++++++
 src/scan.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index aeab6516..f4c2e548 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -62,6 +62,7 @@ static uint32_t SCAN_MAX_INTERVAL;
 static uint32_t SCAN_INIT_INTERVAL;
 
 static struct l_queue *scan_contexts;
+static struct l_hashmap *scan_freq_map;
 
 static struct l_genl_family *nl80211;
 
@@ -2316,6 +2317,37 @@ static void scan_retry_pending(uint32_t wiphy_id)
 	}
 }
 
+static void scan_update_freq_map_entry(uint32_t freq, void *user_data)
+{
+	void *existing = l_hashmap_lookup(scan_freq_map, L_UINT_TO_PTR(freq));
+	uint64_t now = l_time_now();
+
+	if (existing) {
+		l_hashmap_remove(scan_freq_map, L_UINT_TO_PTR(freq));
+	}
+
+	l_hashmap_insert(scan_freq_map, L_UINT_TO_PTR(freq), L_UINT_TO_PTR(now));
+}
+
+static void scan_update_freq_map(struct scan_freq_set *freqs)
+{
+	scan_freq_set_foreach(freqs, scan_update_freq_map_entry, NULL);
+}
+
+uint64_t scan_get_freq_age(uint32_t freq)
+{
+	void *entry = l_hashmap_lookup(scan_freq_map, L_UINT_TO_PTR(freq));
+
+	if (entry) {
+		uint64_t timestamp = (uintptr_t) entry;
+		uint64_t now = l_time_now();
+
+		return (now - timestamp) / 1000000;
+	}
+
+	return UINT64_MAX;
+}
+
 static void scan_notify(struct l_genl_msg *msg, void *user_data)
 {
 	struct l_genl_attr attr;
@@ -2461,6 +2493,8 @@ static void scan_notify(struct l_genl_msg *msg, void *user_data)
 
 		scan_get_results(sc, sr, freqs);
 
+		scan_update_freq_map(freqs);
+
 		break;
 	}
 
@@ -2645,6 +2679,7 @@ static int scan_init(void)
 	const struct l_settings *config = iwd_get_config();
 
 	scan_contexts = l_queue_new();
+	scan_freq_map = l_hashmap_new();
 
 	RANK_2G_FACTOR = scan_get_band_rank_modifier(BAND_FREQ_2_4_GHZ);
 	RANK_5G_FACTOR = scan_get_band_rank_modifier(BAND_FREQ_5_GHZ);
@@ -2688,6 +2723,7 @@ static void scan_exit(void)
 	scan_contexts = NULL;
 	l_genl_family_free(nl80211);
 	nl80211 = NULL;
+	l_hashmap_destroy(scan_freq_map, NULL);
 }
 
 IWD_MODULE(scan, scan_init, scan_exit)
diff --git a/src/scan.h b/src/scan.h
index 4c1ebc21..135ffa5e 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -182,3 +182,5 @@ double scan_get_band_rank_modifier(enum band_freq band);
 
 bool scan_wdev_add(uint64_t wdev_id);
 bool scan_wdev_remove(uint64_t wdev_id);
+
+uint64_t scan_get_freq_age(uint32_t freq);

-- 
2.39.5

