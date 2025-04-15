Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D04127A129
	for <iwd@lists.linux.dev>; Tue, 15 Apr 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705316; cv=fail; b=IWT+vPHlbQTVIHl8r6fg6u7rvSjAHoSpGu4AiBZ9hhdFPnmlabm68GZaN41bXcGBXxlLJsz4BY0ZaMOG9tJ/VaRWePfsM7v6KjaF2631fTrLs4yRXPY1KI38pak+16vybCkcY6QdLP/4zV4m1ed4vCq/20uQcj0gPSLtMUF293U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705316; c=relaxed/simple;
	bh=tvVEKYVayAgB7+P16TXkxnoDd+EhtCLeGb+8oIcSRUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=AwIadKnuY1ynDRZe5QJxa83uYpHG196DorfWLRUDzCTF/kEIv17wCOYxUQCzqiXeCHLhLs343/TWzhBnKvINDDIWpjAK0Ucn1vQ/cFUCb2XpO8Ytxi7CNG4aM8/Kq9Lw4bNqBqkNCpG1se5V6a0breh6NtEnVQk6LvhUoLybU7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=AEfP6uDI; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="AEfP6uDI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGc8P+AeE3lGyeC8jAAU7YqWoh2pVmrY67hkgnrzz3OMJiC5qppxbwjejlqy7Uh+Oknggj+ooLhNOUt6NhmmH9pxeCXcEzi/pMzVNGjHWmNrx4bsccGwDOnByu8wLl+zp+iBsoKt2Sz2i97ZtyQwoJEgXyNFuGPyqnR8fpdGs2XHz5ZWWKK8/0vzCcPy9eGaXA5FEkeZcG+ZdSaqVHQrbOGwKvNTXkgUwJ2e/ZCj7d1uk7gEdo881coTFe3Nr1w9mGUa1u//0yV7fklJn4mj2xCmZYn9Mu3mvag63Hkpp56l0PR8rOJ1k7XRZMwyngen9bZ8YJT0GAf5iP61Lpdd1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3wgpbEah8TwXAIMhJl8T052N3mSFcDcdiCn+FZvzV8=;
 b=GCyN4zvebf2opVTFCheoHlv+goE3LMSpEqQL0jtW06dWNh6wd1D2UXfg2iqAbRkbBDDUEnXKdz3fFy+0QW7v8N9qCAmJioLRjmSvHNILPi+ghEzq89p5dOmu6jbbxpuEWhw6XpNA7qrIRg3EVKudiY3jXkkNWO6XCsWKKz0DefZaI0AoJfkrVAtijz6SBvzPKS2zi/2YYa+joF6CIbsA3E86FIwc1X6agMRFhvwpxZDH5QzbXcjFqf11UALiixyax+Mut3pDfSpZdSOKQKJ8LxVN/a7epHla+WZspx4E403Th186oxrerk7e8UMFezj4bLsIk2g8mR914kx/bWF/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3wgpbEah8TwXAIMhJl8T052N3mSFcDcdiCn+FZvzV8=;
 b=AEfP6uDIS2tc7ZYj+5ZSiLtmtqvpLanZHWMWl82ESL3y86CI0tS+UJjIcGaVhuzGpCfsB3dm7Nt+6MbQwnOyQaR+QmYFEZzqnvBJ4wBMb5rLejIvjOFMZSWYRrZBnKCf2IXF9DSsZ447o4EgxbJM1JucRIlf9OgobqQjF1Hm19w=
