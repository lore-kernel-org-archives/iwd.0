Received: from mx0a-008cba01.pphosted.com (mx0a-008cba01.pphosted.com [148.163.135.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48772218AD9
	for <iwd@lists.linux.dev>; Thu,  9 Jan 2025 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430886; cv=fail; b=Eq7nqpeEKUjuIE7P1LAWrsYcosewY6RiWanSaL6wLvVwiph+GhMUfABspQae/KlR/7ZxUuPNt0Qe7TJuUX17lwJrZ4Q7EuA+g3lRiKXqf5Kw0vLHrLdJXjwY6fM5Z3jznZDG7UmoXmuB5THNarOPZtS5b7I+WSNt1uqWbmiqwkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430886; c=relaxed/simple;
	bh=JDGcMRbyuD38m2zSfVsSl9vZfT+IpvQ9kpVNJdFLJbI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LMbMIEqgEIggskx6mDCxArkVBnqUSgBM6lQkMydhT+XB3+lBCER8RTVFIC6qZFl6weNF3sJpzgvf99KEITwfYBR23q/hXJCJ302NcCn4i99MHP1B/3hLkJEhdNiqgoeJPcLbE+Rz1HhCoaSm1RpKUQeRpvV8vjd33pMbzVCqtx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=midmark.com; spf=pass smtp.mailfrom=midmark.com; dkim=pass (2048-bit key) header.d=midmark.com header.i=@midmark.com header.b=LpGfxShE; arc=fail smtp.client-ip=148.163.135.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=midmark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=midmark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=midmark.com header.i=@midmark.com header.b="LpGfxShE"
Received: from pps.filterd (m0372074.ppops.net [127.0.0.1])
	by mx0a-008cba01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509ASIZL018351
	for <iwd@lists.linux.dev>; Thu, 9 Jan 2025 08:37:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=midmark.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=c7nkshctMRs1dPqAyGl854qHJN5
	w4ozCdk54GrLyP9g=; b=LpGfxShEcDs0NuYYhHqlhjITuPqx/ZVsVJtr61T8Ytb
	M+mdXGhBv29sXEqzvJyKyEP8qmyRi5svh2oJn9I30oF3j76pHRhUVPHzeuRZABp6
	E7jkeGwYpoE+qsHqifih5c+YYq/VJeF63vtlGpPY1YdJWz03OV5ypBfXQ+rPLs9Y
	lAOssXVgDk3jNfaOH34TjnVyfAwW/2BpuE8sZaq0Dz4T46UR2I93OACBTPuWAebb
	qBMpWoBwryqfl/p5cZft7UuMTcD+iJsiywaR401HrngtoPQ24xPjolYxoW5yv/Bg
	tzHta02Nzraj+Pfr+Ed0exTQW7wpy82XwAMBqoNTCfg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by mx0a-008cba01.pphosted.com (PPS) with ESMTPS id 43yq0w36u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iwd@lists.linux.dev>; Thu, 09 Jan 2025 08:37:50 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcWha4AllI5+vyDMDEPP0q/vfyG5y3IGWTW8QpcMcUnlTx63J1tzixGOkSXrag66jW67h9+igEyTxoK1IuQN5szB35nkoaHeMmatbXCdaAYfviF2d64Qja5jbHQIym+d20N9a/8IWVBCLFk1SpFLbMU4QNAuLs/wzisQWig/Dto6mV45ge4wBsKPHDcktZNi4iNsDqNVy19U/3NioGaXq/deol6Tn3EyqU5lgrveviaRfN5oD2rqujU8fnJy6bvTiIwYhkD8lBzFtRrNpC3ET7nVtWN5hkRhpSTPgaNEkKHOHdVpDd0k0eONlIdluh/rIA5IaHtTUjI9r/iMSC1rIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7nkshctMRs1dPqAyGl854qHJN5w4ozCdk54GrLyP9g=;
 b=kKxMIvCIdYWrD9zFRtbCnoEO7TOlu1d6RcJiR6sMLThQRqHBTzILdyP4U9EC7jdyFdgDhYpoWms8ebyhVrNneHYr58or4BLN2ezS2brzm+dlR/AKCXzzc2rmql9gSSqZxUpPnv3FQCQPnaxACo/uawUXJ44tk3Tixhpa0YMCPb7dULu0up7fOzCDNOKhLK4XPEe4iMAuin6iBkzcfFaTpTmtA+VJOgJWHVtWfMel3r0rrZy6Mu4mUWuHcXJOONmFhDX4+zRuid5W3ysnGBITNhrRo9Yqsp+Y/EXwV6VM8WTRzEtm6MQH8UQL+/ct1n0m+w/nIG3TqoLlYymY+Cl24A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=midmark.com; dmarc=pass action=none header.from=midmark.com;
 dkim=pass header.d=midmark.com; arc=none
Received: from LV8PR08MB9350.namprd08.prod.outlook.com (2603:10b6:408:1f9::14)
 by SA6PR08MB10305.namprd08.prod.outlook.com (2603:10b6:806:403::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 13:37:47 +0000
Received: from LV8PR08MB9350.namprd08.prod.outlook.com
 ([fe80::7973:5566:a047:872b]) by LV8PR08MB9350.namprd08.prod.outlook.com
 ([fe80::7973:5566:a047:872b%7]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 13:37:47 +0000
From: Michael John <MJohn@midmark.com>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: support for multiple EAP methods in one config?
Thread-Topic: support for multiple EAP methods in one config?
Thread-Index: AQHbYpr0HESdrSz770WlUjABs2nCew==
Date: Thu, 9 Jan 2025 13:37:47 +0000
Message-ID:
 <LV8PR08MB9350114FC7C034E2E52F199BAE132@LV8PR08MB9350.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR08MB9350:EE_|SA6PR08MB10305:EE_
x-ms-office365-filtering-correlation-id: ac6fdc9b-357c-4585-613a-08dd30b2cdec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?tZdCP/0s8jRRUhAnIl7Wd8wo8960LKnzsYkew+KnRXomevjaSa2rEqsBf6?=
 =?iso-8859-1?Q?Rx1aAw6MKEi8YKunDVUhjZb7Q1jFqNvHFAhT05X1PR9+O6Depp2fkvbEzv?=
 =?iso-8859-1?Q?0vbGv7jQE+mNV5sqgZLx/f0cCAH4M1JIpGXkkyPogHB7MTE1XiaCuSh6jx?=
 =?iso-8859-1?Q?lltfp9zLDaCw6wg08gXJmK9P4IuWfEi7YvBSfjL4TASxGFVqzk84veOLpM?=
 =?iso-8859-1?Q?ft70gKwTjh1cdif1D9mwMB3gMFrmwK1aZlp6l4LpvrWa/SZYt+SyhZd+eb?=
 =?iso-8859-1?Q?3rVrFQHPDa3X19fwrM498zNBNTDuTlDTUzxJxURBbghuSm1XkhD3mhnjzn?=
 =?iso-8859-1?Q?EYF99UDVWOUCxxewygNHp8SikmtxD1APKLAg4IxaYC9xxnuFtZ0yL01K2B?=
 =?iso-8859-1?Q?PFfp26WHS97Gppi08eGF4sweCKfF9RJtGitK/gksJQUbipdZXK61VT389m?=
 =?iso-8859-1?Q?v6Hni901R8K5nG+EO6Co3qef4FU5TZneL/uZzWBDlg/ipElr/UU9fbHCtp?=
 =?iso-8859-1?Q?dOYh9vTpVB4QtakvaDTF0TK3jdrq9U+W2qWWLfr8C+LefhlvKpyJD0Yc7S?=
 =?iso-8859-1?Q?6XQOSKK8A9WIBEjy2LVWgRfGBxmuagLY5fG2A4WuLobtTpsI7kzbdMBN2y?=
 =?iso-8859-1?Q?zDvVzg4+BzWf/EKEjRvnBejJZjN8WYvsLgbwG5ivKaYmk6yvWje7DWPJZs?=
 =?iso-8859-1?Q?gQ8si8s/cqxoYVFibXxLOY2laHckGb9U2VNh0Zk74UOOMHbKuTq1QUhj+j?=
 =?iso-8859-1?Q?z5+fDfssAQM8SfGZVQGfn5OIL1QQjjTgXs7wZevTIUl6PtqkJMMeNTx5Ql?=
 =?iso-8859-1?Q?baiwVo9wq4c43sifLXvlMAHLP2neN0Nbqb1szC2C9/CatW+/DKnRH7u2u9?=
 =?iso-8859-1?Q?5L0N+9wO3D6k5J2L6LUdxyVEevX1cplNBZgS5edxaDCAu7Ab52ulof/mgS?=
 =?iso-8859-1?Q?VemF9YZD0KHmb4q9g/vr4jfwnTlx9KdDFUPsCioWPVpTGYeDAvB6/78hj5?=
 =?iso-8859-1?Q?gPAbD+8vPqIi/YTurFvTbjLgwFSc2XPRi25srkcQiQH+byoyfWXT9wRT6y?=
 =?iso-8859-1?Q?BhjX1aWHdSa9P/Bg2YNJePSA+XVVx08t/4LC3AuPljVPmFqUa/8SdES5Mr?=
 =?iso-8859-1?Q?vz+nL6tD2dS6olPagwF875/OCiCg7Q2zzlOmbE8d/myUqRctYp1uizKphu?=
 =?iso-8859-1?Q?555v/2Y+aqYfFP2WMs/5FBKms8C/IHf2UgBhb9+TqNMni3HrQ0b2x9J0zt?=
 =?iso-8859-1?Q?7hqUN7LEPx8uINa8nzbMLzrRjFTslIvM9u8zWbM1hiDNrrQuqV7p/8TdaQ?=
 =?iso-8859-1?Q?niHr+Oj9+2TpthbJIEW6cQctKF5Z0RvC6JM7Q2G0CV5EWYqmH7f5MJd0rP?=
 =?iso-8859-1?Q?dAvLHiqJB8/qoyqgwLbvcS3YPFb6/nw/GkbLu8aUCMHdN61Corw/61+uXc?=
 =?iso-8859-1?Q?aGuMz0lmXvo6YA9CXHVStkBk/VpjlVptmA908gI9x4w1jsUkN2LOSDQv+D?=
 =?iso-8859-1?Q?kxFN3x6HqzJLWcB7h1d3+m?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR08MB9350.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KIjJ30rWHcfkjbgyDFJXtiayBv+LR0je303DAmHf4Z1YAeQth6EPAEu4K0?=
 =?iso-8859-1?Q?IvOFn4dKaAdDtOscDlAfmBuI/+rg/8OH+sPdvtxPVGHfZHDUTYo8kYwx7M?=
 =?iso-8859-1?Q?LchnrpUaAsJEi7CcKXNs9j0XAnO2q8ICzCW7oFfUggZMf67zHpj7Z0Vuby?=
 =?iso-8859-1?Q?+b/oT4qSIym3X5xyg7VohH/xM/kxxVH+pYyLYQrfl7nQtHQhKAxzjktyiI?=
 =?iso-8859-1?Q?9D2EeDXt1JzUcsuIgMCac2K0NWTRYBJfL8eQOVWyFcy4QJrf3B8+zoBWfu?=
 =?iso-8859-1?Q?zUOf6g0XbDylx4E/y+YMGr0JDeaWV5NhM57u5XeBAAb2pZBB3fIl21oGnz?=
 =?iso-8859-1?Q?tIXQ9uF98hvl7UEi7xhegQNm2xA1Kt53Xc81alk2DZjQXgvNA+BXULMEIb?=
 =?iso-8859-1?Q?xzf3/Ct/C5vab3QMQ8mscQlHBgnWqnp6X1V8cfTxez2e21cVQH/Map8FCw?=
 =?iso-8859-1?Q?nmYAqAFtwnC93r2UkGa7OIXw20/XVYl+04nvLAtg2IhUkh7lkYKhlThP0S?=
 =?iso-8859-1?Q?kX6Mr6zuNXQhet5xTdFZznrBKFPQ0eQ21soOJdwWLAYuWMX/drv9nxbeL5?=
 =?iso-8859-1?Q?7/zzd1/vC8Fu4ROFouzdMAhcIIm+JJfMxVJ0WQ3/53FQvGQS9R5JwZQ/8+?=
 =?iso-8859-1?Q?wWyqlrp5YS01zbdQoxObzbdEvKepTijWmebbsaiLuRY0iXO55LmUNXhhBD?=
 =?iso-8859-1?Q?mJwLCl/6EVAbRsgQ5IgQqSH+6/apOzM24iKnPQUa/60Zltl/d32rWnvwlX?=
 =?iso-8859-1?Q?t2a9CNy+GrzbE8JStTHcVomYH8bceGkr2o11qAeoM11fF9Wv9MkaE30YBq?=
 =?iso-8859-1?Q?C8TdKoj+bmP/9bZ4/49JsC5D3nFS6R4FfGQXugCiYV2d6BVxeZCbo4DfzL?=
 =?iso-8859-1?Q?AM0Wy3VuqxlGXJdouPHvkfaDZzUITtbPMDt8Emw8JxrhOoZAXaFj7iXkG2?=
 =?iso-8859-1?Q?aJd/RGyjIaCicG4W5xVfDCJT8/m8tXGHta4ydSG/IswIy3EFSg0+AYreQO?=
 =?iso-8859-1?Q?CK4p26x4v5ZWGgHDRp1P2Ov/b630WYmTM9TC5AcQnwwb5j0E8DzfSsH2Jf?=
 =?iso-8859-1?Q?y/nZ+aGwhZ1BvabVJruPkJ+MBSF1908lwO0aVetiDSdznZqeZZwgHyES4b?=
 =?iso-8859-1?Q?KSmLyNQPEswP6JR8QrXQfEsL79FKXY1wzpBi2TDy1WRFHEX3OiZZryQf5H?=
 =?iso-8859-1?Q?lld9TKENYCE+5S1iMl1nR8KQs9jP8a0IWa9fpTlqYZSMy7lqoU8HYrfe1e?=
 =?iso-8859-1?Q?Sjfa/Gcxahrfgx6p36LMrw+RzH8HPI+93SJvfRwYYDN3wcJfve9xTQBVTs?=
 =?iso-8859-1?Q?GPVm33aCvtNB0FTFivg0tHmAU8ziMPH1BIxqGtGwfORfyNiwMcagWrM4Nm?=
 =?iso-8859-1?Q?/SD8pKwfELlCs0icQ3/iCYG/S1ITf9HHxNv33W52G+KA9iualG8FL26x1g?=
 =?iso-8859-1?Q?xV9b8C6QjZDvC1pbDJAKrTlbwVoDSl+eKoJ/Phvl7qRpN1liF0qtbGgEn/?=
 =?iso-8859-1?Q?87WblVLEefMi7f1sawG2iXP3x0kE4sZWV6CjFrRHe7mOthr88TvogMRdjA?=
 =?iso-8859-1?Q?VmJxtgdMVianivWES8RuZiHFD+TrXIn0WlgteknTddfdERvBgDDF64YF/c?=
 =?iso-8859-1?Q?YAnwOKRcndP/0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6fdc9b-357c-4585-613a-08dd30b2cdec
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 13:37:47.3443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3c2a020d-f343-4ca1-b6ef-91768380352f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HSRts0/qgccfZ1JPrD/MP8JFpHxtV7ZXqVvoZl+Dw4KUN3H2gRI1UVBGCkFs1Yvabzrh/ASfyepf4CafIOH/vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR08MB10305
X-Proofpoint-GUID: e50PPvOVKlYQOB_KOOOmIG1kn0zJzWyI
X-Proofpoint-ORIG-GUID: e50PPvOVKlYQOB_KOOOmIG1kn0zJzWyI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hello,

I'm looking to see if IWD supports the ability to support multiple EAP meth=
od, like what can be done in wpa_supplicant.

network=3D{
    ssid=3D"example"
    key_mgmt=3DWPA-EAP
    eap=3DTTLS PEAP
    identity=3D"username"
    password=3D"password"
    # Try basically every common inner method
    phase2=3D"autheap=3DMSCHAPV2 autheap=3DMD5 autheap=3DGTC autheap=3DOTP =
autheap=3DTLS auth=3DMSCHAPV2 auth=3DMSCHAP auth=3DPAP auth=3DCHAP auth=3DG=
TC"
}

My use case is that I'm given a username and password for a network but don=
't know the outer or inner protocols (or even if its personal or enterprise=
 but I can determine that from the broadcast beacon).

Thanks,

Michael John
Midmark Corporation

CONFIDENTIALITY NOTICE: This message, including any attachments, contains c=
onfidential information intended for a specific individual and purpose. If =
you are not the intended recipient, you should delete this message and any =
disclosure, copying, or distribution of this message, or the taking of any =
action based on it, by you is strictly prohibited.
