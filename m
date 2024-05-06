Received: from mx0a-008cba01.pphosted.com (mx0a-008cba01.pphosted.com [148.163.135.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87804642B
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715003084; cv=fail; b=SClL0ecFt0J0iPzlEl5KlhLSF+Z0n85Ww4enybM8qXYsJxsldzyWJ2d/RZ1WbZjI3wQPWDQG73rjwMqUVxIE4OoGskYAbDRQLug2Nh9tHP64HLgs+v8cPRiqwG4bmcFGK5itssjaVrsdO1GCGtccGz97Np69UYBpJo3i3iYA9yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715003084; c=relaxed/simple;
	bh=J/1fEjFqBVpjk7vxlyHFYVhbMh52hgzsMSVQQszfj6A=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WJMBHak/WPJWkzNJugZOus2dY7R/D8wIssiICZcW55MHBBHXXlzLurdDr3NTlF+K8OoLvSxUHaHKjU5jnB1U2nH1PDgLCKwRMf9Zv2sg5LbB1mGipHcR98hOpPxu0x3wVlbv7c7fFz3OUbWusONHiTMjgFDg/xtZhChJM08iQBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=midmark.com; spf=pass smtp.mailfrom=midmark.com; dkim=pass (2048-bit key) header.d=midmark.com header.i=@midmark.com header.b=blkQopeK; arc=fail smtp.client-ip=148.163.135.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=midmark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=midmark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=midmark.com header.i=@midmark.com header.b="blkQopeK"
Received: from pps.filterd (m0372074.ppops.net [127.0.0.1])
	by mx0a-008cba01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446AtJFO017776
	for <iwd@lists.linux.dev>; Mon, 6 May 2024 09:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=midmark.com; h=
	from:to:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pps1; bh=3/OMoiXQ8QWU
	7Rsoh+eplI6yDsGB2wjGfBEDvIl7he4=; b=blkQopeKxpkN05wud8Q7H/9TE+ZG
	OxOD/71CZSfSG2WdSTu+X70Q9/Zh5gROgn7Ztv7QSMYwZe3Xe/D/yLfAXb8lYVbh
	LkIyTv/FmkE2dWquSOjTEgt+G7tmOhhaBvdtoWS2Y2ujBGBjL28bvMEsQvWTJwA9
	2kwtvexHPhPZXPvylj9gP//USR8UnfCZNnQdNcAcC465iTaGEZ/OuY+ijwSOmcEu
	6nDEbaFfC+nHVa4bsoTugb93bw3MxbbYQIfKbapssXOlD6U9j5e5AfdNpi+2iFZb
	Hj1uLHNwKXCHMtZoiyOqOXoZ2T5umcMAN4Gy7Qlt8Q81j37Xw4ORfMy1JA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-008cba01.pphosted.com (PPS) with ESMTPS id 3xx65trn2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iwd@lists.linux.dev>; Mon, 06 May 2024 09:16:25 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0RQIBa9NmXYxPnH+BWIPgym3+L6e8/DdznUu0ytIpttngEv1nuTXxckEccca9rRv7eNAtjhlrM1gVm6vVf1xBy0P/S2LblxSaNpvIIie0xkiZtN5rbAQI2Ija0FTp8uExGZeRAuNQTZrczWQ9rz61IHIJ8LiIuCcuxuidKb7adaOfB0MkoTlcuzlIaGa6hitflat3cwe1bv+oNCUimgzmiujvYOmEktl8UMgHIRVvC7un5EhZgvp3vOOI5rzaRsWS06gwHcvnlcCTMxtIlvR7+B3pODr0MZrJ64Ky2dFzdD5KgMbIAYf426wvFE8vAstSiRH7ZiDAEvNDOk06CweQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/OMoiXQ8QWU7Rsoh+eplI6yDsGB2wjGfBEDvIl7he4=;
 b=UtwwES0vuhyZY3Q0agyLw5XZfCqtN/B4QxII89ZCxfzCnJkt3E9Zpa2027Pm+WsM2rWkyUsC4EU3uUARUWmI4wAFr4tmcKOIly2zXrAbnYljsuGttbyKNBGrKjfgoQA5wzPAnsnX6USIU3DXZTBksuUcwZNju2qTV/6nSOWwFcWQpuCkui5m4zGskcaVbZMBMMHl+1gcFRzEymVSzrLlGp0kFNTXwvu2GiDnuzqQmzONqXU/Pf1MNjGvF+SgPL2ddW6ysiWfbEk29+4h5rh1ThhdutMageP9b6/AigMvCqWa47x1gwSv1K3mbC/WcZgJrG25hgJzyHv7+ZMzYwlcFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=midmark.com; dmarc=pass action=none header.from=midmark.com;
 dkim=pass header.d=midmark.com; arc=none
Received: from LV8PR08MB9350.namprd08.prod.outlook.com (2603:10b6:408:1f9::14)
 by DM3PR08MB9013.namprd08.prod.outlook.com (2603:10b6:0:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 13:16:20 +0000
Received: from LV8PR08MB9350.namprd08.prod.outlook.com
 ([fe80::7973:5566:a047:872b]) by LV8PR08MB9350.namprd08.prod.outlook.com
 ([fe80::7973:5566:a047:872b%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 13:16:20 +0000
From: Michael John <MJohn@midmark.com>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Getting list of found networks
Thread-Topic: Getting list of found networks
Thread-Index: AQHan7ePre4eCmlnGkWJ2z4c7hs7Hw==
Date: Mon, 6 May 2024 13:16:20 +0000
Message-ID: 
 <LV8PR08MB9350F79243154C9930EFC4BEAE1C2@LV8PR08MB9350.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR08MB9350:EE_|DM3PR08MB9013:EE_
x-ms-office365-filtering-correlation-id: 909b3276-110d-428b-3dba-08dc6dceb896
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?bt94Do8J/WjMBzgSfjafB4aYqI6GSMb+FbQBssDaAtnO4P3IDC7fYhY75/?=
 =?iso-8859-1?Q?kjs6gNNLyxjllMULSP2xeQ3PWTpOCVSKzBxUdTtyVOABI4Ph4DcJgC1Meg?=
 =?iso-8859-1?Q?8jkX4Rfgz8YkjrKfJyboqzdlLpOMt0XGj3oK90o08zxV0IX97wtuwETvGg?=
 =?iso-8859-1?Q?QpS7tltv1Sk/03IFr9hh0tzjpQcHvmVL4a4+JERjT822x1t36gRBcaDdqo?=
 =?iso-8859-1?Q?hQxZx6hReq87qSXIBTzjaUUTBcb3WnPYVvyusfKyhTLguXXS0VkCEQJC7y?=
 =?iso-8859-1?Q?uKpPVs2GsJl63Hm/9hKJ3ru0LmDLDZrr10KkJSXa6DK/uQ0vCSWWhJD+2A?=
 =?iso-8859-1?Q?LzlqgZHp1Ow9Pa2XsOwSLBTPndfvvdF2UZf/PxRGKH6LsNPk7xZp+yfcRM?=
 =?iso-8859-1?Q?NXzoMa+HFQHJmiHJGtSbHSK8I+0AlII0FW6Gl8gld6RF3urSZHpqbqdqsI?=
 =?iso-8859-1?Q?4uuOZMMrseiX2i0TtGqhSur4DAvpwcvsu/rtqOk1l/EaSlHEs6G+fU9MVm?=
 =?iso-8859-1?Q?wzeemR2+FveWqjDTu4vG2PoaVwXL5pt2JEmgmrPkFbSsz2Y688KkROzDMR?=
 =?iso-8859-1?Q?ZFZQ9YNjPScdwey9KN2KaezUT2D662el2RRc23g6T1eUmrDrqepA+P93qU?=
 =?iso-8859-1?Q?e/IJItHsu+skV74fihe9Ole988JOSM98wHqA0a8S1D0gLffodnNRn8cANi?=
 =?iso-8859-1?Q?AyaWGtpeKCR+t32ESal/cvD0Xu95LLj8cGA4z6cUxLCAyuRf5Hqy5NFMN9?=
 =?iso-8859-1?Q?+EfVMWwPKT7BkkqKm9XYCHREmsKbV9164rabw70OG1fqIftJBa+OZIpkEa?=
 =?iso-8859-1?Q?LB5X9s03tE4Pi+2x5XQYDOT/vb6rbF8voApi6vMuIdb2mTjDCJgjvCANQg?=
 =?iso-8859-1?Q?dptcnjn1OvywzeNwn9tUIqbz1uysrEvITEytZbvYK3Jr4m+n3It5ZciLS3?=
 =?iso-8859-1?Q?VRrhkJL3NgcIgVjrUcWc5CJeOEVB/FMbty9BEQIo9gN3GKbn20y+WMquiI?=
 =?iso-8859-1?Q?9DC8II2ywv8PJeo0m0MHL4Rg16V/AMyZMDlOn0H+YIBxt7FYiVRmHKPZSq?=
 =?iso-8859-1?Q?Autegce4JJc3OUyV67O3vD62e1KyhcBH6lN6+/ok71+OcpdGmd6sp4RcCo?=
 =?iso-8859-1?Q?BGLxGL/T+hJjTn5LXU0WFngHsEpwP8uKQy9XEEgk6PERr0qRw1ZYsSq5hG?=
 =?iso-8859-1?Q?McEP/C8/ylvI/dXl00V126c5E4Z0L6a3JfpEVXl2ekgeuRbGK4gvdTJZNY?=
 =?iso-8859-1?Q?XBs73v9Po43LFo5g6sqfsheqlI0WXJY15Aes663lhT5hBtPav9XOIVjrwW?=
 =?iso-8859-1?Q?YG8FxiYsAXigr55iLZdUgm1Aw+Z1hNsRO4PySzxU4gsb45V+X8C/7+fQB3?=
 =?iso-8859-1?Q?dZl9W01akeyEn9xGy3mGCOhfUzJ4StWA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR08MB9350.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?mrvrgfognVlvQCjcOig6XIK+A9kPmWcjTrFp7VdycKgYD05oCnToT7OxdC?=
 =?iso-8859-1?Q?XDXeUSHrHmgCLVDglCsdQ86MRTI+zL84mh70JhxpsxhIcuxbKkTxNofwrr?=
 =?iso-8859-1?Q?wQT/uLAZ+c59JHdCTkLIkzNGfsleKzOMf0nfI4DHjWWQR8LrDlSJCI5QFi?=
 =?iso-8859-1?Q?e8wRWHxA+KXFy51ntBcMg+X3YX7A63E2VgmP5nm6BqsdtPHOho7OFh2nf3?=
 =?iso-8859-1?Q?fZ3hf2DYKCMf5eXjHJ4rSd1Ay+l7TRaGcPToBIITvG52E+rTFUWU4Pnpce?=
 =?iso-8859-1?Q?cOPbEhcJzdLyN76m6MlROMQgskPKxmkR4QoYb1NkP811MI35ha745YbxJG?=
 =?iso-8859-1?Q?UoA2dGVcCC47RyC0TCsbMpkclon732CWhndlpHB44QAeoVGt8sjP+KODdE?=
 =?iso-8859-1?Q?MSH5bEtQziNp+WZfjwqyaKkisGkJLMDS57RqBwoklMPQ4V9KHyohttp+s9?=
 =?iso-8859-1?Q?btuEJaqQCEJHRE+vN1uzdPidHVYtnbWUwDsBAIwcOiXlBCLIL9SSc//Y/v?=
 =?iso-8859-1?Q?exsvPm4nw3BLUePtsXizWfAXWyf73oLjIcs8SSd7TpzFj8Hcq9OFHpGdjo?=
 =?iso-8859-1?Q?YmN7acTz7a4zTxtFdzCOFv4A0sUn/GZNyuFzY8XQk7qv0TXs0qLipJv7Pq?=
 =?iso-8859-1?Q?lv0OpieS8F9CON07VwsXdLck7k12Lq1Xu+jH+7/WVd+x18Qlq+YT4iorpX?=
 =?iso-8859-1?Q?RTC+NLWTu52wY1IiXqD5ic06lQGkv3na4OMI5VWbAhE+FQTUG+MEs63NOi?=
 =?iso-8859-1?Q?K4J/bhBQrOSSW8vniJcdCTf+9hSu0VIYGcbL171wNE1k9HNgF1ZWGX0OG5?=
 =?iso-8859-1?Q?VY4ScaLeFKElOaknSclAxCMVhQCBjGmnANsdWi5xHPC4Bh+Z+ZX8ThTqYV?=
 =?iso-8859-1?Q?6Vzxfxn6M/83EMqliiffnOwET3pD6aqhXvo3fAFVmanmsVP6/uWduHxiDc?=
 =?iso-8859-1?Q?tVGCTH7SXO5C6o3Ajm7T/M8GesQlwuYp7zKokatnN09U5s7cDYV4oHZ7Wh?=
 =?iso-8859-1?Q?3cky5R9lLD3lSilUsrfHVisABVvAOmOf1tJlkcVBy9lW1ZqoYTI7BtXDXA?=
 =?iso-8859-1?Q?/qkG/UORtBCzRbFaNovoGZiNLaOLWJEegl2hza4dJeLYL35EOAzeJFOaza?=
 =?iso-8859-1?Q?kHAKKzhHZeLLpl+FlEO5z93RWnhurf2rew28sHhdc90ErJFagkxJi9F2qq?=
 =?iso-8859-1?Q?qpivO7ElTU+wpSXGfDhwTJKhqzUXIfeK+zWCkjaH0GCZzcWD3Lk9feldOv?=
 =?iso-8859-1?Q?ieK8OBHsjZToKo0Z/3bRI3Xg0vAFsJxsC1mRbu0AVoERMNS3VaSKVIQFI3?=
 =?iso-8859-1?Q?myZYlaH84lIbBtdzOaZlpMDOtuD5jnQMnu4F/xbZRpTNmCByUim1/YB+pv?=
 =?iso-8859-1?Q?90dHqFM0pLMv58rA8u4Sp9rTbTvyUcbjCiiwGZMCX0gDayVbSU7GsxCbWy?=
 =?iso-8859-1?Q?xLyEnop8bjcpS6NYfp9Qntj2UOXMbEsx9ioySnWGUkgg2/STrsDC+PSGmr?=
 =?iso-8859-1?Q?mvqCcUH4j735WQUYeP6qZY9GOqOWyhPMn4Jotlpjorzgm47cwUplpGa8/m?=
 =?iso-8859-1?Q?hsAp13wi0hbE8gZdBqg+SFuLq/rxdS7M58+S41zv19az7scIk4KRsO+YNG?=
 =?iso-8859-1?Q?Nw64TPNR+ZNNA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 909b3276-110d-428b-3dba-08dc6dceb896
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 13:16:20.7221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3c2a020d-f343-4ca1-b6ef-91768380352f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1j0K2Z3wN1GP+lJmWtCiMO93HXf2QWBG+9caiJpFATkh7jiGrW40HPYh7iO/Le231t9qrHyOYdLbczRPsn8AkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR08MB9013
X-Proofpoint-GUID: D-PSwg-bVeGuBKuWX6UQXQFM2NSimXn5
X-Proofpoint-ORIG-GUID: D-PSwg-bVeGuBKuWX6UQXQFM2NSimXn5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_08,2024-05-06_01,2023-05-22_02

Hi,

I'm looking to better understand how the list of networks are collected  af=
ter a scan is done and get-networks is called.
How long does a scan run for? I am assuming the scan causes the radio to go=
 through each channel and listen for broadcast beacons to find available AP=
s. I have noticed when calling scan and then get-networks I can get a diffe=
rent amount of found APs, like either I am not waiting long enough for a sc=
an to complete or there is some other logic that dictates adding a network =
to the list (too low of an RSSI?). I'm also wondering how much of this is r=
eally controlled by IWD verses the radio firmware and are these simply requ=
est sent via nl80211?

Thanks
Michael John
CONFIDENTIALITY NOTICE: This message, including any attachments, contains c=
onfidential information intended for a specific individual and purpose. If =
you are not the intended recipient, you should delete this message and any =
disclosure, copying, or distribution of this message, or the taking of any =
action based on it, by you is strictly prohibited.
