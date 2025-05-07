Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F81D280039
	for <iwd@lists.linux.dev>; Wed,  7 May 2025 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622419; cv=fail; b=TJcTOGSAJXQ/TbP7dA4Q6LeMSE9nHElSwuPIN1X37n4jFv34JojiRv10GLeHmvuF5GHjLkFTgi8XbQzEYc7pNsreuXfEk48kHiXOsG5aKltfMnK0MFtqCJOSWqpfaHnKI6/gcN9Gy/5aEftWw6gHdaNFymsgD3oJ+WFjzbjSzJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622419; c=relaxed/simple;
	bh=lhRqpaJlS3E38yv/1Pgs+WDHMz6h7QHQJpki+CWdPyg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JxSmIZ3gsv6ReYVmLJ48+VsFAU2te03XSvUklkJUDtppiejFkzJDQ+4oWZyAMj/3e5vj+caPX+tfObhqaMU2LRXOhuoYmTye+5FYbJ688U821meU1wnAlEIbsnZivL17ocQ5hHHdxy8tL8oL9sptc544pYCQCw/rOqq5z9Zv6x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=pfTl7bWw; arc=fail smtp.client-ip=40.107.20.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="pfTl7bWw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vntJ66t13JU/czbF1CxeCE5ZWRX6Hedfe8oQrPdPWRK43uSn5eSjTBSGI6HKbmsY/kEHeL+/r6hyVZsxpYRuMEoFJQ4bj7ydR6oBkjYDxpjwZ2F4RtxM/m0Ux1saOTFVcWzQcU61RbZMJ2VyowSb8sXXntVHDwYDEEHNTgXT/ULjeD0wNBp1lrCLR/BB11TelY21unHYDFHZmb3QoTGSnvQJQZoOUCohT9r+n1EQ8gCM+k5VVonX2jieknxHtfgHUaCp/VF+D6jqnWq8tobtodMSX+Ir1yVJuxt5b1STRFXcUB55cCaqMRdCiOvVFFsM+98+asLAjYQF4n3WOvpTXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsAmrZIugvZGgiP9qhvJT1IcfGl816gISmPeI8qh8vM=;
 b=wtHmDc9nVkXmaeqKIsgKknsG20IbEFtmnOlksD4mM4VhTbu1x7Gi4R1buHkTWkmnHLdqm7FZ1pBl8ONPlcTE9CwFl+g1JtD8AWwZBxRj1mhjb2Ypvs9P8xC4iEIOjflh9hrIQesSVkrjxPocK+YdTQBO1X/OivRkJ1MEO81g26GhmrblPc3k/osAltZBsZzIJsXyM4ndc7QzPcSJr2quRRgLK6+KzuXPl24g7ODe5dIUZLeLtV0QcA8VHVwd3AhR3CFDIyOn6nuNzIdu1OkgyMRCgx0O4RPoPXXTSLRMnpvrvvqynkbsi67mt+gMbguZgjDW/p5aswTqQbSFxYhmGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsAmrZIugvZGgiP9qhvJT1IcfGl816gISmPeI8qh8vM=;
 b=pfTl7bWw42q7wKoE2mGKkuBN1Fag41IHHvWaMHPLyunc6xrvQjeTPIdWilUWDgrR+f3AzDFagMtvKrItuLENmT6ZrJeGzjmlTCJKlCJdDgPzZQbEYnhYcOf7G/cq6OHEmysK4PsQhfkzG1GZp2MZLtR/q5exGjumlgLaKX+ic5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GVXPR02MB8256.eurprd02.prod.outlook.com (2603:10a6:150:6e::14)
 by DB5PR02MB10164.eurprd02.prod.outlook.com (2603:10a6:10:4aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Wed, 7 May
 2025 12:53:34 +0000
Received: from GVXPR02MB8256.eurprd02.prod.outlook.com
 ([fe80::6044:5761:b269:8f3f]) by GVXPR02MB8256.eurprd02.prod.outlook.com
 ([fe80::6044:5761:b269:8f3f%5]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 12:53:33 +0000
Message-ID: <c56180f6-8eff-479e-93ab-522bd8a43ad2@axis.com>
Date: Wed, 7 May 2025 14:53:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] station: improve roam scan strategy
To: iwd@lists.linux.dev
References: <20250415-roam-scan-improvements-v1-0-12827e086895@axis.com>
 <20250415-roam-scan-improvements-v1-3-12827e086895@axis.com>
 <ab31a956-b65b-4b42-b37c-a1c63385d3c9@gmail.com>
Content-Language: en-US
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
In-Reply-To: <ab31a956-b65b-4b42-b37c-a1c63385d3c9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0016.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::29) To GVXPR02MB8256.eurprd02.prod.outlook.com
 (2603:10a6:150:6e::14)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR02MB8256:EE_|DB5PR02MB10164:EE_
