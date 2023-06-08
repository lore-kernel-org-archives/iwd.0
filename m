Received: from esa2.midmark.iphmx.com (esa2.midmark.iphmx.com [68.232.137.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997428F3
	for <iwd@lists.linux.dev>; Thu,  8 Jun 2023 15:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=midmark.com; i=@midmark.com; q=dns/txt; s=key1;
  t=1686237592; x=1717773592;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=9d6TtCohFh1Y99mxBbh/0sxBJO0Jj5VuaAx0P0offao=;
  b=HhxRIvgYlb66gbQZLDAgeGtOFqrFa8M77iajxodmD4WHYN2yjberhuOU
   5Kd9+v4ULYgH46JwHlWTpg8RGQRbWnfsfPyDEyNXYeQSf/LVTeUcm2mll
   3+6BDpUBFQ49Ola5LPMM18473cFLs0RH6KwN6uGyB7XYQdM7au5REKira
   Y=;
X-IronPort-AV: E=Sophos;i="6.00,227,1681185600"; 
   d="scan'208";a="70158549"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.midmark.iphmx.com with ESMTP; 08 Jun 2023 11:19:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhAzax8wr53D2T4qQO5eFyWRpIJjA3+H9yFN8lE4Ennc8Tr4UTQN1S0diuffcVR3IWjzkxap50j5QE8UwxCUjZfIVw7QABk3FmDsISk56fFJbxxh3Mlkteerk0msehy5PkbX26cz4h6+ZpWceRx6YR7XpqE7ekiuMggdrgWv0I7igOn5pWOLciEC0C99s4Q8DRJ2YY6deyTUs+vG4KGBDlMAi1+PnUpSICY4lPcrdR+K+7uuy/e+GM0wLuyV39WcNR+obSIypGncB3slyNqq2yI7XjygWhzKG3vUQSdMqDD+WPEBrDNnEsVU87/0ejOl5iBTk3O3176bXArhEZvLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyD989SCfEQlfYP+jhJDThh/Yx2kvtD+3sMIKcGjVws=;
 b=RKWUyKt9XP4zdCPNMOYNcPCwDVECGYxFPC9BQ0zXcSrB//PUaiiqgs6LHLaohk2AVBxHMnIJkuhCSGI+AGG+7ghhsV6drH8LbDnSTLJT/aLzRHU718u4qhJrBpDqlDRYa5tQpPNeE7BK0Me6FytzPGnio/jnPaaq2yR842uZil2XvXPI6GMjLNs+zGaNNSQQatrI2Sap1njNxcjSP0RlhqIki7Uqm12YqGct//pBip9AKcChF7B/Oae8ijihOqXMKYov1QbUfFfWIQyq7mqd5dVvqjJMBmD7Py8sOkyqb5uXXuGvqv+tM8xBnpXHCw0S/p5Zf1+ok3qNQWQK7g8yQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=midmark.com; dmarc=pass action=none header.from=midmark.com;
 dkim=pass header.d=midmark.com; arc=none
Received: from BY3PR08MB7220.namprd08.prod.outlook.com (2603:10b6:a03:365::15)
 by SJ0PR08MB8436.namprd08.prod.outlook.com (2603:10b6:a03:4e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 8 Jun
 2023 15:19:47 +0000
Received: from BY3PR08MB7220.namprd08.prod.outlook.com
 ([fe80::533b:41ab:1b5b:7710]) by BY3PR08MB7220.namprd08.prod.outlook.com
 ([fe80::533b:41ab:1b5b:7710%7]) with mapi id 15.20.6455.034; Thu, 8 Jun 2023
 15:19:47 +0000
From: Michael John <MJohn@midmark.com>
To: James Prestwood <prestwoj@gmail.com>, "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>
Subject: Re: Bring up of AP fails on certain channels
Thread-Topic: Bring up of AP fails on certain channels
Thread-Index: AQHZmhFyDLlZeiSnFEKt5E31PIosMK+A+LKAgAAKFk8=
Date: Thu, 8 Jun 2023 15:19:47 +0000
Message-ID:
 <BY3PR08MB72207A7A2387AD2D2908D805AE50A@BY3PR08MB7220.namprd08.prod.outlook.com>
References:
 <BY3PR08MB7220600D62E8C2FD1334253FAE50A@BY3PR08MB7220.namprd08.prod.outlook.com>
 <826c0918-84ee-649d-2f4c-10c99e0e45a2@gmail.com>
In-Reply-To: <826c0918-84ee-649d-2f4c-10c99e0e45a2@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=midmark.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR08MB7220:EE_|SJ0PR08MB8436:EE_
x-ms-office365-filtering-correlation-id: 76896c40-f8da-4d89-c4e1-08db6833cb8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CM/PMUz7WX6Fk8HF4w+xoy4bIa3jAJoV/FDzo3MdzPXZxzNNjyC/sxPiD0uwfh/GKWxE1vvRvGyLqDb9QVy+qiH5ylSDHI85HiIwNQV+CcT4i/sMidCl/W338h+nTrqweJQj15EgKbOG4y7+j/J4K1jRc8957GYwJEgNYlLX1rKeesUE5hzsbKSb0R7ZAhWU3wCHwjUhH1O3QCYq5Je8voO26Tc1eNYtoKc7FBjNZwm9EXBg3VnwtEnJUggRKr0+9K8ayvOxRwqnIOcFCCbl66tXTa1wd/64dOshEznHZSDGFtGWSY0NwWWkCvTvWJLMoNJkLCVEVIQYeB/3yXqxAJtF7hofTOz4HZT6NBsDVlx8h7OFv1KzEwhQzGQOXXOzZNWpa+t6yiJGoUVwPc07/coKGsPv3uc0o3KWwe3HbNZByvrLNM8o6mYmysSeoXtSqzVUk1mrO7gzhsbRtNGdEnbPVY1j8OwuYCg+FWzn3tj8+aa0JPXMx9CKX/U5c/LImbLLehBzV5KGvedvSHgtM3KaGVCUr0r+430SGJaI8pr+nh2XdI6OtmFPntGCw7xEgTCONOVGCazgrRQ5TuHzWJ9/1rBOGQrouf971wIzLVKw4QgeQhXKgz5RxXvZrdNZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR08MB7220.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(376002)(136003)(39850400004)(451199021)(7696005)(316002)(41300700001)(83380400001)(86362001)(38070700005)(26005)(9686003)(6506007)(186003)(33656002)(2906002)(122000001)(38100700002)(55016003)(5660300002)(52536014)(8676002)(8936002)(91956017)(66946007)(110136005)(76116006)(478600001)(71200400001)(64756008)(66476007)(66446008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5aM5jlldRfO/TdbCiuPzN4j54GD010KVgwjDIEIz4H2SKwKGmOo9T0usGY?=
 =?iso-8859-1?Q?NjHH3LpuqGeGsqc3d3T/D8aZxw8T1E+OpUkA7/2XdDwD18EKlJkfsC+M+1?=
 =?iso-8859-1?Q?/bcoZUuuiFJGphhigy+ej+pjIrKcYloUOgk2ZaMKYpw7KaSp9+bUDd97kY?=
 =?iso-8859-1?Q?RtmBio5GW3OVdYZzNDG6XyxIMxLL2UoaHcgfqidoPwSe4ChGwZCYkZ+Qka?=
 =?iso-8859-1?Q?4HnYWtieMYNA/HX7AxNRrD8F8BXH3vs1I+42+hdoCfh8K8rqDu98B7FuRF?=
 =?iso-8859-1?Q?l7n5+Pp7AqEQDMBwAvqk2ds5xRC5JwKl1dll3fHO5JXVct7XJ5EpYaQzzj?=
 =?iso-8859-1?Q?GwoXTYBd1S6BEpxzLHgP5JWE7Wg1iA8DR85qtNmdgrOR6dJXQ91UfQ1LRN?=
 =?iso-8859-1?Q?yIp35Q18QiaMGnLuFrfMmIScLM20f704y8ABkKrEc6WsTlhTmhbzTYB3yg?=
 =?iso-8859-1?Q?anFgGf/0xxcGlSqFa0JT5/BrtC6LwIb9s5uwBEZ4sakneuK9+rBCyJ7Ygv?=
 =?iso-8859-1?Q?sfUHc7AaEzNMJMu6B7/TJcJuD6+XX37dq1WlbDKaT88jRLZKfyF/1gShqY?=
 =?iso-8859-1?Q?5j3Uyrgg747ofimNv66DYBQxk/TeWwPaQYeCNlyFdP2dzbcrsx3y4YKx52?=
 =?iso-8859-1?Q?9MEEpcAM6YMcaNRL/Fdr48rFbpnj9pCwRLLW1gqXkvM7I4MO3Z3lK74QmG?=
 =?iso-8859-1?Q?jEe+5M+75y38YIc+PWskWZD9Skdid9+twWXUq2HaefzywhcBl0B/N288lk?=
 =?iso-8859-1?Q?k9m1Yx6Ti+4ax06spJwVkbVKlbgahH2fKEymWYVoCAkAqAsPBKy9whbeSu?=
 =?iso-8859-1?Q?XxN7rhh5ugyQM55MLiyb5A22TrSNSnG83lAP1k0g/NUPLZYjC1L0lObJsY?=
 =?iso-8859-1?Q?l/N0ECFAK/rwVtafJfvuv6p6UgGK1AMAmfUBDnLGCpEkuO1BKYvzX24aJC?=
 =?iso-8859-1?Q?WeJTjN2Oc028gkii4fbqHHXEUi2CjswDrVX96s7AUvUua2qL6rX3I8XK2T?=
 =?iso-8859-1?Q?LDnCmb5BD90IsR1oBbtvJI0OWVjIXdgSJI3wEiqekDycrCSw1KEcKCy6Yw?=
 =?iso-8859-1?Q?76c84UrqeyTqtpO/9hsBLhnIpSPjnWquqNj8t3u8WxaUU85kkyFCwCW9kp?=
 =?iso-8859-1?Q?VBarq9ZSt9H/WJ7458TE+xHwKSf8g2ZqQRNHjMIbiai0ML2q1wUCCKW9lN?=
 =?iso-8859-1?Q?azsf8uv4Vl09WD/dijLJuVP7XziegPG4Z+vFoOGRIrf8vykJfztAswm5E4?=
 =?iso-8859-1?Q?nP52z+eiQYzuldQ7aEM0y/nE5o6yYMRTIELOH/wBDvd2Pbk9ubqzlfFVXq?=
 =?iso-8859-1?Q?ApzXbUvJb0arcoGcg4+aoaGT0+JrY2evh2hLG1yuFTbdKaVtVo6fRtyRAL?=
 =?iso-8859-1?Q?gJ/vpAQIAxP6m7zYVM2bGGh/4Q1WSmqSlzV024e3Ll78UUvstA66aVQyEX?=
 =?iso-8859-1?Q?gKoHDcp+UU/OjrMoXunysd5AawXIW2Mo2DzUeLg6Kz8BhllFEfoK1o8niU?=
 =?iso-8859-1?Q?nRQFlynvlV/0ED39/WeU/QdfdAjMznymIHC5QhFv/gYvIH/puAduzohe6B?=
 =?iso-8859-1?Q?nXtqzcyXGdaKrMkrq7DHwkYpRCJcD2vvf72g404XTPe12AvDf2ycU5zR3I?=
 =?iso-8859-1?Q?KLXcxsbJdPx9A=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: midmark.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR08MB7220.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76896c40-f8da-4d89-c4e1-08db6833cb8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 15:19:47.0364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3c2a020d-f343-4ca1-b6ef-91768380352f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v9Vee068oqwUDt8P9kFippGMOLewej7W9VZs1emPaEWu5gFchrH8Jgr+TClvhpI5qeTs8dhiv2Wtjpd4RT+Bvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB8436

Hi James,

>
>Hi Michael,
>
>On 6/8/23 7:01 AM, Michael John wrote:
>> Hello,
>>
>> I'm trying to bring up an AP and ran into an issue where iwd
>> will fail to do so. My AP profile is below and I'm trying
>> to bring up the AP on channel 64 but iwd gives a failure.
>> If I change the channel to 6 iwd is able to successfully
>> able to bring the AP up. I'm curious to why it fails
>> if the channel is 64? The reason I needed channel 64
>> is because my radio requires the AP to be on the same
>> channel as the STA when in AP+STA mode, and me test
>> network  for the STA is on channel 64.
>>
>>
>> ~> cat /var/lib/iwd/ap/470034.ap
>> [Security]
>> Passphrase=3Dmyphrase
>> PairwiseCiphers=3DCCMP
>>
>> [General]
>> DisableHT=3Dtrue
>> Channel=3D64
>>
>> [IPv4]
>> Address=3D10.42.0.1
>> Netmask=3D255.255.255.0
>> Gateway=3D10.42.0.255
>> DNS=3D10.42.0.0
>> IPRange=3D10.42.0.50,10.42.0.60
>>
>>
>> ~> iwctl ap wlan1 start-profile 470034
>> Argument type is wrong
>>
>> ~> iw dev
>> phy#0
>>          Interface wlan1
>>                  ifindex 6
>>                  wdev 0x3
>>                  addr c0:ee:40:64:4a:1d
>>                  type AP
>>                  txpower 23.00 dBm
>>          Interface wlan0
>>                  ifindex 5
>>                  wdev 0x2
>>                  addr c0:ee:40:64:4a:1c
>>                  type managed
>>                  txpower 23.00 dBm
>>
>>
>> ~> journalctl --no-pager -u iwd --since -1m
>> -- Logs begin at Thu 2023-06-08 12:39:15 UTC, end at Thu 2023-06-08 12:5=
5:04 UTC. --
>> Jun 08 12:55:00 V2470034 iwd[1229]: src/agent.c:agent_register() agent r=
egister called
>> Jun 08 12:55:00 V2470034 iwd[1229]: src/agent.c:agent_register() agent :=
1.193 path /agent/2814
>> Jun 08 12:55:00 V2470034 iwd[1229]: src/ap.c:ap_validate_band_channel() =
AP using frequency 5320 and channel width 20MHz (no-HT)
>> Jun 08 12:55:00 V2470034 iwd[1229]: src/ap.c:ap_get_gateway4_mac_cb() Er=
ror: Operation not supported (95)
>> Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type =
0000: -114
>> Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type =
0020: -114
>> Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type =
0040: -114
>> Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type =
00a0: -114
>> Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type =
00b0: -114
>> Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type =
00c0: -114
>> Jun 08 12:55:00 V2470034 iwd[1229]: START_AP failed: -22
>> Jun 08 12:55:00 V2470034 iwd[1229]: src/agent.c:agent_disconnect() agent=
 :1.193 disconnected
>> Jun 08 12:55:00 V2470034 iwd[1229]: src/agent.c:agent_free() agent free =
0x1d57d18
>
> One thing to note about AP mode on 5GHz is there are many more legal
> restrictions. You can check if 5320mhz (channel 64) has any restrictions
> and look for the frequencies section:
>
> $ iw list
>
> Frequencies:
>      * 5320 MHz [64] (22.0 dBm) (no IR, radar detection)
>
> For example in my case "no IR" means I cannot emit any radiation, which
> prevents AP mode from working. It all depends on your hardware, but
> sometimes you can simply set the regulatory domain to unlock those
> frequencies. IWD can do this:
>
> # file: main.conf
> [General]
> Country=3D<CC>
>
> Or you can use:
> $ iw reg set <CC>
>
> But in my case I'm using a 'self-managed' device (iwlwifi) which doesn't
> allow setting the regulatory domain. For me, I would need to scan as an
> AP first to get the regdom set, but IWD does not currently support this.
>
>Thanks,
>James

I appear to have the same restrictions.

For a network configuration is it possible to specify the BSS you want to
connect to?
For the network I'll join there are multiple APs available, it appears iwd =
is
selecting the best 5Ghz AP. Using the 'BandModifier5Ghz' option in my
config I'm able to give preference to 2.4GHz APs to partly avoid my issue, =
but
it would be convenient to specify a specific BSS so I could avoid one that
is on a channel that I have a restriction on.

Thanks,
-Michael

>>
>> Thanks,
>> Michael
CONFIDENTIALITY NOTICE: This message, including any attachments, contains c=
onfidential information intended for a specific individual and purpose. If =
you are not the intended recipient, you should delete this message and any =
disclosure, copying, or distribution of this message, or the taking of any =
action based on it, by you is strictly prohibited.
