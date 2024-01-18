Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2078.outbound.protection.outlook.com [40.107.135.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A16241FD
	for <iwd@lists.linux.dev>; Thu, 18 Jan 2024 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705578697; cv=fail; b=WsmYZdvWLPaoN7+6K+lmLy11bfVQhfsHy3/a5d9mIJ9dXqUdOb4xQF5ty4SajQtuT4MY/FfYJiZnBTcg0SRrYT4GS3HbmmPN1688D5GH2TXM+yvADVNg6YJmImbcLsfb21bDQs2KMlxGPCWmC7WUqZv2Oo7YP5arv6CZBKc2Hhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705578697; c=relaxed/simple;
	bh=dTIChhpgNOTo5pguUc0WkUEOOcIie9SiHC1wrRY0ERg=;
	h=ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=eXQSONmSo19k7OvxC79LEsA+vGrTjXX8KPdwum9qiYIPFbXAZCLbj2H4qj7BCuTdekyYTDc7YJ1LFkeqS+MeR/GQ25bCTcrrTRLAnkuITSIfld4YwodH0j1tKFnjpIi2Rtb/eeF8BgbAEayY3NZQ0WM3vqDYDQfA5rj62vZNEjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xtonomy.ai; spf=pass smtp.mailfrom=xtonomy.ai; arc=fail smtp.client-ip=40.107.135.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xtonomy.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xtonomy.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIp8bT5FkNMjAk+K6YqeKVzlLYJ0cn7mDHF8EXX+MW7S93SPIvnkUAgCSlO3w67C0lJJ6nw65ZUnAP2LOcscHBagsRnXbmuySK09h0qJPavx9r0lGhCCjYfaoOH2eCYx5Fcjw4GNg6kU10BsT8/tizO2CQvfOhavLv4bGvWWj8BW50gwme888NnMYI7t+VIkMGkpE62pJremyp/JojQf60nOqEwf5r3rH7XKjkYlcfYw8t6mIqaN/Vrp+WA0h7XCEqQtp8uXquqn1U4It7r8k8/1FIEVgdfY9ep8sHCgEMIc7gPwJqlzQMM4yxi7Orv59xyPrzQpZ5eWwFtD/rx+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTIChhpgNOTo5pguUc0WkUEOOcIie9SiHC1wrRY0ERg=;
 b=I3fMqbYAGXyTtxiF511CRPjG5242vIisExT6NdsttF9QSQnBn81BaMjTyJUIvfFu3xJ2NFrcP0ZRzM1FUAqdjO1Xghkv45Cg2KkZgD9/4/0qQbjAYyYqOc5fOkPLJgXcU9gprNlUC3uBKEFhAZUCo4UOILZJqy0LhzouuRU5DhTYtaZP+txQiDhVvIsat7yj6ipNf2GZU6PLtgchdCWiZAOu8PB19C+FdGSmUC84ZxOabT5ZdqBri57cU6A/tdtu/lKMKpPGIRQTVB77wy9OQtnD68MtDE7Eh4d0AcBwNF4MXS12taB5OR0iTzaBWGKrX3gNWwjZ2yhgDJ8TKSjvDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xtonomy.ai; dmarc=pass action=none header.from=xtonomy.ai;
 dkim=pass header.d=xtonomy.ai; arc=none
Received: from FR6P281MB3669.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:c4::5) by
 FR0P281MB1805.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Thu, 18 Jan 2024 11:51:31 +0000
Received: from FR6P281MB3669.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3e43:48ba:1e0b:d9aa]) by FR6P281MB3669.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3e43:48ba:1e0b:d9aa%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 11:51:30 +0000
From: Fabian Herb <fabian.herb@xtonomy.ai>
To: James Prestwood <prestwoj@gmail.com>
CC: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Re: How to Autoconnect Two WiFi Cards?
Thread-Topic: How to Autoconnect Two WiFi Cards?
Thread-Index: AQHaSJvVxoxLEKp250CbS4FBMLx42LDcreqAgALKKwA=
Date: Thu, 18 Jan 2024 11:51:30 +0000
Message-ID: <D88835CF-16B7-4658-8852-65C4C3767E9C@xtonomy.ai>
References: <DFBE16E1-468A-4292-9056-D7ED6AA0CB4E@xtonomy.ai>
 <e3e82ef7-941c-4dbb-9f1b-2d1579a12f74@gmail.com>