Received: from DU7PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::18) by AS4PR02MB8429.eurprd02.prod.outlook.com
 (2603:10a6:20b:574::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 08:21:50 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::c2) by DU7PR01CA0004.outlook.office365.com
 (2603:10a6:10:50f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 08:21:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 08:21:50 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 15 Apr
 2025 10:21:49 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 15 Apr
 2025 10:21:49 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 15 Apr 2025 10:21:49 +0200
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 82C0C368
	for <iwd@lists.linux.dev>; Tue, 15 Apr 2025 10:21:49 +0200 (CEST)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 7F79D287A9B3; Tue, 15 Apr 2025 10:21:49 +0200 (CEST)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Date: Tue, 15 Apr 2025 10:21:14 +0200
Subject: [PATCH RFC 3/3] station: improve roam scan strategy
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-roam-scan-improvements-v1-3-12827e086895@axis.com>
References: <20250415-roam-scan-improvements-v1-0-12827e086895@axis.com>
In-Reply-To: <20250415-roam-scan-improvements-v1-0-12827e086895@axis.com>
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|AS4PR02MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dad6ac4-18a0-4702-deab-08dd7bf6926e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjJUNzg5UUx4NGpCZ0R4QTc5TUl2ZGpaNlRyazcxY2l1SUYwdEhEcUoyMVlr?=
 =?utf-8?B?REc4NmlyTEVKbGdDRHg1QkRXc2M1RWZTVmdDeDJEM2h5QmdPSGpOOTdrMmRm?=
 =?utf-8?B?MlpodUMzQ3dSaDFBUkdlVVN1RkhMbXJmWjFwWVVuZTFoT1hNQW0wZXZqaU9h?=
 =?utf-8?B?V3o0WkY3YklwQVhwT0lTcGpkWGQzVXRLdXJEOGV3Z2RJVzRjaVFiei9PUW9W?=
 =?utf-8?B?Vk5mY2JzUW5GK3VqNDFwUHliT2tlUU8wV3VvaGNGVEMyUW1oNEpXUjV1VTJC?=
 =?utf-8?B?RVo5aVFSaHpEMkpGRkVYUnRuL0V6c3hYMGpRWnNUUnVpMTQwUHp6QUpONVJt?=
 =?utf-8?B?T0ZrWmFkRW9NcTA3QlhtRUt0Z2VCQ0J1K3laVFFJN3hWNmNjM2ZEY0FvZXRx?=
 =?utf-8?B?bzlWRTBNdWxOWXdVZWgzTnNrZ1BZR1RmeUZkVVlqaFR0UFFISStRREdGeElh?=
 =?utf-8?B?TisrcmJQUkhsdmViSFJjdzdmclpCbDQyRDNUc3NmUit4RG00YXBtM2hacUZm?=
 =?utf-8?B?YkhWWHV0RkRzSXhDQ2JRejAzOE4xeFpMSXNBVzBuQXUvaDFTZUxiQlpTMVY5?=
 =?utf-8?B?eHA0eTl3azFkQUZTWUtIaTFFc0NXclE3d3oyLzI4ZGxnYm1IUmp1NHFKR2hp?=
 =?utf-8?B?VElxQkwwWUJISXIwMFpzTS9JVUtqdjZGYWtnbDNWRE5Ca0FoOStCRXBiOWtY?=
 =?utf-8?B?Y1VuUDd6OXMycHpDL3llS1NOaHZDWEhLeG5zbTMwTmx4aTFUT01vb0V3Y1Uy?=
 =?utf-8?B?N0JtM0NCOExFeVczc2tmMTkwcHU1WmlBSW1TdmtWeWNxWTVMWSt2bUcvcWVD?=
 =?utf-8?B?bkpyRWdBd3ViQXRacjNEOGpUenVDQzlmWVBFbTdYV2tmL0I2Q3lLMDZPOVF6?=
 =?utf-8?B?RUhIbVM1aWVNK0tSUzRsTEVRcFZHdEZTb0F1ODk0NHJvMStFUlVvL0g3ZFFs?=
 =?utf-8?B?YkNMMkJTcVJmeHE2eTdHU3N5U3pZbFpTRDgvelVDeW5ZL1pYenZzbWQ0bE5I?=
 =?utf-8?B?MDByMFlxaDNmTEFDbFgrTGQ0RW8xZ3pQNnlqSFNCcXIveDhLQWJrU3BCbjFT?=
 =?utf-8?B?L1d5VVMrM3hZQVo3VmJ6bEJvTUVueEFEbkxGdnVlYnNXUHc0SUl0THdRQmor?=
 =?utf-8?B?REhNQ2QyYjhEb1BLL1MycStVZTdLTG9HWmJBVFVvK01IMmpxSEw1S1podFcr?=
 =?utf-8?B?SmdQdGg1V1NTc0g1NHR4SGZMWHU2b1VsTDRhb3Rjd1FpM0U4QVlIYlJpZitn?=
 =?utf-8?B?bDN5OTgvL3FUbGYwNkJoRHZzUTFnM2VWN25iN0ZPNDVRNHlvY09GTFVwaG41?=
 =?utf-8?B?L1RTOERJcnVaY1Z3NXhjZW1lTDcyL1kzdEhkbHljeGthb2VITXk3RHg5ay9W?=
 =?utf-8?B?OFV3dXVYRkRBZzdDQlhTai8zWXhyTVQwd3IrSlNzSGtWcFVxL2pPazByLzdi?=
 =?utf-8?B?SldCNWJ6NVBqUWxuY2dUS3RiT0JteWRGOFY4Qi81eDRXU2ZIclpmY0hlMmJl?=
 =?utf-8?B?N295MlV3MHBRcVp6Q0xBVGx4OXFxeDhvRUkwS1M1RjRDQUtqUWFnY0t3aER1?=
 =?utf-8?B?RTFFMnF5cnNXWmpFNVdlTmMxSVRmYjJkUTNBY2dTV0FScXp3aklvUVhoeWx6?=
 =?utf-8?B?UFY5UlFkYkp2emV0ek9CQjNHaHJTMS9JSGI5THlnRnhFRXowSHp4VUp0M1Vv?=
 =?utf-8?B?NzJqSTNiM2hzb0hES1NoVUpZSXNnZG5oUWpKZUxOZ1ZCQi9YMDVEQjdZTlNB?=
 =?utf-8?B?RmR2eGV2cXMvOXJubVBDd2IwUDhjLy9vV2tFaUFoYk1FQXdZWStTNjFNa3F1?=
 =?utf-8?B?NDE2TVlqSEdGQTNvdzJOWTF0RVpzUk92NjJqR1Q4R1pVc2Z6NC8rV3A5dG5x?=
 =?utf-8?B?bnRZZnMyZlNtR1FxaEdjSGRTQTFTQ2RpZVVWRzIyQThoNThtQVhWNTVXTVU3?=
 =?utf-8?B?eWVNc2Y2SkF1NUhwWTNYNDFsRlV6K01adFVBcmpTUkM3Z3JSbnV5eVV3QkVo?=
 =?utf-8?B?eEVtR2hVclM4M3B2aGhoMjN5VWxWblVQRlMxdG9oRGl4dFV1YW5vdnNOakMv?=
 =?utf-8?Q?eiN3w/?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 08:21:50.4920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dad6ac4-18a0-4702-deab-08dd7bf6926e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8429

When IWD decides to roam, it scans either neighbor freqs or known freqs
(if neighbors are not available). If it fails to roam after getting the
scan results, it scans ALL freqs. In my testing there's a high chance
that both neighbor and/or known scans fail to roam and we end up
scanning all freqs. This is very slow and if you're already moving away
from the current BSS, there's a high chance you will lose connection
completely before the scan is finished.

Instead of scanning all freqs at once, split them up into prioritized
subsets. Each subset contains a handful of freqs each, a lower index for
the subset means that its freqs are more common. So subset 0 has the
most common freqs and subset 3 has the least common freqs. The first two
subsets also contain no DFS channels, speeding up scanning even more. In
order to make this efficient, use the "scan_freq_map" to avoid scanning
freqs that were recently scanned.

When a roam scan is triggered, add the most prioritized freqs to the
list of freqs that should be scanned. The order of priority is:

1. Neighbor freqs
2. Known freqs
3. Subsets, starting with index 0 and incrementing if the subset is
   exhausted

For each freq candidate, check the scan_freq_map to see how long time
ago this freq was last scanned, this is denoted as its "age". If its age
is above a threshold, add the freq to the list, otherwise discard it.
Once the list has a certain size, start the scan. If no roaming occurs
after the scan is completed, run the same function again. It will now
pick new freqs since the previous freqs have been updated in
scan_freq_map.

This approach results in more scans, but fewer freqs per scan, leading
to shorter delays between scan results. It also avoids scanning the same
freqs back-to-back, which is generally not very useful. In combination
with the freq priority, this increases the chance of finding a good BSS
early.
---
 src/station.c | 190 +++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 149 insertions(+), 41 deletions(-)

diff --git a/src/station.c b/src/station.c
index 9972ea76..87cf9df0 100644
--- a/src/station.c
+++ b/src/station.c
@@ -67,6 +67,8 @@
 
 #define STATION_RECENT_NETWORK_LIMIT	5
 #define STATION_RECENT_FREQS_LIMIT	5
+#define STATION_MAX_SCAN_FREQ_AGE	3
+#define STATION_MAX_SCAN_FREQS	10
 
 static struct l_queue *station_list;
 static uint32_t netdev_watch;
@@ -124,7 +126,7 @@ struct station {
 	struct l_queue *roam_bss_list;
 
 	/* Frequencies split into subsets by priority */
-	struct scan_freq_set *scan_freqs_order[3];
+	struct scan_freq_set *scan_freqs_order[4];
 	unsigned int dbus_scan_subset_idx;
 
 	uint32_t wiphy_watch;
@@ -2385,6 +2387,8 @@ static void station_roam_retry(struct station *station)
 		station_roam_timeout_rearm(station, roam_retry_interval);
 }
 
+static void station_start_roam(struct station *station);
+
 static void station_roam_failed(struct station *station)
 {
 	l_debug("%u", netdev_get_ifindex(station->netdev));
@@ -2414,10 +2418,9 @@ static void station_roam_failed(struct station *station)
 		goto delayed_retry;
 
 	/*
-	 * If we tried a limited scan, failed and the signal is still low,
-	 * repeat with a full scan right away
+	 * If the signal is still low, keep trying to roam
 	 */
-	if (station->signal_low && !station->roam_scan_full) {
+	if (station->signal_low) {
 		/*
 		 * Since we're re-using roam_scan_id, explicitly cancel
 		 * the scan here, so that the destroy callback is not called
@@ -2426,8 +2429,8 @@ static void station_roam_failed(struct station *station)
 		scan_cancel(netdev_get_wdev_id(station->netdev),
 						station->roam_scan_id);
 
-		if (!station_roam_scan(station, NULL))
-			return;
+		station_start_roam(station);
+		return;
 	}
 
 delayed_retry:
@@ -3102,12 +3105,85 @@ static void station_neighbor_report_cb(struct netdev *netdev, int err,
 		station_roam_failed(station);
 }
 
+static void station_filter_roam_scan_freq(uint32_t freq, void *user_data)
+{
+	struct scan_freq_set *freqs = user_data;
+	uint64_t age = scan_get_freq_age(freq);
+
+	if (scan_freq_set_size(freqs) >= STATION_MAX_SCAN_FREQS) {
+		return;
+	}
+
+	if (age < STATION_MAX_SCAN_FREQ_AGE) {
+		return;
+	}
+
+	scan_freq_set_add(freqs, freq);
+}
+
+static struct scan_freq_set *station_get_roam_scan_freqs(struct station *station)
+{
+	struct scan_freq_set *tmp;
+	struct scan_freq_set *scan_freqs;
+
+	scan_freqs = scan_freq_set_new();
+
+	/* Add current frequency, always scan this to get updated data for the
+	 * current BSS */
+	scan_freq_set_add(scan_freqs, station->connected_bss->frequency);
+
+	/* Add neighbor frequencies */
+	scan_freq_set_foreach(station->roam_freqs, station_filter_roam_scan_freq, scan_freqs);
+	if (scan_freq_set_size(scan_freqs) >= STATION_MAX_SCAN_FREQS) {
+		goto out;
+	}
+
+	/* Add known frequencies */
+	const struct network_info *info = network_get_info(
+						station->connected_network);
+	tmp = network_info_get_roam_frequencies(info,
+					station->connected_bss->frequency,
+					10);
+	scan_freq_set_foreach(tmp, station_filter_roam_scan_freq, scan_freqs);
+	scan_freq_set_free(tmp);
+	if (scan_freq_set_size(scan_freqs) >= STATION_MAX_SCAN_FREQS) {
+		goto out;
+	}
+
+	/* Add frequencies based on the prioritized subsets */
+	for (uint8_t i = 0; i < L_ARRAY_SIZE(station->scan_freqs_order); i++) {
+		scan_freq_set_foreach(station->scan_freqs_order[i], station_filter_roam_scan_freq, scan_freqs);
+		if (scan_freq_set_size(scan_freqs) >= STATION_MAX_SCAN_FREQS) {
+			goto out;
+		}
+	}
+
+out:
+	/* TODO: Arbitrary number to not have too small freq list */
+	if (scan_freq_set_size(scan_freqs) <= 5) {
+		/* Might as well add the neighbors */
+		scan_freq_set_merge(scan_freqs, station->roam_freqs);
+	}
+
+	return scan_freqs;
+}
+
 static void station_start_roam(struct station *station)
 {
 	int r;
+	struct scan_freq_set *freqs;
 
 	station->preparing_roam = true;
 
+	/* TODO: Need to request neighbor report here, like below */
+
+	freqs = station_get_roam_scan_freqs(station);
+	station_roam_scan(station, freqs);
+
+	scan_freq_set_free(freqs);
+
+	return;
+
 	/*
 	 * If current BSS supports Neighbor Reports, narrow the scan down
 	 * to channels occupied by known neighbors in the ESS. If no neighbor
@@ -5007,44 +5083,79 @@ static void station_add_2_4ghz_freq(uint32_t freq, void *user_data)
 
 static void station_fill_scan_freq_subsets(struct station *station)
 {
-	const struct scan_freq_set *supported =
-				wiphy_get_supported_freqs(station->wiphy);
 	unsigned int subset_idx = 0;
 
-	/*
-	 * Scan the 2.4GHz "social channels" first, 5GHz second, if supported,
-	 * all other 2.4GHz channels last.  To be refined as needed.
-	 */
+	station->scan_freqs_order[subset_idx] = scan_freq_set_new();
+
+	/* Subset 0: 2.4GHz "social channels" and lower 5GHz non-DFS channels */
 	if (allowed_bands & BAND_FREQ_2_4_GHZ) {
-		station->scan_freqs_order[subset_idx] = scan_freq_set_new();
-		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2412);
-		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2437);
-		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2462);
-		subset_idx++;
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2412); /* 1 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2437); /* 6 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2462); /* 11 */
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
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5180); /* 36 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5200); /* 40 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5220); /* 44 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5240); /* 48 */
 	}
 
