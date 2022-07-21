Received: from us-smtp-delivery-145.mimecast.com (us-smtp-delivery-145.mimecast.com [170.10.133.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1C323A0
	for <iwd@lists.linux.dev>; Thu, 21 Jul 2022 04:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvh.com; s=mimecast20180413;
	t=1658376634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RmbbwwXzu1NazlQdD9j6t5tiGbAfC4kE+Svwv2uU7Wc=;
	b=WIya3htvl31tt0oZPBB4e4NsNzBTjAsL5Tb+pfQD5WXxqL99TTFMpRSLVzqAk8Z/9QiMqN
	iH0/Opyf+DYNVbNxbxBBYPvz+q8NiabcmQCUHg/DSKb9iwY7U/gIW9rb6LzIVD7u+rA+Xk
	43XHNtJ5zmv2x7tyx08uTlB1zJv3Gqo=
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-8DXstC77OMS1dmnhrk5RhQ-1; Thu, 21 Jul 2022 00:10:26 -0400
X-MC-Unique: 8DXstC77OMS1dmnhrk5RhQ-1
Received: from MN2PR07MB7167.namprd07.prod.outlook.com (2603:10b6:208:1a6::10)
 by BL0PR07MB5251.namprd07.prod.outlook.com (2603:10b6:208:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 04:10:22 +0000
Received: from MN2PR07MB7167.namprd07.prod.outlook.com
 ([fe80::801a:400a:2291:56f3]) by MN2PR07MB7167.namprd07.prod.outlook.com
 ([fe80::801a:400a:2291:56f3%3]) with mapi id 15.20.5438.024; Thu, 21 Jul 2022
 04:10:22 +0000
Message-ID: <b240184c-d90a-db5f-e7f0-ff2c5b432e6b@kvh.com>
Date: Thu, 21 Jul 2022 00:05:20 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] tools: Add simple utility to generate the PSK
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20220721021314.14066-1-denkenz@gmail.com>
From: James Tavares <jtavares@kvh.com>
In-Reply-To: <20220721021314.14066-1-denkenz@gmail.com>
X-ClientProxiedBy: BL1PR13CA0240.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::35) To MN2PR07MB7167.namprd07.prod.outlook.com
 (2603:10b6:208:1a6::10)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecd0c7ae-de51-456d-1ee1-08da6aceee47
X-MS-TrafficTypeDiagnostic: BL0PR07MB5251:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: /GdUJs941hcCXHLCoXz/LLzmFvMgw0az1x9dOPHuLN+tt8S8c5wTFGV//yd72ZEtRsgn1JLtUeTVD4r+9VC1ZN8CnBqvHgbnaWjcFlfvkwue4sb4QvWpcVYOsYfna+3M8ABc8hYqWu4GIcqIF5fwh9pb/yMZzdme4fG4kFKvxc9dQLolsma1l65/UD1nd/kpbRmOr922fyym1m3wAjSYF4mOQNKQaL6uPprLuYwoxEhSmc5XjrNWNrAJ1fyxx6xk+hRSfF0m3FJdiuxIX2QFK6fRpTR5bMMsjLVrJwBlDL7Scecg2CSl2tq1/2I9G8KCtFYVSfsIvHTk/cso5rR4f5BqFL8T6TbbmU+47P848Agukw5xLUzQzJDL2uqQGFXNz7ysAPMjjdrEKFSvpiMfC8A1Juy3At0jFPQSoYXp5adCuJ8s8N0y6DN2844pkAuMEuhF0ed3RRQOHjHzYwk1Q9DnyscDFlMwhZI76p/YdRsN7z5FTQJmD6l1tdjAuEHS2ehrrPyj/aA1Kz5jRXLVSmWZ5AMaiZQ/5Gf7yDm30Smbox0ROXowM4fGbacdMEsx6NeYrFCI4fdcZIS5Y6LY4rXoRoBi3lzMsJN/g+86NPwfUSm0ZlQErusPc1SaleavxARysSksXaSmVlg9xoPXNfKccxyaxUfj3J9ypHgUDDEuwWohrEbDEZHR1wXhiR/LdasMGU6tp40YGy1kk3iGiXraXboRe6sw7L1EjfRpzy7eKp9MuDrRFFTTLG5AYDWo3ggX5+owDDYOaD/TdUz2PNMBI+hd1fWRbZSIiQ8HQCg1dYo7ggeRBQnU+CP6UhoYZYEh991UqEDbWa9QAyFPXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB7167.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(346002)(136003)(39850400004)(316002)(41300700001)(6486002)(478600001)(38100700002)(83380400001)(2616005)(53546011)(6506007)(26005)(6512007)(186003)(2906002)(31686004)(5660300002)(8936002)(36756003)(8676002)(66476007)(66556008)(31696002)(66946007)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFl5d3hXZW9UZTZ3M2VocnQ5MXVGWmpNaUNDVTBRcWdFejRzRDR2akYwc1RL?=
 =?utf-8?B?b1V6bDRqQWVMOFV2b0FWVks3ejEwUHFNeXZFa0dJdlFHT2FZWEovMWxWNFJl?=
 =?utf-8?B?ajJxdFMxS01pOTZkc3JOS0dhQXFGaFhMUVJLTzdwYW84OXVWa3dQMWhVVGxw?=
 =?utf-8?B?dXpXSWVZZDZ0U3VvQk80ejFtY0dEdXpCUHFBeXVTbGdJUFdRUUdtcXBGWGtB?=
 =?utf-8?B?VXJFQlZJNm93czQvNUpGZ0hmMlp6Wk5pMVY0UjdxbVhLNm12SFdrTlJLN2dG?=
 =?utf-8?B?aGUyVjFMNFUrOWRsTzlWc00rS0V4YVJmUW5uMGhwd2gxRlVQcWxxVmJuUDlz?=
 =?utf-8?B?TS9tMnNTNEFYWE1maWFOYzBZQlY1MGZKVFhrZSt0OTRlRHJtK0N0SFBzY1Fy?=
 =?utf-8?B?YWMwUkZwTzNnYkZJKzRnVjNyM1pwVVpNYXBtSUNYNUVGVFR2NmVQdVZXRGRG?=
 =?utf-8?B?Ty92VHJKSlhpRWtuaHVJekx5eFh6YlZmUU1CMUNacHcyMUhZZlA2MlYxV1R3?=
 =?utf-8?B?UUFyVjVvcG1vbHZKSGtXUHJSK0VHekREZnorSmI1eWhTdWN5WWg3c3VMaVhJ?=
 =?utf-8?B?QUZXSE5BQzlLbUh3RHYxODg3bDQvU2hiaVJjbndHSy9HZUhwYXdYSkdYUXVi?=
 =?utf-8?B?cFprdUV5QXFSMWppSktiM2dPa2NXS3AvaEluT2YvSkFvNnYxZXlLV1dhSGpR?=
 =?utf-8?B?L2VZZHpiT3dkUXhPQ2xMM0xCUStnYTE4a0p1bDhGRmNDckdmUWJxL3pSdVky?=
 =?utf-8?B?aFBNd0hqL3YxSW8vYTVsWnAvVzNJdHhoRkt5a295ZUtLamlVOTRVKzFqY1NY?=
 =?utf-8?B?MWYwUy9kZXpzR3hQK2RkNWRTMmtRZnFZSXdPOHpvRmhUOW5PQWtOWit2SnRT?=
 =?utf-8?B?MktWWGgrUlRwMFRZSzlxMmdldkpPaUdMNEJTL3RTSndQZTBnOHBVQ0U0UHlz?=
 =?utf-8?B?YnM2OFcyTFRNT0pjVFFKNWhQTk10NE4ranhSTThmei8rbFVvUHdBeGh5S2ZY?=
 =?utf-8?B?alZNMWkwQ0dmYlhpY0RLRk5PZkcwUkpEc1c3Z2I3YmxydDNKdExpcHdrTVlV?=
 =?utf-8?B?N0VibFJvb3grMW56bW4vWkIweDMxYXlNRDVETVFNVm5oYjltaFdaTm9TRFBx?=
 =?utf-8?B?VDhUcmdlaExZUmxmVml5L2I5ajRaSk1BeTR6TVlqYVpYTjUva1p2dlo0bmNa?=
 =?utf-8?B?M1Z3OUlXd0ZMWUwvV0tQUWh4YStkMi9xMjhDejBqMmFBSHlyMkkzU2traVln?=
 =?utf-8?B?clV1TmliSi9xcmFFOU9DUlVuL00vSmpYdFczNG55c21uUUY5ZUllNmZLSTR2?=
 =?utf-8?B?a2ZlRzdVcGRwOWZsMHN5S0lYMEx4Mng1NGRiQ0FnWFlZdWVuTVJ1VERmdXg3?=
 =?utf-8?B?NHdqMUs4Z3FKNE5iQUQwZ1ZzYis3QlMvY3RSRm9uVk9QUm8rN1poZzZJaFlR?=
 =?utf-8?B?YVU1UGVUbGJyMkh5L1pNSnMvR0hQbkE1M1o1UEJ3aTRzZU5QWVp5REZISEpk?=
 =?utf-8?B?VlAwanJiVjlVdXc4Y3hIWXoxb25CUWVkUUNGTi9TSGhoa2V2TEhyR3R6Unh3?=
 =?utf-8?B?dlI3WkZxZk44VG5rUm9JTEYrZHl2ZTlNUVluNFVKOXNyQ3FXcTRqTlAzbHNJ?=
 =?utf-8?B?NXphdlB2ejUxMGpVR2NWb3lPRnFtdlpxeGMyVElsOUdyYXc1TUlOYUpxVUhi?=
 =?utf-8?B?Zjg4cEYvZ1VuZDQ0aGl4NU1DOHdLakNQWkhYZS94cFZXbVI0c0JVdHNQYmhB?=
 =?utf-8?B?bFVSWlA1Y2E2YTRjTCtDd2FudUcza2EydHc0UGR4VTA0TVBUZ05hRVFMR2VU?=
 =?utf-8?B?SnRMVDFRNitHU2gwOU0xVE9CTHhoNVFmVk04U1UwUG05SEdZOGhxbDlUcjVZ?=
 =?utf-8?B?MzkwOElkOURBcnB0Y1hTY1NlMmV0NGx3TzlsajRua0x6NllrYXVjSjFWY0FQ?=
 =?utf-8?B?K1Jpa3V2d2FBMFNEcy9ZYWtKU2RqOXBOWFBMblBvUU5wNHd6b01xNlVQcmpj?=
 =?utf-8?B?UGlaV3ZHUForWXpoQjV5N3VhNmVaZ1ZNdEwwSCtrekFVSEpYRjFaWU9Samlt?=
 =?utf-8?B?blNnWUJnTklxajVtRzc0aDhFUWdxaHJORll6WnpJa1p5Rkh0am5yZnNsWkt3?=
 =?utf-8?Q?YlKc3uJ3XotaWTNoq+kNE6tqY?=
X-OriginatorOrg: kvh.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd0c7ae-de51-456d-1ee1-08da6aceee47
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB7167.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 04:10:22.1366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 45c05af7-f354-4404-835d-8de3cef70ba7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Iig4VZvLXbsd7XjbLhq/CTt1gG07AgznK6tJCMcr4wLUau+GYjL82xtvX5IlA33dyap9iIIKnPIVBGPSoWZ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5251
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA45A45 smtp.mailfrom=jtavares@kvh.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kvh.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7/20/22 10:13 PM, Denis Kenzior wrote:

> This utility is the equivalent to wpa_passphrase and produces a PSK as
> would be generated by iwd.

Awesome! Thank you. With this, I was able able to confirm that there is
indeed a problem at the 40/41 character mark. Passphrases of 40
characters reliably produce the same pre-shared keys as wpa_passphrase.
Passphrases of characters 41 and greater produce random pre-shared keys
(although they sometimes repeat, as-if there was an uninitialized
memory, alignment or aliasing issue?).

My other observation is that iwd-psk (@ 0.450 seconds) is considerably
slower than wpa_passphrase (@ 0.017 seconds) at generating a pre-shared key=
.


Here is an example at 40 characters:

- iwd-pk:

$ i=3D10; while [ $i -gt 0 ]; do ./iwd-psk ShortWiFiName
0000000000111111111122222222223333333333; ((i--)); done
PreSharedKey=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876ef=
e7cc
PreSharedKey=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876ef=
e7cc
PreSharedKey=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876ef=
e7cc
PreSharedKey=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876ef=
e7cc
PreSharedKey=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876ef=
e7cc
PreSharedKey=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876ef=
e7cc
PreSharedKey=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876ef=
e7cc
PreSharedKey=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876ef=
e7cc
PreSharedKey=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876ef=
e7cc
PreSharedKey=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876ef=
e7cc

- wpa_passphrase:

$ i=3D10; while [ $i -gt 0 ]; do wpa_passphrase ShortWiFiName
0000000000111111111122222222223333333333 | grep psk | grep -v \#;
((i--)); done
psk=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876efe7cc
psk=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876efe7cc
psk=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876efe7cc
psk=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876efe7cc
psk=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876efe7cc
psk=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876efe7cc
psk=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876efe7cc
psk=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876efe7cc
psk=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876efe7cc
psk=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876efe7cc


Here is an example at 41 characters:

- iwd-psk:

$ i=3D10; while [ $i -gt 0 ]; do ./iwd-psk ShortWiFiName
00000000001111111111222222222233333333334; ((i--)); done
PreSharedKey=3Dd11a9661447c2cbf945148b305f0cf6caccac072158b8be7a0ce3a8dc28c=
d5c4
PreSharedKey=3Df5c7f45c4f8ca1ece53c0118513893b50ddbd05153d4f3bc7295cd5acbfb=
12e3
PreSharedKey=3Da7edff123b9710da3d36f18a700fc3b1e214fa5f0ad4c2681f629a0248eb=
e5da
PreSharedKey=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876ef=
e7cc
PreSharedKey=3Daeff2dbc47d74eacd4a27e5b7e4bb6dccb7376d013d6eebfbc12b75a5632=
aa22
PreSharedKey=3D6fa3c9218bf6abd053ed640ad90f301d55732d1dc9562c637b40ec4e7849=
6e9a
PreSharedKey=3D934e0f09e85b1efabd89df31a9c24faf916049b7fcf6c9ce18cbaded1cb1=
ad49
PreSharedKey=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876ef=
e7cc
PreSharedKey=3D9523012d845c07633331ca915761e6610d9cc23194b8704863a2ffd848ac=
72d1
PreSharedKey=3Df9408e131af312a8a49128f802b8b755a50aa352a903307bbf5671d876ef=
e7cc

- wpa_passphrase:

$ i=3D10; while [ $i -gt 0 ]; do wpa_passphrase ShortWiFiName
00000000001111111111222222222233333333334 | grep psk | grep -v \#;
((i--)); done
=09psk=3D64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
psk=3D64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
psk=3D64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
psk=3D64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
psk=3D64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
psk=3D64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
psk=3D64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
psk=3D64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
psk=3D64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
psk=3D64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2

