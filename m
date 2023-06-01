Received: from esa2.midmark.iphmx.com (esa2.midmark.iphmx.com [68.232.137.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D9147017
	for <iwd@lists.linux.dev>; Thu,  1 Jun 2023 18:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=midmark.com; i=@midmark.com; q=dns/txt; s=key1;
  t=1685644096; x=1717180096;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=5KE3pOTDJzAuw9polliy5Wb48Cn3ORLKACFHP6Iy7FY=;
  b=Uxtmzu1V1DEKLid4u6WX87Di2+KrplJSQcngdj8uFEk9bQsAuDbz35Qn
   trI7gZHVH7YejOUkAKzX6mrV9G7RK2+3GkD4zJnZUV19quh+v7qe4a/RP
   mZCJ8xkZdyZD7iF/+PmitEUZyRVj5jNYDWm0e/rR/wbOF3oMiIjkI7Yr9
   k=;
X-IronPort-AV: E=Sophos;i="6.00,210,1681185600"; 
   d="scan'208";a="69948631"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.midmark.iphmx.com with ESMTP; 01 Jun 2023 14:28:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSET0wui6fbCWlkuf/mBPhtJ0WRnhYuMa93eWaNP6Z/FnKD5/qsUJadDX7vmEsPW9Rw0wGzp83Eddgf/1+/E4KQEAH268/TuOs67x2wmIGKajMfB3C4LqXMw3X8xMAJR9hdlw/FEPqPUStMnHuiXevR3/B+RQT4mWTftWw79EjxbySxbj51tVnqVMMJjIon5r1rWtZunZtwXdisy3OgmtbheIxQaq88GGj8fOLClQF/9I+THg7vdHEbUKesMHloNpQ15puod4vI4IOmoXukrpB8Llb3WNo04OrX/2MYhRvIG10AINWB9oay08gzW+14/ttnnbo3KvTUF5QpjJp58Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4IPWKQ72wN+CryNER/hJnZwN5e/lU0cjeuTVXNEH7A=;
 b=bSn/xQMeDmhazVaNsciexv0lX8I8Nzpr0may7T944bnPw7lO3fRYJnN7yobS4pjghtkOzfOchE80+1aAcGUgD6eeN774HAT3SYNavFPlW692psJGX76Q0vZYVwAzb6vuNcGwhYd7sQ7Eerl5RQCYOvsuiAJyUWLNo0zKlGYRbjmPKD/QOGXNdeVtqZ+BEzvA9zINke+5h6QBNlYLolMRGTppLy9/86uvBt7A0oNaLJknKwtEx9Ccz3sRwsIh2mYJX34CYUyk+HphT4dk20UwU233LWYiJfbn9YF4rHH5bmZ4neKuT7RLLGIpvpdrJVlM5mfxFdNukhkMI1Nsc9mVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=midmark.com; dmarc=pass action=none header.from=midmark.com;
 dkim=pass header.d=midmark.com; arc=none
Received: from CO1PR08MB7221.namprd08.prod.outlook.com (2603:10b6:303:da::23)
 by BN8PR08MB6322.namprd08.prod.outlook.com (2603:10b6:408:d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Thu, 1 Jun
 2023 18:28:07 +0000
Received: from CO1PR08MB7221.namprd08.prod.outlook.com
 ([fe80::1616:b869:5ef6:3d7f]) by CO1PR08MB7221.namprd08.prod.outlook.com
 ([fe80::1616:b869:5ef6:3d7f%3]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 18:28:07 +0000
From: Michael John <MJohn@midmark.com>
To: James Prestwood <prestwoj@gmail.com>, "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>
Subject: Re: issue using virtual interface with iwd
Thread-Topic: issue using virtual interface with iwd
Thread-Index: AQHZlIs8y9omM24b0kmI/1XiEYh7sa92DDeAgAAC/ACAAALUT4AABzsAgAApeXU=
Date: Thu, 1 Jun 2023 18:28:07 +0000
Message-ID:
 <CO1PR08MB7221B49078929FDBB79773B7AE499@CO1PR08MB7221.namprd08.prod.outlook.com>
References:
 <BY3PR08MB722000E74E402E1C188F35E9AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
 <0e37cdc7-5d9e-f3b3-eb98-d549d9a69d6f@gmail.com>
 <17dd827c-a2de-b7ec-75de-99d0b17cf6f3@gmail.com>
 <BY3PR08MB7220AB646467DBCE1A4B7433AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
 <eba9839e-55ab-d532-c52f-c58cac465ea1@gmail.com>
In-Reply-To: <eba9839e-55ab-d532-c52f-c58cac465ea1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=midmark.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR08MB7221:EE_|BN8PR08MB6322:EE_
x-ms-office365-filtering-correlation-id: 79c8a5d7-88f3-48f3-da78-08db62cdf233
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Qc+Ly2D4zgbGlSOLdiiXlFx+61+qw3kIY+VadQvuT7UjExSpEqF6fvM5g33+2h6ek7z4t+6+6oJmXEBjrnqClLEykrjM6FyMZmUp1CnCtBOxJBQLt4zqAc7DHFKOze7Swblf/z8h4ERptXbEuRvCayLxNXjOZkIeVafhevAVzWgi6bzY1WTu/YX9tTzBDfB4bx+0DLW948qUKLZcN7/8Vs3gciB6Y/vqU93kr87SsfiSb5KYkisyqo3j3otjfTGO5I01js6DN3+z5PR9Q3itt0B8cTtiKbmXciM8a5rW1iiCvRoxjUTIi6B89dheBpEEeSg7vRGAkyzf95pCAP0wYsWPf+s/ZpdMg5p6T1GcEGLRYpWIf6HT+YIzOCKqc9Ox/xaArBbeLeLOk531gPmt9jFNA8tLBijRubsK+UBEtva5RfydR0EF6SaCYRSQ0VaMW29i8o//QBF9+s+vnkw5+r1Biz9AkT2F81TTTZjMqOcczatJfDksrjvZEbd20yWmM4EfC01YII9U7PqjG/ysKLkCCR1uLpy6c/oDUZyoGRMagGZN6QfgQiVhPZFPErLnlo/26oOI+O6LNwYNHMLcMkGAl0rY/kpSZSgRL8E1Y6GSu4Q1UDAYwGd1e5VjH2Du
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR08MB7221.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(376002)(366004)(346002)(396003)(136003)(451199021)(5660300002)(122000001)(8676002)(8936002)(38100700002)(52536014)(53546011)(83380400001)(9686003)(6506007)(26005)(2906002)(186003)(55016003)(316002)(7696005)(64756008)(66446008)(66476007)(66556008)(66946007)(71200400001)(33656002)(41300700001)(86362001)(38070700005)(76116006)(91956017)(110136005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VmNTnsJtThH4IBioH0VQ0F74eJUA/55cshwTCko9l60akjUAPAFyUMod5U?=
 =?iso-8859-1?Q?nP9J3JOB4SfKhJ5X7h+NjIHoQErQB5063y/r9UixL2irNzPjXfoctLehTT?=
 =?iso-8859-1?Q?aQeThAX6NfLTtm9809n671xkHmgWwdPnt36qpPmmSp57Plj2ykontc0/ke?=
 =?iso-8859-1?Q?4fG7glfqyVttXpbiBfZ9X8Wh7vbgP9k1EpGEBWoZZrKAY+S05iGhCL07pX?=
 =?iso-8859-1?Q?9pZai1VyRCOMDdXwYBC8yh9XJ3dYehv3c0J7HfYllhsZEEHGmKrXmAT3nn?=
 =?iso-8859-1?Q?z9W3XUCQlOsAHIxOrjao89JTgM7Nn1AAlMpNwX/ohPGh6qPpM2Rnjc9mLi?=
 =?iso-8859-1?Q?2EHQ0+CFLGDxv9Q5o/TRYlmp3vcHBee4H0/rFtwnZPZ9N6PPJAJgfDcFn+?=
 =?iso-8859-1?Q?oXyiF6GgR2lIJatohgIvsYG9LkpJfYsKy/w0n0BYSHJqknt+NvSBUrxExp?=
 =?iso-8859-1?Q?XjCJ9s/Vp7ZrUB/sTLQsD416CgDsvf7vZ8MwCLX4qwZSAJuIahKwhpQ0Di?=
 =?iso-8859-1?Q?mNmnV9ZmrEdjSBMZAv7ciU/b1gpA6HBTMu5dDnLBGTcGV1C+6+D8wsgchm?=
 =?iso-8859-1?Q?t2Ui+Mrr61CjvZ6w5YORRRkYftryiNEWLDbew552JiFWt8x4vgNbZMBojr?=
 =?iso-8859-1?Q?hF8eb9J77X1FuGTd+Kyl93NAkL+9rVJN/OmJWyZmaUrXiNsRQ+7DLdbHU8?=
 =?iso-8859-1?Q?lpbQQriKoPhuLovDVzy0q6FtrXt6kcde5MFvTe9jLdGlEQ5QtT9v4HzgSV?=
 =?iso-8859-1?Q?mHzgn9fpqIcV3BN0IsO+7lud3Ixx3nGp64etkFhggCpxWQGnqGIfju9Anv?=
 =?iso-8859-1?Q?l0ZGsrmDNU2iVqu3XU9ooAOo0Wn8ZzyhnyY2YEq+6kutimYK9+JNZ3+w2Y?=
 =?iso-8859-1?Q?ugh5TSD8KhxUJTWX2gy2et4ZyCHRZwc74UgaZNNvzmsvCGIzSRgTuUH/Qx?=
 =?iso-8859-1?Q?IeL2YZW3pi7b3YPnLF1jnVgNQxbzT0TebzmJGBJvgblFvcuNu3hvNGjtKv?=
 =?iso-8859-1?Q?96Hp98W8ItLDbCpkDvM4klBf9070cCGt3bcZEToQskuea1xMifIv/wzCRQ?=
 =?iso-8859-1?Q?hU4EDJ6Ipqe0NiXqU4IuciXYKgwYBwNVgUzffkw0ZMOkFot/IopbrC6chd?=
 =?iso-8859-1?Q?bF4h0aKVgvTUnhnADnOCeZTWjlgbsr9OpPcKVG00j2m6Ldh+VGdDM9vwWr?=
 =?iso-8859-1?Q?vrVc8UDtcrD/Dtbsw738NjHkA0s/Ii/wqivuqaSwzvNag8HpYwcTXleFsD?=
 =?iso-8859-1?Q?PthE6iq0YVw79BE4Tr6FV9FhcpPvYOjduzYMhK3dY4jbE7HHYjq44f6pxk?=
 =?iso-8859-1?Q?QNtD3g+tGap+DGhjiCkzYWOgfAf/MrXq4nvzHpfl7+5SgDPQa+5ZAFmFB9?=
 =?iso-8859-1?Q?+x7qmkbAyPZNo0sYoT61WsOSJzjLBn1OPbTVFShqmiN/QFFGsJkXBOABT+?=
 =?iso-8859-1?Q?hKewadtZelHj6vw1ugkuTSfvwcYTG51Fy85ElyAU4gH75WAUlByE4SG56q?=
 =?iso-8859-1?Q?91HAcnnljw6fMYtxHWgihUH5fCnXgGIltRU5l/y4tofA9bn0ET/rP2rUeV?=
 =?iso-8859-1?Q?71I3dqm09N96TLVtfRmiMfVOxvdAtuhIK/QztC62qHZpLazYTFN9Vmfn7K?=
 =?iso-8859-1?Q?Cn88B7WiX4sCs=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR08MB7221.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c8a5d7-88f3-48f3-da78-08db62cdf233
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 18:28:07.4011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3c2a020d-f343-4ca1-b6ef-91768380352f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ESfEwP5Gre3+aDj0pB4dWeHbnIVF7W6lQRAbwM9TmnGOXr//9Cg6/LXcmZikfDh8sG3PvUO58TxCvpHEV8c1wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR08MB6322

Hi James,


on 6/1/23 11:53 AM, James Prestwood wrote:
> Hi Michael,
>
> On 6/1/23 8:42 AM, Michael John wrote:
>> Hi James,
>>
>> On 6/1/23 8:06 AM, James Prestwood wrote:
>>>> Hi Michael,
>>>>
>>>> On 6/1/23 6:17 AM, Michael John wrote:
>>>>> Hello,
>>>>>
>>>>> I'm having an issue getting iwd to recognize a virtual interface.
>>>>> Using 'iw' I've created a virtual interface called wlan1:
>>>>>
>>>>> iw dev wlan0 interface add wlan1 type __ap
>>>>>
>>>>> This leaves me with the following two interfaces:
>>>>>
>>>>> ~> iw dev
>>>>> phy#0
>>>>>           Interface wlan1
>>>>>                   ifindex 8
>>>>>                   wdev 0x5
>>>>>                   addr c0:ee:40:64:4a:1d
>>>>>                   type AP
>>>>>                   txpower 23.00 dBm
>>>>>           Interface wlan0
>>>>>                   ifindex 7
>>>>>                   wdev 0x4
>>>>>                   addr c0:ee:40:64:4a:1c
>>>>>                   type managed
>>>>>                   txpower 23.00 dBm
>>>>>
>>>>> When running 'iwctl' to list devices and APs I'm not seeing wlan1.
>>>>>
>>>>> ~> iwctl ap list
>>>>>                             Devices in Access Point Mode
>>>>> ---------------------------------------------------------------------=
-----------
>>>>>     Name                  Started
>>>>> ---------------------------------------------------------------------=
-----------
>>>>> No devices in access point mode available.
>>>>>
>>>>> ~> iwctl device list
>>>>>                                       Devices
>>>>> ---------------------------------------------------------------------=
-----------
>>>>>     Name                  Address               Powered     Adapter
>>>>> Mode
>>>>> ---------------------------------------------------------------------=
-----------
>>>>>     wlan0                 c0:ee:40:64:4a:1c     on          phy0
>>>>> station
>>>>>
>>>>>
>>>>> When previously using 'wpa_supplicant' and 'NetworkManager' this
>>>>> virtual interface (wlan1) was usable in AP mode. The radio does
>>>>> support AP+STA mode.
>>>>>
>>>>> ~> iw phy
>>>>>      ...
>>>>>           valid interface combinations:
>>>>>                    * #{ AP } <=3D 3, #{ managed, P2P-client, P2P-GO }=
 <=3D 2,
>>>>>                      total <=3D 3, #channels <=3D 1
>>>>>                    * #{ IBSS } <=3D 1,
>>>>>                      total <=3D 1, #channels <=3D 1
>>>>>      ...
>>>>
>>>> So this appears to me that you cannot do AP+STA with this adapater. Yo=
u
>>>> would need to see "AP" and "managed" in the same block e.g.:
>>>
>>> Actually sorry, I take that back. The interface combos always confuses
>>> me when I have to take a look again. The card in my laptop has a simila=
r
>>> combo to yours and I can do AP+STA:
>>>
>>> * #{ managed } <=3D 1, #{ AP, P2P-client, P2P-GO } <=3D 1, #{ P2P-devic=
e }
>>> <=3D 1, total <=3D 3, #channels <=3D 2
>>>
>>> In my case I was having issues because the virtual interface was being
>>> created in station mode (despite passing "__ap" when creating). Looks
>>> like yours is already in AP mode from the "iw dev" command so I'd need
>>> to see the debug logs of IWD starting up to see why the iface wasn't
>>> recognized. You could also try bringing both interfaces up prior to
>>> starting IWD.
>>>
>>
>> Attached is a capture of the log from iwd. I had a wlan0 and wlan1
>> created before starting iwd. I noticed after starting iwd my wlan1
>> in then gone.
>>
>> ~> systemctl stop iwd
>>
>> ~> iw phy phy0 interface add wlan0 type managed
>>
>> ~> iw dev
>> phy#0
>>          Interface wlan0
>>                  ifindex 15
>>                  wdev 0xc
>>                  addr c0:ee:40:64:4a:1c
>>                  type managed
>>                  txpower 23.00 dBm
>>
>> ~> iw dev wlan0 interface add wlan1 type __ap
>>
>> ~> iw dev
>> phy#0
>>          Interface wlan1
>>                  ifindex 16
>>                  wdev 0xd
>>                  addr c0:ee:40:64:4a:1d
>>                  type AP
>>                  txpower 23.00 dBm
>>          Interface wlan0
>>                  ifindex 15
>>                  wdev 0xc
>>                  addr c0:ee:40:64:4a:1c
>>                  type managed
>>                  txpower 23.00 dBm
>>
>> ~> systemctl start iwd
>>
>> ~> iw dev
>> phy#0
>>          Interface wlan0
>>                  ifindex 17
>>                  wdev 0xe
>>                  addr c0:ee:40:64:4a:1c
>>                  ssid MIDGUEST
>>                  type managed
>>                  channel 48 (5240 MHz), width: 40 MHz, center1: 5230 MHz
>>                  txpower 23.00 dBm
>>
>> Looking at the ifindex ID it looks like iwd created a new interface for =
wlan0.
>
> Ah ok, this is the problem. This is what IWD does by default. Since your
> managing the interfaces you need to specify them with "-i wlanA,wlanB,etc=
"
>
> This will make IWD retain the interfaces it sees and not delete them.
>
> So in your case:
>
> iwd -i wlan0,wlan1
>
>>
>> Thanks,
>> Michael
>>
>>>>
>>>> #{ AP, managed, ...} <=3D 2
>>>>
>>>> For example this adapter I have:
>>>>
>>>> valid interface combinations:
>>>> * #{ IBSS } <=3D 1, #{ managed, AP, mesh point, P2P-client, P2P-GO } <=
=3D 2,
>>>> total <=3D 2, #channels <=3D 1, STA/AP BI must match
>>>>
>>>> If you could get the debug logs of IWD starting up I could take a look
>>>> at those to see why the wlan1 interface wasn't brought up, but to me i=
t
>>>> looks like the adapter simply cannot support AP+STA modes at the same =
time.
>>>>
>>>> Thanks,
>>>> James
>>>>
>>>>>
>>>>> So I'm left wondering if 'iwd' supports virtual interfaces created
>>>>> with the 'iw' utility and if so, what am I missing?
>>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Michael John
>>>>>
>
>

Thanks James, that allowed iwd to preserve and see wlan1 and recognize it a=
s
an AP.

~> iwctl device list
                                    Devices
---------------------------------------------------------------------------=
-----
  Name                  Address               Powered     Adapter     Mode
---------------------------------------------------------------------------=
-----
  wlan1                 c0:ee:40:64:4a:1d     on          phy0        ap
  wlan0                 c0:ee:40:64:4a:1c     on          phy0        stati=
on

~> iwctl ap list
                          Devices in Access Point Mode
---------------------------------------------------------------------------=
-----
  Name                  Started
---------------------------------------------------------------------------=
-----
  wlan1                 no


My last hurdle appears to be just bringing up an AP.

~> iwctl ap wlan1 start "testnet" test123456
Argument type is wrong

- Michael
CONFIDENTIALITY NOTICE: This message, including any attachments, contains c=
onfidential information intended for a specific individual and purpose. If =
you are not the intended recipient, you should delete this message and any =
disclosure, copying, or distribution of this message, or the taking of any =
action based on it, by you is strictly prohibited.
