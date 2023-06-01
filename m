Received: from esa2.midmark.iphmx.com (esa2.midmark.iphmx.com [68.232.137.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806F823DF
	for <iwd@lists.linux.dev>; Thu,  1 Jun 2023 20:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=midmark.com; i=@midmark.com; q=dns/txt; s=key1;
  t=1685649674; x=1717185674;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=7edp4lWEZKKIx3krEZo4Oyb51TUDmmHqhRqTX4kfEIc=;
  b=Q21IaaZeC21TajxIjwMjypzCusVHXbhVuuzHhvr0xccrbj6bq5JgQGxM
   JApx3s4ikwd6dK3UqYtYMAi+YTC9qbxoNrvjJp9OK+C+coVmLgOasCPDV
   KHse2HUEwlnSrM1yLV6fKN1MU9XZTdZ0jLBqQCHMMOsZRo/NtKsuyZ4kA
   U=;
X-IronPort-AV: E=Sophos;i="6.00,210,1681185600"; 
   d="scan'208";a="69952149"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.midmark.iphmx.com with ESMTP; 01 Jun 2023 16:00:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1HcvVImEE/nSkN3fNvlNOtnuf/ljJ9kfWXBS81qvyb44Au01hI84sO1cJAGe95694MQbV5Jfum6BCDP8RKG5QxxJLoyNSUkX2pypY9R1rqJfIuZ6vsA3aZAsMIZ4ZVWV6QcCPUnSGfw84fdAtI5b/h4BsxzXdXTGPZf5y9CGiy1fkdVrg5bgDsEYzurd/wzvHeKBVaSjvQqOYnxQpospOVRlcZcCtmcycdshq/FmU42A2u0/yZ4qfFtCcEvGd12NHkkZyM2FhZHXah7QiEbPCzj+aniTwO3NzXmCd2rFNeZuTlyfUG+jU0ruu2WqaOO0Nnr4JzKbgbuQ2toG57kVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNZi8NB9dE+41grqhPgpG/DN4hjZI5XeaQ3HMMkf83c=;
 b=ekz4gLHgy+z18IHs8LPSrrzQNncnM3OgUw0CL/D76evzbQjK0sNARBKxqdD60C48YZuIzphZu4HuHUC7Q82PU4Baq65I70FeCqi8iRfD5vT+CoAXesSeZ1wZrfcQfqhnuGLLvEq6WB4c65ogf9JgGpk7nylamD8kcLNVptxVDLHlJBOYT/oE4gCl9a6rR8fTt84QuRKYXJt0uWoVo4HFnm0zHK4vqs0hZegbWJVX8qu/osr9GBknw3Nov7cFaah2hN/1Kl2Prhqc8WNW/eO5dFxm0tX7LB7xE2kttTAvf+5+9qiW4L0FITpc71c7PZFzbT8IyAYkLrfTQhq+Ek2LXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=midmark.com; dmarc=pass action=none header.from=midmark.com;
 dkim=pass header.d=midmark.com; arc=none
Received: from BY3PR08MB7220.namprd08.prod.outlook.com (2603:10b6:a03:365::15)
 by SN4PR0801MB7887.namprd08.prod.outlook.com (2603:10b6:806:1ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 20:00:53 +0000
Received: from BY3PR08MB7220.namprd08.prod.outlook.com
 ([fe80::533b:41ab:1b5b:7710]) by BY3PR08MB7220.namprd08.prod.outlook.com
 ([fe80::533b:41ab:1b5b:7710%7]) with mapi id 15.20.6455.024; Thu, 1 Jun 2023
 20:00:53 +0000
From: Michael John <MJohn@midmark.com>
To: James Prestwood <prestwoj@gmail.com>, "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>
Subject: Re: issue using virtual interface with iwd
Thread-Topic: issue using virtual interface with iwd
Thread-Index:
 AQHZlIs8y9omM24b0kmI/1XiEYh7sa92DDeAgAAC/ACAAALUT4AABzsAgAApeXWAAAOaAIAAEzuB
Date: Thu, 1 Jun 2023 20:00:53 +0000
Message-ID:
 <BY3PR08MB72206FB8F6C0F2A34729731BAE499@BY3PR08MB7220.namprd08.prod.outlook.com>
References:
 <BY3PR08MB722000E74E402E1C188F35E9AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
 <0e37cdc7-5d9e-f3b3-eb98-d549d9a69d6f@gmail.com>
 <17dd827c-a2de-b7ec-75de-99d0b17cf6f3@gmail.com>
 <BY3PR08MB7220AB646467DBCE1A4B7433AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
 <eba9839e-55ab-d532-c52f-c58cac465ea1@gmail.com>
 <CO1PR08MB7221B49078929FDBB79773B7AE499@CO1PR08MB7221.namprd08.prod.outlook.com>
 <0909f3d3-3ce0-cbe7-48f2-9b37d5ca4bbb@gmail.com>
In-Reply-To: <0909f3d3-3ce0-cbe7-48f2-9b37d5ca4bbb@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=midmark.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR08MB7220:EE_|SN4PR0801MB7887:EE_
x-ms-office365-filtering-correlation-id: f6d7e414-ea41-40fc-b64d-08db62dae795
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 C6md+soAYzZQwke8+y5c4TFJfxr8CwesloInctaR1FInhpSEoxUw6lwQpN1B6fIteNWznBBtQDcn8T58pansSeNx5IxgXrtErm7pA3c0YTbRDbvkbjInt2ulHlR+Olmeo4tygphlIVArCj/sUv0umYJT0+vBRq5v3RF9niE7DyGPU1+g06pt2rQQWgrUrAe7oWwG7BBrezHxZ3hO5avu5PwuwHvG+P+eiCV8L83ybwbpAdTp2MALp7ecp6lg1kBw6I+ZwyJcjgTDIgYA24hk2eAIGUR4lY5GLL4hB1hOpwZGPf+C0rjH4MddNEfzUTjqWdPCvJIcogynKtQ+xorsrDlPDypIkNebM/dcjKjX8noFkI8Imp4zNr0e6ZRFE3eMlzXdqxGvzc7wdR5QabO+WrGP1DGzXGk2K4PSssz6Ugqo1QszQhYQBygSo0hL08CjUeRau5+SdXxp1wXOSeJR+jzh7K1JjyK/fFPaWXXBijNNNipYqTqONkwtFi060JqKM6/5I26J1p6dAf9pIvwyPpqiBnibogSG+6gm0Ed6gyU3clCyeL/MO067waKAi0JAdAhQ9BhzXe3QkOxL+qEm8QqIco35hQz7D5l6uPeSWgcvCfc0NR+4QxzpWPs7S6GHCY36a5vlkQen2hq3GMnpZw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR08MB7220.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199021)(38070700005)(8676002)(8936002)(86362001)(38100700002)(41300700001)(122000001)(7696005)(186003)(2906002)(316002)(6506007)(9686003)(110136005)(26005)(478600001)(33656002)(71200400001)(83380400001)(5660300002)(52536014)(91956017)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(55016003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NnzQhET+X+iJNdbqvOGUvIpcm0P+YhfHbzh+RAtRqRepMAMrnwqcpsS9QZ?=
 =?iso-8859-1?Q?2nK76QN2/2LVDLo8mZEJNHySM/znOHlkWYwhucoO4YOFHUXylXOXSs6OFU?=
 =?iso-8859-1?Q?BvLzWh7yUF2VPlQrqeRQi0o249T++cHMQvXDPF1BrOcLkPWMVwbn19Xwz6?=
 =?iso-8859-1?Q?nQbByUYP8nCx4PAvRqkjMWNbL05JJS8/JxFE8FTSz4uRkxMObJZMmcOi7T?=
 =?iso-8859-1?Q?p8bEMoAqDO3jhjEdVt+rJScttima8sqdkn47z4Gbrz7FIellRmAe0GQ/hY?=
 =?iso-8859-1?Q?nDQre5AzDsSqukNj7K/XM14JJuLtifVzqideLnmaeGUecNKMwSkwyHzVb0?=
 =?iso-8859-1?Q?8GwFeEf74rgF9ZNB/2UPIhdlT2gKcto0DD+7sX93DxJ9GbR+p3UtpRV1IM?=
 =?iso-8859-1?Q?nLljhPD2BOk8MJS9xu5ERxsAQWl6b+OuKIWIeoSWorzy7ZQMzMxk+KfcBC?=
 =?iso-8859-1?Q?rj2jV5+lpDuHb35tMZeTAo7fb6WiE0YhePReSjCzAG7OtMBE7nRXI6bi5j?=
 =?iso-8859-1?Q?eq3+KL9VILdIaPSEHOlDac2FXPQvVo95VymFZj/THxJ3wZs71UufDw2QsL?=
 =?iso-8859-1?Q?Re019r1klyMT+ahWA0Fs5Eh8O7UlOE0o5N6HRCRUn/6rKmPrEZdIGl8Zj3?=
 =?iso-8859-1?Q?GlvdXR1eldyYVLh+SKB6uDjAq5flSKFVLKfSI59iL2CK+6uGBUGuzSjT3B?=
 =?iso-8859-1?Q?lezoJa9nFy8faUmQg7BB9icSgdNAbyN4hqnXLuJK1aaTuryGQ6pUfl4PgT?=
 =?iso-8859-1?Q?HC97DCJgwTjVgnkuhhUfwuprSt9goVX72fYDXQVEFMStTTSW9nR+xU3X16?=
 =?iso-8859-1?Q?/E8178F04152nYkHSiBPk7l7j0pAERvrzrQKZUlaVoFBc4Ss9Jh/H93PXi?=
 =?iso-8859-1?Q?Kj0HRE41ueo3VI7aUgpcW2hdO1liF9GrJ5fDIdGQWenxsXJnNFJ1aUv6oh?=
 =?iso-8859-1?Q?OJ0yOAkMYN792b2xaJoNqyO1GmEoGPRx8X62wCAgeTu48xt2KNP9FW5pP+?=
 =?iso-8859-1?Q?u98UWzYFUOIVJvvZLCFiJk+Mp+tViep2lZw/MLwDfirsdl8Zht62eslqVr?=
 =?iso-8859-1?Q?GX0PguHDbzOy9A8F5UvAwv+fIFmEFOo+7UUMOxhcZnu0ppveXNntKPEy1P?=
 =?iso-8859-1?Q?UoT4RjWRO6Gto+xfIwqaQaetETt1yaCkV95nRoEjdi4C1NhUWyPRC06fNu?=
 =?iso-8859-1?Q?0iuoI3EVlnz1Fl3W7RXc9Inuo57KI1DkbP8Kkif4DNaCJ8fbi0D0kEOr8d?=
 =?iso-8859-1?Q?4L5xdq5Eieolje/beeJtoJUcJLuLFtFy7c+KLAsXQEH1U5oqT9PlSmdm2Q?=
 =?iso-8859-1?Q?H9s6tmXuEMuuX4IFKjI2ywnjtt9OAqUYhgJmJix/n3PpWPc7eCvwwMgZM1?=
 =?iso-8859-1?Q?Vx4NPJ2fMHmI/UrVEAvoZZ5nkI9JTCkfQjaJ3xZ9j9rHPdSXlX9F+/iCqb?=
 =?iso-8859-1?Q?jEbJa4OC2v+IO1cM+XR5Z4B8NfmpVq679VE10FTbKgMrBL5yyjkclWLi5t?=
 =?iso-8859-1?Q?zO5O+iRp2dvzRckf4CT1eA+SZvBKQFw2J1M9B/ZO2BYJrZC5cH845r8tex?=
 =?iso-8859-1?Q?5Pl+OxewtB3QtJtdXvItIxk26dxwg9mZZGHipGbCh+OFIwNHMZgY7CNTdg?=
 =?iso-8859-1?Q?6sbAPCtuC1Y94=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: midmark.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR08MB7220.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d7e414-ea41-40fc-b64d-08db62dae795
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 20:00:53.0568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3c2a020d-f343-4ca1-b6ef-91768380352f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JuoPxfK4xuX2RTNy1GNK4+q6Qmp0+x9vfrKfpy0BmHILBH3Bw9QEiu5xZ6+JCN7C+MP0a9HmAtLoGwW9ECAZNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0801MB7887

Hi James,

> Hi Michael,
>
> <snip>
>
>>>
>>>
>>
>> Thanks James, that allowed iwd to preserve and see wlan1 and recognize i=
t as
>> an AP.
>>
>> ~> iwctl device list
>>                                      Devices
>> ------------------------------------------------------------------------=
--------
>>    Name                  Address               Powered     Adapter     M=
ode
>> ------------------------------------------------------------------------=
--------
>>    wlan1                 c0:ee:40:64:4a:1d     on          phy0        a=
p
>>    wlan0                 c0:ee:40:64:4a:1c     on          phy0        s=
tation
>>
>> ~> iwctl ap list
>>                            Devices in Access Point Mode
>> ------------------------------------------------------------------------=
--------
>>    Name                  Started
>> ------------------------------------------------------------------------=
--------
>>    wlan1                 no
>>
>>
>> My last hurdle appears to be just bringing up an AP.
>>
>> ~> iwctl ap wlan1 start "testnet" test123456
>> Argument type is wrong
>
> I'd need to see the debug logs, but this could be what others have
> noticed where certain drivers don't like some of the recent AP mode
> changes adding HT capabilities.
>
> Again, don't know for certain without logs, but you could try and work
> around this potentially by using an AP profile:
>
> #file: /var/lib/iwd/ap/testnet.ap
> [Security]
> Passphrase=3Dtest123456
>
> [General]
> DisableHT=3Dtrue
>
> Then, you can start the AP:
>
> $ iwctl ap wlan1 start-profile testnet
>
>>
>> - Michael

Here is some log information while using an AP profile.

~> iwctl ap wlan1 start-profile testnet
Argument type is wrong

~> journalctl --no-pager -u iwd --since -5m
-- Logs begin at Thu 2023-06-01 18:53:45 UTC, end at Thu 2023-06-01 18:54:1=
9 UTC. --
Jun 01 18:53:51 cm1sd iwd[8884]: src/agent.c:agent_register() agent registe=
r called
Jun 01 18:53:51 cm1sd iwd[8884]: src/agent.c:agent_register() agent :1.84 p=
ath /agent/14661
Jun 01 18:53:52 cm1sd iwd[8884]: src/ap.c:ap_validate_band_channel() AP usi=
ng frequency 2437 and channel width 40MHz
Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 0000: =
-114
Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 0020: =
-114
Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 0040: =
-114
Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 00a0: =
-114
Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 00b0: =
-114
Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 00c0: =
-114
Jun 01 18:53:52 cm1sd iwd[8884]: START_AP failed: -22
Jun 01 18:53:52 cm1sd iwd[8884]: src/agent.c:agent_disconnect() agent :1.84=
 disconnected
Jun 01 18:53:52 cm1sd iwd[8884]: src/agent.c:agent_free() agent free 0x35ff=
98

Thanks,
Michael
CONFIDENTIALITY NOTICE: This message, including any attachments, contains c=
onfidential information intended for a specific individual and purpose. If =
you are not the intended recipient, you should delete this message and any =
disclosure, copying, or distribution of this message, or the taking of any =
action based on it, by you is strictly prohibited.
