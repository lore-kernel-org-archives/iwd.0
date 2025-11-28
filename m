Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E69325700
	for <iwd@lists.linux.dev>; Fri, 28 Nov 2025 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330914; cv=fail; b=tTM7G69Q48UwDx+ECfJLS9ZaIGcLlkH/CrKkJhn6bw1RLJAzr27FpnjZRjbQOgPwkGLWkWSuo0kPJzhWvJ8z3jN3BiRy8wMd/6Vj3mpdYiMacVJFqj2ptz+gyd4MLWjHV+4ETKj5NtuMAeox6Pq+i3zb69yxpSX1lRei7p9/U7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330914; c=relaxed/simple;
	bh=tZHDIKZ8dBswzE3feIhqz3Biv5WMPM91AsVS/ZznoGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=t/QuaEV0CK/OLg+fZ0m3JbUnWjY91OtSKN3TKDfyJSEpkjaoFBCWpPlVWzh2zw6t2AYqG+v0v9Qv9Vcfid2UlvoT+oR9TCQoLPqlH00fgxcOAs/N1xTQYQ6JP4Wi5y+U13exT9hwbk/AT7Dt9tPwC8EeiSe0rIgIr1gY8IfBE3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=IeFuP5T+; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="IeFuP5T+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kk29AS2WJA9jcxDL8+dc4ht56mWNCZaEV2oDxTZuaxSwR79OmheQILcAgRoyPJaZ11IrLfnhqWv3U88vXdLxCD42WvAq1YYEgbPAQvC9XXbZpqHe0zMw7fdkTwv6PKYVEeD+otqX0/GzzcCARYQ8HRnaMgENwOGrGPpTB/HphoxpNO4xh7sHnKgrXhxB4vlmblV3P2j8FKgkXAtpDVrL6l+O+RkSA/+A9gMDOvTfm7DEcWuLYWcYa1kzljTGXJ9vFLD7ThEYof2u6hDnDQcMlzSeLyoMQn6FzDG73IdcgvW8TZKPM9orovF6WbZjuNx9fkI0X19/iCK7xhuywP78Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKyLy4zoTtf+Jo231GojnKXDq9+Joyw+AIo7wQT+TK8=;
 b=gePYF0c0LPz/gxI6/4MwlGNA9F4mIyVjd5Rc5LtRJUEahCgiYEYqHv+e9jCD7HmFfbHRiFvw/yC9bD8FooQgrWhDweuqQ6tkzv4AYLYV3ZZoIQyRliH+GhTK3skwqBIxIsC32udFbxllbm9Vsnp2QKiEkEIJzxH84XfNh8IvYYans4nxnatu9/WkhYZxZRS7EoNWLXXy/kWyU8E4t8/aFalGAE/poxhD7XyxZm3Cq/1d8Oi8V/iQgC3ucG0LYgNXPNnKKwWQ8dhowuy2OuEVDxMtHhyrvNK1XAFelgJkMWKCltkShOBTaye6xJDT/TbCQTR/RafIv3sRbQVFLYhHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKyLy4zoTtf+Jo231GojnKXDq9+Joyw+AIo7wQT+TK8=;
 b=IeFuP5T+LzON+bip2NQxWeCVFkes789z6ufvKLjHjUFHeskEUNtoLIrP2ntal+7zIEC5u2GLRDC1eA7VYT7cRq2qmnEUj7HgQfbnGtdmZaYjqLwS3Tzq4ZcHLE48B7xDAUHxFC2GWBIqiLHOA7uWlnQRD3Km/sPBCBpsXaLO7SY=
