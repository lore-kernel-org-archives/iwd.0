Received: from mx0b-008cba01.pphosted.com (mx0b-008cba01.pphosted.com [148.163.139.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9D8213E77
	for <iwd@lists.linux.dev>; Fri, 10 Jan 2025 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.151
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736537746; cv=fail; b=nPPvKTEHljxyVpJFJou6ozDzNmCeoDUKmGs+gBkVU90Ic4SKRHz+0mipfy4+n1XT3WUwZyUBs5qjD6EMD64Rc2TB0cF8gNX1Ebu/STKB2DoES9XfElnOsPCxrPbizD3BUDHC9AHO0Q6hxfkK6WSTgupZ63R4/R+uMjTmjvlxX6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736537746; c=relaxed/simple;
	bh=QP9XnR+8U5lUphBlaYXZtXZprWSSENz02G9Xq4TbIpU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=d821d+Fht8flgpLY22tTmcGw54llrRV/bLENBIf5WVF28Fb45yEEStFQFg9iNgBHtxj7VtPzdICnF1VFpWkqgl/iULJ1xli6G0kw1DJOXxxyNwZPGCF4Ps6/ojCnby1xvCa50564bA8bQN6/cZuv9jr1aufS6Lk/ju7nTMeHjSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=midmark.com; spf=pass smtp.mailfrom=midmark.com; dkim=pass (2048-bit key) header.d=midmark.com header.i=@midmark.com header.b=lJXFDQyN; arc=fail smtp.client-ip=148.163.139.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=midmark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=midmark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=midmark.com header.i=@midmark.com header.b="lJXFDQyN"
Received: from pps.filterd (m0372076.ppops.net [127.0.0.1])
	by mx0b-008cba01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ADkHvt025307
	for <iwd@lists.linux.dev>; Fri, 10 Jan 2025 14:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=midmark.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=F18ZRRa/2SLNS8N28OMxyrxcGkR
	/q0o0EHe3YPFDBD8=; b=lJXFDQyNGRBtBi2l4XqGvQPenTdWvMR0rx0XYB/sMxA
	UU9h00W8nmy6Zx/Ad0WEl2RVIbyyQYvgr+p+eif1Oex3oRzHPJYw5+PhJwlP1wso
	rKJNLmZ0H0M0cR7jq0/J7jUTBp5ypH2OtMOQ0VUoNmojf83luu0Li9qkFM2ox2aN
	YiWVj/GwXMpWoZ0BLxOPEk1iUXOgZXRpIE5jIzvEN+0KExgSNJTEI/5K9DO2rv66
	PNAlWLLceRZlLsQVB45bCbnj7npCUmcbZd1k8di1vXeQ7ckAjbcNOhlsqmMdsB9A
	mo6yW9P0ELyUSqvqvKB9IL+xFhfnU2yIacavwV9kUZw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by mx0b-008cba01.pphosted.com (PPS) with ESMTPS id 4434qr8b75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iwd@lists.linux.dev>; Fri, 10 Jan 2025 14:35:36 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnMiIu3NmOCxF4Lpvpz+vkMGn1EwQ3Obeb+vr+E8p20VOgAZLjlZDNx61gXmVnKYS0Fwh3Sn3cC2dNUz1Y6J5XcMJnmf3A3mifYR5cqq+DvUsva/ijMvNLYmp/NV6RiExRR2YMYlIVgVXj/X8dQViJQRHxaemWXyxHYUO4tTDON4tAReE1tQTIXxqyK6C9obAl3e582IBCIETwj8K6+eDFCAaMHJPPSh4A6RJaM8aqg1F9wucVDPN71vXmMYyjpSm/pn2YLuYKxIbrdqYtIqco2jH4ZbPBAoMig2pu+YFMVub2b1Sd1+x279KtzfXjnNXotURqcDqVUXs2U6UR89bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F18ZRRa/2SLNS8N28OMxyrxcGkR/q0o0EHe3YPFDBD8=;
 b=XiG/z0f/P7UH72SKHiFTsAZ+NSnM+Ycc6Nd5QskB6ZXXSlpVEy7WCD3PYulB3dHbpeBVGzUdYPFrIFBbF2aHPOBpvhwft44BkQYBVveIuWT7urPt9RGOaSIJUD8tDMqWMuQ5K3SXkrm99wg7J/AtS1pzi++sdF4xCqQGdnxVmlqBPkTqJhz/HWSsH2uBPGHuexvs+ubDbgUmu8t65Ie0j3hqNT5PDyZLf+Lm7MFumVKtyPCBjIk5leWqZ01UWvEQlExsucdIxxvlkjosUiiRUtaizXSjENXzO39dYInkaGuj2SwaWF7Fp8/ru5EO8G0UxSm66d2ln6GUceLm3ats/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=midmark.com; dmarc=pass action=none header.from=midmark.com;
 dkim=pass header.d=midmark.com; arc=none
Received: from LV8PR08MB9350.namprd08.prod.outlook.com (2603:10b6:408:1f9::14)
 by SA1PR08MB7232.namprd08.prod.outlook.com (2603:10b6:806:1aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 19:35:35 +0000
Received: from LV8PR08MB9350.namprd08.prod.outlook.com
 ([fe80::7973:5566:a047:872b]) by LV8PR08MB9350.namprd08.prod.outlook.com
 ([fe80::7973:5566:a047:872b%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 19:35:28 +0000
From: Michael John <MJohn@midmark.com>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: TLS based WPA-Enterprise authentication methods on kernel 4.19
Thread-Topic: TLS based WPA-Enterprise authentication methods on kernel 4.19
Thread-Index: AQHbY5VQEKn5b1WOiUmPuKtCph0ItQ==
Date: Fri, 10 Jan 2025 19:35:28 +0000
Message-ID:
 <LV8PR08MB9350AF162B98623BB2E6AC85AE1C2@LV8PR08MB9350.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR08MB9350:EE_|SA1PR08MB7232:EE_
x-ms-office365-filtering-correlation-id: cf60d4c5-fecc-4d95-5ae6-08dd31adf04e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?kNYW48jHi0mf66PHihwcQT59x3FcRHHlC9fd2hsW2FFvNlmKjOBs8gSq40?=
 =?iso-8859-1?Q?Npbi6pTR8wYU6a7LPjAsv8KQCFyGHCKsUXUFGgNM5gbB6kJXVe2KOZKGLw?=
 =?iso-8859-1?Q?vNFdZPuDajcAIdJvCPQZVlWQ/EFx0ay1ELXz0WLGnDD9lp6LfL8t8pDe3B?=
 =?iso-8859-1?Q?FMO+QHj9YQcbzVI5an9koG1iwT3yG3MqKQ2GqokS0MYB22D0YoUHFvWOiU?=
 =?iso-8859-1?Q?sGitstATQUqfngOVMOT+twyRRPtE8KcGrkstXvhUr9zt8qReFI0R9qe9XD?=
 =?iso-8859-1?Q?57GV3PynZzufnVCMxmHx2Nf3ttRChf8yEKXMnCgd97wxdXQoHzb5ucID7J?=
 =?iso-8859-1?Q?42jlkjnGfif/Ed4Zg290ZszhUJ8QGIb+tz2WeR3NpeBr5H2LqgYvlK+NVu?=
 =?iso-8859-1?Q?E3Pmh46WdQjjmu0VVorcNmOrf0bejPKYhipALy0M1yLjtqgkTb1V4KlxpP?=
 =?iso-8859-1?Q?8JnIzZ5C1S6hbIkwmBEF+HXS8R2hzkkdYvInnPKxFmsNZ+SvtcQDCHFmej?=
 =?iso-8859-1?Q?U2vM/TneFGh4t7y3gM5c/syKoh/ksSIW4DkoG9xZ5zCTwxiva6kmHvrrq9?=
 =?iso-8859-1?Q?HAlOmuaf8NxvhDjzilmIt775phEbH9MGwiNpKzmcT3bIEcjRCk/Ud7lnmL?=
 =?iso-8859-1?Q?Mz+WyBSGk6HE3lV/F904bptFBo1xH58wTXS+qPcDqqw9ispNAy2n3swvSU?=
 =?iso-8859-1?Q?4hKNFwnzcD/EUxw4yxewxCzGJ929ufjjKVtlCdUeARF02efc4pF1QUSTME?=
 =?iso-8859-1?Q?OVr49MCNDmByKt0j2CGLQVr+yl5qQU/xVUKGssNDJjmxGCjMsxLk2Az04U?=
 =?iso-8859-1?Q?nQOVZX89delGc493JXnmkj+vzzDy7JaH61gkrX3TPKL93SQANdJ0mkyRcH?=
 =?iso-8859-1?Q?DQR9uOV2hJzJ86GpS5Cqb9Gfhe6grnDgp3okBy5k3vu2tliCoBTJmpjutR?=
 =?iso-8859-1?Q?Xs9nJvdb57oGeXeABL8Vn5iOGiflrybJCeNi/KM/CEmHauxl49abIgKvG+?=
 =?iso-8859-1?Q?STyMlBMcNb8/PvnRMgq/6OF1LwEStuFq4JrCC4e6YuwCTCWVKSv50pYiSo?=
 =?iso-8859-1?Q?Qt9tFvpIRah5VOZIY4p40U/XVdqJAYiFTO8wewopZrrMLHfptrOyb+B0Uf?=
 =?iso-8859-1?Q?F3TODMeHDebhmGLgLJajl/XHPbgCkP+qVRTvfxdvDt8r4JYzzgvGxHiEx3?=
 =?iso-8859-1?Q?yPZ+NNsq+l96Xq5yvD9DeaS9oZvDtSgHsRH6K1aUmGH51dUzb8g6HVljy0?=
 =?iso-8859-1?Q?KoG7j0LEJPs165bLa9LD/7gUN5VQUdKLYGlsCmV61j4HHzVda2+k30CzEX?=
 =?iso-8859-1?Q?M6uJlpBqqvgBZqgGBBc+qmKjP/plF07LAIAeDYNvghAmfDwNSJCoGGguPy?=
 =?iso-8859-1?Q?ennh7oeacq9OQkuLd+CbL876+EwlvfyfOh4KjIdxsScFyBoBuQuA0GpNLA?=
 =?iso-8859-1?Q?2P132Q30ALvXuI8W90cnuUYeG18IGwk9kYJIhA5qVBBc8+O2BC35rd4HzY?=
 =?iso-8859-1?Q?8+QmrJNZUTCrYNXyLvdXo5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR08MB9350.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NHL3d1jRfHxEXIxEQaVK6HjLWgYMWsicGT/3YGCXLq+ka5gDKxqqcHbbNB?=
 =?iso-8859-1?Q?Fy3VR4rFXlqRr5rKNxVzrgBxBUzJs/KtRE6ROfEfaTKcuzm9VsGWkd3+1O?=
 =?iso-8859-1?Q?QdHHsLBARZOuVQvbAjernFNiREO/nyU7P8DKUclBf0r0qUP5m3W+8N6r/+?=
 =?iso-8859-1?Q?x+QgH/QOkt8VfbVBNzs86Ms8Z6ChbMwWCtlE6j8HSuHBOUN58qvvISVOJ7?=
 =?iso-8859-1?Q?ZF21gVoqyYBdNE6YRykyrgdh81lkB1SD7VgoGrd1MryN8+2UOmL8D0fPxC?=
 =?iso-8859-1?Q?ZCbmOqwIwgVP0XzVXrhhmk5q2E3UrB5IAG3bOhI7lDRdV0QcyOF1XP+iHI?=
 =?iso-8859-1?Q?ML/WM12FqNvI33QEuzwOoZTGkgUwQiXyM9LiF3jqkXXUdLeL16e+7f2dmm?=
 =?iso-8859-1?Q?zKsmio2su9NmDh00r1PLDm2SAr5clTCZMf3S9T1FH5vMkd2D92WNvYNbRu?=
 =?iso-8859-1?Q?FcA1dZMZy8ssO26BZA2SZqYL9mGE0rfcQbSTvAdh0vep5HshK3g43tvWMO?=
 =?iso-8859-1?Q?WUQmtR7JtzcDQdF9VLwHQAKWxlz1cBgHloM3Wj5+TmyysCvFJq3ldn4lbm?=
 =?iso-8859-1?Q?LPthLFdQJe5SzrWFETCqx3PIe49NeTfQyZTOjDVoZd5qb4T08LW1gyOREh?=
 =?iso-8859-1?Q?sEXNizEUkDbP1QeDvVar9YpvFbu/LAoSZWLrK62WT3wdAphSlN0puOFS7s?=
 =?iso-8859-1?Q?BFdWT9K04ug/X/QUauziBBHaXHiwfULeuF9qsEyBsEE3rhjJk2X5TY9wd+?=
 =?iso-8859-1?Q?gBwrZ03kYTbI0XRijSXYSE3OrYlko9dhT3ZJnzLpS5uKC26EjaIzH72F5v?=
 =?iso-8859-1?Q?PbolZz6XIvX9NF/vM1koZEQBpV1mDl/3XEPLe/8wUnWm1c1hNpflxttI+D?=
 =?iso-8859-1?Q?VAfCpREMsWBDMk5BhyXpD7F+qsd+EX0ptu5xIL7ksko+SCs5dV8pJXt/ja?=
 =?iso-8859-1?Q?iXMm5qmxJW14v19VlYo7bJzrfcPXT8t7clZmlZ28XbMEese+Vj5iezRDHt?=
 =?iso-8859-1?Q?/QguG/MGj/WPuxWpvJHCbc6gKUTY13RHlsfNoXbEj8ZcCWp+9607rIhWj1?=
 =?iso-8859-1?Q?sT9cSgPRjEeAUurM3jTAhtxcF00vjgfG79UloJjzSs2Np/a+uFi39vPaYJ?=
 =?iso-8859-1?Q?05o/TH4UlwHy6LkGmEbFx5jbLDQoCj+n6pFL+prxhUV8ZcauSb7cfPBTTA?=
 =?iso-8859-1?Q?rMEmWmQfmq1l4aRXAUngXq9VOQYI3ONBWSYbGHdl0WkJJPpvVvfsgrud1b?=
 =?iso-8859-1?Q?Ftjh5BM7RYWWnUyUxmszT7z1oIQFAznfbn8NR8X+cGfDtdpbg2En5vwn5Y?=
 =?iso-8859-1?Q?TS4FIuejS7cx7dRxBkmpuqHvLtlX7iPSZxXK79vQiTKLmZDxqOc54xejB5?=
 =?iso-8859-1?Q?cuFASdaRmE03by2+YiWbZafLgJkabJZJbv+a45MlChUIzbW5SImhGfUuk+?=
 =?iso-8859-1?Q?EkD9GPOWI0PmEslVjD/XGUdVgws6wtdvd2odznNhD5v7VqMfl6JvNQXnDU?=
 =?iso-8859-1?Q?nNgIz78g/Jstd8KbS+BBOC9WDdHs0L7hxB1alG59RGUlWAhAkmf52NhiF5?=
 =?iso-8859-1?Q?aFw202qsrJo7d7lZoD5J6Wcmv1xRRdLKNCwdGtwd4t9zL8iE7da1yupS0s?=
 =?iso-8859-1?Q?rAD4cg/JzyVx4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV8PR08MB9350.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf60d4c5-fecc-4d95-5ae6-08dd31adf04e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 19:35:28.7080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3c2a020d-f343-4ca1-b6ef-91768380352f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BkhXwlfkIaeoyOyvybVR3+L5aPuAlKmLvYVCVyUTHxzttuF04Xz2X0gM+Xuqe1Aixt6B+dyVcvGscNbf9pvzFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB7232
X-Proofpoint-ORIG-GUID: vCXuCM-7C_9AilcJMsOf6RznLEts3Fu3
X-Proofpoint-GUID: vCXuCM-7C_9AilcJMsOf6RznLEts3Fu3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hello,

I'm running Linux kernel 4.19.231 (embedded, Buildroot build system) and wh=
en starting IWD I see the following message:

Jan 10 19:13:39 cm1sd systemd[1]: Starting Wireless service...
Jan 10 19:13:40 cm1sd iwd[1537]: No asymmetric key support found.
Jan 10 19:13:40 cm1sd iwd[1537]: TLS based WPA-Enterprise authentication me=
thods will not function.
Jan 10 19:13:40 cm1sd iwd[1537]: Kernel 4.20+ is required for this feature.
Jan 10 19:13:40 cm1sd iwd[1537]: The following options are missing in the k=
ernel:
Jan 10 19:13:40 cm1sd iwd[1537]:         CONFIG_ASYMMETRIC_KEY_TYPE
Jan 10 19:13:40 cm1sd iwd[1537]:         CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTY=
PE
Jan 10 19:13:40 cm1sd iwd[1537]:         CONFIG_PKCS7_MESSAGE_PARSER
Jan 10 19:13:40 cm1sd iwd[1537]:         CONFIG_X509_CERTIFICATE_PARSER
Jan 10 19:13:40 cm1sd iwd[1537]:         CONFIG_PKCS8_PRIVATE_KEY_PARSER
Jan 10 19:13:40 cm1sd iwd[1537]: Wireless daemon version 2.17

My kernel has many backports and all of the listed options exist and are en=
abled.

> ag 'ASYMMETRIC_KEY|ASYMMETRIC_PUBLIC_KEY|PKCS7_MESSAGE|X509_CERTIFICATE|P=
KCS8_PRIVATE_KEY' ./buildroot/buildroot/output/cm1sd/build/linux-custom/.co=
nfig
2475:CONFIG_ASYMMETRIC_KEY_TYPE=3Dy
2476:CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy
2477:CONFIG_X509_CERTIFICATE_PARSER=3Dy
2478:CONFIG_PKCS8_PRIVATE_KEY_PARSER=3Dy
2479:CONFIG_PKCS7_MESSAGE_PARSER=3Dy

Even though my 4.19 kernel appears to have the required options I still see=
 this error about missing features.
Are there additional features that are required but not getting listed?

Thanks,

Michael John
Midmark Corporation

CONFIDENTIALITY NOTICE: This message, including any attachments, contains c=
onfidential information intended for a specific individual and purpose. If =
you are not the intended recipient, you should delete this message and any =
disclosure, copying, or distribution of this message, or the taking of any =
action based on it, by you is strictly prohibited.
