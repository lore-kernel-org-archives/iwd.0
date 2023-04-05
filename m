Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2126.outbound.protection.outlook.com [40.107.22.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6967F5
	for <iwd@lists.linux.dev>; Wed,  5 Apr 2023 09:12:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hi9TXGTJuXIKZnxoPtdnAzsX2OXtCyDzhyadNjabYtAFFC0RrjCdpKB4MoIrsNq+an9YHMYq1aDlH+Zto8Y5WkmdRLPOHdkKCMI21fXLkwr+XGky03BvtbPg8HkQhrQ4l5+waep6Snk61xwH3K/ZXI8kcYjN7ny35N7akJ82RIlGmheE4FgEX9SER1MI1pLJOOeqetZpOcYOdzaaPlXg10WC6aAoyNKioH+CDNx4lk4Qg3+Ld59HApNozqBfkI2wPs8lC83e3eDNbhiNmgaKJ8w20uGsrXjyNW4n7HYAn2Vv7I8YpRx2wbvLx9i7q2QAAdK7p0CzacPZySZuc8KQ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDtVhlFqdJvROSWJdhS1HJvR6oyiajVy9t4PDKBHxiM=;
 b=PnbJ71NykxAQWQOQuQOOY2L47vojgbzzY4xxhur/WgG7oC1uWQqlcBWl9smeVv26axjmDaXCE2rVQRO5RMUeXS4Ce1L6CB+p7WO7FBcCfp2CrywGkpPga0QdqASdnFU7t/XhFo+NdN4XwKgO2fdjT78g5xaTIte/mfQ4fMPVvk5rWOA2rAoSotoQoQ3M8TDP0lKL+L8Kpku4dzZvYXQNhSOniZ+l6zErDd8w+yImX5nl5xOSpijHWs8659gFqWhNLmCek8ikHLhko+3liFnEACqkWiUyRcuHVPHzLeQ/8gNATjUQH07cg50ftJ/J7mG98lyK5YLTNe+BNRdB9CWVVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDtVhlFqdJvROSWJdhS1HJvR6oyiajVy9t4PDKBHxiM=;
 b=JXLMGCkJ7NQFFkQzZTF3hLZHPviawoAS8BXubnmnP3Ap1QYPVnUHxizODnHELjS3YgHBC4vj5TyQdS97TCJdpZ6ijjT69I7EkoGcjzLT2xeYayuXQq3kGUYicieKru+0D4ZimjYXoWCLoIjhLjaMvtpQRxGD9GF7/cbpkeS6n2Y=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by GV2PR03MB8677.eurprd03.prod.outlook.com (2603:10a6:150:76::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 09:12:21 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::9719:4c2f:6bc9:9dbc]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::9719:4c2f:6bc9:9dbc%3]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 09:12:20 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: James Prestwood <prestwoj@gmail.com>
CC: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>, "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>, Dimitrios Karnikis <DIKA@bang-olufsen.dk>, Claudio
 Cabral <CLCA@bang-olufsen.dk>
Subject: Re: [PATCH] station: handle ROAMING state in disconnect event (again)
Thread-Topic: [PATCH] station: handle ROAMING state in disconnect event
 (again)
Thread-Index: AQHZZjdUs9XT8avmIkmHb8xm4XdbCa8aLL8AgAJERQA=
Date: Wed, 5 Apr 2023 09:12:20 +0000
Message-ID: <bfvlzfzk2ov4gzgedn66pblygsbzx5znyfa6vg5b7rocqbnnmp@qdwzifi5ofmq>
References: <20230403141927.235014-1-alvin@pqrs.dk>
 <c9b5a931-ac35-2755-c656-acd567c1505f@gmail.com>
