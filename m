Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2079.outbound.protection.outlook.com [40.107.135.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23477A725
	for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112445; cv=fail; b=GSjj0LOg7CMsPVIqaLN10kpVq8M9LJAcBBv6M60asV4CSlUwBKRgLaSl9Py1JekLYEQVukBTbj4ITl8a/nkg9TtRZ2c7I6iN3NpwAEVWjyFNLbpYyKDUppCdVUkt3n0xrGea4weLp4pdwXG6C5UxTnRxb7ECHBCkKDX02R0UeZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112445; c=relaxed/simple;
	bh=aD2GCvAABXmDeS0ucEIBFMo4lPWfbY+h60XdYJhUL6U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yzd3uf0nB5txsC3OSk7y8nNpTFhTAlZONPctKs4jOh/kBxPWdbVik1pfydQiy6oFse873MYuUQiUNBMSzPfyQYHuLnFCSYtt4SihoKlHgAoUwQU31FabWAuHjR+mdSz9AZTSuKUop2ilF6RrzKhjD7Q4bMms1kutAXGFGJnFB28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xtonomy.ai; spf=pass smtp.mailfrom=xtonomy.ai; arc=fail smtp.client-ip=40.107.135.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xtonomy.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xtonomy.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMkt8Wl/IwZBQbsDhvxjWgMG3Z7iC2E8aPfxfCncSoUY1ZCtawKAlAT6lmi676qcCiWCe/HlT9UZXCKpVlajr/Qj+kA/VgdoEcBTsmYwFYH1aM5TJwuW7ncQzWsWYPKKAvvMn0Vl+uVNzT/juYAMIkpGaRChEz7q6TdVvPkj7xcD3cK+DmyFsMr7jZA/CrhAzWiXLVZc2san466W1Av93IGEClMJ53FYnC8dyCn8RmFFAwdBe8j6Nc4EMOT7ME/FchvOVYWRvzlW4eMQmHVCQhzgdap53ZfFIIzm3vS3BTHpnvz4eUdD+sphfytHj6Ut6r6UJ8V1tQTBOFhRf4zGFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aD2GCvAABXmDeS0ucEIBFMo4lPWfbY+h60XdYJhUL6U=;
 b=cEDe4OQUn0JjX9F3TO3Z0LET7P4RCoiPomVXLodo7/eDtBLUGiFhBvrJFeWJluG+73rI5TGUjrP75XKvgmTwrw0abE4eAXlqw2mfrFz0ADcqiYeq3dAbudMf5uhtkrS+187jUrud4/XnbL7s8cQl8mPqu6cvs9jeGCvjs/Nxn5BULBk3+Wf2G2n32qhb1EdrQZqB1nMSXPjsOS+dbzbWGHqY3JYZIanmB1DGvLYqNCE731DpLvNgOFK2rwf1Yc6G/t4RU2iyg+1yV0UqkUB3UyT9ssN79sst6F2GGu2Dlvcfo4cMJfUDjowURBWBIHkO7phY2suVsmfwO5Q3wncBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xtonomy.ai; dmarc=pass action=none header.from=xtonomy.ai;
 dkim=pass header.d=xtonomy.ai; arc=none
Received: from FR0P281MB1770.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:86::14)
 by BE1P281MB2226.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Wed, 24 Jan
 2024 16:07:18 +0000
Received: from FR0P281MB1770.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6c28:ef1a:1ffe:3470]) by FR0P281MB1770.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6c28:ef1a:1ffe:3470%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 16:07:18 +0000
From: Fabian Herb <fabian.herb@xtonomy.ai>
To: Denis Kenzior <denkenz@gmail.com>
CC: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Re: How to Autoconnect Two WiFi Cards?
Thread-Topic: How to Autoconnect Two WiFi Cards?
Thread-Index:
 AQHaSJvVxoxLEKp250CbS4FBMLx42LDcreqAgALKKwCAAAeAAIAH8ZIAgAAsTQCAAVSnAIAALpeAgAAM2QA=
