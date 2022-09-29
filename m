Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2090.outbound.protection.outlook.com [40.107.22.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0931107
	for <iwd@lists.linux.dev>; Thu, 29 Sep 2022 08:44:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C701eORDehN/ntIE3mFJQTNGmg8I2R1JE6Zhbc5zsVxEWzqi1wxmXok4jSCjE5Z6ZlAdfUJMIhjkdO7Iz6gF5ylwj/S8os8gE7+ddgv7AapiEKj37WRx/mbIj/tYluM9edYuOebPHyzrUkfVtIYJdmCuu2ZVEbGntBpvOJ+7Sash0NBRwd9IY3DUxON72PgO7Hl6NQnqITAq1JAxfH+95JVsPGzG2JKP/zrJYH8KjHrxS+on4Vaiow2svsclHOIpfMN3+cRif6NhMW6/Z4PNPD5w3l3gTLxXVNkPEv74nkQSihTfWq2Yu8/SGRk1TF/nha0Jra2w3iZOKETOCbI3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qx/60IvVTQH/P8Y6vj+I+FtK4Xm8ufQrWzdn1iqgL0Q=;
 b=TSWRoh7ouYfYsPnVNnc/Lonqnfd2hei6QuzIITJEqOsuNMP44KzUJV42d3s7XFNboANESk2PE2y0dcNrcqvU+CaUFVLNP2Ti4dLLs23IbIyS0hkhh1Sy70W0lc3JQ1FDbQ9SjwWTWjCYk4qftTpIawautA1mdzR8xhZfJd0NCZAVEFUhvdGN7BTBamRdnZwKEVqobb8zHBslMVud44x+eDznAhIsMThh3J/otXeb/vd4YccQlQeC3iknHkmPNFESAbTYQHj5kc2wpt9uFIp3MPeBRmd4UHVkOWvttTF2Yp4Hh1J2fTvRh2/D5haT45LjizMxMmHhXVBAFjkYL4IQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx/60IvVTQH/P8Y6vj+I+FtK4Xm8ufQrWzdn1iqgL0Q=;
 b=p+f+c3MhGSZjtARzpk3eIhniDMg/8OHpO3bLJ7SAJm/DmpMnkNS5chFlYPxWH3LAkuhIte2bE3XwprMstU8mXP+KD+vi8rI8Qp/jjhPVjneNOgzj03vEumrhjdt76QlmDL2S2IwHdjAI6b82m/xKok2++99y0XaQneVvFyKp6Xo=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AS8PR03MB9242.eurprd03.prod.outlook.com (2603:10a6:20b:5b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Thu, 29 Sep
 2022 08:44:38 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::f17f:3a97:3cfa:3cbb]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::f17f:3a97:3cfa:3cbb%5]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 08:44:38 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: James Prestwood <prestwoj@gmail.com>
CC: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Re: [PATCH 1/2] station: add two new roaming states (FT/FW)
Thread-Topic: [PATCH 1/2] station: add two new roaming states (FT/FW)
Thread-Index: AQHY02rfZIBegYLAnE2smZ1bfqKVJa31Ni8AgADiZIA=
Date: Thu, 29 Sep 2022 08:44:38 +0000
Message-ID: <20220929084437.b4ycqqouia2bxnng@bang-olufsen.dk>
References: <20220928183351.363600-1-prestwoj@gmail.com>
 <20220928184817.nwc3w4awwsssv32x@bang-olufsen.dk>
 <7c06640fa31b8844b55349f4edb93fd0d6ee0e13.camel@gmail.com>
