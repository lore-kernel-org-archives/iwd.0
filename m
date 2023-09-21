Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2110.outbound.protection.outlook.com [40.107.6.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5521FB676
	for <iwd@lists.linux.dev>; Thu, 21 Sep 2023 14:21:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FK6CxR6wPk/imA+SbPT1F1q49bz0gbkDbi1GNQ7x0fIUB9QjBZqX2VW20MKDlPCKm3//3IwaCoCZGlx3E+94hOqNDKRqgBETRD0raN5LgD8d8C4OHcx0bG4W54r7HYxp5O/0ivGnMfRb9IBHjuKwueq9IZ97miN/nKEIQmmhrLdSYBY5koCH0SsMGTODZhoVz6pwSbxYEG1manxGs6wQOcklouqlbXr2Fh9oWimpebDIISxPIQLlZMMLOwfiHEo+dk4L8yc37Z00AQC2ttOjBkagOszWQnLBhAKra9iAhRUHQgvM5E3bvyOUzkdSQWkS1IJw80pr44vtfxTjDjVDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMu1/m2Tm4w5jzybtTt6eV8qL4XKmmya6b3Mam0VkAs=;
 b=KBSIe4DjC3037LU262L0anyapA9dSPWIpxe3IHi2EnuS1+8RW95fp/riiUGgtwrqlb4fhxwzCSPxI3svpD3kF2pCeOVPEI2bsLy4fSClLdC3IfwRcx8qjhokWgirdIVuMA2vGoCCZ3FIbwm1iOkYZTLjj24TgZ07Xbk8koDmwvuhIRop9FDQpJ8dKNCk2ic7zY8TDtBxWJa2WUpLJ18Nx7BaMIaL6GQgxL28HmXdkW5igFyVr8jTAp+/34mTZAAU9Hqv+4QUOHVsw2kUy3R2qXI2NckbokZ1y4jFRP8NVZIPOCrHDwPpVIZXjN1dhwWonShC1IPvKiCah4/eyg2VNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMu1/m2Tm4w5jzybtTt6eV8qL4XKmmya6b3Mam0VkAs=;
 b=D3r+3b0qZ4etbafVwoThoFtSC17yvhZdQF2ZJh1t/9PdexK9EmK+FPVeUeSbY9ay6T1MpWmgR62vcT45knqRKClwNfYG2oNxaDAQv/+KDEGlIrFZ2eLvUWCpxclGtXHdFOPNNvjhkU0/DpDwlj+MloHsfc00LSaOfngT9L6oTn0=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by PAVPR03MB9576.eurprd03.prod.outlook.com (2603:10a6:102:30f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 14:21:47 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::620a:c21c:f077:8069]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::620a:c21c:f077:8069%5]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 14:21:47 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: James Prestwood <prestwoj@gmail.com>
CC: =?utf-8?B?Sm9uYXMgR3Jvw59lIFN1bmRydXA=?= <cherti-iwd@letopolis.de>,
	"iwd@lists.linux.dev" <iwd@lists.linux.dev>, =?utf-8?B?UGVkcm8gQW5kcsOp?=
	<PEDA@bang-olufsen.dk>
Subject: Re: Force use of 5GHz band
Thread-Topic: Force use of 5GHz band
Thread-Index: AQHZ7Jb0yRxeRT9vlEKkNQBh/txxgw==
Date: Thu, 21 Sep 2023 14:21:47 +0000
Message-ID: <cmbwlnlbewbuiu4ricqyl3txilk6ybvvmoqyu3ljmui6imuzjw@rs2ug3nxl37w>
References:
 <cfdbbdb5774c4db1c8d3ec7d1e09e70e340f075c.camel@grosse-sundrup.com>
 <34795e04-66e4-4359-a6b2-59b3f47eaf64@gmail.com>
