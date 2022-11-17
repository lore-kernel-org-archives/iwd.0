Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2099.outbound.protection.outlook.com [40.107.20.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3608BE0
	for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 18:29:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdIW9qcgRCn212+BNhi0sjN8xT/tn4nqjnSWW2WrSigA+uvKzuaZddyxTgRXg8L0T0TGaUst6Sj4tXH8hLT+nh9Et2kyDWMC/l9yW5CAVmjL1xOIFsDP8ZXuvK1zTK3z/TVsQDWRUhk5C70a7Piu8k5Y+BLtmY0iuytXGPCPlpgAxBK4qPWCaiPtUGMpzwOOcGs2jPmDkmUfE+L6Bdf85RONFQQ/WRe26eRlEfQSrimWmgm93JCCYnkFun+iO4gRCwmKQi9bvLR/OEgQW+zwz8c8VPedble+OXBOPs++6x+8jPiMuT7tQyfgKoFgaf9le6YygOIp1uXbEoam2/dQCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sybUwr0j00cLXTP16SIABeziLIeguouM9n3IG9Y+6g=;
 b=i+PabYplqTi7XeBfIBQTZ58S19kG0qEnyeyzemSCdmkfeoBbmp0mnAjmtiyDYqLm70HO9vyXtuvhhQKBe9xIt7Wp/JRCHf/5P3WENVCm1Huu2GxwqYmkH85fO4IchxSb6xbAwkSGLAC7DGIZjCrhu/5VeKmtLzExTnSwTKZR6DE+7YSStLIywnSWjLDweabnbyjBXwD52qsn/d2eAv+HSr0sezl1DOuW/QNv8kMknmOqNm/smN37ERiNkIH+LUAN24icpuTp4w/5AAa9AY4TkH8xM1McPYo5sIrNKQVAC6jvuLbrP8lW/GbMVxyT2fhvDuVQ/HBRP6C4XcqLyBEV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sybUwr0j00cLXTP16SIABeziLIeguouM9n3IG9Y+6g=;
 b=bj0dE9AVDmxmADV/VjXxjCIzxuW8YyfCjjX06Nn+PxQNpaDc6BmGDdWslaKCzqa39JVfbpdcOo331GRRu9P2P7W+E0DpMmApd85F6YFOu4pmUoVz8i4zgbYB7beeVP93UhJvwPVkt4hOK802OuDkqmfXuKXBfYhnTFvzHHbpanU=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AS4PR03MB8362.eurprd03.prod.outlook.com (2603:10a6:20b:511::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 18:29:50 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::5c3c:8e4f:b41a:bcb9]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::5c3c:8e4f:b41a:bcb9%4]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 18:29:50 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Denis Kenzior <denkenz@gmail.com>
CC: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>, "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>
Subject: Re: [RFC PATCH] scan: retry scan based on scan done events per wiphy,
 not wdev
Thread-Topic: [RFC PATCH] scan: retry scan based on scan done events per
 wiphy, not wdev
Thread-Index: AQHY+qocbjfpHDPo3E6UpBvkNhWfbq5DZG0AgAALZgA=
Date: Thu, 17 Nov 2022 18:29:50 +0000
Message-ID: <20221117182950.ncb7h33ngvqr5q7v@bang-olufsen.dk>
References: <20221117172901.2459224-1-alvin@pqrs.dk>
 <eead8130-e13b-e1eb-6453-e27b1d293c31@gmail.com>