In-Reply-To: <7c06640fa31b8844b55349f4edb93fd0d6ee0e13.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AS8PR03MB9242:EE_
x-ms-office365-filtering-correlation-id: c2d03fcb-847a-4bfd-f2f0-08daa1f6d809
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RDsMZmuPGBcgjrt74CI3bsoSQbze3+NMYaryJr2wwkTHU8B/jzCSVOMILQlWQ4VA4bDCck2eFVuYn9hLhR9NPErluZ3fkQgcfY3CS2jlgBTpAjXlklSFSD8I1g0R7FBcowIWdsMAr6ZEzNY9Pg6mWOnZZYLC7e8QtiWH2ELyB62WAoJs0EJLj2YVQyt5dQMFfN3kQBiXFKotIDljAIFl8ftrfJMgsMf3b+VLvfEz1LT6dLWQlrEVO8SKZdg3yGXUGgb4UhDReEj46F5Gh9N8+F3CflwTXef0ui+QOPti8oscDgkRpIf0CBXL+UrP5RSrM5iMTcQjwGb0q+RudV3GioGf/tcuT0WYWKW39AqvlvDy8W93l63KcoW1h1kLZAvFzqrJ749lq4LS6ky2AQz3OO4jZTa+93D+jST6IChwvnrPWGMazzTz/3zP3wx6YRXQdkWuVlQqNkycnz+Ri6f3qsnhghHxl9PkYfTjQLFJ6lz7EFOWV2IWV+ct1fGCzi5I7n/1O79wkc7PhHY5/NB8eolvFj9z7nwB++C6LTTx3aJDGZ/tOORaR6cR1TbtOuvZrlXoLN1oZVzTM0UVr5ukBJ2qKF987PhA5DQ2r7XFN66f1ooEVahNJg9s+cAJa05f9+Qag8TD1IjQB0nwt6C8dL47RXz63ki/jpchYdrdWpc3q6fDs9TPXyWGnrCR6BFMf+V54bxxxZzZZ0bP4oqrN93VMpLfONhwKWsU+dkefZJeZ0i+8d23Z8Bf064r5zBn1OWt62TFtomg/AeEUCCMUA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(2616005)(66574015)(1076003)(122000001)(8976002)(83380400001)(186003)(38070700005)(66446008)(2906002)(8936002)(66556008)(478600001)(91956017)(71200400001)(6486002)(66476007)(8676002)(76116006)(64756008)(6512007)(26005)(316002)(66946007)(41300700001)(38100700002)(6506007)(5660300002)(6916009)(36756003)(85202003)(86362001)(4326008)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bCswZTYzOHRzWE10Ry9Gek9TNDdhdUlDZHZkbFpzVDlFTFFBZmRjdnFjL3VL?=
 =?utf-8?B?Y1FueW9CQjdldE5UVVVScFlvU2JlMC9LaWdRcGZNVVNFUlg5ZGRvK3piYkh0?=
 =?utf-8?B?WXhsOXhGbitudWx5OXN1c0NMc0dqanVzWXQ3WmcySUxTdEVrN0hnTUZBdVB6?=
 =?utf-8?B?eDJRT3NLemJZV0lWWGRlV2VMZ2ZYQ3crc0dzQVF2bUh5cEJOZ3lDSTlGSk52?=
 =?utf-8?B?OWJMa0Ywd2VGRnA0bXhaeFNYRW12TkNlR2dxSWpERk8zZHZia3FWVGZtL2p2?=
 =?utf-8?B?RkhBSXY0N2FKWWZpT081cWtaWWhyRWNBTzMwdVM1dVI5WldUcEsrLzNnL3E4?=
 =?utf-8?B?ekgyN3JjNURuRkZPWVZVaXR3QTd3eXNuWGN2Zm84c29EY0xGNFhLZ1l3eWJD?=
 =?utf-8?B?THRXV2tVSnQzQ0t5TzFtK1pKbEJGeHRDclZCYW1PNks3azVIc1RSWlVZSzdY?=
 =?utf-8?B?Z0ZwejRyR3dCYlJLTU1KcC9JWlFNZDBRQXFnU2hzYW5lQmNGZFgxNnZVemhD?=
 =?utf-8?B?TEFUTmtBODUxU29yZzB2My80WmZTcE9iU2pGdENRVW4rYTNtK0VrV0hZcWk5?=
 =?utf-8?B?UkFsVEVXaG1rQS9XUzN1bTVrMlMvdFVmMjJUc3JTUFJ1czJjTlNveFFFVmdG?=
 =?utf-8?B?eGxva0QzUHpyZTQ5N3hzTjlSM3BuNXNLWEpIbk5lTjFLa3VWcWpVWkFhMHhW?=
 =?utf-8?B?TTBPZlZlMlFYa2U2OHEvRFpCTVhKajFmdC92NnV3VVhIOFlqWVpCdnYvS0x5?=
 =?utf-8?B?ZThSbTh3cTZ6akFNNWxHZWpWUzJFMU1Qd3JYSGF0aFN4NjF4VjRaa0RjcC85?=
 =?utf-8?B?SXhCZ3pRMjRVZ3dzbldtcTE2ZUp1ZTRCelRoVnJlVjFReWhUemt4eE9rVkhD?=
 =?utf-8?B?cVNjNXJ1bHdURVBsRXBNZEoyKzFBOFEvNi9CeXkwNlltZWhDc1NETDdvNFlQ?=
 =?utf-8?B?ZGE5UjhYVlNqeHp4eVIwTk1PSUplV2o3QUYreCtqZDZFU1FHU1cwZ2FjL2p3?=
 =?utf-8?B?dGU0RXFjb0czOWdBSVFnZVc2TnlsV2dHeTQvWTlSaUN1bFFwQTRnUUkxZHBa?=
 =?utf-8?B?ZEpYeTJGZDQxTkd1RFJOZkpNT3ViN1ZIZ3FFZzVJR05JdXc2bEg5a21PTG1J?=
 =?utf-8?B?TkozTGZwcERzWlVTLzB0SDF5bktiZEorcUdxd1dNV0xJZVcrSlB1OE5OdE80?=
 =?utf-8?B?alpNZTd2Y0VtY2pRNlNhYkV1cGpBQi9qdGdKRnBlMkhtT2NiZ21MMzJlUHJi?=
 =?utf-8?B?VWxwTHJYbnNLZndac0lYdWU2TEhwY3phRWhIZUVmYk1hcXdNSFJiY1MrbEdT?=
 =?utf-8?B?Rk9WVXBBU2R0ZlorODgwcUtYb0s4KzRUVFdISzhKejJxb25tM0gvSWtkeVNK?=
 =?utf-8?B?ek5HcmFqRTFwbEhRbFVEUkxjVXIreUtoL2d2eHZUTDhyMytBNFRwRFg4L1cz?=
 =?utf-8?B?czhaa055cHN4dWRYTmNCcDFvakpOdHlHQzd1b1loNGFxMm5Vb2p6ZjNDbGhs?=
 =?utf-8?B?WkZvWFpabDdOdDZrK2tvYm04YUVpekltRk96dVFhKzk4endJZ241eURnNjF6?=
 =?utf-8?B?V3NBRjQ4S2huT2ljaEZmTGpWVENpem1PcGliS2NuZnNwb1pORFpEZUZMQU5o?=
 =?utf-8?B?WGpkbkprbW5UakRsVVM4MkFtZmIxdmRxcFlFQzYwc2R6M2QrNjlHQVJrY3RJ?=
 =?utf-8?B?ZjRGTDRleXFXT3poQVFIdGFQSThpNStwckpFYSthYktTUVdOQXBIMG93M1FT?=
 =?utf-8?B?aHVHOFcxM28xVy8rREU1Z1d6Z0ZuYlN5U29wUzUrVWhWbDVhajRPZm9ENUNy?=
 =?utf-8?B?WXRqUWxwTHhGbVBHZmdtZzM4U1A2L2tpakt2ZTNOVklyUlVhaklTeGl2VFBG?=
 =?utf-8?B?bmd3Y1YxZDgyU2tvZURkZDYvYTJrL3pjejZNYUt3QWFFVXU4Mm1CYVVtbUo0?=
 =?utf-8?B?dTdmbi9CNkJGN3Blazd6NXNsTHBtSkhteGJCUWlYTHk0MHh5ZklHNThUeWRn?=
 =?utf-8?B?dlFHOWh1SWpvdUIxSTNLUFA0bEh1NEJyUXlJL0NyRGpSMXZpWnZnTkVLb3pU?=
 =?utf-8?B?VFM3ZFJsREo2Ym5aQmVnOHAzVFlTR0FlcjJ3SzVlVmFkTW9LOWpIcm1xOEUx?=
 =?utf-8?B?MmcxRXVYbTI0YnpORFVBalpkRm1jWTBBdVVib241Rmcxb09henZGL0V5Q0Js?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D155537A2909564A8FA96D6B3995C00D@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d03fcb-847a-4bfd-f2f0-08daa1f6d809
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 08:44:38.4747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leQl4eUJxWGhkNgGvmSCZKSfQMQPxa0PMo9IDNxBdsVFefOhjAphs0VYG/bLf/1UHe/GthRnT1td4HvApKKilA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9242

