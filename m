Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93515149C55
	for <iwd@lists.linux.dev>; Thu, 13 Feb 2025 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458877; cv=fail; b=MhWQkG8ERLIGdxxPU+sqhWqlFFNawKR7DpvoB4OC44fC4olPhW0ZokLY1/gO58gOJ0EVLwcx9/54ZQ5XbhABKTX2T3D0IrFXy5wp+hH5v2eRxCNQWLDxQdxJQr4kfUMhdPwQrPpWRKrDFyQUDsv8OJq0DJ+T1mvq56HIGd6hK+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458877; c=relaxed/simple;
	bh=Jw3XL7Qa0LDQo0/d08ERFPCZGlN0z5P/zURCzHQ8/qw=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=fOTN02AGd6N6JsNpp+7YaZLvcH1CKbqvCM3WW+ZUQodxNjWh8Piz3ZzPkI+3rHKYcR9u0FiduMERxCDbB3WqHmteUcbnTnoz2WrnKVFEheTAHYs/SKtY/uRpPQsOA7zrvrgJFcykcVLj9GWd6ZU3h8nsMprfLggvDqg4bITsP/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=F9M0mBhO; arc=fail smtp.client-ip=40.107.247.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="F9M0mBhO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFPEAa/tFtY+w1DBoKQpbFF37NzVKJhufAAIvZx4Px836ja57TWP+dUg1iU5G3AoqEvGER2OzLZbLJ2A/GYDbGmvuaVS1P7i/tBxgXUZBE3igFWkdUnvqm3in4ojFgdRqSpF3RF0I3Mi4OPVuiSM7VSrUtmOQ7NIHbYRRD8Q1qzemMS3IhlxRPt5P118Pi/8du5X9Su6FZ0BYINV5Bo1pd5THOV99HVGzwkjJAVlEfwRw/oRYrqBOgwu6vBgg3AILTQuv5IIVnEgbXlkwpfzQ2w9RsETF6N6vC4SzyviAYkGjmmK2UAB8FsmAfrwQuq8coevB1cs+e8qsL/rM4pJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7I/Z2vpaeifMZi6d6eZLGcIr11iGtBrsQwcMGy+RG0=;
 b=FmBq5V7V/ZBYEBJIVmzNjo4/aeqca65PKQu2HfJebxXdt3ZZWSNMQ3xLdSvWhoTvrpbgJM+7COiKMJ/3lkk461HIpaofNEfoe+pZ++Ug+MMg9HGblIqepVPoxG3i6pfXjb0GLRyH8nkGn++lhwfKxFus/bTi/tYfkgtJg2IvtzdXHUXpRLBD80EpZIFUW7EwPi/depJz1gbgvCaNW9q59J4DbvPDRud/KAqCGS2D0MA/7iCdNIwB05391yBK5G8qJ88Wt4k/BchhrqDazTUXUUcsL/7e7TyDX5e/UNGTgpNE2GeHn/et09BvDkn0WBC7vDlDsCzO3voilk2iGJ5Flw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7I/Z2vpaeifMZi6d6eZLGcIr11iGtBrsQwcMGy+RG0=;
 b=F9M0mBhOGCKU9BFcHCef1B65GP7WjoMCp0oxMnJDNrPgQMklIGvJz8h9lrrMLiXyVAW7iuzZphj4Cizx2axxMxhq9H3QXD8wtkBpheGkCemUT+dfw9wfWbeIM/epLJzSVgfPdCfV3Hb8MFx0KEdxVi+/2EPMOa3VoDaBAT19+pI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GVXPR02MB8256.eurprd02.prod.outlook.com (2603:10a6:150:6e::14)
 by DU0PR02MB7991.eurprd02.prod.outlook.com (2603:10a6:10:352::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 15:01:12 +0000
Received: from GVXPR02MB8256.eurprd02.prod.outlook.com
 ([fe80::6044:5761:b269:8f3f]) by GVXPR02MB8256.eurprd02.prod.outlook.com
 ([fe80::6044:5761:b269:8f3f%4]) with mapi id 15.20.8445.011; Thu, 13 Feb 2025
 15:01:11 +0000
Message-ID: <7b7d342f-0487-423b-86d0-fbbf5987ecfd@axis.com>
Date: Thu, 13 Feb 2025 16:01:10 +0100
User-Agent: Mozilla Thunderbird
From: Alexander Ganslandt <alexanga@axis.com>
Subject: Roaming questions
To: iwd@lists.linux.dev
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0013.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::19) To GVXPR02MB8256.eurprd02.prod.outlook.com
 (2603:10a6:150:6e::14)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR02MB8256:EE_|DU0PR02MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 87715a50-14e3-4041-7926-08dd4c3f4139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVJsR0tCejBuZlA2aE5MWTZqVFBoQ0M1V0lTZmdKVFFDWjFxdjVGTUN1cnow?=
 =?utf-8?B?NVR2aEk3bkZ4SlFidzE2SEsxL3huTmZOamoyR1R0M3YybFE0UkpHMnUwb1J3?=
 =?utf-8?B?aWZMb2x2NXNzaTl5b3JjVFBCL1pJcEE0UExVeFEyTnlKZWw3OTRhM1l0bzNi?=
 =?utf-8?B?Y09WbDRLNHY0dlZIYkF5aU1OdHpOdTQwcE15WThFaDJqMVdJY2ZWbUQvRG41?=
 =?utf-8?B?VTEwSkF4RlJKRW9adzdJVHp5MWJQdEFYaWVOYkt2VWUxQW9KTFBqUWFQUGdm?=
 =?utf-8?B?RDBTam9OUGw2NzROYjFmcXQyQmFJYkUwKzl4NlVtUlo2WWhIVU0wbmV4WlI4?=
 =?utf-8?B?d1oyUmM2VGpWb1FPRTJIWHNaVy91ZGNNdWxqSTdEMnl3eG5MYzY5ckNBaGdN?=
 =?utf-8?B?Uno2WEZJRnAvcFJCcXQwcXJNam1NSTJKR080alJGd05MdVV1MjVISUpjTlht?=
 =?utf-8?B?NkQ1NFNQRzFsWjFVK0lHS0pKbUE0a2dMU0NHSmJ2NlF4TnVvRi9rM2VWREtm?=
 =?utf-8?B?SXlVbWZwV0JkbVdUQ3pkWjlHdERMTVlmcFo1OG0yUG9WQzRua04wRWtTTHg4?=
 =?utf-8?B?Wk0wVXgyZ0VkZTNrOE44ZkVjV2FMQ0tjWS9RdFE4TC9HbWxRRmFKay83YXNS?=
 =?utf-8?B?aFlQRG5ZWDVzT0g5eWZSRzdUb2U0cENIUUw4cEpPVDdKUVJGYWpDakRXRHFQ?=
 =?utf-8?B?NFl6YTJXTys5bG9uS0JUZFcxNTEwRHg4VE5IYm1sb3NjMXRTZWg1Mk9lTjI3?=
 =?utf-8?B?RmF0UFBCamIwdm0wV2EzeFo4dHFkNTN6WU5MWTI5TnhXTHcyT29EWkZsSWtU?=
 =?utf-8?B?RU9mQmgycEhmbXpjc0hSeFUwcnpVUUE2MWwvbkZIUkJWVjZCMUpCaFFzVkxF?=
 =?utf-8?B?QmZaN1gxQlA2Q1I0RjlnT0liVllKNk15NGJaREN5SWhCYkIvODREaHhEUTdQ?=
 =?utf-8?B?ek1GWGdiSWptU1VxVHp4dnZ4d1NJZ2xSWENSWkU4bGNscndGa0xObDNDU0Fq?=
 =?utf-8?B?cmpkaklXL1RNWExBRGwxYVV1dDdDOG9jLyt4d3BDbGc0cDJHWDJHSHRPTnUr?=
 =?utf-8?B?N1psblpFay9GTzhkUW1pUW1lbnVjYTFIMnhIZ0pNVnlBYzdiRCt6aW55N2ov?=
 =?utf-8?B?eVEzQ3MwTlpjODVWTFRmakYzM3BRV283UWNjY3ZMakVMYjR1T0JPQ3B4Tjdr?=
 =?utf-8?B?RUErR2lvbTh3VTJDMlRZUG4xNEZQc0Zoc25DaC96K0kySE5pVlNMcXdWa2xj?=
 =?utf-8?B?RUtCY3hMWUdBNjNsR2EyVnlYa2pDM0hsQm0rblJSalVhYkwyc0VjWGx6K1dW?=
 =?utf-8?B?aFd0ZUZRL3VMRXVKSGxUQ2txdi91dTFjb2hMTjRSNzB0eVJWaU1vbFpiRHVq?=
 =?utf-8?B?RFpvS3IyWkhYaW14MUtRbXJVeC92VTJpa09vbGRnQVZBODlEM1h6U0ZxdlJI?=
 =?utf-8?B?ckpJZTJEcjFjVFBVTlBVVzhSSGUzcE1PNGpkK0xqRWxrNzJZaWUrQ0VpUkk5?=
 =?utf-8?B?U3A2TGRkMktiK0J1OVZveWw4V2tONnZmbkZtRUhUSkVVbEsrZnNpN3lqRTVB?=
 =?utf-8?B?TlNCclRrRnBiVkJjZ1k2SEk3SFlVcE1jd2ljbTIxYVRRNzFPd3JpZ3hMNWpy?=
 =?utf-8?B?WFFPcURyckZOcE9VNmc5UzJPbTJ0YnZENFRKNTNXUExiTHM5NVFoZ015bWQ5?=
 =?utf-8?B?UGg0cFJKaGRxWnhxQmM0akdxc2F3UUZrWHJyRXJ0Z2czb0NoWGtObXdlTUha?=
 =?utf-8?B?TVdRSll5SDR0Y1laaU9lZ0RTL210U0lmb05NajAzMjI2VlF1NWpHWlZXUWtp?=
 =?utf-8?B?cjQxRUZ5SFZwRElvQldvZjdDZlFpTy9INmR5L0habVBzdHJySS9WZjl1ZlZ2?=
 =?utf-8?Q?/7RAUBcpDgiV5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR02MB8256.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3ZnR21HWUJzSkc0bVR1R0ZmdUZwaU0rVEcvdmlkZ2dOQ3FHaDJqdHBZeFAr?=
 =?utf-8?B?em5XYlIvSkYxNTFGNnJjbFlGaVpxTElZUEFiNGpDVjd1QnlVdFJ5S1o0MjFK?=
 =?utf-8?B?UTJ0QzB2cDBvc0ZrZWs0UjdhZlhHNDlWL2ZzTnpnQnFURGttUFdtcGlsbzBu?=
 =?utf-8?B?bFAxa2NOOUVndXhKbStoNWorbUl2OHorY3RMVzNzcTY2eTdPK0wyRFRueWhW?=
 =?utf-8?B?aDhsRGkrZjlQQlNOU1lDTk5PMXhwVGI0d1AwWEROOEVycktlcUtiM3JJTmwy?=
 =?utf-8?B?cHRVTnJSejJaZEFEeUZmMGpyYzQ4VWZ4QUIyNGtrcHRkK0s3cUMvWHlBZU5o?=
 =?utf-8?B?Z3pJWjlicVA3aUUyd3dYWVQxWEZXbGVSSXZrUVFNL2lJUVRnUWU5M25Yd0hu?=
 =?utf-8?B?VkpkQ1JaQTZKajJPKzFIeFVMU1BkNTFCUWg5eVNlM0ZBdmcyWG1rMGJ0QXc4?=
 =?utf-8?B?aUpsWU0zRDFPOHpyUTFBd001QXN4VmhVN0hDQmhaZnhXcTlWSlJ4bldIM1BM?=
 =?utf-8?B?NWVzeHoxUnFLSHNJWFNHWUtMNzhWeEhDZVA2R3RCMjZ3aWRTb0dlQjFqclhw?=
 =?utf-8?B?bWY4L3ljRU94ZXY5dHJ1SXVKWHNnLzlpZ0lEYjVPcUNjWHU0VVdzekUyRXcz?=
 =?utf-8?B?SzBsK0tTUUd2VEFKNnkzMCtKZGZKMFk3VUJTS1pwbDN0ZjVrVTljS0FISWs2?=
 =?utf-8?B?Umo5ZFRmU0pucmJOVjU3QVMxYktYaGthUHB5R0xZOWV3VjAzdkJRWS9vdFdj?=
 =?utf-8?B?elcraUw0TXJwQXhQMWtsbitRdWVQTHJPVU5KdUlwNWdEY0EzaEtlT09zUWpz?=
 =?utf-8?B?VmwwMVl5OFM2bkt4TSsrUFhYMjZMQ200aEpDeU14KzB0cURjTENIMzRRb0xD?=
 =?utf-8?B?SEsxYTF6cTZYUjhkUmxtWHdmZkc4Z2NMSG9Hd3lLVnpIU296ZTExRWJUai9q?=
 =?utf-8?B?S29hbUZrU2t5eVY3OEJxZHRIbTRoZ1lRd3dZVVdtYW9ZQXgvdngrU1dFdzdV?=
 =?utf-8?B?dmFBSzZRSk45QUttZFphc05VT08xM1FzK2tGTzNFWEdtb0hsMTdOaGtpTkYw?=
 =?utf-8?B?Mk9yRDlpYnFEQnVCbklSU0N2dlNWeGxIZ0FPd2hmYzhPaW5wK0lORWpCYkpn?=
 =?utf-8?B?NmlacGREWHJpU3lQOTB4a003N1Z3a3RlVjI1dW5uWC96ejJ6aElzQU9Gdllz?=
 =?utf-8?B?VVhraGVJUGVOcnV5T01uNmc5OWdTazFpSGQvelAvTHpHODZ4eWU0R1M0b2V5?=
 =?utf-8?B?MURnZlVhTVdRYkcrc1hZdWhGNzA1U0JTUWs0aUJuekZmK014bTNhUTVlc2VO?=
 =?utf-8?B?M2ptUWdFT1ViZVk3cVdXVjBCRXpxV0hKRHpsbWpOaFdRblB5dk9EVUVNbktU?=
 =?utf-8?B?dlo0c05RWlFTSDZ5WitCTURWU3hwcmpHMnhPSkxhclhIZDdJcmFDd1ZkTXU0?=
 =?utf-8?B?Ym9hUVRUdllVOUk2bGZnSEYrK3dzMS9OVjdDWFc2S0p3aytaaUlZTmhlSEg1?=
 =?utf-8?B?aW5UUFBKcnRZbkFGOTRFRHFzNnhuSzFMNXZ3WEpNUGRHVnJsdEJQSXNRYWJ6?=
 =?utf-8?B?WmcxNUFkWEFSQWYyYWJmei9QcmdNblZSMXcvQTJFc05MV0JyQ28rYUttZm1p?=
 =?utf-8?B?SFFLczdCTTUxR1k2NkFrZms3ZHdDK25lM2xOMEdNYzFHTHRtcHhQanExS01h?=
 =?utf-8?B?czljSVVLUnZ6NE1NeTZpWWtjenRTZGdGZitCdXh4WVQwVGlZckZmYkwxSTlX?=
 =?utf-8?B?RTNwOEZFTjhxbzhFQVZlVXQ2YWZhd3dPa2VBaEgyTEl4eS9uMlA5WXNiTVlO?=
 =?utf-8?B?YkN5cHhiVzFzY0prc3JycS9NY21hdUM2OWFNS2JVVWtLVGpvUVBxS3lWRlp1?=
 =?utf-8?B?bVFteHV6NWxxWGZuMGQ5ejNrWW5DdW9TL0VHdmpGWVBDKzVvQkhvd3BGVWt4?=
 =?utf-8?B?TlI2NWJiUUhJS2Z4ekc2QlNFbEJBbUdFVGlNd1QvVk1oaFpocVRIZGtqcHE5?=
 =?utf-8?B?bDVybXFtSUFsRkNjTE91a0YyTGtyQ2pwdU9rS1paaGJmT0Z2T0JvYkRxY0J3?=
 =?utf-8?B?S0RPSWc4emhSeUdKelIvNHF6L2pGU1JOSWs4TGR5RVBoNnJtV0FpTkNpZ2NQ?=
 =?utf-8?Q?OCmCIoVeDI3G0WOpwV1Z33RsW?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87715a50-14e3-4041-7926-08dd4c3f4139
