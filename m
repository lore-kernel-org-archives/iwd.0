Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013065.outbound.protection.outlook.com [40.107.162.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA96202F8B
	for <iwd@lists.linux.dev>; Fri, 29 Aug 2025 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453511; cv=fail; b=DVq7Xuh/Ger/ccaL42U5NG/RsKSQDUYVqGTxwiCk0U6COMmi4v5hLykq+WpmD9fz7S6zLclv8O6SP10oYEYdCqRnQ2IplE2edfRafO89uo7EVRAcbPhBDVkpvXaBhggA7EUPnOdByFa6fpNt7rG2B6axh9lqbB6cw9wiP93u7pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453511; c=relaxed/simple;
	bh=tZHDIKZ8dBswzE3feIhqz3Biv5WMPM91AsVS/ZznoGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=oPQI8jHXxq3WYuxvurd+EnQ8UwhsvfQcFV+hk6rS0ziBc7HxVP0Gr1IDlamowIvDM0JXt+SMwkodGQGFDDXuEjgGLs+6wHxFgiD5DiqxA48GhvQMwrxxA652bRgYRZZog8ZmXPhwvlhXU7iDidOwYeive7aXcfr2hGYvjMfCFmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=lGp7Bu5X; arc=fail smtp.client-ip=40.107.162.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="lGp7Bu5X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOmiMYtpacIs1tbbc80Wx8/Tvo+uVzUaZJVgwt24vtRfkD3K3NG6TxlN3bpbAu7MiMSHamKwX1FgU1jA+zd5PrgsYvvl4w7230JF3oPMTphegHtTMKueFC3S+zyxGzNlJkBS+QF3jDPRwUsyEJSs02tCIu0oiHnAsnfr3jlyBySZ3MTk5ATNVDwAsSwUK8FH/gWhQv/Y0v/We+1Oo1BF88nR5a9f+HPG7t+/tVHptovfAQeDEOWYU2yAGeqd2Px7LgG0LK+pW5WYfysk5GiIpxxkWapOv28a6LuKjDd35HIB8AxBKpX68JVsHpA4IO8q3ZyROlxNdQeCCzdZEtjmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKyLy4zoTtf+Jo231GojnKXDq9+Joyw+AIo7wQT+TK8=;
 b=fR7rQk23OhtVfBvuEEH9xEq9OJ5yBFCY+6N09pof1UQikaKC349Uf5mYj0gekeFYMhappBpkvP0EaZ6zAQjZx0jke6iaXaIchTsWvhpJaYNjI8aY+jTu1L0ApZVoGqOo8Qzo+BSU8iH4w1AR3zm0fuF6CGUTXy+6RUygjUuBaCr9ceF7UU7deKhLQc8cgtMFBVmOcxHU4Nbufp48NWSY2k76vy5cogZZtGmNNxo4DGRvb2zKGS73jdSGPKwxb51+DNchhRfcHxGULez14zpaAjLTfqRt6F+WKDcbZagdzaikfbdWHb9cJRAY1gursCKYC5LlsK0oNIsqEp/E69HLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKyLy4zoTtf+Jo231GojnKXDq9+Joyw+AIo7wQT+TK8=;
 b=lGp7Bu5XJkCU1V44YR6V9D69A2+ZCfR7qLmkBchkTjrF2RxCLau+0UE6rri3dcG5Bsp7TAPtDR2qJx4y74YE/Bt7sXkfN/OdCrVD8AtNWKPvWf+fe979cPlaSvHxvDBmOOpaR1utq+SjHptosxhc5d+09eLaWJr64Y6XRxV8gR0=
Received: from DUZPR01CA0197.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::11) by AS2PR02MB10124.eurprd02.prod.outlook.com
 (2603:10a6:20b:64b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Fri, 29 Aug
 2025 07:45:05 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:10:4b6:cafe::5) by DUZPR01CA0197.outlook.office365.com
 (2603:10a6:10:4b6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.19 via Frontend Transport; Fri,
 29 Aug 2025 07:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 07:45:04 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Fri, 29 Aug
 2025 09:45:04 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 29 Aug 2025 09:45:04 +0200
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 9D2AA733
	for <iwd@lists.linux.dev>; Fri, 29 Aug 2025 09:45:04 +0200 (CEST)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 97FC4287FEDC; Fri, 29 Aug 2025 09:45:04 +0200 (CEST)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Date: Fri, 29 Aug 2025 09:43:39 +0200
Subject: [PATCH v2 1/3] util: add scan_freq_set_size function
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250829-roam-scan-improvements-v2-1-888c6bbdd310@axis.com>
References: <20250829-roam-scan-improvements-v2-0-888c6bbdd310@axis.com>
In-Reply-To: <20250829-roam-scan-improvements-v2-0-888c6bbdd310@axis.com>
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF00008860:EE_|AS2PR02MB10124:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b3379a-d38c-4773-7435-08dde6cff7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0htSlIzMnorUWZxd2lqMGhmamE1Y0wxazltdjR3RXl2RzhvMFFFZVZwWkhZ?=
 =?utf-8?B?OHFRODZrVDgwWXNLZVdYdHUxU2dkZmZjaWFwMHdjMko4QlB3SFBEOXRGaG5z?=
 =?utf-8?B?TTkycjJUUGRyUHFKQ0trb3FzN3N4ZHY4enFmSzNQcVVRS1I1KzdkVFhONmdu?=
 =?utf-8?B?ekRsLytUNU5PaDBYbmVwSjhVRXdXRzUyeDNMTVlDb05yaVdHNDEya2xYb1Ri?=
 =?utf-8?B?dHNyL0FZd1hzT3B0QUU2U3VvV1g1bnp0SXNpNTAyUXNWd3VJdFBFQmJueFUx?=
 =?utf-8?B?SXhZNGxhMG5PTmNFT254VGNOd1VEUE8zUVNzU3VKaklHMmNoS0ZBSnRDU1M4?=
 =?utf-8?B?cXRqQnpqRmhkTFZ6ZXRWTDVmdWp5S002Q1pkaExCM2hYQ0ZqV2VVQXp0TWlR?=
 =?utf-8?B?TVlUajErYldMejZncUdtR0NTb0RYRXlWdlZQYUhucXNuR05WVTE1UkprS3pK?=
 =?utf-8?B?d3czanR3K0luQkVnSTVVd3ZmKytBQ1gwYzErOGlZQWovVjBUMTVTOVhEWXls?=
 =?utf-8?B?UjRHbGI2YXVTNjJEQnVvSk45TU1LMDFVTGovdVhwU05oT3JOMmFCMSt2TVNr?=
 =?utf-8?B?QjhKbXYrMnBlVWszVFlTa3E2TTZLY3dVRjdRZ24rYmVxSGp3ckNEdTZQMy9U?=
 =?utf-8?B?T0tvcXdpek1LejBYbkFidEJmVk9JaytTbE81UHIvS05aOXJvMm00amd3UFhP?=
 =?utf-8?B?b1NERkxIczNBR3lPcGlZR3htc1M0dUloOTliN2lZbDN1bE40QXpsMkNLcThK?=
 =?utf-8?B?TVd2SDFzcVQveGVwKzY0ZURqRTVheUVHb3ZqSkVOdVpsbG9sNnRMVytEdFVZ?=
 =?utf-8?B?Sm9kZ040ZldHMnYyNGtEbmN6N2NodTl3Wmt6eGZaWE5RbDJWQW1wR2J4bFNM?=
 =?utf-8?B?bFFOY3FSUWJPNW50cExhK2ZDc21ydjVFUVBXeUlvV0c4YVlxZ3Q1T01DWTcr?=
 =?utf-8?B?dmpxQTV3RDJSRkFGQUtNWTZtQVNCWDNiRXg2TG9WM0JNQ05Kai9ocWRzbXll?=
 =?utf-8?B?ZzBkVVFQQWUyNEFYM0kvTWNXR1pRc01qeWljRTl0UzJrZUtKNm1PVkE4ZUMy?=
 =?utf-8?B?dStTV2RGV25zVm5ZT3hwNjFUM3pRMFN0eWZCS0VSYU5KaDUxU3JncFhMT0tU?=
 =?utf-8?B?QmJzOVB1MUVnVE92NW1Ga1NrZmJWV2lpeFVVQ3RnV1hmVWlsRjR1RUQ0WEht?=
 =?utf-8?B?OU1IMEZkMTZVWkp0Q282NFZnOFFEaGNxZndrbjdMQzhaOGQxc2Q3bmVkcjcx?=
 =?utf-8?B?dTFSQTk0L0lkUCtORE1KYm90d0Yyb3V2Wm9zeGJvSWN5ZWVObE5hQm1rUC9u?=
 =?utf-8?B?cHkzM0JkNUpsazJjUHB2eUdIc3g1eEhocXV6RHpVUFNxSHVUNS9jNi9mbER1?=
 =?utf-8?B?bXprUHpGU0pvTjRvbkFXSE5STU9vWkFPQkhJQUU1amt6Q0hiTHhiVDB5K3Y0?=
 =?utf-8?B?SVJMVTFnZmNvbW4xMkdQSFRFWlo4dlFBb0drQkdXWjNtamVybEQvcTkxdXRR?=
 =?utf-8?B?MXpxaFJZcWs5aGE5dkhsQTYzYVBFSzYwQ0wrSGUrZ1o3T0pwMFhCcWZ0cGkr?=
 =?utf-8?B?SlhBa1ZHdnNITEsrUUUzcGFNT3BoSkZ2ZXdMVE15TFB1cE1TSlJDcVo5R2ho?=
 =?utf-8?B?a3VPakp2Mnl5UUU3RitTV0RZL1VhV3R1YUVrVzM3OEJrM05JL0F1WnNjdFZj?=
 =?utf-8?B?WGUrN0YxazlHR05WQmxneG11NjNRRHNOMDFvbkg5RXNSbzM3clJrUExMRkQr?=
 =?utf-8?B?ZERHQlNqV1lBdU5rU0NFcXBYMDBPWnRGOTlUalFtbElOVG1vcW92aW5CQnNw?=
 =?utf-8?B?ekFLWkZYYmsyaTNlT0k1QVNKRlRkclh2ZVJtLzBlUE9iOEMxUjJWckN1VFlH?=
 =?utf-8?B?NU0rVUwwalpkSUNlKzFvL0ZMekdCSXcvSmhOQUJleGc3bk1KcytWSDY2Tjk0?=
 =?utf-8?B?ei9FNW9XSTNKYk5NRUE2R0pIZG5YTTIzTGpVTGN2M3BjWFRkbXBOL3VCYkZ0?=
 =?utf-8?B?NGxWQTVqVEFmMlVWMHlhWkdQcnVlMFFxbVc2VEZKbTYvTjFmZmNwUGxVZ0JE?=
 =?utf-8?Q?ZRUgiX?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:45:04.9181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b3379a-d38c-4773-7435-08dde6cff7fe
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB10124

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

