Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2122.outbound.protection.outlook.com [40.107.249.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE8C53B9
	for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 19:38:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbaESXE0o12VLH8MdpOlxMih91O1nRW44jpZhQA7tFys7DoMsvoyJXH7dKdIeMaiWpar6oN6mxkPzV0hJkkf9Mo8yYNO4ug0/fIVZt5/UwjoUhkTUQWNl/2Exu2X/FV9o/1IovCP/CRpQv9xAvd4FOWBbnrJOybgwgVVuuYDfhOk01AaemtqRq0TT+2soa9GEYvdGyxd07dy8CqAadR4FelVuG9hX+gdX+zNBnInvEDKShZekZ9/c35nWZ3jc1bnbpv7JkKxixxI8H0iy68lcyyTt0kag3x1aoJsv+rntz+acZ2Rq8icT+gXW1TbZKI0lVlsuHLrQPwZV694SkOwng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHoWOefp16wnFsQjIW1j5GMdvVNyVyP8I4UGryiFuWo=;
 b=FZSwZjdt4NhN44xKeIVpjllf8GxPcrJW4ODUHeZGib3yWXWdCakCOgLe+RyWGjgOe4Bh96HrKq95acD5EAZT/gRBcOGeB6kqnC1f8WvP6UOMbjpi3d7S2V1goEyZuu5oQBMz9NQqmb3gzVDatSdyGcAjxhoSEINgka8C5EeHMrxSObXKOfYwzpYAwPleaiRSDeKSR3nOjGq4Emv76Yjsq2Hwcdxooa26ok1FcCCST4YSPINnojJebb9wRT91pPV8eW1KRSRUo/nVwxF8RzMAhjlBRNHUHF9kts29PxH6lzvDiNj7CWPK0+kRhrFQjq8ZfRkJs0lqAHUSre1qiKsUjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHoWOefp16wnFsQjIW1j5GMdvVNyVyP8I4UGryiFuWo=;
 b=eOd3q0C2tpxhwAQSs7nD4f1qi1cdsNZGhFt5HVfBxtDE1+6+lz4IfVGWpSQf26FE1ofJy9cpZ8CAh4OMSJ/Xjh+9Ziw4x5hscYaSSMn8gOoQS5SpUcQd0kMhAYpL7HOpF794sPm9rKt+Rt23cb7f0JioFqZmM/7i7NkHv+apZUs=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AS8PR03MB8348.eurprd03.prod.outlook.com (2603:10a6:20b:525::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 19:38:47 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::ab9f:b966:bfb6:b71e]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::ab9f:b966:bfb6:b71e%7]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 19:38:46 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Bruno Dantas <dantas@airpost.net>
CC: Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>,
	"iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Re: iwd release 1.30 onwards cannot find available networks
Thread-Topic: iwd release 1.30 onwards cannot find available networks
Thread-Index: AQHZDmFZ+4Yr2XfaIUSG62ZTkmNPkQ==
Date: Mon, 12 Dec 2022 19:38:46 +0000
Message-ID: <20221212193846.ub2ahzpl5eu2ylnu@bang-olufsen.dk>
References: <b7ff5956-f571-d9d8-1f7b-f3025e2055ae@airpost.net>
 <b4ad714bbd162b1f7bc3302c9585adf8811ac929.camel@gmail.com>
 <126d2f2b-07ef-fd22-7656-dcd21f3cece0@airpost.net>
 <0df6f28d-4a77-dea2-dbf6-c83c6a25b8ae@gmail.com>
 <5056edba-fa23-b133-73ac-f8daa483cf23@airpost.net>
