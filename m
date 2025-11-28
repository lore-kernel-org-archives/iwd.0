Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010037.outbound.protection.outlook.com [52.101.84.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EE8325731
	for <iwd@lists.linux.dev>; Fri, 28 Nov 2025 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330917; cv=fail; b=FPjufpFsiMETdoD1/eYh/8ve/LCTGcfgjpQ67l7W+iLIJZEaWdxLXhceO+Li8lg2N2ZlbUwMLJlznl+1t+0PEipqt4TClSYpFR1Wo6PvMSnVEJYILElqE0gcJPrb347TBLz+d10YVQOMiFFM5A4MmTsMwfkM3NWRGg+CrPk1i9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330917; c=relaxed/simple;
	bh=DX2v+TBgdzN/52yS6SF8m01aXRSou4AcRpS0sDVsEz4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To; b=Rz6iT2utgv/eTXPg9xXT1/kq5H/N4+lvzsN4lswy2BfBQcxQJIWrBwb6DwqhpLeLTpgkiPnOS8Fzb0X/xaIVjVVJ8RwelWEnA03ytG7kgcy13VvxK9YN7OQXvLoJB7LEClWZrI8oKoDBpJLr5jlkyULZY23IZQ2dhEpksphj1BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=czfOKazh; arc=fail smtp.client-ip=52.101.84.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="czfOKazh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4+AQmYxbARxj6rcD0a3L8ETc04IdX4vOj0xcDwlJBkoT1pmG9cPXnZ91Bw7MdgTHGT58Xwwcu9kybnhrHd9lIIGDEtoZ8A1KDrCMOlFq0Xt16XW+7LAesfvOTdRuOU2P+uxBSYy+8aJoxk2mBw5/D0MugtB6iJ6GH1qmuUEQl0z73pEGYd5Ku9l9f6QXHQ0v3h249ezlXGG64FIiGc7f5KM8WOUNtaW04W9H5fOIWYih3seGO/mY1ztmplJHVuOecIIXCz8vj4mdK2/RWN/PPHyF2gBIdsuzFqmgPl8nRPsCsDxuZ8MgDqYUTQvLpU4spC36BUBOkxdpOXYRGASug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ocewwOXdZKSIUR8W9PAQtJLtaurM/E6wpdzB8Jzwi0=;
 b=C1QaXu48k78ZZjA9AZnwqn/ZGJIJiB2AOv/fmoOiiakySbkyOkJOEWrkh7kKHpzNiG/ZuuU1xzA0REn3ToWQqo59IyprVD3E+Q8bg5l+TIBIptIfl6xetCLhKeHPNe4Do9WTMbd+GOM8PpqEnwZKG1sQppIjClzhzF2bHl9k7zY+9DLx8zvjZqDn6gDV2LE5ydXVekuFiQc46ngGd0pgU4kxi1T1NQ54HKx1LCTbYa5HJi7kOhf6x7A45oafW4DqaQvi8NQwopXTWu/Ifptq8I2OSrtObf1nq0yVkkL4gyHV2xjbS6hacNONOfN+AKQSD0DUEWwrlg/11wZy+fO7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ocewwOXdZKSIUR8W9PAQtJLtaurM/E6wpdzB8Jzwi0=;
 b=czfOKazhB7jmfx5B9oA49ap9V3y7BxhkLHbICrXkqPgrBW8HvU89WsvRUQ2nFEUOELwaHOwMys9hdoIHtxJrf4b9e2dBk87xbmbIxSizsNa/ph0DOc3hSgxGcqjz7BW/neQdnweGxDdDmjlPo17mF5+MHwW9metO89SL1Yx4/xc=
Received: from DB3PR08CA0017.eurprd08.prod.outlook.com (2603:10a6:8::30) by
 DB9PR02MB6780.eurprd02.prod.outlook.com (2603:10a6:10:217::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.15; Fri, 28 Nov 2025 11:55:09 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:8:0:cafe::6b) by DB3PR08CA0017.outlook.office365.com
 (2603:10a6:8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.13 via Frontend Transport; Fri,
 28 Nov 2025 11:55:12 +0000
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
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 28 Nov
 2025 12:55:07 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 28 Nov
 2025 12:55:07 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 28 Nov 2025 12:55:07 +0100
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 71D01888
	for <iwd@lists.linux.dev>; Fri, 28 Nov 2025 12:55:07 +0100 (CET)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 6CB9A2865168; Fri, 28 Nov 2025 12:55:07 +0100 (CET)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Subject: [PATCH v5 0/8] Improve roam scan strategy
Date: Fri, 28 Nov 2025 12:54:21 +0100
Message-ID: <20251128-roam-scan-improvements-v5-0-285ff0104188@axis.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG2NKWkC/43NwYrDIBDG8VcpnuvijMbonvY9lh6MTlsPiUGLd
 Al595rC0qUQ2OP/g/nNwgrlSIV9HhaWqcYS09SiOx6Yv7rpQjyG1gwFdkKB4jm5kRfvJh7HOad
 KI023wgUCaN97pSWwdjxnOsf7E/4+tb7Gckv55/mnwrb+kt0eWYELDmiwJ2G0sd2Xu8fy4dPIN
 rHiSzFodxVsijHG62EIQYJ4U+RLsYC7imwKDeegIXiN0r4p6n+KakqvwVnspdJC/lHWdX0A5Zh
 Hjo0BAAA=
X-Change-ID: 20250414-roam-scan-improvements-02116c7c4631
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|DB9PR02MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: f05c66fe-b50f-4883-2335-08de2e74fb22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzBoR0RDNVFhdWNIWHZVWmlQQUQyZk1SVjFpT0R5NE1FY0MrVDZjbnVqbmRl?=
 =?utf-8?B?TVR0NW03Q3BTK3hvbWRkVDk1SmRIeDlmaVI2ZVRLUnUvVFFkdENIcHZZR1hx?=
 =?utf-8?B?b1hoV0MrQ05LNEYyS09iejFlM3F2THBSaG4yU2tOTWFER3ZaOGdZbE85MGVh?=
 =?utf-8?B?RnEzY2dTcmN1Mk45c0E1Nmx5cGN0OGQraTFhUzloSFU4SlQrbWZ0b1FDVkFZ?=
 =?utf-8?B?SUl2N2o5TlZtcHIvWWQ4dHZUZjBJV0NIOC9pVEQ3Qmk0VVhxRmZESy9yMnJq?=
 =?utf-8?B?RkhHb1pKTHI5N2dIYkIzVGhERWRBeThMODFuQ3JNcENzSzgzbXE1REVTaDZh?=
 =?utf-8?B?WkpiTkRlcXMvVlBCb1Z5Z0UvTDd6YVVzcnJ2WHNpTG1XL2U4a1g0dzFCSkds?=
 =?utf-8?B?UFJhNjkyTUFtdi9yb3B6T2dOeTVhdEZnT09iRmI0azM0dlRpOHgyUW55M1lw?=
 =?utf-8?B?cUVyZ0JyaVNWMDdUcTlFMUViV3dVT2hQYU42UVF3QXQxYjZid25OREhON2NW?=
 =?utf-8?B?Q2d6SjlVYmxHOFBDRmtZNWd5SUZmcExXeS8yaWUwUGphVWhHRDJ6aUxsV1l4?=
 =?utf-8?B?U0RGVklTWXNwL0tBdS9ybFhvMjR1eDVVdWl5Wm40WDhyZGxDM1hibHFOT3Ex?=
 =?utf-8?B?L2FwaERWOE5naVNyNngxWkxETUtkNVJrMzJDVyt3ZVY2MmJ6ajF0U0tLb3hl?=
 =?utf-8?B?RzRGMms5MDcyVVBBeTIwUTB2d00rQm81Y1pHejZIcHlLa0dDclROODJyckpv?=
 =?utf-8?B?cVA0OE5DQ2lGK1hZaHRqaVdWQmRYakhNK3lEQTVTTy8vSEZEbjJPZDlVWEFk?=
 =?utf-8?B?bDdQak9HcFpKUTRXb1RmY1ROcTI2amQwdkd3VzVjc0pweUhPWGIvNXlMeWp1?=
 =?utf-8?B?UHdLdDJtczE1eEdXNmtDODFSZmJUSGRyaVVMbEkrRmhiUGI4TS9LYUdWL0do?=
 =?utf-8?B?WnpvYWNua0RsNGpIUmVUczM2N0llcitjR3pQN0hpaUhMU2c1WEVnUURCSGk0?=
 =?utf-8?B?R1pvUFlrbC95T1NpeFRRc3J2bEZNOGtqZzZHK0puOXZUTGZ4Slk0a0U5cUov?=
 =?utf-8?B?WUx2bGlBcit6eW9kMEFlbERUVkZ2RmRkaVU0STZFcC9kY1RIbmZYQTYwUXRT?=
 =?utf-8?B?ZXV5dHBsZGhTcjF2b20vam92TWk2T05QbWN2UDZ1bll4ZlVvd2xHQ1F5N3F2?=
 =?utf-8?B?VmVaRnJQTXRBUU1SbzFxaWhQeGpsdjl3eDZ5d1Q4djdyNUtnVzBxa3NTUndK?=
 =?utf-8?B?NWwrL3plcWdXMk5Zc1FRZ1V4dkJmNUh0R1ZMLzA5RTdGRVJNSjNHcTB3RlRI?=
 =?utf-8?B?Zlp6T2Y2Q0tTMEZSbWxwOUNmWXlabHZhSzc2UkFGT1hzK2VtdFZyN3JFOW5a?=
 =?utf-8?B?VklHVkFDVis5c29WT2NtaVRWOExzcDNQUkxLbkl6KzUyMmhNTmR2M0VLQTA0?=
 =?utf-8?B?T3lXQ1ZVTDFib1B4V3dwbmJReitOQmFGNEhKVWljdGdrbkRuWUVKeTlGaExm?=
 =?utf-8?B?Sk5yRGNncGdwY3lXYWxRQWFaeDhFL3hnWStueFJWcVk0aW91dWlZVTI5L2M0?=
 =?utf-8?B?OXRpNEJ5OUVPOEp6WVhRMkJ6WFo3RDhsand3T1paVTVraWVHSUxJM3NBcS9O?=
 =?utf-8?B?NzBMaEU1eWhzQ3lJZFhMMnRXcGdYeFg3dkJGTUdMU2tMbHhmTjBiSVh4ZHBU?=
 =?utf-8?B?cGZNN2F4UEhMZGM3K2tjUjhKaENYdkZCZ3ErR21sV1NTYkx6c2VPWmlRSHdH?=
 =?utf-8?B?bWZLbjU2bER0TlN5ZFk0S1RFbytDU2ZkRkJ2dDFvdHJkRnJNRkhlM3hXVVU2?=
 =?utf-8?B?dkV5U2tidVNWU3QzTUxrenkwdEJzTlcrT0hYeFU4d2ZLZVh6QUxNRktNTnF1?=
 =?utf-8?B?dkl1NlJiSFU3YlRUN1V6VUtKUjV1T1NDMEthVXlkS0dqTlZWaFVSdkFzbFdY?=
 =?utf-8?B?U1dGREljQ0NHZjdEbUtRL05BN2RSUlBNWFZaSXpoamdiS0syOGZIWk1TdlB3?=
 =?utf-8?B?OUQveTRtWnVTNm85a2pwY1JCbC9iSjNKUUJHYWI4WmxjYUI5NzN5amRyaGpR?=
 =?utf-8?B?elVSdWZBd1NXZytOWDh4VUxLRkhYcHNlYkpNbWpyRVlJaWFmR1d5M1N5SVdu?=
 =?utf-8?Q?0Wf4=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 11:55:09.7076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f05c66fe-b50f-4883-2335-08de2e74fb22
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6780

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
Changes in v5:
- Added full-roam-scan event when all frequencies have been scanned
- Added handling for AP directed roaming, it should now use the same
  "roam loop" approach as other types of roaming
- Fixed autotest issues
- Link to v4: https://lore.kernel.org/r/20250912-roam-scan-improvements-v4-0-761a92734603@axis.com

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
Alexander Ganslandt (8):
      util: add scan_freq_set_size function
      station: improve scan_freqs_order channel subsets
      station: improve roam scan strategy
      auto-t: Increase event timeout for test_full_scan
      auto-t: Fix tests relying on full-roam-scan
      auto-t: Call default instead of reload in teardown
      auto-t: Fix test_ignore_candidate_list_quirk
      auto-t: Disable MAC randomization for a few tests

 autotests/testAP-no-support/main.conf            |   2 +
 autotests/testAPRoam/bad_neighbor_report_test.py |  19 +-
 autotests/testBasicServiceSet/main.conf          |   2 +
 autotests/testDPP/main.conf                      |   2 +
 autotests/testDisconnectByAP/main.conf           |   2 +
 autotests/util/iwd.py                            |  13 +-
 src/station.c                                    | 387 ++++++++++++-----------
 src/util.c                                       |  11 +
 src/util.h                                       |   1 +
 9 files changed, 242 insertions(+), 197 deletions(-)
---
base-commit: 3760a49650b39edd623a85a2b9d51645b52d004a
change-id: 20250414-roam-scan-improvements-02116c7c4631

Best regards,
-- 
Alexander Ganslandt <alexander.ganslandt@axis.com>

