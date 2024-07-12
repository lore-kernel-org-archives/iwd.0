Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2012.outbound.protection.outlook.com [40.92.21.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3FE9460
	for <iwd@lists.linux.dev>; Fri, 12 Jul 2024 02:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720751485; cv=fail; b=b0Pa+DS2PmPOPXwZQjukeLemu+bMT7xl7y2IsdE+lkwLazGjqEWhAr19SItJXPIojgwt4lOz9d2EcZhGX5/7Bvve2Lf0ckwZ7c9/4wb7BB1BeEw/+uuClDPv0kDIBdNZzHKd5saxxY1dqo8Jq/jB1TjNEbI3Fe+Vxzvq6VeSWXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720751485; c=relaxed/simple;
	bh=XmvpNLWCZd3E6zCAo6eoP6lvVUHXic710UiKLfbo7xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ILpxtRfZsU7k69MrNJU/AS60z04Nu9cQzCenyCXBB27+e/HNIv4HstUI8hXYGrqTb8/bfAFxaCLsVq+yDLvw7atfnmeFxOcbnunNBV3QMH6c4KAR3lhaOz3YTW789OnTSSEOKty6cdQxn3zojZKfaWNiWZnk1OK75GrrPpqInlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OUZwGHiy; arc=fail smtp.client-ip=40.92.21.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OUZwGHiy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdmacJLimOS8NipsVBdCe4ZbF21iYK6Msqg5qROuxR1EtESSW9toDnZ3eJkSY3b4Gt1pFK94gHjiKc3LaVnqWqAPHRsFTxN7SF+gXPgMZy4jMHdFOuwCD/nEfMbuPv4WPiBz00Wnw6HPj+dAS+PlSbrWvMr87HsxLh3iDx8MnWbS8TIYmPZL0LaSoSuXCuEROuIBvQ1zZPkZYksP2cdV+YWlBi13juIPGi4dNgYHTax/B1W3eLT6ZIsZvgt4QMmeQfF0tni4YyO4EPa+aJ04nmIwhHU+lqQBAm7i65vUMsOkd3qtGaItDproWGF0kKP8p4EuoRO09edmTj8E3PHElg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKPd3PcxpSyYD4EnMFzRgHimlk+p9HYPrSu9nC/cgkA=;
 b=Jc+Uj9NTzY6mGYRv5NKQ4G54mBt8UwxT+f1rHLyRA4QXpuIENxewhMQoXC/xp1h9ez7vUtSQtNM0fS+m4EpnfIAEiqPYciuOgdloxkJGZkIhWWu4NakgVB0MwHYjmxq4/yhn3f+zTjnxMC+9fPvoiXgtXCpO+5PzWepk66E72fBXupeYzZp7WNERODSPeOGqCqeGEPx2ua3Z+eeCp0JQbmc3CIdqS3/hbJNCBB17bWWXRna8NjFOuDCbX7w854W0KzO8l+o/8jSclyELPjwUd6ShGBMAl0iYIBEJK0xK7410u1HTx1eAsGuqQtBiGtvbquaSPKK14bEAI6xfHjnUbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKPd3PcxpSyYD4EnMFzRgHimlk+p9HYPrSu9nC/cgkA=;
 b=OUZwGHiyFRnFZoHtOTnJZV6aj+qRoZIUP+7zgk8+5jG4nOgUVSvIDNpH7v5nzvlyUktbLWnJ5T3xdQ0v0h3uk7euUz2eUcPxgeWvCtpI4pliPxBNLU8RZbJcL02Cgu+38t2AW2CnfX2tz2qfdeC2xhNqMheptBQCi/sK316B60YsdOJzgslPTKFD9Nl6euq3uxfwW593CnSV2cZZ82t8dHRzCfq+78iurZbIllMa/xoW5HFja1EZ1r2clgdX+XHg+2Mi6b8VVmR3kkGoNkRCsmvcvbL4bTDKCPz/tDWxFNmL4SkMHJKhxXZ/hNHlhzKuNUBNFTtPOtrdgFyFm/ziiw==
Received: from DM4PR14MB4880.namprd14.prod.outlook.com (2603:10b6:5:390::9) by
 BY1PR14MB7008.namprd14.prod.outlook.com (2603:10b6:a03:531::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.20; Fri, 12 Jul 2024 02:31:20 +0000
Received: from DM4PR14MB4880.namprd14.prod.outlook.com
 ([fe80::cab3:9377:6fa4:3de0]) by DM4PR14MB4880.namprd14.prod.outlook.com
 ([fe80::cab3:9377:6fa4:3de0%5]) with mapi id 15.20.7784.005; Fri, 12 Jul 2024
 02:31:20 +0000
From: kasper <kasperkantz@outlook.com>
To: kasperkantz@outlook.com
Cc: iwd@lists.linux.dev
Subject: [PATCH] [PATCH] main: remove static from const strlen     src/p2putil.c: In function 'p2p_get_random_string':     src/p2putil.c:2641:37: error: initializer element is not constant     2641 |  static const int set_size = strlen(CHARSET);         |                 ^~~~~~
Date: Fri, 12 Jul 2024 02:30:59 +0000
Message-ID:
 <DM4PR14MB4880E9DA5E6C6A287EB85E77A8A62@DM4PR14MB4880.namprd14.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <DM4PR14MB4880D5598D181E5FE126C54BA7A62@DM4PR14MB4880.namprd14.prod.outlook.com>
References: <DM4PR14MB4880D5598D181E5FE126C54BA7A62@DM4PR14MB4880.namprd14.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [BJEMCGZb41JyZ1Xv9uXZgHEfIKTznWSh]
X-ClientProxiedBy: GV3PEPF00002BB1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:1f) To DM4PR14MB4880.namprd14.prod.outlook.com
 (2603:10b6:5:390::9)
X-Microsoft-Original-Message-ID: <20240712023059.58-1-kasperkantz@outlook.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR14MB4880:EE_|BY1PR14MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e65a0bb-a826-4beb-d80b-08dca21ab6af
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	uaUpWQWUqpkbBlNtU4fKEyjUJ5Upx8hvS7GpMbzbc5V5EzkPkJvA0Cwy5WSgzqXNbCHdUMOkadqTW8su1heVPElv55yOQQE6fOMCMqbRWPr52oVsx4GaRcV8JPm51vWL/cAXzg5r3BLxnn21jqF2N0x5PdBWgVpdwHP4OZZQqvFyllwVlyhVt6mj4tu/gmJ7ZJuqUTkhH7dKJEoOp+sXir+P9CLEzzKHpYAfa0ucjhxkMO5s7jhwQkxjqdbRp2muLztSzFlvFJsFiYieiRFywzlBoJrCjw4OSDM2+8ukoTIC7Aeu87GFF2XuC6iEXkSgumlx+LXVwYHCa/7gCdp40KZqCe3V9qJ0mus2k+ihAOho2KpcVnhqC8i7OwpywH+b2qHCrhRn3Dot1s4/NOx5BVuyLgmIyM5Z7+WjqJeqpqFa0bDJrMV+R1QLjdeCDSE7VBOJEz0NWnqOHsdYb6kaa/y0GsZCCrMJ5+zQ1S42vu7BS2+zeCKe9Z5L7RWMdQWDGNT/gc9N0I8d3KDI0+zcHrXR2TqdOdo9Y7FnVqNo7l8MLi2sWFntjoOBt27WDftQRtyEpaQiKAzoYdr062ebMWrwtNU4WBPR3UjAizrXQzc4SpbvL8OqE+V6Af4Bqvci2VtSQmN6H6fkuvOEDz41kqvuKmjJPRnrzT9o7q1lTkN5mCjKOr4UmwAKKj3X8RTp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ar3QBtYUkvAuhRhK8x5ZfAyCS3BT17YWBJ+N2/zcbCTLP+mzgYpM0tcztzy6?=
 =?us-ascii?Q?TUHgls0R/S3PosVxXek2iT527Kwlh4F88HIWEzXvwTszhshtSgYqz+zcJlWC?=
 =?us-ascii?Q?ysCz3wz5VX5C7VixruFgSB0jz/JJFnKU+fFGQ/JZJXFn3HKVwseoAK63NBlr?=
 =?us-ascii?Q?8p6QC6Ox66fHMJAKJ5etVpm8SgpPjiYbe/ghcihGqsz4MZrnYycF75vYPHFr?=
 =?us-ascii?Q?CBVjtzGrmyEtL12l2Ncxgc45tCPquv03Zyd1VdGsO3ovj/Cd6phGxgofJDj0?=
 =?us-ascii?Q?Yz09pillEtZSh+QuYXlRDhMkzi7wOv+d4vrCh99KrO0XwhCSdGqguwhYydA7?=
 =?us-ascii?Q?kIhipiW1pYKefvtauEjZD8RR03zyXgq0OzYMzQaNECBQ0MW6VZgtzMkIoBnp?=
 =?us-ascii?Q?aGHW/ESLYfy+ZKw5PU955TlcDaY0bJETywdeDML9XgOY7LfyVvs2n9RWms47?=
 =?us-ascii?Q?e6xSBSwzRvESREepWBQiud+uH0CI+1D3wC5LdWd1xE1z6xB09AaFLAEz7AT7?=
 =?us-ascii?Q?PdmKJ5xFD2sPScxoP6HQpyNKS2pK7NiojHp1K5RiOAWFMIYFdiSCq7VAt0qM?=
 =?us-ascii?Q?GnopgAK13m09xVYZtKmABQNDmNqfr93nq07dReDsGx+y9uAkXAvQCZLW+cHl?=
 =?us-ascii?Q?yA9vQdh0bNzO8XcSYVC9w01y+dd5rnlouM0Pi/cud316031lvxsHhg7G+se9?=
 =?us-ascii?Q?TiFmiQ7z6VlvK+vICaPAXM4dgAbrcF3GvbGuAPMJvQlKqNeJZZGIIeY6hejY?=
 =?us-ascii?Q?S+BDhtf0+RNzClsKRguNUchesoGZJbEV7hw4noC+AxWeeXHtHh/8otDdDI5E?=
 =?us-ascii?Q?ZvtqRGlOw91B/I/U3D3seSO+JEHi1q/WR0hh5B0myHuers6KO33j2jrB3g/i?=
 =?us-ascii?Q?a1wFuvNYPTTTWJ5dkA0MCAn7KFsAIZkojvLhDfoLNOTk4F2yYbXei8AuA2jO?=
 =?us-ascii?Q?LlHkSxq1isON3Hti5VDIWReQEevQZ9+e7KVhGB2rNMwZNlOWbMa9Aq8AHrkE?=
 =?us-ascii?Q?OUFPS8NpQorZ//Ht02nP2mtx964z9v9aSt65CdpRHx0nUqpc8DgRIOHQ+1IO?=
 =?us-ascii?Q?uF6e+pDk7thA17PJDguCSnEd2CuJsNROoCgZioPDdLAbJig0FflgYw1rFB/z?=
 =?us-ascii?Q?iIfb9fyuyoZUoJD/PaeTrT+O2hqiSXDSi0oMLYGCpb0Il8+KTuspb2aMgkWA?=
 =?us-ascii?Q?RRh0f23raMATrrdNiNmZet7nqbFwPygwyBdplQtW+4LieSmyoa3wV2vS3aQB?=
 =?us-ascii?Q?QA4sFwvZuB1zFi0ev6Db?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e65a0bb-a826-4beb-d80b-08dca21ab6af
X-MS-Exchange-CrossTenant-AuthSource: DM4PR14MB4880.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 02:31:20.2277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR14MB7008

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

