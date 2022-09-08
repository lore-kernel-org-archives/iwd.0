Received: from mx07-00440002.pphosted.com (mx07-00440002.pphosted.com [205.220.184.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E312E46BA
	for <iwd@lists.linux.dev>; Thu,  8 Sep 2022 17:21:07 +0000 (UTC)
Received: from pps.filterd (m0267195.ppops.net [127.0.0.1])
	by mx08-00440002.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288HJiOv021585
	for <iwd@lists.linux.dev>; Thu, 8 Sep 2022 13:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pselector2;
 bh=q7zFsPjgVFYH+aF6eJlLpfDV5mNp8lzaJQz+S5cHhAY=;
 b=GFK96ZhavMjZD3z+M2sVUPMyo5YR/mZ5WSMXg4wlxuA9PgYc0rnCTDQ1tyP2vragH5sd
 0RikPLFY3920z+IBWxkL5x7iwcRlw22Ty7ZHrR52FCFK2VX7n5FtNsOw69DdbILRPmml
 9o4kj0IjEBvLbILqzc4xKA74QXqMaG0tRXtros7HlTd9ZpPxf1wECyOVd02cxOVBR5tt
 CDypvWli+BIu2kXhbdT/WgJ0LOwJ8Iey/AwI15HJmYm5b83XV4mDoQrr4FN/aAh5jJaq
 XCaRO+h9Sq591HDVO3UCX98q6hIU+YPD+5Qvm8JYoBVZKmG0CgCmDQQGxf8NGmn1j35q gQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pselector1;
 bh=q7zFsPjgVFYH+aF6eJlLpfDV5mNp8lzaJQz+S5cHhAY=;
 b=GdqdvbrmRxKXewWVlq6dpPBFt60KHxuFCDc4xVlrnf0WBXtViXAkgXrKTVWHq8G2BhSQ
 rKXcQpHqfHEHL1tKereI6AA23K19LkNzr9PUOKd9uAGfyL2Ht8l8Rl3FnYWykCVmPIvL
 qopRy+8n6tuo+ncsfvvO7wDlo6EtN+kenV08fhwodXiwelrAiSyVIrh6/z7m2gGnHwEe
 /qlt9lbSUpiojIRbLUR/3XiDGBgMlMFkFyIXUOE0Vd40t2lXiyS/S13+fKEr59Yu3d7Z
 YoLw6gKf+ttH1wmCspMTn9oexRRzoFTNuM07R9wUAKPwro3mp9xVhMfbr3QSlVGvMRL1 sg== 
Received: from eur02-am5-obe.outbound.protection.outlook.com (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57])
	by mx08-00440002.pphosted.com (PPS) with ESMTPS id 3jc0ann1rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iwd@lists.linux.dev>; Thu, 08 Sep 2022 13:21:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJ6zsoSXpWJKemJLa/6lHhLTdY14CU6+COBM5inTB4YOSrcrgQsILyEtiqUUJQQkBs2EW2dH5ZJ5mYNxjqgP9Bsd+qLkuaqcfHO/hmHyqkN9db4LEXz33SMPJWeNhFoBgQk5z++t8QAtMp2jd76ic9TbCRCEXBBWTdWZhL9a226lz5LFqPw2w+kbZpYGpyBcF2nFaf3AXXS5a1u6rT7KBGcQWktr+kZSH1csfwgRHzfOID7bCbB3/gbF49N2xObaB6jvrOqTHLTFaUZZgsijShvegrmEwBSyRpVrc5qwI8zeBpGNX55q/XsYFkp2Ds2TiF113ZLsBYNv3KobNBFG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7zFsPjgVFYH+aF6eJlLpfDV5mNp8lzaJQz+S5cHhAY=;
 b=hFRuOJVnase0jtJwL3nLUfW2epiUyo2HuoDDwoQ+O7D6EDGf/y6KUMjt2RkyHf0hZ0HccF5pvchuxSXrm/bUYGZLu6XKKmkMZkU8WiO2e6ZdB1I/b4to7Wt0ANquh+39Q9UArqaKUcGgpyO2xJaJoI7CkFgvblkNRiZCD2UjnA4B0/fJwXSLQLKAumLfNMBuMp1F/uCPwX0EPiFxocO6M6lPmhCoLcoRTR8xZxhCPgldMkcVenwIqpGYrtdzfwHS2YI7+tgJcKopjWG1Lo10Hr0VPz4VxuJQ7svpdBVbGHyIaNXb8fHQQlt2ENgBEmjoziwMb1FSl2AG2zfbpkXYHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=landisgyr.com; dmarc=pass action=none
 header.from=landisgyr.com; dkim=pass header.d=landisgyr.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7zFsPjgVFYH+aF6eJlLpfDV5mNp8lzaJQz+S5cHhAY=;
 b=eySUAB4FAKm1y50rvU5ILfIOX41HCTeEF93/qbH+U8idmdgyztnt0LW11qeQaft33VgxUgP8tvYKset/Jj+fie8P2PK+V65S/3Cd+LP7ZoP/BcPPAKg3B52m+NW8Zihx+u/AQ31qNDGwLKiPsGf4VgfaHTy2wT/ync0qrO1KLKg=
Received: from AS8PR01MB7493.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:25b::13) by AM9PR01MB7443.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:2c5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 17:21:03 +0000
Received: from AS8PR01MB7493.eurprd01.prod.exchangelabs.com
 ([fe80::b6cc:1d10:ae57:ac82]) by AS8PR01MB7493.eurprd01.prod.exchangelabs.com
 ([fe80::b6cc:1d10:ae57:ac82%7]) with mapi id 15.20.5612.018; Thu, 8 Sep 2022
 17:21:03 +0000
