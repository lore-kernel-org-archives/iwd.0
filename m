Received: from esa1.midmark.iphmx.com (esa1.midmark.iphmx.com [68.232.141.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEC518C1B
	for <iwd@lists.linux.dev>; Fri,  2 Jun 2023 12:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=midmark.com; i=@midmark.com; q=dns/txt; s=key1;
  t=1685707814; x=1717243814;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=i3d8ulrPkPJwp3jGbRlr+Esvp7TrzkKXVCSTG4OpW/w=;
  b=kVfBrFFP/qYX3MfPI/TVZxDmbbWjoIg8Eu7hX6WZrLJJHHgwiIF7WguD
   uDReGBqpbO64Xb84ptH26lselO/V/zuVnLkpQA+NchE69F4k1k75BScon
   cI4xOFR52qZJpZvZMlDAH4EeQBRZLVYP/6OJpQuorOtNFufpml8lV7h58
   Q=;
X-IronPort-AV: E=Sophos;i="6.00,212,1681185600"; 
   d="scan'208";a="73369300"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.midmark.iphmx.com with ESMTP; 02 Jun 2023 08:09:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcfixpvZTjD0kH8dND1YGwPletdxmAU2T0XEydsdWIzMVB8h196Rzltc+nT2z45LudFFTvXYo6CodyAbZgr/CF7RBd/eJfcrQP5FxKBonaK+RiZ6SBL1ugIf+/0c+EEExkE5yyWrQd/uFf9Mt39ar9PMz041/3aa4QrOAwwsudsb/EGktwOM+I9ZWBaWOjf3jUxVA9fP2yQSUoK06adC2/BjUrdP9mh/EWpsk1UUBgJpecCnCvVEoreRuvCeEFvHsm+QGYc6z7/clIKJjb3n3qS/uF/Yy9dseEEoGsSEb2IWeCO6zQSJLAHNiiXPFupCdlfuRSVwl990PzukTpuTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyIcWYAahsE3emI0PwirYTcGwMWFDIDgB8K7TGE4Ntc=;
 b=Em2nnUVz3U+a9VEPUUM8iWly94ndVGKTa+bnpi3NJcL6tP1CCBIS2dN1U329tJVEpI9IP6Zr1+ySLd+w5e+OA6JXzVSdkYfIaIa2wEjYGVRhyXt7eCLToaYMHgN35JzXIuTiLzeYpUO+rQE4+4MW+ZJgKySOVtlzGb4b2mjCkCC2WDcIFK7VJWE2mEkCkQS142F3kTtx8n73LcP4AjWC/evd+8gCytCGxdhytz6TF7maYbm/vvCr05AqmHO4w8b5KCJh8nNt5PQ8b2GETGcipVkUL4Yrzf1CcyFh6XfzvH7AEnBtflD9CpPdNUA+xmxzKvfvYxDmCTtlDSlz6HGggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=midmark.com; dmarc=pass action=none header.from=midmark.com;
 dkim=pass header.d=midmark.com; arc=none
Received: from BY3PR08MB7220.namprd08.prod.outlook.com (2603:10b6:a03:365::15)
 by SN4PR0801MB7694.namprd08.prod.outlook.com (2603:10b6:806:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26; Fri, 2 Jun
 2023 12:09:42 +0000
Received: from BY3PR08MB7220.namprd08.prod.outlook.com
 ([fe80::533b:41ab:1b5b:7710]) by BY3PR08MB7220.namprd08.prod.outlook.com
 ([fe80::533b:41ab:1b5b:7710%7]) with mapi id 15.20.6455.026; Fri, 2 Jun 2023
 12:09:42 +0000
From: Michael John <MJohn@midmark.com>
To: James Prestwood <prestwoj@gmail.com>, "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>
Subject: Re: issue using virtual interface with iwd
Thread-Topic: issue using virtual interface with iwd
Thread-Index:
 AQHZlIs8y9omM24b0kmI/1XiEYh7sa92DDeAgAAC/ACAAALUT4AABzsAgAApeXWAAAOaAIAAEzuBgAAJu4CAAQD+4YAABcXu
Date: Fri, 2 Jun 2023 12:09:42 +0000
Message-ID:
 <BY3PR08MB72200F3BA8B1FC2C28C9C099AE4EA@BY3PR08MB7220.namprd08.prod.outlook.com>
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
In-Reply-To:
 <BY3PR08MB7220F8324CED704A01BE5946AE4EA@BY3PR08MB7220.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=midmark.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR08MB7220:EE_|SN4PR0801MB7694:EE_
x-ms-office365-filtering-correlation-id: 89b9b85c-199f-4f3f-1fec-08db63623f7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LB5LY/dh1fBa61VPaTASqzZ/gLW8V8oDzA9BfitSgnE+dOAI89T/fxV3SF6eGZzTAZVWYygebCRDFzGhJDcPzRy/C1FKugsxOIJ0GTYBgMjAMoB7b3BOh/ecoD8IdJwvjWj6I6q4PmcRFD402bicRbuMqYR8AM4OcJWmMWYf1iPoJpG0wHNjwfdsotSwaIQPyPqXQXazNnBH5Pq9UwKHYFoW+JuJSA1m+7nUHC42AAm2WAjnuTN/cs5mCIdwe6W0ctI5Cf6kBs7w6DKrxjIYvHZt5/bAqrbtBhsVuFv2fRThQT1KMMtE5B5cfdB8SqqDDrjdqNwBxXvB1F0aoAirjrq/ppQbUEb0xnflS8DLEJ6m1H5cNVhBTEsTKFRWmDsuybTu5T8zk+TaUeWAlRvidYOF5DDMuFxiCQPRt5u4BQtmImxsS3cyVKjn/DPqiWqB1lwjUhh1Av9K/DUYqm7LOtkjO2mZZqZynkotWCLgjNG+go6PGWeUYSsQWWTQuRGwgVXyG0MkBtoh4k+ceWOLITsF6JOEylFguGBHBu77McJXBPNydS5ORUxvBupeIFyipLZIHQyRVsDfcdg0WHCF67gGawvOebw7OvEwxL7G3Uy33d7GcyOiN76SdK5QzNk7QBeuULgI2zU1Tdr+xgmgaQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR08MB7220.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(396003)(346002)(366004)(376002)(136003)(451199021)(86362001)(38070700005)(5660300002)(52536014)(8676002)(8936002)(2906002)(38100700002)(316002)(122000001)(66556008)(66946007)(64756008)(66446008)(66476007)(76116006)(110136005)(91956017)(41300700001)(33656002)(478600001)(71200400001)(6506007)(9686003)(53546011)(7696005)(55016003)(83380400001)(26005)(186003)(2940100002)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vg7g3z+v6DecSYW0q6VEuhtbf5u6VUz488AQzCs/1OzsQNhaa7TPubV0T8?=
 =?iso-8859-1?Q?6CpswHymH5NZotfAo+aZCmYCQ4dTdExwoOwWylCABf/uT6jDqHP9+EJzu8?=
 =?iso-8859-1?Q?zehsdZEZc8T9UaXs64joPWgXIGTTs6HkSyo7010Ur5s5QS4hC7IhufwNgM?=
 =?iso-8859-1?Q?BplpWVX2MxQ1CSg3V0/bXFlOG3xq0nkxvWzPheUtC5/pkg0Kqw6aaKpt2r?=
 =?iso-8859-1?Q?M6yMcTIL5gHChIdCP/+dCiIY8Q2Tg8zYFNu+rc/30H3Nq91PxoHrYfhXC5?=
 =?iso-8859-1?Q?io4uwLpF1MIEFmgylEA8PtDpCdTEm8PIZkNLM0WJOmGRieSGyXM50YDIKH?=
 =?iso-8859-1?Q?1RX7LUwPuAUP0TL5ReLwfJlRF/Nd+kh06RKWiDigL3W4zv/WtHgvtT8qOO?=
 =?iso-8859-1?Q?uqotu9nyoqJuwJmklBjOTyPWy83anfT9v6cW9NJ9R1rngsgTFE+3zVkP5R?=
 =?iso-8859-1?Q?TTjFMQaKgYjqvksZDY1pYFGPWiBhnefGzR6EWi8t0ZIUHnxRWpK9JorIoZ?=
 =?iso-8859-1?Q?1a+5f6lhLwX4smfYjhC/xvp71B3uoQRDrAJoj4zYdMLs2fKTrYwKgKrEcb?=
 =?iso-8859-1?Q?NnrwpV2808qIQT70TZRqHjL/5I99LFiJZmWpBwgsNT54bkPbHoK6jtaLEP?=
 =?iso-8859-1?Q?xjivs0PFB/yAhRXnLDxXLoahqHhvLFGL5TrgT+HVH/5BI2vfc9xsdRKzqi?=
 =?iso-8859-1?Q?+YLbTvEJ5Nrd0hzDDdZ8D4LHbWEONoH4ZyZLv3uJ9t0pl+yq/SeGIFciyX?=
 =?iso-8859-1?Q?BsWKWeW5Huwo5FfsXlSvFg+iBB0WS7ItZAELeKnX9JV0HYehfK89ZMljAd?=
 =?iso-8859-1?Q?CzxgG5LHskrNKUKmze+Sr12KTAhZU1aZrKRvhWzCqPbc44xmBbTn0F2bvd?=
 =?iso-8859-1?Q?LI3QfJ6qWXKDNLYdbkSkVm2OQTxi4Q5cP7JOc1CGEzzb/aHpAqPqZStv7t?=
 =?iso-8859-1?Q?MILiFNxegK/xKCmx9DGqqqdDQ3glttNRDitK4HSuWdl6W9cbCOgM4Vj8Zz?=
 =?iso-8859-1?Q?sceu5Nk2dQWiSKn1Dg+z6KxA4n5yy04pqUxNm+zgzVXe8p8vM4dMm5nsP2?=
 =?iso-8859-1?Q?epwNzpk+QtRK1X+xONWis7DVrHDdw4pdN9s4h3g1UXVyVT5Qph7HtcNhu4?=
 =?iso-8859-1?Q?aafAD/Q2X7jBkXesEG+uD0aT1tq3hGNFw7hFy5RsbvZ+UqEGf1ocdz/xC3?=
 =?iso-8859-1?Q?LcUeaWyhqTUJd6rWtFGf2dNmhKRI2d/RxmPsotLuqjNBR1teZNPTxItZPQ?=
 =?iso-8859-1?Q?CPKza0YlmubRxSs2HiMt7NNOaRfahOkNVJtVqTayi6rSBkfhE7GAXuDHut?=
 =?iso-8859-1?Q?sTXFXktmJ257nhLznKteixyp1WDt5b5GQItwiCKlYo5Mu45maaDb3JbdET?=
 =?iso-8859-1?Q?2reuNUBk+klgN9rYSfv5X4eFl+O4UX4K8idofGSBMxniGg9dS1A1z5XwC9?=
 =?iso-8859-1?Q?rAZNPUF1SYKFAQtsEPS5Wj8Qt4592/Eg65ZCHP0MDgjIKR1DUxaW9CbLIR?=
 =?iso-8859-1?Q?fdyt0FwFc5ynAPOprzupxwklqzhjrA4MSgrLamrAftS+/YPQn4aHQLHgLK?=
 =?iso-8859-1?Q?+8TxJohJjkCRHmEwtCMkmm7w6Ft6swtx1VBW8TuaTLpBacfAguXD0U9kvz?=
 =?iso-8859-1?Q?J9wASAWYPCvwY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b9b85c-199f-4f3f-1fec-08db63623f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 12:09:42.5688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3c2a020d-f343-4ca1-b6ef-91768380352f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L46PiVynQ4eUvKM6DThAIW78hO75ANKsALfLNj7eO41m9uvj3cgRqeIs5u7FSOeYxcVq6KiZsEdd38ztzcr4pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0801MB7694

James,

> Hi James,
>
>> Hi Michael,
>> On 6/1/23 1:00 PM, Michael John wrote:
>>> Hi James,
>>>
>>>> Hi Michael,
>>>>
>>>> <snip>
>>>>
>>>>>>
>>>>>>
>>>>>
>>>>> Thanks James, that allowed iwd to preserve and see wlan1 and recogniz=
e it as
>>>>> an AP.
>>>>>
>>>>> ~> iwctl device list
>>>>>                                       Devices
>>>>> ---------------------------------------------------------------------=
-----------
>>>>>     Name                  Address               Powered     Adapter  =
   Mode
>>>>> ---------------------------------------------------------------------=
-----------
>>>>>     wlan1                 c0:ee:40:64:4a:1d     on          phy0     =
   ap
>>>>>     wlan0                 c0:ee:40:64:4a:1c     on          phy0     =
   station
>>>>>
>>>>> ~> iwctl ap list
>>>>>                             Devices in Access Point Mode
>>>>> ---------------------------------------------------------------------=
-----------
>>>>>     Name                  Started
>>>>> ---------------------------------------------------------------------=
-----------
>>>>>     wlan1                 no
>>>>>
>>>>>
>>>>> My last hurdle appears to be just bringing up an AP.
>>>>>
>>>>> ~> iwctl ap wlan1 start "testnet" test123456
>>>>> Argument type is wrong
>>>>
>>>> I'd need to see the debug logs, but this could be what others have
>>>> noticed where certain drivers don't like some of the recent AP mode
>>>> changes adding HT capabilities.
>>>>
>>>> Again, don't know for certain without logs, but you could try and work
>>>> around this potentially by using an AP profile:
>>>>
>>>> #file: /var/lib/iwd/ap/testnet.ap
>>>> [Security]
>>>> Passphrase=3Dtest123456
>>>>
>>>> [General]
>>>> DisableHT=3Dtrue
>>>>
>>>> Then, you can start the AP:
>>>>
>>>> $ iwctl ap wlan1 start-profile testnet
>>>>
>>>>>
>>>>> - Michael
>>>
>>> Here is some log information while using an AP profile.
>>>
>>> ~> iwctl ap wlan1 start-profile testnet
>>> Argument type is wrong
>>>
>>> ~> journalctl --no-pager -u iwd --since -5m
>>> -- Logs begin at Thu 2023-06-01 18:53:45 UTC, end at Thu 2023-06-01 18:=
54:19 UTC. --
>>> Jun 01 18:53:51 cm1sd iwd[8884]: src/agent.c:agent_register() agent reg=
ister called
>>> Jun 01 18:53:51 cm1sd iwd[8884]: src/agent.c:agent_register() agent :1.=
84 path /agent/14661
>>> Jun 01 18:53:52 cm1sd iwd[8884]: src/ap.c:ap_validate_band_channel() AP=
 using frequency 2437 and channel width 40MHz
>>> Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 00=
00: -114
>>> Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 00=
20: -114
>>> Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 00=
40: -114
>>> Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 00=
a0: -114
>>> Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 00=
b0: -114
>>> Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 00=
c0: -114
>>> Jun 01 18:53:52 cm1sd iwd[8884]: START_AP failed: -22
>>> Jun 01 18:53:52 cm1sd iwd[8884]: src/agent.c:agent_disconnect() agent :=
1.84 disconnected
>>> Jun 01 18:53:52 cm1sd iwd[8884]: src/agent.c:agent_free() agent free 0x=
35ff98
>>
>> Seems like DisableHT was not set correctly? With DisableHT=3Dtrue the AP
>> should not be using 40MHz channel width, it should use 20Mhz (no-HT).
>>
>
> This is what I have for the profile:
>
> ~> cat /var/lib/iwd/ap/testnet.ap
> [Security]
> Passphrase=3Dtest1234
>
> [General]
> DisableHT=3Dtrue
>
> ~> iwctl ap list
>                           Devices in Access Point Mode
> -------------------------------------------------------------------------=
-------
>   Name                  Started
> -------------------------------------------------------------------------=
-------
>   wlan1                 no
>
> ~> iwctl ap wlan1 show
>                              Access Point Interface
> -------------------------------------------------------------------------=
-------
>   Settable  Property              Value
> -------------------------------------------------------------------------=
-------
>             Started               no
>             Name
>             Scanning              no
>             Frequency             0
>             PairwiseCiphers
>             GroupCipher
>
> ~> iwctl ap wlan1 start-profile testnet
> Argument type is wrong
>
> I'll add this is with iwd version 2.3 and with Linux Kernel 4.19.231.
>
> Thanks,
>-Michael


After looking through the commit history I see the DisableHT support was
added right after the 2.3 release. I've updated to 2.5 and retried and
was successful at getting the AP up.

Thanks for your help James!

-Michael
CONFIDENTIALITY NOTICE: This message, including any attachments, contains c=
onfidential information intended for a specific individual and purpose. If =
you are not the intended recipient, you should delete this message and any =
disclosure, copying, or distribution of this message, or the taking of any =
action based on it, by you is strictly prohibited.
