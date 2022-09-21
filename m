Received: from mx08-00440002.pphosted.com (mx08-00440002.pphosted.com [185.183.31.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A5B7C
	for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 20:33:53 +0000 (UTC)
Received: from pps.filterd (m0267190.ppops.net [127.0.0.1])
	by mx08-00440002.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28LJwHDe032292
	for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 16:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pselector2;
 bh=OZrY6g9ixhgNkjxVGJhurMHMJiX0RcqdiHhH/XjmWOk=;
 b=kaqOO5S3agPWMGPn6JyhNsKqbgiu2UtJmtHoNR+yx02zViRIhSc2ylMenBmbgjTxKNpF
 OppzAN2j8miJ5Hv1JFgMsC5tl+yTtMlqmkJ5TFZYju64qwT8ty6F0iqCU8aN4EgmGLFN
 KJKzzE4BtBXFV6eg1lnrwjVholjDHgYx/QRN87y7BwDmn6bFQNlBLYBuZGb8QbpCh94I
 KcpG11gkOM4wRkTqCrZQ3BAwSQBoynaxJsaegA7rEy8MA5FlWTn0PJm4ppPSofcpFld6
 oSbZBb4la6YZZ7nKdTD2hA3HUivXTUoLyNNYCqJHRpjIYPDtFcH74RLCx02XqF813Cmc 1g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pselector1;
 bh=OZrY6g9ixhgNkjxVGJhurMHMJiX0RcqdiHhH/XjmWOk=;
 b=k4lSo2emRZrUWnJIc5ebWrvThKDGSczq0LcnpNHSHW69X5qRjkP054SAZEka4LJQOyKf
 zOiP30mBA5t53w4msz88dr8bQ1u4zdyUjJxSqD2aN3GG9zFnezR94+bg6wO1O/lTGuGa
 CadowGWOMr8rS5We+J4heSSTNcPL9awFyeribsvY8i+Av+sr6BddGtTSFxIuxW/YGBjn
 +3amEiN71EGG7KeWNt3+56aXyiqRtRyvuxUq0DyKC06g8L82Qnmti+MFGt0rkMI9o8/u
 lLHknN7xQTx3MkiiDWnjsdv7Omf3Vq/+D8hmMlWKUwT7ZTwKsiceoSO34z6849+QCa9h Ow== 
Received: from eur01-ve1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2053.outbound.protection.outlook.com [104.47.1.53])
	by mx08-00440002.pphosted.com (PPS) with ESMTPS id 3jn8wvv77q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 16:04:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5D44o2hKGhctp1SbnhpMIekTJk7G2eeRUscwRnPb6HH2VUj5KsZsqkerR2pm5Ia6CC7pxC44Sqr+BljvKtUKCgDA7OvRd4bwwn7kbcnGO0Cbue7r4sXkVT6RmsGQar+nHbv/mApp1Xf8iPk3vSETBMLkUOlsRdIxAqRDWbgVO2FhyWhhlqDL6lRBk1fzgUyr4VIxi/hFOXZ1fGWoZwp9Ft3c98BU3MleOc/0Em/plWXoMs4Tk5Tp3ZiJOaLT0pn+/s1ypuscK1M9roi1fjnhgZ6MJ20YxbG/pjM2A2eAktnAs6DHQwikCxsprgDYrJkn31YL4gZSbPeuI/IMr2jng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZrY6g9ixhgNkjxVGJhurMHMJiX0RcqdiHhH/XjmWOk=;
 b=XZZna8FA3RF0RX588X3J8mFnrnmuSYQZADpe+9LLQOnCvlxtxeRekA4O8W1mXutgUugXQmLI37oqMrorbR8R49Tm+Q0tsfbjwbxXmnOGC2yMZGX+jAsLHgcZl9tMUi2Qo606zsUecYqNDMdASwab0ar0paPs4j8cjGiNwHKduZHFniXa4w2VhZ9MM74mkyp5Tu2IEFSB8tIhrVT5fQn/ImfO2llcJQVAhgfKtLSt5slWIOTsFIo/1J5R1fm/XoPoX02tjUXn6jGR3pOfeIjwPyskM64P8MOVjkcJitE37p+ppxTFCew1yfetIDlOe/VSTxhoDUhH0XKW4MMHCb3gEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=landisgyr.com; dmarc=pass action=none
 header.from=landisgyr.com; dkim=pass header.d=landisgyr.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZrY6g9ixhgNkjxVGJhurMHMJiX0RcqdiHhH/XjmWOk=;
 b=S8Q0rHQd0TW0ixPNWyxVFIPfiutlRPTt03ljc4P3zGWLWSUGyPOSumA0jdpGZijc0zkcDnkZg6z4/zOJ5ujJX+RuMo58GiIoBPpjEIGdEBjFzlzLIf+vs0UAhoVRLuu5odh8JsTIBcOvhugb8Ux27X649cXocNQISlYwIuowsAc=
Received: from AS8PR01MB7493.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:25b::13) by PAXPR01MB9577.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:2c1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Wed, 21 Sep
 2022 20:04:33 +0000
