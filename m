Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60094.outbound.protection.outlook.com [40.107.6.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4718215BE
	for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 16:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i96YtbxY0uibPrz119arv74j5QbG+5sDGxpcUJvJyeOpMV1VMh1gHXHcRGOI5SB+DDSKgvmVg7LmOnLZcQ5dcxIJsLXDxnenDmGfTyaqzkWjiFQuIIcdTeP45zNqB8xp3htmu2d1d9aBUVvEk8hBmJeh9crDlXj2KmM33Wd1sJkLGd2gHxYecbF0+bWBaN5OzeRun75JR/sqjSu94TFG7XHQDoevJW2G7ZkyDuONSAf+ypn6Hywh4Z/8fylt16uwQ0EvEhl+nFN9erAivdI8al8cAYUwTnP2bFRK/JfpZmhINFZys3o+wY99kl+Tuyh6T4X5pCey+MnWDQHFi68ZdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CLpa2w/73/B7js/jBYqzV6RrJYk0B0IPzQ+XGKoGhQ=;
 b=COshgg+fFiBX8SiYucsjNZ+7SO8Vvdr5d4UiE9TavnE3Lb2m0eq147wQm38XMZ6y196pTklIAtdY0ccQ0JNGAUfBov3Hsmyr+z6sNSNR28xPeNWQZUeGUW357aCzsOHcJJsYpwv4vZpHh4TJOSLVWXWaOY4OTBzjzf+XAIF211LkcjDbgvGikptwFC8ZMa+FA65UTKNEWsbjLjgAsWIhe03Qw5So9G+qyOeyYcvhPLeNEoHKPkD+KhSjOiPzuvwhfgGpGwSLS47IcUt8xrUaNC/zea4yR0S9abB6cjDJE5X4AmXI/t8RET2P06zn5E0pQK8uPrhHlF2B9bqQ7fRIVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CLpa2w/73/B7js/jBYqzV6RrJYk0B0IPzQ+XGKoGhQ=;
 b=Ea4f02TcMCiYAKcQ89WLrzCfjvCsKRsg9wp0aCWipw9CaQ69DxY0/8oueAkbr7s+bgCZ6Ie5v/RQIeMIcWdAsRwg5D7m3F6sBIejBFCzeGQlFgDxRIgY3VjC0kqoUgskgMlCZHJSmcP69obNX9KKrp3WWjk8gTN3UCDFIDZJKxU=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AS8PR03MB8997.eurprd03.prod.outlook.com (2603:10a6:20b:5bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 17 Nov
 2022 16:46:34 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::5c3c:8e4f:b41a:bcb9]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::5c3c:8e4f:b41a:bcb9%4]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 16:46:34 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Denis Kenzior <denkenz@gmail.com>
CC: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>, "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>
Subject: Re: [PATCH] scan: make scan requests fail if trigger returns -EBUSY
Thread-Topic: [PATCH] scan: make scan requests fail if trigger returns -EBUSY
Thread-Index: AQHY+phdv2rtpTRRCEm7uTm1IaGt8K5DTk4AgAAEzgA=
Date: Thu, 17 Nov 2022 16:46:34 +0000
Message-ID: <20221117164634.7fjgx7rbzncwqgb7@bang-olufsen.dk>
References: <20221117152155.2310412-1-alvin@pqrs.dk>
 <878e8c89-6754-af3b-6d2d-9195a920d728@gmail.com>
