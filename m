Received: from mx0a-008cba01.pphosted.com (mx0a-008cba01.pphosted.com [148.163.135.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B801E32C5
	for <iwd@lists.linux.dev>; Fri, 13 Dec 2024 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101990; cv=fail; b=oLwyOJjQo17GxdxGiom7/QVlXZj2/KEHBjVbbBceluXGcu9ANKqVQfN80Vhms6yxFlk2dQHQ7jCjaAMEqvUvbvQtfBd1IaIru8LeDMyWfqeKaRzqXlo0wxq6b7xS0zhzPJupWciPkQJatp4wnejYVlnFGYZjpszYYsNPCxY203E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101990; c=relaxed/simple;
	bh=yC4ZJHmGk7f478xFzgdp2GMX3NmL5Sz7Y5nyyjVlizg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=o0xENe82XlOBCOaNDZKfxIo86YVzc5WQds5RNQbae6mzLztGpsiTAoDAszCfJC6k68S7YuJnS0tseHJPebVIy17n0WE/GpsmmrFOEyQx32uysHjAxWpwrEUlxQhAv2atLooVOcP/VOy+5ZvH7ajMBSFZEs/tvFW+HwzzqWuapHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=midmark.com; spf=pass smtp.mailfrom=midmark.com; dkim=pass (2048-bit key) header.d=midmark.com header.i=@midmark.com header.b=Ljo7V6Eo; arc=fail smtp.client-ip=148.163.135.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=midmark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=midmark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=midmark.com header.i=@midmark.com header.b="Ljo7V6Eo"
Received: from pps.filterd (m0372073.ppops.net [127.0.0.1])
	by mx0a-008cba01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDB06TA022219
	for <iwd@lists.linux.dev>; Fri, 13 Dec 2024 09:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=midmark.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=yC4ZJHmGk7f478xFzgdp2GMX3Nm
	L5Sz7Y5nyyjVlizg=; b=Ljo7V6EofH6CqWHUYlpHTsw/kft0p7ZZJi8JwfQSTKc
	7cMo/fBrGRNQiAnHckLjNU0a7TetJiimHSmo6OyVMad5A2BAFS0TONXjfaTROkfG
	wBN1+HY/QgB8Wfu3dJK+RpmmQ055NUcODMQ0s0DvBPUFPapXrMyIrJffa+L/k9hi
	f50aAGUQfTz0TgDGRfUBCgSCdUWIQejd/QKYsW9nVwjMJDmksZnm3xkWCgVnZnJX
	mY1wZQhAmQEsCiajf3tCK8xCnGIZDyiJmUUB7Z9lsTuh1tWAneHVAKvERTfoOPZB
	bUCDvpJuftMSmw7Z7+8pYWXN5rkUn0nkS+Hhz252Ibw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by mx0a-008cba01.pphosted.com (PPS) with ESMTPS id 43d5f5mepg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iwd@lists.linux.dev>; Fri, 13 Dec 2024 09:56:08 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhZ/mPh1A+zr7ahVuWIxLtncJmCKOXxKGlqQ4Ql9wlW5F8RwJJkaIj8M/tsaNMemCX6dJoqMuXcS96BOLr837VODvdDAzXkq2nupBvc6CKKfhpS80hQ9xP8KyllaCDhfjlKtiCVF5aqnLMdc7uxyfeiDfxflvJ+ectquRBmHBfbfQ3cgPi9eDIfK7WFoWdEyzprR86M3jFNxq+0CVu069UlN3QIYW1jd+HZZBh6Axy5zOkMh07tJln3bdWgJLEyARuLkT7KxUpt4eqr1CbLQdqcVIGbDQx5wp3dVBfOoJZPSKDzUu8Mr+69nM6IjYERu/p9nPK182EKgjnyW6UmCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yC4ZJHmGk7f478xFzgdp2GMX3NmL5Sz7Y5nyyjVlizg=;
 b=FJPJEJGGE0Awrg4f7CYLjL5ic9fGPLtbsVWK6blEAfERuS1uey+CpkznciEdfegXbpSgaWuLvGBFqXmM//PSeaVlzaz/LdBKvHbVLgWZGr7tsuGZxw7+YTgC6brDJnkFvwqknkUu3mygFBHglUVzqEkUBAGIyUzJnKr+kWAsjd2H01gs8FjEoc8fpa0OTIz7udp6g6e4oi/UPnH+P4/LudKQwpdn9l1iSR8nxGSvkWjQXaFQKGrjUHNRKUQEQfnmGyUV1jIBaVVs5vMbfzqJP8DhZN0OqTIre5fm4u7Q0xDAvlVuoG8LmdeUXa1y5/TEPbub2i+0SV5oVI0qlp4S3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=midmark.com; dmarc=pass action=none header.from=midmark.com;
 dkim=pass header.d=midmark.com; arc=none
Received: from LV8PR08MB9350.namprd08.prod.outlook.com (2603:10b6:408:1f9::14)
 by DM8PR08MB7334.namprd08.prod.outlook.com (2603:10b6:8:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 14:56:03 +0000
Received: from LV8PR08MB9350.namprd08.prod.outlook.com
 ([fe80::7973:5566:a047:872b]) by LV8PR08MB9350.namprd08.prod.outlook.com
 ([fe80::7973:5566:a047:872b%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 14:56:03 +0000
From: Michael John <MJohn@midmark.com>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Question on documentation for Enterprise network configuration
Thread-Topic: Question on documentation for Enterprise network configuration
Thread-Index: AQHbTW7Ev/4y+ObjA0GeZ6USJp7VKg==
Date: Fri, 13 Dec 2024 14:56:03 +0000
Message-ID:
 <LV8PR08MB9350F57066DF7E632045D03DAE382@LV8PR08MB9350.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR08MB9350:EE_|DM8PR08MB7334:EE_
x-ms-office365-filtering-correlation-id: 5507f49c-2489-45c1-6608-08dd1b8643f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?KNgi/N5YVUxA0u6/gIGFvPFnS/DzKyaY51vDb4lzvZ+bACQw8fjBxZ78p8?=
 =?iso-8859-1?Q?ikWe5Ml2Myc8rH+1RW3HmL8Dq8R8F9JqGwXunSIn7aSsjFXty4qImb/IOz?=
 =?iso-8859-1?Q?BzuNGokBrnZgtzpzS8l+55w7X4rQU9uJEPYbt0p20FhJTDWpANarUmZA17?=
 =?iso-8859-1?Q?r6KlfE8qXBu9STsV4AGg5kIQAsfk/cEYVMLYvPx3ufcsO7jERyG+i8E5QH?=
 =?iso-8859-1?Q?BUQ3VeeAe97eHWTOp55oLlKTLZQ/55zH4P+Lj2N2uFoWhKdGvLcpX0+1oj?=
 =?iso-8859-1?Q?6tiuTTWGkzZuPZMueePfuoHSZBv/U2ZPoWdipVrSG7W879/jJBixDX6iJk?=
 =?iso-8859-1?Q?jKVLJR62u6XmbLoIsjySlxIUy6hzBl4u+BAbrKm7j3/QB6QqWv33Gsdz4e?=
 =?iso-8859-1?Q?MGq7e6HaA4uhAyoCpibrLSv5qaYGnL+PbI9cNBHCqKaKbZ7G3zX+Cl3EFb?=
 =?iso-8859-1?Q?6zq9FiqY1vEl1JyWXwHOOFFqdt0R4dObsbJ30ipEOtpmThRz0TVnZgFrhJ?=
 =?iso-8859-1?Q?7GWPC3b4djB2NvSBuhnFd+yZzvWF+oRNdObk7igzax0dwMTzPKHPs+ZLvu?=
 =?iso-8859-1?Q?ZxcS3PgGCdq1PiiLSOYAEMXByafrw3pujp0833N62I3DjeouYI0SuiuHxQ?=
 =?iso-8859-1?Q?Cm6f93unG1UL2z3S8/Vv4R2h424AswCeUm4aV3ARhAuhcuUP+XEX2DHV2m?=
 =?iso-8859-1?Q?qHTotv1GxsfH9+tJULSYsBD5CtUdMl4yq5Km6dyFI/0rAKzGc0Tsim8koz?=
 =?iso-8859-1?Q?G6UUVhKRoNbOhdkx9hLDclvRZIby8BRi7wQbRXEGvtvysvZ8IEwlCMFrPR?=
 =?iso-8859-1?Q?mDKFmvZwGO+NJqH3cqxmkI5S8I1N5ZpMP2CRt9K2jIkFLQuRvyg7Opy9c9?=
 =?iso-8859-1?Q?BVoktbK7MYM99ohE58JrifMZQcrtmxWDBUDJ9+Hkz0/VIQGeFWfh6fxJpf?=
 =?iso-8859-1?Q?LQarMF7eUUZ6bBFh9iYzrofSSPqkh35JSUrWyIaR/0Bc5tpoWxxcVFwZF7?=
 =?iso-8859-1?Q?139vn4rZv6g0mnlWr+D+r73D/m6fjdrMiDPvKo5PK0mwxflZK0gF3V5n7H?=
 =?iso-8859-1?Q?Cm4WXOjySETFuqhm3r/PE1srDvgJ/u9WKvB8VLTpYnq4OX30SoXa9OSEeY?=
 =?iso-8859-1?Q?UYG95yAtvXNqBDyQyqCt8FukM8OL4IDZ8NjAL0KygUIZvV/V538tRCaJGH?=
 =?iso-8859-1?Q?rxTbmzXjVffM0BMoQ3m7KWl7MlRz1EeBHE75jMaQr7BxUURiqOyjBxjRZz?=
 =?iso-8859-1?Q?AUa8pxs8iC/6BM43bA+hF6ad0EmvyfAd6YnWCgl4aW67OKj8gt7Qr4y2Ao?=
 =?iso-8859-1?Q?uc6L3+FUvdYT//Wd/2sECp0TJwWg25KrhNu8lmQ6CqK3QuvecCsNwqaEh5?=
 =?iso-8859-1?Q?4JIcWyA2S63IByalN5J1mE382kN5AbBDE3lqli/dCdoANUv34wmmAdeveZ?=
 =?iso-8859-1?Q?m0QSeS64lg8sWKQ3V3kloGnd/uj9/JLsqFhIvQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR08MB9350.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?q1oEqoyL3GbmDVVjaluwr+cnTiE5UlWWwfaCjo+0x/LZbhntdoV60Dk//r?=
 =?iso-8859-1?Q?FMj93oWyLkWPqM0GCFeOzoSturp4Xc+pN/CFcpZWmqEpgwvGywAp+kr6UJ?=
 =?iso-8859-1?Q?HBT7bWpRYTMXcdV/6nlvCrAQf+dVphynkst0YbsFsny9d/HITIw7PlczBF?=
 =?iso-8859-1?Q?MOsTP3n4jnyW/enJm56YTe34aTlhyTottykS+RWFx5SUyOdNX4qYPE8Cbi?=
 =?iso-8859-1?Q?FySj11ZO50Cv6pgJOD6BynRogef3tNqIJGcPglbi2pc7nynhmLbrlwPe9U?=
 =?iso-8859-1?Q?bIQ0wmEiCr16Q2cGiIG8XKY3c01NaPBgbobUo9LdbRBjB8hT4u9omsZ/3X?=
 =?iso-8859-1?Q?yNJH7HX7O3GxsxaOtY3KP52AIeb5dQJExn0AjoKKuNuw7Xh2bKHPKBNPUj?=
 =?iso-8859-1?Q?zPo2XPHET8j8MGv9grg9H/0oKza4a3xS2iDqSF+RxIzOZb3UMJBMyM7dYr?=
 =?iso-8859-1?Q?ElltPRGXhD9KSSTwjAl+DqiaQCzXJboyYBEMH7X+nHsiYiBFkcB9i1nRMp?=
 =?iso-8859-1?Q?r1Z3sxljK74NhZ4SnBRngauOf5Lr3yN7yT6p7SFB7jIRNlWWM1R5yue/vD?=
 =?iso-8859-1?Q?HCVha2CcZ15wxVHSZx6NhHNrkZVB6Jk0V57EL5yguNA8DOp86zrBwMVvpb?=
 =?iso-8859-1?Q?qItujoYaP7A4Q1yVDksiPBo2vzGFQ1mTzaFfOPNG7IXi1jn9zdlRC5aZ8h?=
 =?iso-8859-1?Q?/BSTMnI05X+PEUdZ/Hib4xYmql5HjiWq9zf2vVaV3ypBpBR/DeYvd234EC?=
 =?iso-8859-1?Q?YchZfK2X9tgrv9SIhNyynu5lHsDmrJy9RJH6CR0g60Z/T+EZ850hyiInnr?=
 =?iso-8859-1?Q?wprm1Oi9PeU13pQKZQIAuLx4XnFNOk89Ns57dxe5quYa1KQeLdSUUUsk1p?=
 =?iso-8859-1?Q?mCy+7RYfjmjRpVdE/ISI7gC5xatw2hNzJzjgd+LG6EqSDJiM128sO/BYHi?=
 =?iso-8859-1?Q?o9Xfr+ofi0SWjN5GlFpW8x7m/8Wc3U3qHxS10Mhjm+909ODWMO7SJocEq5?=
 =?iso-8859-1?Q?es6IrM5vt3lwu/bIbJZhR1Rtth8HxBdVEsEhAn21MK/1dyLGREWgq5Yyd/?=
 =?iso-8859-1?Q?QXaClPwh1wdTcyxZLVluLw4uZfUQE4V+ajgJw2R2xRzHWL7U5jCB411t5n?=
 =?iso-8859-1?Q?hMudxYCn3JIKmw/9JGFHmTrKIBHz0bLRm3Q3clQcbHKyw8dbrsLvCEon+L?=
 =?iso-8859-1?Q?TQ1zTU/VWwAvKkO7KvCH4Ejfvn8Zh8jRG+ajuExOnhjPM8QVJECYzwnHxC?=
 =?iso-8859-1?Q?bOHE+cbxNkQCsSdY2XuDKl4X6Fly4dF4P5v1lWDsviUDco0EamGciD/jaU?=
 =?iso-8859-1?Q?AttqXt+dhi5JyatsBaX5ijsHX3166XcHVAv1dKtCsp1SgdwYWTeez5dQl5?=
 =?iso-8859-1?Q?4febUuKEppCSn9FOVE05ec1rRbGaoeomdDVmcOwOwFEAdWGnNGXXtHLNfF?=
 =?iso-8859-1?Q?GFGQWFBb2AGK3tyHfuPYOdL2GogkZdbMeXL6zO7nC6G8dRG01RVozgj1BE?=
 =?iso-8859-1?Q?WFFFgT1CuxcpPQdvJxV38vUsISKfSnktT/dVLCcHFSgxZFELvwllO/piVo?=
 =?iso-8859-1?Q?GiY5QYSED65h5rxoU94T8jH1MAVfAI7tI+wNk5QeyZO9pCBoGRw8xiYgt4?=
 =?iso-8859-1?Q?CuQGzougQ6eJI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5507f49c-2489-45c1-6608-08dd1b8643f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 14:56:03.5622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3c2a020d-f343-4ca1-b6ef-91768380352f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ruPvpdbBpH8wEIZWP1Afb9lwo6ei/GypKNPOjCCFCuOCgoo2TKG5hJ3qH2uC7iwag0q0jKf72gpRg6mQ9h/Kig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR08MB7334
X-Proofpoint-GUID: 64Ta_zb4DG5I8e-dps173O6QpmW85icT
X-Proofpoint-ORIG-GUID: 64Ta_zb4DG5I8e-dps173O6QpmW85icT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hello,

I'm looking for configuration information for WPA-Enterprise networks and I=
 found this
page on the wiki but notice the banner at the top says this is out of date.

https://archive.kernel.org/oldwiki/iwd.wiki.kernel.org/networkconfiguration=
settings.html

Where could I find current documentation?

Thanks,

Michael John
Midmark Corporation

CONFIDENTIALITY NOTICE: This message, including any attachments, contains c=
onfidential information intended for a specific individual and purpose. If =
you are not the intended recipient, you should delete this message and any =
disclosure, copying, or distribution of this message, or the taking of any =
action based on it, by you is strictly prohibited.