In-Reply-To: <eead8130-e13b-e1eb-6453-e27b1d293c31@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AS4PR03MB8362:EE_
x-ms-office365-filtering-correlation-id: 8199b355-1e85-4baa-f139-08dac8c9b6c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HKdkxOd4+r77jgDm0aU3QZBMA9/LVFI+mUz7FqDlW7Rf3GYDKMzKuPH398z0szE5aBBxC2XMu/w6IO2DR3pnozXUCeiW/CmksmZEk/gxr71BKPk4S3bgr2mSgJIplV2rjXBSSmdIAwJYlDFtC5/6cjUnjL0IBkO3tBqc193EjpVJMtgR4chUMKVzbAippL1mxa3IADVL4qER0uhi/0fGDik0LRcaNJkemriQxP/sUwDH8y50N4Lbgp6TId4kKYAggF3tVMUEb5sHVXYXtsePgDecX2B45mdo4Wzk5lbv3hk+Va7JA9NiswZENm3AZtxAcs3+PZJNmI0obIK65KLkhdk9hGVsvQuCyIQwd5hBfNveqC5bF7zxTi3PUlH5eGt4iMVjtliNCgs9JenNmCJ5SothxCI15sz9ZYB06Lr8LsiCcZ8a7Gwra+tZ5qgw4lXgQBgMhAg+DNHJstvpZTvM+wrv3whlk6+IYGazIOPq8xaYaUy8LCt9lKzh56abZd/R7MiV+/VhbkGFOmuqGhyxoqq/30iZyrGPx2RypSQcHa5PCmWO1TfquVOELfeqC+Uiy/0AtBMJVQ27vsCEozkpfSrUj2V67RSFCLXpwJ3DeUxVhjtCNDW7wWQqhW3kIIvttiY75IInE7SHRnikW5KcqbY2KGyUwMd3D8eSeSSess7SeXyS8ff7n+y44Yna9MUcwrm976+rG8B0VEVgsjwnv1YNZHb1NQJpIMs1go/Fa2o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199015)(122000001)(86362001)(83380400001)(38100700002)(66946007)(38070700005)(8976002)(8936002)(4326008)(2906002)(64756008)(66446008)(66476007)(8676002)(5660300002)(66556008)(76116006)(26005)(53546011)(41300700001)(6506007)(6512007)(71200400001)(66574015)(186003)(1076003)(91956017)(6916009)(54906003)(2616005)(6486002)(478600001)(316002)(85202003)(85182001)(36756003)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnBwdjRDZXB0QVoybXl6QkorT0RYZ3hiNzRNVmJ4Y1VoQUFDVU5ZT1YraFNP?=
 =?utf-8?B?WFNOdmVWN0EraExsVlNwQWhjMzRFTWFjRnJKTnlWTHNFbFhnM2tNejA1NU9x?=
 =?utf-8?B?T3BaWXdYdVRxVk5JMHhpRHpTNVlOdkltYXZxUWsrbDdOdHpwZlJIc1dXVTBO?=
 =?utf-8?B?Qm1jM2pxdUp5VlhRZ2FtMzlJVUljVENlN0x2TjAvMzBYTnBDR3hJK29CZVV4?=
 =?utf-8?B?dTJvbmdtTzNhS1J4YUhRcFlpSlVJcE56Zkt1aGFIbXA4bXcwVk9uYlluaCtr?=
 =?utf-8?B?SEdhVzNtNmRWTVMzYWFZMm1BeWVZSXV0S2ZSOVpOeWNvckhrcGVCRTR0NnhH?=
 =?utf-8?B?TjErbWJTem5JLyt1OEZ5NGZ3dUkzb2FINzhId3Vwdk1LS01WZTJTQzVHdnk1?=
 =?utf-8?B?c0FrRTgzMDRjRUN4STVkZDhFb2dBdmY4dk1mdk4vN0hQa29WbEREcnZvaDFz?=
 =?utf-8?B?b200eU1CbTRxckZ0MUFlaUlRWVRDdnkxOHJXdjg1R1VTYm42Uk5qb3pXRndE?=
 =?utf-8?B?ejdQWVlZdVF0K2dRN0xBZHpsU3pZbzNZODA0bk9iVDRuU1FScHQxWEZCTUYv?=
 =?utf-8?B?TGJuUkVZK0JxQ2hWMU5LcnpzSmdGZ0FRTndVdDVtcjFnS0svd1NzSytSTnJY?=
 =?utf-8?B?VmE2Z2RqTUludjNScDQxekxxOUlLQnUrUGh3dzdnT3lmU3pkTmZqMGdEWllG?=
 =?utf-8?B?ek1HYmVHNi9sZ05sSUo0bFFPdVhtbGgxT3Q4RTVZa0ZETkorOFQ1dUJIQTZl?=
 =?utf-8?B?ZlZGM0VWbmV0QlloQmJpQlkveVJoMFdsUnFNV1YwSElIczJNS2drSFJHNk55?=
 =?utf-8?B?aVpZL0taYnNPbzM1c1dLMlVtK004eTRKbmVyRER4U1E0OWVJd3VxVkVLTUQy?=
 =?utf-8?B?Nk1QMVFPUjBDTlBuK1J2YVcvejJkVGVadWl0cjFZZ1hGSFVxRlIzWWZZU0xF?=
 =?utf-8?B?azg4WDY0UWVzOWwvbHB5U3NYNVNEMlkzY09SSTFVbTNaUTNJbkhObC9wRU1L?=
 =?utf-8?B?WmQ4SVB5SW54d1doL2xBQys3YStYcWJ6SXlhdGRxdWVWT0dEWlNEUWRVbG92?=
 =?utf-8?B?S0pURVZlQXk1VlNuWEI2MjRMSjUyWEQ4NjNWL1VySXdtVThKR3ZJY0hYWnJZ?=
 =?utf-8?B?VlFCalltS1l2UnVzZjdtK1dJZHVWQUJIaENKZXhiMVJiV1hZNGN3bk1udGw3?=
 =?utf-8?B?cDhNS1pIY1ZMdWxwMS95Mlp5c051MzB3K1N2eWNIeG9XYWFMQ3c5Z2JIOFJy?=
 =?utf-8?B?UnhFd2tkelZsbHVEUzQvMGI4eUQ3ZDlkTUlWVkdTaTFrbjdoL2xRWjYyb3BI?=
 =?utf-8?B?eXkyMHVwVjl4OTNrdFVwTXZuVG5zMFFidUdVZGZhc01mbUhHK0NPOFN3MWMv?=
 =?utf-8?B?Z3QyVDBOR3J3QzVwQWFrWkJkNmcrR3Q3VUI1ekVYeHlYb0pxV3JRT3pWeUtt?=
 =?utf-8?B?Yk00OEI5UjM5RzhJalpRaWxqZ3pueXE1cmtqWndBRWJlNGZEdFhmUXRxWlVn?=
 =?utf-8?B?aFY1d2dkWlVxL1A3SmlUOTBKTUZXYStkTENNdGgrKzRGUG5WU05vYlZ1MHZU?=
 =?utf-8?B?L0dDS2toZ29mbzkvamdmOWZVejNpVDdQQVc3WSsySUNSN1Z1eGNLR3loVkhl?=
 =?utf-8?B?R2Q4K3UvSExZcmlyRmN2enBuNE1PL0k0MTdnbW9xKzA3QUNWOFhJaWJ0Mnhy?=
 =?utf-8?B?elhkSG5hRGp3amZ0UGljMjBlMlU2bHNLYldaMHQ1c3dqamswVEVMTllrNmxJ?=
 =?utf-8?B?djRqVVN6bXh3OWJUaFk1ZTZvTWFObFNDcjRJZE5tT3hWeXIyenVGSnE0NUJt?=
 =?utf-8?B?ZzNkL1R5ZlZDblM2RVNmODlGQ29MMXZRTzhDL0xaYnBXVlhhMngvU0ZuNEs5?=
 =?utf-8?B?K3k1VUV2MjJyMjhqNUlqTUt0Y29zR1AyeVJSdmEvOFFESEwyUnlrUnpzaWtw?=
 =?utf-8?B?SW82UHRSOVgvWVdqa0N4OHRad0NKd2QvOGI3ZjBIaC9pTlJ6M0ZlcUEwMHQ2?=
 =?utf-8?B?N0RIZXJOSi9LTkZvZmF4VGRVeFJxdWRsdVhuWGpjUDlBSUthR2t3eUF0akRo?=
 =?utf-8?B?ajE4SllhNEFKeWI2QlZKRjdSOUw2ckI4KzVISVltczJaQkZvOVVPaDFZUGFX?=
 =?utf-8?B?dXYzMm1FOHRCN1UwZDlvRkh0WTVTNjdtSDJrVGJQR084RTFqRGl0TmFMZldN?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <773AD197FF13B8469A675F4AEEEA69E3@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8199b355-1e85-4baa-f139-08dac8c9b6c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 18:29:50.5866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UkAWxv9GuaCX1vM201jOVV58kgLtdHVdHfOnoBzqzYGCaNzkHPohwNet3GeR3IAUVOwHzgjcMJoIiPNqkO6ygw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8362

