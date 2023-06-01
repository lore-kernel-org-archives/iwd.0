Received: from esa2.midmark.iphmx.com (esa2.midmark.iphmx.com [68.232.137.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A417FC08
	for <iwd@lists.linux.dev>; Thu,  1 Jun 2023 13:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=midmark.com; i=@midmark.com; q=dns/txt; s=key1;
  t=1685625436; x=1717161436;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=n/Eu3DF55KC2CU1f+oA56U3s8KZM2uh5hpfshyvvnR8=;
  b=n+U6cu6wyl+EqpqB4KIYt9HYq/LyoUlDlQxl7Abvihq9ZZ5MAzFDT5Ko
   u/ieMI7/6uv8WblaRSWfcTfL37w4nSrcDevTyUzSTBglePqfdlmy6TLlN
   53ZcBQ8yLVfd6FxMvZfE4kkI7Dfv+bp8TukHjscij+VZikLufNc3C1ycc
   8=;
X-IronPort-AV: E=Sophos;i="6.00,210,1681185600"; 
   d="scan'208";a="69931937"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.midmark.iphmx.com with ESMTP; 01 Jun 2023 09:17:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxB0JS9RjkaBlqHgvZql26VVXhk8BspW/mpvdqmomtE2Ai2y/cD0cgyqgBU3SfBLIqz/ufCOixugGMUoxTU3IUPOIyKfK2ACFShYa3L4jjx9mi1rYXeyZbs7w7Hdz8d/xsXo7ZD5iNWeuZd5Pu3KHLAm3QyqbPurnTnHitvnY12Bezr4WbFxoYDIAta/Kmn/dC/OsaRpWwltfUuXVvtCm/CHfoa8xLy+xn09GBHpnyIs11N7eW1RldpfxlsyfO4SDsa3qGPJ5Ncfirg8OTk7Mrjs2N4lVWLTQnrOM+c16aLJsnpomqpzxJ4uQQPDfiymkROZkxrsHGF0ACpo/BUkdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncKIZGTmxy+ClcGggtDpXVbnnHeML3Qkqc66vYcTSeA=;
 b=Q45L8w8HiFFksW68ZOpHj09pqaVIIxIf5vMmuaLCw/8YvIvPHW1GkelXSInXFFLf4iVA47iRo/h6kbT9Yx5XIY25/DZgmYUsqkmx1QJRqHJBAyx/VVrZhIq+ry/x0SQKjYSkZtYaap2Qe25VRF6LFR/cFw9juahM7/Igo/YkLpLWNaOQcf5bICDvPZdyZr65akdM7uwpm2Y1Gr3Gxkp5hN9Kvp7ymE2tg0cJFRWXqjMfCS0E2xoUSCQeIG/LgUqi7UYvXjmfbuq+XK0KFHhJ7oz7KbrHRoU/ZVw6Ez1+/JJmCWDpwBfsh+rpucqy95xOdU6SdbekQAEuXyTY1eomJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=midmark.com; dmarc=pass action=none header.from=midmark.com;
 dkim=pass header.d=midmark.com; arc=none
Received: from BY3PR08MB7220.namprd08.prod.outlook.com (2603:10b6:a03:365::15)
 by BY3PR08MB7217.namprd08.prod.outlook.com (2603:10b6:a03:36a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 13:17:12 +0000
Received: from BY3PR08MB7220.namprd08.prod.outlook.com
 ([fe80::533b:41ab:1b5b:7710]) by BY3PR08MB7220.namprd08.prod.outlook.com
 ([fe80::533b:41ab:1b5b:7710%7]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 13:17:12 +0000
From: Michael John <MJohn@midmark.com>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: issue using virtual interface with iwd
Thread-Topic: issue using virtual interface with iwd
Thread-Index: AQHZlIs8y9omM24b0kmI/1XiEYh7sQ==
Date: Thu, 1 Jun 2023 13:17:12 +0000
Message-ID:
 <BY3PR08MB722000E74E402E1C188F35E9AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=midmark.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR08MB7220:EE_|BY3PR08MB7217:EE_
x-ms-office365-filtering-correlation-id: 00b516a2-203a-4954-4bdb-08db62a282de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PFMVnQ+oBclc3cqY0/tcAUUUyBNqoxgddOWheDtU0xg9Aoth1CZ+ju5efD2zSjVK9Rzu0xcOZ8SBpLkXFJJK1Uu6zotav8VzpFj0mmeGuMhgxneuaHDWIeh4xsfCQQwa+x1gmQk/JyXAvj+3YYVMRrdK9P0WXIUBnPI3jVDQAQ28pDR1chSAxI6k/lI1nVXq73BdO3sh7eE8gBae3j/VvTaseOuLa7TVMtk4o0wy+95vrU+XlJ+nWg9zeQwXv0DkqgaGx4tC+q/m/P7mJuMmS6z6jsDEVP0NegKqn/+VbqxPGQQohrEdQQLroS6UOROJrYE2A9cNj+jQL2oMOP2sFGgJ3vz+m5JP+I0l3GDzdLT6Owzh/zBKdeD9dGVw27DnJWgRLlo86yCXXUz8tfveNk+IZShWLHfm6N8z86+7IPiAwB3W0CpCpj6hvnm+Op2KhjZyg4lIkLYJSxuN7zfaaHIV59k9Znmt/ttJJuen5EYTol9DkPWuh0F+F+VT9qQy0WuKZTQPHCgL6yqz0s5Y/z2uuioI7KetqVHGLNI4XsTLyQUmzXkeRzbCf4bJKrApkSqqu3ypdXvUzK42MrlEvSyDjBR2EKkZzMDQoBW1PzM0xDNEaT7AXq8G72GOQ30n
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR08MB7220.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(91956017)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(86362001)(7696005)(26005)(6506007)(478600001)(33656002)(9686003)(55016003)(71200400001)(186003)(5660300002)(52536014)(83380400001)(8676002)(8936002)(2906002)(38070700005)(316002)(6916009)(122000001)(41300700001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?nhvokkb7h0xUGUzALHFnprrrljUvtFvMw0s2MellpC2Zpcru1dUlcSoas/?=
 =?iso-8859-1?Q?Ims6faHFZYbLg3oFvS8PmRUzhfv/oK0SZwyCYANHLgckScvqOnx2jPUDrz?=
 =?iso-8859-1?Q?hfi76sBwUp83COaHaGK6TjOlf+mNjJFperMpP3/uvrVgPNn1xD3tomSqVL?=
 =?iso-8859-1?Q?vDEnLrXI9HbIOzbgLsARLHcD2WOEaeQZ1WxEU13T4vzs5i16/yVlNjoydC?=
 =?iso-8859-1?Q?X0zkXYkSonN3ydhkNDpKVgenEPN5xMvzxLx07EkWvwC5hogzhyT3OySiw0?=
 =?iso-8859-1?Q?aImjayfzbDgJE3IM7iGrj7MMDW5FwR5IF76dwDhWl1Uer66HgyNsvljcTh?=
 =?iso-8859-1?Q?2hziZNHk0Gh0QbX+Ac1LUUeUCj7l3DcQ7j36OJ4UQVjNKGQ1nLCfWwmY2M?=
 =?iso-8859-1?Q?NgKxkZEEylpWV2QYEkVY5QCN26SlUeGYzegF3a7PUDY84V1cWpLznBOk8P?=
 =?iso-8859-1?Q?lmKTYURpUnfAHxgpb1o9bvPFm/HacAQtMQ0k4CXFptfNU5NwFJpiFm2F3n?=
 =?iso-8859-1?Q?Bpp0WtiqGKgydS0dH9+Ox7BzzN4ByvpTU9vTquY2idDnF0Chd7tZRYPjBi?=
 =?iso-8859-1?Q?q3ZcDI5y3nxMlwRzMm2fjwN8xsa+CRCzkLgOz75fZeMibVP7TyOMIzjySY?=
 =?iso-8859-1?Q?hJQdqi2OCnrIibySfVet/btLNXgI4Ye74N7U7KKMicMUSJkkU5w1EX+/Ad?=
 =?iso-8859-1?Q?1VwyV/1D3oqwZzGfOOOod1uSh3wEFwBxLoX/8gXlFhE58cz1u4ULtK7Te9?=
 =?iso-8859-1?Q?gX2yWdOOfg8ZEGaw6cM5XzwIdnA0iAZUUFCcHF1f48j0PZGetzho6HwAK6?=
 =?iso-8859-1?Q?+kiBixUaEyklyR6ZVWgLvlhQuyZCp/yFe8eE+q2fKsC4JxaniBTkkkk+a6?=
 =?iso-8859-1?Q?G3SXis/RzxVLPAHi7sPJX6iZmOJhI0ZCjcl+NEz8sAzy+sMeVW7xcQ6Rm6?=
 =?iso-8859-1?Q?h9X9WIG26V6mXZ2JqevgNb7u6UL4c7VNSnpdIoSRuYOO8KZh/HaedgxB7e?=
 =?iso-8859-1?Q?QGAqV79zSwF62HXa6iuJKtxSFXDKVX18JmiE14U4+HShaUzS24b+Pnyqz9?=
 =?iso-8859-1?Q?hkmtOJP8iqa3PJoCzFmS7IkTjCJjSNXyGZqqhLZCk3PYm/pxSsuMu4UMFw?=
 =?iso-8859-1?Q?yzbiGAGkwYOp8mwlIgY4gX4IUzJHQlOOZ/sEF0WPZ+VSSZblbItYCCL+hy?=
 =?iso-8859-1?Q?phualOl4lNSM0AcOLQrnvQh6Rt/XvPdBXNM056xnuQvB7jKUGVHl9SrsSb?=
 =?iso-8859-1?Q?MCDBN/EUswAtAH8y5aHeqNUnEy4if6OojH21W3F38WIKHw2KhwChLb9sOr?=
 =?iso-8859-1?Q?W1BLAiSawAbqO+U0700aGtx052+hKjz6e6XtcTq3/zR9QAIXWHGOFoGg9Q?=
 =?iso-8859-1?Q?yAksuJgxQtWN9RvDhKIdrFM7wzTSpfNPBb9uF9BfGUWhJW8wWBNIIc0fkz?=
 =?iso-8859-1?Q?BNviheLO8hWev4RzvcI/20TtTX48JOxjNPsWM5tKNDcWrNUx6mcZVf+hgR?=
 =?iso-8859-1?Q?Z+riO02GZuZRbLQLP4fatExAfO6mcExUTW3UCTJ+1QtTDJ1uaGwH6+6UlU?=
 =?iso-8859-1?Q?UOyB+4SoCrzaRHlavRUtX2x59RtP2UZjjDmambBKIZACoNJ3jHFzb4siW0?=
 =?iso-8859-1?Q?RfsRFlDV5PvXQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b516a2-203a-4954-4bdb-08db62a282de
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 13:17:12.2770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3c2a020d-f343-4ca1-b6ef-91768380352f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wu83sLzU/WuLKgisFhYzfHq91sobFofDgiOOxaHNdbtsdyHAmZwMjrqva6iVBmnc+kco7n7O30t7sqXosSFhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR08MB7217

Hello,

I'm having an issue getting iwd to recognize a virtual interface.
Using 'iw' I've created a virtual interface called wlan1:

iw dev wlan0 interface add wlan1 type __ap

This leaves me with the following two interfaces:

~> iw dev
phy#0
        Interface wlan1
                ifindex 8
                wdev 0x5
                addr c0:ee:40:64:4a:1d
                type AP
                txpower 23.00 dBm
        Interface wlan0
                ifindex 7
                wdev 0x4
                addr c0:ee:40:64:4a:1c
                type managed
                txpower 23.00 dBm

When running 'iwctl' to list devices and APs I'm not seeing wlan1.

~> iwctl ap list
                          Devices in Access Point Mode
---------------------------------------------------------------------------=
-----
  Name                  Started
---------------------------------------------------------------------------=
-----
No devices in access point mode available.

~> iwctl device list
                                    Devices
---------------------------------------------------------------------------=
-----
  Name                  Address               Powered     Adapter     Mode
---------------------------------------------------------------------------=
-----
  wlan0                 c0:ee:40:64:4a:1c     on          phy0        stati=
on


When previously using 'wpa_supplicant' and 'NetworkManager' this virtual in=
terface (wlan1) was usable in AP mode. The radio does support AP+STA mode.

~> iw phy
   ...
        valid interface combinations:
                 * #{ AP } <=3D 3, #{ managed, P2P-client, P2P-GO } <=3D 2,
                   total <=3D 3, #channels <=3D 1
                 * #{ IBSS } <=3D 1,
                   total <=3D 1, #channels <=3D 1
   ...

So I'm left wondering if 'iwd' supports virtual interfaces created with the=
 'iw' utility and if so, what am I missing?


Thanks,

Michael John
CONFIDENTIALITY NOTICE: This message, including any attachments, contains c=
onfidential information intended for a specific individual and purpose. If =
you are not the intended recipient, you should delete this message and any =
disclosure, copying, or distribution of this message, or the taking of any =
action based on it, by you is strictly prohibited.