X-MS-Office365-Filtering-Correlation-Id: 53cefc64-67b7-400e-0b6e-08dd8d662cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkk4c05lU1BkaGo5VFVkaUpDNEV4S2VDZmZwbTRZOFJQRXQrZ1VrTWpkcHda?=
 =?utf-8?B?R2dMSGZJSXFKdm9VMnNiMWJOS3JPdTVRaEZNdktXbkxmSUc0Z2J3ankvMkNw?=
 =?utf-8?B?Z0t1Y2U1ZWg5SXR4K3U5RTZvODNlekZQMFdBaG9oSmVjS0tndDVoVnhIZHlR?=
 =?utf-8?B?L2FkSjhQYm9nMDc4QWsvaVBubCtuaTJwcVJwbi9KVmMvZ0ZSYklYRzV6ZXFZ?=
 =?utf-8?B?VkRaS291WTRRNUZ5clhSYWgvdTRyREFyai85S3NmOFQ0RFRuS01SMjREbWdZ?=
 =?utf-8?B?dE5sWXpNMldBbWo0M3NNeUdIR1RLV2dYWUFyekZhOGlrdlBQZVYzK283VlY2?=
 =?utf-8?B?aVZiL1VrRWMvaFliNjkzRTN2RDd1TzdaTkZ3MVBzTFJwNFNCcWhjbi83cjlQ?=
 =?utf-8?B?ajFvaHVJdHI4L3ZKNGlLNDVZL1F4TmZsL1ArOGtXbjBsZVBmbHJ6bzc1VXAx?=
 =?utf-8?B?NVplSnc5M2t1alVSVDFITGY4R0t1V0diT2lxY3JJTzdUY1pjVHMwN1JrMDdz?=
 =?utf-8?B?eXRTTlAxK2kwTjV3eFVhR1I0eWF1bEhKVHljemMrQW9xSXNoYU81eG5MZ1U0?=
 =?utf-8?B?aDUrMTFPQUxXbFM0ZHRpcTg0bHhBQ2J5a3AxbEpmYU80QWJPc0tzSWRMMm1N?=
 =?utf-8?B?NU9rcDl3UEt1RGpaWmJ4REFIdVExUitDb1Q3QUNHSWlhM0MwQUpCVU9ZQzU1?=
 =?utf-8?B?WWVKY0MrakJBeDV2TmtEc3AwV1dNcFRkYnJOOGFUU3lyREw5eHZYcG41OEZS?=
 =?utf-8?B?cmZ3L2J0blVDZ3ZGSUgzQVFvd255aUt4cmhzdGZ5TkJQUHUzVkNUN3o1a29i?=
 =?utf-8?B?ejNaVW1zT1pCT3E3dklVSmFuTGM2d1NocmZkT29XMUx1ems1TXo1M0NhMlZQ?=
 =?utf-8?B?b25oZ25YbGtSNXYxcXJxSXJuenFQRGMzaGw1anMyeWxuMERVOWgxZ01YZm9N?=
 =?utf-8?B?ZXBwUnRIcmNORy9XaW9seFFUZVl2dXMwL2dsWXRCc1hYYWw1YURTRFZiVVBP?=
 =?utf-8?B?VUhFeXM0VHd2ZWFqeG8vQ1BFWHMyNG9kMU1iaUdEb1V4VGF4M0FURUduSmlx?=
 =?utf-8?B?MHpSVVFGN0psUjE2eFQwVmg3eThQeDNVVTZScjBzQUhMR2NxaFNiK1ZZTVdR?=
 =?utf-8?B?cFl6RjU1c01Sbmpqd0ZLNjBZNHE1a21PV2NMdTAzNU44bFRFd3U0OUViVnJM?=
 =?utf-8?B?MUZQYmNjeWFBVEYyZXNyWDIwZ3ZmelNkbE5vQWNwZW55YUI2Q3hMUHRIb3d5?=
 =?utf-8?B?K25yL0sxUCttYUZlS0pzKzVyMEdVNmdUdlFCNkJadnc4Y3AxdTVvRXR1UHFx?=
 =?utf-8?B?TThybmRWT1NZcUovcHM2ekFScGtPQTVuOUFyMkhpM3Z5cGhGM2ZpQ0lJTWZ2?=
 =?utf-8?B?Z2NnQndGYitSY3R3VnFPWXdpSW9VK3EreTJsV2MxSkFRVTZVbXF0UEVWaWt4?=
 =?utf-8?B?VlFEQ2tyZngwajR0YzBZOTRnMDBVMTM4bEFqNVQrS2dYdE9xUUVXaWtlSzB4?=
 =?utf-8?B?SXZpdzFQa3ZUZG9McnpSZHdyaVo1TlJpNWhEQlcwYVhSbVQyUUd2MXkwVldv?=
 =?utf-8?B?eUo3ZnlXdTQzR2xwSGJNZFFvUC9jY2lWMWE1ZzVqL0ZCeU9tMDdQaUJJMlFU?=
 =?utf-8?B?Vy9NT1RObGJaQkFiOVY3Q3E5N1RsenA1elFUWUpMM2xvZU11MEgxZGNWSStv?=
 =?utf-8?B?emc1WHBnSFFhdVJpQ29ha0JZNXBsVVE2cjRadGdob0JCK2VGaUk4RG50R3pE?=
 =?utf-8?B?dGNjOGZZUm96Rit3eFA2Mk1DRm9sNUNJNmNHUDgxb3JqYzhwcjJqTmU4bXhC?=
 =?utf-8?B?UVJZcWw4WXVnek0xZVpMNks4Rk15Mm0wTGNrSFR0aXQxSCtPZ3Arb3Iyeldh?=
 =?utf-8?B?YWtFbm14WjNOcFNmNXhDNXA3Q1V6WnM1QVNydEJnZ1dOWGxUdlNvTjMrbkk3?=
 =?utf-8?Q?FabjVD4Q5kk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR02MB8256.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG1vTjdJdEMrTXo1N1NxMDRoTDg3cHlEYXpPeXZnR3lKWldzTzNFc2o1cE4x?=
 =?utf-8?B?UWh4WUdJbzZ5OUw3MURteG9BZUVuampiL0toQUI1ZGRSbEZaVUd6WkNkRFUx?=
 =?utf-8?B?d2tCVVFwZjZJZXV6YmFyQ0M5cWE2YlVQRVgvVEtuN1lqZFgwcWJ2YWtXRC96?=
 =?utf-8?B?Z240ZnJXaVo5M0duWlNZSHFqLzhqbHRwUWdvRXEzckIvR0NXL3MrdXNYcHFj?=
 =?utf-8?B?bk5uREYyYmwrZ2loSVpOSWZlNVdlZVRzR1ZrUDd4anpWZEY5MWM1cExBc3hz?=
 =?utf-8?B?cExHb001R29CeTl5cFhIcTVGMWRrajRObjA5blpia2RocXhuZHFnQWN1NDVu?=
 =?utf-8?B?WWM4dVMzYWllTHNFMmkrN3VDdkhKbVNBT1E4bVZ1NjJiSURlSVo2eGxqZDhF?=
 =?utf-8?B?dlo3ZHhvaC9WQmV1VTJiTzdaNmpEUk03U3A0R0JwaDl0MzJLWjl3cG9aTGpt?=
 =?utf-8?B?VFRIYXJOdG9RT3ptZTlyaERtZ1o4aFRsZ1VudGlHWlZ6ZktDZ292Q1NidlZ6?=
 =?utf-8?B?SWxMb3diSkVmalZnaXZBNWhRNEd4aC9JMlRNa2FLZ2ZxY05mNXlpZnJRcTg4?=
 =?utf-8?B?V29ockx6M1B0S0ZZRGtRbDViaUdCcHdyZTlONTRjNUJMZzVKZjVwc0l2UCtq?=
 =?utf-8?B?YlM0NXg3NzRUTzJVY0dDYlFwZm5ZNmhBcm41c3VqMHhsMFd5UVYxOWFycXRM?=
 =?utf-8?B?Zmc1eHdROGZGSExJY1ZXNnR4NTR5U2dlYjRzWS9jYnNSN0NLRG93RHNUQkgv?=
 =?utf-8?B?c1V6U3BoZURXQmkwdWNhRVFIaTVvMzBpRGZqclNEWGIxVko4WTh5a3VnTGNL?=
 =?utf-8?B?ZFNITENlT25GcVNLSnk5YlpYMXNKTUdKTHFlNndHVTRuS1N5SGNDZ2lDK2Z6?=
 =?utf-8?B?K003cFRmZWFzRVZwczlLOUprbVFsYms4YktVSWhIYUhob2VJMjFvblgrNEdp?=
 =?utf-8?B?OVlQRW9TL0VaeEdpYWZvdWtsMlVIUGE2NTJxaGNpQ2hIVlp2S3NWV2c2eU1u?=
 =?utf-8?B?UDI3T3ptdklEOVZ6cWdCM3RQS1hKMHk2ek1TSjN0T1ArKzJwS1lYSUFTYzlo?=
 =?utf-8?B?cnp2OHRrTlY1NzdBdk9ob2Qxa3V4ekNaT0pVam0rTDZVZ2hSRDNtUlZyV3Nh?=
 =?utf-8?B?VDVMNlp3ekdjbFRhVHZGZzY5OXpxOEkyaUlWN1Iwb3lMeDU1Vm1YQ0tNa3NU?=
 =?utf-8?B?WVZMc1BGUjkvRnVDRzVyeHA2UG5EZkhaQTlJR1B0b0JZUjZtT21OUU1lbDlv?=
 =?utf-8?B?dTFGL3ZNMGQ0VG1GUDMxQ1NtdUtqeGhod2JZbUNKNG1jS0tLUklJM3dXSmpR?=
 =?utf-8?B?aXVVamQwekFrUEV4ejlFdktaK1dEVFFmMmpBLzRmc3pZWXNXNFJJUHRzRzFF?=
 =?utf-8?B?dlplTmxRbUxFbyttWThSeFB4VlNZandrSEE3VFZObnRmYmFoRHlXT2Y0TkRP?=
 =?utf-8?B?YVluMElKcmlsKzV6dmp0UTNybGxnU0poallaR01neGo3N2VmNklOZFVDZ0Uz?=
 =?utf-8?B?VHl0MVBsb1NyZ3JRMkswaVV3T3pxelpvNWtpS2lka0JuWlNneVZ1c0t3bS8w?=
 =?utf-8?B?V2JXc2JJWkcva0p1ZFIra2ZRYngxMEVLYzdTVW9nS1ZZRXNrNFVOUjJBVHlE?=
 =?utf-8?B?dFZWK0JYK2FtRlVuMFdMVFhnMURPVHZQdWtaT2oyN3BCblJZSUlOeUJwQURO?=
 =?utf-8?B?QnUza2dSa2NJR3pLMWFCTVo2K2hDa0RObC9KMUN1WEI4REYzb3l3S1k0Q2Fo?=
 =?utf-8?B?U0VMc0kyM2gxTENwRUFFUmJ0NGQ5a2dQdDZpemZpWU9NM1pMWWJLbFljbk5M?=
 =?utf-8?B?VFMvZ2JyZTNRZXRXU0p4VVVMdk0xUk1IelYwN2NEVkVpVDA3dHdFOFNCU29z?=
 =?utf-8?B?Y2VYVTl2OE1ydFZ5RHB0UmZ1Z2pMQlpJNVQxMmgwYWR2Rnp6Y21ZMkRkR3Na?=
 =?utf-8?B?cUZiT3JCNnRaR2grTU5OMTFkaHZmbXMyU3IyOXBvd0ttd1loaWdZQmJNNHVZ?=
 =?utf-8?B?SEswT0o0OE9tRVF2ejI1UG0zSmIxOHlrK3YyVC9Kdk5qejd1TzRmU255WTVE?=
 =?utf-8?B?NkFCNVl1MC8zWm1HWVBObHRYR1JNSFVLVFpxMGhSVVRMekRjYnhFejBrQlhw?=
 =?utf-8?Q?6m1B3X8Hu02pkUnpzHGRSesC4?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cefc64-67b7-400e-0b6e-08dd8d662cd2
