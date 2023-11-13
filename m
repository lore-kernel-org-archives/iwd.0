Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2112.outbound.protection.outlook.com [40.107.14.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6224019465
	for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="lLaRXoI+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bj4ppDIGhVHthkwSGee/jyQ5BwFS97a6YHrRzvzhN6aDpc3T2bZ89oZW30Bvow1zrp0sq1pwt41bVsch7j+CpHBEG9YOBMsPFrFI5+DQxWefR+jzLrRKIXIJXxfFmTjBayAett87b/+5n4C9D378M12/xWvyn1/Pgb4PHJJbq5G1lGfonqud8t/9ti/0xKXulaOXI2vZlWovz7OXEE9HgKRkXYOR2VnpC1N2pbuSzmOk9sZUNSnVCL02Keoz72lRA8fMjU+ykdM16Ve2Ppp00Gwv2YmYTq4Is+SfoKP7+RcpNKPumnwm25aYyGzB6hvKweSYL2BUlgTZEHmNo+Qwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eiPYyVxH3foCYbD2wv816HltYLhOAh9+nXgiBoqIsU=;
 b=kcCWkFSXOvc+oaWbtWM/YEW3nz9bjukD5tF2Qji4YgfD1g+TStBO/PEeu4AFJYD9BKavYVsxQbzAHsHin3nEbaAnEVI+pLDml7ycgmt7ZK3kcsf8Csr6ORKoJLULz/eGp7q45gP+4djApF/tXImAcwI1lRPDiPEsXr8YhYt2xOXnZHLRW5Pl0i1eNFLQVuOOoUfW7RLrHC5PMknRTx1T+KNh1VnEB/ySfI56Hde8mHrQO04A/XfbcruFvR2UcdvenM0xeACaMTrk89D/iC0+arBjygCVFfJdCKYewFaG4OddIcS0xGynJscXtgS/oSX8p3+Sxvw40y1FzpBxMZ33yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eiPYyVxH3foCYbD2wv816HltYLhOAh9+nXgiBoqIsU=;
 b=lLaRXoI+wXvwjpQx5QcfgPI+SNxNmenwgGY3KgwgQFlF0ou522vH0RLgWeG+TwhEZtLOpdV16qaG1OLWQHoVZSDS65XNJWWOzHZEvRHw2gEnGpRhTUtybfJpxrjw2uC39xB0LSpmIlWTJ3HbJh+JinSEArkTiz8vOwH8bj9B5dM=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by PAVPR03MB9232.eurprd03.prod.outlook.com (2603:10a6:102:32f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 12:46:34 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 12:46:34 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: James Prestwood <prestwoj@gmail.com>
CC: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>, "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>, Dimitrios Karnikis <DIKA@bang-olufsen.dk>, Claudio
 Cabral <CLCA@bang-olufsen.dk>, =?utf-8?B?UGVkcm8gQW5kcsOp?=
	<PEDA@bang-olufsen.dk>, Johnny Kudahl <JOY@bang-olufsen.dk>,
	"achyut.hegde@nxp.com" <achyut.hegde@nxp.com>, "yuvraj.singh@nxp.com"
	<yuvraj.singh@nxp.com>
Subject: Re: [PATCH] station: handle ROAMING state in disconnect event (again)
Thread-Topic: [PATCH] station: handle ROAMING state in disconnect event
 (again)
Thread-Index: AQHZZjdUs9XT8avmIkmHb8xm4XdbCa8aLL8AgV9lpgA=
Date: Mon, 13 Nov 2023 12:46:34 +0000
Message-ID: <lrv3ytp7a6jvuupcu4pvx2w5jmud4yj6jxbk4imflcqeuosugo@vu7fco6auklk>
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
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|PAVPR03MB9232:EE_
x-ms-office365-filtering-correlation-id: e5a8f18a-03ff-4376-571b-08dbe4469179
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hM4G+Fpg5Pe05lRjABhE9esgT7DbhemVbfVZgmNCPOvCzjiiY6l8nGJqLZMeqUxVhxw1C7a+KNciW+EUu8Z/yjNQlsv6OlWFr1N95LjMOURio7uZKCG6EdCO0uGcHA/c+PDLFTfB/J3SQp/zH4R2DEMztN7t8QCYlPy22SesP2VGkonBK80NvxYSz7n/jVO/DRHSIHD6Lq+wKS93XkgiTg/TAAFRE+sBpwtNGjZsnHAXszSLrMaEvbf/lCI8CqTnueyFnSNxLgmYfFgkQxGHTQQutt9u8BtdbyJucAd7hXCNZ7h4lNAb1O+bGvlfpiVasvJww6hB5DaO36pzFnOrbAdwQ/qKwh/ecdoZMh81Gf6k2pRe3/UgzXZAIOA11vbF6s+ZZLY/fU0Wa5i/DlaewIfASeA3WpgIxeTmfeac+uyPj1OJb6jR5QnP4awOmngHiIm4IMicDoAzndl8B8ngy77xjtvtgR1Obi9pdznGv4S4EYKhufSPwYQc/G7+bsoa32t6fq1OppL5AOuXablPwMu5QJSsx55zV51Mgdm920nyEcTsyp1bYCsWlP4Et2gfYuZAmETNeCkq25Q2fbLwCwAttCamPSaef6rA34FDPTQegPGRAxTM7hQnRmiaAflU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(136003)(39850400004)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(66574015)(33716001)(53546011)(71200400001)(6506007)(6512007)(9686003)(83380400001)(5660300002)(8676002)(8936002)(41300700001)(4326008)(2906002)(6486002)(478600001)(316002)(6916009)(91956017)(54906003)(64756008)(66446008)(66476007)(66946007)(76116006)(66556008)(122000001)(86362001)(85182001)(85202003)(38100700002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFd1aTZ2Ti96emRtN0RLR3JaS0wrYjA2UkJ0NWFsY1JhMVpMSEt1cGFUN09m?=
 =?utf-8?B?Z1VnUU9FVVdwVnF5RC9oZDR3aGg1Mm9oQTB0OG91d1JzZmd0bkIrWFh1RE9C?=
 =?utf-8?B?UXQ1Q2tFMCsrYVJ6NHltQTREWTc2TGYxRDdFMUZ1QmhyUndsdDRmOTJQS0pP?=
 =?utf-8?B?OGp2VjZPTW9iREJScVdkaDBESUdKS1VvU2xib3FYSGxsY1hTc3drREVPS21G?=
 =?utf-8?B?K3RvZG8xdzNrRHpucEhRaTlneXc0WmdLcC93YkEraGJVUjZ0bnlXYVEzTmpl?=
 =?utf-8?B?NFc4bkJaM1F3djdJUDJvTXM4d09OWVBZeGVycVRhTjRORy83amlHbVlla3Np?=
 =?utf-8?B?UG90LzdwRmZBN1RCd3hrTVczbXlzaEtBRVZ5SWoyZExML2dRWmVqUGplY05j?=
 =?utf-8?B?M2dHS3h0dFVZVlNhaWh1RFR3TXZZYjM4WFM0dHQxQTl1bVQzQWtxM3BCN0lT?=
 =?utf-8?B?R05JR0RmQkpIY2FpZnMzazV0K3NCemV5dk1PS2RoSk94OXhXQ0FUTW9NZW15?=
 =?utf-8?B?L05jUkpXbDljYjVqdDh3YlpVUjBjR0JWR1hJb2VYRnY3ejgySGlLaGl1aHYv?=
 =?utf-8?B?L0ZwQ1g1Z0lhcU4wbHdpcHdYSkx5TEJwb0tKbE9yZktqR1RlVjFRSkt3SUpW?=
 =?utf-8?B?dStMU2dnSjFCTzhoTnRJWFQraHpqN1EyNUt4RWZTeWNldm5nWVVoN3FPbzhK?=
 =?utf-8?B?QkFzRmg3Qy9lWTN4NVdndEh2RnRseFNvVG9vVXJwb3Z5Ny9XM0xiL3VXV245?=
 =?utf-8?B?TmEveXVaNnlwdXRrZzY4d2dNaFRSVnByK2RXMDNsT0NzMjhEbGJmR2ZYejVt?=
 =?utf-8?B?TWR2eFZURDVqMDhlYjdUMU5PRGdVR2lLdHBUVEQrUHFjUktneXRJOWI1V0lL?=
 =?utf-8?B?cnBUbGhocmVVMktXUHc4Mjd2WVpXOGRsalNQRTdEaSs1cWE2UURLU1FGMVlF?=
 =?utf-8?B?YTRKczdYMHlTQzE5ZGQrV3E0NlRzTlgwNkkwMkE1QnRCM2xTZ2o1cER3c2RT?=
 =?utf-8?B?SzMwMWwveDVyOTI2TFhVVGtuUFZRc3JFMW81MU9aQjdoSGJqNTY2ck1KOWVq?=
 =?utf-8?B?aXJkRFdSN1VyRlBJakhFSjVFZkxIUkVnWHdqTHNKMzBWVWE3Z3d1bkl1UE5I?=
 =?utf-8?B?eWcyOEFHTlp1NkxScmU5b2ZYRW5DdHh2clNpaDZlYTNMVUw1b3ZNOHFWMmVm?=
 =?utf-8?B?ckNPYXR6Z2FGT1RtdTRMTVNsZlpTdGJRT2QxWUU5QjRxU0E2Mld1NmdHTGNR?=
 =?utf-8?B?TENHQ21ZRy95U2Y5OWhScnpsdGV1RTBva21LYkt6MkxvNHU3MFBNaTdGSHJC?=
 =?utf-8?B?RDl2dzVVTDM4MG9KRXd3c0tsNzJSek5GTUhyNUt4M2tWempLQ25xT083N21t?=
 =?utf-8?B?cmRYSUdrQ0hwZW9ncEtnU2N2Y0pqRjFqdldwVEdPclBEVGxTeUxsNlpVUEtS?=
 =?utf-8?B?d0tzRi9CN2Q0QkF6MlFNWlJoWUpxeVg0T1VBRXdGclBEeXdDZmptVmdRY3ZX?=
 =?utf-8?B?cjJjSUJDUmh5eG00S0hmYjNwTWhGZ1ZudkFlVWxjSldqaUFZeUhQTit5VThS?=
 =?utf-8?B?SS9KUzZvcnNXKzVYWmZqTCtGelVycmUrR2Q1bE1zTFVMWHkxUzNvL09MR3h3?=
 =?utf-8?B?cTIvWkM2RVFLSFJ4bFA2eUVjWXQ3QndRaVVPaUF2dThsa0J2S2JONWFKR0RP?=
 =?utf-8?B?WVhEUDU0cGRWR2xNbWNLWm1UQ0xEQ0JOcjNBSGJKTHJVUXZkSHhuOVVXS3I5?=
 =?utf-8?B?c2hXbnUwR2JwaGdDU2pSNUtvZEpndXJDb1JYa2l2Uk93bjdMYnYwOWU5WHJO?=
 =?utf-8?B?bms0L0JwUVpPUnVDSXZEL2dQenlVOUp5eHlsZmZSL25wOWVvUkJwdzVXNHh1?=
 =?utf-8?B?NURxMDNtMzQ1dlhmdC95Vkh1VlRJSjBFNDdlZlErdURaRWxZWncwc0JVVHZj?=
 =?utf-8?B?b2pRbkExMlpxZGlvdm9kUyt0MVVyeUJWWm1YdWd0cVZkU1hHNS90WWhyQ2Rz?=
 =?utf-8?B?NXBPZG9oMFR5T2lSTWhnejJ0UW5KWTJoWFVRVFlFSGlBQkIwZGh3ZGJQejNl?=
 =?utf-8?B?bFlVYzBQK1dpeFNBTWtEUTh3aEYveGVCVzlsMDAyWHRmM0M1NGZ3SThabE82?=
 =?utf-8?B?dzRCL2pEanVWejViSHRaWFMxeXNwSGdaWXJhRExhTjl6aEUwZk1YWVNYc1ZZ?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A69ECD78576E00439B97727E24083ABB@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a8f18a-03ff-4376-571b-08dbe4469179
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 12:46:34.2030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nDjDY/+iW3Bb4Du0jvP8yJDOuTtCRbVFs9KsE3eXbDk0jNBfo30UP+Gl1sT5LJY19mmEnASlADuwXsjNWQT53Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9232

SGVsbG8gYWdhaW4gSmFtZXMsDQoNCkknbSByZXN1cnJlY3RpbmcgdGhpcyBvbGQgdGhyZWFkIGJl
Y2F1c2Ugd2UgYXJlIGhpdHRpbmcgYW5vdGhlciByb2FtaW5nIHJlbGF0ZWQNCmlzc3VlIGFuZCBJ
IGFtIG5vdCBzdXJlIHdoZXRoZXIgdGhlIHByb2JsZW0gaXMgaW4gaXdkIG9yIGluIHRoZSB3aXJl
bGVzcw0KZHJpdmVyL2Z3LiBJIGhvcGUgeW91IGNhbiBoZWxwIG1lIHdpdGggc29tZSBsb2cgYW5h
bHlzaXMuDQoNCk9uIE1vbiwgQXByIDAzLCAyMDIzIGF0IDAzOjM1OjI4UE0gLTA3MDAsIEphbWVz
IFByZXN0d29vZCB3cm90ZToNCj4gSGkgQWx2aW4sDQo+IA0KPiBPbiA0LzMvMjMgMDc6MTksIEFs
dmluIMWgaXByYWdhIHdyb3RlOg0KPiA+IEZyb206IEFsdmluIMWgaXByYWdhIDxhbHNpQGJhbmct
b2x1ZnNlbi5kaz4NCj4gPiANCj4gPiBUaGUgYmxhbWVkIGNvbW1pdCBjbG9iYmVyZWQgdGhlIG5v
bi1GVCAoUmVhc3NvY2lhdGlvbikgcm9hbWluZyBjYXNlDQo+ID4gaW4gdGhlIGRpc2Nvbm5lY3Qg
ZXZlbnQgaGFuZGxlciwgY2F1c2luZyBpd2QgdG8gcG90ZW50aWFsbHkgZ2V0IHN0dWNrIGluDQo+
ID4gdGhlIFJPQU1JTkcgc3RhdGUgYWZ0ZXIgYSBmYWlsZWQgcmVhc3NvY2lhdGlvbiBkdXJpbmcg
bm9uLUZUIHJvYW1pbmcuDQo+ID4gQWRkIGl0IGJhY2suDQo+ID4gDQo+ID4gVGhlIHN1YmplY3Qg
aXMgaW5zcGlyZWQgYnkgYSBwcmV2aW91cyBjb21taXQgd2hpY2ggZGlkIHRoZSBzYW1lIHRoaW5n
LA0KPiA+IGJ1dCBpbnRyb2R1Y2VkIGJlZm9yZSB0aGUgbmV3IHJvYW1pbmcgc3RhdGVzIHdlcmUg
YWRkZWQsIG5hbWVseSBjb21taXQNCj4gPiA4NzU4Y2M4OTQ4N2IgKCJzdGF0aW9uOiBoYW5kbGUg
Uk9BTUlORyBzdGF0ZSBpbiBkaXNjb25uZWN0IGV2ZW50IikuIFRoZQ0KPiA+IHJhdGlvbmFsZSBo
ZXJlIGlzIHRoZSBzYW1lLg0KPiA+IA0KPiA+IEZpeGVzOiBlZGY1NTZjYzdiYjkgKCJzdGF0aW9u
OiBhZGQgdHdvIG5ldyByb2FtaW5nIHN0YXRlcyAoRlQvRlcpIikNCg0KVGhlIGxhc3QgdXBkYXRl
IEkgZ2F2ZSB3YXMgb24gYSBzaWxlbnRseSBkcm9wcGVkIGZyYW1lIGluIHRoZSBmaXJtd2FyZSB3
aGVuDQpkb2luZyB0aGUgNC1XYXkgSGFuZHNoYWtlLiBUaGlzIHdhcyBmaXhlZCBpbnNpZGUgdGhl
IHZlbmRvcidzIGZpcm13YXJlIHNvIHRoZXJlDQppcyBub3RoaW5nIGZ1cnRoZXIgdG8gZGlzY3Vz
cyB0aGVyZS4gU2VlIGJlbG93IGZvciB0aGUgY3VycmVudCBpc3N1ZSB3ZSBhcmUgZmFjaW5nLg0K
DQo+IA0KPiBJSVJDIGxlYXZpbmcgb3V0IHRoZSBvbGQgUk9BTUlORyBzdGF0ZSBpbiB0aGlzIHN3
aXRjaCB3YXMgYWN0dWFsbHkgZG9uZQ0KPiBpbnRlbnRpb25hbGx5LiBUaGlzIGlzIGJlY2F1c2Ug
bmV0ZGV2X3JlYXNzb2NpYXRlKCkgdGFrZXMgYSBjYWxsYmFjayBhbmQgYW55DQo+IGZhaWx1cmVz
IHdpdGggdGhlIHJvYW0gKnNob3VsZCogc2hvdyB1cCBpbiBuZXRkZXZfY29ubmVjdF9ldmVudCgp
LCBhbmQgaW4NCj4gdHVybiBjYWxsIHRoZSBjYWxsYmFjayB3aGljaCB0aGVuIGxlYWRzIHRvIHRo
ZSBzYW1lIHN0YXRpb25fZGlzYXNzb2NpYXRlZCgpDQo+IGNhbGwuIFdlIHdhbnRlZCB0byBhdm9p
ZCB0aGUgcG90ZW50aWFsIG9mIGEgZGlzY29ubmVjdCBldmVudCBBTkQgdGhlIGNvbm5lY3QNCj4g
Y2FsbGJhY2sgYm90aCBjYWxsaW5nIHN0YXRpb25fZGlzYXNzb2NhdGVkKCkuDQoNCk9LLCBzbyB0
aGlzIG1ha2VzIHNlbnNlLCBidXQgSSB0aGluayB3ZSBhcmUgaGl0dGluZyBhbiBlZGdlIGNhc2Ug
aW4gb3VyIHRlc3QNCnNldHVwIHdoaWNoIHNsaXBzIHRocm91Z2ggdGhpcyBsb2dpYy4gQWxsb3cg
bWUgdG8gZXhwbGFpbi4NCg0KV2UgaGF2ZSBhbiBhdXRvbWF0ZWQgdGVzdCBzZXR1cCB3aXRoIHR3
byBCU1NlcyBpbiB0aGUgc2FtZSBFU1MgYW5kIHByb2dyYW1tYWJsZQ0KYXR0ZW51YXRvcnMgdXNl
ZCB0byBzaW11bGF0ZSBhIGxvdy1SU1NJIGV2ZW50IG9uIHRoZSBzdGF0aW9uLiBUaGUgc2VxdWVu
Y2Ugb2YNCmV2ZW50cyBiZWxvdyBiZWdpbnMgd2l0aCB0aGUgc3RhdGlvbiBjb25uZWN0ZWQgdG8g
dGhlIGZpcnN0IEJTUyAoQlNTMCksIGFuZCBpdA0KaXMgZXhwZWN0ZWQgdGhhdCBpd2Qgd2lsbCB0
aGVuIGRpcmVjdCB0aGUgZHJpdmVyIHRvIGFzc29jaWF0ZSB0byB0aGUgc2Vjb25kIEJTUw0KKEJT
UzEpLiBUaGlzIGlzIHdpdGhvdXQgRlQgcm9hbWluZy4NCg0KMS4gaXdkIHJlY2VpdmVzIGEgQ1FN
IGV2ZW50IGFuZCBlbnRlcnMgcm9hbWluZyBzdGF0ZS4NCg0KMi4gaXdkIGlzc3VlcyBhIENNRF9D
T05ORUNULiBUaGUgZHJpdmVyIGRlZmluZXMgLmF1dGggYW5kIC5hc3NvYyBvcHMsIG5vdA0KICAg
LmNvbm5lY3QsIHNvIGl0IHRha2VzIHRoZSBTTUUgcGF0aCBpbiB0aGUga2VybmVsLg0KDQozLiBB
dXRoL0Fzc29jIGFyZSBzdWNjZXNzZnVsIGFuZCBCU1MxIGtpY2tzIG9mZiB0aGUgNC1XYXkgSGFu
ZHNoYWtlLg0KDQo0LiBBZnRlciBlbnRlcmluZyBlYXBvbF9oYW5kbGVfcHRrXzNfb2ZfNCgpIGl3
ZCBhc3luY2hyb25vdXNseSBpbnN0YWxscyB0aGUga2V5cw0KICAgd2l0aCBDTURfTkVXX0tFWSBh
bmQgdGhlbiBkZWxldGVzIHRoZSBFQVBPTCB0aW1lb3V0Lg0KDQo1LiBUaGUgZ3JvdXAga2V5IGdl
dHMgaW5zdGFsbGVkIHN1Y2Nlc3NmdWxseSAoQ01EX05FV19LRVkgcmV0dXJucyBzdWNjZXNzKS4N
Cg0KNi4gSW4gdGhlIG1lYW4gdGltZSBob3dldmVyIHRoZSBzdGF0aW9uIHJlY2VpdmVzIGEgRGVh
dXRoIG9yIERlYXNzb2MgKG5vdCBjbGVhcg0KICAgZnJvbSBvdXIgZHJpdmVyIGxvZ3MpIGFuZCB0
aGUgZHJpdmVyIHNlbmRzIHRoaXMgdG8gaXdkLiBJbg0KICAgbmV0ZGV2X2Rpc2Nvbm5lY3RfZXZl
bnQoKSBpd2QgdGhlbiBmb2xsb3dzIHRoaXMgcGF0aDoNCiAgICAtPiBuZXRkZXZfY29ubmVjdF9m
cmVlKCkNCiAgICAgIC0+IGhhbmRzaGFrZV9zdGF0ZV9mcmVlKCkNCiAgICAgICAgLT4gbmV0ZGV2
X2hhbmRzaGFrZV9zdGF0ZV9mcmVlKCkNCgkgIC0+IG5ldGRldl9oYW5kc2hha2Vfc3RhdGVfY2Fu
Y2VsX2FsbCgpDQoJICAgIC0+IGxfZ2VubF9mYW1pbHlfY2FuY2VsKG5sODAyMTEsIG5ocy0+cGFp
cndpc2VfbmV3X2tleV9jbWRfaWQpOw0KDQogICBUaGVuLCByZTogdGhlIG9yaWdpbmFsIHBhdGNo
IGluIHRoaXMgdGhyZWFkLCBpd2QncyBzdGF0aW9uIGNvZGUgaWdub3JlcyB0aGlzDQogICBldmVu
dCwgYmVjYXVzZSB0aGUgc3RhdGlvbiBzdGF0ZSBpcyBST0FNSU5HLg0KDQo3LiBUaGUgc3Vic2Vx
dWVudCBDTURfTkVXX0tFWSB0aGVuIGZhaWxzIGluIHRoZSBkcml2ZXIsIGJ1dCB0aGUgYWJvdmUg
Z2VubA0KICAgY2FsbGJhY2sgaXMgbmV2ZXIgaW52b2tlZCBiZWNhdXNlIGl0IHdhcyBjYW5jZWxs
ZWQuDQoNCkluIHRoaXMgd2F5IG5laXRoZXIgdGhlIHN0YXRpb24gbm9yIHRoZSBoYW5kc2hha2Ug
Y29kZSB0aGVuIHJlcG9ydCB0aGUgZXJyb3IsIHNvDQp3ZSBnZXQgc3R1Y2sgaW4gYSByb2FtaW5n
IHN0YXRlLg0KDQo+IA0KPiBEbyB5b3UgaGFwcGVuIHRvIGhhdmUgYW4gaXdtb24gcGNhcC9sb2cg
b2YgdGhpcyBiZWhhdmlvcj8gSWYgaXRzIGEga2VybmVsDQo+IGJ1ZyBhbmQgYSBDTURfQ09OTkVD
VCBjb25uZWN0IGV2ZW50IG5ldmVyIGNvbWVzIHRoZW4gd2UgcHJvYmFibHkgZG8gbmVlZA0KPiB0
aGlzIHBhdGNoLCBidXQgbWF5YmUgaW5zdGVhZCB3aXRoIGFuIExfV0FSTl9PTiBvciBhIGJpZyBk
ZWJ1ZyBwcmludCBiZWNhdXNlDQo+IGl0IHJlYWxseSBzaG91bGRuJ3QgYmUgaGFwcGVuaW5nLg0K
DQpZZXMsIEkgaGF2ZSBhbiBpd21vbiBwY2FwIGFuZCBhbHNvIGEgam91cm5hbCBsb2cgd2l0aCBp
d2QgYW5kIGtlcm5lbC9kcml2ZXINCmRlYnVnIG1lc3NhZ2VzLiBIb3BlIGl0J3MgT0sgd2l0aCB5
b3UgdGhhdCBJIHNlbmQgaXQgaW4gYSBwcml2YXRlIG1haWwuDQoNCkkndmUgcHV0IHNvbWUgZW5n
aW5lZXJzIGZyb20gTlhQIG9uIGNjIGFzIHdlbGwsIGFzIHRoZXkgYXJlIGhlbHBpbmcgdXMgd2l0
aCB0aGlzDQpjYXNlIG9uIHRoZSBkcml2ZXIvRlcgc2lkZS4gVGhlIGRyaXZlciBpbiBxdWVzdGlv
biBpcyB0aGUgb3V0LW9mLXRyZWUNCk1hcnZlbGwvbW9hbC9tbGFuIGRyaXZlci4NCg0KSSBoYXZl
IG5vdCB5ZXQgdGVzdGVkIHRoZSBwYXRjaCBpbiB0aGlzIHRocmVhZCBmb3IgdGhpcyBwYXJ0aWN1
bGFyIGlzc3VlLiBGaXJzdA0KSSB3b3VsZCBsaWtlIHRvIGhlYXIgeW91ciB0aG91Z2h0cy9mZWVk
YmFjay4NCg0KVGhhbmtzIQ0KDQpLaW5kIHJlZ2FyZHMsDQpBbHZpbg==
