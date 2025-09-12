Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086DB1F4C9F
	for <iwd@lists.linux.dev>; Fri, 12 Sep 2025 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671767; cv=fail; b=u0/jAQXs6LI/YufnQaVWO7sfxcOTQqCkn7x0vc8g6U0ciy9jfaFypfQZF3ijueNbV7drxmg4FaHCJ1jYHt7l9fzvu50ieOMga0hMHZpsBOJRU+U3mK5vtoEbGPjpDAP8rBXp5x2pPz1gABL+zskdfOOPgm2bQ+3WxPV01rPy5SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671767; c=relaxed/simple;
	bh=tZHDIKZ8dBswzE3feIhqz3Biv5WMPM91AsVS/ZznoGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=TgUYYqC54317wU8rwE5YGlytbZ1c7iaX61u2Bd+DRCv/fTn+oySrSpoguiPhOpNttkRIe+c7M816pjoUkJpX3I1f53aJPE0RMjjnQHBcgPBtUJpBR9TSwUY3bVjPq+qQavJDWAIbCcSN3TM1XE1Hs0bDbcDWMUL4Hr7lro6jHfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ks0K/XDI; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ks0K/XDI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCKz3vV2L19831JsxvSJ5RkYaVtxSBHll7n7pUQntlxzh+g+VIcj1kqtt0Dspg/c/CD6kBdUV8sQbZphT9Rbdbk18N/qRrflaPYL8YCXwvhFDMx6cFC6vxjnN1ptMvA5Bypc/9EKtb3p3JRg56DyxMZWoRODC3+OuUD3t8GmcDnoJRu3EklVaQpX43g56G+qfheDJFDUB0QsObiMGnlicMtMKKayfLWxPeYZUN9vvpFXOUcyIJbIb74sFh3QzMbf45b/Br5lybwqbgmMghFJrth6xPrIg4OaZiOO9ghummm0wzGRNIX03GBHClN6cjpV5ngCmyUZniN1fN3JK6IADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKyLy4zoTtf+Jo231GojnKXDq9+Joyw+AIo7wQT+TK8=;
 b=kiyGPoUCMogMlKggvo8KJJDngvuk196J3Icgo4wndxa4Z+FJc7CUMSbSspjk1VenRQ7JjPQwQM9l9XnThFmD/SSPJHpdr1ggksPcvB9QwkKXJUg+VtujOuOePb0ytzgLEyTHOAKbDz9nt9Rd+hzL5rnBm9GBb6TyLQeK7eFxNk3X9ExcrKCV+m90HSDesdlkYmVLXuKWXjP8P7J6tmzahDf7/tP2Ydozhub4yaulwyHR0SYExByIo4N/Nh4wGK5tyYGWetvaCuSXVboKtaAAEkcAB4FohrZHvbv0FTPL4pwBAV9YgwCkYXIWpf6gGsxKJPkI6qAaHq64ksYNVYOpqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKyLy4zoTtf+Jo231GojnKXDq9+Joyw+AIo7wQT+TK8=;
 b=ks0K/XDIvJ1QCwisqYJQhlVstrmyb8sYpyVlwl6jbemvXNUuQg3QLNyKv+tGdpp0YzfG3HDUXnK7PBKR34UUfQ5r8qalNM6WsGXT3+oZPhvPKQhLUcpLrh3GnCrDLLj3FVyht+OlqMzTOLGLnzNxw4TvaBu78M25zhfzzAt0Yc8=
