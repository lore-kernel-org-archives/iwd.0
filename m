Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1361C8616
	for <iwd@lists.linux.dev>; Tue, 15 Apr 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705316; cv=fail; b=Kcg1kTs3tV4t3FfSrjSv93+xCpdy9zsgZKU3dkVqF8mnmKILZNi2NvEnpbSVLPh8wI3a6jWnjhw2lAj9QN2EZ4B+cW2d078rYPheriFZsi1V4lDzi6rsYxtFEySiLXGi3cNlDz94WJpUSegEOfK9Uqg1dZtffb7UG7/rES/+dcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705316; c=relaxed/simple;
	bh=tZHDIKZ8dBswzE3feIhqz3Biv5WMPM91AsVS/ZznoGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=nZwzCrxrit0GyLhbpYoRHbV/4UWAD/uzRCW3sSzhaN33FLDFVSDQlh1Vc2655Z8eWqL6UShVxlTPsIe587coUZVJFZK2XkBqFPCWHxK5+TLmPgucJ1ENI1Runjsdu3TgstH/DBFsKkNGXwwkqDsbd+gOus9Ph2K9IVQQfwD9L5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=H869wfQm; arc=fail smtp.client-ip=40.107.105.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="H869wfQm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAr2VAl1OTCDyLmCoR5K1lMCs5x2q3CXmW7yH+pdDg41KJ5VsjebY4g4arEf7aWBUqHS9LUdM4JvZxDX/s4h167EzLKgQdMKyk163hfW0Sn4D61XNlDM+AlgEM1/oDf88htMcRD5gADe8xQ4JUCDmCH1hxbonxhIjY3ypIWu2LygsJkrYOr7SaJudSbw+Wxz4U5QVInQHHAzbDsjWK7iaxW2QENejb1O8e+x9RtdhcBIv9Rr4qpvMs/aec0jTr0H/PMaxb7OJNMbpWNcov5qJiORbLWNUbxjqj+g0CHk1AQWUaELmKLNr8plI+Rcvaoa5zFwO+M0RmQOPhJ1NoldnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKyLy4zoTtf+Jo231GojnKXDq9+Joyw+AIo7wQT+TK8=;
 b=GDLl9+LmcjJvpcbh5xZSnX6tUhz8nwTL8QK//T16Y+NWnlNvqyOpG+NKWFL/gf9jqJthhYeX5Rf03kz7dGz/XteuQ6+SOEOr2TiMNwAFHvRkOFWGcnJEtxBwse/2K1eKlUmacpDvhIauEVxm/uXaFeBMCV3v4CYKX3c5IsqRMLFylX0ETaNolJ+MdXi+oUX7DwV2y0oLc2ycEt6tIkWWM4Dwwkk9YVPnjFoEOYW29pLwB/qgtnrMt3fB69M2IAFOuxWW4//iV23BwrnwODjy/Thb0SbtKfu1DWpjbeCwUFMStaB3wr1rzql6vaWOLRRT/t0mL3kilPS3lFwbmb+kAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKyLy4zoTtf+Jo231GojnKXDq9+Joyw+AIo7wQT+TK8=;
 b=H869wfQm2Otjw5UsYA4VERJ/yTfRUHAjQPPF8dGsVkprP2Ay341yUMWHjnIYpf5UHP1cH2JRSthxx35/4JQWcZu8sOyTWKBwi9u4KjNeboK09J9rS2929/lAkCho/2ZEcd5tpxvZaIW4UOoSuaDf+joGLJw/yvixXX5ctPib4/A=
