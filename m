Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2078.outbound.protection.outlook.com [40.92.23.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0080391
	for <iwd@lists.linux.dev>; Fri, 12 Jul 2024 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720744442; cv=fail; b=NgZdd7cxennIfXzr0b3iYcVpldvs1XM0Bipigl2SOV32xtiIxtjNtGA8zOryV7070tSg6VhMHvQ54GdkS130DVxKtXZp5XHZI6vEUK2fYPqi2FwD2buYA2iCIwsNp8JtCUJg7T636ZqXY8IWYgTuEBKpTycPIZYX3A4HSp9vxLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720744442; c=relaxed/simple;
	bh=A8Zdp/YAD8heCYcdQEQE33xaTOfmPIoXSMFZLb2Klho=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ij/JxO85jiKWwLTshM3+z7m5/gVOkzwhht4IR71QkMZTBn97UHFggVoO3wng0vik760mL84GiMaIFfLE/lNWtyWfxA5uvavPlA/WltTFszbFXJdr6Ns3/dMV2XMJcrAledLT4prR0GvkH5dKio7Hahop+FLaq8qkrcDVGkJLvxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OKJfGg2V; arc=fail smtp.client-ip=40.92.23.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OKJfGg2V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3CeSz3BqkzXjChR1YQLWdyoEIY+zR96aijEVd8v9GpL+a0Hr+pmJKBV8EKsTyAcqJPyNlB3zp+Ncmda/TYWL3NAXQJXxae8JVo4SlF1o4zmJilvg0jhR07Oyl6cJBVLNnrd9YgjJiZcdoCDyBQ3lITGzZVib1Wfwuc5QB3oeIEmrBoVcLRckQICTxOAyr5ep2jPOKbmT2MHysRdiksvfDqpmr0VgYSqkOWKfUqFvhwtujkuTL9FHHxQGddrv3WqHmoLI/cA6xLfmr0WIuLF8RcF/JOcOmXpSn670SqvVTUSqIeP6jTSZX19fmESDWG3L+eAXP/k5QsF8Ct8RtMxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72U2g+uSj266MglLWfqTsyDMibhCYoW8Ecdfabq61X0=;
 b=G3vyIS4klyAbf5DQDlhsfFXFcWSLpnBlQK+N3EQ2ACjhr3At06/MAfot2wjdbTLcvfLeUHh0M3v3ntVEIsMfWQWoXxDAQHnBQVNmX+3AA/kWyfP+BNnanuDu3mYjLyzOwwUiO29agv0VM9hoDMr21MzGb0DayQD/QJsgu24pgJ93NZjqo3EiwnXlbyBGU6bsNcFUFwKqrYmqlW25cCAf39KZYwZTSBE44ImiIZAc3eyfDQXIjry+mSKa+ov+2Q0faHNvfE1GC4rlFd+NIcWnPNcBGagnM88hf7nh3ZnuFYtDoExyqf9uh2kLU95v+XDQPbfBWYzzRJ/SG3hGpXaw0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72U2g+uSj266MglLWfqTsyDMibhCYoW8Ecdfabq61X0=;
 b=OKJfGg2Vl64CZN7co15tUgjR7FeEWn+k3aATZVIQuQZQ46RNHlMOOdUnswdipEQDF4NnVPq5vW15etrCrDpBID/H8Ov3bLCNoVjVkho4JNz3QNO7gS3iE4iqZKqGnd0ugoaML7bHHpnnTWwf94sbnzcic9J7BjSylmvoKJ2qwbWG1xS9BaMtqb7ShrhVujX1xpweukdGGU0FgKQ8Z3rObEd91TeWLMGJfaklnhvznOaF2wILjPVS+HH5HE749P4QucPfJgEVRKpkmfVZKe8Dvg3PiM3cYjRGTPqHtOCLlsBl93kdPNHmfnRBcLytT8OXtNpFziD5/qxyJ/1nh8tuNQ==
Received: from DM4PR14MB4880.namprd14.prod.outlook.com (2603:10b6:5:390::9) by
 IA1PR14MB6917.namprd14.prod.outlook.com (2603:10b6:208:3ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Fri, 12 Jul
 2024 00:33:58 +0000
Received: from DM4PR14MB4880.namprd14.prod.outlook.com
 ([fe80::cab3:9377:6fa4:3de0]) by DM4PR14MB4880.namprd14.prod.outlook.com
 ([fe80::cab3:9377:6fa4:3de0%5]) with mapi id 15.20.7784.005; Fri, 12 Jul 2024
 00:33:58 +0000
From: "dangling ." <kasperkantz@outlook.com>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: [PATCH] main: remove static from const strlen
Thread-Topic: [PATCH] main: remove static from const strlen
Thread-Index: AQHa0/LOAotEJe4W4UatZ0thwpb6yQ==
Date: Fri, 12 Jul 2024 00:33:58 +0000
Message-ID:
 <DM4PR14MB4880D5598D181E5FE126C54BA7A62@DM4PR14MB4880.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [Jbc5FLZBsRKxbJU6/BPwyy3QyZvP1MyQEYI7LLTZChw=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR14MB4880:EE_|IA1PR14MB6917:EE_
x-ms-office365-filtering-correlation-id: f0f5e9db-3f60-478f-7ab8-08dca20a518a
x-ms-exchange-slblob-mailprops:
 Vs63Iqe4sQmRZ8qlr/ycpgAEOPKg7MYlixds81OC3cZYWzbpc4mzWbQXmpqLfwL7ARuIG+27tu7u548REX6l0xD/1KTIMggACAaAmpl7Bd4v/pBpdGeYOw0RGoH09cjCQ9sW7qwO7r21D5i//E1eMSLzLdRnfhN2k+lRXuGfU2Chib/QIcdfpA8Fust4fQ6lesHYpSknZmnCewCmoAmSPxrNPYKYc+uJYTAGE7heMf0CHYTAhN3twzeDGDCPrcxGD9/dBBiuCXGjbQSkJtdfq2BxSkVXZf46JuelQVRK7+Q4ic1BR3HKvhYCgWPHkHA6tNvCyEm4+jsjlE7nc5T788hbBc3MEdLbL6y+FdDYuUOS85AhsqkSvF4FGbRjNb14/J0ALBFS8plzqyuXa8uzKBh/2FykRLakrY3bkLRKbW1GPbsLP8TTxuvH6jjh1UARN1AWx/itHHQfXK8GqqK+dn3rajUGWZM/TOgfsWc+BkJ5reSIcL/F2+bf+JMEvRl08HuRbfRPk48QzRMx0L6ep3QrHpxQemnb1xFX1wNP5xqH2FGkN+0r6GMBcVFhw+vQpsKAIsEN/HEWMgwQYOpYM4ZPQMqqOj4+OfDeqBHZ53xy4Y/7mlt/KoUe1IQ3mJYrXrUjzYq9SCMbYZiX9ZDGkq1gGOFXQreWLNe+bcDjjTN7CiCw8qSDUkmIwh0AVCaIozD8z8nZ4/fW96y4ckrtKQp+MdZwujASXpv052H+jiw=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|19110799003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 2yrbOBu33FTxPFXslIUGe0HnNlDwkfzkzXDucOHRwqnnIAOxCRlJ4C8d8BOESF+zxCy8pjP0zVo74rWwc+p9bLxTp4K6Hwf/2H/+TCDCW21K3rxiEeeBlyU0K5ruYZ/rD7/z/1vRqqSwAaqOHFs/G0Ur4XTI7SeFE9whw2E8lft1UmYUfF//5loixwT0JIVxsN7DD5t1hrEVZizdFIOv+aNinVToW202c9xYK//27NM5bMYVAo3TK7UlrSMnTyC4iyPZ7aWZng4/3sM4h9xZtCHvS70zd490Isi4kbYwJD5WzzIl1IM7L14sveuY6kbNBlNta4wVulGckb0jBzZ+wVgWov38K0siuHY+JEH0kgg8YLJCdEqVfa3eBVEPehQmoUXaW17mGaUVgG7zDmdlZ2SijsPmRSEiY8YELvc68PTkYsjCfgHjj06j+Vml9B2W9ycqmgrZYQ4jsSD9uwMK9aLiTck/HEoCLuFVgPhtAGTrVof8cUT1Gy9hoc6qDOVd5sMV8Y2JSpAyfEyKDgGIpwKbnrzLpdfgcZeNHNKU4CnWp6D1/MSb0+zYsnFHW4fJ8ZameH+5LKpJCwGW9mqH3yvZ1Ba8JRa4H3AcvlDovxlano6l0JfcAs1t7KoPf/B3Zb14V5heyYuTNLrJAJh/vw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?BbNrt5RovOEjg7FiuCQgljm7qpFzP/S7ba/XA/o0HfG/tbmlbT/aLLcRSb?=
 =?iso-8859-1?Q?8/SnX9itPGn1hKa27YqnpNm40LlqEi6N+B1WcjfvcP29g7Js3uJO1TJ+1b?=
 =?iso-8859-1?Q?WYeAsCXzb3IdRfim6FPsbA0YIBubCcxnZ7XBZdkM/GreqrZDqM7Iyk6rMs?=
 =?iso-8859-1?Q?sBKXhlQ0vOMlighPRw4VAA+7tIrF/zQF4KNDDMaqfgnlbCjvyu/5AuH+y8?=
 =?iso-8859-1?Q?QM4J2ZMrYaQWC+bvfmehuVy2xH3RKsNyUY0Z2bQ9UuhCwFsmaf/XrFPFIt?=
 =?iso-8859-1?Q?DdY5D8imS1y7O/b9/XixFvfzCpQ2S0s5EAldhTM16doGAXjbMYEkgDgRDM?=
 =?iso-8859-1?Q?cJBIk/ol/LLhc0a1HSVwYbM9JA08f6YnX1Wcx364x/vzfck0zKS7GxWJCr?=
 =?iso-8859-1?Q?9lvDy6dBA9ewC2frfju7oqQcbNIHh7EDwcQjD0WZMZ+F9DeoX7z1xRjsKm?=
 =?iso-8859-1?Q?YVQvOpXDpIJjjXFCjvF9tGwvAAc2IIqTkhiIUf8fyHJEguPlFHbzszqpQa?=
 =?iso-8859-1?Q?FwF4xfmTlghYyHegaRs/GfMVJRekaIh2OZMmdkeZJr8ogl9bPD8EJCVulZ?=
 =?iso-8859-1?Q?F80CefCtkmFnuGHgF8hU0FSkELvZ/4jWrk0qJgp0c/FNX6LIwEMn8JZ1NJ?=
 =?iso-8859-1?Q?RGtVF5QafVVJUo2Glo56hBSEZ9JlrCjOY7XoZ1+muFU9VnnkqOJrxD8xX0?=
 =?iso-8859-1?Q?s4AsWS1qdL0rnFoGR2ByRdiiNFOoDpi7d4FvZ2VR0oSLhnrYik3TyLe2xR?=
 =?iso-8859-1?Q?ydxp/Y/qs9rvhUmlLidrSZNCwexxV5f2Y2sjHOZm5Q8LggD9+3FRWXysM1?=
 =?iso-8859-1?Q?csMdaDBHW2Ux1iTPZ8HdyJWe6V8Gd64S3RVzl0Wlz1C3dJiBXRLJ0JAANX?=
 =?iso-8859-1?Q?8wFgeCm0gt1DG7bjiuaaeozEpYfsKLk7Ur0dZGhi5xzl3jp/mp+yMU2RUM?=
 =?iso-8859-1?Q?VYTJoiIX/p7VSd2IgRCPhUH2BMdzXdNxoZwFPQZ20hXr3NCau/cMeyaEW7?=
 =?iso-8859-1?Q?GVRwA8p21MHsI8luU3Sw+qzU4GqhsgqfkpGycelOc+tjYfUDIILF6kqu56?=
 =?iso-8859-1?Q?adh43j2PtcyzZF2gxsbnu+c0IdEyy+8mdqZBxDK56LXCahU4xzaH89LnTL?=
 =?iso-8859-1?Q?23hnPb5hutqdXkDCp754zUlNcXLT1etE3vB4U2OCbju3pxs3uH9y2pXoDM?=
 =?iso-8859-1?Q?1xB+UsP0UBihpfs7hQlVj6eg5IaZT6AW/CTS2JBB/TLtRW6kynhG6dvtdN?=
 =?iso-8859-1?Q?HpalpCWzeRyLcgnkileWYwfz45AksCWX88OGiN9XJ8Q+intinuEnTA+VHr?=
 =?iso-8859-1?Q?SEJx?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR14MB4880.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f5e9db-3f60-478f-7ab8-08dca20a518a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 00:33:58.0664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR14MB6917

From bc0f427f81b5b25f1c706c66e455dc9ea5686266 Mon Sep 17 00:00:00 2001=0A=
From: kasper <kasperkantz@outlook.com>=0A=
Date: Fri, 12 Jul 2024 00:23:56 +0000=0A=
Subject: [PATCH] main: remove static from const strlen To fix this error:=
=0A=
 src/p2putil.c: In function 'p2p_get_random_string':   src/p2putil.c:2641:3=
7:=0A=
 error: initializer element is not constant    2641 |         static const =
int=0A=
 set_size =3D strlen(CHARSET);         |=0A=
 ^~~~~~=0A=
=0A=
---=0A=
 src/p2putil.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/src/p2putil.c b/src/p2putil.c=0A=
index d1f114d0..ef0f988c 100644=0A=
--- a/src/p2putil.c=0A=
+++ b/src/p2putil.c=0A=
@@ -2638,7 +2638,7 @@ void p2p_get_random_string(char *buf, size_t len)=0A=
 {=0A=
 #define CHARSET "ABCDEFGHIJKLMNOPQRSTUVWXYZ" "abcdefghijklmnopqrstuvwxyz" =
\=0A=
                "0123456789"=0A=
-       static const int set_size =3D strlen(CHARSET);=0A=
+       const int set_size =3D strlen(CHARSET);=0A=
=0A=
        l_getrandom(buf, len);=0A=
=0A=
--=0A=
2.45.2=