In-Reply-To: <5056edba-fa23-b133-73ac-f8daa483cf23@airpost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AS8PR03MB8348:EE_
x-ms-office365-filtering-correlation-id: 1716fffe-677d-418d-6862-08dadc787c82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iR9xE0gaW+F44Fbhjn+l4ff1aTG/GDNfoJkzcS7WyH23mHFwPRVFb+vQz1sYytC6eaZnnASFsG9PeEIHlwjwP5HeEUXZifMDc9IBh2kzRj7qkcIv+BLVJdhy1zmG+BpgIYsdoSvoyv+PYijRSVe00/dtf9ksgVVkEsYonr9lTHuXSPEVg4ME3rXknFdE79ydN3J3eJPDs58JFtCK6uN6OrgnrrzIJiX2zuH5gIDdxpWbhdODdC6za0uj1JNQ43kE0169ssCZCnYTkhxqToeXYOn1APYcFyYvlimQ9skkAdTUiMgTLjMEo7Q9huWmRUQCBgKDcfIwttX/h1jFdbFJDlvRQI+ikZqCXSTtUYzhV12228vvIPwr3zBPxVnpT7o7DilwK6i0G4dYTTBvVVXdE6Q4/8AcIp81xd9vT/fn4L7VMlt9Qy7T1jVNMB1ymDn3064PTLjQT6c/iTeDw4DNMEJpMbcs7pDasS2WO1R//B9iqoGGXapML12G2h768x38fH4zeNZnRS2Dy8N5ytseVTBTQUubloY21hOQSa1ptp7pvpkpTrzoaP4p1F+CCUexEMUp5NswqmUEfzIkO7R9WwJxazNaoITX+0XHdpJBVhJprYtyYzGYNTwQX9Q7KQl80TlyWNW+/LiPWDRBkLXQMFyv7zOZ89jU5GxqONjD75gzywEUOBVZg0QyDgKPkQsbtK2e73UXSiug/RQsc/CNUg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199015)(8976002)(36756003)(85202003)(85182001)(8936002)(2906002)(316002)(6916009)(6512007)(1076003)(2616005)(186003)(122000001)(83380400001)(6486002)(38100700002)(86362001)(54906003)(26005)(478600001)(6506007)(71200400001)(91956017)(41300700001)(66946007)(66556008)(8676002)(66476007)(66446008)(64756008)(76116006)(38070700005)(4326008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3Y4eVF5R3ViQmozQnNnNnRnSXgxOVdveHZZNlJKYU9TblhLTktOL0VNcW5N?=
 =?utf-8?B?N2tSSXdHNkg1ZW9HZjJtWDZoWDJ0NFNBTitYcUhud3FRZEtnUTYvKzVndG1i?=
 =?utf-8?B?cG5VandNUnp3MW8xZEVmek1vK2FhN3VXcWdGNWF2Y3RtZHhYR1pZbE4wdU5D?=
 =?utf-8?B?MEFyd013WEg1UC9yMy8wRitaUmdXb0RzYW5KN0F5RXQxYm9samM1VHZ0MWRP?=
 =?utf-8?B?TUdiaU4rWFN3b2RDazZ6b1JxZDdhdUkvZm9qM2ZPSk9qd2V5VkRZUjRXc0hY?=
 =?utf-8?B?V1dueXhkZmE0a2I4UkhHTGRncUovZ3JkbXBoY3UrQVVsc0tCLzlNWnBCYUtY?=
 =?utf-8?B?ZzQ3R2lvdU1tVkFjMXFNaUNLNytZK0oyRkZFbFRKTmJ2Qnd3NElUYlRGeXRL?=
 =?utf-8?B?aHcyanAwVkdWVThsVkx0QWZRUjVUOFlFeXhzT25GSUNtcGM1Y2p6MHE2V1dn?=
 =?utf-8?B?NkRPVG5iaEpzejhyTjVHS3crbi9CSzJ5cWgvRnU4Tk9tTkdJa3VPS2JlNVFM?=
 =?utf-8?B?N1RjL2ZjeDdtRC9jb2lsNWw0cllzYmZhU1ViS2tIK1A2QnFXcjc3QWRxNEJP?=
 =?utf-8?B?LzJiaWFFcmJLOE5sR2tzSXRHdmJhMjZBbzd5Tm1YRG5oMU1CekkveHZCbCtu?=
 =?utf-8?B?dVpEeHVWdjY3RVRGbmJCcmhHaFdwTDhjWW84dW90MzlpRElXaUMvNlFWZEpt?=
 =?utf-8?B?UG93YndXWDJPR3ZTZWZKS2phUGVxd0dyZGxXUEpVTEdGQ3h0WkcwK1RWR0Mz?=
 =?utf-8?B?Y29oUUE1NkpNa1F5aU9NdXVzWURJbVgxZUJhbnZPMDQrbTRTd0EwN0N6cmVp?=
 =?utf-8?B?eFlOK05VVDlDSnZvTWtlY0w4ektGbHp3R0hQQkxLVXZocDEyckV1ZWN0emxn?=
 =?utf-8?B?QmZQa2k2SVRUZGhkQ1YzVjV6WnpNN1h1NDZFSWQvd2FlUG1FcnlFZUFrTmgy?=
 =?utf-8?B?Qm5BZ0dRQndPbUdTNDMyd2xqb2gyVGI4VnhpcnlDRHB6a0VjYk1IbDJweVpR?=
 =?utf-8?B?WGJIeS8yNzFIejk0NFpJejhJeE41MEZMQjZ4b2dCV013ZmJVQUFkUFlvazdC?=
 =?utf-8?B?SERyNVVJeFlYcjFjWXZwUWhkQ1Z0RWNlUmVoYW11L2hoSVlLZVRzMnN5VkhY?=
 =?utf-8?B?UU4vd3VQb1QwMTY2WlR1K0k4SlR2Y21PZDhXbTIvWHphQitWbVVWQ1psT2Vh?=
 =?utf-8?B?amhpaHdyMzB3akJPK21OdmJlQnpSYmMvdzRmeWlTQldUZVc0VnhxRVRrb1dZ?=
 =?utf-8?B?VHQ3RmlobXMzd3BvRlFGT2JkVXg0QmtRM2I4WU9ETlg5eUNmOGFWazBHNzZa?=
 =?utf-8?B?MTFZekppQnJLckZDMitubkZYcGRiclJtSFJBYmNtQUhzWVlQTmVGYjJpbngy?=
 =?utf-8?B?bGdBUDNmOEdxcENsR1dmSU1FaDZhKzhnQ1lUcnFGSFBKVHFhZStwbG9qeThE?=
 =?utf-8?B?Z2xLenByV3MxNzlkZzN3RDE4WW9MSUxDWTdLSHFGY2xXVm5RV0kxcFE1WWFz?=
 =?utf-8?B?UzNnMlBRU0xwQi9lRG9YV0U1eC9WWWZBQWhrVktiSjZBMTNCVGhZTmJ4TjdG?=
 =?utf-8?B?ekJuWEZBaFhtVmtLelhjR3NCNzdhNS9vZ0JmNlJTSFRjTnNsTmxNRElvcTdt?=
 =?utf-8?B?anFreGJsbGlsNlhTRzdjTncwSDBPRmtjeXhCVEVyVDRxU0NSUUN0cVB1UU9o?=
 =?utf-8?B?ZVZNLzJaTHU4QzE1dURpeUpaT1R4dWR3aEo5Q09weWcyRDdMSy9QVXBNTEpZ?=
 =?utf-8?B?a1RTUHZIK2pZUEtaMllyQ1hOYnc2NW5JblY0ZlR2NC9zMG1LZXJZMUVMVVRx?=
 =?utf-8?B?NDQ2VGNSZ3lEU3c0THdWaEFYV1daUkIydjBRM3kvVjZZa0FpNGMvdFhCTDFI?=
 =?utf-8?B?QmRFb2V5d3d0a3dacjdlNE8rdlQzUzlWRUdvVENLamtyZE45cytMUmZ0RVVS?=
 =?utf-8?B?ZXN5MUdxUUZmajRkTU5yZFZrUkN5ajgzQWlYWDJ5TkRpSXJMdVg4NUNWSUov?=
 =?utf-8?B?cDZGbXBpMUk3algweUVSejIzaFI2eGRSNlZJeGh1cWJac09ERVJ3SmFuWExZ?=
 =?utf-8?B?TTIrY0JjQnEzYkpkaFBDM2l5ZEFoLzliNnVXUmFqdVVZdWlDYk81NkhFV09E?=
 =?utf-8?Q?th+UqOmMmrtJ+UDmA9dpXmpVY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6CD8D2447AD8645A0B8CDC78ACE1948@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1716fffe-677d-418d-6862-08dadc787c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 19:38:46.8985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bxQK/p3goECZT7nAy0KMqlqXBEDXZxV5RKJiFI6ON6sOnqQyPaclbWQCLoA1TXFFmX6E44MYSQ6Lhyax17p2TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8348

