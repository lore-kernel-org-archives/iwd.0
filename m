Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80118.outbound.protection.outlook.com [40.107.8.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439D74C62
	for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 18:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDDTyybmzayiPCO169Jol2+iMux9DTy+QSixejynd1w8EtVIyrdbO/jTDc1IQG2TJk2kxDb5E0X7Oymsi1E/svD8l17kBEzeebS+9uHf4kUn/6o3EXI8PP3xI7oh/SNVA2b5WF42NevkXkQ4a0/z7xitfUSS1cgfvMLyad/R29kCZy17mzZivfFpuxdQYaLwswCnOwAjAFBX3OZj7h63kaqDPFz6VhDg7sowjQWHWbjHE4ZyANxI29/TjnlmaAL/ZvEIbmr0hNZZlFbml/kzztQiSTfHjdVHmpr1vMNHfRw+GZP0vsomN+PnCWkF1CMz40b4wfQPz080+FKtcCW9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHPV8TpUILT4fqcNydySnMl/E21Hk1kqbaPBEzDuYiQ=;
 b=oXBDA0cMiRvcFQYfhGMpEZ/vE7/DEDPpWZpl4bZRqBgoPcC7KG8zgilSMCO7odNhUwxkthJv5x2znI5pDJPnQVYeZLOffW/DqlCONB7mxpeZhrDpLXGHO6jXvlim4hR8BriWvII2w1rjIAHvKNAVkGW8rW1prjBi6ZeYVGdYqvSU5MFPLSBQF0Cs9ijmMAnu15SEzP7pvLI2Jj0Nic0VFEMHgytaTIrC7WvuCFFf3jiTORA554x8SCFBQ5Tc6uRTzGQNOyazqYO+F6Gu5PvXvjH9n1toPz0m/wavKitK4U5E/vSCLnn2lB5BC3BYXe0KedqxRFJ5d4kI1QgMVm1NhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHPV8TpUILT4fqcNydySnMl/E21Hk1kqbaPBEzDuYiQ=;
 b=Gt1Ly2WWwpL3n36wPwl+IjgUHJJLCgvrCCKeeAi3bex3lz5G5J0ScUlXz+lSOBwibfja1+cBH5E5LMIFFNYw7qPdjhWoFPeArizMO44oZfq9POZFmR/4DSLyYpQ7hDlpGlQvnG7gcJ5yyBMlXVXBr4G+xvRGXYghHhSXVJW4fk8=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by PAXPR03MB8202.eurprd03.prod.outlook.com (2603:10a6:102:24c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 18:48:18 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::f17f:3a97:3cfa:3cbb]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::f17f:3a97:3cfa:3cbb%5]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 18:48:18 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: James Prestwood <prestwoj@gmail.com>
