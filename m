Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2111.outbound.protection.outlook.com [40.107.8.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603C21EB29
	for <iwd@lists.linux.dev>; Sat, 25 Nov 2023 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="S68YPs2w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZm4TXtKg9d4hF3CX4iIPR6WYYgbxzAWbhpajqUn4u0Rv//fkUPzcWqNiwNIi84SgZVogoke9ixqyPANmuPJtyowbHgi+F/7pAbPmK4bhYbRksKnA0cwhLBDgpv4ywl1lkbMe5340NnPauGweE6gjyRW8IOry7o08Y3kBvApxEj6ZnUW9qp1upEbLPvA+9Jc/B/UdWrbrStMlzoWrQtchzOAZkXsCMmXAeXQLT/496bEHxbCogGIEVyIyC6dARx3+ZwqrL/0HX/dAa3n/ofncdvfhSeJJx6wUnUn30lYKVfszBYy4brMGpCkawQG3WyFsZPt7sPzhQ7d8CpdQ9642w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlhfvgo1SXNvzXJtK2g9yfIaHTaRuAwFTYTLSJqC0N0=;
 b=Aled6hC4xpEPgGeidF0WMVso3+LWTGDHs+hgCA5EKAraT6KeTr2HskYncn0C8r5UHaLQXab7LpkMGaGgpY3DyTcG94indNMCLJRhCukxhUnSQeIlNKxLOcSPuHgA0kzJHegzU2FXtKPoqh74d2ClUTrNsiUER/0PYXcyzh1IRMo2mJeYwg6gWRvyn0Ydh+STAobdATD/ViVOFhcQR9g08+KsD4SNljVpO0VSQH3Pp/bcLuQfXls57lmHEssotFaxgZ3QJWddvHgpzaYdrtdoLS7wZ5LWYVXGqCWvcbq/CyACziagBFsVLLNNaCvRR/pAm/4NzXWaOi/mFc/FIK4yPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlhfvgo1SXNvzXJtK2g9yfIaHTaRuAwFTYTLSJqC0N0=;
 b=S68YPs2wWutzTAvMSIsQwTXtA/JIyRgb5vUjLX4n686M1lE3ZSOszVU/GS5CS6593nOF+BnGdWc6PTMDCP0KK8cugB/n5ZzIhO8ZnrIvu3ikIspnpLjGELfrBS+qRiKzXo9Qhb2j0UwHY/7XYnxFi+s+nV+x7LBHHYtQolFg3Sc=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by DB4PR03MB8756.eurprd03.prod.outlook.com (2603:10a6:10:378::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.25; Sat, 25 Nov
 2023 20:57:27 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.7025.022; Sat, 25 Nov 2023
 20:57:27 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Denis Kenzior <denkenz@gmail.com>
CC: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Re: [PATCH 11/11] netdev: disambiguate between disconnection types
Thread-Topic: [PATCH 11/11] netdev: disambiguate between disconnection types
Thread-Index: AQHaHtCQ8mPlwNZhx0G5Y3dJHjFyK7CJqBgAgAHeRAA=
Date: Sat, 25 Nov 2023 20:57:26 +0000
Message-ID: <bmsflmybfnfjdnbkvjkk3rforvhmjitapyotzzwtl2wo6wlpfh@fj5cj5ixicpu>
References: <20231114171455.1108856-1-denkenz@gmail.com>
 <20231114171455.1108856-11-denkenz@gmail.com>
 <z6bw5z4aptq4fq73ercwhrp76wpz6ihtlzrst2kmfqjoru42y6@v5e5za2r23lb>
 <f25e7bcb-3990-4d72-b51d-b197f8c40a64@gmail.com>
In-Reply-To: <f25e7bcb-3990-4d72-b51d-b197f8c40a64@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|DB4PR03MB8756:EE_
x-ms-office365-filtering-correlation-id: 5ad7075d-a793-4c07-2f6a-08dbedf921b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 s8qHI46unjuR5eQUsSr0BvtOmU/25XepTHw0jXvlmwvyp7RU2lYeusipFfoERrC4QQp46+sT0jF/o6YsXukcTRsY06B2u6BNPWVHEo0BNwjqMrr3uSPPHdjTkw3z0IK0iA7IS1OYWGSTU5C3rpDUpcXO1BUou6ixKkleoyx9+SGr0/ZxgTRZMC4hCYbr2YDkZM+EkPZnl9WL2UctLLVxYhKK0xYlh2pz7LegxhlcBhsZUMz4v+t3cwQtZtBCkGXTLRlToF+mpIClflsBgo8wrJohN9Vz/M0yVXXnDkegjuIpOUxdaEhu0KDxgJ0R0YrCRubMHlk656wFRbWFPXwzxEm2UjdmRH5CT/sKwuTAsVX5kvwfUTt54mcLKvrgx+5DIYLFgIWsv2RNwu/KLqKpg4rjpcima6r4svpH1CqLb19RypPU5b0uBqbh2MLSh+3Gw5cFcemAR8WgTGFuNjpvjHhmxtJmXcbVWCqEolM/zb3bUN0pioJweJa99AR53+rhZCLt19I2uC1QcRLmqJajBDOpybvJff9JDgJWRPxsBBiyl5UR4cxXDPtg5n0Wyq+JTsn9aHx4CVHWee83xBx4WgQdvZXovclyq/Qmw7uDdfqhAY03IFw1YUaoB+w9pHIH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(396003)(39840400004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6916009)(316002)(91956017)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(478600001)(6486002)(71200400001)(5660300002)(38070700009)(85202003)(41300700001)(85182001)(4744005)(33716001)(2906002)(4326008)(8676002)(8936002)(86362001)(38100700002)(26005)(122000001)(6506007)(9686003)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnM2RksrWVZUamVyZFh0Y0N3NE54SWtHTnpqY05oaW9UcG8xOEdlNExqSFpt?=
 =?utf-8?B?SS9jTmhPd3RJV3FiNlFTZFJVSUxjQytESk9NRG93OFhRbE5xQlpFa2M4bC9x?=
 =?utf-8?B?ajM1YisvYkNaZjMzK1h5S0xnUmVJU2Jid2Zyc3YxRHZyRXp4V1FOVlp0cFo3?=
 =?utf-8?B?YTR5MEtWQ1BrZ2F4VXZqYktGZWE4NEMyVW53RmVCWkUrVFRQdjgxNWw3SVRa?=
 =?utf-8?B?K0FhdWlBck5JYXdBbmJuQ2xJbGIzOG9UZ05BR290cFQxYTk5dE4ycTFBWmdo?=
 =?utf-8?B?SUhwK2YwRnRRb1ZaODVFajBTZTM2WWhIMEFFTTV6WGN0VWlIUjI0Rm5RbUdF?=
 =?utf-8?B?NXBjZ1Qyem9vaEF6MWp0eFpKN2lMOFZUaWh3UEUzMEd3L2JDMFRvb2JPQ0VF?=
 =?utf-8?B?UjdUWWw5eXZyZjJEUjlHTnhsdU1iNUk1OVU4NWcxb1lsRGxPVGtMV2ZCYUYv?=
 =?utf-8?B?ZG5VSDYwRS9McWpYb25zdzJ6SWJybmJjZTFkOXErc3ZJeVA5YXg1RTFuclF3?=
 =?utf-8?B?R21QT0dDeGxyVElJSjVxcW80NVI0ZDhuQXN3bFEvMjdFYitrWUFLd2lDblRJ?=
 =?utf-8?B?V0lJbjhpRE9YeXgzcDFZU2tGVWxqbmxUTUhhNCs4UkwrRjJSN2kxVHdwNkEv?=
 =?utf-8?B?c0FqRjRkOHlYTGtxUFJRSHZ6NldsaDE4NWdvdHhSUXh6VXhkY3pkdms3bFlJ?=
 =?utf-8?B?VHNKVE1wMGZZTU9RZFlwd2oxZnYydVJKSnFOT1piai9UNGh0OFFzZ0tPM2g0?=
 =?utf-8?B?VUUvWEZCTDZqSzVnc2RUNEh5WVpaK3Bvdm81TG5CQ3V2V0lueGhBdDE0RTU2?=
 =?utf-8?B?eE5Hc2JzZVJCci9YNjl3UjZ2V3R6ZDV3TWlwR082NTh5UXo0bllxU3lHNXEz?=
 =?utf-8?B?ZENYV21NUU04SkJSZmJYS2JWTTJtdzhjcGM3MjNacGZZeDJwWXUvVnNsbkE2?=
 =?utf-8?B?cGZPOWlhMVJ1MFk3cW9rSUkva3B4dlBKSVV4UktkSkNkdlVhOUpyaEZQWDJq?=
 =?utf-8?B?eWNxWDY4TmtYNTRrb0h3bzVUYVNzdWhlSjVuL1M2RkhpaktNcnNmRW1MTWtC?=
 =?utf-8?B?RHU0VjZvQ1hSQ1c2bkswK0U1Zm1xUXNES3c5ZHpWT0kzK2RPK1B0ckF1WVEy?=
 =?utf-8?B?Z1Y1d0hGZW9PdzMrNkZuM2Fmd25UMXEreThPWDhFeXRKSWM2Wlo0Zko5Yzdq?=
 =?utf-8?B?eURsdlRwb2NxbWJXMVUzMkYveGlMcVFMMEFudTRHN3UrSFVsaWU4T1l5QUtI?=
 =?utf-8?B?SzZMWXVkZFVCTkVLUnZSaXdRdzdGek9iL1VhQ2MxNll6a3UzZHpuTGFJV25W?=
 =?utf-8?B?bTdEMjhzR205ZTV1RHdzemd6Y05sbTdBR0JTKzB6aHdDaHprQ3h6elduTHpO?=
 =?utf-8?B?LytNOGYyVjJGYUM0c2J2WnhKejlJQU1sTFhGVzZLT1diazUwVVI2ZjlnOXls?=
 =?utf-8?B?UnhpMG54SDdxa01oajJ6NmpuTGFIWjRZWmRiNFk2T0htZ3dYbndGNk5Vamtl?=
 =?utf-8?B?aHgrNzk1Nm45UzdPOXpUQWdhT2treUc4RHg5czRsRTE0c2I4TTB2b3Z0OEFI?=
 =?utf-8?B?QlRpYk5nRmVrV0JISFFlRWJncDdrem5UVktwWHQ2MFZrZjBpNXdCbERNaTB6?=
 =?utf-8?B?VlpTdmp3VGxndEcvU1JtWEp1bGlkOGg3akVhT2ZGcldzeDFzTWk1NDUrNVR6?=
 =?utf-8?B?RmN0bnJ2VitqK1NLOE94L29DcHBic3krdGZOTnFOMWN6dFVCMG5tOXBxK3RR?=
 =?utf-8?B?c1dZS2RKM3paZmxLNGdNSTYrM1pNY0swOTA2aUFQQkI4RVpMajVxZnl5VGJy?=
 =?utf-8?B?TjBsWDBJWVIvM3J4Yzh4Nzh6MWQzK29jcXV2WVpKVmY0VkdYZVdFWk5lZko4?=
 =?utf-8?B?TXNqYm84OVB3TVVzTXc1RGVLR0RkSDZPYk5YNXpmTW5zdnV4VWpSL2w3VnYy?=
 =?utf-8?B?RzcybW81cHdxYkUwVWFjb2t0QndaUmtTdEt3bHg2QmRGeFpyRTNBYzdFY1hk?=
 =?utf-8?B?VllpYkZBZVM4cGtnNmZqb1Q4Y1E4K0E1ZDBSR0R3L2N4SEJIUExzMlovbWsw?=
 =?utf-8?B?TEZvekVEN2NpeC92TFFXRW9WVUVKTmpuOUMrWjVORU5aaExyVURqN2Z6bEhP?=
 =?utf-8?Q?p4cVejmld1iSl8CSXAlOeiyFo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A2A6EE297F9EA43ABCB70847E1051A0@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad7075d-a793-4c07-2f6a-08dbedf921b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2023 20:57:27.1346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R57qBo6jJJOZC/ii7WIXPdBrNGCjs0s2cbPi9ZC1IIDee/w59qzZLTYt/OBGUaXu91cUZrJIdyWmMQSZo5zI1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB8756

SGkgRGVuaXMsDQoNCk9uIEZyaSwgTm92IDI0LCAyMDIzIGF0IDEwOjI1OjQwQU0gLTA2MDAsIERl
bmlzIEtlbnppb3Igd3JvdGU6DQo+IEhpIEFsdmluLA0KPiANCj4gPiA+IERpc3Rpbmd1aXNoIGJl
dHdlZW4gMSBhbmQgMi8zIGJ5IGhhdmluZyB0aGUgZGlzY29ubmVjdCBwcm9jZWR1cmUgdGFrZQ0K
PiA+ID4gZGlmZmVyZW50IHBhdGhzLiAgRm9yIG5vdyB0aGVyZSBhcmUgbm8gZnVuY3Rpb25hbCBj
aGFuZ2VzIHNpbmNlIGFsbA0KPiA+ID4gcGF0aHMgZW5kIHVwIGluIG5ldGRldl9jb25uZWN0X2Zh
aWxlZCgpLCBidXQgdGhpcyB3aWxsIGNoYW5nZSBpbiB0aGUNCj4gPiA+IGZ1dHVyZS4NCj4gPiAN
Cj4gPiBTb3JyeSBmb3Igbm90IGZvbGxvd2luZyB1cCBvbiB0aGUgaXNzdWUgSSByYWlzZWQgdGhl
IG90aGVyIHdlZWsuIEkgYW0NCj4gPiBjYXRjaGluZyB1cCB3aXRoIHRoZSBtYWlsaW5nIGxpc3Qg
bm93IGFuZCBzZWUgdGhpcyBwYXRjaC4gQW0gSSByaWdodCB0bw0KPiA+IGFzc3VtZSB0aGlzIGlz
IHNvbWUgcHJlcGVyYXRvcnkgd29yayBmb3Igc29sdmluZyB0aGUgaXNzdWUgSSBpZGVudGlmaWVk
Pw0KPiANCj4gWWVwLiAgSSBnb3Qgc2lkZS10cmFja2VkIGJ5IHNvbWUgb0Zvbm8gd29yaywgc28g
ZG9uJ3QgaGF2ZSBhIGZpeCBmb3IgeW91cg0KPiBwYXJ0aWN1bGFyIHByb2JsZW0geWV0Lg0KDQpH
cmVhdCwgdGhhbmtzIGEgbG90IGZvciBmb2xsb3dpbmcgdXAgb24gdGhpcy4gU29ycnkgdGhhdCBJ
IGRpZCBub3Qgc2VuZA0Kb3V0IGEgbW9yZSByb2J1c3QgcGF0Y2gsIGJ1dCBJIGhhdmUgbm90IGhh
ZCB0aW1lIHRoZXNlIGRheXMuDQoNClBsZWFzZSBhZGQgbWUgb24gQ0MgaWYgeW91IHdvcmsgZnVy
dGhlciBvbiB0aGlzIGFuZCB3ZSBjYW4gZG8gc29tZQ0KYWRkaXRpb25hbCBpbnRlcm5hbCB0ZXN0
aW5nIHRvIHNlZSBpZiBpdCB3b3Jrcy4NCg0KS2luZCByZWdhcmRzLA0KQWx2aW4=
