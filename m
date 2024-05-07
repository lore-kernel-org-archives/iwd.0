Received: from mx0b-008cba01.pphosted.com (mx0b-008cba01.pphosted.com [148.163.139.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014F715B137
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.151
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086195; cv=fail; b=kMJnKTiDuBgQPHZ4gyq/vMpKmlvf/L3cY5fHW4tdNhjj2tuvRLbQlMoU1sH/w3dg64lSbIoj/j37L6mq1pFIQjrmMzGbX97yEDj3438qRunFFjt4pj4pWZzVM86mnmrfwyDtQ9KopiLqLaXvMpMZOOHyGuJ9ukYYriNwHSRoxI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086195; c=relaxed/simple;
	bh=GH0Os+JJ/SrDwCMI9dXVaN6eTU/93sgsBvFYJO6WT2A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sH2XbGt1GYojKroM9rW3HhKbPOdSV7GLZKYT484wuKu3GK92YAmaEbixzl69qEUf4Mhe/VTztNNS+5i+Ql51Q8GjwxWuFJXLSchgkPbZmYR49V1ddmbdtDvEP3/zN9fl87a4XCIY52439QYzIJWROL9VBjfV/09PqpPXuYo5Qpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=midmark.com; spf=pass smtp.mailfrom=midmark.com; dkim=pass (2048-bit key) header.d=midmark.com header.i=@midmark.com header.b=W+Phgb1D; arc=fail smtp.client-ip=148.163.139.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=midmark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=midmark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=midmark.com header.i=@midmark.com header.b="W+Phgb1D"
Received: from pps.filterd (m0372076.ppops.net [127.0.0.1])
	by mx0b-008cba01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447AVAi6026423;
	Tue, 7 May 2024 08:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=midmark.com; h=
	from:to:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pps1;
	 bh=GH0Os+JJ/SrDwCMI9dXVaN6eTU/93sgsBvFYJO6WT2A=; b=W+Phgb1DI8YX
	D1wMdSQ8mt/gr0oMTxJUhKI+MRkch3EqMrmL9JKhfh7/Vp43SwltqBpWGv6tSTt4
	Gr4Niuwlnfhf1epa+m/4pl/4PoDmlUgkfTRENlyFm321Z1HGMhULzYYYQuE5v0NK
	zlZ18ifX5pHqOChW2JA3KG4mUdlVl+9p+RQDMCwuCBGd0lfpkxuamMLxl+caNV3u
	56mQ6z4HJwt/T1B7u4Z6dTsEwh6xBE0oGJhmMjRHDAZbGb9Em6d1KM3AJ3rZQWdi
	mzg0rVez2Mxv293lKUWZVq1CuUM7YdENVzlnQ/XzX+UbHM2kJWMx1bYYM2SKz75/
	osc8YqM4Jg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0b-008cba01.pphosted.com (PPS) with ESMTPS id 3xx4as1hxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 08:49:50 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBZNuekajQVhcILMHxwypbHDHXkAR/e77AVosTvFhPWj2tTwGeU/9aMlIFGmuLEDpLEnu5IG9ANpAwfoF/kQ/2YQdccR2CR+BR8n2kc1ILJa3Wd7Aal2cANbjF0z+r1zmSKwf+4PfcAg2qx+wrFtnDmI6OQKIW6n2a+iH6HqRd1iEj1r0wSxbiK+f5gW2Z2C+GoQNOlISHOVVABSxFexl9LBfktkkQjr6jKrcEbp6uuU/j56UYnkPxmruiRLvpt2HXOB9JZk1Y/Lr4s+DtpBc4Hwq9qlSOMPVHXTNncVVNbmzXJOTfSfJpN7k2nD1qBWT5L3H8NBUNXLGonnzvuFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GH0Os+JJ/SrDwCMI9dXVaN6eTU/93sgsBvFYJO6WT2A=;
 b=F/xfXGagRQ2pSqsqaaADturC442XkdioMH1VQNj4AUZ6ZhQjl0ApDxCdJfFGOXJNyIwVvA9fIzm8wC7Fs3ukq//IbkL+xG7kFCqLznLSJBaVglpI33KU6QK49ZLFQCtmje4xFaAW40DxczG0711f+5PCPf7B+3jBbvMRGLcL6F4Hh8TplnWwzT7IvWxpVqFXVia+jOICQ+2ZeDIofSIX0sPyTFbqDhcPj5XC4cmdUDyWvexJfTcVC5natqxfFKOkAm1PYJIPo3ftKU0xn/nfjivHjKTBTMtBV9aVXLIjo4ivb0ha6rsg08MNIQjGK5vxgTA78Nx7eD/oUZszbS1u9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=midmark.com; dmarc=pass action=none header.from=midmark.com;
 dkim=pass header.d=midmark.com; arc=none
Received: from LV8PR08MB9350.namprd08.prod.outlook.com (2603:10b6:408:1f9::14)
 by SA1PR08MB7646.namprd08.prod.outlook.com (2603:10b6:806:1f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Tue, 7 May
 2024 12:49:47 +0000
Received: from LV8PR08MB9350.namprd08.prod.outlook.com
 ([fe80::7973:5566:a047:872b]) by LV8PR08MB9350.namprd08.prod.outlook.com
 ([fe80::7973:5566:a047:872b%5]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 12:49:47 +0000
From: Michael John <MJohn@midmark.com>
To: James Prestwood <prestwoj@gmail.com>,
        "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>
Subject: Re: Getting list of found networks
Thread-Topic: Getting list of found networks
Thread-Index: AQHan7ePre4eCmlnGkWJ2z4c7hs7H7GKO2IAgAF8w5k=
Date: Tue, 7 May 2024 12:49:47 +0000
Message-ID: 
 <LV8PR08MB9350989BEB22ACB3B9C67DF6AEE42@LV8PR08MB9350.namprd08.prod.outlook.com>
References: 
 <LV8PR08MB9350F79243154C9930EFC4BEAE1C2@LV8PR08MB9350.namprd08.prod.outlook.com>
 <e49f9a7f-5d4c-453e-9dc8-1a7667383912@gmail.com>
In-Reply-To: <e49f9a7f-5d4c-453e-9dc8-1a7667383912@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR08MB9350:EE_|SA1PR08MB7646:EE_
x-ms-office365-filtering-correlation-id: 0c8a6c45-3b65-4b9a-0f3a-08dc6e942d79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?fStHFJaG5nBqLuQqu0/qVw/CIyaIYlITx8XwRqIeaz1lj1Gb/6m3I4nfcQ?=
 =?iso-8859-1?Q?6GhgIAyQNyOpIa60BIsl464EgM508ygcEZ053tSmoH1DNegNxvQhiUE0Jw?=
 =?iso-8859-1?Q?8XVlvC0GuLJcj+Fr/EG+X4R1shJx4glylJcyR3CsIKtuqJxophDsnlv+u0?=
 =?iso-8859-1?Q?kPSLJMIzTzoa77Wkq4y88OVfR3nJtxD//0Dhmkld4JwNaTayO7vAneDyD7?=
 =?iso-8859-1?Q?MsalAVpvmJIwXp5y34q30I72qN4TYrkJfQcFzxDZzg5hed3aL6ikXtoiYL?=
 =?iso-8859-1?Q?cJMwRwS9AyQji+nroTms/t6gfnC7SUxybnkmqiyEYUuqXcw51jTdJK1zJp?=
 =?iso-8859-1?Q?w0Cj8qoypl7Sbo0kJKNoc/Orsmhrw0pxMUmiNFp4iKVbufZHGwUFxITd2M?=
 =?iso-8859-1?Q?gq69imZddqOUjOaDWLaIig/VZIEK/XtnuAU/YT9I6a6O1uMBKB02N34v8r?=
 =?iso-8859-1?Q?RJTLcXzByCdArj6k+5InklMqlrOPu3traT59g8Jnn1LB4DUqetH2hPV53i?=
 =?iso-8859-1?Q?lnQcd06yPNc7qyyYSXvPeoSdOm6fw4hF9nHtb4o0HAsk4j1zznDHoOv2Bh?=
 =?iso-8859-1?Q?jpUVkiXb955Z26jwjn2n9cLvkCagm5jbr/zs59mBqkMxQAaGAuMlvqcMwI?=
 =?iso-8859-1?Q?+35FrrKgKteAZNVoV6Lt9V8RhWWXLn3Ocu3lKHjGkwZWrcUWJGXeIDv0sp?=
 =?iso-8859-1?Q?ak5Ry9UPaPdRbRF6dTNpbeWixa36HeAvSQmmnAuU0JCDyMSJxvp7QH7eNy?=
 =?iso-8859-1?Q?Wra3UwA+tduQLw3CAr3QHo41MBTfvgokYf9s/aeKXfSD3b7iDEF1GKmWAA?=
 =?iso-8859-1?Q?WwbKAF5lBmI37vho7exzOUb6mo5h3N+kVz1qLGequwYrmG9lgxEnEelbTw?=
 =?iso-8859-1?Q?MmLoUdcDaw2yDewTJxqhIblF2JEBP+OivHhre7VncqGwAIR7qM/pbSRtHO?=
 =?iso-8859-1?Q?zHbspVHlnIYyBgFK/vtSWVTVJMoOtgX1QstgJL/n/AL3BPpBf/MYVsNKFO?=
 =?iso-8859-1?Q?VWMtxN2CQSn2BV7hpOr5mVCtMGPk+YgkmZnSOTqgred9c6OV9Ufa2wgkq7?=
 =?iso-8859-1?Q?vcqaTlwKXUHuWChLKDSFSeUUjTgCqVmT2mYkDVahNd1OLNOtz9KJ9SPV6L?=
 =?iso-8859-1?Q?nwLhlWuCUzFjsq31mJzNTQHnRallGE1D8vRghkfqLm5EVSJ52I7X3A1+CV?=
 =?iso-8859-1?Q?bpmaczsu3J7vDvdg84u9oetDvmuj2sc0lSfq730MwOd7fz0TWcgEdSFRbn?=
 =?iso-8859-1?Q?Sh6wLBHRuETO0VVp19TZPv9RxFDfuJeAGkJx1TjM1DHMVs0tvEE/0bJHPq?=
 =?iso-8859-1?Q?qj7DZXmlsEqz/ESv3oK1aj9FeY7mAeHx+gTEXIaBDlgG/qXS2f7US/MeVb?=
 =?iso-8859-1?Q?2nYV3+sKgrV9fOsSH2Kz8me/vhwHp1fw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR08MB9350.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?YJP5l5bAYbDaJ9YV0RKuJOUoATkD53ohpUIjT522nq9edOa1uC/zzHpLjC?=
 =?iso-8859-1?Q?so7cCQvJajEMwArx0yA0bzvmL2gujWrXfZ03wJeGg52H7LJDs8n3tUGFhR?=
 =?iso-8859-1?Q?nB7I98u7c8EZ8q61movXs+z8rRJSYis0vjQGEmSR0Qh7CfqVDrUi2r82ix?=
 =?iso-8859-1?Q?I4xftG4S8vJ88qtL0J23xPm52zpusOgHJENVxnsFueKTmsB3iLUFEjZq/g?=
 =?iso-8859-1?Q?VxFVo1r0xSBwPOukqhU5oUw8PHPuUbqbEXXaV3YjIIoRflOmHwUvo6VaRb?=
 =?iso-8859-1?Q?BiHmpELwS/m3gI9O2bKlo2FPZmsGekzD/U+yJOhtbr8WQI/kT8399CVe/i?=
 =?iso-8859-1?Q?Y4BQ/X+LP4RqiXFUEgz+M1+3/YqgPL+dDY5N4ZItByOcoIyomFBjupTZ5O?=
 =?iso-8859-1?Q?nIZk3OmR0LJ7o+5ar6serTIiYSM2My4ZKVYnVwVcwiLq5JK2OV5zTmunAJ?=
 =?iso-8859-1?Q?tDIxH0gXYJ1pST7XhZuZR2u1XZPKggU0kyOKzs0SjiR7O2TOr1UR38OoUo?=
 =?iso-8859-1?Q?QLMPAGPIj3058/0zOnymv5QcdbfV1RLbNud1WVQYUPMuko06RiAP+E/NYh?=
 =?iso-8859-1?Q?DUKA9FzMgqnntEg9EhvhjbL9ykczP6M0pXYKwQa2AsaTX1tyjD00ppG3dG?=
 =?iso-8859-1?Q?vaVQfnNVxMtiDffwtkGRDtiOUZR+jXtQ2x5FIqpAIQHuKKU925gqJkzgeQ?=
 =?iso-8859-1?Q?jkdcFmVF7R9bQkmcxCSqZRFgBuX5xlTSR8micIcRZAKs6tWnMtp8zuscJ7?=
 =?iso-8859-1?Q?NnWyYAPH+X28AevGUXOfL9d1DP43TBTi95VcJlwygqcXWNuOaZiYAfM6gP?=
 =?iso-8859-1?Q?a8Wo/exr2AkEJhJA0F49JUkydYyQRj6ADsDVbWMeaZYMAm23bO/PggCH8p?=
 =?iso-8859-1?Q?5KUL/+zXhizcwKxqFoM5GoeVlZuw5dXzba9kG3ImPFOl2rBa25G2wbxADJ?=
 =?iso-8859-1?Q?AQsVgO1hfB3Mgvyc3YGbePbc69iFCY94pYKNR99urhlPOptGMsOzNcqIxN?=
 =?iso-8859-1?Q?yewdV4hXjgdmuJMCNFw0NXh92/KXXQyMhckgqutPVU/A1SjO7hk6R41lGz?=
 =?iso-8859-1?Q?oGpZo+O4QV+UG0zSkahS2WPbCxx++iFomGwwrt3ntDq+eKFq/vuHK4N1or?=
 =?iso-8859-1?Q?yPqKMyBXu/J39CIJOFEfVo4PjdTABFq3t5cJZ0Dnl71jW05hL7D2y1P3dP?=
 =?iso-8859-1?Q?dqOBoSqtoK73hgjPdKOQXCYz8uNvhDH6CSJ3e8x3o+OszBpGlaxWv9Maqt?=
 =?iso-8859-1?Q?CgXIQd5X0ooZLgN+GjkTN7+DRvZNg012VlhX9uKxAJrQYB31LIAVgWrni2?=
 =?iso-8859-1?Q?9XWZFEVxraPF0VLDHLK/HMpf8MOZ7KVqpSih7TbzyUYP6unO5Cs57hgR9+?=
 =?iso-8859-1?Q?7rFBdahjP21C+oUZz7HIDbS+5s0V3TzuW5ZTJFYHUHokIgpgHt39W213aL?=
 =?iso-8859-1?Q?LGQqoWgX4xvobZN5M+41bef51s6S2sYbVpuw9JGTYG9uwYu93z4GOyCTPs?=
 =?iso-8859-1?Q?J1DSAp/g+xaVkQPX/AvO5iXh84U01yNzNhUWLHEVgJNkb6NfPyOHQ2Tgla?=
 =?iso-8859-1?Q?GztVPEOyHU/+5iV8OPEc8v+t7C11UUFxYe6l5Yt1CAIVrA5iR6PwP1hfDr?=
 =?iso-8859-1?Q?ll3iEt0B6B4lw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8a6c45-3b65-4b9a-0f3a-08dc6e942d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 12:49:47.6473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3c2a020d-f343-4ca1-b6ef-91768380352f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thidbjdkBhzMVojyf78E6tHD3q16n1swQlZABOZS/1FpzxSapQtbb63QLrVtiXbj93j039IxbUK2vKiEQlzhRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB7646
X-Proofpoint-ORIG-GUID: 3Q1hyBapb-uqLJKIYW2Dj8lg1J60of_Q
X-Proofpoint-GUID: 3Q1hyBapb-uqLJKIYW2Dj8lg1J60of_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_06,2024-05-06_02,2023-05-22_02

Hi James,


>
>Hi Michael,
>
>> Hi,
>>
>> I'm looking to better understand how the list of networks are collected =
 after a scan is done and get-networks is called.
>> How long does a scan run for? I am assuming the scan causes the radio to=
 go through each channel and listen for broadcast beacons to find available=
 APs. I have noticed when calling scan and then get-networks I can get a di=
fferent amount of found APs, like either I am not waiting long enough for a=
 scan to complete or there is some other logic that dictates adding a netwo=
rk to the list (too low of an RSSI?). I'm also wondering how much of this i=
s really controlled by IWD verses the radio firmware and are these simply r=
equest sent via nl80211?
>
> For a DBus initiated scan IWD is going to scan the entire spectrum,
> 2.4GHz, 5GHz, and 6GHz (obviously depending on hardware support). The
> scan runs for as long as it takes to scan these bands, and that is
> hardware dependent but generally takes 100ms per channel/frequency. IWD
> has some logic to update the networks it finds throughout the scan, so
> if you call get-networks too soon you may not see ALL networks that the
> scan finds by the end (there is a scanning property that gets set
> true/false to know when the FULL scan is done). Its very normal to not
> see the exact same scan results per scan. If some AP has a very low RSSI
> it may or may not show up from scan to scan.

Can you help me understand why a scan may not lead to the same scan results=
 per scan?
My understanding is an access point will send a broadcast beacon at a set i=
nterval and that
interval is usually configurable. I'm assuming sometime a broadcast beacon =
may not be seen
during that channel scan, hence causing the difference per scan. Are there =
other scenarios?
Does IWD cache seen networks, or is this list fully repopulated each scan?

Thanks!
Michael

>
> And yes, all requests are sent via nl80211.
>
> Thanks,
>
> James
>
>
>>
>> Thanks
>> Michael John

CONFIDENTIALITY NOTICE: This message, including any attachments, contains c=
onfidential information intended for a specific individual and purpose. If =
you are not the intended recipient, you should delete this message and any =
disclosure, copying, or distribution of this message, or the taking of any =
action based on it, by you is strictly prohibited.