In-Reply-To: <878e8c89-6754-af3b-6d2d-9195a920d728@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AS8PR03MB8997:EE_
x-ms-office365-filtering-correlation-id: 6063c8a8-8118-419a-c74f-08dac8bb49c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 49SFiwAqEbnlbw/y9MSbgoDoJryV8vtP+4ydlQMsPyCShNaROxQqxmI3fiP1mbr2InQdB+R1YyAkDPtP/PNBM+Qpb4nj3ZJU+gRc9bghDQbWzXIQ/NkhPwjQKELytfGVzWMixRnGM38byuHWvcwD+81rKfYKXlSbB+plV82X6NrqrjeLUNyrTWrkItD8R3TSmD5qsmtifsMmtD0buyBlIauBsWVufAVxfEwVUtIhA43X/M9CDFLI+Y4j4nYeLWurNtbMcZ1FW6tHBKeAppBYdHwaY3I4QPObJRJnlM2Ek7DYiaSraZvJySCR4wcIm0YTcWOOzCn14JNXbU/Lr6J9a/aOUjBtWJoIqBQ1qmoWfa0PGe6ELLs3Kke6NhQDysGJn5i3ob+Ui4zXjLb6P2do+IEgioRNq5IsrgnKExgj/ujy9Y+AH+iO/sdw6LVvIZnfWLol4S7irWilQ9XEgQaEMYY3b31usoseJ7oe/EPMB5TIKL9Aij5K21KaeOpA1BC5i+6nQx3LcNPmj6aDhRdhk+rY0JAs5C9zgd6BT8+JnHkVMre0Mom+IyqWvcISxGTB9YFvL+IYpVaw0ndyQzEIvkcAz9XefWaXZZ7ssaz9cGt0XtzVxJDrRRwVd0G+O9HanPfQW2gWS1fmg9iRY+eyEOMFzFLezJ9+7mxyXukSx2i6TBayJuDv+RpbL2tDp8pA7gPyUbW3kwcX4QOEKU9CYw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199015)(2906002)(66574015)(85202003)(36756003)(66946007)(66556008)(66446008)(2616005)(66476007)(41300700001)(76116006)(86362001)(85182001)(122000001)(38100700002)(6916009)(53546011)(83380400001)(8936002)(6506007)(54906003)(91956017)(38070700005)(186003)(1076003)(4326008)(6486002)(71200400001)(64756008)(8676002)(5660300002)(26005)(316002)(8976002)(6512007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmhXcGhBdTNGZFNKSnFvUkdRai81dkoxaVJLNmRtT0tmU2VuR0pwSXhWL0Vk?=
 =?utf-8?B?TTZ4WXNRNC9heWh3K3V0aTcvMkY3YVA2ODZzazN1R3lHOGdrdDZPWHh2dXJO?=
 =?utf-8?B?U2VUT2lCSmNrOERobWFUdGVzeENJL0lQZVZYUFFJeFNteVhjbXQwUzBoc2tq?=
 =?utf-8?B?blZLcDhLOE5sbEJnMVIvdlZUYkoxQ3BjbHVsRTI1ZTdJZmFHdnlQMjZsejRB?=
 =?utf-8?B?U05kMVhKWjRDT2MrU0t1cHY1M3N4OXprS2RvUThkU1c3T2tiWFlJc1JWRmFD?=
 =?utf-8?B?MjNhbTFJek5iNG13Zmo4WldkN0RDYVVEOVcxU1BWVENBRnFNc093Z05tMkw2?=
 =?utf-8?B?Yk5ZMFkvMEpkb2tZYUwwYURteWFXS1NQcW9vZmN3WmVGZCtMK0ZuUkxoVmV3?=
 =?utf-8?B?ZVZXV05zNm9XRmQ5VXRvYW5pNVNCaGRSSndTOUMvN0s4RTNmQTJKc2l6anVO?=
 =?utf-8?B?UkdSWWZhK20yZEkrWmNVU0NKOWZ4d05HWEZXMy9aOXBKS3FhYWFFVTFFOFhQ?=
 =?utf-8?B?NXViOU1nb05yOEQ4SHMyNlRLc1FOVmlkM2lKaWNkVjZhMlcwdmNrTzJYdDFX?=
 =?utf-8?B?MlZHS2NSWmJXbE5kVkFEVlFMRExUdm5pSUo4b2lpblhGMTNBRi84eEM4c1Ja?=
 =?utf-8?B?MzVTbWxnT201L2tUN01waUZKMS90MGM2NjZPcE9Xa21ITzFQdk1heFdwQ2hT?=
 =?utf-8?B?bHBxaktibHp3eEpaWGQ0Ym5KbjVqVmluQ1dqb3NMVUtFbUwybkk3NmNsOVpw?=
 =?utf-8?B?ZTFncXVyTXBVR0xGaEt0MkNJQTluUXc0TEtGUmorRHVrK25rWFdIR2VYUFJh?=
 =?utf-8?B?SWVjQytuNFBoTk9QN1R2U2ozV2xNdlZES056eUMxcnJMS3F5UVQxeG5wbWNI?=
 =?utf-8?B?N2FkSEFsSlgyeVpJb3pVRzdid3g4UWJJRmo3a3ZCa2ZmWnIyZFc2RDRjbDRE?=
 =?utf-8?B?NXR2RkJmWU0rbGQwcFVLVG1RSGkwUkJtdkFWeVlmenMxdGtzWnBrbUtyaGlK?=
 =?utf-8?B?c1NuMXprdXY3a2ZOYmovWXd5RnltRG0wUW9yYWpUdkVyamdZZzgySEZ6bnlj?=
 =?utf-8?B?NUpWZW1jV2pPVmdncmJXVm1VaVBHeklrcmVaWDlsSUxzR2pvTEZqRG9QREQ4?=
 =?utf-8?B?NzF5cGxiZE5XVk5rbzErV1FhZmN2UkMwamNnTVVYN2cvLzZjU0E0QTlKUFJH?=
 =?utf-8?B?UjJJWGN5OEVtbzFDcGpYcFZqa2xCWEtkTzZNd213bVptMHh6Wko5Y2FTOENm?=
 =?utf-8?B?dUFUTFVUVDBIMlFob2dQVGJYMGpraXU5YWtTSXBObFpDMGErVUd6d2h2eEJQ?=
 =?utf-8?B?OE9aUEtRcW11VEI4eFZxd1FNbFhlTE5uSFlaRkRXTnlhbEl5SndFRmJRWXNN?=
 =?utf-8?B?dG01blBtNUJ0ZzB0SERSNTNxRWZ1L3Z2eFpWZnppcjNaeTN4d2pJOVRVaGh2?=
 =?utf-8?B?TGdTTG96YUJETGJqcm9LQkZEZ1JnbjVWdFZTbHVZU3FWUzk5NVdiRkZqWDlZ?=
 =?utf-8?B?NVNJWDlqajhQSXNXWjlOQzNZbml1MzgveWx6ZHMwU2FVZ0ZjblU5NVluUFc3?=
 =?utf-8?B?em5ZUFhUOXplSWJCUElVM3hOUTQ3b3VVa1V4MW1wOHUrWW5HOTBvbXdGTldT?=
 =?utf-8?B?cmQxN0g2SVNKRndhSU9vcXdTRjB1c3lONC9HV0s2WEgzMW5HVW9ZVHNZUVJN?=
 =?utf-8?B?OS9WQmtxdlhtVDdLdmp1cnZDQWRvTnN1bWhPK0FJZExkSmc2aUdvL1UxUm03?=
 =?utf-8?B?OFRQUlo1c21tVEFFWldVOHdIazYwb2l0cHQwdCs1eUdVV2tmQVFhMnY4VjRB?=
 =?utf-8?B?MmJWKzVnN1FSdHBaN1k1YWtPdk5TZ1JOTVlFREg3YjVmRklOT05YR01PajFt?=
 =?utf-8?B?MEd4eGdOcy9VUTZLejVEb0x2VlZXdVFVQmQxK0tuU3lrQXFnaHdyVDg0eG5a?=
 =?utf-8?B?KzVsTHNVeFZleUYyTmdnWUdWdHNaYzJxRWJIOGlKK0luK1Y0WFBnYndxVS9M?=
 =?utf-8?B?UWQrRGhkSnQ5bU9lZ1BadVlFbXZvdVVLbnJMWFJJeW1SMjJkdVlYMFAyN09w?=
 =?utf-8?B?eDVQa0lqK1ZVNXNreUJTKytRSXZacC9MS0w5VTZrenpyNERxLzg0SkprR0ti?=
 =?utf-8?B?cjVLd0VESlVtei9tSGlUQXAyT2J1NExMeHBMVUhoQVV2cytQWDI5d3cyNUZD?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09C5B1C159C660418797B3D906F18D9D@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6063c8a8-8118-419a-c74f-08dac8bb49c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 16:46:34.8000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgOCca5AVRFJKIuNx1IyOCpOe0ZlaPtJvmQZZTErePGwifTxCwODsXbHr1mQzf5nxUvM8NfSKv4R+9G1oAwaSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8997

SGkgRGVuaXMsDQoNClRoYW5rcyBmb3IgeW91ciBxdWljayByZXBseS4NCg0KT24gVGh1LCBOb3Yg
MTcsIDIwMjIgYXQgMTA6Mjk6MjJBTSAtMDYwMCwgRGVuaXMgS2VuemlvciB3cm90ZToNCj4gSGkg
QWx2aW4sDQo+IA0KPiBPbiAxMS8xNy8yMiAwOToyMSwgQWx2aW4gxaBpcHJhZ2Egd3JvdGU6DQo+
ID4gRnJvbTogQWx2aW4gxaBpcHJhZ2EgPGFsc2lAYmFuZy1vbHVmc2VuLmRrPg0KPiA+IA0KPiA+
IElmIGEgQ01EX1RSSUdHRVJfU0NBTiByZXF1ZXN0IGZhaWxzIHdpdGggLUVCVVNZLCBpd2QgY3Vy
cmVudGx5IGFzc3VtZXMNCj4gPiB0aGF0IGEgc2NhbiBpcyBvbmdvaW5nIG9uIHRoZSB1bmRlcmx5
aW5nIHdkZXYgYW5kIHdpbGwgcmV0cnkgdGhlIHNhbWUNCj4gPiBjb21tYW5kIHdoZW4gdGhhdCBz
Y2FuIGlzIGNvbXBsZXRlLiBJdCBnZXRzIG5vdGlmaWVkIG9mIHRoYXQgY29tcGxldGlvbg0KPiA+
IHZpYSB0aGUgc2Nhbl9ub3RpZnkoKSBmdW5jdGlvbiwgYW5kIGtpY2tzIHRoZSBzY2FuIGxvZ2lj
IHRvIHRyeSBhZ2Fpbi4NCj4gPiANCj4gPiBIb3dldmVyLCBpZiB0aGVyZSBpcyBhbm90aGVyIHdk
ZXYgb24gdGhlIHNhbWUgd2lwaHkgYW5kIHRoYXQgd2RldiBoYXMgYQ0KPiA+IHNjYW4gcmVxdWVz
dCBpbiBmbGlnaHQsIHRoZSBrZXJuZWwgd2lsbCBhbHNvIHJldHVybiAtRUJVU1kuIEluIG90aGVy
DQo+ID4gd29yZHMsIG9ubHkgb25lIHNjYW4gcmVxdWVzdCBwZXIgd2lwaHkgaXMgcGVybWl0dGVk
Lg0KPiANCj4gVGhpcyBzaG91bGQgcmVhbGx5IG5vdCBiZSBwb3NzaWJsZSBzaW5jZSBhbGwgc2Nh
bnMgZ28gdGhyb3VnaCB0aGUgd2lwaHkgd29yayBxdWV1ZT8NCj4gDQo+ID4gDQo+ID4gQXMgYW4g
ZXhhbXBsZSwgdGhlIGJyY21mbWFjIGRyaXZlciBjYW4gY3JlYXRlIGFuIEFQIGludGVyZmFjZSBv
biB0aGUNCj4gPiBzYW1lIHdpcGh5IGFzIHRoZSBkZWZhdWx0IHN0YXRpb24gaW50ZXJmYWNlLCBh
bmQgc2NhbnMgY2FuIGJlIHRyaWdnZXJlZA0KPiA+IG9uIHRoYXQgQVAgaW50ZXJmYWNlLg0KPiAN
Cj4gT3IgYXJlIHlvdSBzZXR0aW5nIHVwIGEgc2Vjb25kIGludGVyZmFjZSBvdXQgb2YgaXdkJ3Mg
Y29udHJvbD8NCg0KVGhpcy4NCg0KPiANCj4gPiANCj4gPiBJZiAtRUJVU1kgaXMgcmV0dXJuZWQg
YmVjYXVzZSBhbm90aGVyIHdkZXYgaXMgc2Nhbm5pbmcsIHRoZW4gaXdkIHdvbid0DQo+ID4ga25v
dyB3aGVuIGl0IGNhbiByZXRyeSB0aGUgb3JpZ2luYWwgdHJpZ2dlciByZXF1ZXN0IGJlY2F1c2Ug
dGhlIHJlbGV2YW50DQo+ID4gbmV0bGluayBldmVudCB3aWxsIGFycml2ZSBvbiBhIGRpZmZlcmVu
dCB3ZGV2LiBJbmRlZWQsIGlmIG5vIHNjYW4NCj4gPiBjb250ZXh0IGV4aXN0cyBmb3IgdGhhdCBv
dGhlciB3ZGV2LCB0aGVuIHNjYW5fbm90aWZ5IHdpbGwgcmV0dXJuIGVhcmx5DQo+ID4gYW5kIHRo
ZSBzY2FuIGxvZ2ljIHdpbGwgc3RhbGwgaW5kZWZpbml0ZWx5Lg0KPiANCj4gU28gSSB0aGluayB0
aGUgd2F5IHRvIGhhbmRsZSB0aGlzIGlzIHRvIG1ha2Ugc2NhbiBhd2FyZSBvZiBhbGwgaW50ZXJm
YWNlcywNCj4gZXZlbiBmb3JlaWduIG9uZXMsIGFuZCBjb25zaWRlciByZXN0YXJ0aW5nIGEgc2Nh
biByZXF1ZXN0IHdoZW5ldmVyIGEgc2Nhbg0KPiBmaW5pc2hlZCBub3RpZmljYXRpb24gb24gYSBn
aXZlbiBwaHkgaXMgcmVjZWl2ZWQuDQoNClllcywgSSBhbHNvIGNvbnNpZGVyZWQgZG9pbmcgc29t
ZXRoaW5nIGxpa2UgdGhhdDoNCg0KLSBoYXZlIHNjYW5fbm90aWZ5IHRha2Ugbm90aWNlIG9mIGFs
bCBORVdfU0NBTl9SRVNVTFRTL1NDQU5fQUJPUlRFRA0KICBldmVudHM7DQotIGlmIGEgc2NhbiBj
b250ZXh0IGlzIGZvdW5kIGZvciB0aGUgd2RldiBhc3NvY2lhdGVkIHdpdGggdGhlIGV2ZW50LA0K
ICBwcmVzZXJ2ZSB0aGUgb2xkIGxvZ2ljOw0KLSBpZiBhIHNjYW4gY29udGV4dCBpc24ndCBmb3Vu
ZCwgdGhlbiBzZWFyY2ggdGhlIHNhbWUgcXVldWUgd2l0aCBhbg0KICBhbHRlcm5hdGUgbWF0Y2gg
ZnVuY3Rpb24gbGlrZSB0aGlzOg0KDQpzdGF0aWMgYm9vbCBzY2FuX2NvbnRleHRfbWF0Y2hfd2lw
aHkoY29uc3Qgdm9pZCAqYSwgY29uc3Qgdm9pZCAqYikNCnsNCgljb25zdCBzdHJ1Y3Qgc2Nhbl9j
b250ZXh0ICpzYyA9IGE7DQoJY29uc3QgdWludDY0X3QgKndpcGh5X2lkID0gYjsNCg0KCS8qIEZp
bmQgYSBzY2FuIGNvbnRleHQgb24gdGhlIHNhbWUgd2lwaHksIGFzIGl0IG1pZ2h0IGJlIGhlbGQg
dXAgKi8NCglpZiAoc2MtPndpcGh5X2lkICE9ICp3aXBoeV9pZCkNCgkJcmV0dXJuIGZhbHNlOw0K
DQoJLyogSXQgc2hvdWxkIGhhdmUgYSByZXF1ZXN0IHBlbmRpbmcuLi4gKi8NCglpZiAoIWxfcXVl
dWVfcGVla19oZWFkKHNjLT5yZXF1ZXN0cykpDQoJCXJldHVybiBmYWxzZTsNCg0KCS8qIFRoaXMg
bWVhbnMgdGhlIG5leHQgcmVxdWVzdCBpcyB3b3J0aCByZXRyeWluZyAqLw0KCXJldHVybiB0cnVl
Ow0KfQ0KDQotIHRoZW4gaWYgc3VjaCBhIHNjYW4gY29udGV4dCBpcyBmb3VuZCwgd2UgY2FuIHJl
c2V0IHRoZSBzY2FubmluZyBzdGF0ZQ0KICB0byBTQ0FOX1NUQVRFX05PVF9SVU5OSU5HIGFuZCBj
YWxsIHN0YXJ0X25leHRfc2Nhbl9yZXF1ZXN0KCkNCg0KSWYgdGhhdCBzb3VuZHMgc2VtaS1yZWFz
b25hYmxlIEkgY2FuIGRyYWZ0IGEgcGF0Y2ggYW5kIHdlIGNhbiBkaXNjdXNzIGl0DQpmdXJ0aGVy
LiBPbmUgdGhlb3JldGljYWwgc2hvcnRjb21pbmcgb2YgdGhlIGFib3ZlIGlzIHRoYXQgaXQgaXMg
bm90DQoiZmFpciIsIGkuZS4gaWYgeW91IGhhdmUgbXVsdGlwbGUgd2RldnMgb24gdGhlIHNhbWUg
d2lwaHkgdGhlbiB0aGVpcg0Kc2NhbiByZXF1ZXN0IHF1ZXVlcyB3aWxsIGJlIGZ1bGx5IGRyYWlu
ZWQgYmVmb3JlIHRoZSBuZXh0IHdkZXYgZ2V0cyBhDQpjaGFuY2UgdG8gc2Nhbi4gQnV0IEkgZ3Vl
c3MgaXQncyBPSy4NCg0KPiANCj4gPiANCj4gPiAgRnJvbSBhIHVzZXIgcGVyc3BlY3RpdmUsIHRo
aXMgbGVhZHMgdG8gYSBzaXR1YXRpb24gd2hlcmUgaXdkIHJlcG9ydHMNCj4gPiBvdmVyIERCdXMg
dGhhdCBpdCBpcyBub3Qgc2Nhbm5pbmcsIGJ1dCBpdCBuZXZlciBxdWV1ZXMgdXAgYW5vdGhlcg0K
PiA+IHBlcmlvZGljIHNjYW4uIE9yIGlmIGEgc2NhbiB3YXMgZXhwbGljaXRseSByZXF1ZXN0ZWQg
b3ZlciBEQnVzIGFuZCB0aGUNCj4gPiB0cmlnZ2VyIGZvciB0aGF0IHNjYW4gZW5kZWQgaW4gYW4g
LUVCVVNZIGZvciB0aGUgYWZvcmVtZW50aW9uZWQgcmVhc29uLA0KPiA+IHRoZSBEQnVzIG1ldGhv
ZCBjYWxsIHN0YWxsIGluZGVmaW5pdGVseS4NCj4gPiANCj4gPiBTaW5jZSBzY2FuIGNvbnRleHRz
IGFyZSBoYW5kbGVkIG9uIGEgcGVyLXdkZXYgYmFzaXMsIGFuZCBzaW5jZSBtdWx0aXBsZQ0KPiA+
IHdkZXZzIG1heSBpbiBwcmluY2lwbGUgc2hhcmUgdGhlIHNhbWUgd2lwaHksIHNvbHZlIHRoZSBh
Ym92ZSBwcm9ibGVtIGJ5DQo+ID4gaW5zdGVhZCBoYXZpbmcgdGhlIHNjYW4gbW9kdWxlIHNpbXBs
eSBwcm9wYWdhdGUgdGhlIC1FQlVTWSBlcnJvci4gSW4NCj4gPiBwcmFjdGljZSB0aGlzIHdpbGwg
bWVhbiB0aGF0IHNjYW5zIG1heSBmYWlsIG1vcmUgb2Z0ZW4sIGluIHdoaWNoIGNhc2UgYXQNCj4g
PiBsZWFzdCBvbmUgZGVmYXVsdCBlcnJvciBtZXNzYWdlIHdpbGwgYmUgbG9nZ2VkIGVhY2ggdGlt
ZToNCj4gDQo+IEkgZG91YnQgdGhpcyBpcyBhIGdvb2QgaWRlYSB1bmxlc3MgeW91IHdhbnQgdG8g
dmlzaXQgZXZlcnkgY2FsbCBzaXRlIHRoYXQNCj4gaW52b2tlcyB0aGUgc2NhbiBsb2dpYyBhbmQg
bWFrZSBpdCBoYW5kbGUgLUVCVVNZIGdyYWNlZnVsbHksIHNpbmNlIGl0IGlzIGENCj4gYml0IG9m
IGEgc3BlY2lhbCBjYXNlLg0KDQpPSywgbGV0IG1lIHRyeSB0aGUgb3RoZXIgd2F5IHRoZW4gOikN
Cg0KS2luZCByZWdhcmRzLA0KQWx2aW4=
