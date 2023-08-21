Received: from esa2.midmark.iphmx.com (esa2.midmark.iphmx.com [68.232.137.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F5B185B
	for <iwd@lists.linux.dev>; Mon, 21 Aug 2023 12:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=midmark.com; i=@midmark.com; q=dns/txt; s=key1;
  t=1692619858; x=1724155858;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=eHxICs7MIV/FlNt7JS9r8PbW+/Fcf+XlG2gGtJdv3j4=;
  b=YVf/oXhJJ5nUWPJBTiaxb7GrAkP7htx7j/0KhBy/9HTHp7BmA0NenxrA
   ipWRczG0G6PVcRSZg6Ffop1JtpXBk0J0OkJf7liSFI/0ncvZuKqBEwIz7
   Yo9UDnQjKINamtbsUTmuVXOLF1/v3fzEMLLEYB+KO6p342Yjm67mxKSdp
   w=;
X-IronPort-AV: E=Sophos;i="6.01,190,1684814400"; 
   d="scan'208";a="72630576"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.midmark.iphmx.com with ESMTP; 21 Aug 2023 08:09:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BahHzqBwoSqF1eqts4YietHFtWXbxc/DkA14Hyi33hcYtrv560oc5efTYVdgzfpadCzOFkT1iLz2NAaYrgYy/GgQGASBC7NwJsFORb9myeYDF7KFFBT7SsSwj1aK+EocvqYlQFlb4zz26TBna5h3uiVbMiDko4AlUn/Xh3sqOfww6f2z22hA9J2DxLP+4nZwfZBciZkV6919vJIJCGF8zz0jWr4tkXr83wzBZs0ECfT6GlfZ4RR8Td83WJPALjNCSJA13KLC92ojoQAhzOUSbiU4bI5TgCTX+MjsmXf0pIQ0Fng3BJ8pOFfVwVIvS+g7PJAQbVmJ6Nay9yDsab+Pbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHxICs7MIV/FlNt7JS9r8PbW+/Fcf+XlG2gGtJdv3j4=;
 b=Q+R5rID3sW3l63vjRZOGZ0n9HAWEG4sJmdzVooVQCcw9ydoJD5YbmHg/Qw4qE/5usBL1i9ad8ew85xC4UIYW9W0q9k7wY1nvnV4/69/4FL6+LOfjO2ty7SXCC43LyY3emCNzTMIfyzLTcEILgyip47J979SRiBxCY4DfSJA6uu0+pUCxr62AdU+SFFt9p66j1x5ccQFQQb52TUHNA3xJZddmiousErePv/9UfKhpMTehFy4oStxEhQrumas+YK023cy7GPTIeDNqkbBeiPKc2xBk838cGo25or9kz8J3D1O4xIthv/vRp7P2RlHsiVm/0o4oN0HG1Wu+8GUOUTeLsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=midmark.com; dmarc=pass action=none header.from=midmark.com;
 dkim=pass header.d=midmark.com; arc=none
Received: from CYXPR08MB9294.namprd08.prod.outlook.com (2603:10b6:930:d9::15)
 by DS7PR08MB6847.namprd08.prod.outlook.com (2603:10b6:5:3a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 12:09:44 +0000
Received: from CYXPR08MB9294.namprd08.prod.outlook.com
 ([fe80::6c57:94b1:e041:2136]) by CYXPR08MB9294.namprd08.prod.outlook.com
 ([fe80::6c57:94b1:e041:2136%5]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 12:09:43 +0000
From: Michael John <MJohn@midmark.com>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Segmentation fault
Thread-Topic: Segmentation fault
Thread-Index: AQHZ1CdskyylU19PCkK1AnSiZ5m4vA==
Date: Mon, 21 Aug 2023 12:09:43 +0000
Message-ID:
 <CYXPR08MB92949D45E846096B18128C3EAE1EA@CYXPR08MB9294.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=midmark.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR08MB9294:EE_|DS7PR08MB6847:EE_
x-ms-office365-filtering-correlation-id: 05cee922-7643-46ad-6962-08dba23f8142
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iSkE+BSTFG9WOf8c9m+mDUlYTPpeGGrzKvXZxd8CaYiJrW4790ShAgyfk8Hd1Fl/naT8rPL61ph6NhmrheVcyaSxinBER8xyLKLlZrwQUkADDP81cOKZYWlGJySAxB1ENsEL4k2QYf8xAyh6kSFlufP1LK2y2Auu8GS7DqlrRpiJlvdofO8us0iHeUVRs66Jr+WJts6FQQ9WJhdGyhkDD/BXd9S15MQvlf7xDPW5BPO3NfuvSIhN8y4iHegZgj1YLGCKwuCPCg5t5MYMg+mxU5A1lfSZteUyVMMPZI3q5AeH1lR0yNMXoVa358Iz+i+cuTgjtxLjIEE55uJ+yNeG0CYv5GNI9L7W2seQlqPqEbIp+ZOLwjKmsQzXdjWEQRGvJNOAgcDu3SL9vcJo6kT5XqYVBFTMocmz3kko83qasjGp0qt91LZQQd1zYt+C6iG00JQg86N6rt7PFND3a4QeMGgD+tX6mKiq1//5y4rzfuPoKgRGXcIgp7Agu0AiF1pxqJfqLzq7ol30Kg38ZoCXzeooSK4idn0LfxBuI5pAVY/6sBm7wyptCS+xAn6tycM6FdDQTt8i4CBSk+NwXci+kShW9EQlUaYPgdCAna4i1bo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR08MB9294.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(376002)(366004)(346002)(136003)(396003)(451199024)(186009)(1800799009)(3480700007)(2906002)(4744005)(45080400002)(38100700002)(38070700005)(6506007)(83380400001)(5660300002)(52536014)(7116003)(33656002)(26005)(7696005)(86362001)(8676002)(8936002)(316002)(9686003)(66946007)(64756008)(6916009)(66446008)(66556008)(76116006)(66476007)(91956017)(966005)(478600001)(122000001)(55016003)(71200400001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+9LwdssqK9vsDknYv3TPZhGEMwdUsZAm2KOVzm//rooHmhs2+3zBg0Gqmq?=
 =?iso-8859-1?Q?ICPvT3siP/nVJ0WyRtfdUtWQhNvrS3cIV29tVe2ysLdz5Nmu0+gWjjS1AG?=
 =?iso-8859-1?Q?XpWuOsCQ1xbjv8yL/DtpnMTCitYI9S68DX0tRxw3P58eE9XZ1eF5dh3WkH?=
 =?iso-8859-1?Q?03SXdTaF0sUdiHJYfQBFK3yOaylQIo7xfrkmfSRWZx6womsaFUdlawIvhJ?=
 =?iso-8859-1?Q?IXGQprQ02JQZuqhzgnFvizb9mQwEkmCp8NDcYIN1CPfAo3Hu5g6A7FLaQ7?=
 =?iso-8859-1?Q?ngGFtequerEh4gnHHSb9Ca8waWXniJCC9arjFHoqRiK7DQgflfMagNlA+j?=
 =?iso-8859-1?Q?G9d+fLA6kqYOgDqAkvdjB6Ix2+tqjheYQUy4SCJpmTSv/TmQSMf/OHnoY3?=
 =?iso-8859-1?Q?oApHnCu2xEudXYyul2hvNPBE+xnthIOaWq3OHa2LbLjuYBxc8xAksT+hZw?=
 =?iso-8859-1?Q?HhzZGMWX9UK7xTxIU+9b8zzodyWel7v5iC4HiFP9hBLYWUJMBYrDW38JAW?=
 =?iso-8859-1?Q?KMreUSnoxMoCbBXxZ6l3KjJ/VUA0i8bdmEKrX9QL2GK9cCAmlEo7NX8HE3?=
 =?iso-8859-1?Q?u0Edo6QdN5qd+gLMhW8sncsT0PVVN01ZtJ988MbdIREl351gYHv4AOdZ9F?=
 =?iso-8859-1?Q?Z4ZqWtaAJBzF91DfUxv+zISgJ/QdUyXpXODWW09ZdmAcZMDYszTVr9I8C+?=
 =?iso-8859-1?Q?We6+J5FsL1hxPvOdnKBPpG4XkIOcoQkN9176hWOdreX0la/ZXF9fmTklan?=
 =?iso-8859-1?Q?4kPQRmOBYIFjl/IEA4ElT4ruIYdRQflBvaCxiS02c0bh98qycHLYEGjeDf?=
 =?iso-8859-1?Q?4+WmElYRWKIuKdMTRQz5nYPbZJPcYPUq0KozARSJgbnaYJ+m9LaYfdYmKN?=
 =?iso-8859-1?Q?HtC9+sUocr4N5IGy7FHdjDiOt3ga6PUTpt6gFBKr8fcDJK3F55MDul74iw?=
 =?iso-8859-1?Q?NokMgNsvDPXKjS7grzdymTnmcwxP2iqG9DMnwgz32nP/HI51znFk5hBYmG?=
 =?iso-8859-1?Q?JGxV1TlBmG29BRvCLJkyAIglXvNWnOlsEQEPStUZe+PZnSe8yn2VZkzbFw?=
 =?iso-8859-1?Q?AC9++nh5vKTbAA2VbmwZqiwuRpF9kTIbwdO59sZAr9N6WopO07NntRr4AX?=
 =?iso-8859-1?Q?6BbI5h8jFrGUaiJX60hxgn5iGF4xr3DSiiagJnNza+3VhdnlVU6WdHC7bZ?=
 =?iso-8859-1?Q?7YU55bCePw6tHU0QdRBB9dY54pYhibaXjXrrjwL0Z/f4a/V/qUm9A3QUTc?=
 =?iso-8859-1?Q?BSc7hzrchHLrR+C2H7otOzk6ZQk8DCbtv+8/v7qB+xIUTxenP7FhITdbKr?=
 =?iso-8859-1?Q?6blnX4eP/qNKSERtjRHLojEbJ7szwGoNldj0fy2hpyJm/ZKxkl2YY8lETQ?=
 =?iso-8859-1?Q?wtMLY+6rKfOezrnXjCoP7XP1/y3RW3vWrPdKigvgpHmHWLc/Ns0DRiIYnr?=
 =?iso-8859-1?Q?hQQzxHlqamKYLzJ9BkCOjQeXMwFencnQ6Ky1PSzHMAIOttHHjib088ppPX?=
 =?iso-8859-1?Q?pOBG/sk3upg7t5V95Ke7poGCwd/CIBChYXCJhS9560ekqqjE2ECYkM3nMX?=
 =?iso-8859-1?Q?NdF9K5bJpAQA3pfoBDZqspA/Bye2Gf8Cue5FkusAbC91McrJ+Z9wA1IOUF?=
 =?iso-8859-1?Q?SFjxjtmyb6OBM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CYXPR08MB9294.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cee922-7643-46ad-6962-08dba23f8142
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 12:09:43.8158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3c2a020d-f343-4ca1-b6ef-91768380352f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AGGyrj+tOXtwx71nBUr7mTlgP5ij9afdwOQkrF6WG0VAqxndKEPcO5b1xvAZI5hwI7WYoFdc31iyOKE89MOKzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR08MB6847

Hello,

I hit a segmentation fault with iwd version 2.7, and captured a coredump. I=
've attached it at my onedrive below, please let me know if you need more i=
nformation.

https://midmark-my.sharepoint.com/:u:/r/personal/mjohn_midmark_com/Document=
s/core.iwd.0.a68e5068b8214b27904b0fc85601ac35.241.1692277585000000?csf=3D1&=
web=3D1&e=3D4NPwg3

Thanks,
-Michael John
CONFIDENTIALITY NOTICE: This message, including any attachments, contains c=
onfidential information intended for a specific individual and purpose. If =
you are not the intended recipient, you should delete this message and any =
disclosure, copying, or distribution of this message, or the taking of any =
action based on it, by you is strictly prohibited.