In-Reply-To: <e3e82ef7-941c-4dbb-9f1b-2d1579a12f74@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xtonomy.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR6P281MB3669:EE_|FR0P281MB1805:EE_
x-ms-office365-filtering-correlation-id: e743a86b-2b35-4321-ae94-08dc181bcfc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5mZoD12fpV2pm3kKrdI5oo0w++aZcS2lvJbqd8dtYlWRI8uGlEzlxxHBO/7W7LZPQjp1HklYRL+hcVDnVbJVaOq3RV871x5HMxFfbSo43jHnMRJ31il4KlQTTvIRMF0q5C16RVfSbcojyrtUaqAXW7Kk8bhKrx/TvJbNjVhNFYXhT1z2SiJybzpSbEIHwWcRbDqU7Y2C509NdutL6wYs7PjSw0aivU59a2akm63HWkoQVAJABYnKg1yunp6cvgdVTY5Mk44QhmCladJN6QNwQHvNd4TLHdU65BanImj5anRujh1+cP+y423mUIH4Bloei2bU9LN2QKNE4gn+x/c22T75aoc7GbTJCSvAB700NqEwwP0/XjhFI/LK35ri3AXIpoqKV1E7Wou4AfTsIxhMiipmzVec3ruAefwlojsIg5NkbxkDXI4DlhBiT5hBSatDNjYCkdd4x0IKClrWntLXrRmPMHzkEe4uVjVaB1FK1/VlrbSyMvXMC+vRGkf1duTnPZUySbl74cDpsdX1zHfsSDw05PUf5uD/Glr1tK5MqeFKo9RGYwNR6V9MoaBQ1WxXCw8ZDaMEYbJubT0rPQXY++jCkDed6w67uECyYcc7L0LWTAkcO6EQzpPgMz8OlUCnn1cPpd6qKXsbguAYgEKDpQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR6P281MB3669.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(6029001)(396003)(39830400003)(136003)(42606007)(376002)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(8936002)(8676002)(4326008)(5660300002)(44832011)(36756003)(26005)(33656002)(66556008)(66946007)(66446008)(66476007)(76116006)(71200400001)(6506007)(4744005)(2906002)(6486002)(478600001)(6916009)(316002)(64756008)(86362001)(38070700009)(83380400001)(2616005)(6512007)(41300700001)(122000001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmRib01aY0ViQ3BkdHZIVURXZFl4b1RhWWdQM1YralZJRUQyUW1ES2lYVmRD?=
 =?utf-8?B?djRRaFovTXZYc0JKSkJrODlFQVM3bkpzU0ozK1ZERWlpNXB4dHN5bkpsKzkx?=
 =?utf-8?B?U0k0aGMvY2FuS3RBNlY5MjdsR2RCZ28vT2hRQmQvamQvUXJGenExd09hM0k3?=
 =?utf-8?B?TDNEUW5KeFNPcGVkdk85UE54QTRUa3l1TGhFMUxtcDVQZ2lXYnNZemVZWFpD?=
 =?utf-8?B?V1NEOG8yMGx3S2RTVFo0clgrZEJ0Z0h1aS92cTMxMFhxaVl3N2gxcGlETVVn?=
 =?utf-8?B?RlVQMEp0dkJzL0RhTmNLZWYxWThsWElwMjIwMjk1WE1jaVZoQU5WWGJCeUxG?=
 =?utf-8?B?eFpGeWRMRDUrUHVPMHFIdWVFS2FzMFFBMTFwenRONnhwSWhBUEw2alZHVHoy?=
 =?utf-8?B?eHg5TDlnOS9ZeEsxYkNaL3NpMTE0aldKMUtQcGRzditBY2hMZjJRalpMME1U?=
 =?utf-8?B?QkRmWWlEWnMxTVV4UmY0QTRtQ1VxWFBKM2E3NjdHMGJIamJMbUVGb3BEdFpO?=
 =?utf-8?B?YTBqSWtYRjdpZWg0ZEh6ZitjNXd3YXZ1OXpuWXFHVkVIWGRnbXVDQkdjWkxk?=
 =?utf-8?B?SjR5d0xPWWlYQ05DSTVIc09aY0tjTGFXeE5sZE1iWGY3ZXMvSjgwSTVyUzQ3?=
 =?utf-8?B?cWlmV3BqQ3dsN2FXZEErNmpBeDN4T0YwZkk0TFcvaVp2My9oNkVjTWFUdXI4?=
 =?utf-8?B?ZjNTRmtFaWFweTNxNDZWMm5kY00zaTR4Mk9QUURCMUN2bEF5T0UvMnpWM3hF?=
 =?utf-8?B?SU5CZCt2Vkd2RE5VY1FET2FYQjM1elV2eFFlMzd0Y1M0SkRTWWlvRzFLUHhW?=
 =?utf-8?B?QkhZZnZwdzdSREV4Zkc0WHZodUpTZWJEd0pJNktXMnVPbEJEbGdRRXhpYnIw?=
 =?utf-8?B?QlFFQ0RzMUlETFBScW9scE9WcmF5T21UVm51Z1RtbE5TYWh0OGVtNTE5SU5F?=
 =?utf-8?B?dkg5ZjRUUjd1V0JkVTlZc3B5aC9oZlordmsxUDRDNit3YTBRT1J6Z1dLMFFD?=
 =?utf-8?B?Mks0V1h5MlhFQ2Z1Q0wvWi9yWEc4eEEvYUt0L3Z5a3NWR3AvNmpINUhOK0tN?=
 =?utf-8?B?S0xudjljK0Jyd1hFR1YyaHptN1JNRVFGc1k3cWM5Uy93UE1GQUpvRElsNDJz?=
 =?utf-8?B?d0lqOVMrUzFWb2F6UUZScVQwTlNmbitLbXY4cWFiZjlKZDd5cHRBYVF3Ullq?=
 =?utf-8?B?K1NtSjc0TE5lU0MzNUEyNFFnQk5zazNud0h0TnpuSzRYK3J0bklLMk80QW9P?=
 =?utf-8?B?R1BZY1daY21xODdESWRNdXZpYzIvMGNDRDAwbVFoZFdrRmxBQUVVN29RYXpL?=
 =?utf-8?B?dFlUSkt3ZHZkb2diS1NrVGdwTUxONnZMSTRGM0Y4RE53R2xhVXpROFh0ZkZN?=
 =?utf-8?B?ZjRZMUM5VTNneFM5cHRPM29rNXR4SHNJMjh0a01Bck81Mm9wK1NOdUVhZGFR?=
 =?utf-8?B?YmJkdWlqTittTFB4NGp1K08rZlk5V2hwQ0Z0UVF4L1VCcHF4SDZBeGtHWm0w?=
 =?utf-8?B?SHVwSFAvTGFLaHFDS3dvYjJ0ZXorOVZ6M1lPMjhLOUVkVXcyVEI0RGFxUHZ2?=
 =?utf-8?B?R1ExMXR5VHFNalM2MUtsbkw4aEs3aVgvTTR2b2YyZnBTVXJyQWRxNFpXNDJS?=
 =?utf-8?B?QnVMWk9aa1pyMlI5UGZwQ2NuOXdmOVhYRUVlQmV4UzFLQVEwR09RZFV4RVVB?=
 =?utf-8?B?ZWNiVUR1YnRjU1JZdHJKNmkvTWJjMEZIY2NWcDk0VzFic2FzSldHaTR5Zkdh?=
 =?utf-8?B?Q0RSOTlnM3FuNTFmRHlpc2dMWkVSTjRzM29ESEJYRzJOTTdCV2ZxMVg4S0p1?=
 =?utf-8?B?c245TndXcFJ0NEpUTjE1Z0pmRGloR2JnaVpIODlPQm9leHZhVUhDbzNyQlpW?=
 =?utf-8?B?a2RkYllOamwvZStWVnNxeW5Wa1pLQ0VtUE84WTlWVnd0SXlJVjBFM0k2Q2NF?=
 =?utf-8?B?ZVBaZi8zWFIvVUdyQlRFeWlxQWMreVQ4bjcwQXpta1l4d0dkWEpJdmV5UXpj?=
 =?utf-8?B?blVxYkVOWTlkOGFtUkIzVUp1VWhwSTUyUFd5VVRER01NOTI3Z2dNRnYxb2c3?=
 =?utf-8?B?Ty9uK1JKT0k4STFac01TM3NJUlQzOVFyclpvc2JwbE1LSnd5RCtqZitlUllX?=
 =?utf-8?B?cCtEZHJ0aEl0c0xGMUNtN1BTckw5eEUwbjBmcWQ2NS93Wm00SGdidVkzd2p5?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C33B1D90FC19E469F63E1F5BB4F3318@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: xtonomy.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR6P281MB3669.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e743a86b-2b35-4321-ae94-08dc181bcfc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 11:51:30.8652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ec14d57-ef7b-4273-9e83-d36ba70a79fc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNODQanJSxeIheOlKzG/eaZoB73/rbehl7FUnF7A9Db9nf1XWhRg58to6nf+WBDcoL4kxwxmMrZ/zDOLG4AsaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1805

SGVsbG8gSmFtZXMsDQoNCj4gV2l0aG91dCBpbXBsZW1lbnRpbmcgYSBuZXcgZmVhdHVyZSB3aXRo
IHBlci1waHkgcHJvZmlsZXMgYWJvdXQgdGhlIG9ubHkgdGhpbmcgeW91IGNvdWxkIGRvIHdvdWxk
IGJlOg0KPiANCj4gIC0gQ3JlYXRlIGEgbmV0d29yayBuYW1lc3BhY2UgKGUuZy4gbnMwKQ0KDQpU
aGFua3MhIEnigJlsbCBsb29rIGludG8gdGhhdCBpZGVhLiBBdCBhIGZpcnN0IGdsYW5jZSBpdCBs
b29rcyBxdWl0ZSBjdW1iZXJzb21lIHRob3VnaC4gTWF5YmUgdGhpcyBjb3VsZCBiZSBkb25lIHdp
dGggTFhDIG9yIERvY2tlci4uLg0KDQo+IFdoYXQgZXhhY3RseSBhcmUgeW91IHRyeWluZyB0byBh
Y2NvbXBsaXNoIGJ5IGNvbm5lY3RpbmcgdG8gc2VwYXJhdGUgU1NJROKAmXM/DQoNClRoYXTigJlz
IGZvciByZWR1bmRhbmN5LiBUaGUgbWFjaGluZSBpcyBtb3ZpbmcgYXJvdW5kIHF1aXRlIGEgYml0
LCBzbyB0aGVyZeKAmXMgbG90cyBvZiByb2FtaW5nLiBSZWNlcHRpb24gY2FuIGJlIGJhZCBpbiBz
b21lIGFyZWFzLiBBbmQgd2l0aCB0d28gV2lGaSBjb25uZWN0aW9ucyBhbmQgODAyLjExciBGYXN0
IFRyYW5zaXRpb24gaWYgcG9zc2libGUsIEkgaG9wZSB0byBnZXQgbmV0d29yayBpbnRlcnJ1cHRp
b25zIGNsb3NlIHRvIHplcm8uIFJlZHVuZGFuY3kgaXRzZWxmIGlzIGRvbmUgb24gYXBwbGljYXRp
b24gbGV2ZWwuDQoNCkJlc3QgcmVnYXJkcywNCkZhYmlhbg==
