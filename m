Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2126.outbound.protection.outlook.com [40.107.20.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595CE6FC6
	for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 20:18:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVhUAf4VSPjn2ma05U+vgYYD5ykQs0W219W5nSYv6KIUHfzV04tNM/1VMB8dAxtdJiDgK+Z/+0JFLrJRbErzmsBQHI3SA+5YD3SI3lQA1oXMcz/U9QYPoJwMPZ3vv//H/1ESW3jRYvRcAZMfJc6zUDcKhjON98A5CeEAu4xg0JLgwwg4OoLL5z1p+V5WtrLP15C6R61TOU5Ot7ly43jG9G3vBgExtu4X8GTLuUFeF51GfDg+oybdGxorUbPbHI2GTIABc72acYUEt5D45q773T/pVr4JBkqJmy3PLJUmujI+FTekaYV4vTTeATuo+oCeMsId952BETX78Ok49AOr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lg/BiPtuvUvi0GxVn2IqxE/KgJJdI3xTuKkO/PeqXOA=;
 b=MvxTi+Td71ypInu+B49N+wg9I9qQcGSGAMBQkuZsM+CxyhWHW/n8ALWyzabZwEcnCSgE1WppkceYc8cwUzU1MRGV4hWam+TtgjcsRmflsjQ+hJNTVgnkPcRNjGYztDXBxDDQFbnvIZyMBQU5XjddZB6vZGaz/2OU9BRORaeQag1RRB/D4jVfoxYfgu5yOVMBO6uonon4RP6VVubwnHy3TuS9owPgoSLbIxVROQVbAC0pdV7lyyU9UnBTwkF1EXYOKxLz9jUwEF9lely6C3n/eQhLH0+5hPcnVjpb1TwwThmqIy3nnh77puMwsy5MtEB0vZwBpPOrh1uHwovMxwCM6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lg/BiPtuvUvi0GxVn2IqxE/KgJJdI3xTuKkO/PeqXOA=;
 b=JUvtR03aIZ/o4Sm69j/kUIxshIWd8fackuqDKGkmxHi15ZXyELU8gUpfuWtjEZOK7M8XKWcJmvJLn89HikqJGhGRePc4LcPw8bJ9rY71I98v316sF5gHp8uRK6OzukVtyw/QSGuFt4K9KRx6RZWJSSV+Dpz6mDPOQ7u/gJ8LCxA=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by PAVPR03MB9679.eurprd03.prod.outlook.com (2603:10a6:102:316::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 12 Dec
 2022 20:18:16 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::ab9f:b966:bfb6:b71e]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::ab9f:b966:bfb6:b71e%7]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 20:18:16 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Denis Kenzior <denkenz@gmail.com>
CC: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>, "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>
Subject: Re: [PATCH] Revert "scan: Don't callback on SCAN_ABORTED"
Thread-Topic: [PATCH] Revert "scan: Don't callback on SCAN_ABORTED"
Thread-Index: AQHZDkjJMlvPfXpGH0mqYv6XxbthXK5qpteAgAAKUoA=
Date: Mon, 12 Dec 2022 20:18:16 +0000
Message-ID: <20221212201815.6rma2xhoam2yja4c@bang-olufsen.dk>
References: <20221212164250.3075444-1-alvin@pqrs.dk>
 <3fb7f5f1-04d8-8631-e7b5-70f27c963ac1@gmail.com>
