Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011042.outbound.protection.outlook.com [40.107.130.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E166032571A
	for <iwd@lists.linux.dev>; Fri, 28 Nov 2025 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330915; cv=fail; b=bx/inBa6WHDauRs6pYlDa9TafGcV7EXPZGu8PU5JHD2YuXGqu5S5BxSxvrujxaOlz3G8rO98V06g1+V9qh7ZXH9P2boYtpf6Zas/7uFACeuvL4ldTxNjHreQSQQ0Z3kD8E+DdUINFi88K6K1+HtHuCsxGNYe+O0pyx4N9+FbS9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330915; c=relaxed/simple;
	bh=r22+yjSXkLvwvQbf8lVZAcKq7gXXec5akTissC2cyeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=HWibSkEj6zJG1DYVrE3J2GsZOYSzMpftL/dQVuJOWC5BKGyKNOZKBKYM8xtzJ7O0duvWyjZ6xYBzz4uRzoQwQAndIiqDGU1+F5sVraC764NGZv3Xd9K1iU4sZHpKA7M1SUNIBB0S0DrnmFhsdyKzU/tVJm/6YlP9zVOzSH4Xzbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=cfQcjQOF; arc=fail smtp.client-ip=40.107.130.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="cfQcjQOF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJGhPr2KKK/pKWiBG74iQc7bgnXbdz/S8CLvPAVi5PsHosXtJa1XkmTBMkd5OtS5P47AIkptyQGTXBrAdRntdyFGlZ6u3l/N2wmsTthc3lDKsdNiRkE33FBaWto8oyItp0h6Xm84zFuzKpxs7N31j3+tR0oLodJrKlBQRfbKixm997JlWusvF+GhP8Tgd3IpdA7GIptsywInZ8sxIr4wjqzhN3grk2IkWMi7RCHQNNZeLZ6x+vQp2ceLyBF0o6F2fC/+yYCyRe2peXkcnO5MVVUXVgv4y1G4569J4uKBYR7nRsBskrB1hZkrhcR0FUUlGQyVp+tTvmxRcIrmD9qh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkF52UJYRd3BeSurzMiEorXV4FlOrlF3jBNyYEnMYug=;
 b=Tb41dcCyL08LYo0vDG1a1/hiSp1QqVmBuqmw7wZ0dtO7AoVryKt12k1tMIWMTc6ICcx+GvlAFK+mEsgLcGPdch8RjzhHT/8BkyzCTCxt7z+QyFE/K7TVvz/kkzs4evb5lZq5DN9oBmgf2TsBPR8pwK2ER2BGe9cbaRsoGJI+SOusb+JXdYK++CyQyMwEXesndQbQ9XqiFYD+CpdQLgvpIDd1yNFOF57n2UQ+E/yyOJcai+pvUA6lr1p822ESZzORHnljDFFtz04xzmD+Br/c0Ju3xZNnDR8wxItZ/r21rwP6qLY7iXbZaiIkNz/TPRRXxP0AFfEoZ9J2E0XcqWY6lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkF52UJYRd3BeSurzMiEorXV4FlOrlF3jBNyYEnMYug=;
 b=cfQcjQOFYN2yKghl122aOgtA8P3GDebR9jk+FFdWCu/PODRkJRMimGPM2YRIHD8EQ9FyB5OqGPuyFMrfD0dyw8ebAeLH9kN0r6oEUqzUhVWi4bntNAxorlNcPUhgDc+TlSKO+5JlRdqggxMMYm4BDeEWbKPJlsuegrij6FFMqDw=
Received: from DB3PR08CA0001.eurprd08.prod.outlook.com (2603:10a6:8::14) by
 VI0PR02MB10948.eurprd02.prod.outlook.com (2603:10a6:800:265::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 11:55:08 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:8:0:cafe::b2) by DB3PR08CA0001.outlook.office365.com
 (2603:10a6:8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.14 via Frontend Transport; Fri,
 28 Nov 2025 11:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 11:55:07 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 28 Nov
 2025 12:55:07 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 28 Nov 2025 12:55:07 +0100
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 7B84B9EF
	for <iwd@lists.linux.dev>; Fri, 28 Nov 2025 12:55:07 +0100 (CET)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 7AF052865168; Fri, 28 Nov 2025 12:55:07 +0100 (CET)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Date: Fri, 28 Nov 2025 12:54:29 +0100
Subject: [PATCH v5 8/8] auto-t: Disable MAC randomization for a few tests
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251128-roam-scan-improvements-v5-8-285ff0104188@axis.com>
References: <20251128-roam-scan-improvements-v5-0-285ff0104188@axis.com>
In-Reply-To: <20251128-roam-scan-improvements-v5-0-285ff0104188@axis.com>
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|VI0PR02MB10948:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ab1fbb-4c79-4430-f197-08de2e74fa19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WktOMmFkNjkwQ3BJWmU3OWpKc1BpZ1JjQVZ4S2Q3U0Q3ZDV3N2hqL2puUzNS?=
 =?utf-8?B?TlZZelRJZWtpMFlBZ0VTV1M0Y2s5NFE4THFmdTFCSWFFVVVlV2F5UmFzT3BM?=
 =?utf-8?B?dmYzMUpVZjdzcFhtM1c2R2MwTmtJc1BVeEpYN3pRNkpVdHZRd2FlVnpDZ3Nv?=
 =?utf-8?B?NUt6Zkg1czJmVXdGa08vNEVNaDc2aktJNFFuSklDTTk3ZWRCdnlIbzRzZ0Ra?=
 =?utf-8?B?SG5FcHRJcVcvSVFtOHZNL2FxL1hYZ0F1VzVVRHducEhHS3d1clpBRHFCeFlR?=
 =?utf-8?B?NldVMTJla2Z4ekJaeDZ1U0hJcXY0ZjlKQllGSTkwcHNYempBMlozQVZnVDRF?=
 =?utf-8?B?TEY4aklScHNKYVlHMnlmN0VUZUxVTm5VbnlBbUZ3QWlzVlNoRVBtNnVkTHhj?=
 =?utf-8?B?dkQrcTVzY2Nja2xNVVNSMHd0WFQ2WHVVMUVzd3F3QWRWZkx2UE50ZUdHa1hl?=
 =?utf-8?B?YkI1YU1pTXhMekgxSFIrRzU0YWI2VHgzendiNDRKSHljdTVIa0gzMlVrejdK?=
 =?utf-8?B?RDVnVHB1dWEvdURDK3N1VU1pNGViYkJFTjJUQkY4MmREMXFPS1g4ZDB6cnNx?=
 =?utf-8?B?NjFaTFNSK1dQVWtjdnZPRGoyUlRXN3ZjNldjeXplVkh4VmZXaGh2SGNKQ2da?=
 =?utf-8?B?ODdWQ2tGekNncDVMeFA3bHdBbUY2UFgxOTl1d2NHeWJOaHBNckRrS3h0bGlq?=
 =?utf-8?B?Zmx5UlBKSC8wdFJ4TncrcDY0bVRFZzVMRE9LT0lMM3FuaXRFK1gwdDJRbDBq?=
 =?utf-8?B?aWFEdlBCWFpqWSt2d3pqTGNlRU9QRG1TMFNOTDYxSUk1SjlzZjhHQVVlUVc1?=
 =?utf-8?B?VXVjODY4L1E1OGs1dWJVaGIwcEZxaUV3T3dUeVVsL2NiQzVwM3JPS3MySGll?=
 =?utf-8?B?SHIwaUYyN28wYnBxL2twZEdkcWhCajBXSFhjanoyeXlqYmZyWGZxZGdVengy?=
 =?utf-8?B?OVRQUVV1aXBPeE5sOGEyOUZiZWE5bUxKZFAvQk9rYTFsek8wSkQwSkxxL21t?=
 =?utf-8?B?YkR1enBlRzhqeG1VS0ZpS0lSUzdEK2lLZnZkbnozdkpXY1pHbkpEbjFHOXhr?=
 =?utf-8?B?VytvbVRpcHlPd1NwR3BaYUwrWUVUQWZqSXh5RHMxbVlpUHV0VTN0NjluM2RK?=
 =?utf-8?B?RXFHazUyN2tZUHNpMmRIcmI5cHRjV1VlSTA2cmtFRUFsZU5uRENUUFdTT1Fz?=
 =?utf-8?B?WWFGekJ6b3FxMUlQZDZOQkR3Ty9YRXZoaGhNL290UUFrYlJudzhscTVlUHhp?=
 =?utf-8?B?b3Zsdit4bzRiK3BHSmdYOW00MTM5RFc5R1ZEODJLM0lKZzJUSW9tbCtsbEpn?=
 =?utf-8?B?c1VWOUJoZ1JPdFZDcnprVzJJVUpqU1FvZTUyK2Z4UjdmUUJPenY4bU9maWRs?=
 =?utf-8?B?amcvbVNpSkZiVlJWR3RqZjdORjNIUXdTYWhMaHNPcENxa0F1SUEvNTNTcWlu?=
 =?utf-8?B?OHdTVDg0L1hpOVE1TDZRRGJzM3JnYVlmeFF0b2h2Z3dzZ0NEUUd2dm4vNm1S?=
 =?utf-8?B?akRNc3ZYYjlpdGtJOU4rYkpjaUZTK1MwMDViSWxIVjVwdERjc2tNZXR1eHZK?=
 =?utf-8?B?aVh4ajdUWjcwT1NsdE9jNytjQkYwdHcyVXdmWUhveFVwakYyUCtiMFhDZmIx?=
 =?utf-8?B?cXlDTzQ0ZmROd3VJZEc2eFZWSzk4d0tPT3BJWjQ4U2ltYWo0WG5iK2ttOGVY?=
 =?utf-8?B?Ump2ZnhFVEZ3dGdNeWpJRUM4ZkRwclVkWmtwOVBQY0h4bkFRbFBXZU1MWmFq?=
 =?utf-8?B?MUhvRzJSUmFlWmVuNk12WWh2cmhqSFJRR0NaOUVHMlBHS0tGbkFlMTVwS1VN?=
 =?utf-8?B?NTB3Mlc5N0I1YmpLdmMwOUZjdG9qbkx5dzBuS25BVExGWXBvbCtJK09qQlVE?=
 =?utf-8?B?MmN4bnRvcHJlR1pxTUpJdmJYS2I3ZmFINmcwUktURUx5eWV1bDFoMFFSODg3?=
 =?utf-8?B?UkZtS1A2NnN1VmFqVHVpaFkybWdrRlUxY1BxMUdpRkF6VjNWK3o3THIrRVBI?=
 =?utf-8?B?emZOZ0l5UDBwNWVjWTZhWThTVGJ4OXBnOXJ4MkZhY3JRM0x2cjQrd016c0dZ?=
 =?utf-8?B?UUliUDk4M0NXcnZlVENCazNzeUNVRlBoNDlBaU12RjJnaEtoaE5PMW1YWW9z?=
 =?utf-8?Q?bQ94=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 11:55:07.9767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ab1fbb-4c79-4430-f197-08de2e74fa19
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10948

The scan subsets now contains both 2.4GHz and 5GHz channels, this seems
to cause an issue when MAC randomization is used together with the
simulated hardware.

The AP(s) in these tests operate on 2.4GHz. From the logs it's clear
that the station's probe request to the 2.4GHz AP does arrive, and the
AP responds, but the station never processes the response. If the AP is
changed to 5GHz then everything works fine. I believe this is because
2.4GHz is scanned first, then there's a MAC change, then 5GHz is
scanned. For some reason, this causes the simulated hardware to miss the
response from the first scan, possibly because the MAC address doesn't
match.
---
 autotests/testAP-no-support/main.conf   | 2 ++
 autotests/testBasicServiceSet/main.conf | 2 ++
 autotests/testDPP/main.conf             | 2 ++
 autotests/testDisconnectByAP/main.conf  | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/autotests/testAP-no-support/main.conf b/autotests/testAP-no-support/main.conf
new file mode 100644
index 00000000..9452fb6b
--- /dev/null
+++ b/autotests/testAP-no-support/main.conf
@@ -0,0 +1,2 @@
+[Scan]
+DisableMacAddressRandomization=true
diff --git a/autotests/testBasicServiceSet/main.conf b/autotests/testBasicServiceSet/main.conf
new file mode 100644
index 00000000..9452fb6b
--- /dev/null
+++ b/autotests/testBasicServiceSet/main.conf
@@ -0,0 +1,2 @@
+[Scan]
+DisableMacAddressRandomization=true
diff --git a/autotests/testDPP/main.conf b/autotests/testDPP/main.conf
new file mode 100644
index 00000000..9452fb6b
--- /dev/null
+++ b/autotests/testDPP/main.conf
@@ -0,0 +1,2 @@
+[Scan]
+DisableMacAddressRandomization=true
diff --git a/autotests/testDisconnectByAP/main.conf b/autotests/testDisconnectByAP/main.conf
new file mode 100644
index 00000000..9452fb6b
--- /dev/null
+++ b/autotests/testDisconnectByAP/main.conf
@@ -0,0 +1,2 @@
+[Scan]
+DisableMacAddressRandomization=true

-- 
2.39.5

