Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2071.outbound.protection.outlook.com [40.107.127.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90005EE8E
	for <iwd@lists.linux.dev>; Tue, 23 Jan 2024 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.127.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706017012; cv=fail; b=VieZPV2feSqkzVpONiyiD2Oko7jeP1JjAOqxhMaB7lwkegB/79zX+aDvM80BnakVNQa0u8XMQr56lgvJm2loATEYrpwRPmD5K5Z+FPt7HcSpWl3+CgmRVBNod5Ph660ZRYV3U+78puHj7aOKBesiT4va47eK1anraqttafWVa5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706017012; c=relaxed/simple;
	bh=2XWgRaJwDWKXK4+Fa4SCfE18urNipRXOR7dkhi2CFjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OX4PUb1MdGSEhSC0LySxj0GOxb0Qk23tnuOPgtdfKEz5dxS7T2nErMXNcRD7STXvs2cWmhS8ozpg7yzajBXUAkMGtf0Iuzu175EVpEvpnBw/TXav6v1hKtbyCLZVu5FEUJ5e1ZCI5omxpu+6usY43Zt/LIOExLzLf6jf+2dowDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xtonomy.ai; spf=pass smtp.mailfrom=xtonomy.ai; arc=fail smtp.client-ip=40.107.127.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xtonomy.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xtonomy.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+6JtHCKM7SUgUJvb3MMOH3D/qVZVqc58ArLIky4lNIpb6N036w2gQ7uybnEYIu+UIu0/65JdSUN0G2LhwmtAdq45EqbTwjxEWeRBR8JfzNFV5UNzDRvElLrmky60xP3hGP6ub7kz3eJeJHG0VIzgyTztJMt66hN+bvqcOimM/Rvi9yoArybm8D4AA1FKdCsGNsPg6n8SxN+FIRmG6wk0137HTis3O1ci+CSghtqjh19GjLBvoBR2K66AcAFKh5dSRzw51Dvd3oB6mBgCbSt8tx4u94cbu4WK3X4V9IWwIK00DtKzm/hZHyJf89OkiTZ/5Thjfp2/Tjx7s5bwFN28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XWgRaJwDWKXK4+Fa4SCfE18urNipRXOR7dkhi2CFjA=;
 b=bG6V5xMHJddqrSZLOZ1ENCd2MVsAY3PFSlXqbN65+dwo0TgaLLI802E6X7NG6iUnZArF+R0H6WrhyrETawW49IgEHykXgmMabN77nqfghDpVOKzcqnV+2awkbofN9NLaqJhwKOy8ArI9Fuv9F7aNE/fayR63G93iQA3OsbJsbjbeOi6+YecnXnWXIW3hbjQEwZIdAEmuZ1Auh1DTd57hUxfi6K7zh+61gcGJaApPw4NPBF/SuUCJUIHgDFhED/nppExhjApTu+/Jt60Di3p+dNt18NLmpmW1th3qOfXxsomCeGsOQq+9ewJg4mvLKhFhj5J1W1050wYIvZRLyNkxAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xtonomy.ai; dmarc=pass action=none header.from=xtonomy.ai;
 dkim=pass header.d=xtonomy.ai; arc=none
Received: from FR0P281MB1770.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:86::14)
 by BE1P281MB2869.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:49::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 13:36:46 +0000
Received: from FR0P281MB1770.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6c28:ef1a:1ffe:3470]) by FR0P281MB1770.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6c28:ef1a:1ffe:3470%6]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 13:36:46 +0000
From: Fabian Herb <fabian.herb@xtonomy.ai>
To: James Prestwood <prestwoj@gmail.com>
CC: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Re: How to Autoconnect Two WiFi Cards?
Thread-Topic: How to Autoconnect Two WiFi Cards?
Thread-Index: AQHaSJvVxoxLEKp250CbS4FBMLx42LDcreqAgALKKwCAAAeAAIAH8ZIA
Date: Tue, 23 Jan 2024 13:36:46 +0000
Message-ID: <E8931256-9BC5-4563-8A26-6A346560F34A@xtonomy.ai>
References: <DFBE16E1-468A-4292-9056-D7ED6AA0CB4E@xtonomy.ai>
 <e3e82ef7-941c-4dbb-9f1b-2d1579a12f74@gmail.com>
 <D88835CF-16B7-4658-8852-65C4C3767E9C@xtonomy.ai>
 <ef97ec13-8f6c-4198-bf19-ff50a3e596f1@gmail.com>