X-MS-Exchange-CrossTenant-AuthSource: GVXPR02MB8256.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:53:33.7143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dh5MoI7EW3ZamHy2X/LYStE12uPVhr0le0Pjm9VGzcJEBtwi+t2+sJDLbe29iVY6IGM4x7m1NUdqBWCpvQkxlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR02MB10164

Hello James and Denis,

Thank you both for the feedback! I want to focus on the overall idea 
here and will look at the code details later.

On 4/16/25 18:46, James Prestwood wrote:
 > Won't this start reusing the same frequencies after a few scans? Say
 > your first N scans take more than 3 seconds, you'd then begin using
 > those frequencies again on subsequent scans since their ages are under
 > the threshold?
 >
 > Rather than a hard threshold simply sorting by age seems like the best
 > way to do this:
 >
 >   - Sort the frequencies by least recently used -> Take the first N
 > frequencies -> Scan
 >   - No candidates found? -> Repeat ^^^

Yes, it will start reusing frequencies and might never reach the less 
common frequencies depending on how long time the scans take. That's 
definitely not ideal. Looking at the age as you suggest has the problem 
that it will eventually spend time scanning uncommon frequencies when 
that time would have been better spent scanning common frequencies that 
are getting old.

Maybe this is an impossible task to solve perfectly as there will always 
be a trade-off, maybe it's better left as configs for the user? In my 
livestream use case the APs should be configured such that most good 
frequencies are in "neighbor" or "known", so I would like to spend most 
time on these frequencies. However, for a use case where the network 
setup is unknown, having more exploration of uncommon frequencies might 
be better.

