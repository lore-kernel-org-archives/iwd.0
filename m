Received: from esa1.midmark.iphmx.com (esa1.midmark.iphmx.com [68.232.141.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82687107B1
	for <iwd@lists.linux.dev>; Fri,  2 Jun 2023 11:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=midmark.com; i=@midmark.com; q=dns/txt; s=key1;
  t=1685705966; x=1717241966;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=r9HYAY5fw/eqBrRsvVLl7y60BDoufYH8JaBRFw3B98w=;
  b=XmEaRrRLLnOlSzB4aUnBENOR9fF0yD+DeWjYVtm6z7xrXz6IbbObNYJg
   Gno+GF8rZl4kPjFe6ihe+PGuSDtDlgaB88y69ZQInIXdVt+KMB4+Bq1S7
   bFq+oZyzABILrjtRrNQnLF/iVlcK3i7kQD9mHQHs5t0uPeH/7s9J4wlE9
   w=;
X-IronPort-AV: E=Sophos;i="6.00,212,1681185600"; 
   d="scan'208";a="73366604"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.midmark.iphmx.com with ESMTP; 02 Jun 2023 07:39:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmxbQlqy+knwocTBQUUcxeZ84YhEvfMzsefJlRyUKq7IKepPVfAcMErw9dWEFYGBpXjsW8zjuKzMYpECI1R2q+HwU6rIujpfr3NmUFLuN/TwXlwd2P0SqIRaPkBG2L0l/wUkTSXMkSnUSaY+zIO47gfppjF0AjkK/WcqyavVW9li5bHJB9O8ev4as6sBhvi2RFa51AcoxRUEIsgNLFqoJ6jLQytzN1MHWUSon5TMRyvau1sTy81x2ZXVfJWj2aiALEFfDhfO3ykoSlkDDMZMNHkZXpY9oJPjU7MZhH9721JGVocNxPvltuLMilYB+YAa84G9ctIjjWUmpj8PglAsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OkXM8bLSpBUlAMSfNiuV3kFl1NShP0/0Jjv2Zw1dp4=;
 b=g50+DTYyhQUSEXPpZRZgXvuyB27StjLxGO0Tv8XnEo8d5KckZwAT0PyOIGtYgtkWR9Mxatt+jDq63nEaExEyhglhBwDl/YZL9j/7xPfXymBdbkSdx7Pa7Ph+Yn5/nkrH09iL5k+zdyV+AnTMjs/3ajt9lLgkMPlKuTSjtrtXQxL9AfL+vejphrAy6X1qKT6F2naTSQtkzWt2yEuFcmwItYaZSj5wDphBc/XbneK8djSzK+uHjPvXe1NfLmUIe0BTBqhRq3VarkGqdFTswnYb+lBuGb4gvB/BhV2i9Us9VUKVdeVWysc7LVEZrsbrM2PQsSuCbZhFxWKy1GUnrrV1qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=midmark.com; dmarc=pass action=none header.from=midmark.com;
 dkim=pass header.d=midmark.com; arc=none
Received: from BY3PR08MB7220.namprd08.prod.outlook.com (2603:10b6:a03:365::15)
 by SJ0PR08MB6669.namprd08.prod.outlook.com (2603:10b6:a03:2df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 11:39:22 +0000
Received: from BY3PR08MB7220.namprd08.prod.outlook.com
 ([fe80::533b:41ab:1b5b:7710]) by BY3PR08MB7220.namprd08.prod.outlook.com
 ([fe80::533b:41ab:1b5b:7710%7]) with mapi id 15.20.6455.026; Fri, 2 Jun 2023
 11:39:22 +0000
From: Michael John <MJohn@midmark.com>
To: James Prestwood <prestwoj@gmail.com>, "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>
Subject: Re: issue using virtual interface with iwd
Thread-Topic: issue using virtual interface with iwd
Thread-Index:
 AQHZlIs8y9omM24b0kmI/1XiEYh7sa92DDeAgAAC/ACAAALUT4AABzsAgAApeXWAAAOaAIAAEzuBgAAJu4CAAQD+4Q==
Date: Fri, 2 Jun 2023 11:39:22 +0000
Message-ID:
 <BY3PR08MB7220F8324CED704A01BE5946AE4EA@BY3PR08MB7220.namprd08.prod.outlook.com>
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
In-Reply-To: <7c72c879-98c1-2df3-e676-540ee1463cc9@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=midmark.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR08MB7220:EE_|SJ0PR08MB6669:EE_
x-ms-office365-filtering-correlation-id: 289f5f10-1727-4c4e-9d58-08db635e0287
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 r0Z3f2IBSatSmhSBM1v6hpfnPxc1dBaovjiQahuHYVz13py7sXVsKtstKgl5/MUsDsQApE/K3WHeyFatnBareccn5w+xu50Bg3gucPU+DKMdW9ckyH6R4bAlPk5qZGeHSFF+VtD68CIAKCsfnXddSJQg/FMgpNHlHbtFODKyJyCrpJJ3OP/X860ZC/2eUZlJVDhPX0+xcVs4pVruPOylWanzWhwDSgiTow48lzjz2ThSbCY9PsitZ99vibunE3eGV2jHK8Ou56UOvyUdSxdM0zoz3Apu11JVEn7mJ/zFmTxguhRj1LsffKOVKUF4Bfgz60c/I9HYSkX1RqnVD790UZzMrcvWQomQdq65nDFfzFxRrimkN18WF3q/Ea7xnhqDw4xMgS747VG6GCZnkDtdc2UlErmDQ/4WoQk9YVXpj3rHrO7pTX3RwwBrtsMOkDsAjkin0Xqjs/m6cCc9koVw1fzasaTbb7BhoWm9d/HciKgvw2bv7eiq70y5whi76eATwwsM5AUq5p/PcJVOACkO9n5hg1f6FNDojVb5OK7gYXBzvLIzdMR2ZJhmP6NSz4M4Ec8SGCVo11g22mjXamAmjuB4L1xPXyplgkr5ktwaiY96CHKsm2B7KeBk1UsMWgLIeiv/doWpvvoEAAqH8d4biQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR08MB7220.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(396003)(346002)(366004)(136003)(376002)(451199021)(86362001)(478600001)(9686003)(26005)(71200400001)(7696005)(55016003)(6506007)(186003)(33656002)(83380400001)(2906002)(122000001)(316002)(38070700005)(66476007)(64756008)(66946007)(41300700001)(66446008)(66556008)(76116006)(91956017)(38100700002)(5660300002)(8676002)(8936002)(110136005)(52536014)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gOWcdwuobWCRt6Lj8H+YWgovlp9aVXzN/vQSX8pjxcmDDBV4+JXsautrr4?=
 =?iso-8859-1?Q?AS9CGW0NMzutregU/cN5gMu2r3YUUn0IF1IFAp0Nf9HLstwVV6Hwa7EhSQ?=
 =?iso-8859-1?Q?JNRlr0ohAtbiohwwI04OFv7+6BZmiAHExYQ81WXgUaDTdkzbTlBBuWc3Z5?=
 =?iso-8859-1?Q?Po7kGJCiFdlovnxnCMGsWCV9PUf2/QI4aByLeETn8+X7Gs6Zpe76o9EmWR?=
 =?iso-8859-1?Q?QefyqKvK1FepU9nefxZrubqbpsw5Oa9g+xKc+V+vUQObAqvjBPOPC5NN1C?=
 =?iso-8859-1?Q?1KZK/VPZHIjL8Cu5XbMqUhUzc6yI+rbQ7ya/zmQ7nPYCMYVQ2ekhT+o1+W?=
 =?iso-8859-1?Q?Aj1fM3QCjKtK01isZQ6V6nonOW+37aRrpWqQjwf0aEH9Ef/ffvRHhzPqXH?=
 =?iso-8859-1?Q?zOk6KPNxSRja3z/xrNp43Yijcn7Y+T7r+g/o7DxtIryEanRMHQr1BN7JhJ?=
 =?iso-8859-1?Q?7cH+hePmxNf68k35QHmFxHBSH31JGAcsu7be/MquQ1CnOgJYwUD2/cLPBN?=
 =?iso-8859-1?Q?PfMixW75DMhAJ2STXl+3ncNXjbBfpXPEdf8m4q+sXKDajOKhcGNPlqLvtY?=
 =?iso-8859-1?Q?myn428E1szV3pZpGuVpN41SJ6E6ppf7hZgHv8WJKaO6vzYZuV+iwp98oJP?=
 =?iso-8859-1?Q?b7tXrdDF5CM/7R+MFEvkdVQiiCs9pFtr4JnzFAoIJRvNna7CYQSgtpkL6M?=
 =?iso-8859-1?Q?9Fju+UbNtynjrs1tSteo31+MwYHF1zzvfwh9SFKMz5a1fx23mUIV/gz3Vx?=
 =?iso-8859-1?Q?p+vwFuuVCfZq2OOEUvFwRJJy4uhnCDQpb/l4S4Jk2BMyTkHaa5LGr5oPEY?=
 =?iso-8859-1?Q?KMHBaP/JZyOST3nKllLBpR5GFkj+RcLWjjT03AiBD7LSLIJU5DXTjdR5cL?=
 =?iso-8859-1?Q?SW8Tw8gCNxL/S6Wk+KiCbVPyqZNRxJW2TsKBtu8nC800BlLruu3+dhyrbY?=
 =?iso-8859-1?Q?L8TItJJi44PNiuFmOcQsqEVboXfk561AxPFHu6DfRd2Yuu2Xn0BYZdW5pZ?=
 =?iso-8859-1?Q?hbOYdfYoHnZYoLne6Pt8SBVZMVmoJWeyqAcDfJpOK8lqrw8wyZMHNVwv6I?=
 =?iso-8859-1?Q?ITxOKz+V1oUfQ05LVJ6iFtGohYAhQLTVvP7R0mz7WGXJ32Qg4nsJvcLpsP?=
 =?iso-8859-1?Q?PT4hK4cWD3LBST2PSry6IX0SCIa4ipKadL5SsL3KeaA2VLUZz6uWdBphTd?=
 =?iso-8859-1?Q?0k+xiDzfSz5SnnJ34Qm48iBFi4iCIYFdeB3YYT0leSWvnzET6YoyXCOCah?=
 =?iso-8859-1?Q?J9zFhr/qnI5f/XAk3VehXXz8e81BtXX1M0suYW9mIeMhQAuUdNf3TogBQX?=
 =?iso-8859-1?Q?+PYwO1eoiYjNvmJQ+HsTdTTedOEYFa8TiFpiTaqWkkeD9hXPhV5ya83iRO?=
 =?iso-8859-1?Q?qd3+uEl0/DfYUl+1C7xj79l6c8JLWFWVp/fItHS067Vuk2d73zvHhsGIf4?=
 =?iso-8859-1?Q?r9rNX7xpUFwpXdOB1BcilZsRXLLbJF1BudL5esZHQHv7x1ng3ed4m9KxX3?=
 =?iso-8859-1?Q?v86Y9qDqUM1R2PJdMFx0GApn4wTtBLJLeSmarr30n6oP81kVfXX5NDitaa?=
 =?iso-8859-1?Q?njPubN9BCSO4bkY6ES83G0o95PrW2OgpJ9gh/59DSfvW5DdZHV7lkTZux2?=
 =?iso-8859-1?Q?bnLW0zfMuwTmo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 289f5f10-1727-4c4e-9d58-08db635e0287
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 11:39:22.3245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3c2a020d-f343-4ca1-b6ef-91768380352f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TP5sr4GzcTXnURIJRezmdiO/pqZXQlLCHfRiAWRvZSoZQ/hiuwCzKGgqaQapaoB4Mi0/vaCFw1D/RmTJwX0A+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB6669

Hi James,

>Hi Michael,
>On 6/1/23 1:00 PM, Michael John wrote:
>> Hi James,
>>
>>> Hi Michael,
>>>
>>> <snip>
>>>
>>>>>
>>>>>
>>>>
>>>> Thanks James, that allowed iwd to preserve and see wlan1 and recognize=
 it as
>>>> an AP.
>>>>
>>>> ~> iwctl device list
>>>>                                       Devices
>>>> ----------------------------------------------------------------------=
----------
>>>>     Name                  Address               Powered     Adapter   =
  Mode
>>>> ----------------------------------------------------------------------=
----------
>>>>     wlan1                 c0:ee:40:64:4a:1d     on          phy0      =
  ap
>>>>     wlan0                 c0:ee:40:64:4a:1c     on          phy0      =
  station
>>>>
>>>> ~> iwctl ap list
>>>>                             Devices in Access Point Mode
>>>> ----------------------------------------------------------------------=
----------
>>>>     Name                  Started
>>>> ----------------------------------------------------------------------=
----------
>>>>     wlan1                 no
>>>>
>>>>
>>>> My last hurdle appears to be just bringing up an AP.
>>>>
>>>> ~> iwctl ap wlan1 start "testnet" test123456
>>>> Argument type is wrong
>>>
>>> I'd need to see the debug logs, but this could be what others have
>>> noticed where certain drivers don't like some of the recent AP mode
>>> changes adding HT capabilities.
>>>
>>> Again, don't know for certain without logs, but you could try and work
>>> around this potentially by using an AP profile:
>>>
>>> #file: /var/lib/iwd/ap/testnet.ap
>>> [Security]
>>> Passphrase=3Dtest123456
>>>
>>> [General]
>>> DisableHT=3Dtrue
>>>
>>> Then, you can start the AP:
>>>
>>> $ iwctl ap wlan1 start-profile testnet
>>>
>>>>
>>>> - Michael
>>
>> Here is some log information while using an AP profile.
>>
>> ~> iwctl ap wlan1 start-profile testnet
>> Argument type is wrong
>>
>> ~> journalctl --no-pager -u iwd --since -5m
>> -- Logs begin at Thu 2023-06-01 18:53:45 UTC, end at Thu 2023-06-01 18:5=
4:19 UTC. --
>> Jun 01 18:53:51 cm1sd iwd[8884]: src/agent.c:agent_register() agent regi=
ster called
>> Jun 01 18:53:51 cm1sd iwd[8884]: src/agent.c:agent_register() agent :1.8=
4 path /agent/14661
>> Jun 01 18:53:52 cm1sd iwd[8884]: src/ap.c:ap_validate_band_channel() AP =
using frequency 2437 and channel width 40MHz
>> Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 000=
0: -114
>> Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 002=
0: -114
>> Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 004=
0: -114
>> Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 00a=
0: -114
>> Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 00b=
0: -114
>> Jun 01 18:53:52 cm1sd iwd[8884]: Could not register frame watch type 00c=
0: -114
>> Jun 01 18:53:52 cm1sd iwd[8884]: START_AP failed: -22
>> Jun 01 18:53:52 cm1sd iwd[8884]: src/agent.c:agent_disconnect() agent :1=
.84 disconnected
>> Jun 01 18:53:52 cm1sd iwd[8884]: src/agent.c:agent_free() agent free 0x3=
5ff98
>
> Seems like DisableHT was not set correctly? With DisableHT=3Dtrue the AP
> should not be using 40MHz channel width, it should use 20Mhz (no-HT).
>

This is what I have for the profile:

~> cat /var/lib/iwd/ap/testnet.ap
[Security]
Passphrase=3Dtest1234

[General]
DisableHT=3Dtrue

~> iwctl ap list
                          Devices in Access Point Mode
---------------------------------------------------------------------------=
-----
  Name                  Started
---------------------------------------------------------------------------=
-----
  wlan1                 no

~> iwctl ap wlan1 show
                             Access Point Interface
---------------------------------------------------------------------------=
-----
  Settable  Property              Value
---------------------------------------------------------------------------=
-----
            Started               no
            Name
            Scanning              no
            Frequency             0
            PairwiseCiphers
            GroupCipher

~> iwctl ap wlan1 start-profile testnet
Argument type is wrong

I'll add this is with iwd version 2.3 and with Linux Kernel 4.19.231.

Thanks,
-Michael

CONFIDENTIALITY NOTICE: This message, including any attachments, contains c=
onfidential information intended for a specific individual and purpose. If =
you are not the intended recipient, you should delete this message and any =
disclosure, copying, or distribution of this message, or the taking of any =
action based on it, by you is strictly prohibited.
