Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2099.outbound.protection.outlook.com [40.107.105.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D63241F1
	for <iwd@lists.linux.dev>; Fri, 24 Nov 2023 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="Eyo40Gux"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWDsJj79WSBQCMJaq2DhK0/PSEQv2PIqwK73LaCx2w3Ee9TD3SaMcXSza8ZaUMcZ167P190cQYtQzoqRtxM8JZcVZUkYSVryDcG7x7rkS7TDkwt/OjvYzosUZrbzKtZxqHjoInz3zBc6NpZNYlD8WG0f3+6Ocxsw9t+NV14pHyVM0SRNKe77+Zl4wKsrDsm/esObnPlFW2K8DKKA6RXpwUkA51xyKDurkAK+C49QZty7e4TrT1Ku+eUPZz1gYWGH5jCaN9lwkbB+X9EkyyWZ/BJP3frbIUOzvdtaz1ubD8+uX1C59+M3y5GiNWf5ZS4l2BxdKbx+VHj7WXwsrgg2gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvKzC8hHWLbeDToek61jV96KX1W7t383PeubzZtkQWY=;
 b=khjktELm3p2LiF20tXBgeVA9CXD4ZB1NK6RIre79QCxaMfx8e5fog8jYcv4bWm4tolXe27GIxB5x6I592IJOxHdEuq3i3N407FU3yL5F8epxwCyWDWoPlLHog5H1z2YOc2uoOxqVncKHoAU2JVE7JZTU7wEjkjKHZ+cSn0KNkpWBVOKqeFMCbPAHzqbm6Bf1/2frmA0xZXPIB2hkZJgNEmu1lM0L9NnsutUQv7I8w4XrjH/kpBzP0+13qNenBnEzIUZQIUUOwNoE5Hzr1TIlr/F1gIWAbuoeOTP19TkeW01VJ6ncFBoGZPfUK20k4yg3hX6vQDFdMZwEHoYnaogY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvKzC8hHWLbeDToek61jV96KX1W7t383PeubzZtkQWY=;
 b=Eyo40GuxJ85CY9x0h2HaGa85o8UfuGvBEEjdaHf8UqOiXWVM6XJoSPmgUtsowXIdaWiLhAHiXexVHBV9FR+9iiouhXlTcSjiW92psRC961uE9SwF7AV0Q1XiWtcL09EQGkKB57TLCR2EIPunK6kx/4lN0UyQarhfL6tyBZwhdhE=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AS8PR03MB8547.eurprd03.prod.outlook.com (2603:10a6:20b:570::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Fri, 24 Nov
 2023 12:20:08 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 12:20:08 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Denis Kenzior <denkenz@gmail.com>
CC: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Re: [PATCH 11/11] netdev: disambiguate between disconnection types
Thread-Topic: [PATCH 11/11] netdev: disambiguate between disconnection types
Thread-Index: AQHaHtCQ8mPlwNZhx0G5Y3dJHjFyKw==
Date: Fri, 24 Nov 2023 12:20:07 +0000
Message-ID: <z6bw5z4aptq4fq73ercwhrp76wpz6ihtlzrst2kmfqjoru42y6@v5e5za2r23lb>
References: <20231114171455.1108856-1-denkenz@gmail.com>
 <20231114171455.1108856-11-denkenz@gmail.com>
In-Reply-To: <20231114171455.1108856-11-denkenz@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AS8PR03MB8547:EE_
x-ms-office365-filtering-correlation-id: f050b6e4-1da5-4de4-0e35-08dbece7b292
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qL1U8DzkMO/55AqPaRrXOJ+ttXGJwP/qPFyb/ME7uzTSnTBBXSfk/PsCwzgmZh6d5OqH4NnDe5DmB7BADBaBqNPZyul00whps8fXDvV26PWTwNAgjKMNSre5dbItqYu7g/C85qWgG7a85frZfMOy2//L+hyNcIpyqH+NjhN9mk6o6OLneW+/ddmm2soElC0bfV7y727Pb3OR+OM8NWgLeTI+l60eo1iZeQu7E2MDLn/x09BBmSA7ffE77DmN9UR4ioidYV5BUGK/tTIW9g01yNMl5vUwPZ2xkmhmDMV4c49soivGyBy7gZ3Vn49B0xQa9/QEjpGTZMW6ufDtWSOtXq/3W4TE3MwlqQTt5quklvkhf3PoSWPnxwfYuVW5ybJl95a/K+Erb/fErDK6jkIKCEUyYzex5BPROYqtzFb7a0oI0N+US9o2g/zbYFasoX/fS6lLFp9JnxL5FrcBq+/qZF+rmnVOZsCuzcMFFqSjjX/cGgomQiJABQzqC/zTqzZ6lBVFEHu6MVbiD7wS+7jJR5WEbpBZ4z8oCbOa7wNeVahZKEzyZQzConvD4YvV7WyA5tehxSh2WFORZSMH0+i5zBXU0N67iumFcuEXsrt3MSTvU0j1pqlth9mRcK5OGhl6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(91956017)(85182001)(6916009)(5660300002)(2906002)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(4326008)(8676002)(8936002)(38070700009)(41300700001)(85202003)(122000001)(86362001)(38100700002)(83380400001)(6506007)(71200400001)(33716001)(6486002)(26005)(478600001)(9686003)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V01qcHNFNlBQTFRwcVZTcUhMODV4TkNrSklEd1BFaGZEckRWNEhxbFlyTlRz?=
 =?utf-8?B?VWN4aWt3MFdrbWFtYjEyOEtLOHI2WmVEZ1Fka0QwWFFUbkRnYzd1eWVCOGpU?=
 =?utf-8?B?WC9vTXgyNlhEdTIzSkliUmtIaEtHSTVuTWJmQWtLNDRiR3lBWUY5Y1AzM0VP?=
 =?utf-8?B?MnFqUmI1VzFqK3MxNyt4UTNLWmJnMWVnNDFLb1I4UDNZc0pqaTRlRDF4K3BH?=
 =?utf-8?B?ZU83bXo2Z2pscThJaFg2UzJiWVpwTHRKK3pvNjkxd0x5NzdCRFA3TXc5K2pa?=
 =?utf-8?B?NzE3T1NlMnNQQUxwWTQ0bWFmZUtPbktQWUVMckVjRThIMjYwVk9ORHpHM3E3?=
 =?utf-8?B?c3FCR0ZLWVd0Z2ZxQUduN21GRktkalMwMTV2SVVCT2pkTGFRVlRyQkJOZGxK?=
 =?utf-8?B?V2tQUU00UmkwM1pBdXF2UzB2OUxRVDRYUkpvOE5ZOUxudWdJRnlVQTFjUmZ2?=
 =?utf-8?B?VmJ5L0swbzdjMDZGTnYva0FIVUhvaG9GNE84WWNWZzhUbW82c2VscmlKVHoy?=
 =?utf-8?B?TW5OYXI0UVZnbFp3eXhaZlFhOXVOV0FFd2dQOEV6cndUbnY1cFlWbzY1eXdG?=
 =?utf-8?B?U1lVUmFwMnZSd2R6TjY3RHNwR1pwcFRZK0pmbzlnQmZMT1krZEs0bndyd2lR?=
 =?utf-8?B?VnZad21jamljTmN1R1RCaERhNGNXNTErUHk5Ukp0b3dEd1BGdVhqU0tQYXdn?=
 =?utf-8?B?cVlLTzN4Y3lsQ2R6NFd1V3MzdDVEbHZieVVsVERjbDJxQUp0eEZWMVVuUWNC?=
 =?utf-8?B?UDVocm9UelRyWHlnOHZMcHM1Mm5WbHo4dW41MXkxYlBQeE9xN2h3UEErTXRx?=
 =?utf-8?B?VTRBWmFjRHBRcnZyMW4wWTU5WXVFQTdlSldiRUhpeDhzMkw4VnJ3bU1YYnNS?=
 =?utf-8?B?N1RXMDZXKzdNMjJwQVNPS0lGNGc3ekh4SmhyckxiZk1DNDBlYkI1OWxIU3R1?=
 =?utf-8?B?c0lPVG5hU2dBKzljT0h6emFucDdWL1UxWEd5WUxLYk5UWHlSeDlibEh6Ukp3?=
 =?utf-8?B?dU5wZkR1c0hFYlJic1BRR0Rqd2RkN2QvMkZGamNSbk9oRWkvTXNVc2FBMVU1?=
 =?utf-8?B?NVlleWFDSTNndlJHbXZ2ckFpMUZ0eWQzbzRuaDM3bVNTWnd3ZEJVNGliMDhB?=
 =?utf-8?B?Ykt3ejQ0ZkxBNDFYK2g5S01UU2tYbUFselFsYXdPS2MyUXVISnlFM1lzZGhT?=
 =?utf-8?B?UDVxZERvWWplZG5KRWFKWnZhU01NdDBSa1I2NGsvMVl2M3IyYW1wZGQxRWFM?=
 =?utf-8?B?YndMWHBpMlNpblg0Wm83dmR4YktqM09iV1p6UEVsZnpuc29oQ2tuM2R2RG5L?=
 =?utf-8?B?NWdQN1VBUVVxOVdESEl2dUE5ejAzWTlabDYwSVQ0RTBXM2FnQkhlVHoya280?=
 =?utf-8?B?VHF1U2tRS0FHYjNkVGFHODM0T0VMMGJUYUREWDIyM0VPak5uelRnOE9PODdF?=
 =?utf-8?B?d1k1M0VmQi9YWjF5NXl0dXJZL29GZVpzam8reTNjRmxUQ055bVpsOExBUkFF?=
 =?utf-8?B?Y0o3dTErWTR6dTFzT1ZGckRNTThDeU5wKzRQdkR6WUNpbXJqM0l4YUwxa05D?=
 =?utf-8?B?Yjc2ZEU0V0pkeTRRcGpBd3psb2ZYcXpjL21nSmJqUWltVkEvb1V1cTJnRkE3?=
 =?utf-8?B?M3UzNU9IdzZQTU1OV0VpNUt6bWgxaHJBbU5HMGo3cWtmMThVbnM2NE5HTXFk?=
 =?utf-8?B?Qm9GQVpQSFh0TzZGTkpyTEtMeGt5Q3ZJSEk0WUxLTzZSWFRkb2htOTNvc3dT?=
 =?utf-8?B?QkprSTd3dWFXVHRUVWROSzJGTENtbkFQak15ekZ0Y2ZSRyswb2NKaHYxZGpW?=
 =?utf-8?B?TU1YSE1STGJneHM5Y1BtUFhNVklQbFdRa1M5Zy9zWHIzVlRUNTlUZ2JJTm9y?=
 =?utf-8?B?YUV4TUxEZ3VHYThEMmNvS2J3Nm45Y2pzQ0V2eCtuN1ZldXFTT1VIWlBXRnEr?=
 =?utf-8?B?djlzZVdINHhtcE8zZlh3V3huUXFPa1ZVaDFSaEMyS1pSd3ZGdHE5Tmp1eHZJ?=
 =?utf-8?B?RDFwWVBkeTdSdW5ET0hUcVZqZGt5NHAzRzNQSjVEWTdCR2FGN1dCNzhYL0wz?=
 =?utf-8?B?WURUcno3T2h1Y2tkMkZwcGZoMEN6Q0I3SnZCcFd0ODJGWVgwUGVwWkxCQ1J4?=
 =?utf-8?B?UGFNUDR6NFFKYnFHdW5tMUxzOExwRDU5TFFUQWYvQ2tVT09hTUVaMHM0K1N0?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AB87AC40A093D47A298D3A1AC9FE769@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f050b6e4-1da5-4de4-0e35-08dbece7b292
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 12:20:08.0351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uc42N6T63/dB0++DrVWuBl0kIDPmbsxP4RHnRcAYFx21tGk8JsoihmVPJihldJiaq8MU5D+MsnjX92aNury32Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8547

SGkgRGVuaXMsDQoNCk9uIFR1ZSwgTm92IDE0LCAyMDIzIGF0IDExOjE0OjM0QU0gLTA2MDAsIERl
bmlzIEtlbnppb3Igd3JvdGU6DQo+IFRoZXJlIGFyZSBnZW5lcmFsbHkgdGhyZWUgc2NlbmFyaW9z
IHdoZXJlIGl3ZCBnZW5lcmF0ZXMgYSBkaXNjb25uZWN0aW9uDQo+IGNvbW1hbmQgdG8gdGhlIGtl
cm5lbDoNCj4gICAxLiBFcnJvciBjb25kaXRpb25zIHN0ZW1taW5nIGZyb20gYSBjb25uZWN0aW9u
IHJlbGF0ZWQgZXZlbnQuICBGb3INCj4gICAgICBleGFtcGxlIGlmIFNBRS9GVC9GSUxTIGF1dGhl
bnRpY2F0aW9uIGZhaWxzIGR1cmluZyBBdXRoZW50aWNhdGUgb3INCj4gICAgICBBc3NvY2lhdGUg
c3RlcHMgYW5kIHRoZSBrZXJuZWwgZG9lc24ndCBkaXNjb25uZWN0IHByb3Blcmx5Lg0KPiAgIDIu
IERlYXV0aGVudGljYXRpb24gYWZ0ZXIgdGhlIGNvbm5lY3Rpb24gaGFzIGJlZW4gZXN0YWJsaXNo
ZWQgYW5kIG5vdA0KPiAgICAgIHJlbGF0ZWQgdG8gYSBjb25uZWN0aW9uIGF0dGVtcHQgaW4gcHJv
Z3Jlc3MuICBGb3IgZXhhbXBsZSwgU0EgUXVlcnkNCj4gICAgICBwcm9jZXNzaW5nIHRoYXQgdHJp
Z2dlcnMgYW4gZGlzY29ubmVjdC4NCj4gICAzLiBEaXNjb25uZWN0cyB0aGF0IGFyZSB0cmlnZ2Vy
ZWQgZHVlIHRvIGEgaGFuZHNoYWtlIGZhaWx1cmUgb3IgaWYNCj4gICAgICBzZXR0aW5nIGtleXMg
cmVzdWx0aW5nIGZyb20gdGhlIGhhbmRzaGFrZSBmYWlscy4gIFRoZXNlIGRpc2Nvbm5lY3RzDQo+
ICAgICAgY2FuIGJlIHRyaWdnZXJlZCBhcyBhIHJlc3VsdCBvZiBhIHBlbmRpbmcgY29ubmVjdGlv
biBvciB3aGVuIGENCj4gICAgICBjb25uZWN0aW9uIGhhcyBiZWVuIGVzdGFibGlzaGVkIChlLmcu
IGR1ZSB0byByZWtleWluZykuDQo+IA0KPiBEaXN0aW5ndWlzaCBiZXR3ZWVuIDEgYW5kIDIvMyBi
eSBoYXZpbmcgdGhlIGRpc2Nvbm5lY3QgcHJvY2VkdXJlIHRha2UNCj4gZGlmZmVyZW50IHBhdGhz
LiAgRm9yIG5vdyB0aGVyZSBhcmUgbm8gZnVuY3Rpb25hbCBjaGFuZ2VzIHNpbmNlIGFsbA0KPiBw
YXRocyBlbmQgdXAgaW4gbmV0ZGV2X2Nvbm5lY3RfZmFpbGVkKCksIGJ1dCB0aGlzIHdpbGwgY2hh
bmdlIGluIHRoZQ0KPiBmdXR1cmUuDQoNClNvcnJ5IGZvciBub3QgZm9sbG93aW5nIHVwIG9uIHRo
ZSBpc3N1ZSBJIHJhaXNlZCB0aGUgb3RoZXIgd2Vlay4gSSBhbQ0KY2F0Y2hpbmcgdXAgd2l0aCB0
aGUgbWFpbGluZyBsaXN0IG5vdyBhbmQgc2VlIHRoaXMgcGF0Y2guIEFtIEkgcmlnaHQgdG8NCmFz
c3VtZSB0aGlzIGlzIHNvbWUgcHJlcGVyYXRvcnkgd29yayBmb3Igc29sdmluZyB0aGUgaXNzdWUg
SSBpZGVudGlmaWVkPw0KDQpJIGFja25vd2xlZGdlIHlvdXIgcHJldmlvdXMgcmVtYXJrIHRoYXQg
dGhlIGlzc3VlIG91Z2h0IHRvIGJlIHNvbHZlZCBpbg0KbmV0ZGV2LmMgYW5kIG5vdCBpbiBzdGF0
aW9uLmMuDQoNCktpbmQgcmVnYXJkcywNCkFsdmlu
