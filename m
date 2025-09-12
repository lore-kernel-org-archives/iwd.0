Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010054.outbound.protection.outlook.com [52.101.84.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB11C2D3A88
	for <iwd@lists.linux.dev>; Fri, 12 Sep 2025 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663601; cv=fail; b=LtItvzkW2G0H2A+1TEH75FhZHG7OUQ0hc7XWbhCykzaNcLIcFtmRqqkl6vDDIhuq9Uc6Q0sAOSOHULpkXsNQiNKiiUD7uU210YMJ+LVQJDipKIEZVt8iIWfEKiHLM9ZMJzCQIOb2gKsUOJ6AyyI6s3Nv7krlH5RZy9xlHD6pD60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663601; c=relaxed/simple;
	bh=3PR0TOqvfk4CBWBrQ+chqWM3JrPECqM43YKhooJOwds=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FcjF25sF4ARZ0GXHVK2v/Xkv5T0XgzoCI4wqojbkambpllJmm7KqmbnR2iTBjwdl64K68qPHkbHxPbxDQM7H+a3vfUzBXbsNm2okEZMvHI9h/5BWdvHHalT7PVy0hkE5Cpv3Y6nMAVPtG9V3/grIBZnvUhJhbtsCKppoNSqkUts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=naN+wTSE; arc=fail smtp.client-ip=52.101.84.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="naN+wTSE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWLV7HPS/znSiXdwrQq1qbNxhF2Ra9nQeViYgHciT8P114k6f0jVRBkQjctrsoeYqbhLyekUXxrKq15X4iz5kCuWsCGSkfPaAbYA5U2xge8GxIAilCQdxkDe4rEf09FJ2RbytBgMnILJqPb6QXrK6LeIWWmRGTROxnVWXpgH2PeauYvO1+GGWedL8oj8c0VLyGiZY9kIaRMkAeKKoIZwWpgKcTv6udRPVlUlN667ekRmRsKaOkfOfUiYktyjSdj1VA4eOjWFJWyi6QcZSLvYgGwZ9bvPJVP0DMET7WrckUEDAL8qSfHk/TfGkS+3NWcYCCLp1P25vm9N0oiABVoiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBVenm1/IdsLuJy4saEtBRBxNMzcxaYrlTKg4eRqV5k=;
 b=vrNV0gRpuTZGt9txEnsh5Jr48fagfFreXRpZwqIMVIvJc7yOJil4fH+sQJi4zYi0m/uMDGJh+tAWGOX+bbTb6HpMRtOacqG+AUjJeH7nwb3W7EChZjdFBJIF2/1cpoFspv1CcYe0hys6nUJV6BziZbWv6WAuuSrAxO+L7CaNTVrR7wxxGXdnVMh5HaXwUGupiEmew+JrB0reB7VHERbBqHLNqsyxbx0dmlbmZC6aVMSA6UPEVsMuerzHtWiMOjOsbobDvAFPzrIoP+IJgDcWN4exaTUR+HzpSq3qNfvPwAW98ABO3M5rolzHdmHYSUTI9Trl7xIuKoz6EO3JrCcozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBVenm1/IdsLuJy4saEtBRBxNMzcxaYrlTKg4eRqV5k=;
 b=naN+wTSESy1dQaOkAadU2n0iHy4CeUhRuhhcXrbUncJoU15t16YkBU2gBycATq89LD1P3ovqUfc9x9L56G3fKmG82aZRE+SmcACUtA8A2kUe5SNu5nPxlunwbf09EfDsfKnU9BM5ju5rkZawt9IoLtzyDmfedMV5hUksJDstvGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GVXPR02MB8256.eurprd02.prod.outlook.com (2603:10a6:150:6e::14)
 by GVXPR02MB10904.eurprd02.prod.outlook.com (2603:10a6:150:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 07:53:15 +0000
Received: from GVXPR02MB8256.eurprd02.prod.outlook.com
 ([fe80::6044:5761:b269:8f3f]) by GVXPR02MB8256.eurprd02.prod.outlook.com
 ([fe80::6044:5761:b269:8f3f%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 07:53:14 +0000
Message-ID: <60359dd3-7a50-4cc5-9523-4ca8347eab81@axis.com>
Date: Fri, 12 Sep 2025 09:53:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] station: improve roam scan strategy
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250829-roam-scan-improvements-v2-0-888c6bbdd310@axis.com>
 <20250829-roam-scan-improvements-v2-3-888c6bbdd310@axis.com>
 <b69729a6-808d-4b92-a244-d148af40c7ad@gmail.com>
Content-Language: en-US
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
In-Reply-To: <b69729a6-808d-4b92-a244-d148af40c7ad@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0031.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::19) To GVXPR02MB8256.eurprd02.prod.outlook.com
 (2603:10a6:150:6e::14)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR02MB8256:EE_|GVXPR02MB10904:EE_
X-MS-Office365-Filtering-Correlation-Id: af814f6f-90bc-45af-7236-08ddf1d16dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z240d1pkWFM5aGZRN044YmRZUGZoUk5mZCtCRWNORWFpN0lxS2pHNnNHeFlS?=
 =?utf-8?B?Y1piaVhBeE55OVVwbnY2dGRmZXR5YVIwazdYSHBDN0xVV1B5Wlc1eDlSLzVp?=
 =?utf-8?B?N0pWQVo3L0xmWFRDSEhMcHFMc2R5NmtiZlhhTHUvRm9RY3N3ZjJkeCszSU5B?=
 =?utf-8?B?SkhKUk1XWHJFMnVRdWlWSnJObG56bjdLYUduRVphSVZOdkYrbXk0cXArQU05?=
 =?utf-8?B?cGQ5WG5JMlpLQnprUlBGajV3dDBMTXl5Q3QvZHdXckM0emJMaFNMbTRwNitl?=
 =?utf-8?B?alNsbnVYbVFtREV5Qjk5TG85T01BRmpLWUNsRHJDVUF6TWdTbGEzelZmVkRp?=
 =?utf-8?B?QlRBQnBTNHVuNWNmQjhHVldMemVjdnV6aGZQS082cUN0M29kRHYxL0o5b0J0?=
 =?utf-8?B?dzRtc1EvQmx1U0IrSEtBd2s4YnpKckVxdUl1VkVXQmtiWW16cklmTE1lRkdT?=
 =?utf-8?B?ZFNVY1J5SlN3REUvQmJpNmhuQm5pTXJVRGxob0ZCWExkcE01cWQ4NXlJa3p1?=
 =?utf-8?B?eWZNN090clpuQ0FPQXUwWnl1OXpxcktacTdpdUZ6d0svM0l0RGNRbGpZMVR6?=
 =?utf-8?B?TlpJc2VXem9vSnU5RDNsSjFGRGY4RGt3MVhFUDA2LzF2ZlFuRXJJR1ZNdW8r?=
 =?utf-8?B?UkZEdE44VHd6TEtUdmFBbGRza3VNZWJac1djWTRmaFNQKzFEd0pjRXphVTI3?=
 =?utf-8?B?K2k1QUd0WktoeVJDQlhBa1F1bHV4OHUwVk0rd0I0bUl5ZWJjTHh0ZVVzc242?=
 =?utf-8?B?ZWI5NWxFaWxZK2hsSHVlc0RnMWVUYkdUMEJMQzczYW9ERDNhS2hMYXVIdll4?=
 =?utf-8?B?dWlKRzFCWFZzU3Y1ODY0T3JZcmdIUXdQQm1BdzJ6UWk4Mzk1MGFoZUVxL0dn?=
 =?utf-8?B?dzZYWWhCNklGYWdMMlZTblZ3czdVL2lvS0RjaW10ZkpmQkVLdTR6Yklyd0NH?=
 =?utf-8?B?aUdxRk1nc3RsZ25qK2lXbElpeUdyQzRBSGl0Y3VVTWUwVmRrLzY2Y0hrcDNq?=
 =?utf-8?B?YnJXNGpCdkpzdFhWaWxnaWE2dmwyR0g3QW5mVGJCbS9VUGtjOE1CV05Tamhh?=
 =?utf-8?B?MEF4ZGdJQzdkUE4wWEpyV1N4dkhTRUlPbWVBVWJadGtQN0hyUzZIaGYxK2py?=
 =?utf-8?B?azdhRm1aUHo4M2lTZUk2WERpRk5BS2k4Q3dvV25pcnluc0gwU3NLOS9mTGM1?=
 =?utf-8?B?VFRzcVNDZysySkZOaDU2QVNxcExvVXRCL0VkKzBtWWV6bCtXOFJsYjlLMTY3?=
 =?utf-8?B?OWJlWW1zZW9ac0Vlc3p0dUxFM1BOWHlubnhGWFFtTlY2QVhBVDc1WHd1TVVE?=
 =?utf-8?B?TFhMWlpBVWtZZndxT09Tc3JkaEJaMXZxcGsrRnF2N3BmK3BmYmo4bmV6NnBZ?=
 =?utf-8?B?dnJIZlMyZDhiWjJwZFk1UmFDZHNlWlFqMnVGTkV4MG9oM1VwVkNFenllMmg4?=
 =?utf-8?B?Q0lTSWlac3FQRnlqRjUwVUN5S3F5R2ZKOFhSdWFYdk5hTzBMTXVyUGU4aFBM?=
 =?utf-8?B?WXI3SHhQd1dFQm1VL3NseDh2eVdzc0poTU9GdmdBZjc0SHNxYTUxektvOFZn?=
 =?utf-8?B?dVV4dUp0c010Q3F0NmJaYVh0ZU5CRjBSWFN0SXk1UkorVGRHa2pCamJuS2VO?=
 =?utf-8?B?elBQZmlZMEcxWHNrWWtSeUhHNzlTWXhLUlFQMHVoZXptNWdDdy9IQ1BHcXBu?=
 =?utf-8?B?RWdScE1SbDZtQ2FKcW1jRzNoVGdSRkJ3b1hFVllBaGNoT2RwMnBlVE1mYXQz?=
 =?utf-8?B?VnlkYnk1Zk5UaERrdXJzSDg2ZSt5RE9VanVuM2I1M1JyUzJDdjhJYUlnK2ln?=
 =?utf-8?B?QVdiTHIxRXp6RFZFODlDazd0dGk5S0pCN1lwd2JxVnpNejFpSSsrWmJ2SWpi?=
 =?utf-8?B?dXpoYWpHR0NIUXV5UTJYelBvN1ozRnl4d3BvaUJZcXNKNFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR02MB8256.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2tlTmdJVFNEYldEOUlZbXFIc0lJUjc0cVJYSUlsTFBKeEx0aEsrWWpGMlgr?=
 =?utf-8?B?NnQ2MTQ2WlFjNU1memZLeTRBM3VXUEx1UHlXY0lXYmVFSWpTaHNpRm8zSVYv?=
 =?utf-8?B?V0x6R1BLTVIwdnlvU1p1dXFxTERuTSs5YjFzM1g3WldkVllGZzBLN3JEL01y?=
 =?utf-8?B?OFJHUE94OWZTa0E0cmRuUml3SmMvQTZwcURJVGVIa09JNHdza1ZsOUZGRDRs?=
 =?utf-8?B?SFJkS2Qwb1lpLzIzN3VwYnJKdERUckZtY0NLdm9QRmNOYmZEMm9LRnNrTDdo?=
 =?utf-8?B?WFRMUkFhbkNzQXh4R05zdlVaU00wTHhKdXdONXVsVk5jdGNMVWFmd01oYVlR?=
 =?utf-8?B?RHAxUldZcWcwajcwTm80NVZDVC9oZHlWWlkxem95dlQwNmRJeXpaNGFEcnpI?=
 =?utf-8?B?Mk9uUkdkbng1dS9GbXg4TUFoRzlDWTZvSEtUQlc1cFg2RHhjUUF6Q3pVWG5a?=
 =?utf-8?B?WUhucWZaeHlZQVI3eHV2UG1vRDQxc0krcUNMUnc4NVBzTEt2c0hjQWNVUGJT?=
 =?utf-8?B?UVZHRzk0Umk2Wlc4bDdzVmpYazE5OXovYU51d3pPKzV4cUJiZ0t1TnB6Ulgv?=
 =?utf-8?B?dWVRcGQwWDhQcm5NT1NlUndyUVV2bmhzUjM2Kzl3blBDOFM4bkNHemduWlFV?=
 =?utf-8?B?YjZIRU1wV0d4VU50REFOOExDdkMzOUN3TjhVek93YWdYSXpVbmdvdGJUeldJ?=
 =?utf-8?B?MXF1dkJQTEhpQWtzSmpMa2ZKOGJEWWN1OHFZOTR6UUF0QU9keEVZM1JUQ2hy?=
 =?utf-8?B?aWxhZDhtRFRKVjdUdGRBQkk1Y0grdk11Y0dBKzlUS0Rxb1FYNExJa096Wm5j?=
 =?utf-8?B?NjRZbEJzNGtZd0ZxQzdONG82ZEJpVHNLeHlVWW1DWjRDNWcvSmI2VHZSZHFF?=
 =?utf-8?B?TTlXaUhHUDVtc0twWUVMNVNNQ0JWbVN3aGN3Zm9mZFhlSEpaZFh3Zi9jZ0t3?=
 =?utf-8?B?Q1JpUjBTdFlPL3M3OVFiOXlEWC9VeHZ6RkI4Y00rc3BxLyt0S0ZOVEJKb3hV?=
 =?utf-8?B?RHNFaXRURlBCMFNsTmN6N1h5V3ozWTJ2Y3RLUlRBMTBUVWh6UTlNa296a2tX?=
 =?utf-8?B?SUhYMG5hbXFyWlZ5dUpTeEt5YmVTWFJ3WExhd1FrOGJlb3c3QVhtS0JuNGkv?=
 =?utf-8?B?OWNxUkMwak1NUnRzM3BPdWNiV21HVm9zazNieDdkN2RqUmtKVkF4OTFnUldW?=
 =?utf-8?B?ZXpxMHkyWnBoUEpJck9MNWZHeTRJNFE4bnMvMi9FQjBHR1BvQzBMZG1lNXd1?=
 =?utf-8?B?OWp6M1NvdUJGSlV0b2Z5VVlPNWRxaEtEcU01cVhBaC95QklucU9Tem5LSUlC?=
 =?utf-8?B?UnFnYmszSUNaQ1IwSkRtZ1FNM0o0dGZoeUNxeTNDU0tpMFExUkRFdFdoT253?=
 =?utf-8?B?dCsvYlRUYVdkbThmcjlQcWN4UlZ3NENnUDd3NFZKNy9mVno3QXlxNDJ0YkNY?=
 =?utf-8?B?a3JaZjhjUzFSTEJBVWttc1dFaCtmY1E2aXM3TU9tRU96eWF3NGcrdmZZQjlk?=
 =?utf-8?B?eHRnWkw0cklsZENDckhTcFY2MXdta2FSRlY1STVWYW5EVmRTR0ZwczEzeURG?=
 =?utf-8?B?ZUJ1WnkzOEEvVjM5NDZRM3N4QmRIMmQ3bmdmZlFpbUZSbmpxcms5WXhDVnpz?=
 =?utf-8?B?L2hBeG1idk02SE5uQVpmc1RQcVpUeUhCN1AyN0NCR05qYUNhWUYyZ1dkNG96?=
 =?utf-8?B?K29IY2RDeDNPUVZqN0pQS1lFaXlrWitUNjN0TkVyVy84aER1R0dzVTgzeVdC?=
 =?utf-8?B?VVVIY3RITjJoNWplRDhSZzZkUVlPNjBvNGFZUU85WlliTDZWTG5tMDlwT0Jh?=
 =?utf-8?B?c0hjWTBNTk1pZGcybVlaS2daVVZhRVJKa2xFakFhcEpHcG9nRmNFRkM5a3FD?=
 =?utf-8?B?ZzNyNUxuQy81cWpaYjlPT2FIZVR3Yi9oZnR4clhtVmJYOGJaaHMrS2ZRODAx?=
 =?utf-8?B?cUFpVXVPY1R0WEQ4MVBuQW5Bd0hVYnRZQWtoeXNmd3NnYm1QN3FlNWxQcEtY?=
 =?utf-8?B?WDVXUURWL3lWck5PRzRUQVpFZjlheGZxV3pJeW9rMzVkd2s0K3VVaUtBMTZM?=
 =?utf-8?B?ME9Qc3ZnbzIvMXlncFZUczh6NlZHYjl6ZGRERmVQU2NlRW5qNTJHTkhjK0s2?=
 =?utf-8?Q?4W4haHXZ+TOTvPFbmj4OuM+nJ?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af814f6f-90bc-45af-7236-08ddf1d16dad
X-MS-Exchange-CrossTenant-AuthSource: GVXPR02MB8256.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 07:53:14.8825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KwtELZmlYAUrSvPpCmwOiMkiOnUTlSb/YOlSg48ki0WhReipMuKbzYFDDoP9hZgicYPNF9xeQFRwLqcaNyiMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB10904

On 9/9/25 15:35, James Prestwood wrote:
> Overall I agree with this approach, but I'm still looking at this patch 
> in detail as its quite intrusive to the roaming logic. One thing to 
> address right off the bat is the CI failure. Looks like there were some 
> incremental patch issues (applying patches 1-by-1 and building in 
> between). This prevented the autotests from running but I suspect we 
> will need to alter the autotests a bit due to logic changes in this patch.
> 
> Thanks,
> 
> James

Hello James,

Thanks for the feedback! Yes, a lot of core roaming logic has changed, 
so it's good that we take our time to ensure it works well. I found it a 
bit tricky to follow all the paths where scans would be triggered so I 
tried to make all roads lead to station_start_roam(). If I succeeded 
with that in a good way is up for debate :)

I will push a fix for your comment and the CI issues soon!

Thanks again,
Alexander

