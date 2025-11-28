Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14B631ED8C
	for <iwd@lists.linux.dev>; Fri, 28 Nov 2025 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330915; cv=fail; b=dGg6HgsO23Jcgf6KiTLP079ruTu3YNCllPThkM1PxovDJ1bZ7hOYRF0lSAddAVMPM5AAASPdRIXn9gNR6uMrgLRTsDcboG/ixbnaBLT1E4uzUfqcT1yDbCpbT6+cJzwxKjeV/M1YRTDIR7PbvDch3hXr2Mf+OeX0qfquWcP0qDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330915; c=relaxed/simple;
	bh=FggNZojjTsYtsIjLCzSWIZfPCFLKMXwtlxuEfPWMEVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=MNIRzFpUR6+QHmOu4uoGTlG5Ou2YWijfquPVZ66W1qr9tvEfqCtozt+7OcAOIjUisDsPhNyWlbz0QrxFnaCupL2sqobvBZxyt9dPhwK0G6guZYE/x4+b1IL8QFRAht99/7kfP6rmFbog6SbLUeqtqjrVvfZMMIuLelQuAEvkCA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=OriniFNC; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="OriniFNC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XefS+hKQ3VV0Bu77vq/YVqzacXPBA2WlQxGJ2e+duEacNTSY1sJZ0O7qZh7XOrqcnhiz2VB0i6pAT7Vo3ISii7waDZDuVOGS6w1EcAE8SuH8UQVMuWYxhVEOBTH5KTB0X1QDxE9H+KKq66xsBeveoU053RqlPjIuOblJVVyT5IauyUc+2I+nxi8+CBJAp1OC0dk2KP2YEOCa42LQaOsgDEN2IxmBxNI3/fGqXaApQJtCb/vb7Mh+GMVJmodAr3qgmcXtrlMhCX7LdQ8iEhss3xGdQV1HIvUgiKTcdXpnMHCZpZ+LPLB/q6gZGo39q3lXzTker1obhaLVnMcL/cjTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWokcGC0/5HrAwTf80ddLQxom3l4vSJDxxPcNICiCTs=;
 b=yUwRGnkoWCvivixYqSDaK9MmVLVZoGpzPwbbjqDOosbh7vT35ISGvBWqR3iDdHOoq2k/ocwa/mcK1jW5LQsHG7BMMZVaLQVnXJJ+FNGHhaquhcsPieitBtjtD61pS04ibLGRA2ffvCKZOH8AcBDvOZtLyq9joiiRyY0kMOCF4Wk8BakTLtH++BCXnLqRjdmxU4ZY8FzT2ZQ//NpRa5xrthQ0mkYQxFZJuZ/UL82iVjLZqCsAXL5TxWLbz512JmgnOg/k9JMdQHGoyyUE1Rl/8GNXbOxPuGTXhBKyDxY6Nnd9fgZlFOVAe/bMIjz43tQBfbAmASMVUo7QLfmTNXirGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWokcGC0/5HrAwTf80ddLQxom3l4vSJDxxPcNICiCTs=;
 b=OriniFNCwr4+wgja8gbO0Yt4wfrRC8UNjEbra42Y2l267Pkj8IOsdmlo6Al/rScBP0ogYh9GEzgE9HECHNAcnhfLR/eQLZ6dhR9RykEa76HXH/1Q1U3ZsrZ19AQ9AiUGu7lss4wujsqxGKbm17Z5S/LNyfmr0dHmt8kz4Fg/0/Q=
