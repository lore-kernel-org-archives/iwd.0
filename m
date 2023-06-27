Received: from us-smtp-delivery-145.mimecast.com (us-smtp-delivery-145.mimecast.com [170.10.129.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C79D16417
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 15:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvh.com; s=mimecast20180413;
	t=1687879805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JV+Fu7rexpGJ6Zr4bop9RD8J8WVp4eozFZaDKuk8OUc=;
	b=fZk9+ZVe/b+Jwr+CjfYr2XcslyiSgGvrUwMOusnKA8EDOV1PZjjs29YibfMCoD3iSbe63Y
	0XqMFziYZNTSVn3ZPxZlGxLGMNG5CJ64eohjXbvj61xHhuwddHR1fQV1DQgS4UJhqALFWy
	x36I8PDi6EQLHyP6Im71sU6aFkkPjQg=
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-DhhuTlOfMQWUu6TQlyEcrQ-1; Tue, 27 Jun 2023 11:29:43 -0400
X-MC-Unique: DhhuTlOfMQWUu6TQlyEcrQ-1
Received: from MN2PR07MB7167.namprd07.prod.outlook.com (2603:10b6:208:1a6::10)
 by CH2PR07MB8186.namprd07.prod.outlook.com (2603:10b6:610:34::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 15:29:33 +0000
Received: from MN2PR07MB7167.namprd07.prod.outlook.com
 ([fe80::90b7:d2fe:d63b:f516]) by MN2PR07MB7167.namprd07.prod.outlook.com
 ([fe80::90b7:d2fe:d63b:f516%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 15:29:33 +0000
From: James Tavares <jtavares@kvh.com>
To: Martin Petzold <martin.petzold@tavla.de>, "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>
Subject: Re: iwd forgets network
Thread-Topic: iwd forgets network
Thread-Index: AQHZqM5qeqGH4Ke8GkK+Sl/fa4SaYa+eg6wA
Date: Tue, 27 Jun 2023 15:29:33 +0000
Message-ID: <61D86659-745B-4228-AC0D-216E5CA292D2@kvh.com>
References: <7794c62a-56d2-d34a-06e9-0b17edb235f7@tavla.de>
In-Reply-To: <7794c62a-56d2-d34a-06e9-0b17edb235f7@tavla.de>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.72.23041401
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR07MB7167:EE_|CH2PR07MB8186:EE_
x-ms-office365-filtering-correlation-id: 4356497c-4273-4da5-2675-08db77234ed4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: UsasdhctctJna9oySGStg8P/LtLQFWmtTWiY/X4AuxnwD2uNztrTr3k+MKgWc4qPMCLpT31DgaJ4gHEY5XYnJY9u9/GhooP8Eq8LkCW04VXi+/oYoKHQCbRewwuAodjESuCmf7js2OeYLBAfO5HcYkn1UiLFxOd95A0q+duCdQjFtlsDCdC79ck+Q3RoBJk66r42bCCLj3RopbMA+mcmd6OcS8dYrw1f4bTGPYSDNpHSKarfl94U+eNKChpPo/3kalkogu7QAW8egozWRTB8nC0psSAvET0dK8UavqkC46BEeUJnIM4JkL0XpJOAvFB4IOAJHb2h+uVTyOCxIh8z390OwGDr3DEO6ZT6hdvatErxq5EXzmp0dw6oNIrxQHab8xQf79960vUqrUkPNRWshQlUPgIeVvGbujDre4P36du5PKunmAjjQr0Dcu2RdrrLlcs4sNMIJZXnimerivd5V3eDMLPUnzbvOvAccCCvX3rvvBIzlLHTl4+JdOOIHP/a1bSH7/sO0YL4F8SGzGgFRti/m//9T3/JnzbrquE5UBIeLaQHCRHL71XHHucTfHRNMdNXIk1s8oIIDjxxrilduQwvmmZsQjSrJ+Jpx6s9Ps5QkSGJjHTZQMgvCacE+gqzk4R3WBk62MhCB4Ot4UfJ4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB7167.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(376002)(346002)(136003)(396003)(366004)(451199021)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(8936002)(316002)(41300700001)(6512007)(6506007)(186003)(26005)(4744005)(110136005)(478600001)(6486002)(2616005)(71200400001)(7116003)(5660300002)(2906002)(38070700005)(122000001)(38100700002)(33656002)(36756003)(3480700007)(86362001)(66574015)(45980500001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1JZTjZUcU1wNWtvd3RYWGk4U3BEK0dUMzFFWDcyR3FOTTE0T3lscG1vOC9P?=
 =?utf-8?B?QWlmZEd4b3M5NFJsZEZrRjZ1VE9YVTZBZjZwNVN3dUZwT2F5SmNMMHRKNEFT?=
 =?utf-8?B?VURQSks5YVBuT3NsOXhMY1pya2IzSG56cDdVVmcvRUhxNndxa05VYytMVUg4?=
 =?utf-8?B?QVVER1h4QmEwNkNwS3dVUGt6T3hDcCtiOEltMUlPcExsSTFqNUViQytEM1Z3?=
 =?utf-8?B?RXIwZ0V0TXowMlZPRHQ4VWVubVVXV1RJWUlpMUY3dGpBbDl0Wm9rc2NoRXdD?=
 =?utf-8?B?Tlk3MWQ0aDdQNlUxUXprUm9RQ2drd2lBdnhFaVVhYWxvblorKzBsd0pWS3FE?=
 =?utf-8?B?cnFjcnRPM3FYbzRieW92Q0RLQTVwcFRtVGhmenVIUTFWZE9mNWwvNzhrdlJZ?=
 =?utf-8?B?WGVDRmZuWWxrU0EyRGdPSjJXR3d4cXpMaTlTbjl6VlBreDQyMUlBWjhxQmQy?=
 =?utf-8?B?SzNSNUJsSFp6ZVBRWTBTUFZrTGl0endHTU5zdmh6TFRoNTF6NSs0amQ3Vys1?=
 =?utf-8?B?RmVNR0RwaXVrSDVzMFRTTklQNmNaamNEeWVIdUZNSk5jMG1UWU50UEpXeHRB?=
 =?utf-8?B?dlNnSnV1TUN1Tms2Tms0RHdtWWdoNVNkWm0rbnRtNWFwL2RxM01PeWZLMk5Q?=
 =?utf-8?B?eDlYODZqSmRNSWd4b203aS9wWDRXTzBSaGVEUmlpRTMyZWhkdGF1bExBU2tw?=
 =?utf-8?B?NENXak1EYWRRaEswcDAzNExDSzFuL0V4K2JqQm1YUzE5RmlmeTFNMUExZEFV?=
 =?utf-8?B?WHdab2RCYmxRU1NBZnF1OWxHU0NQZWVmbmhGUE5xWE50dHNTajhRUy8rQXpS?=
 =?utf-8?B?d05NTW9YMEQ0dVg3d3RMdjdKM3JCNHZJU0I0TllHbHJyTUhjUkExZU4vemQw?=
 =?utf-8?B?OXllNUVFQWExKzNrWklkTXhzYWxrNGFaNUVPaEVSY1VVWGl1NW9JMmZuVno1?=
 =?utf-8?B?WWtpTFVob25KTFZ0eTNuV1JMcDQ1aHJNTEJxbnVhTDZpOGp4cXVoazJtUGJY?=
 =?utf-8?B?QUM4TTh0VStkanRiVkNZSmVpeUo2MHFIYTk0Mm40NUQvV285VHA1Y0t2UGxp?=
 =?utf-8?B?WjRuT29KODF0RkoxQThQS2JLbXVOM2tNdUpUYyttT2xXQ0dmV3JleDc3aFIz?=
 =?utf-8?B?bTdlL1BmZGFiOWtzTEZCYUpaakZaaTJVc3pGVkx2bkdHNWpJbXlTbHlxTDVB?=
 =?utf-8?B?cTBYL2pDbjViOEdKcm9HaGRRNWFVTmhqYnkxZEh2cHREbmM3WGljZmkzc1NG?=
 =?utf-8?B?RVhvZDNrcmhwYlB6Zlp6WW0yZ2ZYZ0h1bExuYlRhRWd2Y0tNQTVuQlgrQVZJ?=
 =?utf-8?B?eElwM2R2OVQ4bGd4SHU4UkVyRXRiaEdYTndkUTJKaENkVVo2WGc3UEJ2VVBl?=
 =?utf-8?B?UDE1M3VJWXQvZUczbERweExLMmFYYlVIWVhuSzBkTkQ5OWo5bDhZeEZFRGY3?=
 =?utf-8?B?SHZWaVIyZ0cwUVd6QzY0YWhMbnNYd3hnM0NDanNoUG5oSHZQSThLVWFkbVpD?=
 =?utf-8?B?TjdQS0pySGtsa2VkUFNGSGhURU9EMmVYN0FFQTJBLzlJenlNYjdHVk9jckVB?=
 =?utf-8?B?cVlzcWVncnQzOEpxZlE1M2xxWk5iODBDWGJXM2YzZlhJWEwybUlwdUlIbFBa?=
 =?utf-8?B?VXFYUXc5SUxYUHAxMWt0aUVpQ0xINmhObHovMFVHNWtTZGMxR0J6aVlpYllF?=
 =?utf-8?B?ckFwZ01STmxFVDQzOU5ZYmNiYWZ6MFV1UzF4NWV6SlN5ek52aDlKaW1Qb0hn?=
 =?utf-8?B?VnJLMFc3bGoxQkk3RGFLVzFrcjlJNjZmdVVPbUwyaVBZY0J3ekY2WVBpSGNN?=
 =?utf-8?B?UHJ2NW9sMzNETm5WOC9DSTlzeG9lZVN0OHVJUFFWbEdlWTFQb2tpeFAzTWxa?=
 =?utf-8?B?OVFmbmZmazNmRHFnRFJCeUl3OTdLNUorMW5TUWxid2ZEcFl0UUoyTGVOM2FQ?=
 =?utf-8?B?MjZsOE1uZnJ5WWtHcVRSWEQ5T0VuWFdtWXY3bTcwTlBCdlZBVHFvam1acmxi?=
 =?utf-8?B?SFBrY2hIUTNiQTZXQ0NKdGNQU05IUzdOOGV0WXc0TjRncG42alJ5ZCs4aE5s?=
 =?utf-8?B?S1d6dktIcEdiUUhUaEFMNVd3WUtiYUc2dVBVZnNORS96WU9OajFCTkRFemJw?=
 =?utf-8?Q?ITby4ePSZvxv+7rBgy0/aMwFQ?=
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: kvh.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB7167.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4356497c-4273-4da5-2675-08db77234ed4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 15:29:33.2627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 45c05af7-f354-4404-835d-8de3cef70ba7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99E7sTSvNSZUt6JSuGWCjHbL4kvgeI9Ba7V+JJ0LXG7kEy6lQdX7mQFoc4uZdWArcx9cxICmlI2KJfcDerJdRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB8186
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kvh.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <C8E4B316D1E5664B96C9DF8E7F671085@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64

TWFydGluLA0KIA0KWW91IG1lbnRpb25lZCBhIHBvc3NpYmxlIHBvd2VyIGxvc3MgaW4geW91ciB0
ZXN0aW5nLiBJZiBpd2QgaXMgbm90IHBlcmZvcm1pbmcgYW4gZnN5bmMoKSBhZnRlciBqb2luaW5n
IHRoZSBuZXR3b3JrIGFuZCB3cml0aW5nIHRoZSBTU0lEIGNvbmZpZ3VyYXRpb24gZmlsZSwgdGhl
biB0aGVyZSBpcyBhIHNtYWxsIHdpbmRvdyBvZiB0aW1lIChiZXR3ZWVuIHdoZW4gdGhlIGZpbGUg
aXMgd3JpdHRlbiBhbmQgd2hlbiB0aGUgZmlsZXN5c3RlbSBpcyBuZXh0IHN5bmNlZCkgd2hlbiB0
aGUgZmlsZSBjYW4gZWFzaWx5IGdvIG1pc3NpbmcgaWYgcG93ZXIgaXMgbG9zdC4NCiANCklmIHRo
ZSBmaWxlIGlzIG5ld2x5IGNyZWF0ZWQsIHRoZW4gaXQgY291bGQgZGlzYXBwZWFyIGVudGlyZWx5
IG9uIHBvd2VyIGxvc3MuIElmIHRoZSBmaWxlcyBjb250ZW50cyB3ZXJlIG92ZXJ3cml0dGVuLCB0
aGVuIGl0IG1pZ2h0IHJldmVydCB0byB0aGUgb2xkIGNvbnRlbnRzIG9uIHBvd2VyIGxvc3MuDQog
DQpQZXJoYXBzIHRoaXMgZXhwbGFpbnMgeW91ciBpc3N1ZS4gIEkgY2Fu4oCZdCB0ZWxsIHlvdSBo
b3cgbWFueSB0aW1lcyBJIGhhdmUgYmVlbiBiaXR0ZW4gYnkgdGhpcyBpbiBlbWJlZGRlZCBMaW51
eCBkZXNpZ25zLg0KIA0KR29vZCBsdWNrLA0KSmFtZXMNCg0K77u/T24gNi8yNy8yMywgNDowNyBB
TSwgIk1hcnRpbiBQZXR6b2xkIiA8bWFydGluLnBldHpvbGRAdGF2bGEuZGUgPG1haWx0bzptYXJ0
aW4ucGV0em9sZEB0YXZsYS5kZT4+IHdyb3RlOg0KDQoNClNvbWUgdGltZSBiZWZvcmUgdGhpcyBp
c3N1ZSwgd2UNCnB1bGxlZCB0aGUgcG93ZXIgb2Ygb3VyIHJvdXRlciBhbmQgdGhlIG5ldHdvcmsg
d2FzIG9mIGNvdXJzZSBnb25lIC0gYmFjaw0KYSBmZXcgbWludXRlcyBsYXRlci4gSSBoYXZlIG5v
IGlkZWEgaWYgdGhpcyBjb3VsZCBiZSByZWxhdGVkIG9yIGp1c3QNCmNvLWluY2lkZW5jZS4NCg0K
DQoNCg==

