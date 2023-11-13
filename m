Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2091.outbound.protection.outlook.com [40.107.247.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A9F2136C
	for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="DRh5XYCW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V25qHvBa7yXJQNH7uOHbiDx/siNFJE75CEDmkOljDmz3b0PkKkJScEtOVSuQ/s+s/rgWeSjK7Z1VTasDYAE0p34MtqrB1+auyO4WmLOG0f2dpeNHRXUjRntDmwgAJQQdTKsnjlWRubPIzdS+ZuiHdXxQXrSeCzdmFZkXR4eH6zwxLMTXIvpwdwas6Xcpgz+xgTAKiQY9sgdZNH8qW7WpIeQ77y2VgsIfTaYAzCpPE501p9KWKl2XcPdeIl0FfIAo6aGjd8YJ/LsvBuTgQ1xjGvrNwL1nHitwad7YHUx9t40yh+R+gHdspIrMbbikuDssYOUZSXqCYfXCm3aiLp9DMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYBCwcjG4JBte5MtUUBlV3kBLCJinoHo1wpT+hJ79RM=;
 b=Or31XWxiBg33A2eDy1gFsSCBHyXQEcat6enmprf3AT6XMfsDiLD71KOM6CL2g7t6izmARPTQdMHwR4oDzqXVRt/AtvOlGbz+xFjPbEdt6a0F2p5dB9sKR5CWpUG4klr+8QPlJ/QLdUf1j5C9S7jSONSTWBnEN5qg1mXoD8y2QLbrr8aVZVjYZAnLaHgjSLu1Yptw8iNn9quVzUJzXIIAa1Zx9doczxaqAYP6tlGSDpSXgY8cuI5JKuv3WcLhCHu01u+oc0bxG7w130LKRqG/NbxA3e1idHijjhlXeVNy6KYNYKL0GSche0YOqulSbgm2TJEaCMmXsnUUxmO3Zn8q9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYBCwcjG4JBte5MtUUBlV3kBLCJinoHo1wpT+hJ79RM=;
 b=DRh5XYCWIsO8n8GmjZhii3mKD7Dy+Sbq+FGRc5c70liQEnbLs1RBbNm7YWZgst7wxZ4ysUGeHtOV94ePwx35NXdmO5UOF7keYlazxWuMlRW3N5B4aTlyU0bDTMYANgr9ISqftb2J0HFipn3ypNySvmfmX2uWTJFgz8sJsvzpdE4=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AS2PR03MB9371.eurprd03.prod.outlook.com (2603:10a6:20b:578::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 15:39:23 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 15:39:23 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Denis Kenzior <denkenz@gmail.com>
CC: James Prestwood <prestwoj@gmail.com>, =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?=
	<alvin@pqrs.dk>, "iwd@lists.linux.dev" <iwd@lists.linux.dev>, Dimitrios
 Karnikis <DIKA@bang-olufsen.dk>, Claudio Cabral <CLCA@bang-olufsen.dk>,
	=?utf-8?B?UGVkcm8gQW5kcsOp?= <PEDA@bang-olufsen.dk>, Johnny Kudahl
	<JOY@bang-olufsen.dk>, "achyut.hegde@nxp.com" <achyut.hegde@nxp.com>,
	"yuvraj.singh@nxp.com" <yuvraj.singh@nxp.com>
Subject: Re: [PATCH] station: handle ROAMING state in disconnect event (again)
Thread-Topic: [PATCH] station: handle ROAMING state in disconnect event
 (again)
Thread-Index: AQHZZjdUs9XT8avmIkmHb8xm4XdbCa8aLL8AgV9lpgCAACr5AIAABUoA
Date: Mon, 13 Nov 2023 15:39:23 +0000
Message-ID: <ljgbd2v2ohmkixnbqu4jzxtnxveq5hpahhd3blsw2v3gfr7rdg@lmy6yo3thjax>
References: <20230403141927.235014-1-alvin@pqrs.dk>
 <c9b5a931-ac35-2755-c656-acd567c1505f@gmail.com>
 <lrv3ytp7a6jvuupcu4pvx2w5jmud4yj6jxbk4imflcqeuosugo@vu7fco6auklk>
 <3ad81a83-54f4-4482-9055-6f8ae40839bc@gmail.com>
In-Reply-To: <3ad81a83-54f4-4482-9055-6f8ae40839bc@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AS2PR03MB9371:EE_
x-ms-office365-filtering-correlation-id: 4e83cfe1-4456-45e9-74bc-08dbe45eb5d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 E3fJjTJLJee/wB2hcxTmSWW1XIXcRC6q/dzXJIa4YwydfHWQuvvAD6WgCUS5oYOGpfcu04eqqXGM4Ut+m3UBfSepXjyn+PY9yYkZZuXvfv4hNVJC25H2Lf5lyb8hSD7n2/hs8ckqUrWs8wYKpwMZm5R+klZWSTHv1AWQidIpMSu5U4/ma66QFEscILBWnoZPIsUMyc4YIcBwAwJL4f7wcgMmw3pwP8dN/zACE4kD6Y7Y3Z/PUdnUO8dbrl/sSWH96v5kXC4Jyq7uCjwOW9J8oUnwVRO4/dtni0vbEuxZkVPTb8Y+cZSxobibb3pUeJiv2ZgJBU8wQ2uU09VKQp3sHq2RI0JkIUgpUxkqNbjP88KCQunXVRU8RIOdlHYYOL+RDpk0IfpKhbTzE0bDhCisz/+XmCP21u3mI9UXpE8LswnIalKXPVAajjUkf7VxYUB0fSFxlsxDdBEZzvRLW1GbbiaLaVCv+K1SAegPyGh1paocDL1cD6uVhhUe5R7BfWD8QnT4ZDy+CUrO3ocmw4rZgVB8tWVC96ocmFmEao7FIFau+4I46jhUbkH97YorXQ+JhAPJtXQM8VZnDhipt12/KAmWBhHcImcMXD3U9pjJlDp7Xm6xolHnT5DEEFB/7qPu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(39850400004)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(41300700001)(6512007)(9686003)(4326008)(6486002)(478600001)(8936002)(8676002)(71200400001)(26005)(5660300002)(316002)(6916009)(76116006)(54906003)(66946007)(66556008)(66476007)(66446008)(64756008)(91956017)(2906002)(83380400001)(122000001)(38100700002)(86362001)(33716001)(38070700009)(85202003)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RjJWM09INGNyY2J1eWovR0MvZ1Y0cDVxSGVKM2pvVTd5VEN3WDdKSzlndzF2?=
 =?utf-8?B?dEtLREsrWXlkZDVnYkNkWDdGb1JmcVI3N0VCT3hhRjRVek5XWUJ6WUtYTGdj?=
 =?utf-8?B?M0JwUk5aUnBBb0xQaGQ1TGpNcnJYNHpWbjBkRjJGcWhrSlp2ZmEveG1pVWNa?=
 =?utf-8?B?cjNOUklFSU43Z3NReXQzemdZVGRzQTl4VWFYUGZneVJLZjdGRnJIRU9oLzhK?=
 =?utf-8?B?NmpaWEU2R2pVUGR5cTUwN01XcjNySjdacTB5YXd0Z3U0NHRpMjV2cUtoWlhr?=
 =?utf-8?B?dEtkaCtMTW1XVHhHaUF0L0hqdTlyWGJTQkpqYVF3N0p1VktMM1p5TUNyNWNr?=
 =?utf-8?B?OGtoRElhSUZ5RjVYK1VpUGZRbjdGSjN1ZXd3MGhOaVA3WFZKQWdRRFA3cnVu?=
 =?utf-8?B?VVFOUmVtMFpLYnc0cFRZVXd5LzNRdm5UZkE5UE1nSHczS3ErQUxOa3RScWNK?=
 =?utf-8?B?dS9lL0gzMXFac05WSnhwdUhuQjc2cXB2M3JvSHhSVEN3VHZCZzNJU0pySzF0?=
 =?utf-8?B?bmxGZnNRS0hsWmRiYmRObW8wVTdYcmx6aTdObVRFc21qZFNhZGkxaDIxTkxn?=
 =?utf-8?B?N3NqcEhqRFUrYnNNdkVPQUtUcmRIZkJ5WC8rdFR1RlozM3UwVkZSeGlBUk5F?=
 =?utf-8?B?bU5CQnFEWWNuTklLVFcyOHV0VU9pSVd0dmkwdzhrOFdZWVNwVjNzclo2cFB0?=
 =?utf-8?B?V3RIWktoWG10b2J5clYwVFVzRVZDRjNxYk80dGIwWjQ4dlk0ZjdCRDhiUC9Y?=
 =?utf-8?B?QWhRMWtBNTlON3RWNkVjdUJtMWtkUndnVFlGZ2h5c2VNOE1ueUkydmZzRFJE?=
 =?utf-8?B?aWZFWWhWRjM3cXFlb0tQSU1yaGlJbSt5U0ZNTWF3UWRWa0x2azE4Q3l3S1Bn?=
 =?utf-8?B?bkd2UFpiUENpaTdtcWExQ3B3UVllVVlPVnc2SEhzY0FZc3ZYcks0Q1hMRzdi?=
 =?utf-8?B?dE1KUlFhOXFFandpZWJoOGRTcmxUdUFCaXZ1bEZlczJwWDNQb3FNcFpZVXVL?=
 =?utf-8?B?bVJIVytrM1lOd29hZkZGT0YxQk54VDRkdFpCbm1kblFnTHgyK1E4R1lRbHhO?=
 =?utf-8?B?T1I2YU9XYi9FeWVDekhtWkVFQ2pMeDFKS082OU1ISlo3S3c5Z1R5TTByelBl?=
 =?utf-8?B?d1U1d1BPVUFxUm5rNW5NWjB1N3FKM2FibHlsTTE5aGdsNENNWG1QQXpybFVm?=
 =?utf-8?B?RlEvb1FrQzlSVkg2RkszOEQ4TjFDWDBXMjJMTTFxVndWMUVXZnIrN2d2anJq?=
 =?utf-8?B?YVNkR2crdjU2aVNaZ2ZyQkhEWjBDbEp0M0pMMFFnQ1YzNlQ5NDJhSFZXNnlh?=
 =?utf-8?B?dWpBaWQ1TEhBVFVrMkRlMitvbVVPTFVFMnVoVWVCVDJvc0dCUDhUTlNSeGVF?=
 =?utf-8?B?R3hrQUVJT0tydUFNZ0NmSEJDTElUc3AvTUNrN1lRSXNyMERKM0lveWdvdGpV?=
 =?utf-8?B?SWVrandzbGRmMi9KbzV1ZmdJL3g5T0RjMnljN0NHV3dYcC9adWdwUW9WclNj?=
 =?utf-8?B?M3luemhwamFkU3RydlR4M0hsVEhyb3J0OVZFdWIrQnA2UkJDSkE5Mys3cm5m?=
 =?utf-8?B?SzdUSUVYQjJpUW1nVVNDUlo4c1hXTzcvZDgwT0cwSTVXeTRuNUw1di9TaFFF?=
 =?utf-8?B?K0VRZWRMVU9vbTg1NXpRQ0FHZ1Z3RUJDRjRXdGNva1JTcXY4bFowbUtyR1RG?=
 =?utf-8?B?N3FhaGh2bGlDb1hoY1VTb01EUTg3UG5ydVZDZWxWZkFxbmFycVlSMjRuUno5?=
 =?utf-8?B?bWdoZUc0eUY2eEcwNDVOWWMyRjA0d0tHa3R4YnZkNGxQYkNTKzVhZ3kxSTdM?=
 =?utf-8?B?UjZPblhXdFRSZHliS0QrWnFiU1VjblVWRjFQYngzM2VBMTAyU0ptdzNmc2ox?=
 =?utf-8?B?Ym41bzZldTZxRS9nckhGenN1K0pVNHMvS09EK0UwVFlEQVpuSytJSHJQNStq?=
 =?utf-8?B?K2RHa2NOUFRPVVJqYTU2ZXNhdUhnbU82eXZTcHhXd3hwam8vclhYVHJoQ3Jp?=
 =?utf-8?B?blNjOHRaSG9sMUoxSUc5VXdrTjg4RTB4LzBGbmZ4OXVrKzdleHV2eTUxazcv?=
 =?utf-8?B?c3lqdWtLamJPUnJFNzB4K05WV2dtcEZQV05mNkdteDlnVzVXSW5wMmZvSWds?=
 =?utf-8?B?RWsva2UvazMwRTM1aEtPbThqcmhySXFzU1Vub3BCQStxUjZZVzQ0anN1TXRI?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E27A31C7DB8F043951732B6A4320EB3@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e83cfe1-4456-45e9-74bc-08dbe45eb5d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 15:39:23.1156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 95q2PTM5EYBJcIqOUcfoMqUBgkyKhGeqOstDtfxNV391jBJaYldoJ65IZSXcGUhJU5aPzUiKUDg9JqoTP1lhZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9371

SGkgRGVuaXMsDQoNCk9uIE1vbiwgTm92IDEzLCAyMDIzIGF0IDA5OjIwOjE0QU0gLTA2MDAsIERl
bmlzIEtlbnppb3Igd3JvdGU6DQo+IEhpIEFsdmluLA0KPiANCj4gPiANCj4gPiAxLiBpd2QgcmVj
ZWl2ZXMgYSBDUU0gZXZlbnQgYW5kIGVudGVycyByb2FtaW5nIHN0YXRlLg0KPiA+IA0KPiA+IDIu
IGl3ZCBpc3N1ZXMgYSBDTURfQ09OTkVDVC4gVGhlIGRyaXZlciBkZWZpbmVzIC5hdXRoIGFuZCAu
YXNzb2Mgb3BzLCBub3QNCj4gPiAgICAgLmNvbm5lY3QsIHNvIGl0IHRha2VzIHRoZSBTTUUgcGF0
aCBpbiB0aGUga2VybmVsLg0KPiA+IA0KPiA+IDMuIEF1dGgvQXNzb2MgYXJlIHN1Y2Nlc3NmdWwg
YW5kIEJTUzEga2lja3Mgb2ZmIHRoZSA0LVdheSBIYW5kc2hha2UuDQo+ID4gDQo+ID4gNC4gQWZ0
ZXIgZW50ZXJpbmcgZWFwb2xfaGFuZGxlX3B0a18zX29mXzQoKSBpd2QgYXN5bmNocm9ub3VzbHkg
aW5zdGFsbHMgdGhlIGtleXMNCj4gPiAgICAgd2l0aCBDTURfTkVXX0tFWSBhbmQgdGhlbiBkZWxl
dGVzIHRoZSBFQVBPTCB0aW1lb3V0Lg0KPiA+IA0KPiA+IDUuIFRoZSBncm91cCBrZXkgZ2V0cyBp
bnN0YWxsZWQgc3VjY2Vzc2Z1bGx5IChDTURfTkVXX0tFWSByZXR1cm5zIHN1Y2Nlc3MpLg0KPiA+
IA0KPiA+IDYuIEluIHRoZSBtZWFuIHRpbWUgaG93ZXZlciB0aGUgc3RhdGlvbiByZWNlaXZlcyBh
IERlYXV0aCBvciBEZWFzc29jIChub3QgY2xlYXINCj4gPiAgICAgZnJvbSBvdXIgZHJpdmVyIGxv
Z3MpIGFuZCB0aGUgZHJpdmVyIHNlbmRzIHRoaXMgdG8gaXdkLiBJbg0KPiANCj4gRG8gd2Uga25v
dyB3aHk/ICBBbmQgdGhlIERlYXV0aC9EZWFzc29jIGlzIGZyb20gQlNTMSwgbm90IEJTUzAsIGNv
cnJlY3Q/DQoNCk5vLCB3ZSBkb24ndCBrbm93IHdoeS4gQnV0IGl0J3MgY29taW5nIGZyb20gQlNT
MSwgY29ycmVjdCwgYXQgbGVhc3QgaWYgdGhlIGl3bW9uDQpwY2FwIGlzIHRvIGJlIGJlbGlldmVk
LiBUaGUgZHJpdmVyIGRlYnVnIGxvZ3MgdGhlbXNlbHZlcyBkb24ndCBwcmludCB0aGUgTUFDDQph
ZGRyZXNzIGFuZCB3ZSBkb24ndCBoYXZlIGEgc25pZmZlciBsb2cuIEFsc28sIG5vdyBJIGhhZCBh
IHNlY29uZCBsb29rIGFuZCBpdCBpcw0KaW5kZWVkIGEgRGlzYXNzb2MgZnJhbWUgd2l0aCB1bnNw
ZWNpZmllZCByZWFzb24gY29kZSAoMSkuDQoNCj4gDQo+ID4gICAgIG5ldGRldl9kaXNjb25uZWN0
X2V2ZW50KCkgaXdkIHRoZW4gZm9sbG93cyB0aGlzIHBhdGg6DQo+ID4gICAgICAtPiBuZXRkZXZf
Y29ubmVjdF9mcmVlKCkNCj4gPiAgICAgICAgLT4gaGFuZHNoYWtlX3N0YXRlX2ZyZWUoKQ0KPiA+
ICAgICAgICAgIC0+IG5ldGRldl9oYW5kc2hha2Vfc3RhdGVfZnJlZSgpDQo+ID4gCSAgLT4gbmV0
ZGV2X2hhbmRzaGFrZV9zdGF0ZV9jYW5jZWxfYWxsKCkNCj4gPiAJICAgIC0+IGxfZ2VubF9mYW1p
bHlfY2FuY2VsKG5sODAyMTEsIG5ocy0+cGFpcndpc2VfbmV3X2tleV9jbWRfaWQpOw0KPiA+IA0K
PiA+ICAgICBUaGVuLCByZTogdGhlIG9yaWdpbmFsIHBhdGNoIGluIHRoaXMgdGhyZWFkLCBpd2Qn
cyBzdGF0aW9uIGNvZGUgaWdub3JlcyB0aGlzDQo+ID4gICAgIGV2ZW50LCBiZWNhdXNlIHRoZSBz
dGF0aW9uIHN0YXRlIGlzIFJPQU1JTkcuDQo+ID4gDQo+ID4gNy4gVGhlIHN1YnNlcXVlbnQgQ01E
X05FV19LRVkgdGhlbiBmYWlscyBpbiB0aGUgZHJpdmVyLCBidXQgdGhlIGFib3ZlIGdlbmwNCj4g
PiAgICAgY2FsbGJhY2sgaXMgbmV2ZXIgaW52b2tlZCBiZWNhdXNlIGl0IHdhcyBjYW5jZWxsZWQu
DQo+IA0KPiBUaGVyZSBzaG91bGQgYmUgdGhyZWUgTkVXX0tFWXMgZ2VuZXJhdGVkOg0KPiBzZXRf
Z3RrDQo+IHNldF9pZ3RrIChpZiB5b3UgaGF2ZSBNRlAgZW5hYmxlZCkNCj4gc2V0X3RrDQo+IA0K
PiBOb3JtYWxseSBpbiB0aGF0IG9yZGVyLiAgV2hpY2ggQ01EX05FV19LRVkgZmFpbHM/DQoNCnNl
dF90ayBpcyBmYWlsaW5nLiBIZXJlIHlvdSBjYW4gc2VlIHRoZSBvcmRlciAobm8gc2V0X2lndGsg
Y2FsbGVkKToNCg0KaXdkWzM1ODldOiAuLi9pd2QtMi44L3NyYy9uZXRkZXYuYzpuZXRkZXZfc2V0
X2d0aygpIGlmaW5kZXg9OCBrZXlfaWR4PTENCml3ZFszNTg5XTogLi4vaXdkLTIuOC9zcmMvc3Rh
dGlvbi5jOnN0YXRpb25faGFuZHNoYWtlX2V2ZW50KCkgU2V0dGluZyBrZXlzDQppd2RbMzU4OV06
IC4uL2l3ZC0yLjgvc3JjL25ldGRldi5jOm5ldGRldl9zZXRfdGsoKSBpZmluZGV4PTgga2V5X2lk
eD0wDQppd2RbMzU4OV06IC4uL2l3ZC0yLjgvc3JjL25ldGRldi5jOm5ldGRldl9zZXRfcmVrZXlf
b2ZmbG9hZCgpIDgNCml3ZFszNTg5XTogLi4vaXdkLTIuOC9zcmMvbmV0ZGV2LmM6bmV0ZGV2X25l
d19ncm91cF9rZXlfY2IoKSBpZmluZGV4OiA4LCBlcnI6IDANCml3ZFszNTg5XTogLi4vaXdkLTIu
OC9zcmMvbmV0ZGV2LmM6dHJ5X2hhbmRzaGFrZV9jb21wbGV0ZSgpIHB0a19pbnN0YWxsZWQ6IDAs
IGd0a19pbnN0YWxsZWQ6IDEsIGlndGtfaW5zdGFsbGVkOiAxDQppd2RbMzU4OV06IC4uL2l3ZC0y
Ljgvc3JjL25ldGRldi5jOm5ldGRldl9tbG1lX25vdGlmeSgpIE1MTUUgbm90aWZpY2F0aW9uIERp
c2Fzc29jaWF0ZSg0MCkNCml3ZFszNTg5XTogLi4vaXdkLTIuOC9zcmMvbmV0ZGV2LmM6bmV0ZGV2
X21sbWVfbm90aWZ5KCkgTUxNRSBub3RpZmljYXRpb24gRGlzY29ubmVjdCg0OCkNCml3ZFszNTg5
XTogLi4vaXdkLTIuOC9zcmMvbmV0ZGV2LmM6bmV0ZGV2X2Rpc2Nvbm5lY3RfZXZlbnQoKQ0KaXdk
WzM1ODldOiBSZWNlaXZlZCBEZWF1dGhlbnRpY2F0aW9uIGV2ZW50LCByZWFzb246IDEsIGZyb21f
YXA6IHRydWUNCml3ZFszNTg5XTogLi4vaXdkLTIuOC9zcmMvd2lwaHkuYzp3aXBoeV9yYWRpb193
b3JrX2RvbmUoKSBXb3JrIGl0ZW0gMTUgZG9uZQ0KaXdkWzM1ODldOiAuLi9pd2QtMi44L3NyYy9z
dGF0aW9uLmM6c3RhdGlvbl9kaXNjb25uZWN0X2V2ZW50KCkgOA0KaXdkWzM1ODldOiBVbmV4cGVj
dGVkIGRpc2Nvbm5lY3QgZXZlbnQNCg0KSGVyZSB5b3UgY2FuIHNlZSB0aGF0IHNldF9ndGsgc3Vj
Y2VlZHMuIFlvdSBkb24ndCBzZWUgdGhlIGNhbGxiYWNrIGZvciBzZXRfdGsNCmZvciB0aGUgcmVh
c29ucyBJIGV4cGxhaW5lZCBpbiBtYWlsIGFib3ZlLCBidXQgaW4gdGhlIGl3bW9uIHBjYXAgSSBj
YW4gc2VlIHRoYXQNCnRoZSBDTURfTkVXX0tFWSBmYWlscyB3aXRoIC1FTk9MSU5LLiBNYWtlcyBz
ZW5zZSwgc2luY2UgdGhlIGRyaXZlciBnb3QgdGhlDQpEZWF1dGgvRGlzYXNzb2MgaW4gdGhlIG1l
YW4gdGltZS4NCg0KPiANCj4gPiANCj4gPiBJbiB0aGlzIHdheSBuZWl0aGVyIHRoZSBzdGF0aW9u
IG5vciB0aGUgaGFuZHNoYWtlIGNvZGUgdGhlbiByZXBvcnQgdGhlIGVycm9yLCBzbw0KPiA+IHdl
IGdldCBzdHVjayBpbiBhIHJvYW1pbmcgc3RhdGUuDQo+ID4gDQo+IA0KPiBPaywgSSBjYW4gc2Vl
IHRoYXQgaGFwcGVuaW5nLg0KPiANCj4gUmVnYXJkcywNCj4gLURlbmlz
