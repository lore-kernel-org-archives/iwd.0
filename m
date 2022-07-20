Received: from us-smtp-delivery-145.mimecast.com (us-smtp-delivery-145.mimecast.com [170.10.133.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6617B
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 19:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvh.com; s=mimecast20180413;
	t=1658344405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSrmVZED9gaTul9xTUzsK6o+AIvdlQT2nQoQLOwNNpI=;
	b=WxXm4kFeBii+miOXQt0O5lTUDXW4UEZZLTbWhxkaQGF5a51BZexCrbdo1eZCE0DRh4h370
	gXwM7n2tPMkizC78kn1KYIRqtHwlsI1KVIczjgB8UNSkq4mQWvKyFsFNV4UnimbhkdghQn
	+fKwF4SpMPuTwBY00HVe3qWg7Of5OX0=
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-aBxY9uNEN8S6m0cdTHinqw-1; Wed, 20 Jul 2022 15:13:24 -0400
X-MC-Unique: aBxY9uNEN8S6m0cdTHinqw-1
Received: from MN2PR07MB7167.namprd07.prod.outlook.com (2603:10b6:208:1a6::10)
 by SA0PR07MB7740.namprd07.prod.outlook.com (2603:10b6:806:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 20 Jul
 2022 19:13:21 +0000
Received: from MN2PR07MB7167.namprd07.prod.outlook.com
 ([fe80::801a:400a:2291:56f3]) by MN2PR07MB7167.namprd07.prod.outlook.com
 ([fe80::801a:400a:2291:56f3%3]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 19:13:21 +0000
Message-ID: <caccaddd-4d7e-11e3-5aca-3d7b6c8e40da@kvh.com>
Date: Wed, 20 Jul 2022 15:13:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: iwd fails to connect when passphrase > 40 characters on 5Ghz;
 times out on 2.4Ghz
To: Denis Kenzior <denkenz@gmail.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <E34D86E6-F357-4233-A698-C0EAC029F431@kvh.com>
 <e74694b1-f62c-f430-6c2f-32d275c61763@gmail.com>
From: James Tavares <jtavares@kvh.com>
In-Reply-To: <e74694b1-f62c-f430-6c2f-32d275c61763@gmail.com>
X-ClientProxiedBy: BL1PR13CA0284.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::19) To MN2PR07MB7167.namprd07.prod.outlook.com
 (2603:10b6:208:1a6::10)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73a0f3ac-e36b-4feb-9f0e-08da6a83e93d
X-MS-TrafficTypeDiagnostic: SA0PR07MB7740:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: wXU/IjMFiksqjQszIOsUkEhYAcuU7a2hsreLoxph1RbmA+DdifyI5/8zIOrbNPUEeTvQKdZ52Zet4xbRba1yBOkGmlpApi0iSjZ/Rth1bYPFtW9DGh0lfrhnfsTD45dUoLGcEtycJT9Uog3sUt1ydfytUx8d5zKyl1I0g3K6YBFjxt7YZ+7AiZS8zyxwuBUf5ohN+a+zuGm1LDABxw+gVg8YOtOQwkWQWlsknrkhZ1s72tWMnWOkP4Wfr9eDUnW+MysfMHpAqumUXs6NJ2Z4wI0wpzhX2t80uH9IpDZwDJT48E6wn7MkWnoHGHak+yu533vHa8woZ1oL6J19AWgY3OTDRBatwRWtV4JKgvYO43NSrW6XKR9tivjG8NS8RZHQh5b0h13q6xm3Kd0fdQ95tRKeRiLhWVGpppxQhtBRnPaDjwOftZ8meevLUTHY/4ZhL7BmABzJFwqasLosAdqsboW9eOiQYfvmTyT+nUkD91EGRtgICBP07ZjIO9ylD0z+PcZVI6edZc0JJfle/YKSVX9JN9LWJmYhYbi6eTkSS86k3dsypCPDuJfW2uYvRBfiMhihB0MiAmHRCpipSBk8uIpep32CeVdUiM3Ww6DLWxcmQ+8kmCJpU2kcAvzzo4+/qQpqEOylKLk2bOy4rTPJ0vKFQG6WuXeahAEy/efFPjKWQxRiZhzgt9Fq8qpEgY3odsyMegtv1jTM/bluKLaevPBS/1cbqklP+O/kwOAz5YMivQVg2zv9e3zp4oMFUM7JKEo8eAb0gD31nNVF9vjqBZst/kPrIVUBoQP06H/01o7lHHObkb+rIwcCbMkDwxJj3SSdaqwGVKVyackfeuhO+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB7167.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(376002)(346002)(39850400004)(66476007)(5660300002)(36756003)(8936002)(31686004)(31696002)(2616005)(110136005)(478600001)(41300700001)(83380400001)(316002)(186003)(6486002)(38100700002)(66574015)(6506007)(2906002)(26005)(86362001)(6512007)(66556008)(66946007)(8676002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l3AK6k2X4LMbJbopEofEd/Tl23XLu7xG8E0x6IIlV7zce6DcWl9buz5DTGpt?=
 =?us-ascii?Q?LYExeqraNA6lbvTFyIG5G8JZtdFzbjrJqtk48G/3yeFHvjT4us7AFRmztZX5?=
 =?us-ascii?Q?rMS4aoUHMOwQCRswRtc76fhR142WT1x2hyWdLryUNmX19cLUOAl56sW7sxvV?=
 =?us-ascii?Q?rGUQY6kqmmbFiCY8FZGQP1bqc4k2omRgNuxp+Dh2OSpfChIRVtRY/AKBFpev?=
 =?us-ascii?Q?FIjku1pMepQBUx+7r1RlbvgvpjFr+X4mJk8jCl2m2nr/3oyJVyyh+7xSnnEd?=
 =?us-ascii?Q?JUGL9hOnGEptfFfDPbDSZ/XX/0sKmj/EojFnd+2gNJiX+GrffVk6gganRGLc?=
 =?us-ascii?Q?QOptNoc2jzNU6x0VOYn314thTmijHnXGuv5z5mKHBOG9RR8/PWT6u/Ljd5WU?=
 =?us-ascii?Q?CvxbvzZtBFmwcP9C1bLdE8xu4MeH5/xu5sjzC406C3HQ+kHvgJUEYOV8vKIM?=
 =?us-ascii?Q?eJ71PzWzNtaZMnaule8qTESb+18zhqF39X57ZBUUQdcz95G194oJP21ZqJuM?=
 =?us-ascii?Q?IoPh6kkMStJJkMZcL0E2QiV+COHOO4W5AM/RhZXNMs1YWQ1ULC+A8xRwswaI?=
 =?us-ascii?Q?Rsr3JAro06BztFrwMaVdgQYxbp1uGVKS6OIV4Xpo9ci7NZEnazLJDE5VgRa7?=
 =?us-ascii?Q?o/2Z/0dR/BeAP8ILnJrc3Rcsksb17ZPcjiUWtG+BK7jBV+Q5Tkgo5r+8ivZN?=
 =?us-ascii?Q?69B0hAY+AbDJgyF7z0BaSokrOIaCuso7ZHyAc1H4BiGQgZpG49Tk5AvgzsMd?=
 =?us-ascii?Q?XK6utrmYGdJMdiG6opiIAmB+Z8UB9dmLDns5RRn7pe93p/9xZywiHem8yUn2?=
 =?us-ascii?Q?xiYQg0yo5htL7eWGvL+IgW8S+0mCify75fjhHNrvc3F13SDA/R8YCu3ZKYLR?=
 =?us-ascii?Q?00zxkgnG2vPw98mvuKf0fQMw42MJOroaspmPJp+GYVez7YEkjRKpMHxOI4o6?=
 =?us-ascii?Q?pWeZ1xBmMbWayK/QdlhOshpn+vEq2JRqgixZT0c4c6gPmYwXRW6pjc9e4laE?=
 =?us-ascii?Q?PkwRRCC98+RtZBow6rJPtUmqp164GDLw98ngnDuPg4s8vzCU3eq8ji7uDn1B?=
 =?us-ascii?Q?4mel65L3epnH5id09e+95g+lHebI3g6cSc2CYRLxHQX0EC7Xr3S7K3GxIWBU?=
 =?us-ascii?Q?jVIw7biHr0L9/qH/Fu3Hu/80g7j01o2cq6sYHFs02HJSY5UJosOZmAlHypzA?=
 =?us-ascii?Q?zE2zc8ezVwvlNDDHae+mge5pP6sxiFQI2gGC1Pp5YNPP2/iIkYOa5ttyU5VA?=
 =?us-ascii?Q?6dz4CGp5MjP7qxhotCkJySnujnmaKBTm9RoatYlxNowSci7SDLp/dcP0Vf0o?=
 =?us-ascii?Q?UI9pYFROFgTm/Bj9KOPw1vamf9DDuObmtq94JKPeLA85rM0M3mQegg3ZX0Yx?=
 =?us-ascii?Q?BZl1b4g9SC0/D+WEnDdNM8CP5gimOPTUAyBrjb2i3fsCLiYw2MkrMonQL/Kf?=
 =?us-ascii?Q?pA5uMITIVO7mdBI/8Qnpw3Ws7YVt++6rEwyztqOGv06kZ2Yj/dGigB22gbT8?=
 =?us-ascii?Q?LEpeHIVcYP4r2pOmAuXlu93d59C9MpDpVdY3v0ADtp/BZPtoN5aVTXXugZPW?=
 =?us-ascii?Q?yCwuU//kLqB9RsqNAWApCjIbmA0DQEeXtLHaUgke?=
X-OriginatorOrg: kvh.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a0f3ac-e36b-4feb-9f0e-08da6a83e93d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB7167.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 19:13:21.4286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 45c05af7-f354-4404-835d-8de3cef70ba7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCPN87iXgPyK/PCjgX36UntRFkjWj0MXoW9/BBaB16FMTpvf6KOa60yn3tDhQeadIP//IAkEBamkzdPMNYjpFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR07MB7740
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA45A45 smtp.mailfrom=jtavares@kvh.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kvh.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thank you for your reply!

On 7/20/22 12:23 AM, Denis Kenzior wrote:

> I doubt the passphrase length has anything to do with this.=C2=A0 As a sa=
nity=20
> check I
> just ran a 46 character passphrase through a few auto-tests and it works=
=20
> fine.
> The 5G log does seem to imply that the AP doesn't like our reply in=20
> message 2/4,
> likely due to a passphrase mismatch.
>=20
> How are you entering it? iwctl? Editing the .psk file manually? or ?

I know I sound crazy, but, length is playing a role, somehow. I did a=20
binary search on the passphrase length to arrive at this 40 character=20
limit, and the results are very consistent on either side of the line.=20
With more testing today, however, I did see one instance (out of about=20
10 tries) where 40 *failed*, and one instance (out of about 10 tries)=20
where 41 *succeeded*, and so I'm thinking 40 is not a hard line in the=20
sand. That said, it always works with passphrases say <30 characters and=20
never works with passphrases >50. I'm thinking more race condition vs.=20
say, buffer overflow.

Is there any chance that the increased length could be encroaching upon=20
a timeout? For example, does PBKDF2 computation time, or some other part=20
of the authentication process, scale with passphrase length? I agree=20
timeout is a long shot, for sure, as the CPU is a 1Ghz ARM aarch64, but=20
I'm grasping. FWIW we don't have any SIMD (NEON) accelerations enabled=20
on this processor, and so lot of the security primitives are probably=20
un-optimized. (I mention this because I notice your test harness cases=20
enables X86-optmized primitives in the kernel).

For the record, for password entry, I tried all of the following, with=20
the similar results:
* copy and paste into iwctl
* hand-typing into iwctl
* hand-crafted .psk file, for example:

     [Settings]
     AutoConnect=3Dtrue

     [Security]
     Passphrase=3D00000000001111111111222222222233333333334

(Copy and paste that exact password into my Mac's authentication dialog,=20
and it works every time).

Also, when switching password lengths, I made sure to forget the network=20
each time (which deletes the .psk file, as you noted). Per your=20
suggestion, today I tried restarting iwd and the Router as an extra=20
step, but that did not seem to make a difference, either.


Regards,
James

