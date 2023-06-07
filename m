Received: from esa1.midmark.iphmx.com (esa1.midmark.iphmx.com [68.232.141.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B4231EF7
	for <iwd@lists.linux.dev>; Wed,  7 Jun 2023 12:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=midmark.com; i=@midmark.com; q=dns/txt; s=key1;
  t=1686139475; x=1717675475;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=hf2JzKY2Xv+sTYUE+zOxK64qL3VCpNqvH5mQUtAQZr4=;
  b=eQ6h/mKMKWRX540RJtwvPDMtP9p6MMbeeuzjxM4W+sSg4DyHPqnD/j5V
   fL0KL63UZ2KUvkpqK58pYzPhAl/vtZwDx0RhYkVs+xBQsxntD2DdisV57
   BvGkC2nG3uqn0OhX7UD4U0nopgUePDi/S0selOfuVx2LFEy58Pi2S3xzv
   0=;
X-IronPort-AV: E=Sophos;i="6.00,224,1681185600"; 
   d="scan'208";a="73501023"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.midmark.iphmx.com with ESMTP; 07 Jun 2023 08:04:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5c2vDo6/gJjtqKTNtj/lyozpWa2eZyJ2CgsA+ngVZSKbB4RxMyMmigJ3dbsC/CwP5kVswjm1Zi8wMB0NK3ytFsIy1HkBb64tahu1oRGTpNMyflf4QhlKMEIcF5vnsapG4+LBcIh+jKwn1kWtyPpRgale4VkJhoOb/EnyWpk1Dq3fPlUgW/c5ZoAkh73od5VNU5iOzPbJCMZPJOSLFMkPCYLU7nq6PfmdJHGzH3L3/KqV6UIOsZT8QvX6TeUighUmleob/weY/LMJ9Lb1O2IEV3vqPfu8F9R3A6hm8pxIDdlDhiYdLkxnkbQyOoJ1XqaOYKlGk3G8VHTVGLybczhDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OU7FeQNDHyxAk0/mCqVAJ+rhZmnSHgjxesI0hLq5W4Q=;
 b=f13qDUcrZaK6db+b7mYQRYPFYOQ8ZMx1IsR/AOoR8OWm7f/1Qvujm5V/gVcoJHKlaYG2J2nleSw6d2ZPgYH1iU6rZ+onx/j+R4f+BEdTrC3B1I4fNzh9sxRqHIQaM7y6/6+3LXVfwPYIeAtIAYiJQkdNU7zLccrvtWC6P1JOtHUc0xc3lWucYeQrsqUqDwUnR5cwNtJpMVf7XLMGeaa2lhoTh2k4EL72a9YWjuWNadDG1vHfj+oZN4sWTn5WCiqFti+JZ7RQP/+pgNi2EryrmBo+3BIIGXYYy7afN1S34poSyR4+CORk49PV+UjkuLF5iCtzHskKAgXzJCABCAZztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=midmark.com; dmarc=pass action=none header.from=midmark.com;
 dkim=pass header.d=midmark.com; arc=none
Received: from BY3PR08MB7220.namprd08.prod.outlook.com (2603:10b6:a03:365::15)
 by PH0PR08MB6599.namprd08.prod.outlook.com (2603:10b6:510:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 12:04:06 +0000
Received: from BY3PR08MB7220.namprd08.prod.outlook.com
 ([fe80::533b:41ab:1b5b:7710]) by BY3PR08MB7220.namprd08.prod.outlook.com
 ([fe80::533b:41ab:1b5b:7710%7]) with mapi id 15.20.6455.034; Wed, 7 Jun 2023
 12:04:06 +0000
From: Michael John <MJohn@midmark.com>
To: James Prestwood <prestwoj@gmail.com>, "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>
Subject: Re: issue using virtual interface with iwd
Thread-Topic: issue using virtual interface with iwd
Thread-Index:
 AQHZlIs8y9omM24b0kmI/1XiEYh7sa92DDeAgAAC/ACAAALUT4AABzsAgAApeXWAAAOaAIAAEzuBgAAJu4CAAQD+4YAABcXugAaQwQCAAUg5pw==
Date: Wed, 7 Jun 2023 12:04:05 +0000
Message-ID:
 <BY3PR08MB7220054B5EC6EB85D17B6ACDAE53A@BY3PR08MB7220.namprd08.prod.outlook.com>
References:
 <BY3PR08MB722000E74E402E1C188F35E9AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
 <0e37cdc7-5d9e-f3b3-eb98-d549d9a69d6f@gmail.com>
 <17dd827c-a2de-b7ec-75de-99d0b17cf6f3@gmail.com>
 <BY3PR08MB7220AB646467DBCE1A4B7433AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
 <eba9839e-55ab-d532-c52f-c58cac465ea1@gmail.com>
 <CO1PR08MB7221B49078929FDBB79773B7AE499@CO1PR08MB7221.namprd08.prod.outlook.com>
 <0909f3d3-3ce0-cbe7-48f2-9b37d5ca4bbb@gmail.com>
 <BY3PR08MB72206FB8F6C0F2A34729731BAE499@BY3PR08MB7220.namprd08.prod.outlook.com>
 <7c72c879-98c1-2df3-e676-540ee1463cc9@gmail.com>
 <BY3PR08MB7220F8324CED704A01BE5946AE4EA@BY3PR08MB7220.namprd08.prod.outlook.com>
 <BY3PR08MB72200F3BA8B1FC2C28C9C099AE4EA@BY3PR08MB7220.namprd08.prod.outlook.com>
 <696f641a-59ac-a476-a17f-a9ad43a524fb@gmail.com>
In-Reply-To: <696f641a-59ac-a476-a17f-a9ad43a524fb@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=midmark.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR08MB7220:EE_|PH0PR08MB6599:EE_
x-ms-office365-filtering-correlation-id: 995ef015-c5e5-4318-c001-08db674f4ae0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TmMS7vz/UUgRV0ARIWPAtRNpQbt1+/Aq/xX1dWVaM1DhbS3W5zXV0Vu3BPsN2CF6FEc8PBpUy/SjqwyLXb7ojAO8YqRa4PyxQpOItaZbOmnu8i8CjmaKUl85iGNR8pylTuiGuoMedsMyGngXfcTncX7PfR5mMdXVydnM/WTaMtWYFMmi9fZ4BqnK62swFjLXlxTAQ7D4s5GFz/Zpa65vdIaBk0XgwfQV2TlyK5URsOtjGG7HL01JlFUanlgzU8xqzFsFXWQBsDmW47yqOybpDhXbef6buR86/njaFuOsccOiO5Yj8x//7YEaB9dahsnr/xMB9pKTMJrKIgm6eu5UuTrs+l1x6IvfwoGIWxkSpI8W0TLveLgjDoZNeRgkG5DAh3Rr9J8ynEJHI6Yqz1pm8A+un/Hi1y8iu89irGLry9Ov+EgqyrtbZUwrTHTyK05RBkVRZDFqawn4zgN9MbMhekD1EYTmnMSqfION7K1sFnsr80TGqX2XW9GgC4QaTw92Kw4n6Su0sTInxXHZRQYvVNeo9Qj60x2/mw47TYwyfFPbAxMBhkLqYLKR4AKWKDaGhjwCT1raba6gY3avaInMMia23bSzAwh8uijd+4QnAUY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR08MB7220.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39850400004)(346002)(376002)(136003)(396003)(451199021)(55016003)(7696005)(110136005)(91956017)(478600001)(316002)(8676002)(8936002)(41300700001)(66446008)(76116006)(64756008)(38100700002)(66946007)(66476007)(122000001)(66556008)(186003)(966005)(71200400001)(83380400001)(26005)(6506007)(9686003)(86362001)(52536014)(5660300002)(38070700005)(2906002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8/kOKGfJHYFEIAPzJGNMGGeQtaIbkniZuw8GgWRuIgLzrk66AMMgrFXjfP?=
 =?iso-8859-1?Q?w2haIzFksuHgmPBrRGm1Ci0bldR0cgHn22LNB3aEOjykGwbsRWtNu6fBT6?=
 =?iso-8859-1?Q?1Xo5XHOUF5TO8OurLSloEkKTm6RyfLChTQIdlPEUm+Oex68klRS1qxwJun?=
 =?iso-8859-1?Q?gz29dmYqqtJA10jR8uuF5/F5HazlUepzTs5XEAUbLNUI9qU2z2qjmw5wal?=
 =?iso-8859-1?Q?oML1pui9NNksvcpk75NRfYw+icvFttK3ZPLDxjNv29OkES2P/KVwvmAyCh?=
 =?iso-8859-1?Q?8z92yKhyri1lWveWuk76PtUryWBLaKmVK+VG0hmlwN0mpZhPunJUaHR6l4?=
 =?iso-8859-1?Q?PFga0kJv5UHlqzG8aUSp9XqZK6vNEvqKWjGaaDk10wPI/ydaf+tWqQv9hb?=
 =?iso-8859-1?Q?y9vj64MjiKYA6dQtta3M8ty9b5UirLJY8EpZyvjtH5Aybh3OQN+zy71wvM?=
 =?iso-8859-1?Q?gIzkQQd5lmkCFRIxOEfiMuKBpM5rRGPyrbhrLhbA5Y+YSAI4k34YQbZUzI?=
 =?iso-8859-1?Q?LItQaNem6UdXx7rx2Eoz5zgH3UfLagGjlzXCJJWFTkjuOkoXp58MYJAAIU?=
 =?iso-8859-1?Q?LqNlWr6aabmcE6ddYYEAX92uAJK0/y1FumPWBFWHmiVkaNOGopra5m2ao5?=
 =?iso-8859-1?Q?M34aDLanpRoLU6XvCvTkOvdPBCZInQQ4ZUFQfe2tPPV8hv1YXivhYi7+af?=
 =?iso-8859-1?Q?rOqOeve6wbBghUOr7uCQyDhzupHyuAICIAPUztvx6BXAGmDmHHkNo5qBFZ?=
 =?iso-8859-1?Q?Z1R4ZF0eBcgcfweCZUEzi8U28ZFPeHaksBZ9BEiyInybCNBh6QOXxn92jc?=
 =?iso-8859-1?Q?FuP91HKTSuiQSPE6PbfT3cKFl0tZbHVp2MDV/yol+UQ+8ax3umo6ljMw/S?=
 =?iso-8859-1?Q?mafh4ZxBVZNBUhr9zWE4aUf4rjfZhBvn2NDDzZahbMFLnRAI7nCbfY/DAr?=
 =?iso-8859-1?Q?2RPtgK491xfDNOQFxCTorrhwrqLgxV3sltcYKLmCxYBCNLHqcfj2UChRpe?=
 =?iso-8859-1?Q?MA+UHwLn/rr5XOKpPObK73gwG+s2EcLlcO0R9QVG8MhTGyV/o8y+U/234P?=
 =?iso-8859-1?Q?EMAkGZgjs89hc/8+Ow+ARCPTTUxYyTq23v1pL6mSuJupMuZf6N6vAi1rO4?=
 =?iso-8859-1?Q?Z3ue06HVnHD8CSL3DTyVHTVaJ9/Mnyar3OZmFcnjI+Vy22oBtdHfmUJMf2?=
 =?iso-8859-1?Q?ZDRF/357+fWxsiNIq5JbIrboQGNySJaTAaT1s6jqqWJOY4QmYnBFLnm/gi?=
 =?iso-8859-1?Q?OVUKdpEjPekOSbygGDGfjfJVCIgjwJEHbZUAewH00G/xZcK9NZ4UOWSAz0?=
 =?iso-8859-1?Q?eEMuhTZ1R0//ulOThiaznPW2zixxy6xohiacIsZzG3xQajj2wllVvwhmLZ?=
 =?iso-8859-1?Q?0SbLQR5y4xxM22xQdfZOZBjvVfzHufAqQ2EhrrtDs7J3BFYarDU72V7KFO?=
 =?iso-8859-1?Q?C3V+KnDaFcdDFwqQuJI15euSj+1yIpLXZPknXuNyAJWIFFgF5RrPAElYSD?=
 =?iso-8859-1?Q?vWmTRnFdWgqvWo2WoVRqbdtO2qyf3zE6mY+AEw3k0ePvD6/O3t9zljrqrY?=
 =?iso-8859-1?Q?9zSsimjqMPQpuh6D0Au2e3DPdlvhindTC8V4QutWWOzrm0XUiRXygkm5dd?=
 =?iso-8859-1?Q?/bWeqZRngsT2o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 995ef015-c5e5-4318-c001-08db674f4ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 12:04:05.9314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3c2a020d-f343-4ca1-b6ef-91768380352f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Ewq4jvUbdotc57fshPuAujBYJqg0ivTQiZIyOPthbMllEFX6FQzGvBPcb8W5+aRZ3pvCAK1kebtBR5Fbwrlrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB6599

Hi James,

> Hi Michael,
>
>>
>>
>> After looking through the commit history I see the DisableHT support was
>> added right after the 2.3 release. I've updated to 2.5 and retried and
>> was successful at getting the AP up.
>>
>> Thanks for your help James!
>
> Great! To try and get this addressed better could you provide the
> wireless hardware you are using?
>
>>
>> -Michael

The wireless chipset is a NXP 88W8997/88PG823. It's part of a 60SOM from La=
ird,
believe its one of Laird's Sterling radio.

~> cat /sys/class/net/wlan0/device/lrd/info

Driver name : lrdmwl
Chip type   : 88W8997-SDIO
HW  version : 7
FW  version : 5.5.43.5
DRV version : 9.32.0.13
OTP version : 2
OTP num mac : 3
Radio Type  : SU
MAC address : c0:ee:40:64:4a:1c
Region code : 0x10 (0x10)
Country code: 'US' ('US')
TX antenna  : 2
RX antenna  : 2

lrdmwl is the Laird wireless driver being used.

For reference: this is the SOM:
https://www.lairdconnect.com/system-on-module/microchip/60-series-som-wifi-=
80211ac-and-bluetooth-51


-Michael
CONFIDENTIALITY NOTICE: This message, including any attachments, contains c=
onfidential information intended for a specific individual and purpose. If =
you are not the intended recipient, you should delete this message and any =
disclosure, copying, or distribution of this message, or the taking of any =
action based on it, by you is strictly prohibited.