Date: Wed, 24 Jan 2024 16:07:18 +0000
Message-ID: <A3545185-22E7-4491-AD80-FFF9FEDCB8F1@xtonomy.ai>
References: <DFBE16E1-468A-4292-9056-D7ED6AA0CB4E@xtonomy.ai>
 <e3e82ef7-941c-4dbb-9f1b-2d1579a12f74@gmail.com>
 <D88835CF-16B7-4658-8852-65C4C3767E9C@xtonomy.ai>
 <ef97ec13-8f6c-4198-bf19-ff50a3e596f1@gmail.com>
 <E8931256-9BC5-4563-8A26-6A346560F34A@xtonomy.ai>
 <69a80bff-f587-48da-a14e-8897586c93e9@gmail.com>
 <FAC36784-F498-481A-BD35-D3F24269EBD5@xtonomy.ai>
 <d3ccf10a-72a8-43b8-8f1c-b5e2a76214ac@gmail.com>
In-Reply-To: <d3ccf10a-72a8-43b8-8f1c-b5e2a76214ac@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xtonomy.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB1770:EE_|BE1P281MB2226:EE_
x-ms-office365-filtering-correlation-id: 5e9894b7-e51b-4fe4-97e8-08dc1cf68a1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KAaPABh3meBmNBRXkxJSyH+aV08E9LdQYDSRefE91fjxsy+mfeeIPVhRzng90OrduG1wK7xT6absm1Ui30dbhCFJKCJeQXULXpiyTYOuNCRKyrELDD1fP80uHjsFoLiOxtP5SxbxjgHQdYXC47hWKY8SRz7J1hHeZvuplMdu5RME2DjTiDGq+GsISVwxB6GEBix3SL0L6tf0FZdqQyHOtgxLNMorC2DL5G8pPGXzUofHs+WE5q4oTZ21oX9jHLREVQCpzEkl7GqVbF/euhjMmAINvZgLSqGUx1xzxxA2AUigix9glQC90WMd1X3f+VhChcTQdI4rpu1w0zZkypeB9I1woNwjtP88PXcGjeDgso1RxCs+z+fhHCG/4AHse4j9dCWBtbKPqt1S/wgxnqqkiDXLuiljpMP6DDCZf5OqrP5YVbADXbNlSgHLQpBegGmnVOM6AqjznDjIlCEyNn1l0qZYKFOGVs5ywjYPeizWTZPtsm9qPGSJvP6eT4XuWG+l8D99UStp/z8zEPZ1g8psfWn3qRSXbIhMUz8PfnTIWVvoBokgeoPvy7mevIGdXIopiuBZ2SqluOLtsXX8/KrPQUeetzBhEzIxvNxPgsO9PSEG1n4jn9lj1HQt2PWL2gn1O5wuZuc9lpTI66IUDtl/YA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB1770.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(6029001)(346002)(136003)(39830400003)(396003)(376002)(366004)(42606007)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2616005)(26005)(71200400001)(478600001)(6512007)(83380400001)(6486002)(6506007)(36756003)(122000001)(41300700001)(64756008)(5660300002)(44832011)(316002)(4326008)(86362001)(8936002)(2906002)(8676002)(6916009)(33656002)(38070700009)(38100700002)(66446008)(66476007)(66946007)(66556008)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXA1cS9Dd1FwQkJVcm9GSTJGUUdJbmxjc0ZCQ3YxZXRXY1FaajhxeDZXelI3?=
 =?utf-8?B?QndDN1FraE1hZDJxeHJoblppc3M2ZlQzeC9XUjkwcS93OTh2UnFIRzZuQUhN?=
 =?utf-8?B?eDVvZWZBc3dFeDVEYjNLbGVEczA5aXFIOFphZ2IyZEdlTXUweW5uTGVPemMw?=
 =?utf-8?B?RVY4MVdhV3Bac2hRaCtQbzlPejRuWHNzZ3djWStGT0Y3TWtEdVdSMjRMNmxn?=
 =?utf-8?B?SlI0UndyNlMzTDNmZVJKMXg3eHF4T0I3a0p0Tmtwb3VlSWd6aStKTEt2QXQz?=
 =?utf-8?B?dklCYkh6cXZRbmo1Q3p2RXNGZXFuMyttUlJ0WloydTdrZUhPUlJLMGZocVFV?=
 =?utf-8?B?bExRYTJXenNWUi8xMTFzbnhJYzFjVjBJeTllRWZYUEtjdktBdEllc1k5Ym4x?=
 =?utf-8?B?TGM5ZG13UGdPWWlyQURDWkFqNkpuaGp2L0diU1J1T2lKRU9DcDM1RVRpY2NK?=
 =?utf-8?B?eGJ2SWRxcjdOZ2phbWE4N2ZXR29UcTRsVkJPMWpXWlJzVG5VNkFxQ1FiTFNT?=
 =?utf-8?B?TktmOHV0RFp3VDVhbjRSVCt2b0tpN1pYcmkxTlBOWStYWDlUemlmeUI3YzdI?=
 =?utf-8?B?eWEvNmU0KzlQY0ttZ3VpRjc5OElkZ0M4aE9BQXAwbjExbDlONjk1a1dQT0hZ?=
 =?utf-8?B?R2hDQTZ5a3k4L1NHY2lmVHowaFR2UTZRQUIrbnV3MWlIMkpId3diZlh4SVkr?=
 =?utf-8?B?UXZLeE83ZUtsaStPWTJhMDFDQlgwMzJ2MXBRcEp4U3V3UVNLT2VkdUlZR3Jy?=
 =?utf-8?B?eGpOR0EyeENNaXJGZi9XVW92WGxlSlJ4dk1yY0tlRXhwTCs1dkxvSm45MWQx?=
 =?utf-8?B?TDRaY3hpZS9UWE9VaWlEM1pXTVFHRHRxZjY3dUIyazBmS0ZKM1ROZ3UxT3Vp?=
 =?utf-8?B?dksvaTVsVjNqUlg2ZzZoa0ZqSlNRZktnR09VUXJ3dHkxWEV0d0JRSTVxSzFt?=
 =?utf-8?B?a1ptTGJmTkJwNmZ1aGtPTFdGaC9Od2pVZFQ2LyszSXFHZWpwcVRyMGpFdWc0?=
 =?utf-8?B?cmlDLzRSUTUrRkVLK3VQQWRUcU9vOEc4dWNWb000K2gyY2V1Z1hhVkVXUDM1?=
 =?utf-8?B?K3FNdHZYelY0QWhwRlBaenBJYlorb1NkRTZiNi9MQjlnb0JVbGNGU0JOSXJF?=
 =?utf-8?B?ZkNma05zU2ZRRXBwUzBaSk83bjlZQkdqdUVOMmtBRHN6TWJsR3I2SWJPdkpT?=
 =?utf-8?B?Z1lqTGkvSmU0MVFHR3FKeGxBdThMWGszZFd0L1VpTEpzRkY5ZVNaTEMrT0pD?=
 =?utf-8?B?NTk2aXJqNWpHYklFTzlmc3pWd01xNktOOWZ6VE13U1QveHZEOElBQkZnMFFp?=
 =?utf-8?B?UE85dG1vNHVtQ21PTDl2YjlCcFpUd1VQRU1qd05hdHF5U2U1Y283c1NnenhD?=
 =?utf-8?B?VHgxTlRQcmRiTDVTdEY0TlV5Slc5TDc2ank0T0dBemszeE9VTlJmUFRaT0NU?=
 =?utf-8?B?b0FkSlZLOWVhRitYK29IY1l1amtpZlM3WDBadkpQaS9uTDBYUVpkNFRnbFNV?=
 =?utf-8?B?bUtMMjlsTkFtc2ZpMVA2amVlWHVOTm8vMzBOR0ZnK1pnemVMaTFXOWNPQ1Fv?=
 =?utf-8?B?dGNTNmlnQk5ET2xLdThZL21tU2dDbDkxRERkTXhiYVFOYUI0RkdydHF5RVpY?=
 =?utf-8?B?ZTIwSE1LVDFxem5mdlArVnpNYi9zOXhpNG9tZTlYdlJpd3ZmdFkraTI2d09V?=
 =?utf-8?B?Vm0vdkM5ODgrTVA4UUYrWk44Mm92eHRTUjlzZHJaRnBnRG1ZSFlyYm1WUGM5?=
 =?utf-8?B?TXhuNFNSd25xMWRZaXZvV2VmYndFZ2k1TEtGVm8rOW9HVFVJdlc0czZkQjNG?=
 =?utf-8?B?a2pTcFRkVVF5TTNtTWFncTh1ZW9ONjhYR2ZWeDREWmFGUE13NUYrdWtjQWJ5?=
 =?utf-8?B?NU4rOXlBR3VhdTh4ZGlRUFRENEh2eDB1NmMrTFhKTlB0ZUxTOTllQXhlRW9z?=
 =?utf-8?B?QlZwbnU5SG51dyszNUpkQmwwMitvNk45RXZCVi85aEZNY3VJaWFIOGVEd0sy?=
 =?utf-8?B?bnNHMU1MTVh1aEJRMzFCMTlrbDQzWmU1OFVzYmNlNGxHRWxKYks3T08wNzlM?=
 =?utf-8?B?bGkxUWpYbW1TUmRSZHdQOGtFT1N2VXltWW9kRFFvMEZJdzF4V2xaVjdyL0hE?=
 =?utf-8?B?MkZJaDRsZFpKVUI3Yk1tVXpMWW9sZllocDY4WUF0NGI1VytqVkJ0NmRvWXlV?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC96DFAD49BA2745920613E594D5802E@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: xtonomy.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB1770.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9894b7-e51b-4fe4-97e8-08dc1cf68a1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 16:07:18.4501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ec14d57-ef7b-4273-9e83-d36ba70a79fc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5nijLUJJmfGeUO16LKLTA7eFmPGEL8VHGBfWaNOGEscGAld956PqHHeg7gglaSAhCtK/AZdUp2RiQwB2NMmT/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2226

