Received: from mx08-00440002.pphosted.com (mx08-00440002.pphosted.com [185.183.31.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B44E4A04
	for <iwd@lists.linux.dev>; Mon, 26 Sep 2022 22:21:14 +0000 (UTC)
Received: from pps.filterd (m0267190.ppops.net [127.0.0.1])
	by mx08-00440002.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QML6TZ007805
	for <iwd@lists.linux.dev>; Mon, 26 Sep 2022 18:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pselector2;
 bh=olMy7EqyEtFYMbBsZEb8WDS9kaOVt+fwGo0iBUYyceM=;
 b=pyAzECIr0mUeRQJssq8ASXccDfyE028yEu3p22JCKN4CioMpDyIomYL9UNfLxunmNV+I
 8Nze15FEU0J7PKb5f7pdl8VBfGtkSq+a87M0Kj93I/t3JG1TSCdDWr4jg0OIoHOdWFX5
 iISRsALYKl3sF+BB2ugCkn2od5kOqys6NMZJu4LDJUUHEu70zfdj2c+VuueSshjsYNDp
 zvn5OP/691SsNRzi7/LLnqWGi4N9d77dj63mqzX6te/6FLLDBxcgfspBHvsauGjp3b2b
 uQNqI7DqhCFV6UNWjvmoZtw2EkkPdU7DiCPCJnCjs07W0xkJQJKT+LRctD/lP6GZ7cFI jA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pselector1;
 bh=olMy7EqyEtFYMbBsZEb8WDS9kaOVt+fwGo0iBUYyceM=;
 b=Jj3uK38DuLZEaDHiwYhvmXFSp8pGjK7H2bHxK9okeWEZrXTteY25mO294jqI1YCLE3xa
 58HwAL3CdlAzUPWSP8ia+9ausU2Ekxnea1WvoJLgBcO4sMCCAEy9otQvo2jkJQkRrfEQ
 A23eZg1J9bBjxOtz2IpLP+c7tohjsdmVHUzf5ZAsAqKSrEgsp/ReuJgtLZ5iulxfHKSm
 gKjjR8qCXrYvlAoAMF7elDy38AojoQ7z9SqVS7w6ib07DBL+jqda1BcND71xSA1r0jDy
 2vY9wh2ZlFImVJyDODnS8COmbmcenUnjMaCJ3NGHPIey5TJg4GxgDq9b4Ol23P38L1vR hw== 
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105])
	by mx08-00440002.pphosted.com (PPS) with ESMTPS id 3jsvjwa7b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iwd@lists.linux.dev>; Mon, 26 Sep 2022 18:21:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kttveCjLc1/9ygVaH7pwmqqL6ik8ck+62ePvYScoYmGqDVnaxNooTVgjjfJIxnwc5/X1Gs4cyeHwIhLyTN4aUCv8rWHL8CHqVejvt4WktT6OBQPibkL6gTjEdQgKPQ7iaosRt/08ALSto6ptN+vkcZhYeEQ+UUUK2mAfgD4O9Js1si1Cf1Bo8sKZ4ON+2dHC/SPaGP5p3aadVRj+r9k7njvV8PPwEnMgM3rCJ6W3bTMASWlmqtGoFDWZx/717VBE0j7nOwWc56ATlPhvWkUT3Za6mKH+SwBBsZ5+ObQXrOXDuAwvua26jOpnsYAJLu0/3O+WVgFoQF3/rx0vQeMNjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olMy7EqyEtFYMbBsZEb8WDS9kaOVt+fwGo0iBUYyceM=;
 b=LvQSQg2IosH8/FDkK0bwq+9W3SwkXEf3wCUApN3Nfj9+cx9zjHa7qVyO6gAg1GTwvY1j8e7SUC+Ka+quPE9pRHdEir/RFApYluUKmgk6QmssPBTZEHtJKywdRrRBIqIWuWC28WSkRm4ZEiL0msAEQs/zdQ2OJLgU36rsGWuW+DfrR8yKxXfj84wbI0r2fULnuaSRCVpnnhmJoxCLp7/SlL5R13CoNopLWkVfuS128ndAd/smQ6gLyhRN/OVHqmYBqYL4ISXCB5iJOXK3PKasMKy4cYLqzzQS8VdxUvL49XRPk93dZpGbV/eDoTpvgZHSylAJFGvIoq7s63ETFR+lNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=landisgyr.com; dmarc=pass action=none
 header.from=landisgyr.com; dkim=pass header.d=landisgyr.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olMy7EqyEtFYMbBsZEb8WDS9kaOVt+fwGo0iBUYyceM=;
 b=mfO/MmYmGDdaSUlQaoguSrl6nl9Ff7jUbtjr8j1DFXZn/ij+EK5jyHozleJ2lsaRgIk8HDHRex52jq90JT+kEJXuxf2PQ6isO2/hTy9vDDskD/QHvRZeJ77Mc1t1RS8tpNBq9k5F4MVo21PlE9hpmu6GWXB97dw6tXsGgpq8rso=
