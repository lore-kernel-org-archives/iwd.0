Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2063.outbound.protection.outlook.com [40.107.241.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17013272E44
	for <iwd@lists.linux.dev>; Fri,  9 May 2025 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746780817; cv=fail; b=Th4+YzDJh95phEbcVzBacZHNzoHKUty0Ll6C6tOJDdcMrFmualGLSqaJJYRbum3q91i3kGiIhQKtN1TC/qpKN9YFhkCGJ5ofNNtSkKHu3vppBrau/P94ZLvmIwUBmrBzFXNNFOFjUa8XwwV5hU6CbeJWdv+8n54NONZfKafmwAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746780817; c=relaxed/simple;
	bh=NU3rTgJkg1iWEfH/zveEmRURUIMweQtc1PIunkZB4v4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LBvzQ9rCAP4kbx/WX9Hi+OBewtmgyol9kForqrBwqKbVTlX6/sQ8hTQ//6kk+Jzpl2WiRHSatOAQg8V/TiRqTw0rmAJSqQPn9zglB3PbmrGfogtaBXZFkf/LVyu7rh/+ZerVkSsRQzfgXJEQzeZHdhe1MX45EohWEwdBXvERBvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=RXbv96d0; arc=fail smtp.client-ip=40.107.241.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="RXbv96d0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZE2qoEUapSTJagarTy0lD0wncG4GYz1T34JuBhyoh3ZKTu9sSWP6ED48BfLLaG5NmGcoFXeHsgasmrQywArFGYuVau0+8NJ3xWYdFbFAm4X7YRvMQu2SdCTwg3csunAlJ4pHOJz3meO4enhSZi3rG27erqws4SkPhZAkoIWwIstXP/y0BFEa+v+qW41PUOq8hKyTRZ/AWGqeP8W1gvMdK13lYqp0i7Viz4LutMmlSxZvpR5L254ihktG3kSEZjPV3Xu90aD5Dy7v10uegyGFjO84Vnli41SYh+egLT+6wz5sL0tqYcW3ZwSnUoh6w/3lcKtwXKQWCXb0R40eGkJZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTaPUhLoyxACkN02/9nqt4ya7MGzGikHdan202eavbM=;
 b=pxdOoXdW0eNJAmqsumxx8CoCL8mOVOCvWLNyTBekDHu8Fb7jiSDo1F7pCTBI+oS+qHZTr3zdIY9d0k0AsSZU41eZ42ZzqFv7YZuI6xVbITQoDHijU+bg1OZt7OIFtPDL7Jx9gtyaKcNUZ23n6xSykzePzrQ248eRa9f+LDXqyOQiV6KHO9vtmW8oHGsxTwVOEsQtSwB/8ybavAaDN9wHHlAD3hLamg4rX0GD2asFw3heFpHmDhceIWudxY88qdCXlIltOKSOHszJ14Vc1Ag9k/VxWaNjN7Vb/SYINl6pJ+7nFA/hpLcz6I0onNprt/QqU0mR1LWKYNMmkhKADSLV+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTaPUhLoyxACkN02/9nqt4ya7MGzGikHdan202eavbM=;
 b=RXbv96d0ZPZrw1W41raFebSmp/Df3tsmOspCz6Wrih7aIC3J97MWTmiz2uRTkE/zTJ8aSMel25ofcX0cn3VKdsv2NlJzAwC2OpauZ22X3KtmuXsHXcEWfE9D8Lt1SSRhaU6qOM7pjfyoIcklYWcrKVxFqge+f9D2z4GqkWNyGW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GVXPR02MB8256.eurprd02.prod.outlook.com (2603:10a6:150:6e::14)
 by GVXPR02MB10502.eurprd02.prod.outlook.com (2603:10a6:150:15c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Fri, 9 May
 2025 08:53:30 +0000
Received: from GVXPR02MB8256.eurprd02.prod.outlook.com
 ([fe80::6044:5761:b269:8f3f]) by GVXPR02MB8256.eurprd02.prod.outlook.com
 ([fe80::6044:5761:b269:8f3f%5]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 08:53:30 +0000
Message-ID: <2755e688-806a-4a34-87c2-f1964ddef504@axis.com>
Date: Fri, 9 May 2025 10:53:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] station: improve roam scan strategy
To: iwd@lists.linux.dev
References: <20250415-roam-scan-improvements-v1-0-12827e086895@axis.com>
 <20250415-roam-scan-improvements-v1-3-12827e086895@axis.com>
 <ab31a956-b65b-4b42-b37c-a1c63385d3c9@gmail.com>
 <c56180f6-8eff-479e-93ab-522bd8a43ad2@axis.com>
 <d89b7056-860c-4da1-a6bd-4eac4fd9b0d3@gmail.com>
Content-Language: en-US
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
In-Reply-To: <d89b7056-860c-4da1-a6bd-4eac4fd9b0d3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0021.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::26) To GVXPR02MB8256.eurprd02.prod.outlook.com
 (2603:10a6:150:6e::14)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR02MB8256:EE_|GVXPR02MB10502:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b276fa4-a5d5-4a04-ec0b-08dd8ed6f883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXl0eVFid3duQW9pWG92RVE0L2ZUK05JMXVjZVpPbVRsQ01QdXc3SW1SR1dp?=
 =?utf-8?B?NGpSODYxbngxZTlrL1BONmRjbi9EemRqOUI5MVhlVGUrT252WGRlTUNtYW80?=
 =?utf-8?B?MHBYWDJiQ1cweEcrcWFWbGhGT2NwQ3paVmlacWh3VlNkQjhqV1E4TitScTZP?=
 =?utf-8?B?VkpqRXNlZFNNRE9oOXJHWkJmN1VUcmNHalFzbS9maVJTNUxBQi9LNTF5ZTVW?=
 =?utf-8?B?eXpoY29GM00rVU8rVVF1OTdIaXdjTFJRdzZWR2JNL2o5RDJZNFduVURMd2Jq?=
 =?utf-8?B?SVJjd3Ara0t3eTNBVU9lVXpkdlVCd3c4bHlqY0t3K1hKdGJZSHUvd2hKZzlE?=
 =?utf-8?B?anRvbFRMSjY4eExXWjVLMHFDTHE5MVhLLysxeEpaQUNqcXd1TzNGdDlYYVdO?=
 =?utf-8?B?Y20wbVV5SkRvUVVRSmdmZmZxWnVabHRPNU1Qb0oxRldUMm9xTzVtMmN0QkE2?=
 =?utf-8?B?WEp5S2FldWNYZU9SWWxnN2ozYmpoTENNZmNNR0FVYnhqRGZwVDdQS3hiaG5p?=
 =?utf-8?B?UWFoTmxYWHpIbTJTTnY5clJ5bDIwL1RtbGpCM1Y0SkdSNEpaWDVTSkdjU284?=
 =?utf-8?B?K1FoNHdyQWRQMUJaTklVaGpIRHMvaUYxRFhRWldBM0ZoZFBtVHpvdHdnbU51?=
 =?utf-8?B?RExnK1dYQ3ZvUlVZYzRuQUNWR3d3Z1FZT0hsamt4L1FYSEIwM2FVYk02Rmpy?=
 =?utf-8?B?cVRoRFpSSUkxQy9MQzJGNldHemV1elpBTXVBM3Fqd1QxYzltM0wxcnlyUlJD?=
 =?utf-8?B?enlHK20ybkhTN016Z1FWalBUYyszdEVCRDVKUFJkRTVLZS9pVG56S0tjNUs5?=
 =?utf-8?B?ZHJZWGNBM3Z0b1B2SDNQZGNkYXgwRVF1Rk9SRzdDa3BueUQ5ZHF4MkhPVXVj?=
 =?utf-8?B?WStKeTRwVjYvaTdvMU5HQktqQ2p3YTQwcTdTYThtMDQvbWEyeUVIMW91eU5G?=
 =?utf-8?B?QW5HY05nRW9HUlAxcm5zNnBpa3JtdlpVdkozeG9pWVUyUmk3cHJlWTM3b3V1?=
 =?utf-8?B?SlYwVVVScVUzTVpkWkxaeFFSalRMNUlOYU51aitGcjl5SFpYekdFempYdjIw?=
 =?utf-8?B?T1FiN2hHaW50MllIZmJidzFRU1JkK0t1c2tlQjhGaER0YklhWXlnRDVtVmpj?=
 =?utf-8?B?L3hRMmYwaWcrNjBLOGsyZ1p4QVZOc0FLbFJLcGpUVk5nZmRYNHVzQkVFTkg0?=
 =?utf-8?B?b0EwQ0k3VWgvc1M1ZitQOXE1MURsdWRmeVVyVEphM3JQR1B6alJnRXVvYUJV?=
 =?utf-8?B?cGg4SzhrNGMrNC9QVXRqamxUWjluZG5rSnoxVkVYV0EyL2JHVThUR2laZmFE?=
 =?utf-8?B?VnNuUWQ5RlZ2d0NlVk05b3RQSXg5SUZ4c05FeW9DN01nbjFWNjRGb3h0OTVL?=
 =?utf-8?B?WnNPb2w5cWhFMGdaeWFYMjJFRzdWN1lmUXRlUjk2UnQ2V3o0ODFLTXlya0pY?=
 =?utf-8?B?bjNPUE5LNW8xbjJSSXV6N2ZDK3ZtaHhndzhNSVRtOUgyWE5ZUU16WUVSOTRm?=
 =?utf-8?B?UG1KVGtxeFBJcEFENnVGcE1US0VPajRoRXhRcWYrSTV3UzlGRE02VnIzOHhW?=
 =?utf-8?B?RE13eWZ3dWdDZXRLaTN2VUZubUhSYzhDRXp0a1hUTHVDdk5ORjJ2WkJ3SHlv?=
 =?utf-8?B?TWFpMzVFRFlRSFRCSllocHNkLzdaMTNOa0s1eElCdlJDMks0cUlUNGxtSEZF?=
 =?utf-8?B?YWczNXorVWlCT2JrRGdHMDM3R0JTcHl1cTlnekdSZ3Y1UlBKdURnNzRFWnNz?=
 =?utf-8?B?VkpWZWEyNlRrZU1GRmlqNzdETE1lM0s0QkJYT3EvaHBQQ3JwU0NIaFprUXZD?=
 =?utf-8?B?VUZJeFVjOUlzUWplbFM3TmNkN2RYdHVHdi9uWFFjNHNRR09uaGdhVGRaa0VH?=
 =?utf-8?B?TndhUndGczd6R3o2VWtnNjhPZy9KVWRncUc0blEvbVY2V25Eay9MTHBQdEY1?=
 =?utf-8?Q?Gh7pGVHGvPE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR02MB8256.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0d3VTUwaXNmMEY5RXd3bzJ3Z3Q4R1VpTjE2SXBsL2dXQUlzVjR1cm56MHQy?=
 =?utf-8?B?Y09KQTh0TXpucWJiZXo1cFBQLy9RczRtY1F1Uk9JeUpLYkxOODVmcytVTmpi?=
 =?utf-8?B?RmFUSkhNakdrZzU1QVp3U21zZlpNcmdXdklvSmp4NXhPRWFseTJqVllPZkls?=
 =?utf-8?B?aWdWTjRkekIxdHlOeFM3ZzgrdEpGS2lOQ3V5TmxvQlZ1aTdGN0lablV0eVlU?=
 =?utf-8?B?d0dyc0M2K1g1STdiM0VhUE4zTzgwQzRVYWpHM2RaUTA5RVJGR1hlekh1dm5K?=
 =?utf-8?B?a2JsbDRmMWRHcHdwSFU2NHZyV2FkRnIvMXRib1pWRkM5YS9vU3lGMFpFYWJB?=
 =?utf-8?B?Q0ZGYytSWlVKZDdNS0g5bi9PVmg3S2NvdnpaSHdqQk45dHhNeG0rdkNGbUhI?=
 =?utf-8?B?RERUWTd5clYvUE01cDZUOElDVEh3Y09JZEVFQ2FzZ3lRYnoxQk5jV2U1cGto?=
 =?utf-8?B?VlNKSUE0YTltdjhYNStOd0JsUEUxMERtUUZqNklacFpITnRHRlliR1M4WGgw?=
 =?utf-8?B?eldKMk5zdEVtOHJFRk5ZNFdQQ0crRHZmV0JmS1VmQkYyeFdZNkVUU25tMW5J?=
 =?utf-8?B?VkVVVXhSdFpZQm16aXJ3TUs2OVA0V0NUTWtZR0E3SWJoTERBVS9NcFovQjhQ?=
 =?utf-8?B?cWRCbkVBamdNQ0o2Y0NzWks5YjNHa0hsTnVWa1pyL0JEcDdlWndnVWFjekwz?=
 =?utf-8?B?NVRNeURTeVpsemN2ZXdwdERNMVpRSXR3a3VvVlpXOEZIb2pLNFN0S0V6TmFX?=
 =?utf-8?B?WlpyTEpudzFYNjRBaktGcGl4aDZpMnVqM0krUW9ZVm84OXVoK2hYRTZYeXY2?=
 =?utf-8?B?SkFoRTQ2djUwL1cvc0h1Z2dPT2FpS0U4Q1FSMHpvSTF3OUtLalJ6OERaZy9Q?=
 =?utf-8?B?OVRrNFlKNUhBWnptUDlhVjV5OGJEWmRiWEsxWW9MVlhqaGlySTFXNlNZT2dk?=
 =?utf-8?B?czVVeERkSTFGR1VrWHZLZTdWSGpuVk05WE1ScllIb3hwNytwZUZubU4yQkNu?=
 =?utf-8?B?S2NoYklFa0RGbVhTV3ZlaTZHOFF3WUFNYTQ2UGpnYVVpdmVPVllmN1NxOFlt?=
 =?utf-8?B?aHdLYjB6Ry90SmFFL0d3NXVYaWM1bjBmR2U3ME5pQldwRGg3SVkva3cyR2xw?=
 =?utf-8?B?dzNrc1oyNHoxVkhmMlJ6eElhMzdxWTB5dXBodlRwLy9KSUdPbEVRL0NEcG51?=
 =?utf-8?B?Vnk2WDQvbEwzVXY5eE1rcVJLaWxLTDgxVWNwVGRHME1HVCtMcUsxRVRucWpz?=
 =?utf-8?B?UytXck02SzlWZWRZUmFJNjJYN0M3NWQzNTFMMFlDa1VlMGtJZ2FkN2dweDY2?=
 =?utf-8?B?MlFuU3NvNHlsWXBhMlV5QUZVa29VTytEaUl3MzRaU09rSlRxQlNpZEp5MmNh?=
 =?utf-8?B?ZFlvSENuK1lBa29nS1lQQkUvQ0VlQUNCdlpvbllMelFlZFJvYVlxdUl6R09y?=
 =?utf-8?B?eHpsWlZZSHhFZkpzWUp5MkRrdmEwTkZyRE9XY1pza2VpcFREb0dEeHFwWmR3?=
 =?utf-8?B?WXFEY28xUnBjN1RHSlhTM1A1QWtaTzZvbEtDeC9ydXVsRFZ5NzJBeDhUUEdo?=
 =?utf-8?B?bnlXdUwwNnMvWi9zdmNqM1dDL2Qvam1TUHhudUtxSVpFRkprd3JHVHZta1dm?=
 =?utf-8?B?YVNwdC9xdlRLWGxzK1pXTGxtdjhiNUp5dDQ0NCtWd2I0YXlaL1Nma0d6ampk?=
 =?utf-8?B?RTNiblBKQWNHdWVSbmphMzV2bEFHOWpJaGhieWhVUTlKU29sT2RtU0hLOHNH?=
 =?utf-8?B?MHRxM3BBb2MyZzc2YWcvN0tGdERWZWZzdHEvdHZ4K0hkSC9YM0pEeEpiUTdV?=
 =?utf-8?B?dUVncnpmK3I4NEtoVWkyVTFJMDlzSDRTcStzNnJNMWZuQjZTV3Q0UmF6aHdY?=
 =?utf-8?B?M3pNY0lzS3I0T3E5VkNwMi85YXcvOHYvTXJKZ01SRWxTcG9VUG9PWlFZZ1dv?=
 =?utf-8?B?YzNjZFN4L2dLTlZLUldsT0k1djJscTN6MVRHVDdKdTFhQmJiTzZ1bzV4N05I?=
 =?utf-8?B?Kzh5QzNmcnRXeTMvRGxpa1dlelAydHh2M2o1aDI2d1BtQ04zZzJ2cVdaRzQ5?=
 =?utf-8?B?Qjg1VWNHMFJ2Mlg3MDdZeU9uTU12YjVJdit2K3g2OW5Ta005OGd0dVNNanYv?=
 =?utf-8?Q?0WEwgl7iG34sqb2cqrWFET1Vy?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b276fa4-a5d5-4a04-ec0b-08dd8ed6f883
X-MS-Exchange-CrossTenant-AuthSource: GVXPR02MB8256.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 08:53:30.1831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xn9Qtg/DuN0PZNpfpKv8PB62LNacrYm1oWVSFXpmu1P6fmZOW9CC+oi+vz6hBxDfYi+11hDj2VXaVCMLZMt5FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB10502

Hi Denis and James,

On 5/7/25 18:31, Denis Kenzior wrote:
> Hi Alexander,
> 
> DFS frequencies are valid and it is quite common for APs to operate on 
> them.
> Not scanning them or delaying the DFS scan excessively can lead to really
> terrible user experience.  In fact, we're having this problem on some older
> FullMAC hardware.  The firmware doesn't initially scan DFS frequencies, 
> even
> though it is being told to.  This has led to all sorts of fun issues and 
> lots of
> $/time wasted.
> 
> The less 'preferred' frequencies can be scanned last, but I think we 
> still need
> to scan every valid frequency before starting the next roaming attempt.

Good point. What is the definition of a "roaming attempt" here? You mean 
that all valid frequencies should be scanned before any frequency is 
re-scanned?

> A typical user cannot be expected to optimize something like this.  Our
> principle is to not rely on the user for any configuration.  The default
> behavior should be good enough for typical uses.

I agree, default should be good enough but for some use cases I think 
this kind of configuration could give big benefits. Maybe having a 
general config that limits which frequencies iwd uses is more 
reasonable? For example wpa-supplicant has the "scan_freq" config for 
this, which provides a simple way to optimize scans if the user knows 
what they're doing.

> See my comment above about using a time based age value.  I would push more
> towards a solution that scans every (enabled) frequency in some sort of
> preference order.  My opinion is that using a set of previously scanned
> frequencies, rather than a hashtable, would fit better into that sort of 
> strategy.

Gotcha. I still think neighbors will have to be scanned more often 
though. Maybe something like this would make more sense:
1. Scan neighbors
2. Scan knowns
3. Scan X un-scanned frequencies (ordered in some nice way)
4. Scan neighbors
5. Goto 3

And then use a list to track which frequencies have been scanned, as you 
say. The time until neighbors are re-scanned would then be dependent on 
how long the hardware takes to scan the other frequencies, but that 
seems hard to avoid. I'm only working with one type of hardware at the 
moment, so I don't have the full picture of how other hardware behaves 
and how big the difference is between fast and slow hardware.

I will also look in to ordering the frequencies in a more sustainable 
way, rather than hard-coding values. Also 6 GHz will have to be added to 
this somehow, not sure how to handle that in terms of priority.

Do you still see problems with this approach? It should eventually scan 
all frequencies, but might take a bit longer due to extra neighbor scans.

Regards,
Alexander
