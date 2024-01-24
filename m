Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2051.outbound.protection.outlook.com [40.107.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2537A70B
	for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099680; cv=fail; b=exF2Hhy4hy5dBq9uKXX8WdcEW9TgR8tyvLLNBACILk5d9xtOnEeGhEwUqDIuw7Bx6GsRokRkXHqoqnnRMOJNJl7s1Mce1mRk/zyn1gh3UFHkPHwDEzRRsCQB4v1zOx+0eirhohjsSXbD3VEXpiq8OmexnSgMuKhPyPLdaa9V+KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099680; c=relaxed/simple;
	bh=dcF4ey+QKN9GubUJmMT0QmdMAjdy33WvqFbiOWYei/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wkrjf6cFM4G2K/aaXXgWKRJyK+ybRVbRDE+iPS3hKT7gICj+345oBCSPIbMIKUwODHx9TFoS+m51DL8dsu6hVqTKBT6wIVfF73HP+m8LAyEfF4oWEHXv/Ksghvzwp6ERBZv3EXHO/rszN66v7L+8bvs+Htq65vsrA1FoySYw2fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xtonomy.ai; spf=pass smtp.mailfrom=xtonomy.ai; arc=fail smtp.client-ip=40.107.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xtonomy.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xtonomy.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lq55xbI9pP16FHOERxNx2aMdio5th3fCxJIAOw9ZV+djt5u5wSFujGidWk1Iv56pXhqL+RzXne30PX0Sj1eXV2iWvpmfc22TTddk9hzcLzqBLvwphjnoDQOtBaiNg8fbQ59vU1oCaWfv4i/URjl1ItrDfIQ2iAw/Qjye6jksbsoPkV5QpM20J7apwcQCsOA4Xs5C8HP8KK3yvny1wkcj6ekLs+YED0Le+es6nOI4SLQSTMUniAPlIM11m/AWf02J/Srj5V4wFekfffoAkw0qOmvjFW0JrRmcvjsUtX2ivA07WCRqYNJGDdffZHGGgpRhr8MVxcFeoY4TL6SCaAV+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcF4ey+QKN9GubUJmMT0QmdMAjdy33WvqFbiOWYei/s=;
 b=HOSsJnGfZDYPKpcypSy65gUrVj0HQO8/tNcdrbZHHUkGNeHXLUKv/fKPwq5H5T790IXryJ8+iG+KHX1cAO7lKKpPseOUFx8sbSA7SFpOPsk9beN5EtBCJyXSFwuWUlOo8J7XCP0mqPG0op526KGLcB5T5a4DqyQvUmTKVdn942Bpkc0QipfazwDe1hNFrBw61hBZVflqiwsJdldkymEK25WsqTwwLViKwUxdE31riwZkjSjM2m6XFEobw6iVFgLva9DY01qNQkeVyhLeBYzvn5+FpxgRzOn5v+nTN1xpK0SlSVn0bM0sKg4VyVYyY7sD2LZHag6wbVqDa+gnhWiOmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xtonomy.ai; dmarc=pass action=none header.from=xtonomy.ai;
 dkim=pass header.d=xtonomy.ai; arc=none
Received: from FR0P281MB1770.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:86::14)
 by BEZP281MB3011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 12:34:35 +0000
Received: from FR0P281MB1770.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6c28:ef1a:1ffe:3470]) by FR0P281MB1770.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6c28:ef1a:1ffe:3470%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 12:34:35 +0000
From: Fabian Herb <fabian.herb@xtonomy.ai>
To: Denis Kenzior <denkenz@gmail.com>
CC: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Re: How to Autoconnect Two WiFi Cards?
Thread-Topic: How to Autoconnect Two WiFi Cards?
Thread-Index:
 AQHaSJvVxoxLEKp250CbS4FBMLx42LDcreqAgALKKwCAAAeAAIAH8ZIAgAAsTQCAAVSnAA==
Date: Wed, 24 Jan 2024 12:34:34 +0000
Message-ID: <FAC36784-F498-481A-BD35-D3F24269EBD5@xtonomy.ai>
References: <DFBE16E1-468A-4292-9056-D7ED6AA0CB4E@xtonomy.ai>
 <e3e82ef7-941c-4dbb-9f1b-2d1579a12f74@gmail.com>
 <D88835CF-16B7-4658-8852-65C4C3767E9C@xtonomy.ai>
 <ef97ec13-8f6c-4198-bf19-ff50a3e596f1@gmail.com>
 <E8931256-9BC5-4563-8A26-6A346560F34A@xtonomy.ai>
 <69a80bff-f587-48da-a14e-8897586c93e9@gmail.com>
