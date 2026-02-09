Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazon11021101.outbound.protection.outlook.com [40.107.39.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA927AC4D
	for <iwd@lists.linux.dev>; Mon,  9 Feb 2026 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.39.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670796; cv=fail; b=F5YYegCGYk+/c6s6LRIzOGUQ7DKAVBYSWKTxJxxv0K6E37GqcvTmTpM2QhOhpc+HJePdDOkqtp3LmMNcM47c5rkCdgRSwNj4Za1sol8endUqz1nUng7wvKnecyYRgqsGEeL1qYUKqxcBdeOcOROQ3MO30sTVxOQQB3fm3gIzcsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670796; c=relaxed/simple;
	bh=ylFWYfw43tWatL+yri7Menn8g++STSjqGpLlRK3t1e4=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=I/q363zU3U/lTIQZdEkCrVX7aNFB1TXArW4to3IH7+QnrU6M3ayTgpdLBFUq8GpSNDuq6ghDrF5BaOo3H9N0WdHVMAM3qKwQr/wpMuxBUso1i1E9QaNNGOjAeqNXI8jQ3QBFWj9xavhDDOjAj7/C5QOMvpnUV56HugrM5nieiAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; arc=fail smtp.client-ip=40.107.39.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+woCv4qddt4cw0Di6YbuQzZPIm32o5Gefk57o3d6SJIxItzcFotKVx4VCGFSADGllpnjnNsmE7cZxRcozVEW6x2k+BP7qO5MWAHCKcDyuW5b1AAjJypomTv0FtwBLMkk2Pz5ZcU1IB7MRyzvNDPuyfGUBMeTeqpH1j0lLEMv5x0rwonf+VlRRrlrWwTMfEJ7Cobb/nFHJapMaiKjtVeQJLeWnN/3OJ8IU+BODq2DuLa0JmWSIPlDGTmRReNRvRBCJXfr6+Wbvf/f5E+LH5IGhQ+jB8+5rHP9oGOtLXBLQ+Wp1qinNJwtbdirHiK8uG38o2/Zrr73ZzH8y0lY1sjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAeEbFTB5D77r/mwwZ5fISIUq/Rd48fTRq7Ydm6eHtE=;
 b=md8l9/5WGWQfktXUe8DIcfWMWNWxcGmjJbdWd949KCdNXpho+/f+4q6uDSvixikFas+AJFJsfkKF/snELG/4J5jC6gyGwR2/Ql+uTyr3XL+jguhQNK8bStm4YerG6g5wTdgtgbPh9D1h6OVKZCFsHButRdOCAj0HcLy9M1THGQRTH/iFwDEi3Q1Wn97LC0zgmbY/cL/Hhuh3RjFAL7cpYKWUqTtJuNl5o6i/Csudai9wH3w51Af4cULlPFfjxNsqPQEPMkNI7UpA63A+DccAx+G1rQx8tkKEK1ikysfmmCj6qsGDbf0BaOUTXGm1e3MXowVTpoQD1/GuG1BcTFye2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:73::13) by
 ME0P282MB5294.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:23e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.19; Mon, 9 Feb 2026 20:59:48 +0000
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f]) by SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 20:59:48 +0000
Date: Mon, 9 Feb 2026 20:59:33 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: iwd@lists.linux.dev
Cc: rudi@heitbaum.com
Subject: Bug with iwd-3.11 - const char being modified
Message-ID: <aYpKtVUTo2QHYCT4@ca26aaf82ac7>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ME3P282CA0177.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1cb::16) To SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:73::13)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYYP282MB0960:EE_|ME0P282MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a61c1d3-4238-4dd8-20a5-08de681e28b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bigYcUyzBv22cL7ojej+vGzJO2dp365TjDIMLVynSc4CXzgoguDx/NhXMWz6?=
 =?us-ascii?Q?/zXkAfIAf3Kqyb1ivDD+oEdTMBhEMPrG60n25X2PpUkT1etxk16dgezd8j3p?=
 =?us-ascii?Q?fx3C+J6S+Xsb5sUrTxARTO4ukaqnl2mVdvoxSrUhM/8t8FE016lQcwIfBAT/?=
 =?us-ascii?Q?myDV7qPDUu5/qqBeGdE0q09M+i8Y+8QVjSKL1LShMyIvExbYjZCkZO+mJ4En?=
 =?us-ascii?Q?XHlimk23gSvMvP+ChavdxpPgUN8ANLZsXqZRcf4X67BPY0DRquBjFAJgq8u0?=
 =?us-ascii?Q?WnZulgbqeKX5opwVuLUlU2bg46bRbOOQmQX92sm9xt9RfgEq4OZeAgVvR2lW?=
 =?us-ascii?Q?/GRa36o8mxqDpLBeYqrQ6cU6zBAOQ3qxiwUFtMEBpXDYpXLXlDN+C7+svOnj?=
 =?us-ascii?Q?nCjTAn18AVM0IfvKsPk54AD+wcZy/3+NxlJoLyNTF06oeT8wrW3nBFvmZgqr?=
 =?us-ascii?Q?Th95Ub00FJgwLbw6yz2hcOJaj6i0TDO+PXuUxG5tF+8CQI+RbtRojT/wm/Eq?=
 =?us-ascii?Q?bIjuiaEzowQSHSR8TY95KRBP1HPl4HoSRP2HqpW4MwlrSfipBHtjRYyKHcIT?=
 =?us-ascii?Q?Iv8RDDXGV9WJaRLlGWWpW7yDda6FI8MtcqkOlpjicfQgNPREtnKDbAH/us/H?=
 =?us-ascii?Q?ZfS/Val5Bs30G2zE8ZcXJYyzlXgrkRmmpweLi0NsVc/fUvXdN/ftgoBousol?=
 =?us-ascii?Q?jCwzg1fqxdV4NjXST0jIiWkP9ePyCXn4w+oIZPgkW7PtdWTQRAoOgYkEPzA/?=
 =?us-ascii?Q?OvQ4RHAgsZGBYC7yrLtQ/UrcdYow45oxO41Rie/vqiqTV3L2zZ8Meb1PjkFx?=
 =?us-ascii?Q?TfNIks8fJ6afV+GcS22wu7TfpX3cAR6SgyGubfzuKf9ZPruFzJqWvwotOMk/?=
 =?us-ascii?Q?yXTCe29B9OxtXzoAdbovueyMi48Ywlm21O661eskwseMymG7di/prckHovxy?=
 =?us-ascii?Q?AegoU97XyyTvpGpk/HQXKo/Uw9i5BDUtSTxsLffYQdK5FneSgp8fdKeXsUQn?=
 =?us-ascii?Q?V0J45DjtPw5bYjhK3iUgPYaECjczLaHm1pI1tVTiIrezc7S3thtzUEZvxDyA?=
 =?us-ascii?Q?8+H80Sk1Zovn+QmhzmCMfB5x1mfExQnrOrJ6Y3PgWGA/nA2KKb7DoltDqre2?=
 =?us-ascii?Q?a/qyFXwlYv60NlIfec48OHgD7vlSwcAE6dM+t9HtwuDMLVpcwFgAoPrmWb8R?=
 =?us-ascii?Q?4S1g6LIrsi1t6r0TqaiSMrkSo/EeXaqmsYgYYAcDn+HjghwVBbsUh3ozoCd5?=
 =?us-ascii?Q?3kAmeeXK+SnZHh3tcmYZPxciHdMXmYAFdmMo/f/F7bZSJRCRCm9dmEjmymTk?=
 =?us-ascii?Q?xyFuxwgnLlP8RUUmtFqFQBSa1CDf1PU2CShh3LSNsBPzVlJkHbIPjt30U48C?=
 =?us-ascii?Q?rKbG2uSXDr1pN1tYqN61Bz9KO4NKw/uvRkx5hDsJN9hvHam3+nKceW4QTR3B?=
 =?us-ascii?Q?LcTDuEctlD92VLyw/TuW8bEm9BZZFVwQZlYmSPx2ltwA31SOaQaqYk0bYEMd?=
 =?us-ascii?Q?YAl/AIDwtMXwtz+JvMLgugNun5PBUJgcHY9zhp5Ht2a1TzwsgS07ary/QXD+?=
 =?us-ascii?Q?KskzMhU1GLxWoTQj9wA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Znt12opzIrGwyPxatI1lk0vpzKEkMu/nSgzNwQYKRvy2y524/OzywJ+vNhzi?=
 =?us-ascii?Q?+SzAFg2oM5ca0eH8GDA9FZPaR3dvDDWedBT5TjlUV5548sZ70irBTuMM+CeY?=
 =?us-ascii?Q?wStTcbls96tzubxC9KCR/9AN6f4l+U3ssNUh3SbnZkFuX55VoDzMjwrKHfdE?=
 =?us-ascii?Q?nObwbfYn7YQYwr9iidhDKbWkugHPfXjrDhIBJoLnRsGIcOrbg2bkW5WFw+iD?=
 =?us-ascii?Q?sOrwO8R2MAJy3QrsiEHxki8kCajLaEDqMBbRyI23jkUGJlqYmFBH99M9TZM1?=
 =?us-ascii?Q?IIgQMkamARHkGotsYbqeEVgZ0MopYNpmLxPTZBiq/sbtDCHHf3aB6D/MA+ks?=
 =?us-ascii?Q?Wis61JgG2t55NUlKA21Q/sLdrbqwRdNL/1aPd/AeGAMb7Dsd8mzjSaw4cX5l?=
 =?us-ascii?Q?e/DcsGfxz/s58X9mKqZ33D2V6FP08Alc2Ypvmu9WNWdBWRCSv4f0EST7rY2a?=
 =?us-ascii?Q?/ys81xkOw4g6QNWSnu3wP4yVbV511kxc+m9d42KqS7gPPOIGE/og9TA7KVgb?=
 =?us-ascii?Q?+3Bh3s8b0jAFTc6ac9eqJlC5c1y13kkrnXMxE1FtaW2hp1Rt7nHtH7/TbtpB?=
 =?us-ascii?Q?koKQaFk7asw5kO3xTmN5htlTKvNMRCsQ74Eou+ggHLjvhAR1JxCyXQk7vtBp?=
 =?us-ascii?Q?4K6Tfc0z77o0zYZ/RPVhY+EDv32wxTHSk0DJ65e/lSd68XhXxYCcoC+J+BY/?=
 =?us-ascii?Q?bYJ+cjAsPG855Aq0jX48IkU0gXrZD0SmHZRPcmJwKOPCL2JdDZ4rBOEXfeQc?=
 =?us-ascii?Q?5h3FIGXaubfTu5JEJgnOrB5cW7crzCQVvymltfG/8GiMbKKvmdUawDKtgQGI?=
 =?us-ascii?Q?q3zqbb48V1fkLt1j9S7Wl8IF6vowDHSWvVlape4UplIb/NC4e6EXxCvvyluy?=
 =?us-ascii?Q?2ct7UGHHMu1gmXeFD1Mm/zhGYeMu3bCEFewcKGaM36CsruRfz6M64SvWopzp?=
 =?us-ascii?Q?tD3D30UAT6IXxAXbl1IjOpSWVFL6bMFNYxTjDLsvVO18lRMXqOBB5XxhRVqd?=
 =?us-ascii?Q?m9pYvFo9BVit5ldvychq7rz5wWhCEao5SNiv8/AXqlqk5xSaB1f1jm43HbQ0?=
 =?us-ascii?Q?GlcOqdLZyEhbaJJobdHena7TjmEZkCNK8Nbn7bxrNyp/Thhk+pxg87nCuhqp?=
 =?us-ascii?Q?eMjJJZlJXbz6F0vjr+Ekn+3LMczOAm95sF2yC6lTb3ESC/3QmAxQvvZrE7qN?=
 =?us-ascii?Q?RxbBAdTW/MrflYa6NFzUpimZJKbKgkJxcRSqYhqjyOrqQEsj5T2ZmIqB7RBD?=
 =?us-ascii?Q?mfX//qZywW1PyWgIvUrJCSaTRTlFDLHzkDesz6ZWPrSX9s3Il7faiCYFQNsq?=
 =?us-ascii?Q?hVGSZ4lseeobAx3DYqGm2ty33s80yZ3lj5ebVRyX6d025mwpaAqbKmxG5JNj?=
 =?us-ascii?Q?u/L5e7LpfWD9WfIy+q45Ckz/U/3vXHCFPwpV5mgZPyoD9cs1RtEfFxRLtSVk?=
 =?us-ascii?Q?NGjoD+zvbifFyv/xKvmPQOKsCq+4Ep5NtZZsRMngm42dH6yt1HUZfRK6zNuv?=
 =?us-ascii?Q?TNRqHqsLaxLESgu17piOOU5fZDnQiKKftr+SuGosOSIek4YAkbEaaxzTeoqR?=
 =?us-ascii?Q?AFWWfyYxTYgMx5b02NNyjICHhNMx0veGFnxpTiaEqe/whAJ9WBgDZoIb/FiS?=
 =?us-ascii?Q?oo+NRFjU72kswbND5s+012+WywChgkAoDiXrNil+F4BO9SW7x9IfaejYFxrO?=
 =?us-ascii?Q?3kLv4Uu8lNGYF8drM9hAbrJbAoBRONLm6gePaNw4V1gfB7IU?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a61c1d3-4238-4dd8-20a5-08de681e28b0
