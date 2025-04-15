Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013013.outbound.protection.outlook.com [52.101.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518E4241CA2
	for <iwd@lists.linux.dev>; Tue, 15 Apr 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705316; cv=fail; b=HrQkE0aalqcl1//WePL/eIFhva0rUfUUKtJV++LF8OAkZADlY+tjg6oWlyY/FO7pcmTAnDJu2DAhK+w7FejEeCu6u367LAJvff75FzNjmehrHyj9EOn7X9UoPbwvm8DE+7s5ELDAmW8awQOgzkxJRtfsUcdwtUKglUo/9lw/Gl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705316; c=relaxed/simple;
	bh=ITo2wuEHHvWgabE4sVEoegcZaPgGHI6Vp2vCbyNmiLY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To; b=MdF9a3okJWB8ItcRpFakYbwl8SN1s9F2XVFyhfjQa7T+aDxt0LYnB0jdftQ3M46MA92Zm70h1E0OPyzSV6saw5rX65Sv+muP5CYZHCIZqRqyMgBNQeMj5eozEa6poROxiPfZs9UZXow4LmSZYAyheRnvMfROJl8EWrvTzrMleO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=d+YQJkux; arc=fail smtp.client-ip=52.101.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="d+YQJkux"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOXyUuwLF9ueVedMdNSpC25qM+KO8/1JLOp9DMpa1iYHELxTR+MGcj4GK/pFGXccA5qYmvuDuTEbloOLLB7URaDT7K9D+tGSH0q87+xmhZgDX/b0q+o49A5eg6aLbG3FbORAPI2CJtAyZ+hEkrLIFQDBamIUUw7MdBAUcN/dRp/rIk9zYU9/9TCRbc4fwVuQeYAkR8l8YwXzin0AIwhx1NwdizT5keuEQTTuMR0RwOU29ci+KXCJRitGo+j0YwGrEVCtGb5YiPMbit5iF0u/o3Ap0yXxGPb/1Xpu0lEUM0B4u35zxxX5rzqfmgktTm804QfKqn8mIPjqqzx0W+gfjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ho3zx17XUk6Bcj30nHXf8pzBYtPEnPSweNLUf42VSSU=;
 b=CTJmzmVxsy1sVpukJ4dWqOoD5d+Metrj0HcC+wzXS7TWAqAjTQz+4MYnd3mRpQV7KAt0TGXWiJ43nrqkiCfrDrVy0hgZO+zkbLEBxOTkdm6uJeOsZOEtRsiCJU4bGNjwFWp99jOIzEiG8zRQjxbrcC2zQFUyi+/RH8Dv09FTBCOf/VdHIKpZmuUUs3oJZV4uTDNCxR6HKOnvhxwf6hkB434iGS0c4YYAKFgmBkUHEK6gdC0/Tq4fYCL14utdxAsm7EMg0JF5GmgycqCMkwvXS9SQR3SO2K3tmGsXiXrsr9eYhv7S53+fcL74g6RlUtHnaywwb6bzBDRs/7SHJMup7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho3zx17XUk6Bcj30nHXf8pzBYtPEnPSweNLUf42VSSU=;
 b=d+YQJkuxadzlGOLMgqhxrY6BSia0XIVbuPGyLGMmR0jqQkh7HdIiAWnM3ECo+FieadsHsLTrDGPNiWG9sHmoiBArtzpNVejWaXmEabt/6OEqvH8fJTi3REMcd05rklWO3SNkVnvFegCSg8fkiZEwRisyFVMpbOI+WHxbNQ9TZDA=
Received: from DU7P250CA0001.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::23)
 by AS8PR02MB10269.eurprd02.prod.outlook.com (2603:10a6:20b:631::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 08:21:50 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::22) by DU7P250CA0001.outlook.office365.com
 (2603:10a6:10:54f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Tue,
 15 Apr 2025 08:21:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 08:21:49 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 15 Apr
 2025 10:21:49 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 15 Apr 2025 10:21:49 +0200
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 7FD3918E
	for <iwd@lists.linux.dev>; Tue, 15 Apr 2025 10:21:49 +0200 (CEST)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 7B7CE287A5EA; Tue, 15 Apr 2025 10:21:49 +0200 (CEST)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Subject: [PATCH RFC 0/3] Improve roam scan strategy
Date: Tue, 15 Apr 2025 10:21:11 +0200
Message-ID: <20250415-roam-scan-improvements-v1-0-12827e086895@axis.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPcW/mcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0MT3aL8xFzd4uTEPN3M3IKi/LLU3NS8kmJdAyNDQ7Nk82QTM2NDJaD
 mgqLUtMwKsMHRSkFuzkqxtbUAX9c/f20AAAA=
X-Change-ID: 20250414-roam-scan-improvements-02116c7c4631
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F3:EE_|AS8PR02MB10269:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f94db90-4034-4b0d-d597-08dd7bf6921d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amNRanQxVWhTNGdkYXJmR1N0S0tEZHNqTFllUE00dW1OR3Z3cmtoMStOOVdm?=
 =?utf-8?B?VGt3VXVjS3pjQjdxeEZ5RktKcVZDSE81cnNQR2RBa0lRa21RR0c2RXQ4VTAr?=
 =?utf-8?B?cm1talFiUEJiODhOekIwT21ta1ZxcUVBY0ErM3lNVU9kM1FtSk9GL05BNzVW?=
 =?utf-8?B?aHpCc2tlNnptNnRsMGhUZkU2R2d2OW5zQWVITHk0cjVzdWRzMGdmTkt0cDA3?=
 =?utf-8?B?blAwaDN5M21uN0JWNVFvRVZwOVNrdXBTcjF4MXR4dWZYdy83eEdrV1EwYkpo?=
 =?utf-8?B?WHNFRWhmUzcya0VNdXFFMzFEQTlaa1JLS3ZZRXFpUEYwSHc4Rm1YQWRJS3JM?=
 =?utf-8?B?QkRtSXNXLy9jQi91NWhrY2duZWYxMFRNYlMvSFJPV0MwUTZnYUdrdW8wSWg0?=
 =?utf-8?B?WlZKblBPRVdGVnk1bS9BTEd3SnI1TktLSmNJcVBhZTNOaytaZFdOVThhUFFR?=
 =?utf-8?B?ZzZ5dGErazFEcFhJd1RwTHdwSmhkdDQzUEJWZXlOT2had0d4MjZOTHJRU29Q?=
 =?utf-8?B?TVNHaDRVbWZkT3NERkZoeGcxUis1R3hySlBBZmg0R0gzVTBaVG0yZkFoOWgy?=
 =?utf-8?B?WEhpUnZhNUhTOFJVSnhxQUZFcHNIbmhuTHREU3prMktzQjM2WnJkbUtCK2dh?=
 =?utf-8?B?Zms2WTdiNlR0SlIyNTEvQlZGQVVtWHFURHRiWEsrdzl3bzJmeWVwNm1xK09u?=
 =?utf-8?B?QU5WZW5zMlFwN016KzN4VFBuNTc2cXlpMm16bmZLbVR1SjlRVlVsNVdYZkRy?=
 =?utf-8?B?VEhKcTNzaEZNbDIrZFVOZUlLZ0xLZjNyaWIrTU1zYkJwQmRiWExFZjZlSjJE?=
 =?utf-8?B?L3ZNZ3E5NFR2U09JeW91THNRWmZxOVJYUHVKVHU2V0VyZjVzRXY5MFBENUlk?=
 =?utf-8?B?Wmk1L3RkcExHTGZHeWFqTTBzcHA0MlkyRnhxclVGS1JxcXRucUU5Vk83ampE?=
 =?utf-8?B?OCtxZHREcXhQSGkvczNUMFBtdDdiTHNGUWZCN0J0ZktIamtqWnQzOEVlalpM?=
 =?utf-8?B?VzVnNGUrVnFxUlZMYnVKWHprN2U4NFIrbXp1eW5VRUhzVjFRc1dCN2g5RHBr?=
 =?utf-8?B?dEdGdE8rMElLVEkrVzBPMGpFM1VoZDNKMWhPby9VRWxLTWdxODRDRHAyclNp?=
 =?utf-8?B?bGlTU2dnNHE4dkZSQkFwbzF5MVpONXp2ekV0QmZMbktvT3NXdEhaRlozQzdZ?=
 =?utf-8?B?bzFPNlJ2K1RRTTFGZ29jZDU5TVNCRkEzbFpiVnk5RjJ3TXVlbXR3cUlna1lC?=
 =?utf-8?B?clNKMkpsc3F1MW9JdWxBZ2N0L3VmeWhlKzBIblZBVmV6aGVxZVVzWmxYalBE?=
 =?utf-8?B?NzRma2ZLbnE5VGZUSTR5WU0vZDJNQ1duY25WY09GNFZiekNvck9JeTJNNTVy?=
 =?utf-8?B?bGNHT3BiSmNwcEc0MHB5bGVHSXJSY2tHVFU2UFJLYzlsMi90dTZyU2wzL3BD?=
 =?utf-8?B?YlN3ZFhrd244d2FacEhTVDMvZHArUXhIZDNISlA2TzZPM3NBUUdOV3d3bFhn?=
 =?utf-8?B?SGVGRzc1eFM1OXJmc3ZrWnhWMVIyK1R3UkFnc1lMU1d3WU1RZWtFK1dsNVNs?=
 =?utf-8?B?MFc3WmtoZGVhY1dLVnlVazArVWhwQ1h5WHZIYXVaeHMrekFzMUxQT0UzekhX?=
 =?utf-8?B?ZGNNZEZpcVdWZER2b21pUE1GeFBXNXV5QnlsNmFGQzQ4VEp6N2JUVC9Za1JM?=
 =?utf-8?B?a0NlODFJRjM4WTJPUVJCdHZtekR2MlhDTWFnMFV1Q1BEVGVRQ21xNDlhRGdW?=
 =?utf-8?B?QUpqRnhOcGEraXVBMEpiaHpTd1luY0ovK3JXNVB3aEVXazhDcVdqTjZPYlRM?=
 =?utf-8?B?NEF6T2JjK0Yrd1ErcGxuVmx3cUVBU1NGai94Y2RSc1RCUlc0eTA3N3lkWTRY?=
 =?utf-8?B?bjhrSnhzZGx1eEhBTkNHU1daS3ErUC9qVVNRSEIxYzBqZGNkcHdlR2VRd3JW?=
 =?utf-8?B?cDZHaWJIaUozV2lzcUxqWUV4YnB5ZmNCN0h6SldxQ200Qy9SeXVSM1ZHa29W?=
 =?utf-8?B?MDN3Mi9nZytOSUdsNk9tNUUwMlBOdE1QUTBoVDdkNnhLS21LUWFHZFB3VzdQ?=
 =?utf-8?Q?4Dw0u4?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 08:21:49.9609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f94db90-4034-4b0d-d597-08dd7bf6921d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB10269

These patches are WIP, I'm not submitting them for merging at this
point, but rather to start a discussion if this approach makes sense and
if it's a good addition to IWD.

My use case is livestreaming video while moving around a building, which
requires quickly finding a new BSS when the current one becomes weak.
The current behavior of scanning all frequencies at once takes too long
and is almost guaranteed to end up with a disconnection, resulting in
choppy livestreams.

The approach in these patches works a lot better for my use case, but
I'm unsure if it could cause issues for other use cases. I'd appreciate
any feedback or ideas!

Thanks,
Alexander

---
Alexander Ganslandt (3):
      util: add scan_freq_set_size function
      scan: add scan_freq_map
      station: improve roam scan strategy

 src/scan.c    |  36 +++++++++++
 src/scan.h    |   2 +
 src/station.c | 190 +++++++++++++++++++++++++++++++++++++++++++++-------------
 src/util.c    |  11 ++++
 src/util.h    |   1 +
 5 files changed, 199 insertions(+), 41 deletions(-)
---
base-commit: 7d5bcd738bb92cd33756985ffd2c4c67452a7f85
change-id: 20250414-roam-scan-improvements-02116c7c4631

Best regards,
-- 
Alexander Ganslandt <alexander.ganslandt@axis.com>