SGkgRGVuaXMsDQoNCk9uIFRodSwgTm92IDE3LCAyMDIyIGF0IDExOjQ5OjAyQU0gLTA2MDAsIERl
bmlzIEtlbnppb3Igd3JvdGU6DQo+IEhpIEFsdmluLA0KPiANCj4gT24gMTEvMTcvMjIgMTE6Mjks
IEFsdmluIMWgaXByYWdhIHdyb3RlOg0KPiA+IEZyb206IEFsdmluIMWgaXByYWdhIDxhbHNpQGJh
bmctb2x1ZnNlbi5kaz4NCj4gPiANCj4gPiAtLS0NCj4gPiAgIHNyYy9zY2FuLmMgfCA0NyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvc3JjL3NjYW4uYyBiL3NyYy9zY2FuLmMNCj4gPiBpbmRleCA1NTQ4OTE0YTEyZGUu
LmMzNzYzZWU0MTE3MyAxMDA2NDQNCj4gPiAtLS0gYS9zcmMvc2Nhbi5jDQo+ID4gKysrIGIvc3Jj
L3NjYW4uYw0KPiANCj4gPHNuaXA+DQo+IA0KPiA+IEBAIC0yMzEsNiArMjQ3LDcgQEAgc3RhdGlj
IHZvaWQgc2Nhbl9yZXF1ZXN0X3RyaWdnZXJlZChzdHJ1Y3QgbF9nZW5sX21zZyAqbXNnLCB2b2lk
ICp1c2VyZGF0YSkNCj4gPiAgIAlpZiAoZXJyIDwgMCkgew0KPiA+ICAgCQkvKiBTY2FuIGluIHBy
b2dyZXNzLCBhc3N1bWUgYW5vdGhlciBzY2FuIGlzIHJ1bm5pbmcgKi8NCj4gPiAgIAkJaWYgKGVy
ciA9PSAtRUJVU1kpIHsNCj4gPiArCQkJbF9kZWJ1ZygiWFhYIGJ1c3kiKTsNCj4gDQo+IFRoaXMg
bWlnaHQgbmVlZCBhIG5pY2VyIG1lc3NhZ2UNCg0KU3VyZSwgaXQgd2FzIGp1c3QgYW4gUkZDIHBh
dGNoLiBJJ2xsIHNlbmQgYSBwcm9wZXIgcGF0Y2ggdy8gY29tbWl0DQptZXNzYWdlIGxhdGVyIDop
DQoNCj4gDQo+ID4gICAJCQlzYy0+c3RhdGUgPSBTQ0FOX1NUQVRFX1BBU1NJVkU7DQo+ID4gICAJ
CQlyZXR1cm47DQo+ID4gICAJCX0NCj4gPiBAQCAtMjA0NCw2ICsyMDYxLDI5IEBAIHN0YXRpYyB2
b2lkIHNjYW5fcGFyc2VfcmVzdWx0X2ZyZXF1ZW5jaWVzKHN0cnVjdCBsX2dlbmxfbXNnICptc2cs
DQo+ID4gICAJfQ0KPiA+ICAgfQ0KPiA+ICtzdGF0aWMgdm9pZCBzY2FuX3JldHJ5X3BlbmRpbmco
dWludDMyX3Qgd2lwaHlfaWQpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBzY2FuX2NvbnRleHQgKnNj
ID0gbF9xdWV1ZV9maW5kKHNjYW5fY29udGV4dHMsDQo+ID4gKwkJCQkJICAgICAgIHNjYW5fY29u
dGV4dF9tYXRjaF9yZXRyeSwNCj4gPiArCQkJCQkgICAgICAgJndpcGh5X2lkKTsNCj4gPiArCXN0
cnVjdCBzY2FuX3JlcXVlc3QgKnNyOw0KPiA+ICsNCj4gPiArCWxfZGVidWcoIiIpOw0KPiA+ICsN
Cj4gPiArCWlmICghc2MpDQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsNCj4gPiArCXNyID0gbF9xdWV1
ZV9wZWVrX2hlYWQoc2MtPnJlcXVlc3RzKTsNCj4gPiArDQo+ID4gKwlpZiAoTF9XQVJOX09OKCFz
cikpDQo+ID4gKwkJcmV0dXJuOw0KPiANCj4gQWxzbyB5b3UgY291bGQgc2ltcGxpZnkgb3V0IHRo
ZSBuZWVkIGZvciB0aGlzIExfV0FSTl9PTiBieSB1c2luZw0KPiBsX3F1ZXVlX2dldF9lbnRyaWVz
KCkgc3R5bGUgZm9yIGxvb3Agb24gdGhlIHNjYW5fY29udGV4dChzKSBpbnN0ZWFkIG9mIHVzaW5n
DQo+IGxfcXVldWVfZmluZC4gIEJ1dCB0aGF0J3MganVzdCBtZSBuaXRwaWNraW5nLg0KDQpBbHJp
Z2h0LCBJJ2xsIHRyeSBhbmQgaW1wcm92ZSBpdCBiZWZvcmUgc2VuZGluZyBhZ2Fpbi4NCg0KPiAN
Cj4gPiArDQo+ID4gKwlsX2RlYnVnKCJYWFggcmV0cnkgcGVuZGluZyByZXF1ZXN0Iik7DQo+ID4g
Kw0KPiA+ICsJc2MtPnN0YXRlID0gU0NBTl9TVEFURV9OT1RfUlVOTklORzsNCj4gPiArCXN0YXJ0
X25leHRfc2Nhbl9yZXF1ZXN0KCZzci0+d29yayk7DQo+ID4gK30NCj4gPiArDQo+IA0KPiBPdGhl
cndpc2UgdGhpcyBsb29rcyBmaW5lIHRvIG1lLiAgRG9lcyBpdCB3b3JrPw0KDQpZZXMhDQoNClRo
YW5rcyBmb3IgdGhlIHF1aWNrIHJldmlldyENCg0KS2luZCByZWdhcmRzLA0KQWx2aW4=