X-MS-Exchange-CrossTenant-AuthSource: SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 20:59:47.9995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2djxpPF0qjLIo+G6oHPAoGFYO0YfpAvUxXTQqUkXrS9ig3/fW/s+JwUi1UFrG0r/pPicOgt/XoSPie+KNcchLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P282MB5294


Bug report (as below) for current iwd (including 3.11) - const char being modified.

When compiling iwd with recent gcc and glibc-2.43 the --Wdiscarded-qualifiers
warning occurs because with ISO C23, the function strrrchr that return
pointers into their input arrays now have definitions as macros that
return a pointer to a const-qualified type when the input argument is
a pointer to a const-qualified type.

../client/known-networks.c: In function 'known_network_proxy_find_by_name':
../client/known-networks.c:296:29: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  296 |                 char *dot = strrchr(name, '.');
      |                             ^~~~~~~

The fix would be to declare dot as const char as below, but this surfaces
the error that name (which is const) is being modified. See >>>> below -
this being an error.

Regards
Rudi

--- a/client/known-networks.c
+++ b/client/known-networks.c
@@ -293,13 +293,13 @@
 		network_args.type = NULL;
 
 	if (network_args.type) {
-		char *dot = strrchr(name, '.');
+		const char *dot = strrchr(name, '.');
 
 		if (!dot)
 			/* This shouldn't ever be the case */
 			return NULL;
 
 >>>>		*dot = '\0';
 	}
 
 	network_args.name = name;