Received: from PAXPR01MB9217.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:2b1::18) by PA4PR01MB10110.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:263::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 22:21:04 +0000
Received: from PAXPR01MB9217.eurprd01.prod.exchangelabs.com
 ([fe80::7055:a44:30c5:983c]) by PAXPR01MB9217.eurprd01.prod.exchangelabs.com
 ([fe80::7055:a44:30c5:983c%9]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 22:21:04 +0000
From: "Johnson, Bryce" <Bryce.Johnson@landisgyr.com>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: IWD dhcp issue?
Thread-Topic: IWD dhcp issue?
Thread-Index: AdjR5Sdp5fEpeP/YRLClAbci1XoOuw==
Date: Mon, 26 Sep 2022 22:21:04 +0000
Message-ID: 
 <PAXPR01MB9217E777D1480543FFEC84B5F4529@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ActionId=9877ed04-25bd-4722-921e-88b8ae4d0a2f;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ContentBits=0;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Enabled=true;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Method=Standard;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Name=724d29b2-602f-4b77-ba15-b7b42511c7c5;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SetDate=2022-09-26T20:17:52Z;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SiteId=ee2cd48b-958f-4be4-9852-b8f104c001b9;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR01MB9217:EE_|PA4PR01MB10110:EE_
x-ms-office365-filtering-correlation-id: 0cbe17c2-4614-4cfd-fef1-08daa00d66a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 9HcH60TU9PmGXSYc/kHnHCvPojkbRMPExr/STxpb22KnX2uiGnK9sLHFHsXuzi2rolf3p6VeDBKftFukiun+5u6+E33DaLo8KICx7t5xDvpP9qlDtZH+v8F+w8JF6r3GvpqnX/ZBIr0YIQCCWv4mTtv17pDUNtW0s1jfJfP4EIu9KJeqP37HN2cfo3wfdfQB8xosZZFPwrXs5Zv5Y5/BcXhAsBrsPJPpt7JjyY5ud3AdNVMqFMNoADxdkFDV8JQeqRdiFcW8kzrY4220g+Mfamy8CrnXz9U+cx28/N/jl+pRWv0FxbDqrhMM7JHsTCsZPAaKTXWTLmz7g2SlMzb26p0V0dOFP+CWPG076/xay5DKhLpDDlIsZEbJudptx9Mohva0+5raO3Jj0WyGd/OeBJSu777T8hlq07usMB4qzwpg7c7Blmxf9v4vjy/JF92ZSbqrkG84yIa97bxo2CdUU9+OLml1gDx3zC9ceN7t9EkvTPkkLjPaFXktSXkjGvszJ3QGk8+EpWh858hFRiMEYa15NUkFUsDXEpCgRoYkiDyGjxg8e9/BJM8alKsGPFJkG72UupUYck4kooJJS2o6Z/Y5VJf6p7eSwNPpTzWqUv/ZytyMjkeZu16aussxGOX5/fEZJS2s5piLJJu5l25FLvT3HuyWB8W+0Dl9AM3Lp+ikNBTbRd9mXwOFisMjy7MI9RTk4dB1yIVvAcbE+N/mTnXN8ippLC52jGQSIRKFedmzQAG1ruaeuJflLzNMemN//sDaa5eQXMAWk7YpfEQnXg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR01MB9217.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199015)(9686003)(55016003)(26005)(6506007)(7696005)(71200400001)(38100700002)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(122000001)(6916009)(5660300002)(8676002)(41300700001)(7116003)(38070700005)(86362001)(33656002)(3480700007)(83380400001)(186003)(478600001)(8936002)(316002)(66574015)(30864003)(52536014)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?eDRLQp9vaPoghrbh5mtqiG2IIFQm7aEkbl7HJFaAbquMKQ5B81B4X2c4vQ0D?=
 =?us-ascii?Q?KQYirivwzo6WEqg0Q/3skOoP37Ee9yTfuFSzohyF4pdACMg+Vq1jPde5+l6k?=
 =?us-ascii?Q?7HtqEttaYwmzmn+qPW+gRc5GxzA1aK4gM5vzQK3lRva4SKWXjTjpbMYdEYnk?=
 =?us-ascii?Q?xrGkhscTSWyWEbpOY/LyPjaKDQD2s7My2yaCq5uKPWuwfD6LJOGfYw3iyLCe?=
 =?us-ascii?Q?8mj/8hlIYzLsdAA1uDj5FBKvAljFaqHMVgK515yBWBjKEpGzmtvj4xZfe13m?=
 =?us-ascii?Q?kb72EJAvZElsLMnn/iCtN97Wl1rcWMfuIWmSFZAJLezJ2xbFY0/cT+pTazpR?=
 =?us-ascii?Q?+pPgO6pVlMKug3f/GTZEMpXufj+FFUbTsO/vRq72hVFzZ6p58IarpHz6+d68?=
 =?us-ascii?Q?dalYDNeAQXVdfO4z12aTgeU+kqAIFQm4iB3QfPv5/u+B/ivsKwsyPjO10VSf?=
 =?us-ascii?Q?w0PiuwUEElnIy7KIGnCwX1OZnANt9OPkMfbvPlKD7GCDUClCucYwmXX8botH?=
 =?us-ascii?Q?B0FtOmMq+yOy4PbvUu/I47pgLqiidovEgyFS55uvO4yjJ9X4RpbKsyNho1Ou?=
 =?us-ascii?Q?kAXwBhdXt4/BYo5/XQXuvY8dkpmEoLa44JQT5DIg1fs4vn7p4p7mdVDUZb6N?=
 =?us-ascii?Q?m925y/aEC5Bw9PYGUN8AbGTR4/xNqQ5Y5awle+auxN1n3wyQblOVGHO5E0Ab?=
 =?us-ascii?Q?isK0js+4u3yqLfefV7YVORBP1gdiqQBD6oCxDU7zz7e7rALqEnrAgELi7+Yk?=
 =?us-ascii?Q?10alMCxmbtkhjXPkEnV/rNhMwJq3sKmaPZq2nn3JeohIbICBF7aI97HL41ry?=
 =?us-ascii?Q?rfB6YdX+xo9kHtwrn3RJwNYGBuTXw7EY2UL/aGYal9MjxBYVZF/ZvNxXRtSG?=
 =?us-ascii?Q?DfkfN4aKfJkWQtGb0o2IvDp7nqHEEdB0kAId/lE0ZF0agMpX+49ztti7X3/T?=
 =?us-ascii?Q?3A0yl7VBjF2twtGJAXHtzQ+6TM3nV0cCW0pFrRt7WaCxA5z9K9LGWl6r43sA?=
 =?us-ascii?Q?b1VQhzSPPsErsQNpqwdwssESTLrUqdH7s8iRBmRGQkuInAtlykk6G4Te00c6?=
 =?us-ascii?Q?88IAO7w6t9uDP4ki9Jwk5e2FisCWD/zoWsO6P1p8uC4AvK0shgc8D6wSIC86?=
 =?us-ascii?Q?9ksfJcp80Pn4DC1MM8YBiMbPVzpmTiUlBZRWZ5ukOpplb75GC+d74Ykmz0Fj?=
 =?us-ascii?Q?dGtpfchtvIRdTDC3Op7wVA2JVnDa7KRuWaBrsbobn2wBOegW3uaqnBUOHghB?=
 =?us-ascii?Q?yOeStG8/s2x8e6XJmYTrTaK67i/lTjEI00KVTQIpZnrRG4+LYo9etAWeRn41?=
 =?us-ascii?Q?Ali+HACc0qQij8ayVzlW41Aymqd1sx1J5HPHOPmS1HS1jqrjlAgrvlcvdVjB?=
 =?us-ascii?Q?B/nZhOR6eXj87tKpCnSn0DI/fsp0v3M+Y+ZOZ1Coyw6q7HP32ehPuBmAoVOX?=
 =?us-ascii?Q?3poafwH/WIgV0sttMfu6ukx1NZTeFabmgoUi5GgWX9UMjS1VvWVfG5o6+vTj?=
 =?us-ascii?Q?QPAp9MyTv7rUqKm6r2qbysG582+kiwL3QcYfYLUhIRI86ZF83h1jbd/5FqA+?=
 =?us-ascii?Q?ocjLazY7DRMhkXIl+aI66Dr2flI+x2YZdVHRGD+e9KqmwWEkeXkizkiBOthr?=
 =?us-ascii?Q?Qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: landisgyr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR01MB9217.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbe17c2-4614-4cfd-fef1-08daa00d66a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 22:21:04.3625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UbUZma+XbDPep7yOK1GBV0XwPuY727JaNtgVNGKNhWca2WedWH4lxPwOq+AeGo3HxDhOWoVPir3MUEW7XMDRLk3feVsLJrub5KWVMQ/hufU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR01MB10110
X-Proofpoint-GUID: -0JTWwYtSNd3wtfNK2ZGK9mHZgED14E4
X-Proofpoint-ORIG-GUID: -0JTWwYtSNd3wtfNK2ZGK9mHZgED14E4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_11,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260138

Hi All,
I trying to track down an issue that may be related to IWD DHCP (or maybe a=
 buggy router?).  I got 2 devices on the same router one with IWD 1.29 and =
using the IWD DHCP (EnableNetworkConfiguration=3Dtrue).  Another with IWD 1=
.30 with DHCPCD and EnableNetworkConfiguration disabled.

For the IWD DHCP one:

I am getting these Received Deauthentication event several times and also s=
aw one authentication timed out.

Here is a snippet - I'll put the full log at the end:

2022-09-25 11:46:22.648370085  [DHCPv4] dhcp_client_rx_message:931 T1 expir=
ing in 43200757 ms
2022-09-25 23:46:23.405783996  [DHCPv4] dhcp_client_t1_expired:619 Entering=
 state: DHCP_STATE_RENEWING
2022-09-25 23:46:23.486728353  [DHCPv4] dhcp_client_rx_message:898 Entering=
 state: DHCP_STATE_BOUND
2022-09-25 23:46:23.486988397  [DHCPv4] dhcp_client_rx_message:931 T1 expir=
ing in 43200548 ms
2022-09-26 03:58:27.484075832  Received Deauthentication event, reason: 4, =
from_ap: false
2022-09-26 03:58:30.163789430  [DHCPv4] l_dhcp_client_stop:1247 Entering st=
ate: DHCP_STATE_INIT
2022-09-26 03:58:30.701341987  authentication timed out
2022-09-26 03:58:30.701584748  [DHCPv4] l_dhcp_client_stop:1247 Entering st=
ate: DHCP_STATE_INIT
2022-09-26 03:58:31.216295792  [DHCPv4] l_dhcp_client_start:1202 Entering s=
tate: DHCP_STATE_SELECTING
2022-09-26 03:58:31.790039330  [DHCPv4] dhcp_client_handle_offer:796 Enteri=
ng state: DHCP_STATE_REQUESTING
2022-09-26 03:58:31.800427550  [DHCPv4] dhcp_client_rx_message:898 Entering=
 state: DHCP_STATE_BOUND
2022-09-26 03:58:31.800693308  [DHCPv4] dhcp_client_rx_message:931 T1 expir=
ing in 345600752 ms

In that case it dropped off one AP and joined to another AP that I had prev=
iously configured.

The first AP had a range 192.168.1.x  and it had received a 192.168.1.7 add=
ress.  When it joined the other network it got a 10.3.8.85 address, but the=
 192.168.1.7 was still showing in ip addr

2: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq qlen 1000
    link/ether 68:0a:e2:6e:3d:15 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.7/24 scope global noprefixroute wlan0
       valid_lft forever preferred_lft forever
    inet 10.3.8.85/23 scope global noprefixroute wlan0
       valid_lft forever preferred_lft forever
    inet6 fe80::6a0a:e2ff:fe6e:3d15/64 scope link
       valid_lft forever preferred_lft forever

with IP config it still showed the 192.168.1.7 address (that is wrong for t=
he AP it moved over to)

wlan0     Link encap:Ethernet  HWaddr 68:0A:E2:6E:3D:15
          inet addr:192.168.1.7  Bcast:0.0.0.0  Mask:255.255.255.0
          inet6 addr: fe80::6a0a:e2ff:fe6e:3d15/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:168136 errors:0 dropped:0 overruns:0 frame:0
          TX packets:42515 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:15397947 (14.6 MiB)  TX bytes:8289125 (7.9 MiB)





I rejoined to AP #1 and told it to forgot the AP #2 so it wouldn't try and =
rejoin that one.

Now when I look at ip addr I see
2: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq qlen 1000
    link/ether 68:0a:e2:6e:3d:15 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.7/24 scope global noprefixroute wlan0
       valid_lft forever preferred_lft forever
    inet 192.168.1.5/24 scope global secondary noprefixroute wlan0
       valid_lft forever preferred_lft forever
    inet6 fe80::6a0a:e2ff:fe6e:3d15/64 scope link
       valid_lft forever preferred_lft forever

I am able to ssh/ping either address and they both work.  I assume the vali=
d_lft forever here is OK because that is kept track internally with IWD DHC=
P?


On another device with the same router, I set it up to disable IWD DHCP and=
 use dhcpcd instead.   That one appears to be working well, but apparently =
don't see the dhcp renewal in the dhcpcd log I have:

2022-09-22 14:35:54.018588654  wlan0: adding address fe80::1b83:3f0b:41de:6=
458
2022-09-22 14:35:54.668575308  wlan0: soliciting a DHCP lease
2022-09-22 14:35:54.761768202  wlan0: soliciting an IPv6 router
2022-09-22 14:35:54.892327544  wlan0: offered 192.168.1.8 from 192.168.1.1
2022-09-22 14:35:54.964343726  wlan0: probing address 192.168.1.8/24
2022-09-22 14:36:00.397299562  wlan0: leased 192.168.1.8 for 86400 seconds
2022-09-22 14:36:00.402319706  wlan0: adding route to 192.168.1.0/24
2022-09-22 14:36:00.403757565  wlan0: adding default route via 192.168.1.

And ip addr for that device:
3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq qlen 1000
    link/ether 2c:11:65:46:fe:84 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.8/24 brd 192.168.1.255 scope global dynamic noprefixrout=
e wlan0
       valid_lft 85737sec preferred_lft 74937sec
    inet6 fe80::1b83:3f0b:41de:6458/64 scope link
       valid_lft forever preferred_lft forever

Thanks,
Bryce


Log below:

# cat /var/log/iwd//current
2022-09-22 17:31:40.541188969  Wireless daemon version 1.29
2022-09-22 17:31:40.573037719  Loaded configuration from /etc/iwd/main.conf
2022-09-22 17:31:40.724218761  Wiphy: 0, Name: phy0
2022-09-22 17:31:40.729741053   Permanent Address: 68:0a:e2:6e:3d:15
2022-09-22 17:31:40.730502511   2.4Ghz Band:
2022-09-22 17:31:40.731049344           Bitrates (non-HT):
2022-09-22 17:31:40.731983636                    1.0 Mbps
2022-09-22 17:31:40.732179511                    2.0 Mbps
2022-09-22 17:31:40.732333803                    5.5 Mbps
2022-09-22 17:31:40.732480094                   11.0 Mbps
2022-09-22 17:31:40.732620553                    6.0 Mbps
2022-09-22 17:31:40.732755594                    9.0 Mbps
2022-09-22 17:31:40.733089511                   12.0 Mbps
2022-09-22 17:31:40.737616636                   18.0 Mbps
2022-09-22 17:31:40.737991428                   24.0 Mbps
2022-09-22 17:31:40.738174219                   36.0 Mbps
2022-09-22 17:31:40.738325219                   48.0 Mbps
2022-09-22 17:31:40.738467678                   54.0 Mbps
2022-09-22 17:31:40.738608719           HT Capabilities:
2022-09-22 17:31:40.738741844                   HT20
2022-09-22 17:31:40.741867094                   Short GI for 20Mhz
2022-09-22 17:31:40.742095803           HT RX MCS indexes:
2022-09-22 17:31:40.742242678                   0-7
2022-09-22 17:31:40.742386553   Ciphers: CCMP TKIP BIP
2022-09-22 17:31:40.742538386   Supported iftypes: ad-hoc station ap
2022-09-22 17:31:40.742684094  Wiphy phy0 will only use the default interfa=
ce
2022-09-22 17:31:43.483774511  hardware_rekey not supported
2022-09-22 17:31:43.525566678  [DHCPv4] l_dhcp_client_start:1202 Entering s=
tate: DHCP_STATE_SELECTING
2022-09-22 17:31:44.114600136  [DHCPv4] dhcp_client_handle_offer:796 Enteri=
ng state: DHCP_STATE_REQUESTING
2022-09-22 17:31:44.125368511  [DHCPv4] dhcp_client_rx_message:898 Entering=
 state: DHCP_STATE_BOUND
2022-09-22 17:31:44.129158220  [DHCPv4] dhcp_client_rx_message:931 T1 expir=
ing in 345600737 ms
2022-09-22 17:31:54.874541013  [DHCPv4] l_dhcp_client_stop:1247 Entering st=
ate: DHCP_STATE_INIT
2022-09-22 17:31:56.233417596  [DHCPv4] l_dhcp_client_start:1202 Entering s=
tate: DHCP_STATE_SELECTING
2022-09-22 17:31:56.859134554  [DHCPv4] dhcp_client_handle_offer:796 Enteri=
ng state: DHCP_STATE_REQUESTING
2022-09-22 17:31:57.215529929  [DHCPv4] dhcp_client_receive_offer:777 Serve=
r sent another offer, using it instead
2022-09-22 17:31:57.215894013  [DHCPv4] dhcp_client_handle_offer:796 Enteri=
ng state: DHCP_STATE_REQUESTING
2022-09-22 17:31:57.216082054  [DHCPv4] dhcp_client_rx_message:898 Entering=
 state: DHCP_STATE_BOUND
2022-09-22 17:31:57.218336596  [DHCPv4] dhcp_client_rx_message:931 T1 expir=
ing in 43200616 ms
2022-09-23 05:22:46.891765261  [DHCPv4] dhcp_client_t1_expired:619 Entering=
 state: DHCP_STATE_RENEWING
2022-09-23 05:22:47.241523016  [DHCPv4] dhcp_client_rx_message:882 Received=
 NAK, Stopping...
2022-09-23 05:22:47.246754249  [DHCPv4] l_dhcp_client_stop:1247 Entering st=
ate: DHCP_STATE_INIT
2022-09-23 05:22:47.255490495  [DHCPv4] l_dhcp_client_start:1202 Entering s=
tate: DHCP_STATE_SELECTING
2022-09-23 05:22:47.655326384  [DHCPv4] dhcp_client_handle_offer:796 Enteri=
ng state: DHCP_STATE_REQUESTING
2022-09-23 05:22:47.689505558  [DHCPv4] dhcp_client_rx_message:898 Entering=
 state: DHCP_STATE_BOUND
2022-09-23 05:22:47.689940789  [DHCPv4] dhcp_client_rx_message:931 T1 expir=
ing in 43200498 ms
2022-09-23 08:55:01.632928813  Received Deauthentication event, reason: 4, =
from_ap: false
2022-09-23 08:55:03.594093591  [DHCPv4] l_dhcp_client_stop:1247 Entering st=
ate: DHCP_STATE_INIT
2022-09-23 08:55:04.078785340  [DHCPv4] l_dhcp_client_start:1202 Entering s=
tate: DHCP_STATE_SELECTING
2022-09-23 08:55:05.461744842  [DHCPv4] dhcp_client_handle_offer:796 Enteri=
ng state: DHCP_STATE_REQUESTING
2022-09-23 08:55:10.133058431  [DHCPv4] dhcp_client_rx_message:898 Entering=
 state: DHCP_STATE_BOUND
2022-09-23 08:55:10.133590475  [DHCPv4] dhcp_client_rx_message:931 T1 expir=
ing in 43199882 ms
2022-09-23 20:55:10.014758692  [DHCPv4] dhcp_client_t1_expired:619 Entering=
 state: DHCP_STATE_RENEWING
2022-09-23 20:55:10.088691984  [DHCPv4] dhcp_client_rx_message:898 Entering=
 state: DHCP_STATE_BOUND
2022-09-23 20:55:10.088954534  [DHCPv4] dhcp_client_rx_message:931 T1 expir=
ing in 43200211 ms
2022-09-24 08:55:10.300724632  [DHCPv4] dhcp_client_t1_expired:619 Entering=
 state: DHCP_STATE_RENEWING
2022-09-24 08:55:10.356941637  [DHCPv4] dhcp_client_rx_message:898 Entering=
 state: DHCP_STATE_BOUND
2022-09-24 08:55:10.357325348  [DHCPv4] dhcp_client_rx_message:931 T1 expir=
ing in 43200893 ms
2022-09-24 11:46:05.576600345  Received Deauthentication event, reason: 4, =
from_ap: false
2022-09-24 11:46:10.364561762  [DHCPv4] l_dhcp_client_stop:1247 Entering st=
ate: DHCP_STATE_INIT
2022-09-24 11:46:11.002450830  [DHCPv4] l_dhcp_client_start:1202 Entering s=
tate: DHCP_STATE_SELECTING
2022-09-24 11:46:20.699675548  [DHCPv4] dhcp_client_handle_offer:796 Enteri=
ng state: DHCP_STATE_REQUESTING
2022-09-24 11:46:21.295708317  [DHCPv4] dhcp_client_rx_message:898 Entering=
 state: DHCP_STATE_BOUND
2022-09-24 11:46:21.296248750  [DHCPv4] dhcp_client_rx_message:931 T1 expir=
ing in 43200509 ms
2022-09-24 23:46:21.807937371  [DHCPv4] dhcp_client_t1_expired:619 Entering=
 state: DHCP_STATE_RENEWING
2022-09-24 23:46:21.877155925  [DHCPv4] dhcp_client_rx_message:898 Entering=
 state: DHCP_STATE_BOUND
2022-09-24 23:46:21.877561825  [DHCPv4] dhcp_client_rx_message:931 T1 expir=
ing in 43200699 ms
2022-09-25 11:46:22.577861408  [DHCPv4] dhcp_client_t1_expired:619 Entering=
 state: DHCP_STATE_RENEWING
2022-09-25 11:46:22.647972970  [DHCPv4] dhcp_client_rx_message:898 Entering=
 state: DHCP_STATE_BOUND
2022-09-25 11:46:22.648370085  [DHCPv4] dhcp_client_rx_message:931 T1 expir=
ing in 43200757 ms
2022-09-25 23:46:23.405783996  [DHCPv4] dhcp_client_t1_expired:619 Entering=
 state: DHCP_STATE_RENEWING
2022-09-25 23:46:23.486728353  [DHCPv4] dhcp_client_rx_message:898 Entering=
 state: DHCP_STATE_BOUND
2022-09-25 23:46:23.486988397  [DHCPv4] dhcp_client_rx_message:931 T1 expir=
ing in 43200548 ms
2022-09-26 03:58:27.484075832  Received Deauthentication event, reason: 4, =
from_ap: false
2022-09-26 03:58:30.163789430  [DHCPv4] l_dhcp_client_stop:1247 Entering st=
ate: DHCP_STATE_INIT
2022-09-26 03:58:30.701341987  authentication timed out
2022-09-26 03:58:30.701584748  [DHCPv4] l_dhcp_client_stop:1247 Entering st=
ate: DHCP_STATE_INIT
2022-09-26 03:58:31.216295792  [DHCPv4] l_dhcp_client_start:1202 Entering s=
tate: DHCP_STATE_SELECTING
2022-09-26 03:58:31.790039330  [DHCPv4] dhcp_client_handle_offer:796 Enteri=
ng state: DHCP_STATE_REQUESTING
2022-09-26 03:58:31.800427550  [DHCPv4] dhcp_client_rx_message:898 Entering=
 state: DHCP_STATE_BOUND
2022-09-26 03:58:31.800693308  [DHCPv4] dhcp_client_rx_message:931 T1 expir=
ing in 345600752 ms


Log below for device without IWD DHCP:
# cat /var/log/iwd/current
2022-09-22 14:31:27.679975178  Wireless daemon version 1.30
2022-09-22 14:31:27.710601428  Loaded configuration from /etc/iwd/main.conf
2022-09-22 14:31:27.860217844  station: Network configuration is disabled.
2022-09-22 14:31:27.951893178  Wiphy: 0, Name: phy0
2022-09-22 14:31:27.957807594   Permanent Address: 2c:11:65:46:fe:84
2022-09-22 14:31:27.958664636   2.4Ghz Band:
2022-09-22 14:31:27.959058469           Bitrates (non-HT):
2022-09-22 14:31:27.960518636                    1.0 Mbps
2022-09-22 14:31:27.960714803                    2.0 Mbps
2022-09-22 14:31:27.960864803                    5.5 Mbps
2022-09-22 14:31:27.961002344                   11.0 Mbps
2022-09-22 14:31:27.961140928                    6.0 Mbps
2022-09-22 14:31:27.961284886                    9.0 Mbps
2022-09-22 14:31:27.963547761                   12.0 Mbps
2022-09-22 14:31:27.963735719                   18.0 Mbps
2022-09-22 14:31:27.963874344                   24.0 Mbps
2022-09-22 14:31:27.964011386                   36.0 Mbps
2022-09-22 14:31:27.964145428                   48.0 Mbps
2022-09-22 14:31:27.964276178                   54.0 Mbps
2022-09-22 14:31:27.970533511           HT Capabilities:
2022-09-22 14:31:27.970775969                   HT20
2022-09-22 14:31:27.970925886                   Short GI for 20Mhz
2022-09-22 14:31:27.971062844           HT RX MCS indexes:
2022-09-22 14:31:27.971209428                   0-7
2022-09-22 14:31:27.980627428   Ciphers: CCMP TKIP BIP
2022-09-22 14:31:27.980889011   Supported iftypes: ad-hoc station ap
2022-09-22 14:31:27.981047094  Wiphy phy0 will only use the default interfa=
ce
2022-09-22 14:31:29.953735011  hardware_rekey not supported
2022-09-22 14:35:29.208229012  authentication timed out
2022-09-22 14:35:37.592649524  authentication timed out

P PLEASE CONSIDER OUR ENVIRONMENT BEFORE PRINTING THIS EMAIL.

This e-mail (including any attachments) is confidential and may be legally =
privileged. If you are not an intended recipient or an authorized represent=
ative of an intended recipient, you are prohibited from using, copying or d=
istributing the information in this e-mail or its attachments. If you have =
received this e-mail in error, please notify the sender immediately by retu=
rn e-mail and delete all copies of this message and any attachments. Thank =
you.
