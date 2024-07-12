Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2095.outbound.protection.outlook.com [40.92.18.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8B91C69A
	for <iwd@lists.linux.dev>; Fri, 12 Jul 2024 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720812743; cv=fail; b=TJqnejn7CN4zeWb3mtBNGEdzGUGqlN6w069uGzXsOI5iK9ck0tw47swKZztQkjHmnjQa9NNb4eLJ21SWxihRuoh2fsQoA2Wk/C22iwio2jFnGOnVSL9sLDCcfnm+osPZewYzmnUFiypNLEVMULy2qcsCIOvNYlygQGZ+/LzpEXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720812743; c=relaxed/simple;
	bh=WZ3oIdZkwU0xc7qJKcZ5KddVYr0cYX8D8t4+IN4CILs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XYwoTN1GlrGbsEwkXVaYvVyD/Gez/3vWF1v/Q0EEXDhA0Igg8iz7hnKZiGbM7Il2iEa+DKwdB45F9Y/VW4f6mjrvnSivDm+sUojvwNjA/+gA356KMnOGOCVjjmeg7qSeO+TsV7qHsCsMNas8L9N8Gus/3oV8PO8cPWlwP8mR9ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DQSFyBrd; arc=fail smtp.client-ip=40.92.18.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DQSFyBrd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOLVaarhnZdfWdcyhuBff4+trKdby4w1gpLAV+XEeX/H0/8qPi97yeGPNgHrM6PprAVbbZ5ZmHDtfG2omaptTbVENHgDq4k+1J9/d7XergnXDk0EJPj5PStOctOhT5QN0jjyXiqm06HxZ9mVOQU3Gx/pazgshIrbwefYcmG5u+eSJS1vNgkxZQtkHT3ufF4l77iB+zIl8uj5d/7e5L14yVrYrhEaNtltqT8xHmaacwllk6C53+1L87gcSneO9vD5wJTfGlqByW9xRGMnLSXhPJ9haHCamez2yElPTymaD/uBy0oHEj/jjvLg2N18AlF21AuLBk1/aA76K78iG3OhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imFygkZpd4qK2V2Otjxcz8Sy+FqE8WKuupeCq9Z/qsA=;
 b=GcX85nRzKw9RRAnnmxZGuGO4DZQ4gRFpTPYuDHl+KcB9OXtboT06P35a/nJwXdNqJvyby2Qru53OU4AiAVj5DYQ+LkKtqZDL0a2L4WlZvl0LTtLODghSEtn2aH3h/oODprV/JRxclXPHuy6jasvqoOOy7GbKiKdcYOr/qfw9/UQuZhsBcsjDxwH9u7jraPDuQz26tlYSSu+PBbnKIS923d7oGeUOjDGAIezXV2A7sGaRXuWYoQBLMGaQxwSYISDybowPEwgmUyCPBEn0S4VqJQ7QPYzfWWQPInzn9cYV/DHjKPf3l1zxgBGfUER6qBrJ50A20NFydsanZ05g+RgRRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imFygkZpd4qK2V2Otjxcz8Sy+FqE8WKuupeCq9Z/qsA=;
 b=DQSFyBrdPPxhP1aGn2HwC+sWdn9asFmWUe+7bl9z2kOKDixEBnaVyfaDUEQgrJSvCtCLP4TAX/cbRpDkT3FuGiFzL1FvRAQXg/h/v+Xu6N5eeHtwbXt11adE0lK9NE8oWjgeTPRPjMOJcJbZHE+5It2bIp3yZo8p5zLcHPy/EprZ16NuX88Wf9tNiwmuWeYwYaYr3y88N7no5YYZX2bra8O2eZ2WgzL6My844L1acUYbyDwU97MJ+lNkGozPPMMMyHxl+P65SwDV8gd9RJhYSF1tfR/87urqP3YlPb2Fv/iNoNPUEs6/rAYWwuv4j64JeA/uGdJ7CH5GBvtad0pAdA==
Received: from DM4PR14MB4880.namprd14.prod.outlook.com (2603:10b6:5:390::9) by
 BY5PR14MB3878.namprd14.prod.outlook.com (2603:10b6:a03:1d4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.8; Fri, 12 Jul
 2024 19:32:19 +0000
Received: from DM4PR14MB4880.namprd14.prod.outlook.com
 ([fe80::cab3:9377:6fa4:3de0]) by DM4PR14MB4880.namprd14.prod.outlook.com
 ([fe80::cab3:9377:6fa4:3de0%5]) with mapi id 15.20.7784.006; Fri, 12 Jul 2024
 19:32:19 +0000
From: Kasper Kantz <kasperkantz@outlook.com>
To: iwd@lists.linux.dev
Cc: Kasper Kantz <kasperkantz@outlook.com>
Subject: [PATCH] main: remove static from const strlen
Date: Fri, 12 Jul 2024 19:32:03 +0000
Message-ID:
 <DM4PR14MB488070291579BF883BDD0195A8A62@DM4PR14MB4880.namprd14.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [9M3FVdn85GCmKD+XtyHM1Ok73x3nneqF]
X-ClientProxiedBy: GV2PEPF00004533.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::35e) To DM4PR14MB4880.namprd14.prod.outlook.com
 (2603:10b6:5:390::9)
X-Microsoft-Original-Message-ID: <20240712193203.73-1-kasperkantz@outlook.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR14MB4880:EE_|BY5PR14MB3878:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff98c91-df05-4e34-bcc8-08dca2a957d3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	SzSWCXCtrIZ9cqIRXIta6Yd5sXdgzm2EH09O1wPylS4ZZdbnrDLpQl9cfb57Hhzep/1SnS0OHw7/musb5ufu9cafdYnDZx5km/e2OpHeD0GxRJLTBOnCAZ12IwxQSFDdCc1gceYjt+wrAkULU4K4iNTbIiK3xH88TBlLOqRPKBvGzUj6ZI6hjiOOwR+QE53oUNS5ynL2yljoWwvUd1WjFy93xtCOf8MLFsiTADTyW8AqadAzcUUjn5jGhPh4BRYr0XE6Ul7FA1SF3alThl8JJLw3SbzO+MTn142PvXAmAsmBeUbG1Zwsl9CmuWh68PG1KlAvL6jSJ7sWKfyh1IJgC8MBcMxtRYAleAFL/4mMudLvR/ZDMNr1AI8oBqs85tGMb0LMS1sj+Jw5zLdfB46hyctuPE4C9x+5kRhzEc/5HdQ6HkjJdm7ZtxdV9BCO7mDnfKAZQqiRovPPzeVbwwRA+B4KyvKU0QOSvOeOoDM8sj6YGxSQ66Up1fU7Jwd5ycoGivIxXr1Ke5rz1eeDnFzwIgBqSaJiNe7phY5z/TQcwJhg8s2eBMpyVmPsI3gp9YfcaOdppPyrrWNSCU49905GXUisijXNgZTBZYW5LBoZnHJbeU3cxtgXa8FrYtV+3YAuZj2jb8riDFJtbijFKM4WVNudAufRhqjrZhPg9fofeiHeRozyfCEMxoA6Ew5Pu59J
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XdES1ci9F1c+yiWl8sZoNzpaJja0PThClE14alYESL35O5n9lcnOCTeuoYq9?=
 =?us-ascii?Q?LM5Y6kUbadiLSarZdjpWqVJKznOvmxnMejdur2Y/0TxQjZ/EGF1Lmg08Xl0F?=
 =?us-ascii?Q?nyMjURAqjpxisBdtuD08ThVRU2MZOEXRYI2kRjDnsTkXKBUVfFOgyp5twVbg?=
 =?us-ascii?Q?9krsZb1WLn4UK9Zds0OmlSodS2vDPFGRPM/kcrgNAXLhnVIpIe0Hvqk67Od8?=
 =?us-ascii?Q?fwLmu7rJbFLojmnnID7YvDJtbUeGErvmbKPOF9VH/XZOk26uDGqjD8MLmlKN?=
 =?us-ascii?Q?BQ7oasqhORU1kSqI3IkRqfL+laeJIGU+YtoG5kbU9DHYVPQgSETlgaZ9UICZ?=
 =?us-ascii?Q?rr3RDYb2+WXUHPIQraNKQh4nSDFhYPLHFCI6kY1vzOYDXpvE2smNgvPM6idb?=
 =?us-ascii?Q?UuvWgArb6SyEWNyuXE3h4gYR3SF+r+lVHlJSIhIhk/2Neh2flSnWOOReTRCk?=
 =?us-ascii?Q?n4G18oW+c+xLHQTzcveDlYg8xCzmZHJ6Pss7pOSfI86hwP8OC3/e9KD5stoE?=
 =?us-ascii?Q?fsb3COJO2TP3eoM2L6nLlN3hDyWC+9Jqdj9KZAfu6g6SjW0seNmLu/+hp48e?=
 =?us-ascii?Q?zvP4kiaKgeadr18cy2LCeqpFNjGgOuiPZIl/KQJQW+R0Rdq1XwGIi2htCQOD?=
 =?us-ascii?Q?x9UKy1GolK0mca1OE2ko8ghqMbTjfX/GewFA8YOeZkeMBPW8DF+DhrJOBQM1?=
 =?us-ascii?Q?LGxKFy8HlaLqsZGsXs/0piaXZ0mwawefHAnASuJqHsJhRgZxtS6Hb0NuFOsP?=
 =?us-ascii?Q?XgCGCywm1Qmv4jikgYw70+WGULIfN16zZqn1m/gb7inEB0zvHaj7AmIji2pD?=
 =?us-ascii?Q?xrInVyol3QSFW17gLanUfxWn9F7Nk9cErdnX/iOsjA9ymyngIlM0I43WmsNn?=
 =?us-ascii?Q?Q/kFU7rGo1af01H66shtK0J2D7O7pCkFuPSREb/ktJEshB+SJtmOSK6sontM?=
 =?us-ascii?Q?neVhcfQReZ/7qzrfInvogQwRpT46dIhW//DadaOTCcJXLqyklwzaWFRSHbqA?=
 =?us-ascii?Q?vV4/UU6hfauWNKiKptiyLgzzi2FI+DZkSlSm7YA4LYcFm8o/9XVoGXb4+1qW?=
 =?us-ascii?Q?ZyRbBfcKXNvI8/Tkk3lFp1LfE+a/teujcOmyz2lm7Ill+y2JRfMg8/g5W70+?=
 =?us-ascii?Q?oVIMAU47QcFtMy75IR7wSEPb1uIlGvpoXD+R/iPxjQHp5adX/UbEZHWT7upq?=
 =?us-ascii?Q?fX6yp7TCRMCHS/yJgZV5dQtNn1xd1mOPuPQo1WWZQ199jTeBlQArrdGFqN5s?=
 =?us-ascii?Q?Ygo3L0yrWZyFPfMj0qX1?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff98c91-df05-4e34-bcc8-08dca2a957d3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR14MB4880.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 19:32:19.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR14MB3878

 src/p2putil.c: In function 'p2p_get_random_string':
 src/p2putil.c:2641:37: error: initializer element is not constant     2641 |
        static const int set_size = strlen(CHARSET);         |
                     ^~~~~~
---
 src/p2putil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/p2putil.c b/src/p2putil.c
index d1f114d0..ef0f988c 100644
--- a/src/p2putil.c
+++ b/src/p2putil.c
@@ -2638,7 +2638,7 @@ void p2p_get_random_string(char *buf, size_t len)
 {
 #define CHARSET "ABCDEFGHIJKLMNOPQRSTUVWXYZ" "abcdefghijklmnopqrstuvwxyz" \
 		"0123456789"
-	static const int set_size = strlen(CHARSET);
+	const int set_size = strlen(CHARSET);
 
 	l_getrandom(buf, len);
 
-- 
2.45.2