In-Reply-To: <ef97ec13-8f6c-4198-bf19-ff50a3e596f1@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xtonomy.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB1770:EE_|BE1P281MB2869:EE_
x-ms-office365-filtering-correlation-id: e7580844-6fbe-4049-7cf8-08dc1c185867
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hnUz7xI3ZJYm4FXqs0Swq6ZcCD35RsRcun9d6XCKzMgQDP3enOCdR8u+ebufGPizZQlUP9rn86+a7Z8qe3IcDCAlI04TUT75GgIGqxQ02g/yVJl+7TseJ9ZFJuZJK/h4ZoDNG4hhbdT/qubHyXW24aFaVFXis2eFUOn1eDniImPwlvcJ7VrH/qYBdbtITEsh0CBIHLShFC5BgtMiKEhqqh8A8fx+FmNQjzHeyYnSpaVk2eCb7BDDFo/MKlycMPsJXxELNIeNKBF5fYekBc9ZUwl/FuKwaT/KVQYXNc2KOfEtLUcjQGaBH/sU1QArvjqm4kCEXImUavHxH/+hdNhC0w+nbu+XbIeRETo5Q9KZ/45KHblIu62NOxTK2VjcjvziR5rB5Rb9bNVxSAkNU1iZ1Se8css9KdQHbpIIxU4Vi0jEpBLlzLWwRdyDETi8sVKGLYLfa5I4EIP4qu6x1GGlVf0AKr5kJdMQRVAHwUh8sGfdlwXkvO3Uc6QjhhfTJyR4XxMQDN37rDckzUyy3Rhd0hOnE0kdUupI8yvLdvjUyGIlmeC0BwGRlC5M3bHPdo/WAMd1PnFaXzkbvVd+c/QdL6JEx9xrVIh+UJ65FqMG4CJPOoWLnO8FaqMnczUDAYdlpppdaWS6lQppId40VWkzhQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB1770.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(6029001)(396003)(376002)(39830400003)(42606007)(366004)(136003)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6512007)(6506007)(83380400001)(53546011)(2616005)(36756003)(41300700001)(66476007)(8676002)(8936002)(4326008)(316002)(64756008)(6916009)(33656002)(5660300002)(2906002)(44832011)(66446008)(66556008)(66946007)(76116006)(38070700009)(86362001)(26005)(71200400001)(6486002)(478600001)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NVBkcUVSMXpJNjhuc0YxbUFhdWQvZ3JpUlNQZ0pGWUZGVHE2RFhsSzRPblpR?=
 =?utf-8?B?N0V2bHJvU0xac3hMYmpyLzNXaENpVXVrYlFDMDh6ZUZsNUVIWEkrSHVoWmwr?=
 =?utf-8?B?UTYzQmFpS1lGbE5XTGpndXdvM1c5WmZValJ5WUlZM21TZ0RmeVJ2d05XMmtV?=
 =?utf-8?B?a3V1cGt5M1lQYUVZNmNTV3FrRTBQbFlNRFJvbE5BY09iQms1SEs1akhGVzJD?=
 =?utf-8?B?SHZDWmFDVERaaXNEOVU0c0w4Y2oybzRJdGxHSWZnaGwxT0UwV3g2a2hrbUg4?=
 =?utf-8?B?QUlyVmFxUnEzOXhMbmIwZE9QM2x0a0o0RFNNdmlxU2ljVUdZeEd4ZEFTUzBL?=
 =?utf-8?B?R3ZuK2E4b3IwKzlFY3dwazd6RmY0QmgyRU0zUzNRODY1UEtsNmllZUNFMmZm?=
 =?utf-8?B?eEdWMUx0UXBnSlE5N1ZDWWVwWGlCanhVZnN6Q1dBWWZjVDUzbzdCRjNkWTBH?=
 =?utf-8?B?bEZkZUJndmFDdjdaT0pFUUZ3N1BtaWdaOHRLS1M2R210cHdRaXluWHp0YUNR?=
 =?utf-8?B?TkswRnZBSGhHZFEwc2lnM1cxckhWRVdKUGRMcHdSSTlYdHNkVzd0OXduL09J?=
 =?utf-8?B?Rm43RVRPUURJSWNQejRGaklVSUErR3l2WUl3UVJWK3Z5K2RieVpKdTRYQXBy?=
 =?utf-8?B?UTlJVlpqYUZRcm0vdFhxbXlSeDVXRnpOUjdsQnZaRmlFYklCYUs5dUUwSTZB?=
 =?utf-8?B?N0MvRGtwNTlaZitJWlI0T3RXT016c1k1K3kxTWRUbEVyanBKYXR2NFprbjl1?=
 =?utf-8?B?dW1WbEVESGJmcGRQQU8zc2N4UzNTZnRaMmhMRUk1ajYxVUlyS3JJekkrWHFz?=
 =?utf-8?B?b3ZMdVE5aE1rUEhqNEU1WTA4MFlTMnN2RnlYYnNXMjh4alFZdEQ4cnVqZUJG?=
 =?utf-8?B?TEZDTlV2S0hPR1hXRmRjc2d0NWNScHE2M082bGtERWlSVnp1QkNPMmE3cGhD?=
 =?utf-8?B?VzhHREhWQ3JiVE5MQzNYL09SamN0ZnRnZWhTblZrdUpvU2VPaml2d1lUak5w?=
 =?utf-8?B?OFIvNTRIdUdoYWtPMXR0eU5jVkpvNE9BTFJNdU84L21vTHpWYTdpeVV0SXVn?=
 =?utf-8?B?Zmd1a1FGMHA5TlBKeHd3NXErakFFUWJJNHp3ZVpXY2c1ekZwSjI1NC9wc3h6?=
 =?utf-8?B?aTRxd2s3NnRISCtJTm1qbStYUnR5UStnTUNzMjFFbVdzRkwrcHBKNlNQL2lV?=
 =?utf-8?B?bStyUmhPdytCZmNFbERjMWFMeG82bStEeThwODV4ODJ0eGx4dTJDMHIzaWFB?=
 =?utf-8?B?ZWVNRnBmOFRnODZOZ3FzQ2g3K2pNdzdoNHhSTmZmZ0NBODU4bW1Hc3FIUWsr?=
 =?utf-8?B?VlhWbk5RWG91MDlaekpiVEV1QnpMZjUzdksvd1NvaWwyaWtBSXloU25uRDJ6?=
 =?utf-8?B?RzZpT25ZUDRpUlFkZjZmZ0IwL1JoT2ttQWhuczdNVFhNU3hPZVF2b1h1Y1lT?=
 =?utf-8?B?L1Yra1d0ZndzMlpmSnFrNDU3N3hCUG5uL3Fwa2p3QkhzbHo3Qi9JbDdHa0pa?=
 =?utf-8?B?c1Z0Kzg3UHBWdklhQ0MyaXZlNFAzbXdydjJKSTVPSlZVUmMxMm9WcHZ1aUNU?=
 =?utf-8?B?NmhPMzduNEl2VFY0YVBNY0FvTmtSN2NDODg5U00zSStzQUxja3VXMFZRd0Q4?=
 =?utf-8?B?YWhLcmk4ZnlXaU5mR045MnE4MFJMRHNRemhOUFNxekRmSEJ3dWtRUlBYb0p1?=
 =?utf-8?B?bGFPcytyRVdoVWxxMytPc3BQR2dIT2VLaTcvNUdLNHM1MU8zRWZ4eVBjcGd0?=
 =?utf-8?B?TWxhSUdSams2bXJpc3p1OHFubW9UUVdUTnJQQzFFWnZKS0QzdDJ5ZXEzU1NB?=
 =?utf-8?B?VmU5MDZaVjJ3bGpPbHZoR2l4cEUzaG9MUXAzU3dmbldTVlB6Um9lZU14SkZX?=
 =?utf-8?B?MlFxUUtNajRvcTZGSklRMmkyOFdJVW5DTW1jRUw1a1RjamhsNUh2blNDTE93?=
 =?utf-8?B?VzlzU2l4a2xldk9zb3ZZeVJSS0JUVkVxR3BvVWdscmVKNHFRZFowK3ZVM0lW?=
 =?utf-8?B?ZGVaMWRjeVIxMlBhNUFkOGRJQVUzamQvL0NBTFJCb3FkL0dMN0RzdWxWUmlX?=
 =?utf-8?B?czNRNG52QU5OT3Z1SWpjYzl2by9VYVcrTmlDRGtidEVwekhGRlJzUjNtZlhm?=
 =?utf-8?B?TXJvNmZOZjc1OEhhQVFPbmEzckZBSjNCZDdVQStPM2NXQTJlNzczQVJzWUQy?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DF194CB388F4A4A982CF6ED18BD1640@DEUP281.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7580844-6fbe-4049-7cf8-08dc1c185867
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 13:36:46.7255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ec14d57-ef7b-4273-9e83-d36ba70a79fc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KLOq91qS+uD/ddlyMsy68zeBkTn1aY8amVuiRlLT0t5BE4AuVrZvFCmCQgIj8iD50ZOdOT5Hqw7Xsy6tK7yoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2869

