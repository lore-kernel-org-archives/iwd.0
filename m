Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11021092.outbound.protection.outlook.com [52.101.65.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A218EAB
	for <iwd@lists.linux.dev>; Wed, 17 Jul 2024 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721244920; cv=fail; b=d5hgOtXEudysSV57MDi2rixpgqx1VvVdbtblFLXmSTTuiKjOMehojjsVUZt4Ri6kMItMy0gyHKFbsh5Q14w2zll3nE7eoIzENKf2goPUPMaGJEI/HAnP6ymbM9pUiF5TPtSt8yrhIsDMRWp0a3bIvOkY4GiYr/mVEXAZF0fdX3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721244920; c=relaxed/simple;
	bh=fLcAP5FABDg8ODiTZxQlfbs+xmD4jX4QSWkuskcCShY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hQwbL0SBg2XXlHCvjQLvsyHgXvMSXAU4N/tDAKZRQWE8WsPEIY7i93mFC1JjL25A4uv3g3swZAigeEgXhV+8Ty055pP7UQ15ZO0OeDQpP3gPs7L0VDT+J2UwY3X0vdL16Cp4IYlL0Btup3tkYF32y7n+6HbadC5y6f0LY/7oapU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk; spf=pass smtp.mailfrom=bang-olufsen.dk; dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b=p2MKYTFt; arc=fail smtp.client-ip=52.101.65.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="p2MKYTFt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iob7JLUY/MHIIU1d79aHPweeKHV2Bt8SAGLLS2ROlAyj8vzleVzFe3Ui/GC9SljOHj2UrXeUCxeg1CTRmpjGr4nK0qrizYUPAT38VdzFWGuFNw9vXy2WXEDu1hFu1B2XJCubOSVO/T46q+3tHVeCVykp6RaS/KBSwHJ59sHxFZFdiiLOzXV8eCqUBetx20Bxz4HdIiwXHVmDAZ4+a4TwYMLfiyj2SReyAook2ZTlVFyd2VXkJH1jCHAoaZkHR7aSdSZBaGQ36hHXjLzj7YWRwwMfCc212XQlelVotv65t9nADTiXnA6w6LkW6fVuxczwofSkrDWwmChd/pvxC2BE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLcAP5FABDg8ODiTZxQlfbs+xmD4jX4QSWkuskcCShY=;
 b=wcLqTpVrsrcTIjP9D73tXUbPozReY65SVwNywWXcfJKCSnZRrHWP+b78C0QWLc0OC3Fb9ZNap6/gI1KwChoq3271FFmgKg8aotHzTFk+dqTbFSPTf6WRn6bA1HtRyZtHn5kZZmROaDS1L9IbORpKmk4pTcr8iOwEQEusOdLRLr0At8XasdBpqT2FB44UdD7ZN+Phm6RqFcBPxM0s2KXVVhJGClDDoTWdGS1vyOIq0KJX3B3LY9W3+nJFF6zG0gGs3XtgIYgEklge5BZAJQXtw054F+wYM/3Mc0VB0yFgbvvGbPVRYdEqxsgSMai0Jp8bmXHqx5j/lU0hmb24++XqLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLcAP5FABDg8ODiTZxQlfbs+xmD4jX4QSWkuskcCShY=;
 b=p2MKYTFt1tAAFSoVjgYLX8f9iljKhC2ISdFSRpsdR0og1xyLuEgvYHvSgqQDu0jB4rfBDCPK3aFbz/vT7zf4f80QRohhd365dFbzEIMnq2tMx0BB2+K+CA6yWPfsaQwbiWN62457JSV8hQOY7O34SD+VvsKyM4eiJitL8zFisOo=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by PAWPR03MB9716.eurprd03.prod.outlook.com (2603:10a6:102:2f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.31; Wed, 17 Jul
 2024 19:35:14 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::6ac3:b09a:9885:d014]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::6ac3:b09a:9885:d014%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 19:35:14 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: James Prestwood <prestwoj@gmail.com>
CC: "iwd@lists.linux.dev" <iwd@lists.linux.dev>, =?utf-8?B?UGVkcm8gQW5kcsOp?=
	<PEDA@bang-olufsen.dk>
Subject: Re: [PATCH] netdev: handle disconnect event during the 4-way
 handshake
Thread-Topic: [PATCH] netdev: handle disconnect event during the 4-way
 handshake
Thread-Index: AQHa2FpVRa8w/qTuXE+jlMip0WtAF7H7UC8A
Date: Wed, 17 Jul 2024 19:35:14 +0000
Message-ID: <egk54l4s2ylywom72plctncrjbvwvd4h3ddcrnlnbqecl5f2l4@pd7ojuwyivf2>
References: <20240717140009.2648885-1-prestwoj@gmail.com>
 <a3c34f70-9620-4a27-ac76-ab55b2bc636c@gmail.com>
In-Reply-To: <a3c34f70-9620-4a27-ac76-ab55b2bc636c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|PAWPR03MB9716:EE_
x-ms-office365-filtering-correlation-id: d0b38a24-47f3-48ac-562b-08dca69794ae
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MVJnMWFaZllYN3lFU09IVVQxbXg1bTVHNDNhWkNpZDhZU3JnVWNPNFZObEdO?=
 =?utf-8?B?WDdNblVGZk1oNGdYTFM2M0NBb1VUZk90SU01bFFSM2VET1VsSHNwNVVaR2hs?=
 =?utf-8?B?TlE4aklpWUtML09UMndiQkpJSUtqZElIUDlxMXd0ZHh1RGdFT1IyUHdYc1oy?=
 =?utf-8?B?eWx2bzZnZ3FsWGx3TWpiM0tGaVo4OXRiN0YyY2Y5UXFlbnhocVBUTzVLWHEv?=
 =?utf-8?B?M2NHbGk2ME1MQ1BzZWtBNjlnS0VYV3J4OW52SVBvOFJPOWc4L21jVXc5SlQw?=
 =?utf-8?B?Y1FCUldUckw4ZURNb2dDcThRTkRKRlYzU2VpeEprcGRVMHpvb25hbWxsZ1Rh?=
 =?utf-8?B?VXhRUFlkeTFHMkZFVG9tODhwVFBHQi9lLzFiditHb3VOU0drV1FoTEQwMk1G?=
 =?utf-8?B?ekNFT1FiajV5cHdjNmNuck4xTkg3NEVnOFhtQm4rWHlRK1lLRHhKTW90S3Br?=
 =?utf-8?B?elMzd080MlVnSGdkU0x5c3V0cG52Vml2TEFtUytRWlAwR28yMThZVjhMWitZ?=
 =?utf-8?B?Z2VNMTVPdDRTYzZhWWhHSFduZ015RlJHeEJLeGxaOFhUdDdnL20rcU1ZTCtK?=
 =?utf-8?B?K3ZNY2h3ZzJZU2wwZVMzY2lyTUNJS2djV0UwQmxHRGw0a201Q1RCcytGQzJq?=
 =?utf-8?B?eUc3ZWxoSW9TQ2pUeGJjRFpPYVlxMjB0ODM2RUFPUXhEV2xvdHZreGJndXY4?=
 =?utf-8?B?WjRBK3BRUHhBeXAxOTZycWlEYnhLTmVRbkRzWjNZQWZPOWpGOTVzWkNhLzc3?=
 =?utf-8?B?ZjE1VmJZTXh2OEtIbmZyTk54MkxMWE52K3dwbUdqaCtXK0tMU0RXL05CdUpB?=
 =?utf-8?B?bUZUZ0VYbENFR0hhaUpMOThTM3h6VXM1WjYyREdPcVVWcTE1ckFibldzQUVV?=
 =?utf-8?B?TStlSjNOYkxOOXl2cXVtc28yS2REbW10RFhIS3BpM2lURmVrdEp5cGVyZkg5?=
 =?utf-8?B?TGlPWExTVTVUaFhldkdrOHR5U2hBaXB4azJSNHA5Y1FVWXc5Ukd2ZUlycENE?=
 =?utf-8?B?clBhbVFWSHZiQkkvZUEwME1BRU9MS3NEWGxiZnh2UG1LcFJWZFdBbFM3VStU?=
 =?utf-8?B?NnRjajZ1UlYxQlFzeGhlZUt5dUxjMkowdFdOSFJsVkdPZ2RnUmdxNjVPUEdO?=
 =?utf-8?B?dTBWN3M5SG91bGVTelJucEpZS1hNdGpXTkNzdjViUVpHa2I1ellFalZjdXVE?=
 =?utf-8?B?VlNhS2JTTHFrdmFHSWg2S1hHcHVlbU03MVBpby91Um1KSXJLL2xTWWJuYmly?=
 =?utf-8?B?dUVlU29UcXZwdTI0RjdSQzFDSkY3VE1GajB4dXdva3Nya3dyNkhpc3UxQUMy?=
 =?utf-8?B?TFFUS2R4TktXMWlHUVA1SEZzVlNOUG11SzNWQUN3ZTdGcWJZK2p5OGpEbXE3?=
 =?utf-8?B?di9jWGlGZDg1TjdCaFExM0Y2TmdaTFhmV0lzMS95aWhCK2hhZXpFaEpudXhz?=
 =?utf-8?B?NkZpRzR2WHlzUVpHdklsYUc4TEp3NmdNN2pwNzNYVWtYYVlYY3dEMWZJVXlI?=
 =?utf-8?B?TEhHelgyV3hMOEhjWXR0dkh3OEN5V3paQnJYcHhKeTRsSVd2U1FsL2NlQkhh?=
 =?utf-8?B?TzFVbWVWUy9YQ09qeUprc1Y5WjZuSTUvSi9hb2lhVnJ1RUtoN0s0dUxWaTRj?=
 =?utf-8?B?eFRpMksxZzgyM3JRRjBscG9Oams3Qnk0Rkl0N1hZenNiQlRneDB5VXFWTmth?=
 =?utf-8?B?blhVdzFTWEt0eDZvSzgvemNsWklvUWdDeXBreXhRdUJkbXBXdk1pTmNGNjQz?=
 =?utf-8?B?MVA4ZFNjQ3U5Wks3bVNqNXlhbG11ZFl6alU0KytMdkhab2htME5LeUJIMDUr?=
 =?utf-8?Q?O1AvJ97ErEbnYXOkQNT8aOg4zYVr6wLa2iUCw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3NFdllGVjA4a2xrUmVaL1RVd0U4dFBZcjFGUlU3MSttYlRQQzZUakcvSnhO?=
 =?utf-8?B?MGc3RWFITmxIeTNtRWc0bVJFNE1RdDI0RGpROWFCb2xCUHBnZkhwRWJYMUpy?=
 =?utf-8?B?N3czY3RFdTlYbC9ia1U1aWFORWJZQWhzbmZCR3RRb2NjeE4vbVZsRkNSSnBC?=
 =?utf-8?B?M0lCa244dDJ6QStSUXlNVWRmQmhQWUkvdnVuZWNjVlZobnZkWHllL2MrVTF1?=
 =?utf-8?B?TXQwZWYxajJYWEtsa2VBa2pmY1ptazNZS0J6RnV6TTNwUGtSQjBId2pnR3A4?=
 =?utf-8?B?ODBnOEpGVmVJVnN4M2ZmY1BUWDNvOWpWYno0VkladG9FclEwNzR2TlY1cnNQ?=
 =?utf-8?B?R2toRnp0T2JTY3lZOUVDZng2RXI2eTYvOWFMbDdaR3FVVTJZMm9qeXB2TmV2?=
 =?utf-8?B?OWdrUU8yRVYycUNQSS83S0tZZ2Q0dGVLRmlhMGlobnB5UkZXVUs5WWQvdU9T?=
 =?utf-8?B?WFJHQ0lacVV1NFFUKzJkSk1zU0x2Snc4ay80TTRqN2xSdUExa0ZIVVpBMVVu?=
 =?utf-8?B?WXlNRGUyaFk3dTBjNEZFTkZzMHJuVWFxM1Vkb3BhZkNIZ1lVKzlPdDdPajc4?=
 =?utf-8?B?UEdJOGNqS1RYUlpHYVBMQ1RoMHdZN3MzVWFzalhYaUk3M2hUMjM2TzZ2Tmpv?=
 =?utf-8?B?SDBSVDcyRVFBUkFKTDh2eHhHUmMwUmpDVmc4UlJnc0VlNlR5aXpIbGE2TG54?=
 =?utf-8?B?SCtpd2RjMWpzQm5nNUQ0YUE3ZXlLMlVJQXJIM2dMOTV2UFA2TEdOemVjc1Jx?=
 =?utf-8?B?SG1meUZ2bkJMOGNnSU5zUUFnWFRzWml4VUFvN3EzaWV4Ukh5dzRxNkNKSlIr?=
 =?utf-8?B?cDBuTE83cENtNW5SR3hLdUVpS0hkSThrSkplTXZ6QVJpTjlXOWNnWHNRTndD?=
 =?utf-8?B?S3FxZ2c5SG9QaFo3aVlmU0F3ZUxWdmp4ZkpLQW9mQmpiMzBrblZOVDJYNUla?=
 =?utf-8?B?SnBQc0IvNlhHcEt0WHY2bWN3MzA1cTlnbk93WjJlS2RIVXNlL2VNUUlwS3Bj?=
 =?utf-8?B?UXJ4cFVNT3NUYWxSK2h5S0RHK1V2cEVGQmw2OWdVYTNqbCszNXN5Q1ptUlBD?=
 =?utf-8?B?NFBjQlhNRHprOTIyem9MMjR4RjRicWFSV2p0MzBSRlppUWdvOU9YS0t6SGVK?=
 =?utf-8?B?dmNjUytxclgvUlJaT2F5VGgzZFFiT0x2cG9OQkhzWTJ6REZkamQrZFNmaE9Q?=
 =?utf-8?B?ODVmdzB6aWk3UEkwNGF1RDBVVlUvUCtzYzZKSjhuNHFPb1dUNDJJSXlUTEpN?=
 =?utf-8?B?a1djWnViZUhNbjNlQ2YzNG81V0svbU9XQjRuMmU2cXgwbE5rcVhVbndLeENl?=
 =?utf-8?B?bTU5VFFYeXUxbFhDcEJSUTRuS3I4MlhWV1AzVGJlRHV5WWhqOUR6eVBJWXlk?=
 =?utf-8?B?VWl1VWtaMWdELzl6MHJ0R3hPa3IyMmFBUWxmQ2luWTBCU1hUY21BN1RuZmhI?=
 =?utf-8?B?NklaWjlIcktESnNBNTR2QjU1VVBVS1pWeitjVGZqWUE5eXhnaHN2QnBkNHhY?=
 =?utf-8?B?MGFneHJRK00zWHgvMlY3Yy9vYTFIV0xXT3QrNzQ2N0tBTzZTeTIzYnBkY2VP?=
 =?utf-8?B?QmU5Z2IrclVSK01uQjdJNjB1VGdwb0JudnhKRzFaMktvS3g5UVUreW1mK0hL?=
 =?utf-8?B?QWtKVUh3UkJxQit2cStHdll0bzBoOFZUQ2FON1FaMnpLdVRDckFJL0tmZWxs?=
 =?utf-8?B?SDN5OUM1VlRXcHRZYjNvTGJLQ1VaSGxmVlFWbzV1amRYMHdFc0xPUGg3VXB3?=
 =?utf-8?B?dXIzSGdLMFN0MzlkRVdsRURqOUloMXg2WTJjdkIrTG4zVFQrQXBtOUlsQWF1?=
 =?utf-8?B?bHNGa2l1L0l4Rk9uUDEvY1Y2bWFvVHdLSURJYnJYUDBZNDI2YmxSZjhmT3l6?=
 =?utf-8?B?NFI5WFBlMGpxMVB3YlJPbEtYV1Avb1p5dEF3elJtZnVCaGQ2VVcvanBJc0lv?=
 =?utf-8?B?ek5VcFI0Ry90R1FOR2dnVGNiTUpvbzNLVHdGQTE5aUVDVWxWd3plSVgrb3JV?=
 =?utf-8?B?TDB3ZGY4R0V5dlVqdWtCWTVmRlJWRTdVQ3FERGMwRmJGVHpaajVsTlo2eUpT?=
 =?utf-8?B?RFQzOXdYTmFTNkFJeXMwVE1BL2ZOekY0RW5IWEYrWkFBLy9tUjBCK1c1WWFs?=
 =?utf-8?Q?wR/WNtMS6Bu7n1NhOZBoZhqeW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9370D76698CA7B40B691BF387F1DDCA1@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8805.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b38a24-47f3-48ac-562b-08dca69794ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 19:35:14.4135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HQyJ93oCx7nSmX7LaN1LsBLwMtXxfZ0/QGky4SMc4/J8xjdKMjAgRrZqet/3j4KqW/D5PeuNZ/u+c1ajJBsYaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9716

SGkgSmFtZXMsDQoNCk9uIFdlZCwgSnVsIDE3LCAyMDI0IGF0IDA4OjAyOjE3QU0gR01ULCBKYW1l
cyBQcmVzdHdvb2Qgd3JvdGU6DQo+ICsgQ0MgQWx2aW4NCj4gDQo+IFlvdSBoYWQgb3JpZ2luYWxs
eSByZXBvcnRlZCBbMV0gYSBzaW1pbGFyIGlzc3VlIGJ1dCBpdCB3YXMgdW5jbGVhciBleGFjdGx5
DQo+IHdoYXQgd2FzIGhhcHBlbmluZyBhdCB0aGUgdGltZS4gSSBiZWxpZXZlIHRoaXMgaXMgdGhl
IHNhbWUgcHJvYmxlbS4gVGhpcyBtYXkNCj4gbm90IGJlIHRoZSBmaW5hbCB2ZXJzaW9uIG9mIGEg
Zml4LCBidXQgSSB3YW50ZWQgdG8gQ0MgeW91IGluIGNhc2UgeW91IHN0aWxsDQo+IHdlcmUgc2Vl
aW5nIHRoaXMgYW5kIHdhbnRlZCB0byB0ZXN0IGl0Lg0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2l3ZC8yMDIzMDQwMzE0MTkyNy4yMzUwMTQtMS1hbHZpbkBwcXJzLmRrLw0KDQpJ
dCdzIGJlZW4gYSB3aGlsZSBzaW5jZSBJIGRlYWx0IHdpdGggdGhpcyBwcm9ibGVtLCBhbmQgaW4g
dGhlIG1lYW4gdGltZQ0Kd2UgaGF2ZSBiZWVuIHVzaW5nIHRoZSBvcmlnaW5hbCBwYXRjaCBJIHNl
bnQgdG8gdGhlIGxpc3QgYXMgc2VlbiBpbiB5b3VyDQpsaW5rLiBVbmZvcnR1bmF0ZWx5IEkgZG9u
J3QgcmVjYWxsIGhvdyBJIHJlcHJvZHVjZWQgdGhpcyBpc3N1ZSwgYnV0DQptYXliZSBteSBjb2xs
ZWFndWUgUGVkcm8gKCtjYykgcmVtZW1iZXJzLg0KDQpSZWdhcmRsZXNzLCBhIHN0YXRpYyBjb2Rl
IGFuYWx5c2lzIHN1Z2dlc3RzIHRoYXQgeW91ciBwYXRjaCB5aWVsZHMgdGhlDQpzYW1lIHJlc3Vs
dCwgc28gSSB0aGluayB0aGlzIGlzIGdvb2QgLSBvbmUgbGVzcyBwYXRjaCBmb3IgdXMgdG8gYXBw
bHkgOikNCg0KRG8geW91IGhhdmUgc29tZSBlYXNpbHkgY29tbXVuaWNhYmxlIHN0ZXBzIHRvIHJl
cHJvZHVjZSB0aGlzIGlzc3VlIG9uDQp5b3VyIGVuZD8NCg0KVGhhbmtzIGZvciBmb2xsb3dpbmcg
dXAgb24gdGhpcyENCg0KS2luZCByZWdhcmRzLA0KQWx2aW4=