Received: from DUZPR01CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::6) by PAXPR02MB7863.eurprd02.prod.outlook.com
 (2603:10a6:102:288::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 11:55:08 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::f9) by DUZPR01CA0018.outlook.office365.com
 (2603:10a6:10:46b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.16 via Frontend Transport; Fri,
 28 Nov 2025 11:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 11:55:08 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 28 Nov
 2025 12:55:07 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 28 Nov
 2025 12:55:07 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 28 Nov 2025 12:55:07 +0100
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 729D08C8
	for <iwd@lists.linux.dev>; Fri, 28 Nov 2025 12:55:07 +0100 (CET)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 6E0712865169; Fri, 28 Nov 2025 12:55:07 +0100 (CET)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Date: Fri, 28 Nov 2025 12:54:22 +0100
Subject: [PATCH v5 1/8] util: add scan_freq_set_size function
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251128-roam-scan-improvements-v5-1-285ff0104188@axis.com>
References: <20251128-roam-scan-improvements-v5-0-285ff0104188@axis.com>
In-Reply-To: <20251128-roam-scan-improvements-v5-0-285ff0104188@axis.com>
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|PAXPR02MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: 905443bb-1a4a-4cfc-59ee-08de2e74fa4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjhCL0srcjVMM00rT0ZWZVM2MnUybS8rVFNBdm1pZXAxSmxHQUQyMWtPS01C?=
 =?utf-8?B?d2NHSEREYVczWkRudjc3VmdxTVpZWTBsSkF6NmdPQUVreFdjVGFOZ1l5ZkF0?=
 =?utf-8?B?ZnNCL05ueTNxQ2QzL1orMDQ4OXdBZEFETE92cU1QK0JCeDZiV3JCdENpNldE?=
 =?utf-8?B?dlVIalMxSDlGZ3M1clYveDNldWs2ODVMK0xvSXoxSEFoa090SkRqN2I4TG03?=
 =?utf-8?B?cjN2MURJMk9xYzFiTEFVZmdHaVA0c3Y2S1pxSmFvSzFIeGwwbDJtZHdTNGFX?=
 =?utf-8?B?aWhFdG1IVGV5SThwekVaOFZiMzU3U3FReEVwc0ZXVUdXSm4weFVzdE9zemta?=
 =?utf-8?B?N2FXMnlLMjJpV1JxTnJvbGRZb0xxcW9Bb1E1anYzbkc2c1N0eitLcTdwcm5Q?=
 =?utf-8?B?WWZtMUJXN2JLVTVZM3JicGVnbXJNN1oxUjFqaUFta1VuQy9JS0RIZGRlSm4r?=
 =?utf-8?B?ZXlheG8xbmhLY0tjYVN6QVNaYUlMVndxSzI1L0RVUm53SkRKd29XY3F2YW5s?=
 =?utf-8?B?QVBDY0hvd2dqQTI0REdXT0NKdEhHSkxhbW1XTFpnamhPOE1mS3BoZUY2VUMv?=
 =?utf-8?B?SldhS1NNOGdJdlRVOG8rem54Q1J3b0ZNcS9WcG5ycGRLTXFtTVZnZzVXajRW?=
 =?utf-8?B?M0FrNjloVnQ3d3Z0elgyeDJkUkpnTVgxVzgxamhwTktBRmFnb3JXS3YzTXpG?=
 =?utf-8?B?bjZpTG0yci9CR1dMaXZJK0hCSjRMWVF0YXh2WTJZQzlFUnB2RDcvang1ank3?=
 =?utf-8?B?NHRLcUVqYy9weERsSTBiL2ttWTlUL0FzTXF6TGkrYUo4UjVXNWQ0ejVmY0Zn?=
 =?utf-8?B?TXI4QnJIM0hMMURmdHFGSENXcmJXZWh6YlMxaVdTMS9BZ2pmVGQrRlNoUHQ4?=
 =?utf-8?B?TVlzczV5d29KRVJDdG1mZk1xV01KM2hmVlhmK0UvZ3IwbEpaMWo5dUVKSGtZ?=
 =?utf-8?B?SG4zeWRVUUVBbHVDcnc5QXdPWlJuTGhFTGg0dVZ3R1kzZ0RzT0s3RGU0MXVj?=
 =?utf-8?B?WTEvV0VPNDJsU0xMS1JmazlPSVViQjZoOC82R0RlV1JwMkhmeVRGTUxkbXhW?=
 =?utf-8?B?aS9QWGZydklpREtheWZPUStlRmxEY3pKY0xSQWh0Qys3TmdnUTFITlB2UkdZ?=
 =?utf-8?B?NVl2YkdFRzdxQmF0T0NWQm9RQWRBNXo4NnJVSTlJajdnUjI3a2NCQThMY3l1?=
 =?utf-8?B?WlFGOTNYZ2wvNDNpWE45OURFczNQbGR4R0FxaEtmOVZJeTMzZnJLQ3B0N3di?=
 =?utf-8?B?SnBFZnpva1hjK3VCc1Q4VE1QMXhMSHVRb3BYME9UOUZqTjJkZDRNTnJ3QStn?=
 =?utf-8?B?WEZBbW1HSTV6Nmo1MDFiZm1ZcXNvbFBacXdtR1FZRlRzeUxRZmJvSzEwTURl?=
 =?utf-8?B?SWpTOFpZTjBFenJUNzFBbWRUbHVQSDZBV1JKTHB0NU9wQVEzZHdjdEk3eEx0?=
 =?utf-8?B?VjdDazFuRVNqYWV1L0tXZHA1SHhWdW1RSndpaVdxVFBaeWVvQVNWeUViS2Zn?=
 =?utf-8?B?MnNCaWVJcGlaeElmNFVmdHNWU29VbFJDdVJkczZJMk1LOFZ1eVJvUm9kTEhL?=
 =?utf-8?B?b3dGVHREYlpQQXBXV25PNzRQZExYOFlWNFg0S3pyUkd0Zy96ZWh6eTlzbThx?=
 =?utf-8?B?c0MwQWZVRUYyUWhCR3l6MDZmR0ZpdStGR25rYlZ0VWx6cHRYLzd1cnhlUy9D?=
 =?utf-8?B?RE44dUsyUi9NbVhzV21zTG5MMURqVXRQVVpTRFdJamhJY2c3Y040TnQxVnRO?=
 =?utf-8?B?bnZ5UXdYNzJyY1BZN1VyMDI3ckJiRTNjOGh4TmZqdVJBTDlaS1hOUXE3bVQy?=
 =?utf-8?B?TG5kbnRmQndRZ2RVWFIxQnA4OE96dy93cFdVZndSSWdNYlN1VWk4QkdrWVRI?=
 =?utf-8?B?N01XUkhjUlRKOHYzZStucmJiU3VUODlrWlVmdjA4SnJEU1cway9XVE5NQVky?=
 =?utf-8?B?UXlKTEpHOHUrTzZjMnRGRU5MQ09saE1HNlJ5VzIrVUR3NzRNbk50SkttOUlH?=
 =?utf-8?B?QytvSVNnRkMvY0NTQitVbHZva0VWVkRGY2xrTkpjeng0YWNLSk1tbVpqYkQ2?=
 =?utf-8?B?MmpBRkhwVjN0RjIvL1NqM3NVYWxMN2w1TklIYnQ2YkxXenNUcUpqbWNLeWtC?=
 =?utf-8?Q?LnYI=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 11:55:08.2887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 905443bb-1a4a-4cfc-59ee-08de2e74fa4a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7863

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

