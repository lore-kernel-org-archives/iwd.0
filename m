Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AC2257845
	for <iwd@lists.linux.dev>; Fri, 12 Sep 2025 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676330; cv=fail; b=bctAbXoR/l2LANV4ukU5MmWp1bUtWp86sVnubIDLSMoK+Nx5fdUYRVncjvyZtmCkQtg4n3+lLP4WtDGfxZMZZh3+YhlMWAEXLHUV0JydkRInLj2J/bfnDLQkECfiUoA92S3rxb/dbAwZptxYU+2zUqhI9wl2diU60VGnhjTbEBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676330; c=relaxed/simple;
	bh=oJdpD2GQfer13RwfrbudhUKScuQ15q2jGLzscIvPzGg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To; b=Iy0jFsPIr9ujOLetPFFh882gjpofzeDNv9PkLDD3fQerI0M67BDOARfnsx7niGGttt2loWJj0iMK1FC/6TRF2ps37X6yQM1msv58HfNJkEE36ywGUQHvcxOnLyKnocbfWCxxPobC0wQ9mt0HnGps8B1n5SkhL1GkUiGT7Fy7FAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=SveXfzdM; arc=fail smtp.client-ip=52.101.72.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="SveXfzdM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlbvLuSpl1v8vcS8pFJaBxL4cXt47F75/Pa2WwOm1nQtLsObZWSVpxbxHtGH14WHThtBfhx04fncvi/zl3zW7wRdtYFTw55+DI+a+WIl/6beDZlsLHbmghSLrm7Bqqdt7djUribyUxPxKZ5rGXP60Lv3qI14JSKzXKQR6Ykn82ojGwpSiWJhItcKjN+JXrjSMX7K6/uXHnKmOSh9ighWyIu3j8BLN0ivDMbCsgjHwveDDafrbfagqaz9RQ7v4cFID/z1+9OWo8Pm97OlY/PRGt9qr4lZy1rsy4suFFblKbWFlSPDsgypj7wZlNSliGC4Bi+whYaVV7mtCgJTvcqgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2rxW3FZ/wb6ZtfVhM4wO+oBpn9neNWJfso/uy3Hv4Y=;
 b=LFqxx4M34BslmI2+H2b02fMHxF98j4123YMWLN1XUnJ4V1+nzpTWzcyjpLjqffQ7VQBrdp4zpKtF67HVffLA9vgj7o8JKPkd9XW8+MLrXSMS5cKEvD1NzFC5f5vAolDmuHijfXnt1CcHxSbscDyhVE8agnZkEAYDSflhqL0VvOQfjms2+zDVo7e/VUQcVipfGm67rpWkxKnN1kVM1tsA+dQWtxw6PrxFXW8mJWmK3CN4II/VmoY0/NkuVeCX+iKrOkf5K6u15EhK6BU/2nQAJs6sbLXdaNyj1e27QN77/71YvykKaLe82XobTHtKUcGUVZ/C+lRU5f2cS8Z4W9F1ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2rxW3FZ/wb6ZtfVhM4wO+oBpn9neNWJfso/uy3Hv4Y=;
 b=SveXfzdM3dT6CtBmVIjvRFndG7Tb/dkgg5UDVYfC37mQZxpQK3MiUqbyN2JykVTcGpPgp+smNhhW3/1Ira0v/WutIcz+Jktgn8lzH2lkas3zeLwgk6M70FH41R9UJ6omh8hrTIN4yHCm7vNzq4c2apU8xDJjEnHMNsbBvTkak2g=
