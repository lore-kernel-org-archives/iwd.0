Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2093.outbound.protection.outlook.com [40.107.21.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B27EA6
	for <iwd@lists.linux.dev>; Mon, 18 Jul 2022 09:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEAxPWbs03HV+IaO7iJJkRzt79qLCzeNtrLrj9rGg2tgv0bGKi9nVbAjQLBLtk75D+zpSjC15MnXShsVMziDyOBAJ3h1BEFnpKqjOkIXEumjy1Zz1E/gu765yXmP9uA5vZ5wEo9mtvQIU1B5OZ2D6RzS2yOfPrEpkVq0vuEJejDIYprlADmXSelPnA0zDE+8apxxfbWvixvCD7XNJjr3CEXiwTAG2MNqcYdVAJPLZI3FidUB8Q19xZ+JLBvBUU9Hi2iNcg0s/Mk6sn6MjYjsawTI0yzU/m93KJVjC9Gn1uylyK3SWLnvzEwRAheg2YvdkLMaAcjGiPMBqXDU+dH49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yf1qdAC1nONiM9LUOD1IFzJzOEp1OT6Io/nls5cVqHk=;
 b=RLp444okJWiui4cszsztnhc8GvTV6dKnjzB64GSrvCWwwq17nSs+6nNSPRC2VK0xsR9qMdfYfoaOuvRGl8H70jssylgh2NYc5T5pzzskNDkeq30nBhtN8/A33ggfOwSlKDH11rykVscebvI6y6lK5JpDGEDfDylYnwfMDSobm8MXgOLZ58YdzeRYwG13QNPISIALy8+3cAChVYGTXTwuIKgnYjgydxmC5BzwEucd1hfyM+EqzxUZJTGxG2nuXxCWZDLZu2Z4IRigkcBb/q7X7/lpzj2rGn/rY0GJpkf84mMXAicmR/PSRSfcoyaFTFYiXTa3aEEZXzAN/lphDVSGNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yf1qdAC1nONiM9LUOD1IFzJzOEp1OT6Io/nls5cVqHk=;
 b=FBhJxqYfuFX2oViyw1jeJLHon/GW7X3iICtO1fambBRXOX7CbTH89iY8Gk3hmdz+YKJDsXcUWT4eGKwkR3/F7tVA01rNwLnf+bg6ms6ENSgWxa5wPGtmUokWkzbXhlRLXInsZ8fSm/QgEwbTAw50GFkZAWrpU9A2SXUEo4u0zBE=
Received: from VI1PR03MB3950.eurprd03.prod.outlook.com (2603:10a6:803:75::30)
 by VI1PR03MB3615.eurprd03.prod.outlook.com (2603:10a6:803:2c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 09:10:18 +0000
Received: from VI1PR03MB3950.eurprd03.prod.outlook.com
 ([fe80::de7:d0ed:2d93:9f78]) by VI1PR03MB3950.eurprd03.prod.outlook.com
 ([fe80::de7:d0ed:2d93:9f78%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 09:10:18 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Denis Kenzior <denkenz@gmail.com>
CC: "iwd@lists.linux.dev" <iwd@lists.linux.dev>, Emil Dahl Juhl
	<EMDJ@bang-olufsen.dk>
Subject: Re: iwd 1.28 segfault while terminating
Thread-Topic: iwd 1.28 segfault while terminating
Thread-Index: AQHYl6IhhDAjjHOo8UC8aT6SDA+BFK1/jIOAgARQnYA=
Date: Mon, 18 Jul 2022 09:10:18 +0000
Message-ID: <20220718091017.yk2yu5fwrf5qbyoc@bang-olufsen.dk>
References: <20220714165240.244e25gcyjtaxhx2@bang-olufsen.dk>
 <75994299-03a7-8a01-30ca-2342e5d7c5e0@gmail.com>
In-Reply-To: <75994299-03a7-8a01-30ca-2342e5d7c5e0@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 289b4a99-2c55-49ab-9c35-08da689d55a7
x-ms-traffictypediagnostic: VI1PR03MB3615:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kSX1mJWebV+Mwx3rVyZqjCJA2BnFF1QBIZa7HMTCCHD81UE/NrfZh+33xV5cekJV35a+GP3pht8ic/p0hjG4/AAbwjnzBXdfsvFc8R0TAW1YD9Yz/KHfgyy2B/W7ZPVm/6rwyBHS4k4qdamdaHei9Cgtc42WkMIDoaAqCcMIwJixHzv650S8ybLpGyVgvQJk06s+G4Rveg1uK21MlIkrHPvOVwutli1NvqWwT4gHAHeN2U+Spte9qtI0Prn+D3LdjTfLBrtAxOUiZV1GDHfG9WiPF9E4lkdKSGfjsl7Lc25JIkuuj/YQxGXD3ULDCyR1tQPOhvPkUgkLzB+CwTebdX9K8q7dkopssA7bpBPhhA54V1cyMpgwxHeOMVrWaAwyGWuwkJMfWLsVAeDcUU6iuasT0SzCBEJmUUu1GoH76z7DPktLSMsTa8nyrCSI7uN+eQ5anEF8VkQuLxVV2cFR43cHt0BxlUkY84qxY72h+juD8sscoPL5V6wN2xgrMwn65uzGC8NCdzQAwif5rt4e+XFbirw2Z1qOUsj3ic016XoxV1a4NC77h0OHZ2Z1eXXy662ra2jWVo7qqKHesEfmd9z7vEPXFgr3VoIB7k6SmQUkWA/ctWKDhGgHS4tp97MpkrBEMa1nUorUrLvdYcXU8ZI4eT4MOnyp5L4ok/ncwK+rdGcLktk8TYrQe1TYYkEm5ZnP8ZaNQjitwZhgGoqgHV2n0z6UQmoPtk4elFe9ZvCfKFf08nOQhSQezOjmcOpE2i3vj4B8qH2LNUw6CZEeuY24EAJOIUs9l/oIRcG6L0j/gtn2QHuqVjbInWIh4Q5z
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3950.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(346002)(136003)(396003)(366004)(376002)(86362001)(478600001)(186003)(1076003)(6512007)(26005)(8936002)(107886003)(122000001)(2616005)(6506007)(6916009)(38070700005)(6486002)(71200400001)(41300700001)(316002)(54906003)(64756008)(36756003)(76116006)(66946007)(38100700002)(91956017)(66446008)(66476007)(83380400001)(8676002)(85202003)(85182001)(8976002)(5660300002)(2906002)(4744005)(4326008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z0lNWngrVUkzMU9lZHBBdS92d0JsbkxDdDVEeHdyNUtlYU1RL3RQZ3Bpd0tu?=
 =?utf-8?B?dXVwV0NvcCt6MkwxQmREdHRjQTd0V3YzTVBlbDViQ292R2FHMTNzbHRGNndT?=
 =?utf-8?B?YWdiV3JXMUFDMHhhUTkvaGloVE5kdEh1ZitVWkxVemVUWjZYNHB4eklEMHlz?=
 =?utf-8?B?cXYwcThEcGtJOXdaMzYrK29vRUZwQUtBbEpVaUZmQ253WkI0TjRpdXhuWC9k?=
 =?utf-8?B?TmRBY0dTOHFBclJYTmZxaWxSNmVxS3kzZWRzeTNuRElZeU1aTjF6UWx5eGhz?=
 =?utf-8?B?UXgxR285UnpiSUJxQTVsTWliY01iRUxCaTBWMjJmbmRTTzhJbEhQb1NLdm5o?=
 =?utf-8?B?SVZId3N1TlJEVnJ4NW1vQWpXcTBkSFJhbkpuSk9ac1FRUzZsaVdGR1VDNUhx?=
 =?utf-8?B?VzdpR0s2cWFpMEs1MEpKVnlCTmdzRitUaUVQaENaWEExZGJjTURoZ3lVWlpY?=
 =?utf-8?B?T1NpQmZoaTVxNXpyNVBXajArUjdVaUthd09wb09iZVZEZHZNNkdLSVpXdVpS?=
 =?utf-8?B?Y25IeFJiaDlMeHo4M0N5QTc4azk4Yzl5UUZnSG5YTFZNcWlSdjJkMmlsR2tZ?=
 =?utf-8?B?blpocmQyZERNRXRoczdXZDQ4c0RiWS9xaU00TGNiZG9PWm5paXIzQkk2THIx?=
 =?utf-8?B?UVp2eEpMRUk0NzZ5N3JEcHZMb25aMEhUNjkzTjdjZ2dBWW9ocGNaVDY0S2sz?=
 =?utf-8?B?QU5HaHlNaW9wc2x0dkFWekZKTXRWQUpLQ3NUNEh4RTVQQlZYUklCc2lkRjJZ?=
 =?utf-8?B?QkFablM1bHhiRVB0Rk1nemozUU1CK3RrZGRXbDVlcFh0RFlNNjU2dnBxT2pQ?=
 =?utf-8?B?enV4SDNIYjFFZ01ZYS8vRmY0eXlpb2JBY1JCVEx0YlZkYThsUUtaamNqWE9Z?=
 =?utf-8?B?OTcvTGhFSWxWbjR0azNLNjFWdnJjRGsyaFo2Wk1xYVJNWjhMQ1pwOXJlRG5Z?=
 =?utf-8?B?OGlhQUtVaXpwMy9xQnl5UWQ4WlJ5MVR4NVpYWVZRREZOdFZJd2s3NGd5MzRX?=
 =?utf-8?B?d0dyWDl6aWNXNHlwcUZpdXpqU0VFZFF0eHVKQkdPUGN6aThmbERUREJuQjMv?=
 =?utf-8?B?a2VKMXlVdGRtZE90SDJ1RVdISGdoam81RTJWRnN6VHpZeENMVVF0ellDakpz?=
 =?utf-8?B?RGpOMUl3RnJUTk5TenRCUEtTUXhJeDlpMndBWWYrYzMxZnNlSXNsLzdRNlVm?=
 =?utf-8?B?b21WaTQ4bXMzY1lUR0d4bXJMSnZXdEp3aWJrcUZEY2ZtRFVmdGRzbzBKanN3?=
 =?utf-8?B?ZUhmTkxsaWhqTVFhVFM1RWN6d1g2eFpMMkxTSUdWTkE4bnJqU0creXdtdmFV?=
 =?utf-8?B?WFYreXFtQ0I1TEVtanhqZmRuMmZablhCaXgva0pXaktZL3dTa01RNHI1S0NW?=
 =?utf-8?B?WmxNWGo1V2lLSW83MzhZM1hDTXlQZGtCejJKMk9oNlNielpKb09xY0Z3SzIz?=
 =?utf-8?B?QlZxcVhlNnFiUERzejVVYlJHUnlBbTl3N3cyeXJSazNaanR6QjIyRVZWWXZm?=
 =?utf-8?B?dzd0dlpjTW8zRG1SUmcxdmo4UmZMVC9wVlRVNVlWTDlTbEl1LzVhN0I1SlVY?=
 =?utf-8?B?Z2pCUU5FakU2Y0pKa3B5enppMXdsS2JJUm4vU0I4ajU4OHJkZFpHK2MvWmZF?=
 =?utf-8?B?UFR4dDVOV3VEOUlsaXZ5MkVKZDI0aHlac1UzUVdwdzFrTElMMkJzWlNVM2pG?=
 =?utf-8?B?UVVNZFJidlowWmh1a3JzcEtJU3lFUDlEV1g4aklCaVJ5R2tsSytvMmhmVjNT?=
 =?utf-8?B?N0daOEdQUm1pSXVVVUpCczZISTZ6UXlhS2JlTUp3Qk5TZWVNd2xnemlHUVo4?=
 =?utf-8?B?eGFDVm1FaEJYajhERU55ZFdVRHBiRnQyczVtUzRZMjNKK0Z2UzhrUUdlWHEx?=
 =?utf-8?B?TW1kcmtUdFA2ejFqUEZxVE9LRlVSUlF0bElQMTRlQW00RXJxdUFMTTc2OElT?=
 =?utf-8?B?eUxseTgwVk1zc0FDYTBWOXZwYlZVZHpON1ptVFhLYWpKc0l6cU1JOG9Jczgw?=
 =?utf-8?B?Y1U1dm5lK3czZ3p5WmdMS2RodTEzVEdJTDJ6dTNSM0ZCNnREeDh0N1VjRnR5?=
 =?utf-8?B?T0RmUXdKMkJRNmNUcFcvcmlYbHRTVk8zRnQ1b1ptZW5CYisvMFprcXZmOFRD?=
 =?utf-8?B?REpKNC9EZ2NJaThUQWhaYXhOMkRHb28rSDJkSHMxUmJVSEZwbWtPbi9YUFlD?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04FBA2A5E6AF41429377424F135A37EA@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3950.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 289b4a99-2c55-49ab-9c35-08da689d55a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 09:10:18.1923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cyIrarNnSTtqrupWSz9Rp0UOdU/31ZR1qRQBAYbIAq/5xeCYM/ezK/bI8vSIVqeKcEYNG7mx7Rq4VM3DJN4OJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB3615

SGkgRGVuaXMsDQoNCk9uIEZyaSwgSnVsIDE1LCAyMDIyIGF0IDEwOjE2OjQzQU0gLTA1MDAsIERl
bmlzIEtlbnppb3Igd3JvdGU6DQo+IEhpIEFsdmluLA0KPiANCj4gPHNuaXA+DQo+IA0KPiA+IGl3
ZCBiZWNhdXNlIG9mIHRoZSBCaW5kc1RvPSBhYm92ZS4gRnJvbSB0aGUgbG9ncywgeW91IGNhbiBz
ZWUgdGhhdCBpd2QNCj4gPiBoYW5ncyBhcm91bmQgbG9uZyBlbm91Z2ggdG8gcGljayB1cCB0aGUg
cmVjcmVhdGVkIHN0YXRpb24gaW50ZXJmYWNlIGFuZA0KPiANCj4gU28gd2UgbWFuYWdlIHRvIGRl
dGVjdCBhbmQgc2V0dXAgdGhlIGRldmljZSwgc2NhbiBhbmQgc3RhcnQgdGhlIGNvbm5lY3QgaW4N
Cj4gdGhlIDEgc2Vjb25kIGdyYWNlIHBlcmlvZCBkdXJpbmcgc2h1dGRvd24/IEltcHJlc3NpdmUu
DQoNClRoYXQncyByaWdodCA7LUQNCg0KPiANCj4gQ2FuIHlvdSB0cnkgdGhlIHBhdGNoIEkganVz
dCBzZW50IG91dCB0byB0aGUgbGlzdCBhbmQgc2VlIGlmIGl0IGZpeGVzIHRoZQ0KPiBjcmFzaD8g
IEkgZ3Vlc3Mgd2UgY291bGQgYWxzbyBhZGQgc29tZSBsb2dpYyB0byBkaXNhYmxlIHdpcGh5IGRl
dGVjdGlvbiB3aGVuDQo+IHdlJ3JlIHNodXR0aW5nIGRvd24sIGJ1dCB0aGlzIGlzIGEgcHJldHR5
IHdlaXJkIHNldCBvZiBjaXJjdW1zdGFuY2VzIDopDQoNClRoYW5rcyBhIGxvdCBmb3IgdGhlIHBh
dGNoLiBTb3JyeSBmb3IgdGhlIHNsb3cgcmVwbHkuIEJ1dCBJIHRyaWVkIGl0IG5vdw0KYW5kIGl0
IHNlZW1zIHRvIGRvIHRoZSBqb2I6IGFmdGVyIGh1bmRyZWRzIG9mIGN5Y2xlcyBpdCBkaWRuJ3Qg
c2VnZmF1bHQNCmF0IGFsbC4gUHJldmlvdXNseSBpdCB3YXMgcmVwcm9kdWNpYmxlIGFmdGVyIDIt
MyBjeWNsZXMuIEFuZCBJIGhhZCBhDQpsb29rIG92ZXIgdGhlIHBhdGNoIGFuZCBpdCBzZWVtcyBj
b3JyZWN0Lg0KDQpEbyB5b3UgaW50ZW5kIHRvIGNvbW1pdCBpdCB0byB0aGUgdXBzdHJlYW0gZ2l0
IHRyZWU/DQoNCktpbmQgcmVnYXJkcywNCkFsdmlu