In-Reply-To: <34795e04-66e4-4359-a6b2-59b3f47eaf64@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|PAVPR03MB9576:EE_
x-ms-office365-filtering-correlation-id: 8fd96238-668a-432f-becc-08dbbaae171b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ed3bE8N6WI3KVySwbaalpmJo+nS0Y2yhhskCvH2rYO/CST4TOpgjwewS67+Si6OXP45vWbDH6kBERzq7jLxSFhDNR7QLWxNydrcBRos8aeye8vauroakZxFTveBScRIJd+6tkvK/wIjmBG3bjDJywNP5wbPqzRFFELrTVoEcpyvZcNp5AZDBinky6ss/L1Ev70KYFiF7+8H50nCmTQJqVJXbD0v1fp8NYP4HA4Uq3kZku/vj8NPx5t5cfh9zJA70Kmh9CcJIEWj7CzXwekcv0hFijgZpI/n4WIfrkZLuAaCFvaaM6ycXPAS/cLmDef8g0ZSWZFPccElP5osBcwzxl6+zgDU/E4nyIn8xsuiEuxjg4maE+M1eAIb2w1xxWlMN0H5cxwEujnPm917r8euK6+xWuj85c+LVXnRvk7LZyb08hsnWQrAFhSrFLFmLrDtXb71n1UbwATCReD014nUsfOJLwx3y8Sa326MPaGgbKY8/YjecY45FxgjtD8i5F3b5OwjQXiRBUpsEZ9hNNnzt6MPe+3ydVPgGHkyn53s1ILMO9jM/CzYpX/Pd4ir6f10egIlx/miGp+87cPlVutXIOGfP3JIfqe+kvGEiabUtZGfYo7Wa5opdXu4jiFUzl1+6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(136003)(346002)(39850400004)(376002)(1800799009)(451199024)(186009)(26005)(54906003)(6916009)(86362001)(71200400001)(66446008)(316002)(66946007)(76116006)(66556008)(91956017)(38100700002)(38070700005)(122000001)(2906002)(33716001)(85182001)(41300700001)(64756008)(85202003)(66476007)(5660300002)(478600001)(6506007)(53546011)(9686003)(6486002)(6512007)(4326008)(8676002)(8936002)(107886003)(83380400001)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDk5NElOdEQydHFKRm1yVE4vWGpReldZeExFTU9uQjd6aEttTE9YOWo2TXZo?=
 =?utf-8?B?a1RENi9QVFNrYnpZNGwvZnNQWWt0Tit4ZEpIbGlmeCtrV3dXN1RYMUd5SVh5?=
 =?utf-8?B?WlhZTEJncTRZK3E4WFB4WisvL1VwY2U3a1djUmJQYWRobWRSVVJqR2hnNnZr?=
 =?utf-8?B?a25IZU9OODYvaGJ6cjc2clVQUm0zM1RIOVNHNmJsNm55YlNmMWNUSmpCLzZG?=
 =?utf-8?B?Q3JmZGhhUE5Qc3I1NUxQMGRpaFd1ZzlKWFcvL3I4RkJEMHRYMzQ1T21ZdGsv?=
 =?utf-8?B?L2c0WDFZWG96T09hN3J5aGVKM3FOSG15WFRML2ZvdlNOMnlaakRFKzVrUVNm?=
 =?utf-8?B?YkwrYWQ5V1dhUCtTTUx5OEtVUENJa3RlUnd6cFJRV01zdUNKa3VMYmo2Rmx2?=
 =?utf-8?B?alcyQzVjMVBUVGVMaG9zbGVmc0VsKzVjZEZFa2hpNVZYVHNBcmQ4Zk1WUnVB?=
 =?utf-8?B?KzN4dDd0MXloZFRFbzh2NktldU13Mzc5TnNkbG5JcU5jT2oxaGorZ0ovTnpB?=
 =?utf-8?B?OG1NSDh6Nnl1NG1FT3lLQnJsbGRGbVRGVmtHQUdIVjNvUVF3YlBJWVBWcm8z?=
 =?utf-8?B?T3dPMi9oSDk0MHcyNFBTTjdZUm96QUJPQVNzekt4VTJ1QmNLVG1sT1kzWVpo?=
 =?utf-8?B?YWg4UnV2d21BbFR0ZlovVTgxSHphUSt5a1M0WStCK05ocml3U0YrNWY4dVF5?=
 =?utf-8?B?anFMRVF5UDBHMlBFdG0xUTExZlJ6SGFFUjJ6OXplbjBRa1F2UE95WEVuVzFV?=
 =?utf-8?B?YjJ5ZDlhaWx1cDNGODllMjlxdlJGb1ZVWWpGSGN5RktuK1NsZjlJMXNXZDE2?=
 =?utf-8?B?ZE96NzhoU3hiY2pKQnVVczdxN3YrVUF1R1dmODA0TGJ2M2w3YlZMci9Sdi92?=
 =?utf-8?B?UWFFOXVLWmJoc0tGTmtCMEVNY2NTZWgvNDR5TE5zTGFLVlpEa0IwenJ6dlFJ?=
 =?utf-8?B?N3M3WkxCdkl1SlJHUVI1SHVvRStqRXdLbEUwc3EwQXpHL2RicjZJY2orK21a?=
 =?utf-8?B?cVVmZkxadUppbWlJU0JEWEF3Y0hpNzZ5bUpFUzZNaDVOcVpVTi9DdzBPNVZD?=
 =?utf-8?B?VWZnUTZzMnZ1UDZEaUE3Tmd1ZktmbTE5aVZaZUVqRm9BLzF3Y3hka21OTWRr?=
 =?utf-8?B?T1o5OWNxWHVLOXpXdEZwNWlFemNiRlVMWGJkY21WQzlSdWJNMlBjWjFOcE8v?=
 =?utf-8?B?dGg4Z0xzUHhKRFluakFMdWZMVmdsc1RTSzd0L05XOG8rYVVXUGtKZHRyc3F4?=
 =?utf-8?B?MWV4QWRXcnJVMWExNU9DNUlyT3ltVUl0VzRFbzhPcGZFejAzNHdpZnVVaVkv?=
 =?utf-8?B?b2lZZ0hoOFpuSCtEUmVqaU1DT2d5bFhjSS9FY0FaaEtrQ2l3dllUUTdCMmFV?=
 =?utf-8?B?eHlidGcrUnJ3eTFZSU16QjJtNElheEt1bzBvZlh5VitjaGV5QXdlaWxXY1lC?=
 =?utf-8?B?TFBYUm9xQk9yVVpYQWZHSllrdEY1Z1MvK2tVdm5lTWJZZ3ZHdGJhRlBoZzhW?=
 =?utf-8?B?aU1UTGxENmFMUExHRng2RE9CRGE5MWxiSFJHanYwWE1yTmF0NnBNeVpaQ1lI?=
 =?utf-8?B?b0Q5SUs2T0k1UEpGUXlwSVh2RnpSc1dBVk5JWGdTU3l1OEY0RmliSUcrekNt?=
 =?utf-8?B?OEU0R2h3cUZmM0dHZGE3azVYdmJJU2RLbStHdEpUVmhCWlVnQ21JN1lrNkg2?=
 =?utf-8?B?TGMvT1BNRFdFVzZETnVqeHpobXdKcjc1b0tmdnREUm1CSkZFSCt6V0VxSWFD?=
 =?utf-8?B?UktXOHFtUXdMT0x1Sk5UMndtcnBKalk0U0pFMWdubDNzZHpwekFjVHdpdU1l?=
 =?utf-8?B?VXBnZEZ4ZFRMbk1QdllScmR5bm9ldWZxVHVaVmVRZVFDOGgxQkUwNHp0UmpY?=
 =?utf-8?B?aittY0dzd2xZOTVYM2MxTnVWMHdXa3h0OUhDeUljTG5UaXJIK0dUS0dMdHpN?=
 =?utf-8?B?bWxLTzFOaDVTbGtsTWlmam1lTUJhTXgzQTFjNzRDWFJ6ekZhKys2NVN6SGVV?=
 =?utf-8?B?RFdOakRwY21PZVZ3a0FZOEpEUnBlWG9Oc1gyYTdNOHNsUTlLejJ5L3VsSXQw?=
 =?utf-8?B?emVZTmVXOGNiVXoyLzRtKzVRL041ODJOUE5vaE45UTN0bkNQU3FhRVl5QTN5?=
 =?utf-8?B?SnJHTzIvT2JlZlZwS2NiRXZRQ3RCMkRPUDA0cFhWcWpLVDgwemxFemhOYXdJ?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CD64705F20B424D8D3B596AC1F32699@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd96238-668a-432f-becc-08dbbaae171b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 14:21:47.7313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kDhq5pt13yZJd/oe3y7ZjW9lIJmEvVlQYAWPRk8Hm+LtdT/hO+saRYgRZxPR6pe8i1uXq5ruZiXJjt6/mmEQSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9576