X-MS-Exchange-CrossTenant-AuthSource: GVXPR02MB8256.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 15:01:11.8784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UntB9uzcKNLmMDkKGrRsAKht/rNu3Utn9NQ4eHrOPPx9UV7D7W3DN2/DpcTryH8Pk4I7Z2j8o0OvFbwBT1lckw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB7991

Hello,

I'm looking into different roaming solutions and currently evaluating 
iwd, which seems promising so far! My use-case is a device live 
streaming video while moving around large areas, and the goal is to do 
so without hiccups in the live stream. I have a few questions:

Looking at station_roam_failed(), it will schedule a full scan if the 
previous limited scan failed to find a better BSS to roam to. A full 
scan on our chip takes about 7 seconds, which is often enough time for 
the signal to get low enough to deauthenticate the station when you're 
moving. It seems to me that a better approach would be to schedule a 
scan for either the "known frequencies", or all non-DFS frequencies 
(since passive scanning takes extra time) or some other popular group of 
frequencies that won't take long to scan. If we're lucky there is a good 
BSS in that scan, otherwise we schedule a scan for the rest of the 
frequencies. In the worst case, this should be identical to a full scan 
with minor extra overhead. Do you have any thoughts about this from your 
side? Is it something that could be accepted into iwd or could it cause 
issues for other use-cases?

Another question is about the "CriticalRoamThreshold". There seems to be 
a config for this and some functions for lowering and raising the roam 
threshold, but I can't see that they're called from anywhere? It seems 
to me that only "RoamThreshold" is used, or am I missing something? 
There's also a hardcoded delay of 5 seconds from the point where the 
roam threshold is passed before a scan is started, is that just a 
"hysteresis" to not immediately start a scan if the signal temporarily 
drops, or does it have some other function?

Thanks in advance!

Best regards,
Alexander