From: "Johnson, Bryce" <Bryce.Johnson@landisgyr.com>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Could not start RRM scan error - repeated 
Thread-Topic: Could not start RRM scan error - repeated 
Thread-Index: AdjDpwit4JRLBkttQ3+PMFfEEbU4+A==
Date: Thu, 8 Sep 2022 17:21:03 +0000
Message-ID: 
 <AS8PR01MB7493D4E15D3465B3B0491B22F4409@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ActionId=d399250f-29a9-4b89-bcd3-6a67d95093cb;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_ContentBits=0;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Enabled=true;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Method=Standard;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_Name=724d29b2-602f-4b77-ba15-b7b42511c7c5;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SetDate=2022-09-08T17:17:22Z;MSIP_Label_724d29b2-602f-4b77-ba15-b7b42511c7c5_SiteId=ee2cd48b-958f-4be4-9852-b8f104c001b9;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR01MB7493:EE_|AM9PR01MB7443:EE_
x-ms-office365-filtering-correlation-id: 78ae2d21-9b0c-4cf4-16d7-08da91be81ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 msRu2v8jMObQTYq6LkyEBT2jHMYg4T8yHuoosHLHEKwZt+IwZZcFaCpmFpDh4RiOaPcwOoFrhV74M+XQocJAgCsXxMtaeV1UDIBn4LGBWbcSGSQDkMx/pzZwAdKfJ2Ho08fK3Qn5HMTTTGi0idIYlbMKJ8dFYVoFe3WdubPGC5lyGKAbU+dD9Q8LBtuiUOuTcXBSTn+vNsEFLIpGRl3knYWFnuMGH9I9c6aSbp2xiQuDgletQ+lYz6BjowldBOo8EJgBY0tALDvVuS/Ue7pq20xnEIBRQwFWBwKiH395D2+RL0fuPUCgg+QAkBqRMBOXK4EVzn9Os3g3+K5Eg7wKHIZOoOO37Mur7j/zgsneTI0cZQ7RBuqHVMYgZuxq/+9rg+bj/Id5ME+MeMrHJS14VnnNuceEfh99saaPQRoBhYebjgg7GJR0jUmA8EEOoEOSTqeOGKcEVnx6yQbKVuUFe3UM2gGoO7Tm1xDp6IilITFfoj2l8H1JCbV18jVKoWW3xKTmrhhW2bnP6Lc/tU9dLtpKNhnhyuL8heUfCQksAB28PLB8VnI8lhVZKpBDcZXseZI7NsujgL7RklnL9zZGWneU8C0u3PvtLZ5HnmTDQwl/3WJpG3nDLM/FO6vIckfdg+3CHie7EjJ4sswu/n3kDNzL/omKZu4KNT8Tjzm+V/frCBEwqvx+6cFI46B4KZt9FUCD+IdhNefPFzeFHLzaTmTsb5ophmoEq9DePMCIKZNRv4gxaWel1W6owz4UFCMzCSoZFU3i/ygST0ercv6OgA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR01MB7493.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(9686003)(86362001)(71200400001)(55016003)(6506007)(7696005)(26005)(4743002)(478600001)(41300700001)(38100700002)(122000001)(38070700005)(83380400001)(186003)(6916009)(66476007)(66556008)(8676002)(66446008)(316002)(2906002)(66946007)(64756008)(76116006)(52536014)(33656002)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?i51kUB241IHVSBq24Mlpu90OmkTYlZkLzbKGDG8Za+6NBTJLm7KygWxaik?=
 =?iso-8859-1?Q?p8TSjRIzgfVmIDOgc7H5cEotwnRZxl+n3yn0LrKDyQq/JXTLBjBbkaaUXq?=
 =?iso-8859-1?Q?7vcmpT/Xp6pXMe2Fzv149OdbKOZ9mFw+GJc1161SBScytELLyoqJY2Bm6S?=
 =?iso-8859-1?Q?TfvQNPjy6lKKZauxMQFQCHy5MBYI/0+GY5njwS0fXaZu0KYTDTXvgmiMj6?=
 =?iso-8859-1?Q?R5gjfxNWSDWkYosXW09YPIx0Z2Txv224m1kF0zvEElsMUdxId95MexcJel?=
 =?iso-8859-1?Q?oZY8+DuVVy1EjPQtVEUAg7amjq/qTRyvG5Awmmb2m7YunXyr04/TDB4EPC?=
 =?iso-8859-1?Q?XZgOmfQka4qfj8D91P+yoTlzozgk+EYXf5wFMvNcmitQbr1hx/CW14bpl2?=
 =?iso-8859-1?Q?UwxpcrMVDGWxXXpQH5V7yLwba4oDiaKgeZ4CWEag6DlPXqY5I8Q1wzkWS/?=
 =?iso-8859-1?Q?8G9rRnLcTtzjwg+1OWx05Z80tiLXXzUSyDVJ9Nkmo7pd2geW02hxH3Ol/I?=
 =?iso-8859-1?Q?26N18XTiDU6lC3RIO0ShzL96Lxbn1JOioYK+KLIC4Nmn/LovUrsXahoXVv?=
 =?iso-8859-1?Q?bXC8hS1Y7rGBOcbxuD620kau1ErIei1d1WvYq+ebQCO1Om4B5m2TpyuuaG?=
 =?iso-8859-1?Q?tqeuNX6+47U/G+l3jBvinKOQZHe/paklqy+rJY/RVj7mgD3dOlX2aoYAYa?=
 =?iso-8859-1?Q?cYIrei++iXVEM3Rj4yZoslk6HUiR2qZx9Nft/6he//WSmxljBhYsZzBWOj?=
 =?iso-8859-1?Q?SsnPsT0yLx2cXVgaU+bgByHSk8f5fRlCUiP5RTQNWM+6SuYCL5BM4MQ3OE?=
 =?iso-8859-1?Q?3t/zzDQPaiYc9fgyN2LC2oHIPB/TkW6s4ioPpZ1AkYWGDc8PKMIJVy75AF?=
 =?iso-8859-1?Q?qnfH6yE0b7LW1Gv1o/5AN40WIHSSadouXUvOtQMIDbtb11DXv4nQOUMkq2?=
 =?iso-8859-1?Q?irVNT/P8cjhmzsClJGTfw9ADa7ioGj5k/36UzGOy+JC3NlZCydZI8rCTwg?=
 =?iso-8859-1?Q?x3SCqCmCS/1BScGHbH5Qxrlv0WIhPS1vTGVqbbkAT1jHQWle2J+3/U6mY3?=
 =?iso-8859-1?Q?nm4JL2kOaocBgoFVV9y/3lbIFm7umCwhxR14/RTenLxYhkCmaSOUkvO4xG?=
 =?iso-8859-1?Q?uN3D6Oq7c1MJhsx3sD8bKL/yGdHLth9PvWEFZTT77Q6OI5pzDkXNhvprrB?=
 =?iso-8859-1?Q?KqMRD99ZyJ2jCXmfjarAacxHnTLVt+pN7LBIMFyrF+gK/vM3acvOiR486A?=
 =?iso-8859-1?Q?lFDvSWSG599UmBzq5FFJXu8sr+/voHu9usEBP43pggGv+RGqGgK7xMmRq4?=
 =?iso-8859-1?Q?whrXP/dSz7PUck9MQb6vDVasyp8NIoBD/573YA3YjA5LAvsO3dqHcfs1S6?=
 =?iso-8859-1?Q?kiyOuHH/yxzVZottU2kEo7QAqVLmtG7wRl8EaHF4R38DWJ7ET6m/Ys4owV?=
 =?iso-8859-1?Q?kF64ZPVn9jij2+DMrYaA6eQq4qBW2DMWbWz3zCbnpT3aJKZCn4DT7aXocC?=
 =?iso-8859-1?Q?zbk3NVZ2uO3YrW2KhZKNBANwmPDxncMgRcsXeMAWlLULgyqO5cu3MFvvcK?=
 =?iso-8859-1?Q?a7DMyItZi6cQQSGM5fZL7Q7AZxb99nbQxMURZfrrazP7HGIrfSJPStV3H5?=
 =?iso-8859-1?Q?MDG8VM/kf5qfIJCT7uEaKB1u2Fkt1c9dCl?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ae2d21-9b0c-4cf4-16d7-08da91be81ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 17:21:03.5621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vTbxacSkW1JGqVqEKEnwpAJ8u9lI/Wb09YMMEQr30pkYWR0sauHy1BQuLnCSfn49ViR7YuwmkIQCn1GpxzU0H2Qx1n5nvoKtjruCaBdsNk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR01MB7443