T24gVGh1LCBTZXAgMTQsIDIwMjMgYXQgMTE6MDY6MThBTSAtMDcwMCwgSmFtZXMgUHJlc3R3b29k
IHdyb3RlOg0KPiBIaSBKb25hcywNCj4gDQo+IE9uIDkvMTQvMjMgMTA6NDQgQU0sIEpvbmFzIEdy
b8OfZSBTdW5kcnVwIHdyb3RlOg0KPiA+IEhpLA0KPiA+IA0KPiA+IGlzIHRoZXJlIGEgd2F5IHRv
IGZvcmNlIGl3ZCB0byB1c2UgdGhlIDVHSHogZmxhdm9yIG9mIGEgc3BlY2lmaWMgd2lmaT8NCj4g
PiBJIGFtIGF3YXJlIG9mIEJhbmRNb2RpZmllcjVHSHosIGJ1dCBldmVuIHdpdGggc2V0dGluZyB0
aGlzIHRvIDEwMDAgSQ0KPiA+IHN0aWxsIGVuZCB1cCBvbiB0aGUgMi41R0h6IGJhbmQuIFRoYXQg
YmFuZCBzcGVjaWZpY2FsbHksIGhvd2V2ZXIsIGlzDQo+ID4gdW5mb3J0dW5hdGVseSBzdXNwZWN0
IGZvciBzb21lIHN0YWJpbGl0eSBpc3N1ZXMgSSdtIGZhY2luZyBhbmQgaGVuY2UgSQ0KPiA+IHdv
dWxkIGxpa2UgdG8gZm9yY2UgaXdkIG9udG8gdGhlIDVHSHogYmFuZCB0byBzZWUgaWYgdGhlIHBy
b2JsZW1zIHN0aWxsDQo+ID4gb2NjdXIuIFRoYXQgcHJvdmVzIHRvIGJlIGRpZmZpY3VsdCwgb2Yg
Y291cnNlLCBpZiBpd2QgaXMgcGlja2luZyB0aGUNCj4gPiAyLjVHSHogYmFuZOKApg0KPiA+IA0K
PiA+IEV2ZW4gdGhvdWdoIEkgZG8gc2VlIHRoYXQgaXdkIHByb2JhYmx5IGhhcyB0aGUgYmV0dGVy
IGluc2lnaHQgaW50byBiYW5kDQo+ID4gc3RhYmlsaXR5IGZyb20gYSBzaWduYWwtc3RyZW5ndGgg
cG9pbnQgb2YgdmlldywgYW55IGNoYW5jZSBvZg0KPiA+IG92ZXJydWxpbmcgaXdkJ3MgaW50ZXJu
YWwgbWVjaGFuaXNtcyBoZXJlPyAoT3Igc2hvdWxkIEkganVzdCBjcmFuayB1cA0KPiA+IEJhbmRN
b2RpZmllcjVHSHogYnkgYSBjb3VwbGUgb2YgbWFnbml0dWRlcz8pDQo+IA0KPiBBbGwgd2UgaGF2
ZSBub3cgaXMgQmFuZE1vZGlmaWVyNUdIeiB3aGljaCBpcyBtdWx0aXBsaWVkIGJ5IHRoZSBjb21w
dXRlZA0KPiByYW5rLiBUaGUgc3RvY2sgcmFuayBpcyBiYXNlZCBtYWlubHkgb24gYSBkYXRhIHJh
dGUgY29tcHV0YXRpb24gd2hpY2ggaXMNCj4gdGhlb3JldGljYWwsIGJ1dCB1c2VzIGNhcGFiaWxp
dGllcyBhbmQgc2lnbmFsIHN0cmVuZ3RoIHRvIGVzdGltYXRlLg0KPiANCj4gMTAwMCBpcyBwcmV0
dHkgaGlnaCwgc28gZXNzZW50aWFsbHkgeW91ciAyLjRHSHogQlNTJ3Mgd291bGQgbmVlZCB0byBo
YXZlIGENCj4gcmFuayAxMDAweCBsYXJnZXIgdGhhbiB0aGUgNUdoeiBvbmVzLiBTbyBlaXRoZXIg
NWdoeiBpcyBpbmNyZWRpYmx5IGxvdw0KPiBzaWduYWwsIGRvZXNuJ3Qgc3VwcG9ydCBIVC9WSFQs
IG9yIG1heWJlIHRoZSBJRXMgYXJlIG1hbGZvcm1lZCBzbyB0aGUgZGF0YQ0KPiByYXRlIGlzbid0
IGJlaW5nIGNvbXB1dGVkIGNvcnJlY3RseSBlLmcuIChkZWZhdWx0aW5nIHRvIGJhc2ljIHJhdGVz
KS4NCg0KV2UgaGFkIGEgcmVxdWVzdCBhdCB0aGUgY29tcGFueSB0byBkaXNhYmxlIDIuNCBHSHog
ZW50aXJlbHkgYXMgd2VsbCwgYnV0IEkgZGlkDQpub3Qgd2FudCB0byBjb21wbGV0ZWx5IGRpc2Fi
bGUgaXQgYXMgc29tZSBjdXN0b21lcnMgbWF5IG5vdCBldmVuIGhhdmUgNSBHSHoNCmluZnJhc3Ry
dWN0dXJlLiBNeSBjb2xsZWFndWUgUGVkcm8gZHJhZnRlZCBhIHBhdGNoIHdoaWNoIGFsbG93cyBm
b3IgdGhlIGludGVybmFsDQpCU1MgcmFua2luZyB0byBiZSBub3JtYWxpemVkIGFjY29yZGluZyB0
byBhIHJlcXVpcmVkIGJpdHJhdGUsIHNvIHRoYXQgNSBHSHoNCm5ldHdvcmtzIGRvIG5vdCBhbHdh
eXMgb3V0LWNvbXBldGUgMi40IEdIeiBuZXR3b3Jrcy4gV2UgZm91bmQgdGhpcyB3b3JrZWQgd2Vs
bA0KdG9nZXRoZXIgd2l0aCB0aGUgQmFuZE1vZGlmaWVyIG9wdGlvbi4NCg0KSSBoYXZlIGFza2Vk
IGhpbSB0byBzZW5kIHRoZSBwYXRjaCB0byB0aGUgbGlzdCwgc28gcGxlYXNlIHRha2UgYSBsb29r
LiBNaWdodCBiZQ0Kc29tZXRoaW5nIG9mIGludGVyZXN0IGZvciB1cHN0cmVhbS4NCg0KS2luZCBy
ZWdhcmRzLA0KQWx2aW4=