Received: from DB3PR08CA0034.eurprd08.prod.outlook.com (2603:10a6:8::47) by
 PA6PR02MB10457.eurprd02.prod.outlook.com (2603:10a6:102:3ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Fri, 28 Nov
 2025 11:55:09 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:8:0:cafe::df) by DB3PR08CA0034.outlook.office365.com
 (2603:10a6:8::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.13 via Frontend Transport; Fri,
 28 Nov 2025 11:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 11:55:09 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 28 Nov
 2025 12:55:07 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 28 Nov
 2025 12:55:07 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 28 Nov 2025 12:55:07 +0100
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 766AE903
	for <iwd@lists.linux.dev>; Fri, 28 Nov 2025 12:55:07 +0100 (CET)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 735C2286516C; Fri, 28 Nov 2025 12:55:07 +0100 (CET)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Date: Fri, 28 Nov 2025 12:54:25 +0100
Subject: [PATCH v5 4/8] auto-t: Increase event timeout for test_full_scan
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251128-roam-scan-improvements-v5-4-285ff0104188@axis.com>
References: <20251128-roam-scan-improvements-v5-0-285ff0104188@axis.com>
In-Reply-To: <20251128-roam-scan-improvements-v5-0-285ff0104188@axis.com>
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|PA6PR02MB10457:EE_
X-MS-Office365-Filtering-Correlation-Id: 17554c1b-62bf-4adc-e456-08de2e74fb44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blVONUJpdDJnWThDclFGZTFobk1VQjh0Z0lqMmUvN1ZCOW1lVnVkMWErV2Zn?=
 =?utf-8?B?VDNPY0RYRWZZanVGY2tMbzhmMUdEeUo2NjBta0NhS09DRCtrMFVNc1lFdTJY?=
 =?utf-8?B?akl6YW5jUWdjdG5CQUpZTHZpcHluQ2xnZzQyOG11Ykg1L3NLVVBFcTFZOVlY?=
 =?utf-8?B?cGFpTktWNXkyUnVuSzE0QW91d2pPSmZ6N1dHcU9KUXZOenZqWVB6bi9pZDNi?=
 =?utf-8?B?bHd0Mk5qU0RncmM4c3dOSVplSHlULzRHV2RLQmNzd0hJZ3N1dDFrQWV3V280?=
 =?utf-8?B?ZzVTT2N3QjZ0SERaRC9JYjRSV1hqM25xaXhYOVYwVFZvQkhqem8zc0hZYnhj?=
 =?utf-8?B?N1QzVFp6aHJKR2lOWmdlWXV6ank5VGdsb3Z6N0Q4NTcxNUVoWHZrWTIyM3Fa?=
 =?utf-8?B?TGxSVzE4bnlEVXpVOUxSK2NGbGY5Zm9uQnVNamhlU2NvZVdpYlh2clVpL3ZK?=
 =?utf-8?B?Y1pWVjBFV2NwZ1RYblcySlFtMWxwT2JxMnFMLzJsUE5GTFkvOGlJUVJwRGZj?=
 =?utf-8?B?Q083R2pncUtLaTJxMzJmUGU0a3pXVWtoSXE5TFpDSlJYL0Z2QVF5ZzJuZ2xz?=
 =?utf-8?B?MVVid2VrYzdhVmFFMHUwbCtIbTFJdnV3b04rMHcwNW56V3h1RlhwNmV1WFhI?=
 =?utf-8?B?RWZFTWxDNVVHMWJERzdpemtSeTJzY3BUR1U3VW1lR28zZTFMVEtOc293Sk9n?=
 =?utf-8?B?R0R2cGwyZmZ6NW91SytmZEVmcE5RNDF5S0Jxa2NBYTRYYWRjTXd5eDB1YnFW?=
 =?utf-8?B?bWhaWm9LdVZ5emJSZEFSYVNOSllJVzhvVk82S2xRYlJnUmFKdmJVZE56NVB1?=
 =?utf-8?B?UWFEQUpJQmhWRjR1a1RjZGJzVE8zTTEyNmorTS9VdDVMMU5hZUR4dFRUMFY3?=
 =?utf-8?B?NngvdUJXaUEwdGJlQWxCdkVhVVg4ZE9ZNEt4WkVrbnJ0aG5heFRMd0VteXRr?=
 =?utf-8?B?SGtqSmRXR3JwWllzbFdUNGFWS2Q1eWt1MHFSWCtQdkpUZkgxTzdTSHMvL3Az?=
 =?utf-8?B?b04yTWN6SGJxYjh6amtTdDFkbUpuMzI4dlQvSmxPRHVHVkk4alMzSjd5M093?=
 =?utf-8?B?NFFLWGpUVmhYZVM0MTZHcS8rUXQwSXhaQXdPRGdOL3ZscHkrRzg5Rm84ZHQr?=
 =?utf-8?B?VXNxQ3lYazRwWXVFY0xMSldkbEt0YnpxYXVRdzE3RGovM0h1cll6Y2pMTUsr?=
 =?utf-8?B?dk8zU1BvMWlLV1Rhd2ZKTm1rR0JuTkZpZ29HRGo3OUpJMllVdGdrRFo3eFVO?=
 =?utf-8?B?dklERkVMOW8rS09zMFVyYzkyNTgzK2crWG1ZK1pDODVnQTZoazFFY2ZWY1FG?=
 =?utf-8?B?YTFOTWlSNDF0TGFiejhIeXVmRUxJdytmbjhpWHUwWG94K2ZjVExkVmNBVTNE?=
 =?utf-8?B?TGxSM3BvcXRHMUdnVy9neFVlWXp6L29JSE1CUXg0Vk9rV1c4U2ovY3lzeXVt?=
 =?utf-8?B?OG1aM1FPdWRDcmV1cWdLU0lyY2ZSN0w5OWp2OXZLNVlBaGZWRXlmYWdNeVpG?=
 =?utf-8?B?a1RmZXVWT21OWUJWNEx2eEJmMmlHcUVHUjkzRjdtUVltMHRPalhnMGhrLzhR?=
 =?utf-8?B?SnJXREZBZFpuc2lSLzNBb1NWV0IwQkFoUkVFZDhOekErczllQkRqU2toQnp0?=
 =?utf-8?B?dVZQY1pCQS8raFphQlk5WnF2T1N2OUxocXUwa2l2c2MxTGU0akMxWnNFMFlx?=
 =?utf-8?B?eFlFeUJ5dmpPMTMxdjY0NWNrMWtTdXFXTS9wZ3NTczRZaWsvR1BrT3Jkamc5?=
 =?utf-8?B?WTA5YXUvaW5rd0t5c1hrUlFMb0twcWFqSkVicVo0dnczUzhWK3I1bk9hZ05V?=
 =?utf-8?B?VmY0czNKTXFmc0VaSkxEK2U1ZXIwRnl5ME03d2h3Z0kxd2V4a1NOdk0rMGhz?=
 =?utf-8?B?aDg2RUJ2Z3Y3SXRWQWNBK1lqbFY3NE5kdHFjaGpqeHFwcWlua2RyR1pTYjhj?=
 =?utf-8?B?NGRnaTB6VEdROG5UZTdJQmtNcU5TT0g3enRWUXhJV25lM0twdnNXY3hrSE95?=
 =?utf-8?B?UCtqUWZjUE1BK0F4UEpobDM1clAwM1Z6a2N1dkkrWllvNytGT2kwS0lrNlNu?=
 =?utf-8?B?djRKVUZNc09EdzRGSW1CVzI2Q1NJTUZNZ3Vab2w1SXJ0ZUxvVGFjUzY2Znp6?=
 =?utf-8?Q?1m+I=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 11:55:09.9354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17554c1b-62bf-4adc-e456-08de2e74fb44
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10457

Reaching the full-roam-scan event now requires scanning several subsets
which takes a bit longer, so the default timeout of 10 isn't long enough
anymore.
---
 autotests/testAPRoam/bad_neighbor_report_test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/testAPRoam/bad_neighbor_report_test.py b/autotests/testAPRoam/bad_neighbor_report_test.py
index c1ec7e26..ab275e71 100644
--- a/autotests/testAPRoam/bad_neighbor_report_test.py
+++ b/autotests/testAPRoam/bad_neighbor_report_test.py
@@ -49,7 +49,7 @@ class Test(unittest.TestCase):
         self.device.wait_for_event("roam-scan-triggered")
         self.device.wait_for_event("no-roam-candidates")
         # IWD should then trigger a full scan
-        self.device.wait_for_event("full-roam-scan")
+        self.device.wait_for_event("full-roam-scan", timeout=30)
         self.device.wait_for_event("no-roam-candidates", timeout=30)
 
         # IWD should not trigger a roam again after the above 2 failures.

-- 
2.39.5