T24gTW9uLCBEZWMgMTIsIDIwMjIgYXQgMDI6Mjc6MzZQTSAtMDUwMCwgQnJ1bm8gRGFudGFzIHdy
b3RlOg0KPiBIaSwgRGVuaXMuDQo+IA0KPiA+IEFuZCBjYW4geW91IGVsYWJvcmF0ZSB3aGF0ICdo
YW5ncycgbWVhbj8gIElmIHRoZXJlIGFyZSBubyBuZXR3b3JrcywgdGhlbiB5b3Ugc2hvdWxkIHNl
ZSBhICJObyBuZXR3b3JrcyBhdmFpbGFibGUiIHByaW50IG9yIHNvbWV0aGluZyBzaW1pbGFyLg0K
PiANCj4gQnkgImhhbmdzIiBJIG1lYW4gdGhhdCB3aGVuIEkgcnVuICJzdGF0aW9uIHdsYW4wIHNj
YW4iLCB0aGUgY29tbWFuZCBuZXZlciByZXR1cm5zLiBJIHdvcmsgaW4gYSBob3NwaXRhbCBvZmZp
Y2Ugd2hlcmUgdGhlcmUgYXJlIF9tYW55XyB3aWZpIG5ldHdvcmtzIHdpdGhpbiByYW5nZSwgaW5j
bHVkaW5nIG9uZXMgd2l0aCBzdHJvbmcgc2lnbmFsLiANCj4gDQo+IChpdyBpcyBhYmxlIHRvIHNo
b3cgbWUgdGhlIGF2YWlsYWJsZSBuZXR3b3JrcywgYW5kIEkgY2FuIGNvbm5lY3QgdG8gdGhlbSB1
c2luZyB3cGFfc3VwcGxpY2FudC4gQSBkaWZmZXJlbnQgbGludXggbWFjaGluZSB0aGF0IHVzZXMg
TmV0d29ya01hbmFnZXIgd2l0aCB3cGFfc3VwcGxpY2FudCBiYWNrZW5kIGFsc28gc2hvd3MgbWUg
bnVtZXJvdXMgbmV0d29ya3MuIGl3ZC0tdXAgdG8gYW5kIGluY2x1ZGluZyB2ZXJzaW9uIDEuMjkt
LWlzIGFsc28gYWJsZSB0byBzaG93IG1lIHRoZSBhdmFpbGFibGUgbmV0d29ya3MuKQ0KPiANCj4g
PiBDYW4geW91IHJ1biBhIGZldyBzY2FucyBtYW51YWxseSB1c2luZyAnc3RhdGlvbiBmb28gc2Nh
bic/DQo+IA0KPiBGaXJzdCBhdHRlbXB0IG5ldmVyIHJldHVybnMsIGFzIEkgbWVudGlvbmVkIGFi
b3ZlLiBTdWJzZXF1ZW50IG1hbnVhbCBhdHRlbXB0cywgbm8gbWF0dGVyIGhvdyBsb25nIEkgd2Fp
dCwgYWxsIGdvIGxpa2UgdGhpczoNCj4gDQo+ICQgc3VkbyBpd2N0bCBzdGF0aW9uIHdsYW4wIHNj
YW4NCj4gT3BlcmF0aW9uIGFscmVhZHkgaW4gcHJvZ3Jlc3MNCg0KTG9va3MgbGlrZSB0aGUgd2lw
aHkgcmFkaW8gd29yayBxdWV1ZSBpcyBnZXR0aW5nIHN0dWNrLiBNeSBiZXN0IGd1ZXNzIGlzDQp0
aGlzIHBpZWNlIG9mIGNvZGU6DQoNCnN0YXRpYyB2b2lkIHNjYW5fbm90aWZ5KHN0cnVjdCBsX2dl
bmxfbXNnICptc2csIHZvaWQgKnVzZXJfZGF0YSkNCnsNCgkvKiAuLi4gKi8NCg0KCXN3aXRjaCAo
Y21kKSB7DQoJY2FzZSBOTDgwMjExX0NNRF9ORVdfU0NBTl9SRVNVTFRTOg0KCXsNCgkJc3RydWN0
IHNjYW5fZnJlcV9zZXQgKmZyZXFzOw0KCQlib29sIHNlbmRfbmV4dCA9IGZhbHNlOw0KCQlib29s
IHJldHJ5ID0gZmFsc2U7DQoJCWJvb2wgZ2V0X3Jlc3VsdHMgPSBmYWxzZTsNCg0KCQlzYy0+c3Rh
dGUgPSBTQ0FOX1NUQVRFX05PVF9SVU5OSU5HOw0KDQoJCS8qIFdhcyB0aGlzIG91ciBvd24gc2Nh
biBvciBhbiBleHRlcm5hbCBzY2FuICovDQoJCWlmIChzciAmJiBzci0+dHJpZ2dlcmVkKSB7DQoJ
CQlzci0+dHJpZ2dlcmVkID0gZmFsc2U7DQoNCgkJCWlmICghc3ItPmNhbGxiYWNrKSB7DQoJCQkJ
c2Nhbl9maW5pc2hlZChzYywgLUVDQU5DRUxFRCwgTlVMTCwgTlVMTCwgc3IpOw0KCQkJCWJyZWFr
Ow0KCQkJfQ0KDQoJCQkvKiBSZWdkb20gY2hhbmdlZCBkdXJpbmcgYSBwZXJpb2RpYyBzY2FuICov
DQoJCQlpZiAoc2MtPnNwLmlkID09IHNyLT53b3JrLmlkICYmDQoJCQkJCXdpcGh5X3JlZ2RvbV9p
c191cGRhdGluZyhzYy0+d2lwaHkpKSB7DQoJCQkJc2Nhbl9wYXJzZV9yZXN1bHRfZnJlcXVlbmNp
ZXMobXNnLA0KCQkJCQkJCXNyLT5mcmVxc19zY2FubmVkKTsNCgkJCQlyZXR1cm47DQoJCQl9DQoN
CgkJCS8qIC4uLiAqLw0KDQpJIGd1ZXNzIHlvdSBhcmUgZW50ZXJpbmcgdGhpcyBsYXN0IGlmIGJs
b2NrLCBhcyB0aGUgcmVnZG9tIGlzIGluZGVlZA0KY2hhbmdpbmcgZHVyaW5nIHRoZSBwZXJpb2Rp
YyBzY2FuIGJhc2VkIG9uIHlvdXIgbG9ncy4gVGhlbiBzY2FuX25vdGlmeSgpDQpyZXR1cm5zIGVh
cmx5IHJhdGhlciB0aGFuIGFjdHVhbGx5IHJlcXVlc3RpbmcgdGhlIHNjYW4gcmVzdWx0cw0KKGdl
dF9yZXN1bHRzID0gdHJ1ZTsgbGVhdmUgc3dpdGNoIGFuZCBjb250aW51ZSB0aGUgcmVzdCBvZiB0
aGUNCnNjYW5fbm90aWZ5KCkgZnVuY3Rpb24pLg0KDQpLaW5kIHJlZ2FyZHMsDQpBbHZpbg==