T24gV2VkLCBTZXAgMjgsIDIwMjIgYXQgMTI6MTQ6MjBQTSAtMDcwMCwgSmFtZXMgUHJlc3R3b29k
IHdyb3RlOg0KPiBIaSBBbHZpbiwNCj4gDQo+IE9uIFdlZCwgMjAyMi0wOS0yOCBhdCAxODo0OCAr
MDAwMCwgQWx2aW4gxaBpcHJhZ2Egd3JvdGU6DQo+ID4gSGkgSmFtZXMsDQo+ID4gDQo+ID4gT24g
V2VkLCBTZXAgMjgsIDIwMjIgYXQgMTE6MzM6NTBBTSAtMDcwMCwgSmFtZXMgUHJlc3R3b29kIHdy
b3RlOg0KPiA+ID4gVGhpcyBhZGRzIHR3byBuZXcgc3RhdGlvbiBzdGF0ZXMgdG8gZGlmZmVyZW50
aWF0ZSBiZXR3ZWVuDQo+ID4gPiByZWFzc29jaWF0aW9uIChST0FNSU5HKSwgRmFzdCB0cmFuc2l0
aW9uIChGVF9ST0FNSU5HKSBvciBhIGZpcm1hcmUNCj4gPiA+IGJhc2VkIHJvYW0gKEZXX1JPQU1J
TkcpLg0KPiA+ID4gLS0tDQo+ID4gPiDCoHNyYy9zdGF0aW9uLmMgfCAzMyArKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0NCj4gPiA+IMKgc3JjL3N0YXRpb24uaCB8wqAgNCArKystDQo+
ID4gPiDCoHNyYy93c2MuY8KgwqDCoMKgIHzCoCAyICsrDQo+ID4gPiDCoDMgZmlsZXMgY2hhbmdl
ZCwgMzAgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAt
LWdpdCBhL3NyYy9zdGF0aW9uLmMgYi9zcmMvc3RhdGlvbi5jDQo+ID4gPiBpbmRleCAzNzJlMjNj
MS4uNmJkNjZmZmMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9zcmMvc3RhdGlvbi5jDQo+ID4gPiArKysg
Yi9zcmMvc3RhdGlvbi5jDQo+ID4gPiBAQCAtMTk3LDYgKzE5NywxMyBAQCBzdGF0aWMgYm9vbCBz
dGF0aW9uX2lzX2F1dG9jb25uZWN0aW5nKHN0cnVjdA0KPiA+ID4gc3RhdGlvbiAqc3RhdGlvbikN
Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0
YXRpb24tPnN0YXRlID09DQo+ID4gPiBTVEFUSU9OX1NUQVRFX0FVVE9DT05ORUNUX1FVSUNLOw0K
PiA+ID4gwqB9DQo+ID4gPiDCoA0KPiA+ID4gK3N0YXRpYyBib29sIHN0YXRpb25faXNfcm9hbWlu
ZyhzdHJ1Y3Qgc3RhdGlvbiAqc3RhdGlvbikNCj4gPiA+ICt7DQo+ID4gPiArwqDCoMKgwqDCoMKg
wqByZXR1cm4gc3RhdGlvbi0+c3RhdGUgPT0gU1RBVElPTl9TVEFURV9ST0FNSU5HIHx8DQo+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0YXRpb24t
PnN0YXRlID09IFNUQVRJT05fU1RBVEVfRlRfUk9BTUlORw0KPiA+ID4gfHwNCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RhdGlvbi0+c3RhdGUg
PT0gU1RBVElPTl9TVEFURV9GV19ST0FNSU5HOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+IMKg
c3RhdGljIGJvb2wgc3RhdGlvbl9kZWJ1Z19ldmVudChzdHJ1Y3Qgc3RhdGlvbiAqc3RhdGlvbiwg
Y29uc3QNCj4gPiA+IGNoYXIgKm5hbWUpDQo+ID4gPiDCoHsNCj4gPiA+IMKgwqDCoMKgwqDCoMKg
wqBzdHJ1Y3QgbF9kYnVzX21lc3NhZ2UgKnNpZ25hbDsNCj4gPiA+IEBAIC0xNDYxLDYgKzE0Njgs
MTAgQEAgc3RhdGljIGNvbnN0IGNoYXINCj4gPiA+ICpzdGF0aW9uX3N0YXRlX3RvX3N0cmluZyhl
bnVtIHN0YXRpb25fc3RhdGUgc3RhdGUpDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiAiZGlzY29ubmVjdGluZyI7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgY2Fz
ZSBTVEFUSU9OX1NUQVRFX1JPQU1JTkc6DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiAicm9hbWluZyI7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBjYXNlIFNUQVRJ
T05fU1RBVEVfRlRfUk9BTUlORzoNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gImZ0LXJvYW1pbmciOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgY2FzZSBTVEFUSU9O
X1NUQVRFX0ZXX1JPQU1JTkc6DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuICJmdy1yb2FtaW5nIjsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqB9DQo+ID4gDQo+ID4g
SSB0aGluayB5b3UgaGF2ZSB0byB1cGRhdGUgdGhlIEFQSSBkb2MgaW4gdGhpcyBjYXNlPyBkb2Mv
c3RhdGlvbi0NCj4gPiBhcGkudHh0Og0KPiA+IA0KPiA+IFByb3BlcnRpZXPCoMKgwqDCoMKgwqBz
dHJpbmcgU3RhdGUgW3JlYWRvbmx5XQ0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFJlZmxlY3RzIHRoZSBnZW5lcmFsIG5ldHdvcmsgY29u
bmVjdGlvbg0KPiA+IHN0YXRlLsKgIE9uZSBvZjoNCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAiY29ubmVjdGVkIiwgImRpc2Nvbm5lY3Rl
ZCIsICJjb25uZWN0aW5nIiwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAiZGlzY29ubmVjdGluZyIsICJyb2FtaW5nIg0KPiA+IA0KPiA+IElzIHRo
ZXJlIGEgZ2VuZXJhbCBwb2xpY3kgcmVnYXJkaW5nIHN1Y2ggZXh0ZW5zaW9ucyB0byB0aGUgQVBJ
PyBJIGFtDQo+ID4gYXNraW5nIGJlY2F1c2Ugb3VyIG5ldHdvcmsgbWFuYWdlbWVudCBjb2RlIHRy
YWNrcyB0aGlzIHN0YXRlIG92ZXINCj4gPiBEQnVzLA0KPiA+IGFuZCB3aXRoIHRoaXMgY2hhbmdl
IG91ciBjb2RlIHdpbGwgbmVlZCBzb21lIGNoYW5nZXMuIEkgZG9uJ3QgZmluZCBpdA0KPiA+IG9i
amVjdGlvbmFibGUgYnV0IGl0IG1pZ2h0IG1lYW4gSSBzaG91bGQga2VlcCBhIGNsb3NlciBleWUg
b24gdGhlDQo+ID4gbWFpbGluZyBsaXN0IDotKQ0KPiANCj4gVGhpcyBpcyBvbmx5IGNoYW5naW5n
IHRoZSBpbnRlcm5hbCB0b19zdHJpbmcoKSBmdW5jdGlvbiwgbm90IHRoZSBEQnVzDQo+IEFQSSAo
aXQgaGFzIGl0cyBvd24gc3RhdGVfdG9fc3RyaW5nIGZ1bmN0aW9uLCBtb3N0bHkgZHVwbGljYXRl
ZCkuIFRoaXMNCj4gc2hvdWxkIG9ubHkgZWZmZWN0IHRoZSBkZWJ1ZyBwcmludHMgZm9yIHN0YXRl
IGNoYW5nZXMgYW5kIGV4cG9zZSBhbnkNCj4gd2VpcmQgZHJpdmVyIGJlaGF2aW9yIHJlbGF0ZWQg
dG8gdGhlIFJPQU1JTkcgc3RhdGUgcmF0aGVyIHRoYW4gaGlkZSBpdC4NCg0KQWgsIE9LISBNeSBi
YWQuIFRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24gOi0pDQoNCktpbmQgcmVnYXJkcywNCkFs
dmlu
