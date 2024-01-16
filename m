Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2082.outbound.protection.outlook.com [40.107.135.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFCA18E06
	for <iwd@lists.linux.dev>; Tue, 16 Jan 2024 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xtonomy.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xtonomy.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLYnj3m7kHhLxu7A8kdwJyDkYmfrKHTcYo8NLZCIsa8r/tNsQt7cmRqag/S545DX7UAYrUCN/U9yBS7H39way0Ae0ZI/6uZBAI1Fq6EaOUlpy5Egko9HYosXFylZrei4E/uHGletRAJzdqoGKCfe15Y4Pq1F/TBz1uNOhOSg8JWab53iVsYLiy990LVpiatsgjeWr5KcePTGsEF8CnVJvQ3Wn3npPoFRkeKnU+xsNwT73aaLBgwc49/MMv1wyvc2+otu3vnOCVkCyOkG7ikbMjSrddloaPHKFGagcq2funsl7daOFWEslTHwNANLOQXz/PGnULICTb/Ov3FkQcP3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0ecK4toSbg7yUkRCGWSNOhjImnPIFKC5XNNo04xso8=;
 b=iHlH35gvyDUV37Ls1xnpPIyJa4DPAONS+P9cvyoYaaBARtv4a+Dp9cQKkHVvfPaLSkKH5Ao6++vkDqPZZiLp2GCSRtTZFhHbd7PHxGRykqP+3B42cAmmhfvsLfvO89plboFPqYIbuV5t6l4n/cXTKmvg+h9fWdwYWUlgnVmi+ack9/NWQZF39ZSTNYrJny20XTwvd07cpRo6216s9yBNq1nL+moc7aROcgs5KgYWJPPqOfme5zsy13AgKmHtfLpaBaoWOfJlym0XKBrxbfJHdQS/hzmu6UrXI+4OkZjavdJrvD4LG421RUbwscu6hkf2ZpaXXfy3T5tYNq+R8o91+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xtonomy.ai; dmarc=pass action=none header.from=xtonomy.ai;
 dkim=pass header.d=xtonomy.ai; arc=none
Received: from BEUP281MB3675.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:9b::10)
 by FR3P281MB1454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:79::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Tue, 16 Jan
 2024 16:48:29 +0000
Received: from BEUP281MB3675.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9b74:50c6:11d5:b698]) by BEUP281MB3675.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9b74:50c6:11d5:b698%2]) with mapi id 15.20.7181.029; Tue, 16 Jan 2024
 16:48:29 +0000
