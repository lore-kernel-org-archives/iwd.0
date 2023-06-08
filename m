Received: from esa2.midmark.iphmx.com (esa2.midmark.iphmx.com [68.232.137.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDA7947B
	for <iwd@lists.linux.dev>; Thu,  8 Jun 2023 14:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=midmark.com; i=@midmark.com; q=dns/txt; s=key1;
  t=1686232884; x=1717768884;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=cSIi/4dlBJmdRipsrBVZTkKL0sqbCbKaPiriAMyhojA=;
  b=WO4xf6H+HPDvny3T2WP6Qlvx6wYgOWTZwKDMUsJmFo4XQGsqaMNb3WRu
   bg0OgtfVsUzk3Jn3fcZ/8rebF+twwOPgTY0dUi1vJ/237Z6bStQ5B3ECc
   Jd/Z2+cdbR7Qf3D9LjrSIrZZ4GO5YYHdY0CD0vG4EcKrcTY9fD1YmGNC4
   w=;
X-IronPort-AV: E=Sophos;i="6.00,226,1681185600"; 
   d="scan'208";a="70152625"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.midmark.iphmx.com with ESMTP; 08 Jun 2023 10:01:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNWtEJ0KzeGC6bENR4HZt73Yev9I3ucyCTX/HMLxaZ9xBcrA/aHwlXyeb0bKmeZXyMKstyR8tvFyO24Pk3oUhSz/No0zQYkL7dYRHnjC77H5g8Uue1ua2QcGkyGR0p6iqdWGWTKRmWvZV1566kZrzRKhbyrzy4ivOjN8n4odCcKVX1ugJVbZhs60Z9TcAQ9Z9d2TwAc+pWJGpED/tYFOnI6v1qCHjP9pZ6vFx3tngBoEfpPv3hfjHP4GyohiQWWz9UpyDXGzaJzBLOpfh7DKwJcwRg8287u9ovK1w5sviZfzzRa9hlBCbbRyU7l4fk9s+71Zo9nFbVJtxfATJI79pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnA7yZz55vODtuL+jmS7WdpS6XAKwtO4dZ5CUjU2tYA=;
 b=Rv0uVZgRK6kdoYkdAYBI/CKXVNtQTF25In4sN2kpXKO7zRtdySfILmafTRsA9M5YmPDwso7rx3Pn0/fLTTVkF1uH7xGyXdmBugeznCOafi3/LfzjM7ObnO/SRlp53XVFdsDVC7SPSkNmCblJQfx+/7+9GrNS9L5jm/J5eYVUXBeKUYgrc4oyOuueNy6UtVbK/9LaADdUUZX009mh85j4D0etwetUM7KSPPEwQ54XffSCNnQcV5SIG29n04DA904sgBOmJPqKRmZO0++nUOltZScNAokh8+0/do5vVkdX4wqV+nzdM3lEnPGZ2I+wV1FztNTBou1GAjuEu3mnkqynFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=midmark.com; dmarc=pass action=none header.from=midmark.com;
 dkim=pass header.d=midmark.com; arc=none
Received: from BY3PR08MB7220.namprd08.prod.outlook.com (2603:10b6:a03:365::15)
 by SN4PR0801MB7871.namprd08.prod.outlook.com (2603:10b6:806:1ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 8 Jun
 2023 14:01:11 +0000
Received: from BY3PR08MB7220.namprd08.prod.outlook.com
 ([fe80::533b:41ab:1b5b:7710]) by BY3PR08MB7220.namprd08.prod.outlook.com
 ([fe80::533b:41ab:1b5b:7710%7]) with mapi id 15.20.6455.034; Thu, 8 Jun 2023
 14:01:11 +0000
From: Michael John <MJohn@midmark.com>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Bring up of AP fails on certain channels
Thread-Topic: Bring up of AP fails on certain channels
Thread-Index: AQHZmhFyDLlZeiSnFEKt5E31PIosMA==
Date: Thu, 8 Jun 2023 14:01:10 +0000
Message-ID:
 <BY3PR08MB7220600D62E8C2FD1334253FAE50A@BY3PR08MB7220.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=midmark.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR08MB7220:EE_|SN4PR0801MB7871:EE_
x-ms-office365-filtering-correlation-id: d7604932-ee1c-4b82-b6a2-08db6828d084
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IbVf/jNUks/L2ElgYmIDcaYwJmWbHcfqcwPPZ/i6utm+rntDpTHI0pRbc3SnX9DUTzYyW/LfLSeyTPUu6NNGPwfveX8GhypLOS7Y5zUpTJwTJ1W6Ym+oFJAjbuqyDbogs3uUvvYgWoIoUJwaAWo4M3XPqF74GyOBNSmO6PFgZcY0DbykRmo2IfsUL3+AOgwO6wNqyPEPAsUKhNrzwS5uOoW3x3aHUQMT2yDYHms8QtC2VfFIUJsh0pbNHwYZZG8KY75RwOLUKDP6u4qiTm4L9mDq/wu1xcSH10Lw5JlOhKoNJRgdeSMtB56UietsvgKD6Mr8+SUgvnCOQ684mpJLrvEOHOPHn3T/xYp+QPav43JRhTLtX6MGGE/GJhAQzKXN+GHPbo0kukPcl5bmBY89AylYROitEQZF9rX+WUiWEwzLqtXPeDT+tDZLoUDwT9rk300Tl90RW3KiOxtDK2Vim1dprr6r98C4f/X50fl2QSPQNYrZJtbLY9tjqmjKtphUpCfVxWpB9fUpogD03xouvAh7QZaOAxNjsey2JNjb2kArSh24uuSwin76LCfeTCfEsrLytj8wts1Wnfz5jEoRM8qU6e2DxBW5PEI3jw0eiUhNU0dPPBerTrf9+ooyNqTB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR08MB7220.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(39850400004)(366004)(396003)(451199021)(91956017)(66946007)(8676002)(8936002)(5660300002)(52536014)(66446008)(66556008)(66476007)(64756008)(6916009)(76116006)(71200400001)(478600001)(41300700001)(316002)(7696005)(38100700002)(55016003)(122000001)(26005)(9686003)(6506007)(38070700005)(186003)(83380400001)(86362001)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ptZjzy7P/EF8Td0vvY2yUuErjy/x5njC3CWchsvK8zh3j6Sz8lxDI3eHJ+?=
 =?iso-8859-1?Q?KJWJgswLSi56ZUXZxUxj+fjU9JJ3LGCSqZgvm2d+SIzD0rhSmaQraeiiDI?=
 =?iso-8859-1?Q?Og9Ljk+7dtIha9pO2buq39N8Egnx3rG3uAjSEY2S3A/S7XtvHdmkGbW7h5?=
 =?iso-8859-1?Q?cvf8X4MoEdoH58F9TarpKdMv9jpiObEQrtS4li7L3ZbM5fxW56KgZQN7Xo?=
 =?iso-8859-1?Q?t+v4SLvfUeCnnERjWaGZaywmwwI23bp3CPM3sNu1419w8EW78jSw0es7Pl?=
 =?iso-8859-1?Q?3sFhcl7GYOLY2FclI2pDfQdNIDo9Li5DtV56BpcFBeOcSWxjVkMJ6OmT7M?=
 =?iso-8859-1?Q?GfmZaAUJYE6+61LCTDwpOKN8255q6BziZp2AGVb5LklFow82YWrey6VhFo?=
 =?iso-8859-1?Q?rFSM56+FJ6FSVpQb5+TlVQcBxgBErh7KsED8IwIlQ8V0ykYVTBVw75+zsM?=
 =?iso-8859-1?Q?j0dn8V8N07a+D7bDj3uSic7XuvAGqD5SK2RMC23Q1KO8UMwla4NKaRXddJ?=
 =?iso-8859-1?Q?zdxbPgLeR1MhhHCwayIe2da4Qy4eNZT1PTF+RwpZIVUKZP3LGvqoUmBA4o?=
 =?iso-8859-1?Q?2UpN3Et2Ot2+9cWsfy3KeqYVwE1PB8UnM9ez5BQQb6inemjYLzWbk4fBKt?=
 =?iso-8859-1?Q?86NjV8X3wPnx8UiV7IqPsyEZ5e1N5vTMlcfnKLwvW+dYC667V+tHsfYWQ7?=
 =?iso-8859-1?Q?tphQaZXlaHXGSiyeqnKVrFZsYlDxEDLdKRsltzarEt1gJ6oA1g4OtVw+6v?=
 =?iso-8859-1?Q?H/QEIKYuK7Kz8iTv1Wj3brbjVxwhpB7LMX4KCL7Yic38yWksN536wvUlbK?=
 =?iso-8859-1?Q?DjzThYfY95t4kekGbqA1R72pgVRsPdBOvU7Mw9YlhqZ/G7+6+ZqsVNV8/E?=
 =?iso-8859-1?Q?GoEcWkTb1xu+BgFCu1udiUHnfGPcuBLH+I37SC4hK6WXVq6EkO0kVkl7IB?=
 =?iso-8859-1?Q?ng9oqp2xZfH7spSkXdhr+oDp0zIzlfQ3FV8W7i/ebEN6Ta4vDCHaG283f4?=
 =?iso-8859-1?Q?E/8TA8fyONSpV1cmWewkEm7YtO7/lO++HrCnSalXoziUdjWzWN4EGRWvvo?=
 =?iso-8859-1?Q?269nx/r8XEaGji0U2vYpUjtpDyGhB9JKfb1lDsCM4RVaW6UEtfAaS1XFDj?=
 =?iso-8859-1?Q?uoKftYKEItelPcDnVTdll8gsYbC5BeVFJ4OGFFXZrlK8GEwsxJ460jhWBp?=
 =?iso-8859-1?Q?mZhSvRe4kosxacQLLXtT67WaTsk23vqNVuF9UL3lcMJ4Sai6kuLYm1EsiB?=
 =?iso-8859-1?Q?WZkbO7Sl+qkQs8KLMpkCyJNPmpn5njJ6/SZyTw3AWz1cQX1DPZVAiD/HW8?=
 =?iso-8859-1?Q?Uli96nN19DyuHYXSohjBYFPKtf6d86inqBGY/3/eVCEabputfZUsguzst+?=
 =?iso-8859-1?Q?3H6mtmPXmuIpESX1w6PNAn3WBVBNf2NqutnJeKtosJtzPm/ecbSO6zlVrA?=
 =?iso-8859-1?Q?7h5MBWbDJhaa/5EavdsjkBF4WIqYYmmBVfg/g753vsHoBKaCQvQy1cSI3g?=
 =?iso-8859-1?Q?SITOPDHNYdniXFypWTccMv3dBlw0cR/6+p+VohFVR+szsVBy3R+2bJhene?=
 =?iso-8859-1?Q?lc2h0Yca3LZPnT1ryTTdvlJ3fL+DQDdtp+Yqn98nIiwmjS/aSDa023Jfif?=
 =?iso-8859-1?Q?+QUhw5l6wqX70=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d7604932-ee1c-4b82-b6a2-08db6828d084
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 14:01:10.8842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3c2a020d-f343-4ca1-b6ef-91768380352f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sIBa9Km7pY5Z/DFVypYV1ytOyJgwHcXzYKcixUlf636lRCNhwehEGfa+pKUseUo8b3T2I/oNxsk/+VOH2iubww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0801MB7871

Hello,

I'm trying to bring up an AP and ran into an issue where iwd
will fail to do so. My AP profile is below and I'm trying
to bring up the AP on channel 64 but iwd gives a failure.
If I change the channel to 6 iwd is able to successfully
able to bring the AP up. I'm curious to why it fails
if the channel is 64? The reason I needed channel 64
is because my radio requires the AP to be on the same
channel as the STA when in AP+STA mode, and me test
network  for the STA is on channel 64.


~> cat /var/lib/iwd/ap/470034.ap
[Security]
Passphrase=3Dmyphrase
PairwiseCiphers=3DCCMP

[General]
DisableHT=3Dtrue
Channel=3D64

[IPv4]
Address=3D10.42.0.1
Netmask=3D255.255.255.0
Gateway=3D10.42.0.255
DNS=3D10.42.0.0
IPRange=3D10.42.0.50,10.42.0.60


~> iwctl ap wlan1 start-profile 470034
Argument type is wrong

~> iw dev
phy#0
        Interface wlan1
                ifindex 6
                wdev 0x3
                addr c0:ee:40:64:4a:1d
                type AP
                txpower 23.00 dBm
        Interface wlan0
                ifindex 5
                wdev 0x2
                addr c0:ee:40:64:4a:1c
                type managed
                txpower 23.00 dBm


~> journalctl --no-pager -u iwd --since -1m
-- Logs begin at Thu 2023-06-08 12:39:15 UTC, end at Thu 2023-06-08 12:55:0=
4 UTC. --
Jun 08 12:55:00 V2470034 iwd[1229]: src/agent.c:agent_register() agent regi=
ster called
Jun 08 12:55:00 V2470034 iwd[1229]: src/agent.c:agent_register() agent :1.1=
93 path /agent/2814
Jun 08 12:55:00 V2470034 iwd[1229]: src/ap.c:ap_validate_band_channel() AP =
using frequency 5320 and channel width 20MHz (no-HT)
Jun 08 12:55:00 V2470034 iwd[1229]: src/ap.c:ap_get_gateway4_mac_cb() Error=
: Operation not supported (95)
Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type 000=
0: -114
Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type 002=
0: -114
Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type 004=
0: -114
Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type 00a=
0: -114
Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type 00b=
0: -114
Jun 08 12:55:00 V2470034 iwd[1229]: Could not register frame watch type 00c=
0: -114
Jun 08 12:55:00 V2470034 iwd[1229]: START_AP failed: -22
Jun 08 12:55:00 V2470034 iwd[1229]: src/agent.c:agent_disconnect() agent :1=
.193 disconnected
Jun 08 12:55:00 V2470034 iwd[1229]: src/agent.c:agent_free() agent free 0x1=
d57d18

Thanks,
Michael
CONFIDENTIALITY NOTICE: This message, including any attachments, contains c=
onfidential information intended for a specific individual and purpose. If =
you are not the intended recipient, you should delete this message and any =
disclosure, copying, or distribution of this message, or the taking of any =
action based on it, by you is strictly prohibited.
