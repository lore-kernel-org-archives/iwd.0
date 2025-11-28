Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013023.outbound.protection.outlook.com [52.101.72.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAEE3254A3
	for <iwd@lists.linux.dev>; Fri, 28 Nov 2025 11:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330912; cv=fail; b=KNZ6Wt4GFhn1owTEjUVN97Nu09xbMekcDCvoBKgmZCQ0Qz8w7m6W6koUVPzMkwC2Wsv5mGMOPGyso7IHGwGg4rHP517Krvlv110RO45y7sNrZ1gEVjxaZ6Xz9LKJ2XJbxZbKtMYXT+6ienAsKPHwpZi58DXVTtmbrW8J6Ch41ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330912; c=relaxed/simple;
	bh=wB2uvvVoAC1Kygq0iYOFZ0scLpP4rGpQFh7lWXxWrs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=FOy1LnsZoTfhmaDpQKpMoBFk0YZJ1RkCsah78RsvPWmS3UxI/hxauO6LInH9f5V4PP2E+q0HNRMWtRxjOCl5udQppxcSaJnnAl37EyFwMB1ecwaa4WCGYrYRmRqo243JRqWAV28OKyJHUYaoz1rsdPKV5RjG5K05UqvxeI4kwkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=IUm+GLui; arc=fail smtp.client-ip=52.101.72.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="IUm+GLui"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOtjUisnn/a7LYn8O318mhHE4iKqnAKD4F/+gBf8rAmUgT1wp0CfJe04fRuix8g9MBicmgKdgdTBnvZwpg5bwQs8gCgpshpc7+TcfHootZBTDhXaVWi3GvtnyvoUBpWwxIoSB8x4mmbUQpggi1M7JM5eX+bxCIvOK+/cQFZlQ7wD/Tn3uPCnj/K6ZwPnj0y3wHdo2NiMr6I4zm6jmkWW8SE4n4RO4SFY0VxbHI7wKqJzDZCkN4A7xVYzYNo5VLuU87zHQXReiBmsyc17t3sLwB6VFhlbypPN5U0pERsXzzPnInf0fu4c8XP7Sf/8rrQifB7602N11PjMxJZ5ExzG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWzOFchDRtV3JEz7Fgji7O5C0WardGvlsTSWPgaNyjE=;
 b=To+U6SVVUm5So8HvkUVNJBKblK9F+ijFobppnhguoCL2H3rVU8ppKL9WU+uj26VC0ZbdEvrQ6E0kigFNma47wJm0apOmNlUp87AgIvra8ZLqSqh0WzwUuQyya3WK73B7qngGXdO9yiGjEROILR1m1i8+OWRiiA4JIkiqe7MGP17RjVsgclnvwEFsQUim8vkCf6ikKc6/v1WKoul9+Follf4tq4dtwqBn3CXdBlfSSPPfjVMxgP0Abi2loVqw91GkSEuAGiN5/hUjRYVfqHsuBryHw2D+B48liNElNwD+d8ivwrnTmB8HTHCw5yhrA2bw2Iy5kjPJg1nMnxvCOheObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWzOFchDRtV3JEz7Fgji7O5C0WardGvlsTSWPgaNyjE=;
 b=IUm+GLuidatLgi1Hg+J3NL1Ag4ZEQQhe8hcj32bZS9x19g5et065wJwtaW/ncfZLZs+KyiUx5/WWxm4oeXuX0FDjBf97BXqOSbbss4NeUidc7MmerfiTOTBIC6Qo5NbuUgCXLbW5ye+QZZ3BkRS2R/LJKN7dewgLpBb92xgepxA=
Received: from DUZPR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::7) by PA1PR02MB11305.eurprd02.prod.outlook.com
 (2603:10a6:102:4f4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 11:55:08 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::66) by DUZPR01CA0028.outlook.office365.com
 (2603:10a6:10:46b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.16 via Frontend Transport; Fri,
 28 Nov 2025 11:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 11:55:07 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 28 Nov
 2025 12:55:07 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 28 Nov 2025 12:55:07 +0100
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 77A95912
	for <iwd@lists.linux.dev>; Fri, 28 Nov 2025 12:55:07 +0100 (CET)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 755F42865168; Fri, 28 Nov 2025 12:55:07 +0100 (CET)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Date: Fri, 28 Nov 2025 12:54:26 +0100
Subject: [PATCH v5 5/8] auto-t: Fix tests relying on full-roam-scan
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251128-roam-scan-improvements-v5-5-285ff0104188@axis.com>
References: <20251128-roam-scan-improvements-v5-0-285ff0104188@axis.com>
In-Reply-To: <20251128-roam-scan-improvements-v5-0-285ff0104188@axis.com>
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|PA1PR02MB11305:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c7f7a1-e66e-49e0-7271-08de2e74fa09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVVPa0thclZtSmNkb2MzTE1sdk1FRzZmQ0JKY0liYkQyaFkrdE03VW1BckdY?=
 =?utf-8?B?TC9XTXEvNFdkTGdkZWpCeFJBWVlyY044clJsMWJ6SXp6dEVObU84cXZXblNS?=
 =?utf-8?B?SVdWTXJxUHpjZ0x6MUd6dGxJU21FUGhiK3lDbWxMYjBrSHNQVWlFTTE5NXRQ?=
 =?utf-8?B?UXZmWnJhcmV4Y1BTVGtUSUh1SVhablVVRFFJYjR6Sy9TQ09SdGhSaWNFTlh0?=
 =?utf-8?B?dXowMmtMdHBKY2tjV1c2blhZRnE2WGgwNktIYUNBaWtuWkdTMkdsYk5uVys1?=
 =?utf-8?B?SHN6NjF1dDRwbXVGQ3dDenpjcXR4V3dVRDEwWUZYVlVYdlErejZEbEJwb3I3?=
 =?utf-8?B?NmpRczl5WDhRYk5rTFc2NmhXdkFCWG1GeGxqUTBjSkJKWVVPcEkvekR2NEp5?=
 =?utf-8?B?SFY1TUhtRG11RUVmK2JoaTVaWHExRnZXWjZwSEdVR2ZLRXp2Unk2RDdyOGo3?=
 =?utf-8?B?YXAwek9lMk1JN2diaVpQYURQR0g1TXdBQXhaMGJvSGF5dnFHV0F1R0pWMkY5?=
 =?utf-8?B?UnVrVlppMUhxbWZ4WnlRcVdMajAwbWdzMk96WU56T0RmcDZ5aGhralB4aURV?=
 =?utf-8?B?Q2RMTzJ4elZhVjNpOUs1S3RXdHYyRHlkU0Vqc2Q4djJkT20wR3BZVjY3c0ND?=
 =?utf-8?B?QXhpalY1MllGSHlaM0ltRzRlTGxEQUphd2Z3bzI3dVhaZVI3eGNQNisxVCt0?=
 =?utf-8?B?SVByS0ZPb3Z0LzBhQWZnMytQdjZYMTdDOTZjeTlQbEJGeUNvQm03Z01yMWgx?=
 =?utf-8?B?dEU2RE8reVNuVWZZWWxtdUQ2NDV2ZUlCL1VvNElXdElCVDV3bFNmeDdFUlU2?=
 =?utf-8?B?TUFQYVdtM1VHUC9hRlRIQUZvR1dKdnp1ZldiajNyWE9pRHJjOFA3V3J0cy8x?=
 =?utf-8?B?QWZWVjJ4aERQTHJaZElIWjhzSW9MTjJSUWw3V1M4TEljbHlUYmprUVd0RTdl?=
 =?utf-8?B?aWFsaFN5Z1pRU2tON0t3eUtVMWs2VTQ5MTdGQkV1RHZRQ1dvYUY0elBNbmVK?=
 =?utf-8?B?bkZrN3V5UnBEbTB5OGFVSjVNa2pzeXRkWnU4WEJzU2J3bFcydmc3NGI3Uys3?=
 =?utf-8?B?SUY2a2xSU0xES2VPdjZmejZ3blhmSm81YWlyTEpKNHFWZEhIQ2hSZGJXTldv?=
 =?utf-8?B?WHJVd3pYTk1XNEFYTG9VZkNMazZGQWxvQXd2eFExM0pMQmd4UlRyYW1uQWw1?=
 =?utf-8?B?R2NxdGwvcythTHZyR2VmWnU1QU96MVcrbUdUdW1oeHFEalR6WUp6TDY5VElz?=
 =?utf-8?B?VEFMeTBsdnJOK24zT1V5MUhLL05FZFRqTzJqUHJXVlFYR1h0bzdEbSthSjQ3?=
 =?utf-8?B?R1BDa1dTQ2RSOS85OVBWOFRoenZ4WVl1aEVaU3hwaE9qVFhSM0VMZlV5ZTNm?=
 =?utf-8?B?ekhvWDIwSy90Q1o0aG1XdjVleURpYWxSZHhyNXVkRUNLYXpLR3NBYnBBRFcx?=
 =?utf-8?B?eS9xK05KdVhCNitWOUxtcktBU3lMWmpxaTNJWDVuSWkrbytCQ2NXRmdaQUND?=
 =?utf-8?B?WFA0ampxQmwveG00aHNhZWVkTWFXWlhqZWhjR1RtOUZqenovQjNCbDZXQWZq?=
 =?utf-8?B?dnhNSGZERm1vYlhMRDdLUFRiTHFFeTdhS01KL0dZV0NST1I0ejFXRnRRY2hB?=
 =?utf-8?B?Z2FDS2t3QWV2ck1IT2hRSE5KbWhJa1NCcUhNZ2JTWXBSbHVNSzFRK3JjMnRH?=
 =?utf-8?B?WDEvOTRhM0p3ckZJUVU2WnpHQWpQYXJQaFgrLzdER3ZIY3VWOXd2cnlqejdY?=
 =?utf-8?B?dlRrRzhGWUdSS1FxanFENnRRdEZIVWQwQXdVaDlPTUFPbWkvUzZrQnByRUR5?=
 =?utf-8?B?emZUMTRiV3dPMWZuZ2dqcEpwM2dMbk5sS2VRYXREYnE0L2tzbkpBdkd3Y3ZF?=
 =?utf-8?B?L3dVMDcvY3RBSVRPZHFjZ09URUZuY3hiSzB5STRGN2o3cFVBbURnWk1VWjVu?=
 =?utf-8?B?aUxRVFdKMXRoemcwbkhFdUFVeWEvSCtTUXRxZUlWSGJUTGp4dzFZYnRKN21U?=
 =?utf-8?B?cEdjK2d3M3VxdzdNQ2NRakdmRForZ3pFZWM4YnlxTG9OZWlNS1l6SjlkcUxv?=
 =?utf-8?B?emJuUEJLdVpxQVhObXVHQ3BWQ3F3dHZ3QmVxTC9KWFpOaUs2ckVEbUhtbldK?=
 =?utf-8?Q?Z7I4=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 11:55:07.8627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c7f7a1-e66e-49e0-7271-08de2e74fa09
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR02MB11305

These tests can't be guaranteed to reach a full scan anymore, as iwd
will find the BSS before that happens. Getting the roaming and connected
events should be enough to pass these tests.
---
 autotests/testAPRoam/bad_neighbor_report_test.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/autotests/testAPRoam/bad_neighbor_report_test.py b/autotests/testAPRoam/bad_neighbor_report_test.py
index ab275e71..e361d37d 100644
--- a/autotests/testAPRoam/bad_neighbor_report_test.py
+++ b/autotests/testAPRoam/bad_neighbor_report_test.py
@@ -71,8 +71,7 @@ class Test(unittest.TestCase):
         )
         self.device.wait_for_event("roam-scan-triggered")
         self.device.wait_for_event("no-roam-candidates")
-        # IWD should then trigger a full scan
-        self.device.wait_for_event("full-roam-scan")
+        # IWD should then start scanning until it finds a BSS
         self.device.wait_for_event("roaming", timeout=30)
         self.device.wait_for_event("connected")
 
@@ -99,8 +98,7 @@ class Test(unittest.TestCase):
         # channel 11 which no AP is on. This should result in a limited scan
         # picking up no candidates.
         self.device.wait_for_event("no-roam-candidates", timeout=30)
-        # IWD should then trigger a full scan
-        self.device.wait_for_event("full-roam-scan")
+        # IWD should then start scanning until it finds a BSS
         self.device.wait_for_event("roaming", timeout=30)
         self.device.wait_for_event("connected")
 

-- 
2.39.5