CC: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Re: [PATCH 1/2] station: add two new roaming states (FT/FW)
Thread-Topic: [PATCH 1/2] station: add two new roaming states (FT/FW)
Thread-Index: AQHY02rfZIBegYLAnE2smZ1bfqKVJQ==
Date: Wed, 28 Sep 2022 18:48:18 +0000
Message-ID: <20220928184817.nwc3w4awwsssv32x@bang-olufsen.dk>
References: <20220928183351.363600-1-prestwoj@gmail.com>
In-Reply-To: <20220928183351.363600-1-prestwoj@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|PAXPR03MB8202:EE_
x-ms-office365-filtering-correlation-id: 1601395c-2302-484c-2eb2-08daa1820276
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nv/HP38orAZraI7WhJg3/wQjaBZ+qBSJ5TNn0sZR4MvWDxXt11mmy13DB1T4pijwm+raY34S5hfDz3qpxBetHI23e3c/+E5uH3cODALccna7LNjijDJusFQG4fkonD0Ym5OiiDPzn9vO03vF9lo2K8eKprhWlq1fEd8wFLLLlEY/Yl/gGoun3Nj/JEgJUlOBicFGlTCV9ATuhxrrsQs9WSHCNYdzS89qsXkEqRD+xwWKLzoVoUjEfM9hroo15LkHvgaWHRMK/jQ5Z0J1iW982YvxjuCcCQHEwgks6CNjzad4XsIn36y8DvCINPBH5kFuzZMaRuHxwa7iaR+6IoKuVN5HSZnoglzRZIBdo28EdvS0JOPzX3M34QGaCx+suHQuNMlb0v+aomVAYr5IYi7gXQjOvFoEWbSFkF7JX7dnL3E+y1RHoSCFXBS1tYeqJyLYME4BFuyLdeWIsq1ou68bQvaCXLZDkgvOv/TA5flS+JBaG2+0Vl6VQ8tO95JqkGtnC0wbQaj6/NI0KFXSsdVYNgE7bSipjm9okR2soYWR5arU9jpdQgD5H19SQIkS9Qu8vG89D7NkhXEEVPynffNSPdyzkg45tLDklDGrVuJxF6lHuC8/Pr5Kf/0Qkkd2kt4e8t/aMya2jwZRbBHNR4jPKSE4wf98ZpR7DP7zAnqHv0NaJq8ejIod3niidzr1yChta2dvzY1rYHfUcUuzFbeo7oVlBFJ6J5/JaBXgOSB103y7wqXE+Ou9DcEvaZZJblPOH2Ui3lqNlXArcNvzFVEbQA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199015)(2906002)(38100700002)(66946007)(41300700001)(76116006)(85182001)(8676002)(66556008)(91956017)(66476007)(1076003)(66446008)(26005)(64756008)(4326008)(122000001)(186003)(2616005)(8976002)(83380400001)(8936002)(6506007)(85202003)(86362001)(6512007)(5660300002)(36756003)(71200400001)(38070700005)(6486002)(316002)(478600001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkQ4MTk4aXFPVDUxekRvRFlaY3RVc2pqeTQvRXc2ZEc0WEtnakFMVnMvamRK?=
 =?utf-8?B?TjMrNHdzN0ZSVS9xa2ZRell6VDdQRXhaaDFkMGdFV2sxeko4NjErWDdGN3Bi?=
 =?utf-8?B?QzRZRk5GbkQ4enZydkdqaUtQMjIzQnZ5Y3hEMTM0MFEzeUhtaUhxemd1dVlu?=
 =?utf-8?B?VnBvZ21pblR0NktLUFpaeGY0UHhEanJ3eXUzRGgvQ3FUMEh6MDZzSVEzNkNQ?=
 =?utf-8?B?ZFpmZUR2dHNVenZmanRrZXF0SHZuTnpiRDlsMlBCM2ZrQzVWQTcyUnZGY0g5?=
 =?utf-8?B?NThnMWJOOVpkYVowSnpUSW1reTFKTFN5TlMrU3Z3VjRCK01CV2E5TUFiR0RS?=
 =?utf-8?B?YWlzdUJ4a0l6dUNnRUFYTTRKM1RGbXJCaytTNjk2NWkwUVJXSUROcjhJaE50?=
 =?utf-8?B?MHcybXZTRUs4NkxhQVlBdkFDMmlvcENPWkFzaUlIbXYzU2RCOW81RlVmNHBx?=
 =?utf-8?B?bHVQTTlaSVdOY2xIZDNqbktCNlNnZ21oeFE2Q1BreHI1eVJ2ekc4MGFjTk90?=
 =?utf-8?B?TjFRRTAxSUdZL3dhdWJaK2Y0c2xQWnlmSTNJWThodHJOcDZ4eE5ncHhKdlZh?=
 =?utf-8?B?Q0haZk5lMEd0YUx6L2RxZXBuamFncDJGeFVNbktibTI5QTdURjNqellzUW40?=
 =?utf-8?B?bUkxVzNSVXdldlpwZjVwUzgvRUYzanFGbnUyZmpuSXpxUFdnRFdzOHI2UFFr?=
 =?utf-8?B?Z0g0dEV5ZUx4WE9iYk1oanozU0x5ditQSmRGajZ6d0JYZW91enVGc0t0With?=
 =?utf-8?B?bWEzeTlucGY2dzFGRjZrZk9weHdxVDY4WEErcE81elBqNzY1RFlKTTRHSG5I?=
 =?utf-8?B?MHdUYSt1S0J1UnJuNmwremt3MXlSUUwvQlhkeVlDSytxYXdyZ2h5TUg4b0Zx?=
 =?utf-8?B?aTB4Y1RMTkZaRXpvazhZdkpUL1VGMGN5SDJnVU1uZVNRWGJhdHVhRUJjL2Zl?=
 =?utf-8?B?TFA4YVZDT1kxWmZybVFGdHV1MmRnY2JZeDFuWnlqMHhTaG9YaFJLWSs4a3dj?=
 =?utf-8?B?dGt0c0pUK0k2ZngwTGJzd1QySGZidTBEKzZZNjJzTEdGMEdjaFNVUkVtdXZP?=
 =?utf-8?B?blB2eVJBUzlFcTBsYk5OZkhNaHdNc0Jkbk1zMUNObGFHQUpYUTJXNWlpekly?=
 =?utf-8?B?ampmYnBPUEdTeSsxNHo2R2hTbHdaNVpCMFA0ZGJrOUNUMUgwcTlubCtuNXJS?=
 =?utf-8?B?RDA3NXc1K1VPNjY2bFh2LzN3WHhpSlpWMEVMUnkvMUh5QWVTYVlIbk4weGdQ?=
 =?utf-8?B?cXA0L2VHZGpDRE1NNStYdDRyWmtBUExnQmVYKzVOaVFKZGNoZHNsT3pnYmc2?=
 =?utf-8?B?OTVEeVNkRGxKenA4RTFFZ29DYTZ0YWpoOUZaRVFYWkZUcWQwdzlQRjlIMHdG?=
 =?utf-8?B?RE5kS2pwekVRM2R5S0FXWCs2SXI0TS8vaFVqT3kyQ2N4eWxjdDFYcmVrQVNG?=
 =?utf-8?B?cVY5NmpPTEowUUtvUFJ4dlljb2dESUErckxxdTlmdXk2WlV6U1dHSy9BTVpX?=
 =?utf-8?B?bklxNjhNcWxBYzJoTCtuazIyNWNFZUFIN0pSRXUvTlpFNEpLeVVDcGxIZXA2?=
 =?utf-8?B?YWVMZnNNeWQvRkltMktMNlUxYnBCMXNLclJ0bHI1UzRSVHFWOWdPYys3ZDdB?=
 =?utf-8?B?TEx6STQxZEs0NzFkT2Zmdkp4U3RlV0IzREFPdTgrWjFhVC9uNGFzU1NiVDNZ?=
 =?utf-8?B?OFd2UVZqMGR3bmVmSkFZNDczdkVnMGI5b1RqLzdLY1dzTGZZMXlFYzZmTEZE?=
 =?utf-8?B?cGJqU3VrRGZGcURoamxpcjVKWXBUZzhJNEhGb21tQ0hxTzZqSkJzcFZkVW4w?=
 =?utf-8?B?cTBIdnEySnNUa3BEVHo5MzNWSnNzWmIrU0UrM1VXOGVlRm1GVXdMdHF2ZXk5?=
 =?utf-8?B?SjZleEJRTjR3bHNBTElrUSs5Q0VadGE0QW5iWGpWdWRkT0tmWVB3elNqbXRC?=
 =?utf-8?B?bFVPZlM2d3E2STlVczVBdUQrQnREMU53S1FzTW5CK2NJRmpQZFI4czVQR05l?=
 =?utf-8?B?eUZJM1VqV2V0Q2pnVFFlZlA1amxLaDlBOTI0S3ViSGFmaTNSa2t3S09HdEpS?=
 =?utf-8?B?aER6VUJtOUxQekVtS01JbVphdVMwVmxsSGNwY1VneEpXcFQwS1RPbTFVWjBl?=
 =?utf-8?B?N2x5M3R2OUYrSENoWTRuSjNyVEtPQVNtVWIzYzRDdUkvN3VSUXA2Ui9mTU55?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99AC2BA9A68E6242AEDC9B19EDB8B000@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1601395c-2302-484c-2eb2-08daa1820276
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 18:48:18.4997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oT8+XY1c8PbUKMFSUxkufHFXjszu/V9v2n/K8piQZO1PtJojljZoDeRAjOCNYxmGEoGG1ZiG9ArcpKck5Jbr2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB8202

SGkgSmFtZXMsDQoNCk9uIFdlZCwgU2VwIDI4LCAyMDIyIGF0IDExOjMzOjUwQU0gLTA3MDAsIEph
bWVzIFByZXN0d29vZCB3cm90ZToNCj4gVGhpcyBhZGRzIHR3byBuZXcgc3RhdGlvbiBzdGF0ZXMg
dG8gZGlmZmVyZW50aWF0ZSBiZXR3ZWVuDQo+IHJlYXNzb2NpYXRpb24gKFJPQU1JTkcpLCBGYXN0
IHRyYW5zaXRpb24gKEZUX1JPQU1JTkcpIG9yIGEgZmlybWFyZQ0KPiBiYXNlZCByb2FtIChGV19S
T0FNSU5HKS4NCj4gLS0tDQo+ICBzcmMvc3RhdGlvbi5jIHwgMzMgKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tDQo+ICBzcmMvc3RhdGlvbi5oIHwgIDQgKysrLQ0KPiAgc3JjL3dzYy5j
ICAgICB8ICAyICsrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDkgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc3JjL3N0YXRpb24uYyBiL3NyYy9zdGF0aW9u
LmMNCj4gaW5kZXggMzcyZTIzYzEuLjZiZDY2ZmZjIDEwMDY0NA0KPiAtLS0gYS9zcmMvc3RhdGlv
bi5jDQo+ICsrKyBiL3NyYy9zdGF0aW9uLmMNCj4gQEAgLTE5Nyw2ICsxOTcsMTMgQEAgc3RhdGlj
IGJvb2wgc3RhdGlvbl9pc19hdXRvY29ubmVjdGluZyhzdHJ1Y3Qgc3RhdGlvbiAqc3RhdGlvbikN
Cj4gIAkJCXN0YXRpb24tPnN0YXRlID09IFNUQVRJT05fU1RBVEVfQVVUT0NPTk5FQ1RfUVVJQ0s7
DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBib29sIHN0YXRpb25faXNfcm9hbWluZyhzdHJ1Y3Qgc3Rh
dGlvbiAqc3RhdGlvbikNCj4gK3sNCj4gKwlyZXR1cm4gc3RhdGlvbi0+c3RhdGUgPT0gU1RBVElP
Tl9TVEFURV9ST0FNSU5HIHx8DQo+ICsJCQlzdGF0aW9uLT5zdGF0ZSA9PSBTVEFUSU9OX1NUQVRF
X0ZUX1JPQU1JTkcgfHwNCj4gKwkJCXN0YXRpb24tPnN0YXRlID09IFNUQVRJT05fU1RBVEVfRldf
Uk9BTUlORzsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGJvb2wgc3RhdGlvbl9kZWJ1Z19ldmVudChz
dHJ1Y3Qgc3RhdGlvbiAqc3RhdGlvbiwgY29uc3QgY2hhciAqbmFtZSkNCj4gIHsNCj4gIAlzdHJ1
Y3QgbF9kYnVzX21lc3NhZ2UgKnNpZ25hbDsNCj4gQEAgLTE0NjEsNiArMTQ2OCwxMCBAQCBzdGF0
aWMgY29uc3QgY2hhciAqc3RhdGlvbl9zdGF0ZV90b19zdHJpbmcoZW51bSBzdGF0aW9uX3N0YXRl
IHN0YXRlKQ0KPiAgCQlyZXR1cm4gImRpc2Nvbm5lY3RpbmciOw0KPiAgCWNhc2UgU1RBVElPTl9T
VEFURV9ST0FNSU5HOg0KPiAgCQlyZXR1cm4gInJvYW1pbmciOw0KPiArCWNhc2UgU1RBVElPTl9T
VEFURV9GVF9ST0FNSU5HOg0KPiArCQlyZXR1cm4gImZ0LXJvYW1pbmciOw0KPiArCWNhc2UgU1RB
VElPTl9TVEFURV9GV19ST0FNSU5HOg0KPiArCQlyZXR1cm4gImZ3LXJvYW1pbmciOw0KPiAgCX0N
Cg0KSSB0aGluayB5b3UgaGF2ZSB0byB1cGRhdGUgdGhlIEFQSSBkb2MgaW4gdGhpcyBjYXNlPyBk
b2Mvc3RhdGlvbi1hcGkudHh0Og0KDQpQcm9wZXJ0aWVzCXN0cmluZyBTdGF0ZSBbcmVhZG9ubHld
DQoNCgkJCVJlZmxlY3RzIHRoZSBnZW5lcmFsIG5ldHdvcmsgY29ubmVjdGlvbiBzdGF0ZS4gIE9u
ZSBvZjoNCg0KCQkJImNvbm5lY3RlZCIsICJkaXNjb25uZWN0ZWQiLCAiY29ubmVjdGluZyIsDQoJ
CQkiZGlzY29ubmVjdGluZyIsICJyb2FtaW5nIg0KDQpJcyB0aGVyZSBhIGdlbmVyYWwgcG9saWN5
IHJlZ2FyZGluZyBzdWNoIGV4dGVuc2lvbnMgdG8gdGhlIEFQST8gSSBhbQ0KYXNraW5nIGJlY2F1
c2Ugb3VyIG5ldHdvcmsgbWFuYWdlbWVudCBjb2RlIHRyYWNrcyB0aGlzIHN0YXRlIG92ZXIgREJ1
cywNCmFuZCB3aXRoIHRoaXMgY2hhbmdlIG91ciBjb2RlIHdpbGwgbmVlZCBzb21lIGNoYW5nZXMu
IEkgZG9uJ3QgZmluZCBpdA0Kb2JqZWN0aW9uYWJsZSBidXQgaXQgbWlnaHQgbWVhbiBJIHNob3Vs
ZCBrZWVwIGEgY2xvc2VyIGV5ZSBvbiB0aGUNCm1haWxpbmcgbGlzdCA6LSkNCg0KS2luZCByZWdh
cmRzLA0KQWx2aW4=