SGkgRGVuaXMsDQoNCj4gIC0gV2hlbiBjb25zaWRlcmluZyBhIG5ldHdvcmssIGZpcnN0IGNoZWNr
IHdoZXRoZXIgYSBuZXR3b3JrIHdpdGggdGhlIHNhbWUgU1NJRC9zZWN1cml0eSB0eXBlIGlzIGJl
aW5nIGNvbm5lY3RlZCB0byBieSBvdGhlciBzdGF0aW9ucyBtYW5hZ2VkIGJ5IGl3ZA0KPiAgLSBU
aGlzIHNob3VsZCBiZSBlYXN5IHRvIGRvIGJ5IGxvb3Bpbmcgb2YgdGhlIHN0YXRpb25fbGlzdCBh
bmQgY2hlY2tpbmcgY29ubmVjdGVkX25ldHdvcmsgLyBjb25uZWN0ZWRfYnNzIG1lbWJlcnMgb2Yg
c3RydWN0IHN0YXRpb24uDQo+ICAtIElmIHRoZSBuZXR3b3JrcyBtYXRjaCwganVzdCBza2lwIGl0
IGFuZCBjb250aW51ZSBvbiB0byB0aGUgbmV4dCBhdXRvY29ubmVjdCB0YXJnZXQuDQo+ICAtIFRo
aXMgc2hvdWxkIHJlc3VsdCBpbiBlYWNoIHN0YXRpb24gb2JqZWN0IGNvbm5lY3RpbmcgdG8gYSBk
aWZmZXJlbnQgU1NJRC4gT25jZSBsYXRjaGVkIG9udG8gdGhlIFNTSUQsIHN0YXRpb24gd2lsbCB0
cnkgdG8gcm9hbSBvbmx5IHdpdGhpbiB0aGF0IG5ldHdvcmsuDQoNClRoYW5rcyBmb3IgdGhlIGhp
bnQhIEJ1dCB3b3VsZG7igJl0IHRoYXQgbWVhbiB0aGF0IGl04oCZcyBiYXNpY2FsbHkgcmFuZG9t
IHdoaWNoIGludGVyZmFjZSBjb25uZWN0cyB0byB3aGljaCBTU0lEPyBSaWdodCBub3cgSeKAmW0g
Y29uZmlndXJpbmcgSVBzIGFuZCByb3V0aW5nIHZpYSBzeXN0ZW1kLW5ldHdvcmtkIGZvciBlYWNo
IGludGVyZmFjZSwgYW5kIHRoYXQgd291bGQgc3RvcCB3b3JraW5nIGlmIHRoZSB0d28gaW50ZXJm
YWNlcyBhcmUgY29ubmVjdGVkIHRoZSB3cm9uZyB3YXkgYXJvdW5kLiBUaGUgYXBwcm9hY2ggYWxz
byBzY3JlYW1zIGZvciByYWNlIGNvbmRpdGlvbnMgOkQuDQoNCkkgd2FzIHRoaW5raW5nIGFib3V0
IHNvbWV0aGluZyBsaWtlIHRoaXM6DQotIEFkZCBhIGNvbmZpZ3VyYXRpb24gb3B0aW9uIHRvIHRo
ZSBuZXR3b3JrIGZpbGUgZm9ybWF0IHdoaWNoIGhvbGRzIGFuIGludGVyZmFjZSBuYW1lDQotIFdo
ZW4gaXRlcmF0aW5nIHRoZSBsaXN0IG9mIG5ldHdvcmtzIHRvIGF1dG9jb25uZWN0IHRvLCBza2lw
IHRoZSBlbnRyaWVzIGZvciB3aGljaCB0aGUgaW50ZXJmYWNlIG5hbWUgaXMgc2V0IEFORCBpdCBk
b2VzIG5vdCBtYXRjaCB0aGUgY3VycmVudCBpbnRlcmZhY2UuDQoNCj4gV2VsbCwgaXQgY291bGQg
d29yaywgYnV0IHlvdSdkIGJlIHJ1bm5pbmcgbXVsdGlwbGUgZGJ1cyBpbnN0YW5jZXMgYW5kIHRo
ZXJlIHdvdWxkbid0IGJlIGFueSBjb29yZGluYXRpb24gYmV0d2VlbiBpd2RzLiAgQWxzbywgeW91
J2QgaGF2ZSB0byBtYWtlIHN1cmUgZWFjaCBpd2QgaW5zdGFuY2UgcnVucyB3aXRoIGEgZGlmZmVy
ZW50IHN0YXRlIGRpcmVjdG9yeSBhbmQgcHJvYmFibHkgZGlmZmVyZW50IGNvbmZpZyBmaWxlIChm
b3IgYmFuZCBwcmVmZXJlbmNlcykuICBTZWUgJ21hbiA4IGl3ZCcgZm9yIGRldGFpbHMgb24gaG93
IHRvIGRvIHRoYXQuIEFub3RoZXIgaGludCwgZWxsIGFscmVhZHkgaG9ub3JzIERCVVNfU1lTVEVN
X0JVU19BRERSRVNTIGVudmlyb25tZW50IHZhcmlhYmxlLiBTbyB5b3UgY2FuIHN0YXJ0IG11bHRp
cGxlIGRidXMgaW5zdGFuY2VzLCByZWNvcmQgdGhlIGFkZHJlc3MgYW5kIHBvaW50IGVhY2ggaXdk
IHRvIHRoZSBkYnVzIGluc3RhbmNlIHZpYSBEQlVTX1NZU1RFTV9CVVNfQUREUkVTUyBlbnZpcm9u
bWVudCB2YXJpYWJsZS4gIE5vIG5lZWQgdG8gY2hhbmdlIGFueSBjb2RlIGluc2lkZSBpd2QuDQoN
CknigJlsbCBnaXZlIERCVVNfU1lTVEVNX0JVU19BRERSRVNTIGEgdHJ5LCB0aGFua3MhDQoNCkZh
Ymlhbg==