Received: from DU7PR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::29) by DBAPR02MB6405.eurprd02.prod.outlook.com
 (2603:10a6:10:17d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 08:21:50 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::65) by DU7PR01CA0008.outlook.office365.com
 (2603:10a6:10:50f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 08:21:47 +0000
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
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 15 Apr
 2025 10:21:49 +0200
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 15 Apr
 2025 10:21:49 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 15 Apr 2025 10:21:49 +0200
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 810AB1F5
	for <iwd@lists.linux.dev>; Tue, 15 Apr 2025 10:21:49 +0200 (CEST)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 7CD8F287A78F; Tue, 15 Apr 2025 10:21:49 +0200 (CEST)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Date: Tue, 15 Apr 2025 10:21:12 +0200
Subject: [PATCH RFC 1/3] util: add scan_freq_set_size function
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-roam-scan-improvements-v1-1-12827e086895@axis.com>
References: <20250415-roam-scan-improvements-v1-0-12827e086895@axis.com>
In-Reply-To: <20250415-roam-scan-improvements-v1-0-12827e086895@axis.com>
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|DBAPR02MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c233ab-fa23-4741-e177-08dd7bf69230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2JhaGxJSnVFSy83L1JXejFhU252VHFlVFRzMjRRUFFINDJuenptTHl1SFN1?=
 =?utf-8?B?amhTK2Nxek8vdnlTMEhqbG9SYWpGYkpUckxpVElPamJkQjlKOUV0Z2IwSVZN?=
 =?utf-8?B?TWM2MDVwbEw3YjU5cGp6YVBpM2VhYWs2bWIxVVdhOUhSSDNXeXpHcTZNNzBB?=
 =?utf-8?B?WWZtL0xCVlhwT25nRzVPWEErcXpJMW91VVNGN0NQWW5vMXBPN2hLeU8xUnZ0?=
 =?utf-8?B?T0R0ZEJPbU42WW1TZUpnRG5LNVc1emF4TnUzc1Vlek9STFlOVjVISnpKcUhm?=
 =?utf-8?B?WGd4Y0xtUkRsSUxPUWx5YWVxR1dNclRZQThPYVQyeEcwOHRXenpGRnJQNWlw?=
 =?utf-8?B?RWNBb2c1ajNaOWI5Z0dRZXd1QVEwVk5NUFJmOUtYNlR4SXhHQUh1R0xENy80?=
 =?utf-8?B?ck53THoyeDNQYU1EUnl1Q3V6cnBydW9PZU00bXVXdjRPYm5Nb0dxTzh5THhm?=
 =?utf-8?B?MmtmaWhlZmJFS2RqMFhTQWlqYnhOcVlTSUF0TEJyQ0dBc3ZsdUYwd1ErQThK?=
 =?utf-8?B?QXg1akdUZ2M5Sk1BSGtPMW51akVmWktVOGp3UnNBQytMZUs1QmNiSEVzajZn?=
 =?utf-8?B?WUgyNUZ6N204YWRPbWpvYTdRLzkvQ1c0cTNaVUxDeVh6V012WEhqMTJFTFNT?=
 =?utf-8?B?anNMVlhDUGMwZVZibk50NitxVDA5UnRhSGpkRUdaN3lLN1JzWG1SQUJqSXNs?=
 =?utf-8?B?OFRlRGZOU2lCc3RvdEdkYlJ2YTNvbjQ2MjRmbXE2NlNZYThCaXZOU3I5ZEhU?=
 =?utf-8?B?SWJDSWFqT2MzbkVtSXdSUTR4ZHNRV1pKaXpTbGtoWmNXOExCU0RSY0RvSzhN?=
 =?utf-8?B?aFVoMnJWUVFXbXYzNE5FYmN5UWthTjA5L0UrOWpBMkMrNTZYSWxKQjd2UDBp?=
 =?utf-8?B?ZVdzSFNzbWRjUWp5SGhHRUxldGNydlFMd2JqOUR1TVRxbXN6SGlRUDQxNEFX?=
 =?utf-8?B?bi9kNzNmWDFWRDJaalBYUWR5U2ZJUm41UVlGQ3ozdGk2bE5PNG5Rd3VLK1FT?=
 =?utf-8?B?a3oxUDJlcHhDZHFHbitDNUVzbnVXbTZGSE0walFYRFMxQ1prbFhwTFRIYmtN?=
 =?utf-8?B?Q3NzR2tUMGQvcFkzdnFJTHpDTWowZ21KdHJGbExsK3FhaW82VHdUZWx1cW01?=
 =?utf-8?B?ZWtOM3RvamdSVWNKV3BFbTEwRXBkRkJMb0pyc1F6dENQMHNneHFvaHpxbndq?=
 =?utf-8?B?aWdWbGwvbDMxcnc0clBlSFZxUmYrN1pTTnVSdG5FeGlsbGZJUEl4YmpJRy9r?=
 =?utf-8?B?QW0xS3VXN3NGK3N0dzFLYWY1Z2JJWTUxTWUyb0kyVmw2Q01jT2VnaTBpd204?=
 =?utf-8?B?NTQ0MTZPNWVqcElLcDlaZjlvR29meVBMbERVV0ZDTlljMVdoVFRrU055QU5S?=
 =?utf-8?B?azg3K2dLbVM4QW85c3plQ1UzWGVUdEVHTnNWT1FUaE42UVMrYU1YUDBYWXR2?=
 =?utf-8?B?YkxpL1BNdTdWNjZST2dXdUw0aTZZenpraVRLWkpNQnhkTEZQdEtFV0pXWWMv?=
 =?utf-8?B?cmo2UFFFWkE4MW1hemVnVzVmOXFpZnJmTnBkZjhlSUdjSkMzN0hXeGZ3N1lJ?=
 =?utf-8?B?SVZlU0YrSVhCeHZuUnIzak9iaTNNTmpSNXZaeGw4c21UMUdQMFpwUlgvbFQ1?=
 =?utf-8?B?WDBReHhsWWsxTTBtZDJVNDNrNW5pV20vWXFtNGhOYys5NEFZQm44enNWeDJI?=
 =?utf-8?B?WTJtSmExcW5KTTZxeDNjblRHVGowU0VYazYrTlg3VmRxeTB6MVo4Y1lNb1NB?=
 =?utf-8?B?dzhEUjhySjl0eGhSWGxPUUFQU09mZ3k1NTBDMVQ5YWRxNTVFNzUxd3hQa0ls?=
 =?utf-8?B?UXl0VE5ZRmRBenUyYnpxQ0JYN1k1UUxucVV2NURFQmROb3dIMUhkN3VreDRT?=
 =?utf-8?B?L3dRaWhKSHJDUmRCeEkwY2g3M0F5aWZBVjlmcGxkckVlRGYxc3VqYjBtcHVv?=
 =?utf-8?B?L1E3eWUvemVuSnRrVW5sYktZRmU0cVVLMXQvYlIwQnYwRi9yYWIzYzlEV2VY?=
 =?utf-8?B?VTlxd2hxUFFPU0daTDhqUXZwVHNGUWF0c1k2cEhlNWhBM2ZiWnpRUk0xWGRR?=
 =?utf-8?Q?OzIjSc?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 08:21:50.0857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c233ab-fa23-4741-e177-08dd7bf69230
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6405

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