Received: from AM0PR01CA0157.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::26) by MRWPR02MB11504.eurprd02.prod.outlook.com
 (2603:10a6:501:75::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:09:22 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:208:aa:cafe::65) by AM0PR01CA0157.outlook.office365.com
 (2603:10a6:208:aa::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 10:09:27 +0000
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
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Fri, 12 Sep
 2025 12:09:22 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Sep 2025 12:09:22 +0200
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 16C401E53
	for <iwd@lists.linux.dev>; Fri, 12 Sep 2025 12:09:22 +0200 (CEST)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 12BA9287A789; Fri, 12 Sep 2025 12:09:22 +0200 (CEST)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Date: Fri, 12 Sep 2025 12:08:51 +0200
Subject: [PATCH v3 1/3] util: add scan_freq_set_size function
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250912-roam-scan-improvements-v3-1-ebfd61dc6239@axis.com>
References: <20250912-roam-scan-improvements-v3-0-ebfd61dc6239@axis.com>
In-Reply-To: <20250912-roam-scan-improvements-v3-0-ebfd61dc6239@axis.com>
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|MRWPR02MB11504:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a4303d-f564-4262-b57a-08ddf1e47209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MENVbHlkWUdNdEVFUzRLa01uRWY3YXc4RG40N2dnOGpFUTc2OWZmYWpvSW5t?=
 =?utf-8?B?TTBadjVCTzY4ZzVBMExwWEpHSlpLZzBTRkxZWCsxclk2aW93ZVBsejZUdEpZ?=
 =?utf-8?B?YnhWbGZaUlFJL1MxT2dXdEpDNmQ0OHVWd2ZPaHJCNGdUQmFzQVFqck5FajZu?=
 =?utf-8?B?cjd3d1JxeS9ZSTgwb3ZmTnRYWmNGODIxbWRPMlAwUkJnWlRNTHNPWWg4d2VO?=
 =?utf-8?B?eUtvWC9RMmY5dTgyOGU2ME1jVXhBNzRNTmF5WUEwTTBvMFRFM0tjVGh5bktv?=
 =?utf-8?B?SnJVUnQxTWVhc1RrWGJtcGh3cTFIazBUYWFaR2tudTIrTGRpZFZlK0dWRk1s?=
 =?utf-8?B?YmJ4T3NJbEdzbFB1MXFyK0lrbUZpSGtQbWJKOElpYVM3U0sxcmNvbURTUjRV?=
 =?utf-8?B?TlQ2RFBMZTlZekMzcDM5TnNiWDd0UFV6azA2UVFHcVp2Z2NSd1l5RjdOWTht?=
 =?utf-8?B?QXNXelJ2d3N4U2NSOHh5Y0xlY2FQYlVhQUhJdG8rVkRpU3BvT3ViVkJ5UC9Y?=
 =?utf-8?B?dTFDYThDeVU5WE5EaFBPSFRNeU8wbWJuNFZubDJsYUJrblFQRWtNaTV4c0Rt?=
 =?utf-8?B?ZmFGOUZGMkRDVXcxNG93dDhOUDFDRG52ci9PWmx6QlNHaHhmcWN6MFFjOHZk?=
 =?utf-8?B?c3RDTFgzN3RyUndmbmFFd0drNUcyWmV6RHpxNFNmM3owT1RkdWlhNTY2RlA1?=
 =?utf-8?B?YjdNaWxBQjR1Wm1HbHpxNnBwZzQyS2lOWjdjMWFDSkkxL21WM3ZhTk1zbDlH?=
 =?utf-8?B?TWdXWG83aXBPdCtGU08zaEM3dUZtQlNIMUc0SnJtM0RmVjZ6bEN1NHgvTXZn?=
 =?utf-8?B?eUc0WGJHMGpMeStzZHl3WGFYV1JONDFqVnZHS210RG9JdlJySmdVQWZHdElV?=
 =?utf-8?B?SHlBc3VuZStjVUFBaW1sQW80NU5DR1JIQVh5TThIdXI3Z0ZaNmQ2UHlnczVJ?=
 =?utf-8?B?RGYxUElnQUtyTlJWZEdhRkNBMXh4TWpjRjF0K3BYRUtmOHRoTzVOeWttdVp2?=
 =?utf-8?B?NkRsQm5JVm01YjIvdi8xbkdyUjI3QmVIbDJZK2x6R004bXdYWVNORHBFU1pN?=
 =?utf-8?B?akNvRFEwM1hMaEUyamRhdU5YY3dncDBhbEdyZTBRb2t0SXlENWRJUUMvWmtr?=
 =?utf-8?B?NmZRU2NzTnVjSGo2VG5nUXgzOWQ5RS9RdzRFK1U3SkM2NU52NWFpbk1HcXo2?=
 =?utf-8?B?VzlVeFNRVG9sTlRldHNMRVorU04zbWpzcjNvZzJ5ZjAzNVIvVTBmM1RHUkhD?=
 =?utf-8?B?eXcwZlU5dVNNUUxUZnVXd2lHMWJGc0VUN2JUNERsTEI3UmFMcWtrQnVOazFU?=
 =?utf-8?B?dlRENnZQZHJ5NTBWcW1OVDEzcHpnZTV6U0h4d1YxVnh6UWpleW1EZkdSOHQ5?=
 =?utf-8?B?c2JtVVhSNFZZc1lxOGRyL0NHN2ZoSGliVjBTOW9GbHcrUGpNS3hDc1dBRlNU?=
 =?utf-8?B?TGQxQ3dvMXVJTU56bXcvVmpuUGpYeWlUaXdSNGJOY0NSRDhjbjMxWWsyWlVP?=
 =?utf-8?B?aktFTG41Q2ozOHNQS2Z3RzIyRWd2bEVFcEUxemJ6VWdzL0dvYWFBUHVFb3JV?=
 =?utf-8?B?WnpLMVdKKytwTC9PNC9peVVsN3cwVU1YYWkxQk91NFZsNTFXd0NjbW8ySEMv?=
 =?utf-8?B?NEF1d1RBZEZxa21RTXlYZWtocFlaVlJnNjBvWFBKQ004d0VGNnVrZlUzQWlK?=
 =?utf-8?B?dnBiTHVLcTg0OVk4VGE4Ry8yNHJOb0xGb1JxUlEwR1dISGlnRW1SYlI2NmZs?=
 =?utf-8?B?MFZRa1ZveXVjeFdkekIyV1pVdVNFbTFqK2ZHUUpmMlduNDFYWFdDa2FPU3lx?=
 =?utf-8?B?TXBNaXFKRTFtMGNGK0VXbHhkV09PNzl1UDc1V2RycUVKdTFqb2s0RE0rWUs4?=
 =?utf-8?B?OG5Vc25TRmttb1BTOFpDeU5xRTFvOEpBbHo3SXFuUmJlaUZzdGxLd2hwSlNa?=
 =?utf-8?B?WFRhdVhRSGxPNWZNblRmOWluNWxQaWdhV0lLbzlyRDhDNTZ1ckpIZW15TjFV?=
 =?utf-8?B?aUhueEpiZ3JKWjhPZXZ4UmZyWWhsMjN4eFR0Vk9DNUtiNUFPNkZ2WmVFeGxz?=
 =?utf-8?Q?8Rew4u?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:09:22.4150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a4303d-f564-4262-b57a-08ddf1e47209
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR02MB11504

Return the number of freqs in a scan_freq_set, useful for knowing how
big the set is.
---
 src/util.c | 11 +++++++++++
 src/util.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/src/util.c b/src/util.c
index 65b97c8e..1e1dfc15 100644
--- a/src/util.c
+++ b/src/util.c
@@ -637,6 +637,17 @@ struct scan_freq_set *scan_freq_set_clone(const struct scan_freq_set *set,
 	return new;
 }
 
+uint32_t scan_freq_set_size(struct scan_freq_set *freqs)
+{
+	uint32_t size = 0;
+
+	size += __builtin_popcount(freqs->channels_2ghz);
+	size += l_uintset_size(freqs->channels_5ghz);
+	size += l_uintset_size(freqs->channels_6ghz);
+
+	return size;
+}
+
 /* First 64 entries calculated by 1 / pow(n, 0.3) for n >= 1 */
 static const double rankmod_table[] = {
 	1.0000000000, 0.8122523964, 0.7192230933, 0.6597539554,
diff --git a/src/util.h b/src/util.h
index 8aef2985..7c024c79 100644
--- a/src/util.h
+++ b/src/util.h
@@ -138,6 +138,7 @@ uint32_t *scan_freq_set_to_fixed_array(const struct scan_freq_set *set,
 					size_t *len_out);
 struct scan_freq_set *scan_freq_set_clone(const struct scan_freq_set *set,
 						uint32_t band_mask);
+uint32_t scan_freq_set_size(struct scan_freq_set *freqs);
 
 DEFINE_CLEANUP_FUNC(scan_freq_set_free);
 

-- 
2.39.5

