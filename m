Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011060.outbound.protection.outlook.com [40.107.130.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693272DF70E
	for <iwd@lists.linux.dev>; Fri, 12 Sep 2025 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671770; cv=fail; b=nvMYFGhFlyz/txgHQU0uYrqMUcQdyaeSsiN7af/tndbx5dZdeh42Gn+zIDlwvgxdPkMpwrp319+tXL0c6pWLBdJXL9AAB7TRhG5W+TbYfP7H8ypQfyxOte4Nmh2JloHxt7098C/9PeB0f/B2Bhj/EYKZvcIlYe4/at9eGXG6Q98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671770; c=relaxed/simple;
	bh=Lew8A5PFcGdeZya9hVaJBJGdU8aq+7G2+DNf/uuqNkk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To; b=A/AOHce1nUgHnFULAseuifaOjvlt5k1mbo2C1JQ0DTokOMRb4VRAZr7wQhD8KEMh7Ad1VwpTghSR59tBYDetq90ZMvX4ZooI8TbMEo5urG/LMBEGSVIQzYA5ysCtCQptnuzM0dgCtDD0VqHSBib7XVw8jzKUqlcWhJAKe28+kx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=eKNpjVaj; arc=fail smtp.client-ip=40.107.130.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="eKNpjVaj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWv5qF5zhmF6RsKll6G2Dy7tefi/uPppnAl6vDecqE/knBQZL8UXkY+PelwCsgAk+Z9kSh/2myoBiIwmHswiLstSyqEbNeoKeSzglUX787/Rp+Q7GqjbU33PaPbEusk7gSXTi2sLY4ZEOLuvwdYUe8XCey+rxVhWKMqc6LFb0THihLIYhA3rb+PFQzwpP6XjsdA4a2FyojGTmcqrVbMHzB8IwvXiQi087RyawNQ/lU4mTp8luwJVhvDWk/UZvmB5J7xxuqrwvt7krI8Er9Nl0tGoD6pdkXLxSu2r2Qh8M2u7JJ2oPqPUI3N8NTtuQ8zX2fhy9/Hn92zGVLDV6BW2gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiYOymsEK+3lWaPjmINk3jxID4s/iuZi10x/DRNiV0E=;
 b=x/GmCpcyuz3W2jqk9VtqJFlmVNSa7f0LSyWkFZ6HHCIUMttlDJzec5uaFm3IxLe+PoboIsF/4Ouxj40tS3i9UYZAn5cL1IX22sF4pnProKXEExtZ2r7ckFTJzibLgNlffdPNx/J4L2qSeuMGpIde09mKgqattsTWIbXm5F6iSetA08rmZ/Jlm911aCs7+Q9xLVyrKsFbrMq6V6sPkjPhkCQwmjGGSLXThs2VDS4r6IncySz8mWAU/twZvUhakC9X4Mk26qF/lUT6UI/MZAkskfyBm/d4y+QnOEw49gj9u0wKT2OeIVS6ySkJygOwFP/4weylXm5Tl+9l5vw9XaMOFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiYOymsEK+3lWaPjmINk3jxID4s/iuZi10x/DRNiV0E=;
 b=eKNpjVajbZ5rgwtuGc/FucQLMqSLehbeLla8w/7/y1A6b8IzCvq5lvUwRxL0DxpexyIO84QLd4qBbkd2rmhrFNshE6km4f5htGhx/6UItV5wKXtiwSdQkcVyOYcfto69yO5+RqsGhifLSgXmWUNQLJMb5lYfJsQv/27KyPq0oRQ=
Received: from DUZPR01CA0275.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::6) by AM9PR02MB6547.eurprd02.prod.outlook.com
 (2603:10a6:20b:2cc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:09:23 +0000
Received: from DB5PEPF00014B8E.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::b) by DUZPR01CA0275.outlook.office365.com
 (2603:10a6:10:4b9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 10:09:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B8E.mail.protection.outlook.com (10.167.8.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:09:22 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Fri, 12 Sep
 2025 12:09:22 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Fri, 12 Sep
 2025 12:09:22 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Sep 2025 12:09:22 +0200
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 0C4F41BC9
	for <iwd@lists.linux.dev>; Fri, 12 Sep 2025 12:09:22 +0200 (CEST)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 11656287A5DE; Fri, 12 Sep 2025 12:09:22 +0200 (CEST)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Subject: [PATCH v3 0/3] Improve roam scan strategy
Date: Fri, 12 Sep 2025 12:08:50 +0200
Message-ID: <20250912-roam-scan-improvements-v3-0-ebfd61dc6239@axis.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADLxw2gC/3XNQQ6CMBCF4auQrq1pByjVlfcwLkoZZRalpCUNh
 nB3C4nRDcv/JfPNwiIGwsiuxcICJorkhxzlqWC2N8MLOXW5GQioRSUrHrxxPFozcHJj8AkdDlP
 kAqRUtrGVKiXLx2PAJ807fH/k7ilOPrz3P0lu65esj8gkueASNDQotNKX+mZmimfrHdvEBD9Fw
 +VQgaxora1q264rpfhT1nX9AJBNYP0BAQAA
X-Change-ID: 20250414-roam-scan-improvements-02116c7c4631
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8E:EE_|AM9PR02MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: c526ebeb-2606-4c61-48e5-08ddf1e47262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azlWd1FvcE9jaEJtTTNDSmhIYXh3bTJPVkxrV2MydXl2WGxaRTBnM2d5L1dl?=
 =?utf-8?B?cjhkZ0NMS0pkdEtsT25UeFdJeDl6OTB1bmY0SG1tNzc3NEF2bVdXQ3F6eWZR?=
 =?utf-8?B?N2RmL0ZDV29ucmp3dXpDQlRRVmVacHo1VE96WEVPUERRMTJoL01PMGN0Y1Fm?=
 =?utf-8?B?K2tZRGNsaTZPZkFlVGlxVXRUTmtPWXk0VDF2MkRGYlJNK3Y3M1VZYzNIUGxj?=
 =?utf-8?B?eFlocnVHZ0w2V1JST1l4VnE1ZHZEZ0hPdEV0ZVFCQ3kwTmJjdUxNZ3podVZa?=
 =?utf-8?B?SGh6aG1uMUpwWDEwaWVIMHhVdTdBb1MxbGZQVml6QldBWmFjRFVxejNUdG50?=
 =?utf-8?B?MzBSM1pkN0NqZVhOaDVYTXRYRFdHM1EwSjFBb0pLNEVZc1VLL256SnJUK3hu?=
 =?utf-8?B?bnJTcjNVR3RvOUQwTm5yQ1B6UGRDV3RFNDhPeXNMclZFZFhiM0cyUXpncEp0?=
 =?utf-8?B?bktjcHM4dUpUSXZYSmVuMTdpSHdzMDF6SVFaaE1aU3NPV2c3bmxDbG1LMjM3?=
 =?utf-8?B?Qi8wSW9Db3cyU0FzK3dKV0JiSTBpOGE5Y3c5L2lYem1ma1cvaEJBV3Ivd3E2?=
 =?utf-8?B?ZkV2NFBvYkVhOUxVVXY1WWlvbGlQOFhZQXB6Mmd2U1V3Qk9qSEdkaVE4MmQ1?=
 =?utf-8?B?MHZWZjdvQjJDaWIwNVJWM0dKT1RhVVNJTHZJc3pNVUs0ckZ6S1ZxZFdna2Ew?=
 =?utf-8?B?ZTY0Y2FoVDdRbmdOdTNrMXJyQTR2MlB2UTFJU0JNZnpNSXczNUQwY1BNbDZX?=
 =?utf-8?B?QndkMy9Ham5neTBYTWduZm45VEVEWU9iRnZBVHc1MmFQajFpVDVFUjdGdWhq?=
 =?utf-8?B?Zy8xd1ZlUTVqbzdQYkwxT3N4bkhOQ21xREJRY1BtbFV4WDJZRnZnSjN1Ykx1?=
 =?utf-8?B?MHVmRjZqdWh6eHBtbFFzRUp0dHA0cTN3MGMwQjdYQWdXTzNJNEdubFJuRkg0?=
 =?utf-8?B?aVh1UEIraUwxd1p0RnpvSWtBekR5WERTRjNmaVFiOUE4QVM0akF6a0luQ2Z2?=
 =?utf-8?B?YjVkYzl5NnFLMWQ1aG5WUG9zMy9GQ1NJWjIwYXVoK1o4TkNJa1pUcC9id2dI?=
 =?utf-8?B?ZG8xZ2VDcTB6NGhtN0prR0hodXRTKzVvNTBWNmJQN0FoTHBCdG5nKzljdnV5?=
 =?utf-8?B?N2NDNWNtOXpLYTlCUm9leDZuNzBhdEZlMEZ2SlFuSFNvQnd4RzMydmdlT1Fs?=
 =?utf-8?B?VnBtcEp2TDBqVlhCbmRnS3FLSmhRSUh2M1NXVStvalhUaTVheU1BRzlUaGxp?=
 =?utf-8?B?Y1poYkJHa1p4ZEU1WG5MWlRHemhkdnNtTmMxbStPTW0zd0NYS1FNV3pMMms5?=
 =?utf-8?B?bnVJeWpIV1R3b3dDVmhqSUV4ZzZ6ZUlrUDhnYUtQWjRNd3dvNm50RzFnUWtW?=
 =?utf-8?B?MnRLWU1pL21UdkVoWVhTYUUvNE1sMTgxcTFXYzdWZFJMcmpFZkJGTEdGcFJi?=
 =?utf-8?B?S3M2c0JYYTVYaHltRmxKMk5uS01EeThsdVc5SEI4VC9RN1QzN2pobjN1enFa?=
 =?utf-8?B?WUlsakVWK05BWENVQjFYQk9jOE8rWjBueGdMQjk0KytrTmFJeW9UV2Y3TlNV?=
 =?utf-8?B?T1A0T3lWM215QnJTbENYUDFOcENoUTlYY2dwdU9KNzBnM3ZrVUxUM0dzejQx?=
 =?utf-8?B?Z09DY3ZIdXRHRlE5WHA0eVEydmlKU3ErRHVHRDcxd1lCb3c1aXlCL2xYNEg4?=
 =?utf-8?B?ZTM1U25rN2s5Wk04ZE9JbUxPTzdDN1pFSS9qS2ZMVmdwb0x2ay9veG5qMTlD?=
 =?utf-8?B?MmJFdUZpVzhKMTVlTys2dTF3OE8zSGtXQ1ExZ2FrdkJOL2dNT1FkK3NIS254?=
 =?utf-8?B?eTVlcVB1UGNHZlVla2VWMGFxSThqZVZZYW9BWTU3bHV5WVdLSTlhUGNCTmFw?=
 =?utf-8?B?TjE1enRBSGFNU0hXZnBNS050bmZoQ0hiS290NVVOMmRMYVIwOVRaNWtvZFll?=
 =?utf-8?B?SnBvc0xwcVpEdWJCbVFmUU1pSVRadGZwb2tQZ3p5UkxCSUk1MDZpamRzc1Fn?=
 =?utf-8?B?OVJGMzg4UXdpSE9GcDFaNFpUbnRMbGZjQXZhQUlTNVNYWXBsNGxRTFlQOGRl?=
 =?utf-8?Q?Ls5k9J?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:09:22.9830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c526ebeb-2606-4c61-48e5-08ddf1e47262
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6547

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