X-Proofpoint-GUID: fODYzJSANMYFFyHo3hoIhruhmnLIg39g
X-Proofpoint-ORIG-GUID: fODYzJSANMYFFyHo3hoIhruhmnLIg39g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_10,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080062

Hi All,
I am seeing this `Could not start RRM scan` and `Received error during CMD_=
TRIGGER_SCAN: Invalid argument (22)` error on iwd 1.29  every 15-30 seconds=
.  This is on an buildroot built embedded linux device with a wf200 radio (=
2.13.2 driver).  I had previously had issues with connman+iwd and a lower v=
ersion of iwd (1.25), but I removed connman for now and updated to iwd 1.29=
 (and ell 0.52).


The error might be related to an occasional drop from the AP and not reconn=
ecting as well.  I have only seen this on my home network (Tp-link archer A=
7 and archer C6), I have a few devices on different networks/APs and don't =
see this issue.  Next I'm going to disable roaming scanning to see if the i=
ssue goes away.

Here is the portion of the debug log that shows the error from iwd:

2022-09-08 16:47:14.319877134  src/netdev.c:netdev_unicast_notify() Unicast=
 notification Frame(59)
2022-09-08 16:47:14.320330902  src/wiphy.c:wiphy_radio_work_insert() Insert=
ing work item 108
2022-09-08 16:47:14.320497579  src/wiphy.c:wiphy_radio_work_next() Starting=
 work item 108