In-Reply-To: <c9b5a931-ac35-2755-c656-acd567c1505f@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|GV2PR03MB8677:EE_
x-ms-office365-filtering-correlation-id: a3c4ecaa-22f9-47c6-c192-08db35b5dc82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Zaf3p0l1HnFeJ0I2u+dXEgVSJdfM3Gt0FcPGABsBt7Y6wruRO2LxWVcxw9YmqsYIb/N4xl+RPcV3oJCPUnRtDdryu5ESoxVvBGIWe0yBZxXheawbShWxBsY4VTTx/qI/ICUkoBCjouZ52sapkBoQtF6MFIvYSex7GmY6IR4yaC7j38u9lvgn4CchZY0VxSobfKcCjg+HMwXovKJShoP44xy9S8AfmEmtjrhnEhHPHEF0www8pCV0TjKSyGOWPgVfrYxvvj53WSmydTIvNYgKzr6mIkyOSwcYUNu2VoCnV43h3USWimZG3+8qkZ4IiB1trS0bCU0cCMHwuvkLbyuFLTKBZ9YvIJJ74ac9wEvUbA3GfmsHC+GeF6p99g6RwqHVJYh/41lTDTsBk7P493N7PIIR+ysSlKZQn9dHN1OdAmrkhkYn07WGWulw1dGWPb2vI8iuNpI5Gaw14LdTNeCS8RPVikvSrPvokHDSoXJIbq6PULm0//MXxG9U9mVTDH3ZZaFLreWWIRJ+A2cnZ2/zv/+UNtYvyfa7YmYPGzxQ9+UNqaut1b8PS3ns7f/j8hDXMg2JCOda0Md8H24IN9lbpgKeR4ub+FERWz79+zA7uNWFXQtdjnVRnO/3TTZX0RVo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(86362001)(122000001)(2906002)(85202003)(85182001)(38100700002)(33716001)(38070700005)(71200400001)(6506007)(53546011)(6512007)(9686003)(26005)(107886003)(66946007)(91956017)(41300700001)(6916009)(66476007)(76116006)(66556008)(66446008)(4326008)(8676002)(64756008)(54906003)(478600001)(5660300002)(8936002)(316002)(83380400001)(6486002)(66574015)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cE1KRHIybXRmREdqeVZDZ2krbU5iUk9tSUt5azN1ajRSenh5U2pjVHdtaElC?=
 =?utf-8?B?dlloekdodkJmLy9tZUVtREkwdDgrWnJZb2szd2Nmak5wb2YrbnRORlNyRU1D?=
 =?utf-8?B?V0h0MStUNHhqS2VsbnhmL3lBYXcxTS9TYnZJZEZ2czlVblJrdUorWXhVZitY?=
 =?utf-8?B?bzlTQ1VXbTBpUFNBalMvUUdmRWx5UlhkNTlvcWxsQkNCV3UwUjhJRlVRK29Q?=
 =?utf-8?B?K05YbGhSb3J4TnZsZ2lqTk5SSzZvRU1PQWdkS1JLallKT21TNUxUZnF2VzlJ?=
 =?utf-8?B?ak1Ua2d6L3UySVVrazFJMHRvcytXOTFYdHlHeWZJRE83Q0FYdTJTankxc1Nj?=
 =?utf-8?B?V0lTMDBDak9sWEJrQVQ4U25vaHFLa0JEdkZjNGNjZDM0RFoydnZYVzhsc1NO?=
 =?utf-8?B?M21ndDVYaUw1Wng3c0ZEZW9Wc0dRRlkvV0ZCSnVkNDErZ2ZVa1Mvc2l4eTQ4?=
 =?utf-8?B?empCQ3h6MTZIOU5Id0ZBN2o5UFVtRENRYWsvbUp4YjIxVUk2WXpYUWg1MWd5?=
 =?utf-8?B?TWlWL05lYmY2eWZNQzVqczBkUUU2dXRoTDlGQlVxZmt2V0JOR2UvV3FhVlhF?=
 =?utf-8?B?Z0EyV3J6bHdYeml5TkI1WkR4SHVaQTZUNHo0YWo4QUNHYy9IZmRiTTRlamJX?=
 =?utf-8?B?NWVVdjhsZ2Y0cDJCa0gwMU93OS9mR2NOUnppbjUzdThyTTI0RlQwam9HTmti?=
 =?utf-8?B?M3BmVkYya285dEQ4eG1UNkhMaXd1MGVRSk0zbE8zOTZIaUV3b0I2RlZzVDJn?=
 =?utf-8?B?K1R3SlUzN0E1MWk4VHJldkg0NmdzUGRlVGRyK3NkMU9GdjFFV3hoZVBmRlJ3?=
 =?utf-8?B?ekVDWElnbVRWaFBtNnptM0VCdmRWeHN0MmY0VmlMcnAwTGxGaGQreHBaU21S?=
 =?utf-8?B?S2dvc3E4WTBtSkczMHRwT2IrNDhmMHZnaWVXK1AraXdEVUFUUmwraTd3aENR?=
 =?utf-8?B?OTgrU21sNC9qUXZ6N0hJTmRSdmRuWTlQZXFZbDk4b082RVJlUUJNQ3I5MWFY?=
 =?utf-8?B?Vk5ZYklRT0FxWUlJSThESU54ekV3cUh4d2J5MTZPNHJNVUxlM3RjNDdhVmwv?=
 =?utf-8?B?MUtENEFMU0xqVVNwWm1IMHFWSzVmbDhoTG05S251NzJTN1NYSUZFQ25scmxp?=
 =?utf-8?B?STdYU1lYWTRWdTZhZC83a0h4Sk12ZXIxRWZ5aUxWNlhoUWc0OU4rU0oxR2pr?=
 =?utf-8?B?K1ZDNVVvNEFxS1hUL01qOXJVOWwrd1FaNXJUN2VpY2VpVGY4RG9rWllvcmIz?=
 =?utf-8?B?V2dWN2Rsc1RrMnVMMTVwTzF4b0Y5dVVwWklGMzFjYkxaSnljeElGUWJqT2gx?=
 =?utf-8?B?ZG5aNGQ5K2hvWmhpZ3huSUpCL055UFVpaFE4UlUwdDZqNHZET09GUkZ5VnlZ?=
 =?utf-8?B?b2dDamdhNHBCSDEvYUZadTBUcXhHU1pQM2tmZkpTMWJCVWlVbGN4OEdpcm1M?=
 =?utf-8?B?ak1TVnRWWlNWS25VSHBRZGFOMWo1MlNabzN2Wk1HcktHMVFaNzVmSnZKOSsy?=
 =?utf-8?B?a2s4a3gvZWdpQ05IZGQ1cVFMazUxTW51Vi9CdnYzZjJudDBHT0RSVWQzRHdx?=
 =?utf-8?B?NG5UYnc3YTRNZnF0Z0x5Nmp4WDQrTmJJQmExb1dvOWE4OStrM0U1NGR6WExP?=
 =?utf-8?B?SnBna1lMYWlBQjBKMHI0OE1TOGxCV0FCRVRtYVpqZjNXWTUzQVRsU3dGVzd2?=
 =?utf-8?B?VXVCMHgyY0MxUEd1L0VCRUp3dmVleVFscHZZU3d3UU1WbERUUXNWUVNuS2VB?=
 =?utf-8?B?VkFzMEpGNnV1TmNyQzZCK0FFem5wUzdLcWR0R0VQT0NQWU9RMGxVY2s3eitB?=
 =?utf-8?B?SGpJQW03TG52MUpPRzFvNS9ITzluRzZBY29jajFSSDYyb2w3c21sWlNSWHNC?=
 =?utf-8?B?NTVYZHE4VjhYRGx6ZWlxSUFtK2tnejlKdEs2RmoraCtNNE1aSWFXYm1DMnEx?=
 =?utf-8?B?R25sa0pwcXZKV2NJcUl4bnBuY1FyU2RCTk9KbHEyTmQ5UmhWZm1NOEc1UmpZ?=
 =?utf-8?B?Q3ZQY2huUDJRNVlNSmxqMlduaERZdisyTjZ3cjE2S29DQk9YNFhtdTBzUEF0?=
 =?utf-8?B?ODl6cXhWbnBnOTdsenNNOE10UndQZ0ovTzUwVFJEcU5RejE4ZnlralpnQ0lR?=
 =?utf-8?Q?Dr0HUMMlx0d6sGFjymtWMUXsa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFFD32DD6B78784D8B3F4F0399AC7FCF@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c4ecaa-22f9-47c6-c192-08db35b5dc82
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 09:12:20.7746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ccZ9VZszqN9q9cYiNj+MONsHj7zecC4Uu7gNp5y5O0h+RpdMlh1NRuzmBk6ipZBirJZeNY8UkoGRjbYQtPAuWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8677