We could have configs instead where users can define the subsets and age 
threshold. If they don't set anything, the default is the current 
behavior. If they set subsets, the roaming algorithm will pick 
frequencies from those in the prioritized order, just like this patch 
does. It could still get stuck scanning the same frequencies if the age 
threshold is too low, but then it would be a user configuration error. 
We then also get rid of hard-coding frequencies in IWD and all problems 
that causes, but still give users the possibility to do so if needed. 
Does this make more sense?

On 4/16/25 19:19, Denis Kenzior wrote:
> Have you considered maintaining a scan_freq_set of all the frequencies 
> scanned
> by the neighbor and known-frequency stages instead of maintaining an 
> hashtable
> based on age?

I don't completely follow what you mean here. The reason for having the 
hashtable is to know how long ago a certain frequency was scanned in 
order to not scan it again too soon. So that info will have to be stored 
somehow, or did you have some other approach in mind?

> So the idea is to add up to STATION_MAX_SCAN_FREQS to a new set, 
> starting in
> order of preference with:
>         1. neighbor frequency set
>         2. known network set
>         3. scan frequency ordering set
> 
> while filtering the frequencies already scanned.
> 
> How do you know when to give up the current attempt?

Yes, correct. Do you mean when to give up on the roaming attempt 
completely? The current approach is to never give up, it will continue 
scanning frequencies in the subsets until it finds a better BSS, or 
until the current BSS signal goes above the threshold and roaming stops. 
I believe this is also what IWD does today, except it uses full scans 
continuously.

Regards,
Alexander