-	/* Add remaining 2.4ghz channels to subset */
+	station->scan_freqs_order[++subset_idx] = scan_freq_set_new();
+
+	/* Subset 1: 2.4GHz common "middle channels" and high 5GHz non-DFS channels */
 	if (allowed_bands & BAND_FREQ_2_4_GHZ) {
-		station->scan_freqs_order[subset_idx] = scan_freq_set_new();
-		scan_freq_set_foreach(supported, station_add_2_4ghz_freq,
-					station->scan_freqs_order[subset_idx]);
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2422); /* 3 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2427); /* 4 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2447); /* 8 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2452); /* 9 */
+	}
+
+	if (allowed_bands & BAND_FREQ_5_GHZ) {
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5745); /* 149 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5765); /* 153 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5785); /* 157 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5805); /* 161 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5825); /* 165 */
+	}
+
+	station->scan_freqs_order[++subset_idx] = scan_freq_set_new();
+
+	/* TODO: Add 6GHz here, after more common 2.4 and 5GHz, but before DFS */
+
+	/* Subset 2: 2.4GHz remaining channels and 5GHz most common DFS channels */
+	if (allowed_bands & BAND_FREQ_2_4_GHZ) {
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2417); /* 2 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2432); /* 5 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2442); /* 7 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 2457); /* 10 */
+	}
+
+	if (allowed_bands & BAND_FREQ_5_GHZ) {
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5260); /* 52 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5280); /* 56 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5300); /* 60 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5320); /* 64 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5500); /* 100 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5520); /* 104 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5540); /* 108 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5560); /* 112 */
+	}
+
+	station->scan_freqs_order[++subset_idx] = scan_freq_set_new();
+
+	/* Subset 3: Remaining 5GHz DFS channels */
+	if (allowed_bands & BAND_FREQ_5_GHZ) {
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5340); /* 68 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5480); /* 96 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5580); /* 116 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5600); /* 120 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5620); /* 124 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5640); /* 128 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5660); /* 132 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5680); /* 136 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5700); /* 140 */
+		scan_freq_set_add(station->scan_freqs_order[subset_idx], 5720); /* 144 */
 	}
 
 	/*
@@ -5223,11 +5334,8 @@ static void station_free(struct station *station)
 
 	l_queue_destroy(station->anqp_pending, remove_anqp);
 
-	scan_freq_set_free(station->scan_freqs_order[0]);
-	scan_freq_set_free(station->scan_freqs_order[1]);
-
-	if (station->scan_freqs_order[2])
-		scan_freq_set_free(station->scan_freqs_order[2]);
+	for (uint8_t i = 0; i < 4; i++)
+		scan_freq_set_free(station->scan_freqs_order[i]);
 
 	wiphy_state_watch_remove(station->wiphy, station->wiphy_watch);
 

-- 
2.39.5

