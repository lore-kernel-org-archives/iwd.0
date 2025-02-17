Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F87215F5F
	for <iwd@lists.linux.dev>; Mon, 17 Feb 2025 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787319; cv=fail; b=uHEIZcQ7ckuRq/kLCztyGFCmVXTgcif98HagirMqKKGBnZXxeJsryNIoTZ/oo3y4pHnuyOtmPCYKmlpnXBOPivnPZYKDGrbTGZOhp4IUSDuQ44IU9051AK5EM8+Sieffq89tIR/u9wgRN2Ufjm2HjdRE848P+5CjlMAbUqyN/h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787319; c=relaxed/simple;
	bh=N0Z9gXza+sGOfR5FG5hy/0dlO8IZXu9qF+9oMhySmvE=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j18kZpXdSj/qboMpku00+IeHEIwvt+82DGB+fydLIIjNQ5o4DcYHcrnS68jJCDcCwsSdHpMzmUYlwItvx9XpWWFX7HmN/TlthnjKIrvQZ/5NuJlmuSIKGHMXVV9fQLpbbkXoy7ZibaukgGNLpT5j8TvPmLkcFHZUxn8BKjyLLPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=GKKHuGy2; arc=fail smtp.client-ip=40.107.21.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="GKKHuGy2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEKy3SjJunatNNG+cMPsofUI64V+CBCj8v3D5f7VBPxNRo5jFEr75bcK0fLubC6mAawsyWMeDqfIF1kpDxlMe+1NLEm0JXpphuEMwXvs9aeYjlmnrqIfj7ueRyfFg/sSqV5gXAR53aL0rFcdPbNkn1nyqq/b69RBnKDsDK/UNUygUlYGwL/biftehhRd8Q0nxypTC+W0elVjvWdRVIDWVYyF6fsttR8AE7S/9ghFVHQxLqBm+Rio+3aWmVntlbLZnts5+NE4VdbjDt+YKJoTngJmzCdL9zorR01mmzOmwYmo/8G6JwnYSv1ZMDAbBN0FALms3668qCXX0FZp9rQPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcH1fhvq5XmbZlosnJeS6y2g3KQNk437mSwY//tT/wg=;
 b=ESsuZ34tziB9etZez6qhS/7nw6/LvonBAlrOgkT9no18MbzTym5MqZvdhMaV7aFmUovyxcuPvPtSW1pE6zu3q5fHMA0vS2iH4wMdtKsma71lhRgqDkx1y3BVGYinezG1ghzTHl/+1HAJ130TKQS1JYUFLWqPN4zoU++LHgu4bb0vFHPPxxYYXe/wL3R5XB2JB6FPiNwE47bGcvhPI68kXF2HtAtgq2LCUEedBZ/waruYw4Ub36ATKOC44Oas8ryTlXasRhDwrYw56Cv2lmqPTU4Ow4MFXwxwoSiqe45a/mSIbL31wy/gqEkN14FimVXcZroSp8PK0efSwkLZurLeFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcH1fhvq5XmbZlosnJeS6y2g3KQNk437mSwY//tT/wg=;
 b=GKKHuGy2HdRWNiVjQ6kUQehRaosFTwrqaz0QLAHHKeGs1133auH47hrXbxVrdlEewD05NHQzC7dLze0cfal5o9Um3J9P2J0v+B0gS3YoqyhZvu3YfSJ4AlfkZsuWRlXmMSJo/NjhFHm+gTvt47lhbCPdIVmZW1vyHz8xuE/ogxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GVXPR02MB8256.eurprd02.prod.outlook.com (2603:10a6:150:6e::14)
 by VI0PR02MB11116.eurprd02.prod.outlook.com (2603:10a6:800:25a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 10:15:12 +0000
Received: from GVXPR02MB8256.eurprd02.prod.outlook.com
 ([fe80::6044:5761:b269:8f3f]) by GVXPR02MB8256.eurprd02.prod.outlook.com
 ([fe80::6044:5761:b269:8f3f%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 10:15:12 +0000
Message-ID: <9772b360-2d94-447c-90c6-c72849b5a74f@axis.com>
Date: Mon, 17 Feb 2025 11:15:11 +0100
User-Agent: Mozilla Thunderbird
From: Alexander Ganslandt <alexanga@axis.com>
Subject: Re: Roaming questions
To: James Prestwood <prestwoj@gmail.com>, Denis Kenzior <denkenz@gmail.com>,
 iwd@lists.linux.dev
References: <7b7d342f-0487-423b-86d0-fbbf5987ecfd@axis.com>
 <9eb9d215-8a21-4d82-9da7-50077dd63e13@gmail.com>
 <7ddbf418-e8c2-4d2a-9495-3a1cce2ddb3e@gmail.com>
Content-Language: en-US
In-Reply-To: <7ddbf418-e8c2-4d2a-9495-3a1cce2ddb3e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0120.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::34) To GVXPR02MB8256.eurprd02.prod.outlook.com
 (2603:10a6:150:6e::14)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR02MB8256:EE_|VI0PR02MB11116:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d69d70-087d-4246-89c4-08dd4f3bf6e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3lzUTNvTUZWdmFzSkQ5UGZ4K1BqcTZueXI3WW4vditsVHBFbmcyVnFVWk1O?=
 =?utf-8?B?TlZsVzJHdnRZUDBJS0hUSW85Y1BmWWFvZGhXL2NkSkdPOTEvVkZjMVRJWGx0?=
 =?utf-8?B?dDlLMDE2MjUrMjZBTWtEcDZpYlZyQkxXcW5ZenVmTDdvdDdLdTFaRjkzZGFu?=
 =?utf-8?B?aXJQSmhZeFArQXJrWEM5dzN3NTVvMXdxbVJ4YXVZYjNJdjJXdjdsRVRXKzBy?=
 =?utf-8?B?K1NrbktqSEVsMTlEQVdhSC9mQk1NQ3dQMDB5WHdMV2FQWGN3NGNvck9aMjNu?=
 =?utf-8?B?ZzQ5RmxpOWxzRTUxUFdZL1dKcGNTZlFXaHdhcTJ0VGRPUno0Y3p2MFVobkVU?=
 =?utf-8?B?ek16akdUQkM2ZWw1c3BCbWVtT3krMWZrMTZBVDBkOTh6SEhLVXlYRG4zdWtr?=
 =?utf-8?B?ZWpOcFdJUmxMV05kaURHOStWT2xkN2R1M29KNkd6Y080dWxmZlkwZ3RLb2hL?=
 =?utf-8?B?d0txWi9zOEUzQ2lzZGtMUkJnMktaUTV3enpOZUUyMHZFbHFYMVVjNGsycTRz?=
 =?utf-8?B?OVAyQW1oa2ZrbllzZUM3NGhLSlBLUWdHeEhKVEFjTFVpNzJSYWFNeHNjdkxy?=
 =?utf-8?B?VlpmNGFkWlRMajN6cWk2ZXlrbGZxQkpld1VMSjM3aFVlUkFpUmZFWnRzL0Fp?=
 =?utf-8?B?SjhaaC9VUm1aNFBPNjU1bkdNZ1ZpN29qbU44RnF0YXpRMDNRU2lvNzBCcmxK?=
 =?utf-8?B?bTFnRHN0VTdCOG9JMjBYZmFQYlZ6QlZzRklhRnJSMWY4YVdmc0tlMnloZXVB?=
 =?utf-8?B?QkRPK0NEZ2F6amQzNTh2Qnc1cHZ5YmtNZVNWb2Rpd1l3QTdiYWwxbTJaZzFU?=
 =?utf-8?B?RzNvaXROaFVkNnh5UnVWRUxTNkZXZTgyMWgxNEhGTFl4VTlTdU5mQ3BKaTdv?=
 =?utf-8?B?ZS93ZCttUGg5VjBpc3A3eDM0RjJpclJMZno4U1pCRmRzc0xFbjJTMXpSL2Mr?=
 =?utf-8?B?SDZ6TlZySkhjcVJGeTZzMW9nMUVQTisxd2VtenBWVFZXT3hjYXhFM2twRjRO?=
 =?utf-8?B?MHZkLytoWms4bUwvSFpYYXc2VWQ5RWJlWmwwMXBUYXEzVlI5cGJMdEJ2NGhC?=
 =?utf-8?B?OUFCWWthVWF3Umk1b2ZqZ21YY3grQ0hYZlRhcTYyRnVpNkFrRDNxdks0Y0lP?=
 =?utf-8?B?YjFpMTN6MFNOV2tVU1FwUWx0S1NIcWdJSWdFS1dpeFZUUFlhV21QcUxpZUEy?=
 =?utf-8?B?V3dPRXdKOFpEUzBBdGsrelpPRmdCMFU1Uy94SS9QUUNzVDJHU3JtUlUzc3lR?=
 =?utf-8?B?QTZvSW94bWRKQUZKNCtWTW9aUWwxVi9WR1AxMERxcVVGOEFuTTVSejl2M09B?=
 =?utf-8?B?eUxjQzNsaEs0NzArcW9kK0xEUUlJWnhUeWhraTljamZ1UUV0bDNqREhFcTJv?=
 =?utf-8?B?dDk3NTcrZzN2OUp6WXJMR0g1N2NhalhaT3hXaU9ENm40R1pzMElOZWxjc1o1?=
 =?utf-8?B?clczN2IwcmRFcEkvSHNSQklEay94dnkzMC9JL2FaUFhTbXV5dlZKb3BRNzdP?=
 =?utf-8?B?UzMrb00zRGRna1dyYXo4bWZrYzNBN1lBeTBhME9ZUGh0SUpNbGhhVUVDa3dK?=
 =?utf-8?B?VEJlSWJacVJMSlVPTHZBSVFqbnhvb1RTQVdVK0F2eE5kTHpyWWF0ck9nRzJJ?=
 =?utf-8?B?bnJxOHp3U0FTd2x0VmVIbEVmRDR1bjNtWDdqcjk0YmtHbnNLbExUS0J1NkFM?=
 =?utf-8?B?VytKN0ZxWkVhbDVoK2VpWGN0VGhGNWZZVzFkRjIrTXA2N1JGNkcxUE9aSXFt?=
 =?utf-8?B?L0dnalJRdUQxVGhUS0M3NVpSQzUrcDk3ZFhsSUUxUm5HYnI5RTZGQm5CZ0lR?=
 =?utf-8?B?TVlYRFRzMUM1ajd0UFZLbFpLRnNXeUluQjkxVkR1THJ0MUZzQ2lCTFJhNnBB?=
 =?utf-8?Q?WzgxzBJ8aiF4u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR02MB8256.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEJUK3ZubGxOMGpQQk56bXVnZTdaMlZhRXJKV1VVL1VnRlNvWmNnUWU5YUpY?=
 =?utf-8?B?bVlZbVUwNzFnNm1UdWlnRDFTS2dWTElOMU5JUDBnWVEwMElnSVN0ZXI2VTJl?=
 =?utf-8?B?clBXMlFlUkZ6eWRmemptL2JSUmcrQnVFVFFaMGJOT3hrK3BuSHF6NDNYWG1B?=
 =?utf-8?B?VzlaU1NCZTlqaTdDNnZ3SEV4RDZBeVNVcjlIR2YwWTQ3ZkpYVVNBbGFKN2dU?=
 =?utf-8?B?WGpSdTl0TDMrL1FTdUE3RHYzTjRtNGVjemlxdXdQbGRqUXhPaEx4SFArOVJG?=
 =?utf-8?B?Y1J5T1lRVjU1a0VLUVp6Mm5OWXB3eVlFUGJFMThRV3dObGVPMENQakVwcE53?=
 =?utf-8?B?S21JYStxTFcydWxiTGZxOTFMbVhMN3hKeklPa3VRNFVTTGNZN1FRbVh4ZG1m?=
 =?utf-8?B?bGgvbi8xSEFCaGVyVmhVa2MyZy9USi9yM3RYeWM2Vk5Ya2gvSHlTSGh1MnJz?=
 =?utf-8?B?ZmRjVWE5NWx1STc5b2l5QkpVK2R1b2V4c0Zud3lXdWlheE1pb2RNdUd0ejhE?=
 =?utf-8?B?cUN4WVllakJ4WUh3MjlXbG12czVpazRwREtQMnh3NjBVTG1oKzRscjV0bDNh?=
 =?utf-8?B?bFZBdmsvSUJ0SmtvdnZudEpET3FzZTR0aTU2SDB3UGNsTnVGK2ZDS2JkVnRy?=
 =?utf-8?B?VEQyREM3YVp6bUgzN1JpeVlSYjkrQjVyMXhkUXZ1WFc0dzdoemZPR252bjM4?=
 =?utf-8?B?ZW9ib2Z0TUZtY0ZPUXdVbGw4R3BsbFNncFJJU3Fkc1krSTRUaVV6cnlhMmdq?=
 =?utf-8?B?OFpSWjlaelB2cXhlM3ZSUUkvNE8wc3VvS3ZJTGNRak0zRFphaWFFTjFrVVpM?=
 =?utf-8?B?RnRaSUhac05teTkzUWdlVGVqWktYNytXSVdlNTd2RVkxeFZ1ZzlnNEdTSEFN?=
 =?utf-8?B?eUQrSVREMFJzZTZhK3orQkdkcGRuSXdVK081bnkrV1V6YUlLeFJ0TmdxajA1?=
 =?utf-8?B?cWpvWmFvVFRrVVkvM3dKU2RkZ1hzY1hjTnZNWUtNc2c3czd3c1JueTlHK3dI?=
 =?utf-8?B?RWs4MkllM2FpNVVuckl3RURsLzNHTmp6ekREVk9ycVkzR25ISmx0c3lNUUg3?=
 =?utf-8?B?dlgwanlKRzVnM3pObFFweWdhazB5b2Q0Yk9OSm9zYXBWYVd3NFN5cjdtSVhn?=
 =?utf-8?B?SmxXQ0VOUTZ0K1pYYnMwa0VPZjhVU1MxMmtpclJYL3QxMWNNWDM1UXloakMw?=
 =?utf-8?B?bXJhZHRXNUZsdCtQYUxmbm50bjhEMEJNNFAyU0dWYUg1cFhZZVpLOUZYejE5?=
 =?utf-8?B?cTh3RDB6R2RzUDUwN2Z3RXpTWVdwRXRnU3J0OEs0aFdlaGNXTXh3K2diN1dt?=
 =?utf-8?B?aDJGSjAvQ052WVlRcDdRVFZhSkVsOHV3dmVVRVJBUTF5eCtMYTRGZ0ZHN0lZ?=
 =?utf-8?B?aWptT2FrWVpPTC9QZGxjWDhjMmR2ZDh6cWxZQXZDd21hVFFWL0k4eUNyMDJm?=
 =?utf-8?B?VG9xOWVIazlEUnJtenNuY1JCUDhCWVJybElWSXVsVi9jM2EvMGJQSUJNY0tl?=
 =?utf-8?B?YlUrNTJjSjZkT0YxOUJQKzE1bWlwU0tXWk9GajFMVFdYK2pGQjgxUlpqOVRN?=
 =?utf-8?B?ZDNBU2gySjB2Mlkyd1hVVi91SUJaZE84YVJjUk55VFllcmp0QW5HZEJvSzd0?=
 =?utf-8?B?R3YrUDd0eGhhMlhKZkFON1VHR0JWTGk2THhyT0pyOW9KNWJpSVBqWWdsU2to?=
 =?utf-8?B?NlA0UlRWVVVDcmNDSDBqSDg3WkFyVFB2SjVPTmEzSFJhbU5WZ2FUKzBPYktj?=
 =?utf-8?B?RDQ0QllNb2FhaFEyUUxLblA5aDB3YlZydS9aYUlSbmxxZy9pa20wd2g4dGhX?=
 =?utf-8?B?SkxTRDQ5S1hlbTZKU0lQWHpodlQzQVl0QjB2QjVCT25kZi9ydUVQdUtxRm45?=
 =?utf-8?B?eGQ2Q1VYMHpEdWtRN3g2SFEydVJWSUNDNmVBSXZWT1ZBUmwyajY3REhYVUZR?=
 =?utf-8?B?czhwKy96UU9ENDlJOXpEVm11QStMUkp2VDJGQTBjWEUwU2VqcnFjQkpOdVdB?=
 =?utf-8?B?Z1BHMWsrd3cyNUhJd2twVDN2Y0I5TmthWExwcENxaFY4b0g0RnRvSFhlTFp4?=
 =?utf-8?B?Q3d4enkzeEtSMEw4SElBc2kxcFZFeVd1bmhuUE11OG1KbHptWEllK2hrVXQv?=
 =?utf-8?Q?Nedyw6xQunJkhyRHos85aMH+y?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d69d70-087d-4246-89c4-08dd4f3bf6e4
X-MS-Exchange-CrossTenant-AuthSource: GVXPR02MB8256.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 10:15:12.1945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YchfwjJ797+q9EeNmAkwip1SJCz1HbGHO/+UnhxmAEYGsLNQooF3RZMqsoSvNTuXUXzQu7yp/9sVE67mOBb0aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB11116

>>> or all non-DFS frequencies (since passive scanning takes extra time)
>>> or some other popular group of frequencies that won't take long to
>>> scan. If we're lucky there is a good BSS in that scan, otherwise we
>>> schedule a scan for the rest of the frequencies. In the worst case,
>>> this should be identical to a full scan with minor extra overhead. Do
>>> you have any thoughts about this from your side? Is it something that
>>> could be accepted into iwd or could it cause issues for other use-cases?
>>
>> If you find that full scans do indeed happen when roaming, then
>> introducing intermediate limited / non-DFS scan(s) prior to the
>> catch-all scan would be just fine.
> 
> This is an area I want to improve since we do see full scans routinely.
> Not because we didn't see any acceptable BSS's via neighbor reports, but
> because the current one was simply better. Likely another limited scan
> using the very same neighbor reports, just done later, would result in a
> successful roam. But its tough because you can't always the APs are
> sending accurate neighbor reports.

Yes, I also see full scans routinely for exactly the reason you 
highlighted, that no other BSS is better than the current one. I also 
see that the neighbor report doesn't include all nearby BSSes, it seems 
to prioritize 2.4 GHz and leave out 5 GHz, but maybe that's a config 
issue on the AP side or the 5 GHz signal is too weak for it to pick up. 
Either way, immediately going for a full scan seems a bit overkill.

I plan on doing some more testing to see if I can improve this, will 
report back if that's the case!

>>> Another question is about the "CriticalRoamThreshold". There seems to
>>> be a config for this and some functions for lowering and raising the
>>> roam threshold, but I can't see that they're called from anywhere? It
>>> seems to me that only "RoamThreshold" is used, or am I missing
>>> something? There's also a hardcoded delay of 5 seconds from the point
>>> where the roam threshold is passed before a scan is started, is that
>>> just a "hysteresis" to not immediately start a scan if the signal
>>> temporarily drops, or does it have some other function?
>>
>> This is currently used with the Affinities property on the Station
>> interface. For now it is only useful to lock the station to the
>> currently connected BSS to prevent roaming.  For example, for the
>> duration of firmware upgrade or similar scenarios.

Ah, Yocto Styhead is using iwd 2.20 and in that version the functions 
for using CriticalRoamThreshold were implemented but no one was using 
them. I've now updated to 3.2 and see it used for affinities. Thank you 
for the pointer!

BR,
Alexander