Received: from AS8PR01MB7493.eurprd01.prod.exchangelabs.com
 ([fe80::abcb:ec37:67ed:db1f]) by AS8PR01MB7493.eurprd01.prod.exchangelabs.com
 ([fe80::abcb:ec37:67ed:db1f%2]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 20:04:33 +0000
From: "Johnson, Bryce" <Bryce.Johnson@landisgyr.com>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: wiphy_estimate_data_rate() failed
Thread-Topic: wiphy_estimate_data_rate() failed
Thread-Index: AdjN8lRkJil+fRmsST+H/QVnE9hZ/Q==
Date: Wed, 21 Sep 2022 20:04:33 +0000
Message-ID: 
 <AS8PR01MB74931FD1507D2D70FDFB5F05F44F9@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ActionId=afc763dd-09d5-48f1-96c8-1d70aec8a49e;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ContentBits=0;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Enabled=true;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Method=Standard;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Name=724d29b2-602f-4b77-ba15-b7b42511c7c5;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SetDate=2022-09-21T19:40:01Z;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SiteId=ee2cd48b-958f-4be4-9852-b8f104c001b9;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR01MB7493:EE_|PAXPR01MB9577:EE_
x-ms-office365-filtering-correlation-id: 266ac4da-87c8-4b61-3ff2-08da9c0c805f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8FaPEUnHZVarhIKIUAXoxCbLWKG9NZdN+0CR1gkDh3RV/4BAOW2dWgL0iQ3DwiTXidIQS0Do4tQ1B2kmBE/y5qrprhvQpLDMva1vNNIwbNSk/7+5Smn9MX6z3LttqZm0bj5v4TOOcL8gUBY9H7zQtcIVgTnGzPhAIPqMH/SMpgwWtI9NrMNuD3SW7QkgVgkbN9DnNy5y+L4QqZ0XJ4FEZ3/x/11tFljwFKH4qoRGEIkBugrUIytCkwVPVlhBfighF+blcW86SKiwuA/Mcg9lF756HWGyPT3yz4hBuwqb+sqyJcyv7/KjZHbRi9biZfmmcaHwZA9UfHgZwxc0C7N0rnwhqDoRtkotXES+vklLdFVMKktnpuLw5j3fYVCY2YL0gbH6IVqSklEezzyMK48pkOw3qnd4onj7Xc+tBR4/2qWd1KRx2PXmnR5MaDHbRsnrcqQ2L3jRbiQRB9chNB5NSDb4Bq4DnkAvhmnboKreeAUB0Nu3jfkXtrjjxSxzgkjyjvd8ggIpNRREwNzPf4QCsY2NlprL3EEGt4DDI2eKnzyyZdCgpEMLVZy7h9tHWoYEekfEvVxqxaB0iogSO/dNQ5abRs/h0Tlb5i9g7uEHsDlrhcBZh8TlNYJfpUpV9RZ75s88wRFnvblnY7Pkf7itBh1Zvwe4PLoAzCPrJduMczMZ/fH7YJ379BMaV0ooO5Wr6K3vVoDb0LgfDrynD/IbruFS38WR3sTYVZWITr/7vKfVQteoOT+ip2RzbY1Op55yLLHB8lxIzS6Cso2B0r63uA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR01MB7493.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(55016003)(30864003)(2906002)(86362001)(316002)(122000001)(66556008)(38100700002)(66476007)(8676002)(66446008)(52536014)(66946007)(5660300002)(6916009)(8936002)(186003)(478600001)(9686003)(26005)(64756008)(76116006)(33656002)(83380400001)(38070700005)(41300700001)(6506007)(71200400001)(7696005)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?jkbnQtBG8WLugi/lpmK3eSD464QTlzn/LtLgKq1MYqIDFS0Zy9NI3Goxo6dK?=
 =?us-ascii?Q?lJUErhIufx3hst86ijLptIaPeabnryKKnMALnu5flcskctKQsQ/DHdORcOIb?=
 =?us-ascii?Q?EAtAJgpwURUQD3pfhJhk2QsBAHeYQj9elMPFzaWVYryh6hBrz9v1zxrMQ22u?=
 =?us-ascii?Q?Gc4/IMSLnpZAtaoomwsYcPLa46kG2QdklwoTOD+UbpPiKRs8LrParsgky2Zn?=
 =?us-ascii?Q?B+uVJevhmp1RYkz3oJRssCLEpKgZTxQWXKDaV6N1cF5iT+UUgkpKgqdbOgyd?=
 =?us-ascii?Q?xK9K2f3EEF9oI9v8AyHW8TJOuE+wQ2K/1lTOku8H/w1OK8xrUhue+SD4jOAq?=
 =?us-ascii?Q?x5JPe6pMWALbWImDa3EYduWpcGu5xEWLMhjaycOejUXbP78IvworwRDTHKxq?=
 =?us-ascii?Q?y+yoIDTwdRVzN5HbYScKD7dBeiMBnV/8ePNXL6LurQA+hZR0gVtugGx2cOvp?=
 =?us-ascii?Q?VKuwM0K8u5JiJGtXjFQ7p1kG5dJKJtLJ42xbkEsyDVTv30mrKNv1br1RG25U?=
 =?us-ascii?Q?OnK3KXYHIasObF0ifrz4fgiCy9SS2pdoOZzZNiOnkpuoPXulCP4WNBEl3dzP?=
 =?us-ascii?Q?iWB0SQ0BjbEiv4QuLzkWImirPkHKogVtq4vdnQD9p6VdEnm7nekQRv8Bd+ew?=
 =?us-ascii?Q?NHi1xRtI6wU4KOG8oQ3pYpcgjZfIP8PTcDj02RyIBIDTbyIY4ItfNldubkel?=
 =?us-ascii?Q?Fhc8ZthVKYoqUYm5rPUnzcRj2xWno+9+M2cfGsWKeyXHmybM6wb3v5yAfrFC?=
 =?us-ascii?Q?IqhSOl5J5xwuTGKnZp1URUMi0GOwUeUj+BGIgDAXeC59fAY6WSG1FO6FWVbG?=
 =?us-ascii?Q?Pi/x5H/g2e4Sg3u4mCb80HDZS7eHHv9SwePH4ndEjcY+9f0cCw8HXH4Zd6bH?=
 =?us-ascii?Q?8fyhlPRTbi4QjfHDgMzheoh/vLjshIfsDQ3ivoYc9UZ9GcmyqyxvuFAj/pJ+?=
 =?us-ascii?Q?lkaGF2LL6IEd6NoqgsO8iVwW5iJ1uYtX6vx6TrEog1+X8Skys8PDgH3kjupD?=
 =?us-ascii?Q?5/xolkuj3cMbbtyIYYCP5wJy3Iw/v7FRkFK+nuM3c5JyerakSvxRfWCP9nbL?=
 =?us-ascii?Q?kSP3UFeI0w2yYy4Z7YJzfJHJX3434GoKcXUqk7tGuJXJPvb+JIvTHLa9X0FA?=
 =?us-ascii?Q?nQWu8jpiIX4JB5t9oGo+1iKcPjO9ydTzW8CPvNCB+GsyzqC3l1QvUsA+SwFs?=
 =?us-ascii?Q?kqhqZSmkEJv9ukKxFgsIbHnFL8tuDL/WiZeQ6Qhof2pH7bGJoK2HigK9y8tV?=
 =?us-ascii?Q?10BQ6US8kxOb3OAf4xtQlEFotUM/wjQYVyRKBlW4/no0ND4VGZnEUZZpcsnx?=
 =?us-ascii?Q?NyIH97irD0VAgodsU/ZQMgDM8Anll9cgqp4oTYWFmWaNkxEJNunrt/7Gq9Tv?=
 =?us-ascii?Q?mVon4DN3kAIEbh7BVTkpZv9VeliuNmjjqa8ZEEX69LCmE25tUUK39SU+qYQ3?=
 =?us-ascii?Q?yx83W7e7kql8YreTE2J4tb2ScWV2E3Cc9VtTZMGWaP8cut4Ukj5i1fv2dZtw?=
 =?us-ascii?Q?4gOjRArqIDECHaY1IZSpOeXloyGkOGeJa204cML6XEMuH2AdK7EqbQuCI8C9?=
 =?us-ascii?Q?LYSFQWTW6zv014xvkCIwvrXdTBXkH8MMdraie084bHw5Z3/T1QCrHstO5MRu?=
 =?us-ascii?Q?gg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR01MB7493.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266ac4da-87c8-4b61-3ff2-08da9c0c805f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 20:04:33.2988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3uJua6ahAuLhgTtUH7gR6QxS49+fo9t+8LW0OcW+0yWWY2twtLxdbEbWTj+E+c5i+KSCwo5bStEvO7psfedj1uEUdHGNzUq7hax0PN8ls4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR01MB9577
X-Proofpoint-ORIG-GUID: nYRf-rVHrU6veeSQVnHgl_doeT8_ZrvW
X-Proofpoint-GUID: nYRf-rVHrU6veeSQVnHgl_doeT8_ZrvW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_11,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209210134

Hi all,
I recently updated to use IWD 1.30.  I also recently added a script to call=
 `iwctl station wlan0 scan` and then `iwctl station wlan0 get-networks rssi=
-dbms` to write out to a log file every minute for debugging.  When I went =
to check my iwd log I noticed it was filled up with wiphy_estimate_data_rat=
e() failed errors.

I stopped my scan script and manually called `iwctl station wlan0 scan` and=
 was able to cause the error.    I did also get a deauth event around that =
time when I was looking at it, but not sure what caused that.

Received Deauthentication event, reason: 4, from_ap: false


I restarted my device, but I haven't seen the problem happen again.  I was =
going to start IWD in debug mode to get more information.  Anything else to=
 capture if I see the issue?

Thanks
Bryce

Whole big log:

2022-09-21 16:58:59.250419471  Wireless daemon version 1.30
2022-09-21 16:58:59.447439804  Loaded configuration from /etc/iwd/main.conf
2022-09-21 16:58:59.622803721  station: Network configuration is disabled.
2022-09-21 16:58:59.676712137  Wiphy: 0, Name: phy0
2022-09-21 16:58:59.679405846   Permanent Address: 38:5b:44:08:76:85
2022-09-21 16:58:59.680005179   2.4Ghz Band:
2022-09-21 16:58:59.680524846           Bitrates (non-HT):
2022-09-21 16:58:59.682477762                    1.0 Mbps
2022-09-21 16:58:59.683337262                    2.0 Mbps
2022-09-21 16:58:59.683540679                    5.5 Mbps
2022-09-21 16:58:59.683683971                   11.0 Mbps
2022-09-21 16:58:59.683827179                    6.0 Mbps
2022-09-21 16:58:59.683958721                    9.0 Mbps
2022-09-21 16:58:59.689675929                   12.0 Mbps
2022-09-21 16:58:59.689943387                   18.0 Mbps
2022-09-21 16:58:59.690098887                   24.0 Mbps
2022-09-21 16:58:59.692394887                   36.0 Mbps
2022-09-21 16:58:59.692571846                   48.0 Mbps
2022-09-21 16:58:59.692708554                   54.0 Mbps
2022-09-21 16:58:59.692851012           HT Capabilities:
2022-09-21 16:58:59.692986346                   HT20
2022-09-21 16:58:59.693121971                   Short GI for 20Mhz
2022-09-21 16:58:59.693335596           HT RX MCS indexes:
2022-09-21 16:58:59.693468262                   0-7
2022-09-21 16:58:59.693604262   Ciphers: CCMP TKIP BIP
2022-09-21 16:58:59.693746846   Supported iftypes: ad-hoc station ap
2022-09-21 16:58:59.693882679  Wiphy phy0 will only use the default interfa=
ce
2022-09-21 16:59:00.056345387  wiphy_estimate_data_rate() failed
2022-09-21 16:59:01.628609179  hardware_rekey not supported
2022-09-21 17:00:07.886120976  wiphy_estimate_data_rate() failed
2022-09-21 17:01:08.201358544  wiphy_estimate_data_rate() failed
2022-09-21 17:04:10.062344997  wiphy_estimate_data_rate() failed
2022-09-21 17:04:10.062609260  wiphy_estimate_data_rate() failed
2022-09-21 17:06:10.894354152  wiphy_estimate_data_rate() failed
2022-09-21 17:06:10.896408237  wiphy_estimate_data_rate() failed
2022-09-21 17:07:11.312225598  wiphy_estimate_data_rate() failed
2022-09-21 17:09:12.248566219  wiphy_estimate_data_rate() failed
2022-09-21 17:10:12.665852173  wiphy_estimate_data_rate() failed
2022-09-21 17:12:13.601395564  wiphy_estimate_data_rate() failed
2022-09-21 17:14:14.740502322  wiphy_estimate_data_rate() failed
2022-09-21 17:14:14.744916398  wiphy_estimate_data_rate() failed
2022-09-21 17:14:14.747342459  wiphy_estimate_data_rate() failed
2022-09-21 17:15:15.157362125  wiphy_estimate_data_rate() failed
2022-09-21 17:15:15.157629126  wiphy_estimate_data_rate() failed
2022-09-21 17:20:17.140345625  wiphy_estimate_data_rate() failed
2022-09-21 17:20:17.140612335  wiphy_estimate_data_rate() failed
2022-09-21 17:23:18.594294448  wiphy_estimate_data_rate() failed
2022-09-21 17:23:18.594568366  wiphy_estimate_data_rate() failed
2022-09-21 17:23:18.594723075  wiphy_estimate_data_rate() failed
2022-09-21 17:25:19.427571499  wiphy_estimate_data_rate() failed
2022-09-21 17:25:19.427841625  wiphy_estimate_data_rate() failed
2022-09-21 17:28:20.983256366  wiphy_estimate_data_rate() failed
2022-09-21 17:28:20.983529159  wiphy_estimate_data_rate() failed
2022-09-21 17:28:20.983685826  wiphy_estimate_data_rate() failed
2022-09-21 17:29:21.705329943  wiphy_estimate_data_rate() failed
2022-09-21 17:31:22.538378224  wiphy_estimate_data_rate() failed
2022-09-21 17:31:22.538648642  wiphy_estimate_data_rate() failed
2022-09-21 17:32:22.858662007  wiphy_estimate_data_rate() failed
2022-09-21 17:32:22.858936175  wiphy_estimate_data_rate() failed
2022-09-21 17:32:22.859400928  wiphy_estimate_data_rate() failed
2022-09-21 17:33:23.371345767  wiphy_estimate_data_rate() failed
2022-09-21 17:33:23.374878291  wiphy_estimate_data_rate() failed
2022-09-21 17:36:24.724341777  wiphy_estimate_data_rate() failed
2022-09-21 17:36:24.724752946  wiphy_estimate_data_rate() failed
2022-09-21 17:37:25.141356519  wiphy_estimate_data_rate() failed
2022-09-21 17:38:25.866486637  wiphy_estimate_data_rate() failed
2022-09-21 17:38:25.866752347  wiphy_estimate_data_rate() failed
2022-09-21 17:38:25.866904140  wiphy_estimate_data_rate() failed
2022-09-21 17:39:26.486365308  wiphy_estimate_data_rate() failed
2022-09-21 17:40:27.005361551  wiphy_estimate_data_rate() failed
2022-09-21 17:40:27.005624803  wiphy_estimate_data_rate() failed
2022-09-21 17:41:27.319051186  wiphy_estimate_data_rate() failed
2022-09-21 17:41:27.321374660  wiphy_estimate_data_rate() failed
2022-09-21 17:41:27.321776538  wiphy_estimate_data_rate() failed
2022-09-21 17:41:27.321959456  wiphy_estimate_data_rate() failed
2022-09-21 17:43:28.459357884  wiphy_estimate_data_rate() failed
2022-09-21 17:43:28.461378689  wiphy_estimate_data_rate() failed
2022-09-21 17:43:28.462383029  wiphy_estimate_data_rate() failed
2022-09-21 17:43:28.462614822  wiphy_estimate_data_rate() failed
2022-09-21 17:44:29.185247927  wiphy_estimate_data_rate() failed
2022-09-21 17:44:29.185522346  wiphy_estimate_data_rate() failed
2022-09-21 17:44:29.185676305  wiphy_estimate_data_rate() failed
2022-09-21 17:44:29.185962890  wiphy_estimate_data_rate() failed
2022-09-21 17:46:30.122047224  wiphy_estimate_data_rate() failed
2022-09-21 17:46:30.122402935  wiphy_estimate_data_rate() failed
2022-09-21 17:47:30.434346124  wiphy_estimate_data_rate() failed
2022-09-21 17:48:30.647819490  wiphy_estimate_data_rate() failed
2022-09-21 17:48:30.649376542  wiphy_estimate_data_rate() failed
2022-09-21 17:48:30.649618169  wiphy_estimate_data_rate() failed
2022-09-21 17:48:30.649767128  wiphy_estimate_data_rate() failed
2022-09-21 17:49:31.165293090  wiphy_estimate_data_rate() failed
2022-09-21 17:49:31.167331896  wiphy_estimate_data_rate() failed
2022-09-21 17:49:31.167591106  wiphy_estimate_data_rate() failed
2022-09-21 17:50:31.477346530  wiphy_estimate_data_rate() failed
2022-09-21 17:50:31.477612365  wiphy_estimate_data_rate() failed
2022-09-21 17:51:32.099343327  wiphy_estimate_data_rate() failed
2022-09-21 17:51:32.099611496  wiphy_estimate_data_rate() failed
2022-09-21 17:51:32.099769622  wiphy_estimate_data_rate() failed
2022-09-21 17:51:32.099908872  wiphy_estimate_data_rate() failed
2022-09-21 17:53:32.932525933  wiphy_estimate_data_rate() failed
2022-09-21 17:53:32.934940658  wiphy_estimate_data_rate() failed
2022-09-21 17:53:32.936401876  wiphy_estimate_data_rate() failed
2022-09-21 17:53:32.937840135  wiphy_estimate_data_rate() failed
2022-09-21 17:54:33.253343431  wiphy_estimate_data_rate() failed
2022-09-21 17:54:33.253608975  wiphy_estimate_data_rate() failed
2022-09-21 17:54:33.253758893  wiphy_estimate_data_rate() failed
2022-09-21 17:54:33.253895560  wiphy_estimate_data_rate() failed
2022-09-21 17:55:33.867492676  wiphy_estimate_data_rate() failed
2022-09-21 17:55:33.867760428  wiphy_estimate_data_rate() failed
2022-09-21 17:55:33.867915929  wiphy_estimate_data_rate() failed
2022-09-21 17:56:34.186344036  wiphy_estimate_data_rate() failed
2022-09-21 17:56:34.186797456  wiphy_estimate_data_rate() failed
2022-09-21 17:56:34.186985915  wiphy_estimate_data_rate() failed
2022-09-21 17:56:34.188104006  wiphy_estimate_data_rate() failed
2022-09-21 17:58:35.426339104  wiphy_estimate_data_rate() failed
2022-09-21 17:58:35.426737523  wiphy_estimate_data_rate() failed
2022-09-21 17:58:35.426902774  wiphy_estimate_data_rate() failed
2022-09-21 17:58:35.427036692  wiphy_estimate_data_rate() failed
2022-09-21 17:59:35.740346931  wiphy_estimate_data_rate() failed
2022-09-21 18:00:36.262550313  wiphy_estimate_data_rate() failed
2022-09-21 18:00:36.264399284  wiphy_estimate_data_rate() failed
2022-09-21 18:00:36.264652702  wiphy_estimate_data_rate() failed
2022-09-21 18:00:36.265369415  wiphy_estimate_data_rate() failed
2022-09-21 18:01:36.677379185  wiphy_estimate_data_rate() failed
2022-09-21 18:01:36.677829313  wiphy_estimate_data_rate() failed
2022-09-21 18:01:36.678022064  wiphy_estimate_data_rate() failed
2022-09-21 18:03:37.716361870  wiphy_estimate_data_rate() failed
2022-09-21 18:04:38.132240198  wiphy_estimate_data_rate() failed
2022-09-21 18:05:38.444342448  wiphy_estimate_data_rate() failed
2022-09-21 18:05:38.444605033  wiphy_estimate_data_rate() failed
2022-09-21 18:05:38.444756201  wiphy_estimate_data_rate() failed
2022-09-21 18:05:38.444889744  wiphy_estimate_data_rate() failed
2022-09-21 18:07:39.278352744  wiphy_estimate_data_rate() failed
2022-09-21 18:07:39.278619287  wiphy_estimate_data_rate() failed
2022-09-21 18:08:39.795342091  wiphy_estimate_data_rate() failed
2022-09-21 18:08:39.795611718  wiphy_estimate_data_rate() failed
2022-09-21 18:09:40.314996414  wiphy_estimate_data_rate() failed
2022-09-21 18:09:40.317384262  wiphy_estimate_data_rate() failed
2022-09-21 18:09:40.317648014  wiphy_estimate_data_rate() failed
2022-09-21 18:09:40.317797723  wiphy_estimate_data_rate() failed
2022-09-21 18:10:40.730724709  wiphy_estimate_data_rate() failed
2022-09-21 18:10:40.733720020  wiphy_estimate_data_rate() failed
2022-09-21 18:10:40.735395656  wiphy_estimate_data_rate() failed
2022-09-21 18:10:40.735645075  wiphy_estimate_data_rate() failed
2022-09-21 18:11:41.352357527  wiphy_estimate_data_rate() failed
2022-09-21 18:11:41.352804988  wiphy_estimate_data_rate() failed
2022-09-21 18:11:41.352983864  wiphy_estimate_data_rate() failed
2022-09-21 18:12:41.973487508  wiphy_estimate_data_rate() failed
2022-09-21 18:12:41.976504736  wiphy_estimate_data_rate() failed
2022-09-21 18:13:42.596492877  wiphy_estimate_data_rate() failed
2022-09-21 18:13:42.596766462  wiphy_estimate_data_rate() failed
2022-09-21 18:13:42.596917796  wiphy_estimate_data_rate() failed
2022-09-21 18:14:42.908354515  wiphy_estimate_data_rate() failed
2022-09-21 18:14:42.908672351  wiphy_estimate_data_rate() failed
2022-09-21 18:14:42.908839102  wiphy_estimate_data_rate() failed
2022-09-21 18:14:42.914572682  wiphy_estimate_data_rate() failed
2022-09-21 18:15:43.325399393  wiphy_estimate_data_rate() failed
2022-09-21 18:15:43.325670145  wiphy_estimate_data_rate() failed
2022-09-21 18:15:43.325824188  wiphy_estimate_data_rate() failed
2022-09-21 18:15:43.325972230  wiphy_estimate_data_rate() failed
2022-09-21 18:17:44.262344915  wiphy_estimate_data_rate() failed
2022-09-21 18:17:44.262609125  wiphy_estimate_data_rate() failed
2022-09-21 18:17:44.262759376  wiphy_estimate_data_rate() failed
2022-09-21 18:18:44.783353536  wiphy_estimate_data_rate() failed
2022-09-21 18:18:44.783622663  wiphy_estimate_data_rate() failed
2022-09-21 18:18:44.783775747  wiphy_estimate_data_rate() failed
2022-09-21 18:19:45.301363743  wiphy_estimate_data_rate() failed
2022-09-21 18:19:45.303384507  wiphy_estimate_data_rate() failed
2022-09-21 18:19:45.303644883  wiphy_estimate_data_rate() failed
2022-09-21 18:19:45.304339221  wiphy_estimate_data_rate() failed
2022-09-21 18:20:45.819353867  wiphy_estimate_data_rate() failed
2022-09-21 18:20:45.819618494  wiphy_estimate_data_rate() failed
2022-09-21 18:20:45.819768786  wiphy_estimate_data_rate() failed
2022-09-21 18:20:45.819907954  wiphy_estimate_data_rate() failed
2022-09-21 18:21:46.543491343  wiphy_estimate_data_rate() failed
2022-09-21 18:21:46.543760095  wiphy_estimate_data_rate() failed
2022-09-21 18:21:46.543913596  wiphy_estimate_data_rate() failed
2022-09-21 18:21:46.544046930  wiphy_estimate_data_rate() failed
2022-09-21 18:22:46.959369963  wiphy_estimate_data_rate() failed
2022-09-21 18:22:46.959640548  wiphy_estimate_data_rate() failed
2022-09-21 18:22:46.959793383  wiphy_estimate_data_rate() failed
2022-09-21 18:22:46.959935259  wiphy_estimate_data_rate() failed
2022-09-21 18:23:47.374465537  wiphy_estimate_data_rate() failed
2022-09-21 18:23:47.374736705  wiphy_estimate_data_rate() failed
2022-09-21 18:25:48.208054039  wiphy_estimate_data_rate() failed
2022-09-21 18:25:48.212596652  wiphy_estimate_data_rate() failed
2022-09-21 18:26:48.933352190  wiphy_estimate_data_rate() failed
2022-09-21 18:26:48.933623150  wiphy_estimate_data_rate() failed
2022-09-21 18:26:48.933776151  wiphy_estimate_data_rate() failed
2022-09-21 18:27:49.452579946  wiphy_estimate_data_rate() failed
2022-09-21 18:27:49.454385208  wiphy_estimate_data_rate() failed
2022-09-21 18:27:49.454642418  wiphy_estimate_data_rate() failed
2022-09-21 18:27:49.454790086  wiphy_estimate_data_rate() failed
2022-09-21 18:28:49.767238361  wiphy_estimate_data_rate() failed
2022-09-21 18:28:49.769383833  wiphy_estimate_data_rate() failed
2022-09-21 18:28:49.769638376  wiphy_estimate_data_rate() failed
2022-09-21 18:28:49.769786669  wiphy_estimate_data_rate() failed
2022-09-21 18:29:50.182564686  wiphy_estimate_data_rate() failed
2022-09-21 18:29:50.185244037  wiphy_estimate_data_rate() failed
2022-09-21 18:29:50.185506080  wiphy_estimate_data_rate() failed
2022-09-21 18:29:50.185656331  wiphy_estimate_data_rate() failed
2022-09-21 18:30:50.700437975  wiphy_estimate_data_rate() failed
2022-09-21 18:30:50.703720622  wiphy_estimate_data_rate() failed
2022-09-21 18:30:50.703981915  wiphy_estimate_data_rate() failed
2022-09-21 18:30:50.705667551  wiphy_estimate_data_rate() failed
2022-09-21 18:31:50.914999108  wiphy_estimate_data_rate() failed
2022-09-21 18:31:50.917488332  wiphy_estimate_data_rate() failed
2022-09-21 18:33:52.053474277  wiphy_estimate_data_rate() failed
2022-09-21 18:34:52.366350305  wiphy_estimate_data_rate() failed
2022-09-21 18:34:52.366615098  wiphy_estimate_data_rate() failed
2022-09-21 18:34:52.370509582  wiphy_estimate_data_rate() failed
2022-09-21 18:34:52.370953502  wiphy_estimate_data_rate() failed
2022-09-21 18:35:52.785343925  wiphy_estimate_data_rate() failed
2022-09-21 18:35:52.785609761  wiphy_estimate_data_rate() failed
2022-09-21 18:35:52.785761803  wiphy_estimate_data_rate() failed
2022-09-21 18:35:52.785895262  wiphy_estimate_data_rate() failed
2022-09-21 18:36:53.406380554  wiphy_estimate_data_rate() failed
2022-09-21 18:36:53.408367942  wiphy_estimate_data_rate() failed
2022-09-21 18:36:53.408741195  wiphy_estimate_data_rate() failed
2022-09-21 18:36:53.408906446  wiphy_estimate_data_rate() failed
2022-09-21 18:37:53.925659550  wiphy_estimate_data_rate() failed
2022-09-21 18:37:53.929496867  wiphy_estimate_data_rate() failed
2022-09-21 18:37:53.929761368  wiphy_estimate_data_rate() failed
2022-09-21 18:37:53.930073745  wiphy_estimate_data_rate() failed
2022-09-21 18:38:54.340343059  wiphy_estimate_data_rate() failed
2022-09-21 18:38:54.340609686  wiphy_estimate_data_rate() failed
2022-09-21 18:39:54.961850566  wiphy_estimate_data_rate() failed
2022-09-21 18:39:54.966677390  wiphy_estimate_data_rate() failed
2022-09-21 18:39:54.966947433  wiphy_estimate_data_rate() failed
2022-09-21 18:39:54.967112726  wiphy_estimate_data_rate() failed
2022-09-21 18:40:55.377379165  wiphy_estimate_data_rate() failed
2022-09-21 18:40:55.377652375  wiphy_estimate_data_rate() failed
2022-09-21 18:40:55.377811668  wiphy_estimate_data_rate() failed
2022-09-21 18:40:55.377945127  wiphy_estimate_data_rate() failed
2022-09-21 18:41:55.796018368  wiphy_estimate_data_rate() failed
2022-09-21 18:41:55.798400217  wiphy_estimate_data_rate() failed
2022-09-21 18:42:56.215755661  wiphy_estimate_data_rate() failed
2022-09-21 18:42:56.216027705  wiphy_estimate_data_rate() failed
2022-09-21 18:43:56.832373219  wiphy_estimate_data_rate() failed
2022-09-21 18:43:56.832638179  wiphy_estimate_data_rate() failed
2022-09-21 18:43:56.834394191  wiphy_estimate_data_rate() failed
2022-09-21 18:44:57.250486127  wiphy_estimate_data_rate() failed
2022-09-21 18:44:57.250755754  wiphy_estimate_data_rate() failed
2022-09-21 18:44:57.250907963  wiphy_estimate_data_rate() failed
2022-09-21 18:44:57.251042506  wiphy_estimate_data_rate() failed
2022-09-21 18:45:57.872335594  wiphy_estimate_data_rate() failed
2022-09-21 18:45:57.877634213  wiphy_estimate_data_rate() failed
2022-09-21 18:45:57.877908964  wiphy_estimate_data_rate() failed
2022-09-21 18:46:58.288570614  wiphy_estimate_data_rate() failed
2022-09-21 18:46:58.290392460  wiphy_estimate_data_rate() failed
2022-09-21 18:47:58.704356007  wiphy_estimate_data_rate() failed
2022-09-21 18:47:58.704626925  wiphy_estimate_data_rate() failed
2022-09-21 18:47:58.704778259  wiphy_estimate_data_rate() failed
2022-09-21 18:48:59.427519896  wiphy_estimate_data_rate() failed
2022-09-21 18:48:59.427829898  wiphy_estimate_data_rate() failed
2022-09-21 18:48:59.430820793  wiphy_estimate_data_rate() failed
2022-09-21 18:48:59.432513304  wiphy_estimate_data_rate() failed
2022-09-21 18:49:59.744359215  wiphy_estimate_data_rate() failed
2022-09-21 18:49:59.744627300  wiphy_estimate_data_rate() failed
2022-09-21 18:49:59.744782968  wiphy_estimate_data_rate() failed
2022-09-21 18:51:00.160226233  wiphy_estimate_data_rate() failed
2022-09-21 18:51:00.162394706  wiphy_estimate_data_rate() failed
2022-09-21 18:51:00.162652291  wiphy_estimate_data_rate() failed
2022-09-21 18:52:00.371014932  wiphy_estimate_data_rate() failed
2022-09-21 18:52:00.373389240  wiphy_estimate_data_rate() failed
2022-09-21 18:52:00.373794118  wiphy_estimate_data_rate() failed
2022-09-21 18:52:00.373958244  wiphy_estimate_data_rate() failed
2022-09-21 18:53:00.689258938  wiphy_estimate_data_rate() failed
2022-09-21 18:53:00.689534774  wiphy_estimate_data_rate() failed
2022-09-21 18:53:00.689694191  wiphy_estimate_data_rate() failed
2022-09-21 18:53:00.689826567  wiphy_estimate_data_rate() failed
2022-09-21 18:54:00.999357062  wiphy_estimate_data_rate() failed
2022-09-21 18:55:01.313225752  wiphy_estimate_data_rate() failed
2022-09-21 18:55:01.313497754  wiphy_estimate_data_rate() failed
2022-09-21 18:55:01.316332147  wiphy_estimate_data_rate() failed
2022-09-21 18:55:01.316585482  wiphy_estimate_data_rate() failed
2022-09-21 18:56:01.628792286  wiphy_estimate_data_rate() failed
2022-09-21 18:56:01.630375964  wiphy_estimate_data_rate() failed
2022-09-21 18:56:01.630623090  wiphy_estimate_data_rate() failed
2022-09-21 18:57:02.045650496  wiphy_estimate_data_rate() failed
2022-09-21 18:58:02.360294024  wiphy_estimate_data_rate() failed
2022-09-21 18:58:02.360563484  wiphy_estimate_data_rate() failed
2022-09-21 18:59:02.876499103  wiphy_estimate_data_rate() failed
2022-09-21 18:59:02.876767230  wiphy_estimate_data_rate() failed
2022-09-21 18:59:02.876920856  wiphy_estimate_data_rate() failed
2022-09-21 19:00:03.397299630  wiphy_estimate_data_rate() failed
2022-09-21 19:00:03.400008814  wiphy_estimate_data_rate() failed
2022-09-21 19:01:03.914491632  wiphy_estimate_data_rate() failed
2022-09-21 19:01:03.914757217  wiphy_estimate_data_rate() failed
2022-09-21 19:01:03.914913093  wiphy_estimate_data_rate() failed
2022-09-21 19:02:04.330909755  wiphy_estimate_data_rate() failed
2022-09-21 19:02:04.331301674  wiphy_estimate_data_rate() failed
2022-09-21 19:02:04.337681258  wiphy_estimate_data_rate() failed
2022-09-21 19:03:04.952352118  wiphy_estimate_data_rate() failed
2022-09-21 19:03:04.952618870  wiphy_estimate_data_rate() failed
2022-09-21 19:03:04.954390881  wiphy_estimate_data_rate() failed
2022-09-21 19:05:05.888497093  wiphy_estimate_data_rate() failed
2022-09-21 19:05:05.892618787  wiphy_estimate_data_rate() failed
2022-09-21 19:06:06.408358738  wiphy_estimate_data_rate() failed
2022-09-21 19:06:06.408622948  wiphy_estimate_data_rate() failed
2022-09-21 19:06:06.408775991  wiphy_estimate_data_rate() failed
2022-09-21 19:07:06.825353657  wiphy_estimate_data_rate() failed
2022-09-21 19:07:06.825619158  wiphy_estimate_data_rate() failed
2022-09-21 19:07:06.825780660  wiphy_estimate_data_rate() failed
2022-09-21 19:08:07.344332088  wiphy_estimate_data_rate() failed
2022-09-21 19:08:07.344597589  wiphy_estimate_data_rate() failed
2022-09-21 19:08:07.344746424  wiphy_estimate_data_rate() failed
2022-09-21 19:09:07.964364775  wiphy_estimate_data_rate() failed
2022-09-21 19:09:07.964632610  wiphy_estimate_data_rate() failed
2022-09-21 19:10:08.383362307  wiphy_estimate_data_rate() failed
2022-09-21 19:10:08.383628475  wiphy_estimate_data_rate() failed
2022-09-21 19:11:08.899357239  wiphy_estimate_data_rate() failed
2022-09-21 19:11:08.899625991  wiphy_estimate_data_rate() failed
2022-09-21 19:12:09.418348108  wiphy_estimate_data_rate() failed
2022-09-21 19:12:09.418610068  wiphy_estimate_data_rate() failed
2022-09-21 19:17:48.847389948  Received Deauthentication event, reason: 4, =
from_ap: false
2022-09-21 19:17:48.966528970  wiphy_estimate_data_rate() failed
2022-09-21 19:17:48.966792346  wiphy_estimate_data_rate() failed
2022-09-21 19:18:06.904422636  wiphy_estimate_data_rate() failed

P PLEASE CONSIDER OUR ENVIRONMENT BEFORE PRINTING THIS EMAIL.

This e-mail (including any attachments) is confidential and may be legally =
privileged. If you are not an intended recipient or an authorized represent=
ative of an intended recipient, you are prohibited from using, copying or d=
istributing the information in this e-mail or its attachments. If you have =
received this e-mail in error, please notify the sender immediately by retu=
rn e-mail and delete all copies of this message and any attachments. Thank =
you.