Received: from AM4PR07CA0021.eurprd07.prod.outlook.com (2603:10a6:205:1::34)
 by AS1PR02MB8207.eurprd02.prod.outlook.com (2603:10a6:20b:482::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.30; Fri, 12 Sep
 2025 11:25:19 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:205:1:cafe::43) by AM4PR07CA0021.outlook.office365.com
 (2603:10a6:205:1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via Frontend Transport; Fri,
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
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Fri, 12 Sep
 2025 13:25:19 +0200
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Fri, 12 Sep
 2025 13:25:18 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Sep 2025 13:25:18 +0200
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id D55EB225C
	for <iwd@lists.linux.dev>; Fri, 12 Sep 2025 13:25:18 +0200 (CEST)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id D2947287A5DE; Fri, 12 Sep 2025 13:25:18 +0200 (CEST)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Subject: [PATCH v4 0/3] Improve roam scan strategy
Date: Fri, 12 Sep 2025 13:23:19 +0200
Message-ID: <20250912-roam-scan-improvements-v4-0-761a92734603@axis.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKcCxGgC/3XNQQqDMBCF4auUrJuSmWiMXfUepQtNpjULjSQSL
 OLdGwulpeDyfzDfLCxScBTZ+bCwQMlF54ccxfHATNcMD+LO5mYosBQFFDz4pufRNAN3/Rh8op6
 GKXKBAMpUplASWD4eA93d/Iavt9ydi5MPz/efBNv6Ics9MgEXHFBjRUIrXZeXZnbxZHzPNjHhV
 9FY7yqYFa21UW1rrQTxp8ivUgPuKjIr1N6tAmsUyvpHWdf1BTOYtMdHAQAA
X-Change-ID: 20250414-roam-scan-improvements-02116c7c4631
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C717:EE_|AS1PR02MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: 01582b4e-bf8e-438a-c018-08ddf1ef0e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEVsZ2wrUkYvTVNzcVNuUkJ4bk9JRndJNmNQZ3dILzNsRWVjSGZLTytHcTcr?=
 =?utf-8?B?K29lUEdKQ3pUOStJKzlxWUF5Uk9pUDdIUnhkOWJFUmZpMExTQ1Z2aU90cmxh?=
 =?utf-8?B?MTNVMVZySjV4U1ZYN21sTmluUjhCSnhTZ2NxM21YclNqNUJHMFk0eVR3bnpJ?=
 =?utf-8?B?endDMzlibDhOSHh1anFiQUNqcXUwMWVsM0ZINTI3R3p2UURVcE1QRWdwQWhr?=
 =?utf-8?B?M1NMTFFhMDVXL2VLWVdRTW9TR1IwQVkyMnRMS2c0MWNpaTc0SmEwamtTYXJR?=
 =?utf-8?B?Nms5N2ZWUUNXb0l0czBKeGUyMGJ2L2d1NkR2SXYrckN2WDIxczhrTTcvSTN1?=
 =?utf-8?B?N2paN0syU2RnTXhuNXlaVW0yeGF0bVpTRjdDVzBmS3dzbFoxblhqY1ZOM3hN?=
 =?utf-8?B?c3RvZXN3N04wK3lKeXErV2FuMVM0eXFVU2NKNy9YQzR4RTFhQ1RsU0YrQ3ZO?=
 =?utf-8?B?TkdZWjlSN1J1UDViRXp1WXlseWlQVnNDdWkwbktOdkdGUDdnYytZckI4SHBq?=
 =?utf-8?B?MlBPS1NSbFF5UWJXVnZaWkl5MjRScWxaNnZqNE9hc3VhK2cxbUxXUjF6M2ND?=
 =?utf-8?B?dzMweEkzcnJMbitlSVJ4MjVxVmlKUjRoV09PZllhOG1VWjlkVnJURFQ3OXRF?=
 =?utf-8?B?eUJRRnh0eHJVeU1NR0JLZ041YTVYQ3dGanlYdU5FeUZpeUJmUkc4YzhxeHV2?=
 =?utf-8?B?SG9na0NHanBrSDBwekVYSHRjd2N0Vno2UE04anJ0V05KRUMxRVM4MWpMUEtE?=
 =?utf-8?B?UTgwUUJoV1NMbGtRb3h4L1FUTExUWmNMWlRpY1p5YVpXQVFHL2Q0a09XbFlH?=
 =?utf-8?B?MXRhaWNRKzdtTGF1N1NYS1E4bTdtcjkza3pmQzVaMk1POGUrdjRaUEN1QW84?=
 =?utf-8?B?L1dmYWVpQlFRWU4rU1BMNEZBWXRZeDRTSUkxeVRzMHRqWExocXg0dDNBWmEx?=
 =?utf-8?B?LzVQMGNVSE9QT0tFbTRHdHRpTFp4V0kxQm1TTnNaMEVlMXJsWGtxRzhBbEwy?=
 =?utf-8?B?WFJpM0VOSllWdGVqTjM0TUg5MHhyb1RsOU1EVzV2bmxtTDRoV3p6YjBsVEUw?=
 =?utf-8?B?L2RYQzNoVXpuSmFZNGd0d3NzaHNpQ0lIaHFHdSs5RWNIS0pkTFFVVGdHTmwr?=
 =?utf-8?B?cnJETitpOXE3WE5DMkc1ZGl5bE5EUmloSGIybGRJempSL3YzMktzT0FJcDBm?=
 =?utf-8?B?QldvekJwZXA2R00wQUUwTzJUSzkxYTRvYnJMa2RkZ3U2NW1NNXRIb1VKSzVN?=
 =?utf-8?B?VjZEM3BNY0M4UGV1bEovUXJ4OG5CTHhFd08xUlFKWjN2QjZNVkJCbHlsV3pm?=
 =?utf-8?B?RFNtSDhSeWViazJiN1VhdUdkRGlhUnZaa2FkMGZyY28zaWo0UTlTY3VOMksw?=
 =?utf-8?B?MC81Z1RsVkVSQW9ERGFtS3RpZ1Q4clNTV2JQNW5HYnlZSlh6MHhSVnNER2sw?=
 =?utf-8?B?S05mU2JNUVhzZFNwKzU2anRNZGRvTFJ6TmpwbjRRclRKRnhVT3FoSGhwdnVH?=
 =?utf-8?B?SWpsVldvWGpRVXA4MDNqWU9BbDJrazdjUmVzanVYcEdLZ2lXaUlFNFFabnZl?=
 =?utf-8?B?T0ptRi91ZlhvTnFyOXFDa0R2Z1dFMENKbXBDK1UwN1EzUktrMWMzeDVVMEdm?=
 =?utf-8?B?Zkt6VisvMm1Cb201YW5UUW93bzYyamhWVXo5WkErVEhzUzZDNVRUcG9GR1ln?=
 =?utf-8?B?VlhFNlk3OUpGN29qZmpqeFArMXg0S0lvdUdOTG1EUmRTdlY1cW5xellCVU5D?=
 =?utf-8?B?V0RkT05kWFlzSFhVMDBnVlg0KzVHclR1cm9oVVRGTDVnR3ZHcUpTWEhZVjY1?=
 =?utf-8?B?Zm1OWWxORFRkVU02algxd1JNN09iTHBacm1PbXAwUlNPenRQYVYyUE5NRndW?=
 =?utf-8?B?aEhPaGt3Vll3VUJDM0d6ajQ3eGVqTUoyWGJQMGJpZkk3UThSWG1rSzRYUXZL?=
 =?utf-8?B?L2hGL0hvSm5hcUV4eHdUSEdVVHIxSGZZSTBlWmt5dW9vclp6NDlBQU5tRitD?=
 =?utf-8?B?L1JFK2UwSUFFTnozdTZCeG1qNzFxMDFyTXpVMHRRY1hUVkVKYlZvbWtoaGNZ?=
 =?utf-8?Q?XIs2oX?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 11:25:19.8351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01582b4e-bf8e-438a-c018-08ddf1ef0e78
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR02MB8207

I recommend looking at the diff in a side-by-side viewer, the patch
files are looking far more complicated than they actually are...

This is attempt #2 at improving roaming. This removes the previous
timestamp-based approach and instead uses a simple list to keep track of
which frequencies have been scanned in the current roam attempt.

The main idea is to make station_start_roam() the central point for all
roaming. When some function wants to trigger a roam, it calls
station_start_roam() that takes care of all scan logic.

In my own testing I've noticed a big improvement in connection stability
when running around a building. There might be edge-cases I've missed
though, as I don't have a setup to test all different functionality.

Happy to hear your thoughts on this approach and if it can be improved.

Thanks,
Alexander

---
Changes in v4:
- Fixed small build error introduced in previous revision
- Link to v3: https://lore.kernel.org/r/20250912-roam-scan-improvements-v3-0-ebfd61dc6239@axis.com

Changes in v3:
- Fixed CI issues
- Fixed unnecessary braces as per James's comment
- Fixed bug where 6GHz "set" variable wasn't freed in all cases in
  station_fill_scan_freq_subsets()
- Added logic to handle case where all subsets are empty in
  station_fill_scan_freq_subsets()
- Link to v2: https://lore.kernel.org/r/20250829-roam-scan-improvements-v2-0-888c6bbdd310@axis.com

Changes in v2:
- Removed code that tracked scan frequency timestamps
- Added code to track which frequencies have been scanned
- Link to v1: https://lore.kernel.org/r/20250415-roam-scan-improvements-v1-0-12827e086895@axis.com

---
Alexander Ganslandt (3):
      util: add scan_freq_set_size function
      station: improve scan_freqs_order channel subsets
      station: improve roam scan strategy

 src/station.c | 367 +++++++++++++++++++++++++++++++---------------------------
 src/util.c    |  11 ++
 src/util.h    |   1 +
 3 files changed, 208 insertions(+), 171 deletions(-)
---
base-commit: 3760a49650b39edd623a85a2b9d51645b52d004a
change-id: 20250414-roam-scan-improvements-02116c7c4631

Best regards,
-- 
Alexander Ganslandt <alexander.ganslandt@axis.com>