SGkgSmFtZXMsDQoNCj4gQW0gMTguMDEuMjAyNCB1bSAxMzoxOCBzY2hyaWViIEphbWVzIFByZXN0
d29vZCA8cHJlc3R3b2pAZ21haWwuY29tPjoNCj4gDQo+IE9uIDEvMTgvMjQgMzo1MSBBTSwgRmFi
aWFuIEhlcmIgd3JvdGU6DQo+PiANCj4+PiBXaXRob3V0IGltcGxlbWVudGluZyBhIG5ldyBmZWF0
dXJlIHdpdGggcGVyLXBoeSBwcm9maWxlcyBhYm91dCB0aGUgb25seSB0aGluZyB5b3UgY291bGQg
ZG8gd291bGQgYmU6DQo+Pj4gDQo+Pj4gIC0gQ3JlYXRlIGEgbmV0d29yayBuYW1lc3BhY2UgKGUu
Zy4gbnMwKQ0KPj4gVGhhbmtzISBJ4oCZbGwgbG9vayBpbnRvIHRoYXQgaWRlYS4gQXQgYSBmaXJz
dCBnbGFuY2UgaXQgbG9va3MgcXVpdGUgY3VtYmVyc29tZSB0aG91Z2guIE1heWJlIHRoaXMgY291
bGQgYmUgZG9uZSB3aXRoIExYQyBvciBEb2NrZXIuLi4NCj4gWWVhaCBJIGFjdHVhbGx5IGhlc2l0
YXRlZCB0byBldmVuIHN1Z2dlc3QgaXQgOikgVGhvdWdoIG9uY2UgeW91J3ZlIGRvbmUgaXQgaXRz
IG5vdCBfdGhhdF8gYmFkLiBXZSBkbyB0aGlzIGluIG91ciBhdXRvdGVzdHMgZnJhbWV3b3JrIHRv
IHNpbXVsYXRlIG5ldHdvcmtzLCBhbmQgcnVuIG11bHRpcGxlIGluc3RhbmNlcyBvZiBJV0QuIFlv
dSBtYXkgYmUgYWJsZSB0byBkbyBpdCB3aXRoIGEgY29udGFpbmVyIGFzIHdlbGwuDQoNCkkgdHJp
ZWQgd2l0aCBzeXN0ZW1kLW5zcGF3biwgYnV0IHRoYXQgZGlkbid0IHdvcmsgc28gd2VsbC4gRm9y
IG9uZSB5b3UgY2Fu4oCZdCBwdXQgdGhlIHBoeSBpbnRvIHRoZSBjb250YWluZXIgd2l0aCB0aGUg
cHJvdmlkZWQgdG9vbHMgYmVjYXVzZSBpdOKAmXMgbm90IGEgcmVndWxhciBuZXR3b3JrIGludGVy
ZmFjZSAoc2V0dGluZyB0aGUgbnMgbWFudWFsbHkgd29ya3MgdGhvdWdoKS4gQW5kIGFsc28gc3Rh
cnRpbmcgaXdkIGluc2lkZSB0aGUgY29udGFpbmVyIGdpdmVzIG1lIGEg4oCeTW9kdWxlIHJma2ls
bCBmYWlsZWQgdG8gc3RhcnQ6IC0y4oCcLCBldmVuIGlmIEkgYmluZCAvZGV2L3Jma2lsbCBpbnRv
IHRoZSBjb250YWluZXLigKYNCg0KSeKAmW0gc3RhcnRpbmcgdG8gdGhpbmsgdGhhdCBpdCBtaWdo
dCBiZSBlYXNpZXIgdG8gYWRkIGEgZmVhdHVyZSB0byBpd2QgdGhhdCBkb2VzIHdoYXQgSSB3YW50
IDopLiBCdXQgSeKAmW0gc3RpbGwgYSBiaXQgbG9zdCBpbiB0aGUgc291cmNlIGNvZGUuDQoNCj4+
IA0KPj4+IFdoYXQgZXhhY3RseSBhcmUgeW91IHRyeWluZyB0byBhY2NvbXBsaXNoIGJ5IGNvbm5l
Y3RpbmcgdG8gc2VwYXJhdGUgU1NJROKAmXM/DQo+PiBUaGF04oCZcyBmb3IgcmVkdW5kYW5jeS4g
VGhlIG1hY2hpbmUgaXMgbW92aW5nIGFyb3VuZCBxdWl0ZSBhIGJpdCwgc28gdGhlcmXigJlzIGxv
dHMgb2Ygcm9hbWluZy4gUmVjZXB0aW9uIGNhbiBiZSBiYWQgaW4gc29tZSBhcmVhcy4gQW5kIHdp
dGggdHdvIFdpRmkgY29ubmVjdGlvbnMgYW5kIDgwMi4xMXIgRmFzdCBUcmFuc2l0aW9uIGlmIHBv
c3NpYmxlLCBJIGhvcGUgdG8gZ2V0IG5ldHdvcmsgaW50ZXJydXB0aW9ucyBjbG9zZSB0byB6ZXJv
LiBSZWR1bmRhbmN5IGl0c2VsZiBpcyBkb25lIG9uIGFwcGxpY2F0aW9uIGxldmVsLg0KPiBTbyB0
aGlzIHZlcnkgc2FtZSB0aGluZyBpcyBiZWluZyBhZGRlZCBpbiBXaUZpIDcsIGNhbGxlZCBNdWx0
aS1MaW5rIE9wZXJhdGlvbiAoTUxPKS4gSXQgZG9lc24ndCBoZWxwIHlvdSBub3cgYXMgSVdEIGRv
ZXNuJ3QgaGF2ZSBhbnkgbG9naWMgZm9yIGl0IGJ1dCBqdXN0IHB1dHRpbmcgaXQgb3V0IHRoZXJl
IChhbmQgbWF5YmUgQVAgc3VwcG9ydCBpcyBhbHNvIG5lZWRlZCkuIFRoZXkndmUgYmVlbiB3b3Jr
aW5nIG9uIHRoaXMgZmVhdHVyZSBpbiB0aGUga2VybmVsIGZvciBxdWl0ZSBzb21lIHRpbWUgbm93
Lg0KDQpZZXMsIFdpRmkgNyBpcyBjZXJ0YWlubHkgaW50ZXJlc3RpbmcuIFlvdSBjYW4gYWxyZWFk
eSBidXkgV2lGaS03LWNhcGFibGUgaGFyZHdhcmUgbm93LiBVbmlGaSBwcm9taXNlcyBNTE8gc3Vw
cG9ydCB0byBiZSBhdmFpbGFibGUgaW4gRmVicnVhcnkgd2l0aCBhIGZpcm13YXJlIHVwZGF0ZSBm
b3IgZXhhbXBsZS4NCg0KSXMgdGhlcmUgYSB0aW1lIGZyYW1lIHdoZW4gTUxPIHN1cHBvcnQgbWln
aHQgYmUgYWRkZWQgdG8gaXdkPyBPciBpcyB0aGUgd29yayBvbiBrZXJuZWwgc3VwcG9ydCBzdGls
bCBvbmdvaW5nPw0KDQpCZXN0IHJlZ2FyZHMsDQpGYWJpYW4NCg0K