From: Fabian Herb <fabian.herb@xtonomy.ai>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: How to Autoconnect Two WiFi Cards?
Thread-Topic: How to Autoconnect Two WiFi Cards?
Thread-Index: AQHaSJvUl54Mg7xcpUa+1cFhgA3Qaw==
Date: Tue, 16 Jan 2024 16:48:29 +0000
Message-ID: <DFBE16E1-468A-4292-9056-D7ED6AA0CB4E@xtonomy.ai>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xtonomy.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEUP281MB3675:EE_|FR3P281MB1454:EE_
x-ms-office365-filtering-correlation-id: 233726e6-62bc-4659-ffc2-08dc16b2f780
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8jB7xkRF3vRGQQ5FH/TaoQNBVxV1cq2DavTsD1FNX/HcOqZhoVYS191XCFDTKjAnaly+9MX7lrWD232oEWI958Q69eOGuL6TftsAzQIxTJ3FEX2Yxh6hQr+0ps28rPLsc+NxqcC+1snRchXNDBp5zeR2uiibb+IL4qYLuMgmYx5rhuTsknyFjMJbzEBLde0eEeBsgd+2oswHceuHtS3Iu4jSUjPC4yA5cVzP3woOzuiU20HU60eaeDpRy/leJNa6KzLwVmEb/pU5tBBzDuYHdM1C/j8QfyQ3vPJriD3vtFQ3b5OLaLyPKAqGap+vlc9AbKNl/Sh5NCYyxN10Ug8WQU0pfttUoYuXo6enhYN5ISAcy98+o3B89cdhumGnL7vjJK8DjD99Ej5ldxxhdWIBHiI/vZ1pJofRyp7vcalyQ4YgybM9H4RObSeE6wbwyZfkYKOtaCMTVyDLzMnmS7yzQrKwN0Bns95eG88uXnkPA3vQWNT2nX+htUVY0ndDgEVugSrZ3SDcn0cbDIX7s+iscbxrolYY9KOd00xZDovSdPnmbN7Vn5mMRn3dj6jiwOH2PhFM6zVn5YrTox1joC460RnV6PGpHPZ1XOnFxgCRRdS1PJ1jKcaPXqosKmaDH5WrxVJWBy1IlwiZLrzgVF9cVg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEUP281MB3675.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(6029001)(396003)(346002)(42606007)(39830400003)(136003)(376002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(8936002)(8676002)(5660300002)(6916009)(66446008)(66946007)(66556008)(66476007)(316002)(64756008)(2906002)(2616005)(26005)(71200400001)(36756003)(86362001)(33656002)(44832011)(91956017)(76116006)(478600001)(6486002)(6506007)(6512007)(41300700001)(38100700002)(122000001)(38070700009)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWF4TVd6blFOMFhUQVZRUkpjaVVGL2kyd2w1L1FvdThpRFVQWG1OUm5RR1Vs?=
 =?utf-8?B?QjNSbnp2QWE1WFpDSEsrS3NFTlc5VUJNdlZqSUU1aGphbi9jRGZqa05Pc0dp?=
 =?utf-8?B?Z05UTjNLd2tIWjlJSFpoMHNkblBhcGg5MGVFbVkzb0NZK290aHJWa1hORk1Q?=
 =?utf-8?B?SmtZVTQxUGRLckNDcGRMQm1YYkw1TlRneExqZGYydHFFYWczMDQxM3ZQUVIv?=
 =?utf-8?B?U2RUVnZZYUc4enUwTFRnMWZRYTJaRGYyVy91VFY4OGNKS2ppaUVRT3FXMHgz?=
 =?utf-8?B?RFh3QlZQcXJ2M0pKU2VHTmpRRktrcEVOMTNPU2Y1UlVKZXo0OEVrbDdLMVZN?=
 =?utf-8?B?b01JYi9UbVY3RCswd2Q4Z0s3VE5ZaUlTcUMwS05aY1c4UmhhT3Z4WHNuV0Vq?=
 =?utf-8?B?eXA4aEFsWS9DeFFXSW4yRHJYSHFzaGR2TG5WK3Y3U0JxSXM0c1dMVDVTeW8r?=
 =?utf-8?B?RzZlUXZrWEd1OE1jTzhtUGRhUitCWGRCNnNXVllqNnpicHVoOEdlSUx0ZHJm?=
 =?utf-8?B?U0p6bWd2OWRMTFdmenBDUXZkUWVTUDNwWlZkMXo0SDVMMDlIZWNmMlpmL1dO?=
 =?utf-8?B?cmhaSElycEhWK2w1SXdMMGhlaWpSQjZOZnM0VmJIMndaajZvS1VJRis1cW52?=
 =?utf-8?B?MGxqSHJRRXBja1oyMVJGUTJGU2RWdkMyWStUWGZMRDhKVEtBZGFwUkVlNmVB?=
 =?utf-8?B?aXBzZG1KWHB2MG0ydVMxVVh2cGs5eXRaQ1dNYXBiWGs3Z2o2VW5DV3h1bk1P?=
 =?utf-8?B?bGp5b2JIblpkdTFVSExFTVlTRHcxdmtJcit4bFJteGNyT2d1ZjA0aXl0bkNW?=
 =?utf-8?B?eWxPTjNPdDJYSnpqUmVzUzUvckR2MkNoT2xCZ29sMEloSTRyeGF1MGlFck1Z?=
 =?utf-8?B?aHRydEt1VTVtNFFKMkl6eGlBaTE3dFJyMEdXaGN3Wm1rR0VhNDZqVk43Y0lD?=
 =?utf-8?B?ZjRWTkdNa0RRampmY2J1V2NIVVgrbUlHVU0rdWNldmZpZmhkcmdYVE5hK016?=
 =?utf-8?B?bWU0ZEZQN205RjVSRkZ3K1Vnd1hUem5zTVY0b1IvQ29WYkpjQ3dLNVdJMnNr?=
 =?utf-8?B?OFlXR1ptc1lsdzhyc0dVb3JGNDBrOC93Ri91eEUvWFVwSU95R1ZQVmphTFhy?=
 =?utf-8?B?WHU3RHdKemJCeWJJM3RmVWtqRnRoTVhZek5MRTBVSUlocTdsZTcySUFQZTk3?=
 =?utf-8?B?dmt1UnljSE03NEFNdHFoKzg4bG5DRC9jQlQ1N1RtTDJWNVQwQ3VVU3ViMHE3?=
 =?utf-8?B?TnRQeTRSdlRPSFBHMjVFUHg5dUdTcDlsQnNoWkNGcVgxYW0rU2ozMEl3L25u?=
 =?utf-8?B?Y25pb3Z4c0taUmhrUHZneHZsMzY2cVh6U2VQellzdUVmZ1Q3N0ZSUUFJTkVh?=
 =?utf-8?B?dHUvQXd2SkhneU1PR1c1SUpCUlVkZ0dzajBNOWdmd1g4QWRxN25tVFdxUjc5?=
 =?utf-8?B?NlMvRy9YMVJOQnJHamF0YUVtSTNNRDRmT2Y5VCtJY3hzZTYzOFJ4NkFnMDMv?=
 =?utf-8?B?bXlIVGUzbGxIM2M3WE5xWGlLblhwOVJQYUdVODhQcXR5cFdoU3ZjMzl0VzBH?=
 =?utf-8?B?S2lveWJNY05EWWs2bTVYOXBXbEt2VThLcnpva0Z1SnZHM1J4MjBVVFNSNFYr?=
 =?utf-8?B?SnlLVUZqYmF5TTBsSzBpbXdzZDRyYlFGa2FSdUZRUzJDdUIwa2JBQlovUU90?=
 =?utf-8?B?Sjlnc2kvNStTRXBwSFVKaFFYWU1PSHJOR01jQ2FVSjRiT2sxeG1ZNWpLU3hJ?=
 =?utf-8?B?MDZzVW1UWDJLVGZyTlg1bE01N2ZJRG1OM3c0VE1tZWtjS04xK0FvVE9aWWpL?=
 =?utf-8?B?SnlMOExla0RMSzZHZkpXQVd6QkFWVDEvcXhINXplV2lkby9tZ3lIQmZZNlA5?=
 =?utf-8?B?c244WnNxUW5SWmxNYW1sOXdlOVJPaFRxODVHUE53MkdsZC9pcEZ0cVh4ZVRP?=
 =?utf-8?B?ZVl5dkMxcGZYZ1BlRTFuWlNXY1hVMmRnNTdwUkw3bktkRU5MYkpJOXhCck01?=
 =?utf-8?B?SlVaQmhGWm1VVmRqNk91NXhaZkNaUjBueDNjNmh4ZzArM282MGEwV2tWUXR4?=
 =?utf-8?B?WjZGOXJ1eEV3eVVPRHJINzVacW5mQ25XQzJpQk5wczRxblprMTRIUS96WVA2?=
 =?utf-8?B?SXhuMnBYaW1aSDVnbE9IbkppdC9HOHo4eDcxZCt1b0w5ZlZJVFdqZlJnY3NV?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B8206027C7D3649B9D5FD0919128308@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: xtonomy.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEUP281MB3675.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 233726e6-62bc-4659-ffc2-08dc16b2f780
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 16:48:29.1605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ec14d57-ef7b-4273-9e83-d36ba70a79fc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzV0vPMjSjKJSLms171M5VDIsdWVh9V4HMJFKtsLvK4214hzeFawtrCYuQDUjs1KIYuaokyCG7l8cqz4EzCO5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1454

RGVhciBpd2QgdXNlcnMgYW5kIGRldmVsb3BlcnMsDQoNCkkgaGF2ZSBhIHNldHVwIHdpdGggdHdv
IGlkZW50aWNhbCBJbnRlbCBBWDIxMCBXaUZpIGNhcmRzLiBJIHdhbnQgdG8gY29ubmVjdCBlYWNo
IHRvIGEgZGlmZmVyZW50IFNTSUQuIEF1dG9tYXRpY2FsbHkgaWYgcG9zc2libGUuIEJ1dCBJIGNh
buKAmXQgZmlndXJlIG91dCBhIHdheSB0byBkbyB0aGF0LiBFdmVuIGlmIEkgY29ubmVjdCBlYWNo
IG9uZSB0byB0aGVpciBuZXR3b3JrIG1hbnVhbGx5LCB0aGUgbmV4dCB0aW1lIHRoZSBzaWduYWwg
aXMgbG9zdCBhbmQgYSBjYXJkIHJlY29ubmVjdHMsIHRoZXJlIGlzIGEgZ29vZCBjaGFuY2UgdGhh
dCBpdCBjb25uZWN0cyB0byB0aGUgd3JvbmcgbmV0d29yayBhZ2Fpbi4NCg0KVGhlcmUgaXMgbm8g
b3B0aW9uIGluIHRoZSBuZXR3b3JrIGNvbmZpZ3VyYXRpb24gZmlsZXMgdG8gbGltaXQgYSBuZXR3
b3JrIHRvIGEgY2VydGFpbiBpbnRlcmZhY2UgYXMgZmFyIGFzIEkgY2FuIHNlZS4gSSBhbHNvIHRy
aWVkIHJ1bm5pbmcgdHdvIGluc3RhbmNlcyBvZiBpd2QsIGVhY2ggd2l0aCBhIGRpZmZlcmVudCDi
gJ7igJRwaHlz4oCcIHBhcmFtZXRlciBhbmQgU1RBVEVfRElSRUNUT1JZIHZhcmlhYmxlLiBCdXQg
dGhlIHNlY29uZCBpbnN0YW5jZSBmYWlscyB3aXRoIOKAnk5hbWUgcmVxdWVzdCBmYWlsZWTigJwg
KHNvbWV0aGluZyBELUJ1cy1yZWxhdGVkPykuIEkgYWxzbyBjYW7igJl0IHNlZSBhIHdheSB0byB0
ZWxsIGl3Y3RsIHRvIHdoaWNoIGl3ZCBpbnN0YW5jZSB0byBjb25uZWN0IHRvLiBJIGFsc28gdHJp
ZWQgdXNpbmcgTmV0d29ya01hbmFnZXIgdG8gY29udHJvbCBpd2QsIGJ1dCB0aGF0IHdvcmtlZCBl
dmVuIHdvcnNlLg0KDQpTbyBob3cgY2FuIEkgZm9yY2UgZWFjaCBXaUZpIGNhcmQgb24gYSBkaWZm
ZXJlbnQgU1NJRD8gT25lIG9mIHRoZSBTU0lEcyBpcyBvbiAyLjQgR0h6IGFuZCB0aGUgb3RoZXIg
aXMgb24gNSBHSHouIERvZXMgdGhhdCBoZWxwIHNvbWVob3c/DQoNClRoYW5rcyBpbiBhZHZhbmNl
IQ0KRmFiaWFu