2022-09-08 16:47:14.320643359  Could not start RRM scan
2022-09-08 16:47:14.323058208  src/wiphy.c:wiphy_radio_work_done() Work ite=
m 108 done
2022-09-08 16:47:14.323230842  Received error during CMD_TRIGGER_SCAN: Inva=
lid argument (22)
2022-09-08 16:47:14.326895157  src/netdev.c:netdev_mlme_notify() MLME notif=
ication Frame TX Status(60)
2022-09-08 16:47:29.505877918  src/netdev.c:netdev_unicast_notify() Unicast=
 notification Frame(59)
2022-09-08 16:47:29.506172411  src/wiphy.c:wiphy_radio_work_insert() Insert=
ing work item 109
2022-09-08 16:47:29.506345046  src/wiphy.c:wiphy_radio_work_next() Starting=
 work item 109
2022-09-08 16:47:29.511265145  Could not start RRM scan
2022-09-08 16:47:29.511557924  src/wiphy.c:wiphy_radio_work_done() Work ite=
m 109 done
2022-09-08 16:47:29.511914160  Received error during CMD_TRIGGER_SCAN: Inva=
lid argument (22)
2022-09-08 16:47:29.512925593  src/netdev.c:netdev_mlme_notify() MLME notif=
ication Frame TX Status(60)
2022-09-08 16:47:51.733225794  src/station.c:station_roam_trigger_cb() 3
2022-09-08 16:47:51.733527013  src/station.c:station_roam_trigger_cb() Requ=
esting neighbor report for roam
2022-09-08 16:47:51.740930338  src/netdev.c:netdev_mlme_notify() MLME notif=
ication Frame TX Status(60)
2022-09-08 16:47:51.741220228  src/netdev.c:netdev_unicast_notify() Unicast=
 notification Frame(59)