SGkgSmFtZXMsDQoNCk9uIE1vbiwgQXByIDAzLCAyMDIzIGF0IDAzOjM1OjI4UE0gLTA3MDAsIEph
bWVzIFByZXN0d29vZCB3cm90ZToNCj4gSGkgQWx2aW4sDQo+IA0KPiBPbiA0LzMvMjMgMDc6MTks
IEFsdmluIMWgaXByYWdhIHdyb3RlOg0KPiA+IEZyb206IEFsdmluIMWgaXByYWdhIDxhbHNpQGJh
bmctb2x1ZnNlbi5kaz4NCj4gPiANCj4gPiBUaGUgYmxhbWVkIGNvbW1pdCBjbG9iYmVyZWQgdGhl
IG5vbi1GVCAoUmVhc3NvY2lhdGlvbikgcm9hbWluZyBjYXNlDQo+ID4gaW4gdGhlIGRpc2Nvbm5l
Y3QgZXZlbnQgaGFuZGxlciwgY2F1c2luZyBpd2QgdG8gcG90ZW50aWFsbHkgZ2V0IHN0dWNrIGlu
DQo+ID4gdGhlIFJPQU1JTkcgc3RhdGUgYWZ0ZXIgYSBmYWlsZWQgcmVhc3NvY2lhdGlvbiBkdXJp
bmcgbm9uLUZUIHJvYW1pbmcuDQo+ID4gQWRkIGl0IGJhY2suDQo+ID4gDQo+ID4gVGhlIHN1Ympl
Y3QgaXMgaW5zcGlyZWQgYnkgYSBwcmV2aW91cyBjb21taXQgd2hpY2ggZGlkIHRoZSBzYW1lIHRo
aW5nLA0KPiA+IGJ1dCBpbnRyb2R1Y2VkIGJlZm9yZSB0aGUgbmV3IHJvYW1pbmcgc3RhdGVzIHdl
cmUgYWRkZWQsIG5hbWVseSBjb21taXQNCj4gPiA4NzU4Y2M4OTQ4N2IgKCJzdGF0aW9uOiBoYW5k
bGUgUk9BTUlORyBzdGF0ZSBpbiBkaXNjb25uZWN0IGV2ZW50IikuIFRoZQ0KPiA+IHJhdGlvbmFs
ZSBoZXJlIGlzIHRoZSBzYW1lLg0KPiA+IA0KPiA+IEZpeGVzOiBlZGY1NTZjYzdiYjkgKCJzdGF0
aW9uOiBhZGQgdHdvIG5ldyByb2FtaW5nIHN0YXRlcyAoRlQvRlcpIikNCj4gDQo+IElJUkMgbGVh
dmluZyBvdXQgdGhlIG9sZCBST0FNSU5HIHN0YXRlIGluIHRoaXMgc3dpdGNoIHdhcyBhY3R1YWxs
eSBkb25lDQo+IGludGVudGlvbmFsbHkuIFRoaXMgaXMgYmVjYXVzZSBuZXRkZXZfcmVhc3NvY2lh
dGUoKSB0YWtlcyBhIGNhbGxiYWNrIGFuZCBhbnkNCj4gZmFpbHVyZXMgd2l0aCB0aGUgcm9hbSAq
c2hvdWxkKiBzaG93IHVwIGluIG5ldGRldl9jb25uZWN0X2V2ZW50KCksIGFuZCBpbg0KPiB0dXJu
IGNhbGwgdGhlIGNhbGxiYWNrIHdoaWNoIHRoZW4gbGVhZHMgdG8gdGhlIHNhbWUgc3RhdGlvbl9k
aXNhc3NvY2lhdGVkKCkNCj4gY2FsbC4gV2Ugd2FudGVkIHRvIGF2b2lkIHRoZSBwb3RlbnRpYWwg
b2YgYSBkaXNjb25uZWN0IGV2ZW50IEFORCB0aGUgY29ubmVjdA0KPiBjYWxsYmFjayBib3RoIGNh
bGxpbmcgc3RhdGlvbl9kaXNhc3NvY2F0ZWQoKS4NCg0KWWVzLCB0aGF0IG1ha2VzIHNlbnNlLg0K
DQo+IA0KPiBEbyB5b3UgaGFwcGVuIHRvIGhhdmUgYW4gaXdtb24gcGNhcC9sb2cgb2YgdGhpcyBi
ZWhhdmlvcj8gSWYgaXRzIGEga2VybmVsDQo+IGJ1ZyBhbmQgYSBDTURfQ09OTkVDVCBjb25uZWN0
IGV2ZW50IG5ldmVyIGNvbWVzIHRoZW4gd2UgcHJvYmFibHkgZG8gbmVlZA0KPiB0aGlzIHBhdGNo
LCBidXQgbWF5YmUgaW5zdGVhZCB3aXRoIGFuIExfV0FSTl9PTiBvciBhIGJpZyBkZWJ1ZyBwcmlu
dCBiZWNhdXNlDQo+IGl0IHJlYWxseSBzaG91bGRuJ3QgYmUgaGFwcGVuaW5nLg0KDQpZZXMsIHRo
aXMgd2lsbCBiZSBvdXIgbmV4dCBkaXJlY3Rpb24gb2YgaW5xdWlyeS4gRWFzdGVyIGlzIGNvbWlu
ZyB1cCBhbmQgdGhlDQppc3N1ZSBpcyByZXByb2R1Y2libGUgYnkgY29sbGVhZ3VlcyB3aG8gYXJl
IG9uIGhvbGlkYXkuIEJ1dCBJIHdpbGwgZm9sbG93IHVwLg0KDQpUaGFua3MgZm9yIHRoZSBxdWlj
ayByZXBseS4NCg0KS2luZCByZWdhcmRzLA0KQWx2aW4NCg0KPiANCj4gVGhhbmtzLA0KPiANCj4g
SmFtZXMNCj4gDQo+ID4gLS0tDQo+ID4gICBzcmMvc3RhdGlvbi5jIHwgMSArDQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvc3JjL3N0
YXRpb24uYyBiL3NyYy9zdGF0aW9uLmMNCj4gPiBpbmRleCBkNTY1MGEyOTk1YTkuLjY5ZjliZTc5
ODgwZCAxMDA2NDQNCj4gPiAtLS0gYS9zcmMvc3RhdGlvbi5jDQo+ID4gKysrIGIvc3JjL3N0YXRp
b24uYw0KPiA+IEBAIC0zMjAxLDYgKzMyMDEsNyBAQCBzdGF0aWMgdm9pZCBzdGF0aW9uX2Rpc2Nv
bm5lY3RfZXZlbnQoc3RydWN0IHN0YXRpb24gKnN0YXRpb24sIHZvaWQgKmV2ZW50X2RhdGEpDQo+
ID4gICAJCQkJCWV2ZW50X2RhdGEsIHN0YXRpb24pOw0KPiA+ICAgCQlyZXR1cm47DQo+ID4gICAJ
Y2FzZSBTVEFUSU9OX1NUQVRFX0NPTk5FQ1RFRDoNCj4gPiArCWNhc2UgU1RBVElPTl9TVEFURV9S
T0FNSU5HOg0KPiA+ICAgCWNhc2UgU1RBVElPTl9TVEFURV9GVF9ST0FNSU5HOg0KPiA+ICAgCWNh
c2UgU1RBVElPTl9TVEFURV9GV19ST0FNSU5HOg0KPiA+ICAgCQlzdGF0aW9uX2Rpc2Fzc29jaWF0
ZWQoc3RhdGlvbik7