In-Reply-To: <3fb7f5f1-04d8-8631-e7b5-70f27c963ac1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|PAVPR03MB9679:EE_
x-ms-office365-filtering-correlation-id: af487eca-8299-48fb-f040-08dadc7e00b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZxCGstlabT1ZnWFsd8slogKa3odpyr7SgYoiLUEYNgPC/CNwahXecomNwwMrmaMEDZG15QYSZ8SX7uqrkFVogQamMNKtG8mykU7t+CV+V+AjgR6BmAJ1N+GmwS0SN3tJ8SBeSrJFbxDwBgNGJipd326TYJxAmatsv6f0T8XBY1ElWfJrWsnG/Pa/vDm+XyXf9nQXA8WdGVRX8/fWWu+nP33vG0Wj+Bf+qV65R8Uo1g/GJx0iSnOf0l/TJtRHfyIzTUd99XgGQVXUGNdyHdY50aaAQY/PrFJDFlsB/CvX6YPNkxFgNwCFLuI8oUb4qTxfTJs+lBpBwRKkMskC8kRP+bS4Yuu6ZO3UbJMktlekXd8vH0hVqxXivB0gvgThGcwy+PJH+3WtHRN9WPkRhQxtCV7fzkZk1iZzmGL4qzWU6aJDBeKwC2vJPT04+Kpf7NZq1Rz1k7WtUY315A7dBlRa4DjCsTJFTldwsn2ao6l5QbBDNTIWd6kNJpDAzg+POTjslpbLOVVdbngEceGIQ04AztQxWOwu+obNRPswsMt0BTO4LSUsL5sg7mRz711li/7z6HuQrHk3DfhmqGX4zusb4adPb2Gg9Wj50cihC68L0PrvJ5KMwp27NnR1AwDwh+WLjSxDZOK8jeQifrfT1Fas0uA+C6AI4C50ejNBvLeHSAxmb2ggOPCZ+TQfeL7oyVRhBf+OfoiN20j+w0woQuusRA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199015)(38100700002)(122000001)(86362001)(5660300002)(2906002)(38070700005)(478600001)(71200400001)(6486002)(41300700001)(91956017)(66446008)(6916009)(54906003)(8676002)(66556008)(66476007)(76116006)(64756008)(316002)(83380400001)(4326008)(66574015)(186003)(6506007)(8936002)(26005)(8976002)(6512007)(2616005)(66946007)(1076003)(53546011)(36756003)(85182001)(85202003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blphcnNhZXUxazYrS3lNNldiUVgwdE90bHd3cmUvR25QeDhQR21xRzVmSTFm?=
 =?utf-8?B?RWhxUmR3MWNwNVA0aE5NNWFuUDdsclBtOFV5a1Q1MWFpTmtvSUtzdE8yd1Vh?=
 =?utf-8?B?Yi82eE1NTEV1eWRaWVBaS05uM0NkSUw4dCt3UElBSWF2M0pKQ0plQ1pxN1ZB?=
 =?utf-8?B?ZXpRSDk2Q01IbFcxbDFTbmhwUytoeXZPZGhMR0NxY0ljR2VtdDZNcUh2eDZE?=
 =?utf-8?B?MDBIUVRaN1RTZWVBbS95TWtndGpSSXQ5bzFNL3NTSmJ6TGtjeHMydHdrSTQ5?=
 =?utf-8?B?Nks3eUNoTTNEZmtvVDZUUGtpa0xQOXBaakViOHE4ZEdyclByMm1uK3Vjd0M0?=
 =?utf-8?B?ak5UWkFOWmtydGIrbzVibEhuTXpoMklRMXc2RzQ3eUJhWmIrUlNhZXBEZ2Iw?=
 =?utf-8?B?ZW1vcVhIYVAzNVc5VDRHeFppWFRObkFqRHEzTks4TFpWU2lsd0huUlNUNkh4?=
 =?utf-8?B?Vlk5cWg4VW5pTGhCRTJJRU1na1JHMVNmcVRiMGo5QTVkYU8yVVU4a3p5a3Va?=
 =?utf-8?B?OGh4WmJyOWRYM1ljTjljOEVhVitaVmNBdTJSdDlNWHlwRVhpRFRxSjh0NmFx?=
 =?utf-8?B?OEpQYjRsZExHZExhbVI0L292ZHBZaWh6NHp3bThDMU5oS0t5T3RwSmhCSS9W?=
 =?utf-8?B?MDdkb1B6R2FaV0NSQnBXbDljbkxZSHB0TzlpL3JvN3I3dG04NmU3OUNsak1r?=
 =?utf-8?B?WVluVytlV081YU1UQVRxRTFhUXhlNWxMNVNZdDhobXVxVTdwV2puRVRIVFFx?=
 =?utf-8?B?dFZMVVFBS0FBQXovZjlidWVGb2JJU3hjWk1NRGFzcVZ2RWRaL1ZLOUlyZ0pU?=
 =?utf-8?B?ZVFlKzVrQnJlSmpCY21CZmNQdHY1WU9FMDRLem9YSFRmbDNXcWxsak40WFJr?=
 =?utf-8?B?TWtoWk9ZOUJ1MnRFUVNHbzdFQ3hVbk1rV1QvWVE1REkybk91NDhqcUU3dG50?=
 =?utf-8?B?MHVJT1NBNnNSTHJTSm1iQmI2THpncU5DUU0xVHRzQUVqR3pLTVByaTM3eFVW?=
 =?utf-8?B?ZDBDQndvZm40bTNMVyt0L3B5dUZ2OFVEMlZhLy9hUEVJNWhiNmNBbHBOckxq?=
 =?utf-8?B?b3ByWXZ0Q1FNRFgwUHNOS3NYdGRtZ3QyRnI0b0VTQjA0cEk4NEVwaWZ6dm1s?=
 =?utf-8?B?UUJsb3BnVHpJV05IUlJlczBlUG00MzZQOUlGV25COG9xWUlFV1JPRWtHQ3Mx?=
 =?utf-8?B?NGtTd3QzQkZNMmhsbHQyWnJqNkxGNEZJMkhwakZpWG0rZ000UlFDc0ttcHhi?=
 =?utf-8?B?VGR6TUwyT1pxa2FKSVI2NGM2QWJudHY0RWROL3BjV21yaDlLMTdFanRsK0o0?=
 =?utf-8?B?ZEdybUt2bk5uemNDenBMcUNRZjF6N2ViZzNLRXA4aUdjcmZmUmpWLzZkbkNE?=
 =?utf-8?B?ZjM1VmhZYWRrUkNPeDV0L3hid1dhMys3ZE9mb3hZYjZ6ZmtQMWVqSHdGRld0?=
 =?utf-8?B?Q0VVdXFHVVdTT1FqNGtubUtMMnVqWFdPZm91SzdHSURTVkdzZGE4RFVaQXp2?=
 =?utf-8?B?UG95MXBMUldITVNobGFTUko3NUtpSG9KbmlHWEV4K21TWkZKWlBQOTI1RWQr?=
 =?utf-8?B?THJFbVNzaXJoN1RPUW5SaTdkM3pqWmsxalJCMXZXTm9ENEt1ZStEL0ZaZ2l3?=
 =?utf-8?B?Nkw0aWdHU0c2VENtNFRySjE0S2pYM1ZpSmQ0QVBKM3BCNDlraG9oVXNldUVs?=
 =?utf-8?B?WTZ3dkZvaTNoZFhCL0gxK1ovSUo5Lzl5NmtPcDBBbGYvdlFoTmhaVVpybmtz?=
 =?utf-8?B?S2x3WnpVdzZ3YzROUG1SMTF1MzFJaUpYa0hidXA5VzBJQ3BJMXVaYmlBZkV4?=
 =?utf-8?B?QVlLRklWc0NNNDE0a0FsYUY2VU1mRHZNekRudUdRVVg2Rms3RVNTYVQ3Mm5Z?=
 =?utf-8?B?eGtCc0EzMXkxWE4xRVkyanc2ejFieVRUL3BsNkkxTFY0NFRUMmFxWm1rR2Nu?=
 =?utf-8?B?RllncldtaElkYmpBdW9pREFveW54Qmp5VzlZaEtldjJDWEtNZ09jSkx6dVpR?=
 =?utf-8?B?R3QyNFlJYmpocmUyeWNCSXU3VzhSUEVkdnBFVEFRb1I2UFZ4NmQ0VWRadExJ?=
 =?utf-8?B?RHRiQ25mb0Yyc3FYdFZmcDhyMStFRGlJME5ORlBsN3BzelY3K21SYTkyOGhY?=
 =?utf-8?B?MC9aN3A3dnJacWhNMC9GZFBUZFpzK2F6NVM4alZvSm5DcEN1bS9pMHlmSEhs?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1610E803304024CB852EAE667F2179C@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: af487eca-8299-48fb-f040-08dadc7e00b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 20:18:16.1831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YD1mhTsKHSZPWI8QwXgizJsO3enVQviSogs7QeInbv6j0YMS/gPZdXGJHMfUi04viFNVOe/96heydrjpcdbGzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9679

SGkgRGVuaXMsDQoNCk9uIE1vbiwgRGVjIDEyLCAyMDIyIGF0IDAxOjQxOjE5UE0gLTA2MDAsIERl
bmlzIEtlbnppb3Igd3JvdGU6DQo+IEhpIEFsdmluLA0KPiANCj4gT24gMTIvMTIvMjIgMTA6NDIs
IEFsdmluIMWgaXByYWdhIHdyb3RlOg0KPiA+IEZyb206IEFsdmluIMWgaXByYWdhIDxhbHNpQGJh
bmctb2x1ZnNlbi5kaz4NCj4gPiANCj4gPiBUaGlzIHJldmVydHMgY29tbWl0IDYwNTFhMTQ5NTIy
N2JiZTdiYTM1N2Y2OTk1ZDRkYmU0YTQ4NjIzMzEuDQo+ID4gDQo+ID4gVGhlIGJsYW1lZCBjb21t
aXQgYXJndWVzIHRoYXQgdGhlIHBlcmlvZGljIHNjYW4gY2FsbGJhY2sgZG9lc24ndCBkbw0KPiA+
IGFueXRoaW5nIHVzZWZ1bCBpbiB0aGUgZXZlbnQgb2YgYW4gYWJvcnRlZCBzY2FuLCBidXQgdGhp
cyBpcyBub3QNCj4gPiBlbnRpcmVseSB0cnVlLiBJbiBwYXJ0aWN1bGFyLCB0aGUgY2FsbGJhY2sg
aXMgcmVzcG9uc2libGUgZm9yIHJlc2V0dGluZw0KPiA+IHRoZSBzdGF0aW9uIHNjYW5uaW5nIHN0
YXRlIHRvIGZhbHNlLiBGYWlsdXJlIHRvIGRvIHNvIG1lYW5zIHRoYXQgdGhlDQo+IA0KPiBIbW0u
Li4gVGhlIGNhbGxiYWNrIHNpbXBseSBmbGlwcyB0aGUgc3RhdGlvbi0+c2Nhbm5pbmcgdmFyaWFi
bGUgb24gYW5kIG9mZi4NCj4gSSdkIHByb2JhYmx5IHByZWZlciBqdXN0IGNhbGxpbmcgc2Nhbl9m
aW5pc2hlZCBpbnN0ZWFkIG9mIGEgZnVsbC1vbiByZXZlcnQuDQoNCkkgY2FuIHNlbmQgdjIgd2l0
aCBhIG1vcmUgZXhwbGljaXQgdGl0bGUgdGhhbiBqdXN0IHJldmVydD8gU2VlIGJlbG93IGFuZA0K
dGVsbCBtZSB5b3VyIHByZWZlcmVuY2UuDQoNCj4gQnV0Li4uDQo+IA0KPiA+IHN0YXRpb24gc2Nh
bm5pbmcgc3RhdGUgcmVtYWlucyB0cnVlIGluZGVmaW5pdGVseSBpZiBhIHBlcmlvZGljIHNjYW4g
aXMNCj4gPiBhYm9ydGVkLCBhbmQgbm8gZnVydGhlciBwZXJpb2RpYyBzY2FucyBjYW4gYmUgcGVy
Zm9ybWVkIGJ5IGl3ZC4NCj4gDQo+IEkgZG9uJ3Qgc2VlIGhvdyB0aGUgc3RhdGlvbi0+c2Nhbm5p
bmcgYmVpbmcgYWx3YXlzICd0cnVlJyB3b3VsZCBwcmV2ZW50IHVzDQo+IHN0YXJ0aW5nIGEgbmV3
IHNjYW4/ICBzdGF0aW9uLT5zY2FubmluZyBpc24ndCB1c2VkIGFueXdoZXJlIGJlc2lkZXMNCj4g
cmVwb3J0aW5nIG92ZXIgRC1CdXM/ICBNYXliZSBJJ20gbWlzc2luZyBzb21ldGhpbmc/DQoNCk5v
LCB5b3UgYXJlIHF1aXRlIHJpZ2h0LiBJdCB3YXMgYSBtaXN1bmRlcnN0YW5kaW5nIG9uIG15IHBh
cnQgZHVlIHRvDQpuZXN0ZWQgY2FsbGJhY2tzIChzY2FuIGNhbGxiYWNrLCBhbmQgcGVyaW9kaWMg
c2NhbiBjYWxsYmFjaykuDQoNClRoZSByZWFzb24gcGVyaW9kaWMgc2NhbnMgZ2V0IHN0dWNrIGlz
IGJlY2F1c2UgdGhlIHNjYW4gY2FsbGJhY2ssDQpzY2FuX3BlcmlvZGljX25vdGlmeSgpLCBkb2Vz
bid0IGdldCBjYWxsZWQuIFNvIGl0IGRvZXNuJ3QgcmVhcm0gdGhlDQpwZXJpb2RpYyBzY2FuIHRp
bWVyLg0KDQpCdXQgb3V0d2FyZGx5IC0gdGhhdCBpcywgd2l0aCAnaXdjdGwgc3RhdGlvbiB3bGFu
MCBzaG93JyAtIG9uZSBjYW4gc2VlDQp0aGF0IHNvbWV0aGluZyBpcyB3cm9uZywgYW5kIHRoYXQn
cyBiZWNhdXNlIHRoZSBwZXJpb2RpYyBzY2FuIGNhbGxiYWNrLA0KbmV3X3NjYW5fcmVzdWx0cygp
LCBkb2Vzbid0IHJlc2V0IHRoZSBzdGF0aW9uIHNjYW5uaW5nIHN0YXRlIHRvDQpmYWxzZS4gQXMg
eW91IHBvaW50IG91dCB0aG91Z2gsIHRoaXMgaXMganVzdCBjb3NtZXRpYy4NCg0KS2luZCByZWdh
cmRzLA0KQWx2aW4=
