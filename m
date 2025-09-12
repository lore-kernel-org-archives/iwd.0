Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010029.outbound.protection.outlook.com [52.101.84.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01D7257845
	for <iwd@lists.linux.dev>; Fri, 12 Sep 2025 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676326; cv=fail; b=svdgEQ7OZbaToBgmmgnAuU3PB/5QuqQcnMOLaj7KmLd16HweVGBQAl0mdTsJSKMqGHrru15vaIOKkfHPNMV2VqLxiCnkpQavlvL+iOwysgB0WfYg4H8CtawI5L3PVA8qNNToVWZE3s+itLX/lP1b6wDaoPaqRQB5Vz1x38UyecA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676326; c=relaxed/simple;
	bh=tZHDIKZ8dBswzE3feIhqz3Biv5WMPM91AsVS/ZznoGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=s+Shn/BLmjg0fyAanfeKms3o1ZcE4obf4bnVnZVGArjVH1zys1bLTuxu03dpQlwS9Ys6WMKy+cmhgjGFCbKi0X9gVZY2LzlSJZ6fcP3RGlq/SZR7uzeNb9QZIzujEQkqdV6NouMcH9+Gv0Ja+HFPKDKOg92SpzWoCw2Yu7oMgN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=N+jN9Dni; arc=fail smtp.client-ip=52.101.84.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="N+jN9Dni"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUpfgn3tCw3eMibFFHGvrTItwj808qPZsUeqQhvgRzbsM9hoqix0PM23Wgf+r8I8Z+AfdV2XErCFQYLd82TN/OQ3C9upLvXIGdmaYqA3DCURwtHG2zTCyeIXT+PNtyXOn4iJqnDsVY2eVbO2ZiPtL7nxXvo1aCXiG8sgpXQSi7NfSEhvrdPZt/7I32cwKMFm3xsWa0oJh0ifI6ei8iTjUmscDwl0yrkSSUsf7ubIRCLme4YgjW+OHOqYg6phhrtP0iTX15yGoxhb6iw8hmHw4i96ch6KOqGR+YgqJbRL8B2vLxtB1syOVQTj40tlFCbY17HfkJpO+x8oMpAARgDLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKyLy4zoTtf+Jo231GojnKXDq9+Joyw+AIo7wQT+TK8=;
 b=mr/+o5NS9PBVaxNetFETYoVpbQ6hrfxvvdCWCM7PEO1vHSVhcAFgFS2vCe9ABe9DXLRRQEgLjYTxSofnvJ6iKcRxIM6APgvkI0wkRlR8103sUeLb667guQtPNAGhdQxaJv5kjikXdtn/eSIg9rJspng7GEJQudtE129pdjAiLCnYSwabPWVYCPrkySWbSZ836qxQIMqKLpDLNXu3exz/G3691R1RuqnFHc2WXQFwUjI+547mZ5RIMNjHXercCvhVQgJzKIew6Y7noXPGOAowqFqTPxLKvsC0xZoI9/NhFivLTIBI6WdF/m1dP/jJeE2FOFdRAwGUJEjDlgqJ0/nofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKyLy4zoTtf+Jo231GojnKXDq9+Joyw+AIo7wQT+TK8=;
 b=N+jN9DniFIVc9X2M08AY4hbyUGMQeYhwvA5QVfKXsbGKHRLLBKol0C6bZa2Y/aGHngJlGTt+DhP9HqScJfmClDN9Y2tWb71faJPOx0jIDza3rtQyHgyrPA9xcIBDU8oTY0ziXTi5ajXxOA1WVCnG2ybzmWj3hTTheR4NySIlLxk=
Received: from AM4PR07CA0029.eurprd07.prod.outlook.com (2603:10a6:205:1::42)
 by VI6PPFF757AD860.eurprd02.prod.outlook.com (2603:10a6:808:1::327) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 11:25:19 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:205:1:cafe::aa) by AM4PR07CA0029.outlook.office365.com
 (2603:10a6:205:1::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.12 via Frontend Transport; Fri,
 12 Sep 2025 11:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 11:25:19 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Fri, 12 Sep
 2025 13:25:18 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Sep 2025 13:25:18 +0200
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id D6BCF2269
	for <iwd@lists.linux.dev>; Fri, 12 Sep 2025 13:25:18 +0200 (CEST)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id D3DCB287A789; Fri, 12 Sep 2025 13:25:18 +0200 (CEST)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Date: Fri, 12 Sep 2025 13:23:20 +0200
Subject: [PATCH v4 1/3] util: add scan_freq_set_size function
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250912-roam-scan-improvements-v4-1-761a92734603@axis.com>
References: <20250912-roam-scan-improvements-v4-0-761a92734603@axis.com>
In-Reply-To: <20250912-roam-scan-improvements-v4-0-761a92734603@axis.com>
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C717:EE_|VI6PPFF757AD860:EE_
X-MS-Office365-Filtering-Correlation-Id: 70bfdb0c-d3fd-4549-8963-08ddf1ef0e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVQ2Um1ORFlLdkxEUHVFUkZscmd5KzdXQkNWVjBEQ1lZejIrT2VPcGFCZHJH?=
 =?utf-8?B?Ly9wZGluMnczN254eUFweUZ4N0gyNlRBVjc5RTRCb2piaE42SVFPQWVEQkQ0?=
 =?utf-8?B?K0xhVVRuOXZNTG16M1hwK1VLZDBnUWcvRktXeHgvajVuQm4rRDRxSGpZcHQ4?=
 =?utf-8?B?eS94Y3pnNzF1OXJRcnFScTdZb0VhRG9ZUndEL2FWMW5LR2x3aGowS0JmTXF1?=
 =?utf-8?B?LytjY3RuVXh2NXNPZDJqZC84TlpobnNHM0NLR3VOd01hVksrMDZsSDExR1VB?=
 =?utf-8?B?UVFXMEpEYUI3NU9wV2pXbnR0UDY5V2M0cStMa2ExamUzbUNBWWJzTUJKaisy?=
 =?utf-8?B?RXpGUlErYkZxbm1WTWwvbjBIcGVRZk9VUUJwM21RU2pNcE15SUtWc2lZT1J4?=
 =?utf-8?B?TkNiRmJwWENaZ2Qzc0FidURJNG1hM2duTU5HMDRhaHcrbjBuaUlkMU5UVWRa?=
 =?utf-8?B?WTJJcU9Tdmg4OWpJeVhZOW1qTXBGdmRZRTA5N2FBby9QRktIcmxsaHRiNzln?=
 =?utf-8?B?eG54NWgraTg5UFRwTG54ZnpXTmkyN1dvbjNEQ2psRFdDYXFGN2dWYlI3ZFlK?=
 =?utf-8?B?U3NYZEFuN2czdkpvMi81UlBsNWJ5Kzd6TGJCZXN0QThKTnJQQVA3bnhNTGFD?=
 =?utf-8?B?MXE3OWZkN0NnQXVxVjI5OWZGVmkweDJNaTNQYlhkZ2xFTGppbldmQk9ra1M5?=
 =?utf-8?B?MlYxYkNhM2lYYWtQa3FRUDlrandwUU05ajJpTlVCVjRQekQxdk9qbUkwRytP?=
 =?utf-8?B?ZlRvNHBHMlhmNkpxZU1IMTgxUE5ZOTBVQjBFY0t2YmJveVNzVUFCcDRRV2U5?=
 =?utf-8?B?SnhLR3BCS2o4SDR0ekJUM0RYTHFJTDNrU0JXa093S1RCSlNkR1ZsSnFrRlFR?=
 =?utf-8?B?K0J2dmlxZTIycnhuRkFkU1BaR0FTaWZaUXFhVlhQamNHLzBQeTVXbGV3cGJn?=
 =?utf-8?B?NlJRdzVWQ1l2djJ1VFNua0JGZUNHU1FsclNHK21yNVA4MlAzS3JQVFgwSlNz?=
 =?utf-8?B?eDhwMVJOWnFuMUpaRXp2TElKRDM3d3BVUGRGM2c1K0pSOERkYlFORmRwVnkr?=
 =?utf-8?B?RnoycEZibllsY1EvTExxbURHT0QwQlR6SjBEYnY5TVp4YS9OSzhLTzZDbXND?=
 =?utf-8?B?YTZpY21jYTl0L3luT0ZteEJBOFVoc2NoWHVTaFJtVXd1aFRLTjMrRTI5UU1L?=
 =?utf-8?B?ejBaR1ptSnZzbmE5RklmUHJZNHd6UUVJenc3SGR2cWFWMFl1amEvMW9YamZI?=
 =?utf-8?B?RUdOa0FnVVFybkhId2xGZlNGOWJkb2JUaEplZHl4T0E0S210QTNvL3MxNi9C?=
 =?utf-8?B?VUJ4d2FCUzZPdnhSVmxoQ1FWUDAvY3VtTnQxbnR5eXVXaStKWFp1UlNaYk1O?=
 =?utf-8?B?UWJHa0MwaSswODBNazhiSEloQlR4VSs1eldQdmEzWkYzSHYwcWIyWlNvVFdu?=
 =?utf-8?B?aUZzZjlXbldpT2s5WXNsT1kvbjIrL0VSKytTK1lsaEIyYy9yK1lyNG92VlA4?=
 =?utf-8?B?Lzd3bUpUdmFVMjVQUkpPWC9XUERXZ05LeUJ5a0g1My9aUzRWaU11ZmRnUlh5?=
 =?utf-8?B?NThIWEMwclZJMlF1cGhHWUpveHZMUGZRRzZHcHJLMXZDaFYvYXlPa2JaN3E2?=
 =?utf-8?B?YURjeFJESWxOdmR5TmxHeEl1TUx5RS9YN0FianlBek9tcFFZQjVZZTdabjZI?=
 =?utf-8?B?ZFNqdGFYVTE0ZGphaFF6YVRwMVhjN214R1BZNS9SdUxaK3NpbzhrUDVLTWpP?=
 =?utf-8?B?dlp6L1d0WTZqQTBKRnRCMTQxOGI5bG1VQUljV2t5cmRuTm51VFZ4R2owK1hG?=
 =?utf-8?B?YS82T054UXF1Zk9zK3dUeEpyVHN2bDZJcGRBNXVRWkFBTHc1QjgxTW81ZkYr?=
 =?utf-8?B?ZWp6alo0dnp2SjBpWEdrMWZaK1c2Z2JqNnVTdWdjRitoTGNuK3RuTVpNK1dU?=
 =?utf-8?B?Q2FpUThNVWJqUkhwSi9rNTJzWGNobW9OVGR6R1BvNUUwSnZWTzFjZTNLaTk3?=
 =?utf-8?B?N2hSQmhFNytFbjRDaURLdHg4U054S01MMlRGT2gyTS80bkpKK2pVeWtkNnpj?=
 =?utf-8?Q?/OrFGn?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 11:25:19.1930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bfdb0c-d3fd-4549-8963-08ddf1ef0e16
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI6PPFF757AD860

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