In-Reply-To: <69a80bff-f587-48da-a14e-8897586c93e9@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xtonomy.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB1770:EE_|BEZP281MB3011:EE_
x-ms-office365-filtering-correlation-id: a7bfdc32-4d79-47b3-32fa-08dc1cd8d27a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mEXPGlFHlIIZPFRbgc1zsSFNqFxKEaZT7dQ0WVMYeVl3qXe0J9vuLqnzFbiRRMBbT554D6NkYkUP4rJfwJUZC5vsna0RsY5G7SuipywcsEWJ6OoDgEoUCzdTRQTIfv037+tHO654f263w9cEmjKiwE87bxQlF5TzrMTutu08gpbUgRbzN0KVDvngB/BvB+g81C4KsNcNIS2OYGIGgiYHvMTdd8VbgpbSirRroR4KZxOxaolHqyYaZCrGvyvjph6u4yuGjI9DUSYDeCyCATFJGrbkhVqPgzvLn9k4N0YJ1ID1bvB76rtf9AGx0RpRKCGJ8bNeST4yKT3zG1BZGkVKNI1rh5AFLJfj8E5/oJb1bIxQOTzS3jPH9hBkYBaNN2lgBnd0xhPIV3PJhkRxH7ka80W9RahbsTgw4wpZow38CfQ2Fxs7e3WB+ObOdPMl+CBjN8A6WDzWKbDIVADyI5j1yYsqm+MTbOKFoxf/01ytquX93Pw9Q7D7jYsHCBh3H6tAZneOJhFML26awIgLGkCOhwGwDVfgLLn7M4E7HhRW7bPxcob+soT1BCvPH7BlnPhh5eFESdKF+7NOyJGI3EsO6IztuIFWeVLVqxFNK0td5nlAoTy8EET8nLdA3t++cpmJZ2A8MBEZq41M7hsA9M8g9Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB1770.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(6029001)(396003)(42606007)(366004)(376002)(136003)(39830400003)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6506007)(5660300002)(44832011)(71200400001)(6486002)(966005)(478600001)(83380400001)(8936002)(316002)(6916009)(2906002)(66446008)(64756008)(66556008)(66946007)(2616005)(4326008)(8676002)(76116006)(66476007)(26005)(38100700002)(122000001)(6512007)(33656002)(41300700001)(36756003)(86362001)(38070700009)(66899024)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SnZ6ejRDZFdCclBZVkxRQk15K1Jmc3pqd0pYNGQxeE9hTlN1OGNOK1hIdVU4?=
 =?utf-8?B?Sjh3UUZodysvRUMyQmxmaFdjcXljV0FlcTFmU2NScUpIL3pvcUhOU0NtdDNa?=
 =?utf-8?B?NTVmc0VkSkFqdG9QL3ZHZi9yWnZpakNpeTVWQ0ZTb29qTy81SDBZUHg3T2dK?=
 =?utf-8?B?UFlrT21ZM29uRFFaaFp4SVRzQ3RRVHRKQk5sODBkSzhQUHNmS0xaRkV4dXVm?=
 =?utf-8?B?djAwQWx2ZElkOExGVWRRYmRVYS9hTXM0blZjenM0RjcrampMVjhZREpYUmZ6?=
 =?utf-8?B?K2tpZ1JJbEV2bmxONkRrM05nV0pVa2VtNmJwenFnSjFKbFNNZWdrQzVRSmVi?=
 =?utf-8?B?RnErQnEyMDR6SVVMdW1WbXFuSWV5NHRvcDA5bFV3eXJoYUdRSFhnMDZrSnhk?=
 =?utf-8?B?V1dxMFRqTlVVL2p3WkdoVHc0amlpR3Z5KzMzSWNpZHhsVWQ1MUR5OEpYcEp0?=
 =?utf-8?B?cDl5cWJyMytWUFhaT2tSdGZoNnV6VzZsL24vNUYwQitZaEJtNDdod0VzTHdV?=
 =?utf-8?B?a0t2TGMwSG9iSEF4TGZORmI3blZPNUs2RUtwU1lJVFF2VzJadk5ZdnRSN2lC?=
 =?utf-8?B?RmlEY1dPaG1rNnJDT1hCbzZnVDU5d2tEVHRmNG1NNnNZMXdLZjRjTU15OG9a?=
 =?utf-8?B?T1Qra1hhTUxIcElUeldXcUxlR0NxZ01scmUxVGE4bldZbTRhT0FJT3FNQUt2?=
 =?utf-8?B?ZTl0Z3pTelptYUNoUFdWTldtcUVPQUZTb0R4Tm9uNStRT3NFZmloSkNaZ0E4?=
 =?utf-8?B?VVVSbHo5Q0hvMFBzWkhTVndIMzlQam80ZjZRdEJISWFLWm9JU3hKbDJraFFn?=
 =?utf-8?B?cXhpK3lsSWtxbmN4Mk1rZnV5TmhPNDdRNDVJNkszY2lGU3l2aktGRHZ4bGhC?=
 =?utf-8?B?RUppMWdQTFNudlFIMklTZ0N2SjNVWHZnMUwyaWN3Qi83YUd5aUZSNlZTdFg3?=
 =?utf-8?B?VGthU3I4M2JYbDNlUkQyWWlPWVdRZm9YZmlmZWJrTnhzSU1yNGdYMFI0S0la?=
 =?utf-8?B?ZXZrb0VqZ3M1bmNGWmlvTWlSM0RreXpPZjlKTGx3OGR6ZWt2cmFHaGVYRS9k?=
 =?utf-8?B?SmVQN0VWaXNZalFXN0N4NHJuSmx0SFp2UUNnQlNJcG56UmE4UCs2dGpiSlhB?=
 =?utf-8?B?clJTWkNNbGdkL1lnYnpZYm0wYmU1VHEvR0E1elpxY0s0TmszYnNkeHQvMkVu?=
 =?utf-8?B?RkNxTThLcEN1NjhSQklIcW44cjdSUHU4cTVZZjdoVUhXYSsrRTV5emoyZTlB?=
 =?utf-8?B?WkljaERtZWZPdW0vazlJUkluYUt1RTVKTE80MGo0YUNoS0I2N0N2K3pCTHJG?=
 =?utf-8?B?WGhzbmowRkpUaDREOXNFcmRPOE1lTWg2U0pZN2dybWlid0piMjFWT0FSWWxj?=
 =?utf-8?B?UlQzdmNxcW5jSVdEb1ROMUNvV2xrK0J5TjBGUERhNFlaZmtGTVJ5SFcvazMx?=
 =?utf-8?B?UUxtRVhCK1ZYb3ZBNWhDOElXU1VTOTgrcDZSYUJMTjRXcit1Znk5eS90OWxX?=
 =?utf-8?B?ZllCUGRwazVUVEJNNzEwWm5YdG9vN0c0K0cvMWFJMzIyQ1M0UXIwQndhSFFQ?=
 =?utf-8?B?a3JtSWV3Wlpyckt4T3dTR3kxWHBVY1pGYnN1YWdvOXFZeWhIbjBpZUF4WEYr?=
 =?utf-8?B?UFFsMW1nNHNldUFidnppWGh6RmYvd2o5cDJOVnlwVVNnajJ5RlVES0pHdHlY?=
 =?utf-8?B?N2o4TFphVlZQS3YrMEw1cGZuaXFLcXdFTE5yQ09TcG9kS24ySmZDUHpQejNz?=
 =?utf-8?B?aU5kT2Jxek5aZUlVM0xWRTJBamJROGxGOG9RYno5VHo2RFA0NXhSR2REM3BT?=
 =?utf-8?B?azJHNGZhUlc0Sk5POFNIMXFJQWJMM202RnhOcDRjcXN2aXRhWnBpQXVNNjBO?=
 =?utf-8?B?bGxzVW1LS3VUSG1DMVlMbXJIUENCZzlDa0VtMzdQRC9NZ29vdjFWODkyL0tz?=
 =?utf-8?B?UzlGRUtFdDZLNG96cHpYVStZNFVqUWVoRGxoL1hOUWdJTkJoYTN5WVFHL0RL?=
 =?utf-8?B?NERBdHl6Y1RMdVByMFo0SzlqU0liWG5WNnNYclpuYnl5emsrWGpkd2JBdCsy?=
 =?utf-8?B?Qk54MEV0NzRGMGpXUHlUNTd4SFhNYUl3SjRjZWJ0NkJuOHd6RWVDSEVUalRQ?=
 =?utf-8?B?Ymo4RGJLc0orRDY3aE01UzhDNzNtMjVRSVFiZU1jQ0JxbGhHQUw3RFIwdmZQ?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F089B8BCFD1E01478CE7C92FC313764C@DEUP281.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bfdc32-4d79-47b3-32fa-08dc1cd8d27a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 12:34:34.8821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ec14d57-ef7b-4273-9e83-d36ba70a79fc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 887e20gndTYFquaR24R2pV5wQ511RnETZHCz0HF9/2tkHcOwzkah+VwdNkwt73XuaRkU9iyQoSwERdG2+7/aWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3011

