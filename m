Received: from us-smtp-delivery-145.mimecast.com (us-smtp-delivery-145.mimecast.com [170.10.133.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61888441A
	for <iwd@lists.linux.dev>; Thu, 21 Jul 2022 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvh.com; s=mimecast20180413;
	t=1658410762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fUZx+lTexwYOcj70J/cRcuko9qPN5iZaubZA+fkMvZs=;
	b=DIljGI7DtdB6WGA1la+dOo5gvuT3wU6kRbTkOeP+Im4nP8ot6z5q88JZhwd2P+L5XbYU+F
	yzPW7rDWkDGN+73TqybseBk9Ce/5HzWl/p7vA3UJ6jQEuGqGVZdnOcJyTJfBTRbSslydh4
	emMfXh9o4yVqIGNNW1os3575y+R9xVo=
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-ZydPlozVN76jYp4TtBeWAw-1; Thu, 21 Jul 2022 09:39:15 -0400
X-MC-Unique: ZydPlozVN76jYp4TtBeWAw-1
Received: from MN2PR07MB7167.namprd07.prod.outlook.com (2603:10b6:208:1a6::10)
 by CH2PR07MB7286.namprd07.prod.outlook.com (2603:10b6:610:a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Thu, 21 Jul
 2022 13:39:12 +0000
Received: from MN2PR07MB7167.namprd07.prod.outlook.com
 ([fe80::801a:400a:2291:56f3]) by MN2PR07MB7167.namprd07.prod.outlook.com
 ([fe80::801a:400a:2291:56f3%3]) with mapi id 15.20.5438.024; Thu, 21 Jul 2022
 13:39:12 +0000
Message-ID: <f2c732a0-fb4d-c37b-b4c5-99006c1a9245@kvh.com>
Date: Thu, 21 Jul 2022 09:39:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] tools: Add simple utility to generate the PSK
To: KeithG <ys3al35l@gmail.com>, Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
References: <20220721021314.14066-1-denkenz@gmail.com>
 <b240184c-d90a-db5f-e7f0-ff2c5b432e6b@kvh.com>
 <daab977b-fdf1-274b-0ebd-45d71b090500@gmail.com>
 <CAG17S_OysUm+YSDobUTLnY3k7mU86WMoVRY7D3iz7dFMBYYopg@mail.gmail.com>
From: James Tavares <jtavares@kvh.com>
In-Reply-To: <CAG17S_OysUm+YSDobUTLnY3k7mU86WMoVRY7D3iz7dFMBYYopg@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:208:256::24) To MN2PR07MB7167.namprd07.prod.outlook.com
 (2603:10b6:208:1a6::10)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa432213-b393-4a67-104f-08da6b1e65a8
X-MS-TrafficTypeDiagnostic: CH2PR07MB7286:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: CpvDZK1aYTqdTuxCS1RekMGSYH1wJTrtkMaXNeg9+39CuA/C7ROVZNPQvGA0iK6F3Xiy7Y4TtTZOkjekPXmLzVdL8T+5zRCA95j7cPvSAaFCBRB6r8m6PZrf88Y6V3tomvDBhrtKoikv3IZivQeNtjGQCbb7BVx+RL3qoWSSoybBF6BjCkC/3n598oI9OK18ByKtAd5Ubq+EJsXvOZUlq0oHvTN/FQ8ayd+b0dqW4JSOjwzgEsJeIpWMlv8bqzo3fiQICIQCRiFAmhd3kR6Vk+yASZ0C4fUF9jW8GLQLjbIgiNcQP16B4Nm9QKjcZIn1xoYE/oRUjSVj7a34JCRCacuwFkqGQmLZ5GLUDK7JI3LcdyZhp7wd29tH3zVWcAYNwWiv08Dc1ojdTRVyQlcKz0/K6r7/rb8XB1LhMAl3s4BayyvilnnwZiWEBY4FfwrRkSoLZj8qbNL6u/sHi686uCFLjXaFcb4CBGhQlCsh63v3kIQxgKWfUlvoRCdC1nQE3h0HwNT7m+Vdax9OwbgTRdRnsyOD5rrjVI3/9xcj2L+A9oNAYBPR34RZeRmMi/1Gc+VmALklf/WCnfB1VFzPk7uXRd9DqcPSFNIj6FJ1DGeecQDl/H5QNR+YjSsokVwh9fMCkWNC6uku/wVgfIrG2wYetiNBwxorDHUKv1hJH3b8amFJLIqZGufpjhgcmYfhF5GaYFb+/uyCkiLvVXbflR0cwKoL+PcF4EY8EJdtCGlecYJt6Ns/ieQuGMxEl7BHg3+10XT/RW9/rLHpt12NOYwAd3NUasirNaAPLjvZzx4opYqOnhzX3+HEK+YwKNGzNmgBb//gNBd78X597zXdDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB7167.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39850400004)(366004)(346002)(396003)(8936002)(4326008)(66946007)(110136005)(2906002)(5660300002)(66556008)(316002)(8676002)(66476007)(31686004)(6512007)(53546011)(86362001)(31696002)(4744005)(41300700001)(36756003)(38100700002)(6506007)(6486002)(2616005)(478600001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE9JMzVQS0RTcVZGRS9BZ2VQWnpHajNWY0NibVEzSFlMenFwR1NqR3dyT1hJ?=
 =?utf-8?B?SmxRN0lFUE03ODl3T1p3T2kyR2hBaUJ0ZVE0SGRHcGF2MDh6L1dKT2N2TGdQ?=
 =?utf-8?B?enVCLzV3OC81ZE12eDZacCs0ZjZUZ1QzRjVjUE1YL2xZWll0MWEzVmNjMEtQ?=
 =?utf-8?B?MC9hYVpsZ2VieUhCTjZ4TlZ6SkFXcTRZQVBzbVFXSTVPYVhZblE2c3dHN0V1?=
 =?utf-8?B?SlJkSFc0Zk5RRG83UkptM3hmS1ZiTllPa0EyaUFqQnRyUmlmeGdqTHZPMXdz?=
 =?utf-8?B?ZmVGOTkvdjdsdGZsZHF6VkE0YmszSk1iTm05cXhLRzV4bkVaejBhbklSZXV2?=
 =?utf-8?B?SU05OFk3azJFbFhDTFkvOVFTNHNlRGtVeEVLbnBkazFXcHBVaWRKRE9sN1BC?=
 =?utf-8?B?MUwvMVo4a0RSR0JmVTJjKzNQZ2lXOGYvOWtNK3EyK1pWOXh1NzJUSE5MRGd0?=
 =?utf-8?B?TzBKOVliUjBqMGZacXNKa2N5eEcxc05MN1A2WXZQQU56MnJFM3YxZGxwTlJw?=
 =?utf-8?B?NnorQi84NjJXM2NpMzgwWHZ3MmwyOGlmeGVoY0czVmxwSE9jZHVHVEprZ29F?=
 =?utf-8?B?MVo4M1Y2aXZXbHRsaHdodXl3K2RkNTlQSkFHeFZWb0ppS2ozOFRwanpjc0Q0?=
 =?utf-8?B?TWdpOXNWTC9PZDlTNDFuOUNqQisrOWlITFBWOHgwOXhlemNwMkFqTndaQTBz?=
 =?utf-8?B?VEtQb3BrVVMvdkhXdk00Tmw3djV3a0tqUFhrdDJBN2VzZWE1b2pOdm1NWGZi?=
 =?utf-8?B?SVllUUFJK3J3K0lKOTBIcGtZcHRkTjB3VEVQSUtRQmlQMEZ4OUNQdmtIS3hP?=
 =?utf-8?B?TE1Cb1prblMxYmVoT09BdS91ZUlCYldDSVFKR05UY2ZlWmNrS3YzRm1OZVhN?=
 =?utf-8?B?amRab1p2ZjlObURGNVRLcDRPUjA5NTdkbzVoM0VzVVMxVVByLzFSRlQ2UWtE?=
 =?utf-8?B?eC9zU2QzSjQ2cjFpWkZ0clpSK0IyVGZQNTRVUk01MlpLdTJXMlZacm5QOUhM?=
 =?utf-8?B?UjVTN0RuZFpGaTlZVUxsOHpkS09kZWYwaWlCbWp5RGJTQVJOUWJkTkhQVjdz?=
 =?utf-8?B?dU01elI5eHdpMWRHcGIwdS9VN3ZwSDB0U0d6czF2V2YyWmpMQ2dNWUVFZzRV?=
 =?utf-8?B?UENkYmpDTjFzZ2RWM1FUL2hHdi9YZ3pFSWhOdm5YejZ3NC9oaXlnaXFnTWx1?=
 =?utf-8?B?cWk4aEI5TkVwVmQrd08yVkxWdG5zWENDaUV4cmVaeU1EWkdYVjFPbC9nRHA5?=
 =?utf-8?B?eWRVRlg1Q21YZEtDY0NQQnpvUHoya2YreGh1elRwZVhGcFB2TW5uenYyYzd1?=
 =?utf-8?B?QUREbndxZlF4NVQzMFo2ZU5oVUlJSEdqaVRrb0VMR1k0QWRGV3kyeW8wM3Fl?=
 =?utf-8?B?Yll5ZFkzbmNlNjFDZXgwenRrMm0zRFpwbXhDR0JDV2xVa1plazBqaEg2K1pM?=
 =?utf-8?B?NFJ1YVFCT21RZ3VSQXdNSjgvcTQySHlsajJIbDBhcEl4K2pPN2p6dGR6NVJs?=
 =?utf-8?B?bnZZRzF1eHZWdXpUeW9qdXoyQ2RqSUNiZXlQamlOMllEY04wUlE2OTJVSzVt?=
 =?utf-8?B?ZTJZREYwODFoSGEvYTRCZnRTY09MSGNNRXFVN3pXTkFiOUxFcG9rTVVQTW5m?=
 =?utf-8?B?M1N3RnRtRmdwd1M1NlF3YSsxdjNrSGJqcXJTbkVHUFJYWjFPUUZaZGJYc3l1?=
 =?utf-8?B?NFdoQVNRM1hUcWIwbkVvK2Q3TUwvaFV0RWVQVSt1K2ZOQmU3Y3hZZENMY0M1?=
 =?utf-8?B?cGhWUGhUR01LcjlEYS9GUVNqek10ajNwNWlsMVNld2xId1VYbnJHYnUxbWNB?=
 =?utf-8?B?NTVrQzFOb3Fhcjh3MjBiUkZwS3hmbXIwRCsyMnpqeHRiR012VmJUUkd2R2hJ?=
 =?utf-8?B?YWExalJBZmloYzQzMGFHT2pvcDBpU1Y1L2FRNjFYWnQ2cVZqRkVVVCtjRTdL?=
 =?utf-8?B?ZkdJSit4RExKV1d2T0I0S1hab3JWT25BWVVvL0s4K0k4N0I0MHVYR0k5akE2?=
 =?utf-8?B?OW45SHI3dkhuM0MxNHl2c3dDYnFod0NyRGdKWXJPYncxR2lhZ2JiT2hFd1Fr?=
 =?utf-8?B?RjNIK1JCZmFuaWM4dERlN0lNb1NOZXdNanNqeFdSdGNRMERpcDNVYkV6Tmph?=
 =?utf-8?B?RUxkL2c3VWdZemgyWkF3TzNoaFdJUmJWNnA3Y1FzUHZWcHMvdGo0SkxBTExu?=
 =?utf-8?Q?O5nKDd6qTSGe/G95G+ftNmWn/tRFw8LKSmxWBRHO8F1X?=
X-OriginatorOrg: kvh.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa432213-b393-4a67-104f-08da6b1e65a8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB7167.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 13:39:12.6000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 45c05af7-f354-4404-835d-8de3cef70ba7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAu3zqeiKNu82lb/BwiC+Kt0Xd6+xX/7wWaGBI4brpxOeQLdRNOEoWKNaxlyus/LLn2WQEr6tXJvgIic1AIjmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB7286
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA45A45 smtp.mailfrom=jtavares@kvh.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kvh.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7/21/22 9:26 AM, KeithG wrote:

> Interesting... Which arm distribution are you using?

NXP (aka "Freescale") Linux kernel (based on kernel 5.10.9)
Variscite Linux layer
Yocto Gatesgarth

Hardware is a DART-MX8M-PLUS SOM from Variscite with an NXP i.MX 8M Plus
processor.


Does anyone have a suggestion for a libkcapi-based test that help
isolate kernel issue vs. iwd issue?

I was looking at the kcapi-dgst tool but honest have gotten a little
tripped up with it.

Regard,s
James

