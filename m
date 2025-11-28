Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011043.outbound.protection.outlook.com [40.107.130.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB19D325727
	for <iwd@lists.linux.dev>; Fri, 28 Nov 2025 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330916; cv=fail; b=l+PWBp9l813f66A35XxsRd8hbGY9SG9IhzX4Cxera6PPsxo6ezw1U/pA254cDLukb5iMJ09YswModQOojPEeOXe4ipuU0S8kis59pMYHOYTjzsbili3FO1aDrZNlRrcIAIunehzRM7HAaFOsyNZSQf6kiJg0LD4jxFq1Irww1yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330916; c=relaxed/simple;
	bh=V11XKkFqtlK6n1ugDKAiccldcPlfhrAZ2BGn5tqxE7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=u08/A0iWvI2qtW7OKFY1TjygMsZOkPw5LfD5lYBaJ17dzg+FO5L0pCEKORbTgBpsweoczPEExqOLwlVL3KdZVa3+N2I0O4kQxZoGpfRK9q3U2KDJm8mRQ4pkzXcAb0tYKSSUvU+MBX7suZicQ5jR3j/3n72TDeVlOd7VBsqzRP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=gYLwB7Ci; arc=fail smtp.client-ip=40.107.130.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="gYLwB7Ci"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hg3Ek4jPfyi5y18o/bk9uE35d0H3V8UMXRW1i8ZMnUdeqzs0ZrXrs7rx9L+Df8Fye5xiDI523VDD3Np52Twsd8+RB8iQusVpCWRD0VmIQXqBgrJU816T/coCVcqt4uowwcrQ4jv9WKy5R4R1X8ufEte95KptOlmUvt+YSDBSzoeZ6m5mZ3IxnN45Sa8CG1bu98itRPqWQZk2RQt0UgEJMy5pAn+YPZM7SB/jCSdL3snu3ZORf9Kzjj7DtJBkQ8IpcegBDNpzSMXabpUqB/uJtzGdrQGwyHcogTvqGu5BXxZ0w8kXQ2LfMIyaRzZ8lq1CEDfXU2Wtk2dvjYSYlWfatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeBKO/xeMtcMFCBNHE7Efpv7EoZjCtsK+wh5NURsqIs=;
 b=TPOx0M1/scyg89KyqqrPrxsvqXqYypgATiRqR7jKzrww0CjuMpKsWUR3q2yVyXQjj/ymnClIy6/6lwU+FfsA2nqNY4XCEXZ52UmpXjYlPuwuK23ebfFukq9D1fqlL1XMsg+uZri/ptEsHxeGca3sWPPth/C9V80VMyScdZNcWF+GDM19Xeo2fXQJ/CwraDOIpCLaCBXk/3ZQc95G/sN2Hdwk/dQFRPoBl5J8L3J6eht2VuXCaFS16fk56lSU9r0Or7xnr5q0YkFW+WDPOwbKCzoIYOKmYyL0xlWj3N7Kh4S3P9zDdpOTWx0PxX6KCOOxvUrXk5129zOr37nHTOCQSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeBKO/xeMtcMFCBNHE7Efpv7EoZjCtsK+wh5NURsqIs=;
 b=gYLwB7Ci1SugEug/khjZmLc4xEUeHOFMVD4uHh1jTi+GyFRj0Jezh6wHsBSmj6QVjNbGphOQvkRP5j9XKfGWZfr94cZkFoHt/PXUHYUWhRM6WiUGfpmZrE62x9x+DLFqpiykYOkqk/lixV6KAvSUwMipERczgL6UGZF53L0KdwI=
Received: from DUZPR01CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::10) by VI0PR02MB11691.eurprd02.prod.outlook.com
 (2603:10a6:800:325::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 11:55:10 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::8) by DUZPR01CA0019.outlook.office365.com
 (2603:10a6:10:46b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Fri,
 28 Nov 2025 11:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 11:55:09 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 28 Nov
 2025 12:55:07 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 28 Nov 2025 12:55:07 +0100
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 79FC6927
	for <iwd@lists.linux.dev>; Fri, 28 Nov 2025 12:55:07 +0100 (CET)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 7745E2865169; Fri, 28 Nov 2025 12:55:07 +0100 (CET)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Date: Fri, 28 Nov 2025 12:54:27 +0100
Subject: [PATCH v5 6/8] auto-t: Call default instead of reload in teardown
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251128-roam-scan-improvements-v5-6-285ff0104188@axis.com>
References: <20251128-roam-scan-improvements-v5-0-285ff0104188@axis.com>
In-Reply-To: <20251128-roam-scan-improvements-v5-0-285ff0104188@axis.com>
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|VI0PR02MB11691:EE_
X-MS-Office365-Filtering-Correlation-Id: e84e8e9c-0e21-4c7a-5354-08de2e74fb1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L09JekQ4MU1iZ2lFT3g2ckR2RnhuSEk4V0tIcklYaFJDZURVZ0JBYmJ5cmJD?=
 =?utf-8?B?THhjYmFqVlZUSVJPWnJIS1U2R3FJS3kzMjZwVk9qQkY2SkorUnczcGZRSFZD?=
 =?utf-8?B?ODJCNUpJcUtWRkthbjRGU3c5aXpFRDVSZ2VqNFMwMjdwZE9pK0Q5eDFXSWRH?=
 =?utf-8?B?MkxHUzQxWTU0RzlIcUc0eEF6MzNmZE9CUGltUS95NGw2R2RMd0lDNW0vQWVF?=
 =?utf-8?B?M0cvRTQ2aDAvY3hXTUhFQUhnVi95b3N1TEErV0hqdFB0Q0F6bkJveVI3WXd3?=
 =?utf-8?B?cVRQK2FKZWl4Z0ZVbzgzQml6M1M0K0JTSXhlUmwyekcxQ3RyY1pPZUVpbzFF?=
 =?utf-8?B?bXY2Y1dVd1F6djR5bTBMWGwxN045SFUzeUM0V2JJblI3dVhUZ0prWkUxYTBP?=
 =?utf-8?B?eG1jeksxU29rZXJxcjR1RGcwemJFWW5uNXE3RC9Bd0VVc2hyelpSUUh6LzJh?=
 =?utf-8?B?Zm12djZyUEFBSkpVNGhEanh3SU54ODZmRWVPRmZSTk52TGI1QzRQWHpZb1Ay?=
 =?utf-8?B?dXJRT1B2Szc3OTJxR2Ewemc4UThSQ1IydEpXR0RGcm1Fcml0Yk1XREZxMXpR?=
 =?utf-8?B?Zk9leGQ1VnFXZldDSjAzUkRocHRqQ3hnOGU0UWxlUXJ1eUdXWkdvK05jZ3R0?=
 =?utf-8?B?UjQraVEvZlc1MWMvTTlPUE9sWGw3U0hiYWhPOUFFZGM1elBWaG9sN1YvemxI?=
 =?utf-8?B?d0lOakJFRVNQclpWYjJHVnVTRTFmamFYWmVOUlVWMnFqeWtZU3p6VWIzMGRT?=
 =?utf-8?B?dmlzUFJOcWUxbXJ6Y0VROFErRW9takZQekhycVFtaU5DTjVVYkthbjIvdjVl?=
 =?utf-8?B?VFZ0Qk5UY3l3TnhFYkJjdUp0TkdTaEVNV0hVZzlYS2Nrai9xdjlsd29mVlRB?=
 =?utf-8?B?ZUk5TmYybHZ3Nm40RHRxZ2J0RXU1ZWdlVEtZZzZ5TU81bHl0UUpWb0p2bFBt?=
 =?utf-8?B?bnA4TFU4Y0Z0c2htdWdsUGdHd3JYY1hWVHlyUkxnM3NuL1V3ZEJIYmJ2cUV4?=
 =?utf-8?B?Vmw4aHI2eCtiRUQydldQUkVPaVpFdkEwMktJTkpIaG40cTJLOWJjNFpCbVdY?=
 =?utf-8?B?S0RmVlNCTzlua2JxL2VUYnpUdzUzS2lzRkpJbjJqNnFiZjFBSlFOcVBMblBM?=
 =?utf-8?B?S3JpWENDc291WCtUMTBETWJ5bDUxVExrVHk1eHhDaFpialFuM1BOTmN1cVlX?=
 =?utf-8?B?VjJtcThDWEFlVGFFRXZnT0lCNDE1cVN6enlMZXJKSW11ZmJjQk1jZzNPQmxl?=
 =?utf-8?B?aUd2bXNZS2JRMHBFRENPOWxtTGJFZCtVbHI2c1AyQjZFNHdRSE9CSE9qeVVX?=
 =?utf-8?B?VTVVK29yQ3Zjd1lpcmp1UWlhbGR5dExHNGYvRVY2akYwZFBsYzhwVExlZ1E5?=
 =?utf-8?B?SVV1ckpUWU1oTkgrTW41OXkvV0RtRUJYWHo4eWFXcnNkOG1tczJVcXMrWU0r?=
 =?utf-8?B?NWFldjU1M3lzZkZQaU0yZ3prdHdieHljUFFaS2NmelNYNDdvQ0NWUjEvcDg1?=
 =?utf-8?B?V3lxQzRFdHJ3QVVva2tha214N1ViUmdIUk9DMDFLSXE0SDQ3cHdNUW4wR2Ew?=
 =?utf-8?B?Qms3U2lJNDloZEJwUjlRSGVSKzhvMU9JYUd4OFNrQkZGckZza0R2Vzd2RXVU?=
 =?utf-8?B?ek9ESGxVRGdHOHRsMjV2eUFoK21KLzAwRjZHR2dOYnkzODN0TW9OZGJJM0lB?=
 =?utf-8?B?d1pkOU5kRTZCVmh3dVZ3M2swTmZ2bFRKS1MvMnBGbFV1eERQSisxektGc1F4?=
 =?utf-8?B?dm5qMHV2Q0pZK1hyUFlkTjNPM1JSK01BTzg2Vy91c1ROWjJZVmZzU01VOHJK?=
 =?utf-8?B?THFQSmUvblVDbzVCUFh1NldrZC9jREZCUSsxTWRsbkVmcEcvc2lVTzJiWjYw?=
 =?utf-8?B?aWVsZWViZ0QvU0Fua1hLREd2YkhJOUl3V3haZU9XV2ptNFg3RDgyVkI1UTU3?=
 =?utf-8?B?QisrTTMzTFVwM0NGUk9CaC9KUFRWdTk2ektkYnYyVWdsNGNRV05sRDRHakVM?=
 =?utf-8?B?aVJoT0FtSzhYN2l1MzNtOU1LUFlYY1lWM010d1VCUklkS1VvNGdJRlVYZlRU?=
 =?utf-8?B?ZkhIaVlyUkxvS0Z3TndnMitZd0dBOGFZMnlrVGdyMndIYlJzMWxOc3pjcmJi?=
 =?utf-8?Q?QJvw=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 11:55:09.6508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e84e8e9c-0e21-4c7a-5354-08de2e74fb1a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB11691

This solves an issue where test_ignore_candidate_list_quirk() uses
set_value() to set a vendor element telling the station that the
candidate list should be ignored, and that config was never cleared in
teardown. This resulted in subsequent tests ignoring the candidate list
and doing a normal scan. This caused them to connect to a BSS other than
the one in the candidate list, causing the tests to fail.

When calling default(), it first resets all configs to default, then
calls reload(). So we still get the reload() call as before, with the
added benefit of also clearing the configs. This makes the tests pass.
---
 autotests/testAPRoam/bad_neighbor_report_test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/testAPRoam/bad_neighbor_report_test.py b/autotests/testAPRoam/bad_neighbor_report_test.py
index e361d37d..c8e4e45a 100644
--- a/autotests/testAPRoam/bad_neighbor_report_test.py
+++ b/autotests/testAPRoam/bad_neighbor_report_test.py
@@ -136,7 +136,7 @@ class Test(unittest.TestCase):
         self.device = None
 
         for hapd in self.bss_hostapd:
-            hapd.reload()
+            hapd.default()
 
     @classmethod
     def setUpClass(cls):

-- 
2.39.5