SGVsbG8gRGVuaXMsDQoNCj4gDQo+PiBJ4oCZbSBzdGFydGluZyB0byB0aGluayB0aGF0IGl0IG1p
Z2h0IGJlIGVhc2llciB0byBhZGQgYSBmZWF0dXJlIHRvIGl3ZCB0aGF0IGRvZXMgd2hhdCBJIHdh
bnQgOikuIEJ1dCBJ4oCZbSBzdGlsbCBhIGJpdCBsb3N0IGluIHRoZSBzb3VyY2UgY29kZS4NCj4g
DQo+IENhbiB5b3UgZWxhYm9yYXRlIG9uIHdoYXQgeW91J3JlIHRyeWluZyB0byBhY2NvbXBsaXNo
Pw0KPiANCj4gRG8geW91IHdhbnQgaXdkIHRvIGNvbm5lY3QgdG8gdHdvIFNTSURzPyAgVHdvIGRp
ZmZlcmVudCBCU1NlcyB3aXRoaW4gdGhlIHNhbWUgU1NJRD8gIFNvbWV0aGluZyBlbHNlPw0KDQpJ
IHdhbnQgZWFjaCBXaUZpIGNhcmQgdG8gY29ubmVjdCB0byBhIGRpZmZlcmVudCBTU0lEIChlYWNo
IGNvbnNpc3Rpbmcgb2YgbXVsdGlwbGUgQlNTSURzKS4gSWRlYWxseSBJIHdhbnQgdG8gYWRkIGFu
IGVudHJ5IHRvIGVhY2ggbmV0d29yayBmaWxlIHRvIGxpbWl0IGl0IHRvIGEgY2VydGFpbiBpbnRl
cmZhY2UuIE1heWJlIGV2ZW4gYmV0dGVyLCBidXQgbGVzcyBnZW5lcmFsOiBJZiBJIGNvdWxkIGxp
bWl0IHRoZSBmcmVxdWVuY3kgYmFuZCBvZiBlYWNoIGludGVyZmFjZSwgSSBjb3VsZCBzYXZlIGEg
Yml0IG9mIHRpbWUgZHVyaW5nIGNoYW5uZWwgc2NhbnMuDQoNCkJ1dCBJIGNvdWxkbuKAmXQgZmlu
ZCB0aGUgc3BvdCBpbiB0aGUgY29kZSB3aGVyZSBzdWNoIGEgZGVjaXNpb24gd291bGQgYmUgbWFk
ZS4gU28gaW5zdGVhZCwgSSBhZGRlZCBhIGNvbW1hbmQgbGluZSBvcHRpb24gZm9yIHRoZSBELUJ1
cyBuYW1lIGl3ZCByZWdpc3RlcnMgYXMsIHNvIEkgY291bGQgcnVuIHR3byBpbnN0YW5jZXMgb2Yg
aXdkLCBlYWNoIGhhbmRsaW5nIGEgZGlmZmVyZW50IHBoeS4gV0lQIGlzIGhlcmU6IGh0dHBzOi8v
Z2l0aHViLmNvbS9jbWRyZi9pd2QvdHJlZS9kYnVzLW5hbWUtb3B0aW9uLiBJdOKAmXMgbm90IGZp
bmlzaGVkLCBhbmQgSeKAmW0gbm90IGV2ZW4gc3VyZSBpdCB3b3VsZCB3b3JrIGluIHRoZSBlbmQg
b3IgaWYgdGhlcmUgYXJlIG1vcmUgY2xhc2hlcyBiZXR3ZWVuIHR3byBpd2QgaW5zdGFuY2VzLg0K
DQo+IE1MTyBvbmx5IHdvcmtzIHRvIHRoZSBzYW1lIEFQIHRob3VnaCwganVzdCBkaWZmZXJlbnQg
YmFuZC4gIFlvdSBtZW50aW9uZWQgdXNpbmcgYSBkaWZmZXJlbnQgU1NJRCBlYXJsaWVyPw0KDQpV
c2luZyBtdWx0aXBsZSBTU0lEcyBhbmQgZG9pbmcgdGhlIHJlZHVuZGFuY3kgb24gYXBwbGljYXRp
b24gbGV2ZWwgaXMgb25seSBkb25lIG91dCBvZiBuZWNlc3NpdHkuIEnigJlkIGhhcHBpbHkgdXNl
IE1MTyBpZiBpdCBkb2VzIHdoYXQgSSBuZWVkIGluc3RlYWQuIEJ1dCB5ZXMsIGFmdGVyIHJlYWRp
bmcgYSBiaXQgZnVydGhlciwgSSBhbHNvIG5vdGljZWQgdGhhdCBpdCBvbmx5IHdvcmtzIG9uIGEg
c2luZ2xlIEFQLiBXYWl0aW5nIGZvciBXaUZpIDggdGhlbuKApg0KDQpCZXN0IHJlZ2FyZHMsDQpG
YWJpYW4=