2022-09-08 16:47:51.741389297  src/station.c:station_neighbor_report_cb() i=
findex: 3, error: 0()
2022-09-08 16:47:51.744929179  src/station.c:station_roam_scan() ifindex: 3
2022-09-08 16:47:51.745213202  src/wiphy.c:wiphy_radio_work_insert() Insert=
ing work item 110
2022-09-08 16:47:51.745380240  src/wiphy.c:wiphy_radio_work_next() Starting=
 work item 110
2022-09-08 16:47:51.746906372  src/scan.c:scan_notify() Scan notification T=
rigger Scan(33)
2022-09-08 16:47:51.747171845  src/scan.c:scan_request_triggered() Active s=
can triggered for wdev 1
2022-09-08 16:47:52.812884701  src/scan.c:scan_notify() Scan notification N=
ew Scan Results(34)
2022-09-08 16:47:52.813174817  src/scan.c:get_scan_callback() get_scan_call=
back
2022-09-08 16:47:52.816425758  src/scan.c:get_scan_done() get_scan_done
2022-09-08 16:47:52.818357321  src/station.c:station_roam_failed() 3
2022-09-08 16:47:52.819990960  src/wiphy.c:wiphy_radio_work_done() Work ite=
m 110 done
2022-09-08 16:47:52.820283603  src/netdev.c:netdev_link_notify() event 16 o=
n ifindex 3
2022-09-08 16:48:02.094920605  src/netdev.c:netdev_unicast_notify() Unicast=
 notification Frame(59)
2022-09-08 16:48:02.095207471  src/wiphy.c:wiphy_radio_work_insert() Insert=
ing work item 111
2022-09-08 16:48:02.095528864  src/wiphy.c:wiphy_radio_work_next() Starting=
 work item 111
2022-09-08 16:48:02.098414226  Could not start RRM scan
2022-09-08 16:48:02.101949460  src/wiphy.c:wiphy_radio_work_done() Work ite=
m 111 done
2022-09-08 16:48:02.103862022  Received error during CMD_TRIGGER_SCAN: Inva=
lid argument (22)
2022-09-08 16:48:02.104241186  src/netdev.c:netdev_mlme_notify() MLME notif=
ication Frame TX Status(60)

Here is what I have for my main.conf
[General]
EnableNetworkConfiguration=3Dtrue
[Network]
EnableIPv6=3Dtrue
NameResolvingService=3Dresolvconf



Thanks
Bryce

P PLEASE CONSIDER OUR ENVIRONMENT BEFORE PRINTING THIS EMAIL.

This e-mail (including any attachments) is confidential and may be legally =
privileged. If you are not an intended recipient or an authorized represent=
ative of an intended recipient, you are prohibited from using, copying or d=
istributing the information in this e-mail or its attachments. If you have =
received this e-mail in error, please notify the sender immediately by retu=
rn e-mail and delete all copies of this message and any attachments. Thank =
you.
