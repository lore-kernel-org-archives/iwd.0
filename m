Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.109
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795521115;
	b=3zODkgyvn1qE2q4zkkIaGh20gHxy1oDrl8xeBLyDxyghQMk6c2mWcx3fA2ARlMYCPoc5
	 KATCJdL7SgzgapBVSWfXbIpLnBeEFBpYSMLHHb9Jq5uq1+guUcGKGXHE63sRSzJKxka4L
	 dCL8H6Ss2CxLl7ZdHkm3UC02YAZwCa4CXVCcAAg72hbdjQD4ukdIs7UPDdgaySlbxO/3u
	 xlkGN87tSUZqra+2BzdhERnuz/roY6teUzAddkWqAwcV0OYoBfrxESH2uica8W59H5Ahn
	 te3l5fyOkYc1piJfGW/dj17dp6mhU/+cROydtEp2m3rEL6aJzK8OxxF0driqGwfg8OA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521115;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=TESv1Mgdt2IVtENp7WRLV32QjIRNPHUhBWpbSAwM5zs=;
	b=LSMi7skV18yNY0m7i56TbqrjS5CAvjos48QXuZ2WapXqpMv8Dhg9e+Kn+vVBd7AuJ+ob
	 FvO/DicCnyS3vgjmP6B7c13tQgsLoHbvRlJPpfAGjZqYojSKnl3fHRCJX/NW41H5KO2Uo
	 BHwNDTU9W8DY2BiSMQhX0xG+wmF0ZCCioyMWCx/OQwxZ92hk6xEwJD0v3Ks9cjVy4+OQ2
	 HvKuVafSecG4VwO1BqdG2KrDWURW+/ohLoaQB4Dc/0qLLSwiZ4PPsAtwys3lPX/RSgyMD
	 8oDiPYlsCEQt+4oMUAOjfIH1z7dwppqTbnQ0erWJYgqAXPeiaPWnXeEE0BKtXTZXj9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=jFyark6G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.109
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021109.outbound.protection.outlook.com [52.101.65.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B5606A682
	for <iwd@lists.linux.dev>; Tue, 24 Nov 2026 11:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 787B5606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=jFyark6G
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESJQI0jcZcIuZgLHsjfcLgMm6Gv8lb/wuQh/Gi4Q6QN0C2ywmen/jx/nelouRd5/JZg0rEDKOXgk45xri/czw8TvSS2XAeSqkU5TDM5YkYsbYUh3snrVVBaxy6oJqpxo+t+16i1r+yhNYlLcYa1lhr/1b+d0S9C/1/cvdg7aU3SLLVe9Ep33H22q0LB1UK5lRyOxmpA97deUXG901geGvKvGL0BCJJHzsZlH9Crgm/iNMiwiiqURCKLsivlhEkm+/qcN7OdUQcSHekxs7m5qkQIzxNMnClDQMYJYn1CLuwVBLwGUYkgQNAzLP4RJiP/GH/Pj2bRgqSUJ0ZcjzO8lTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TESv1Mgdt2IVtENp7WRLV32QjIRNPHUhBWpbSAwM5zs=;
 b=gkNRV/245VdMDH7atqziu8OVobpQDFmNqpQka1C1mlIKc+OTHiYCegCXkzbSMleUyao26+oD+FYKFFlWf6D2mrJNUwOjckowzMgbUjtQgLsAjQ5/0D2u3A5YQ8AFb99jz+lQlXPaASDyXsDvEq95Rcs9jzNU9kffqri1vOp53qLCKqroUVI6FOVedLkFgYNYLNSRruKeKNso7a9HMGItAbMcl7erET1lUjvZE89N+PWmYo6z9RhMK9i/Ee3z4vqZ/jI1/tgbWIDwks3KI+SsavbP8vr/8rN38xuKoVQzaUhQ2YqLCK02TflmPUzWtwRGz6S1+RoFeKpZ67zVD3wjzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TESv1Mgdt2IVtENp7WRLV32QjIRNPHUhBWpbSAwM5zs=;
 b=jFyark6GiQxS96Zf28awaLXjyq+vTiYCpmhONeOw3ZJGI7v8BBCzke3S6otaZdo8DBmkxpfuJ7HwPeuTmvmHEeF6sbeoPCtfd5vEtek/N7WEEu7PtyJZyrSKJSiiSYMvayXb2OBP3gbe4usZtdb8kJAisjoOfnDiarnFbbohVik=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI0PR08MB10711.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 11:51:51 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 11:51:51 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: iwd@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	prestwoj@gmail.com,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 0/7] Add EAP ServerCertHash setting and Certification signal
Date: Tue, 24 Nov 2026 12:51:39 +0100
Message-ID: <20261124115146.1281715-1-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::13) To MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16)
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Post: <mailto:iwd@lists.linux.dev>
List-Help: <mailto:iwd+help@lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iwd+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR08MB763857:EE_|VI0PR08MB10711:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e47fca1-7fca-4726-3976-08df4a2153eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|786006|376014|366016|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|11063799006|56012099006|10067099003|261009223027099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YV7hLpY+RAitjOdOgqup/WAeeh5Fp7uZHRb3Wn5NoiHSft3eB846EArF3lFzUIqrDbskAd0s5r8kjfFb8O4f9ViCPanPqLJMHu0ICAxwmOkeMoI7F7/YnplbSuZqPd8PoT51+J8RY9xA0UDmMo63ZIn5wOY4N8t+w8V+b8uxNhOC8mKbww0jds9MJwP5uvn5jhvhk+dTxyfT8AyS/nqrFgF6uZ5MzUBad4RzeL+7SrGPfCKRjMuuOB3Y0mi1ehGOVZYaEWypefWp8KLyHFT9kCId2Le6CEHkc/r0OEaenVljS0qcMdRdDPA+6BrAGv4hODV7OW/RNet5BTJRvJGcIhQA/etARR5qCkAFElY6w9D3kdVu9/ekICGvFf0Mro3Rac9VAytMD4iJxCUZ9fhKu5e6bv9Q+c0S46j6PELMCV5S47g/J3/R3/YpBF5lHwjaTDcKb60NCvvZj8q5FWg/vPrvnNRadBHe42k4Hej5Ly1eJ+qqO86Xh6NRRPv9P8HJxvaNqUssA1gJlsjSITatcyJR2qLxiaIA8Ls0xsgi1enq5qWHI9HVi3H4VD1hh5dnlK9FkVogqM46KYXj0AbBLHhISm+VAKKXRxVlIcNQ828Ws24l3bkil3G4K1L0gIpL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(786006)(376014)(366016)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xPygjibU1MQ23f1iVzMpudol5MG9dup9vvmqN/WWBtQeim07/kai4IUitoWi?=
 =?us-ascii?Q?HG/INzNaDOtKmRNoYnWczYi7n0tYPhq0klSe47GqUdJI2+bWUmLfi0iuyPmh?=
 =?us-ascii?Q?fvisqd0ZEhVAjXNaW3zJctusIAEr3LH9BsUrXwhfWUnOG0ZrING7njTbNP5J?=
 =?us-ascii?Q?3I8dWCnXypDtH8oqF50cEIbMuDHhsmSf2Iv/Fp/pEJs+tsVr+7GiH6Zm3TbQ?=
 =?us-ascii?Q?QK5g6rEx/aUJjt/iUM7LE5SfFj2Q1NTkS/ScOHbYwsFDJgBVWS2Iv4HBMZua?=
 =?us-ascii?Q?KLLJaIUAWNsy+ZbJFnO9nL0zfmaSDAeFsPd6hvw4ftGimzmbBs0nvC1jsTgm?=
 =?us-ascii?Q?PRo/TSFXtXGzZ0W4xTWn6Yz0RpBbEQh+ZW1U/dk6ddnNRHPp2TMYGELe9Acz?=
 =?us-ascii?Q?nkPpDmoWgVi/hlk8VeJIH6qPLxsV1yfAVfYe7wSNJA/ezmJ7oVpeY42H1/JH?=
 =?us-ascii?Q?0+OaEjLTyPSUMqdsJvEa8TmWOP1ZHMF/uW5CVb0V9L+F1MO/7VBH7FCRA/TA?=
 =?us-ascii?Q?qsVw+0IZ9mVuloXd3WMqV1ser7jTwW6zr4oSh5n2Aqj5DWyGv2i/GnnWJibT?=
 =?us-ascii?Q?Yq9yfLW90CB2Fa9dF5eDub2GTC2qG5VFsmxiTviMy9XZg86tDfBJ+r9Ylw2C?=
 =?us-ascii?Q?qyBhNn2Sc6NHznnFxeIy7RsA5kqh84ZWrnqungeOwVWDQtiV2s30BOcQmkDa?=
 =?us-ascii?Q?R6+/ev71L3esWmXPzTtE/X5OfQHPhAOqi65CZTHILbzLxXfcGKhgPQxjw6kp?=
 =?us-ascii?Q?gX5J1K+58p7Yhi2ZZE3QjYiDmscoAfPdVcyD00VuKpDJ1874+V/obruZAYH5?=
 =?us-ascii?Q?AF3xJOiJ2aYtpXsOQSUbTyNecuZsBHyxqDrfZzCesozgLKDO8ZUYxF0YkQMf?=
 =?us-ascii?Q?q9s9Tgn2NHWi5+hbpBMr53gh8Xq6zuyXHAzXbENFkycLUTWGp6dy0MmD4uUj?=
 =?us-ascii?Q?cKKuiC3O7Y4bgkkmbVw8lj0eJFjs0MeRAd9aDBVocPBF/8UqzpldtFjaL5vS?=
 =?us-ascii?Q?G9THhvTGyODMPXkaGzWCKE2l/MUeePAYrAt5/tgoKYjKhih3+oy34uBZ+5no?=
 =?us-ascii?Q?vdMB3OZs7oh/4sXI1xnbvG0WKATM9o1ADMhvfcsZVPHWwmWLSVEiiL4wHco1?=
 =?us-ascii?Q?xUxaQJF73Uymls1YBbQfgc7BzLlzf0b7MrVJ+xJeLAJ6MHyUN01FYeMS1hUk?=
 =?us-ascii?Q?iJnSN/hCYsBvYakOwWlgATd0ad58sciZ1i8OAbYqh3VtMoyMvBRBxbNLC3Vr?=
 =?us-ascii?Q?pzv2047W7LhrfOkDFUNSqX+X9gJEFV3oFmdTPDsne7PhUldqtXXTHf7crUNq?=
 =?us-ascii?Q?hWZxidtCxDoqRB6iZakonsvkbIIF/dYW1vIT2fSjkrTHFEwj9S83Ge3DQ/qO?=
 =?us-ascii?Q?SF8Qe7WSluRU76f0ccjcvQG72hozc0K8jWasWBHjF2/rhQIpAwFy3/zx15DR?=
 =?us-ascii?Q?IZOUP5F0uLGHw/zdbwZVWa9ffY7B5qdwtqrlARUM1FBFdY4voafATAvYMzcl?=
 =?us-ascii?Q?AXqGz30omikC6V4a339Y7N0YPG9yckQAJayghFzIsFJ7YqqhZYntf29wYUbk?=
 =?us-ascii?Q?4QCpgxwlZzBIgpI44NUBKd0pdLPtuq1+yvcUIw5C9LS7gQaiUcrUQxZ5gOsb?=
 =?us-ascii?Q?zsscmKOnNgwAPdBeekfVga27alURMi+gJdFPBhO7kRWMWNXk2OOMLXcDbWx7?=
 =?us-ascii?Q?Y0Y9Hmt/hLqtnVJos1d4l0ECfaOOc1wjeQU9+25bkO/ElJ4Ios8yeeoR249S?=
 =?us-ascii?Q?F2LQ97KLex5ibAa9dzagsIjrkodAWwt3le8z80YA1ia8pFxyj9p7?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e47fca1-7fca-4726-3976-08df4a2153eb
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:51:51.3253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYLr+4evCjmsMWscZ/XxuCPvpZXtQqpL2c6QdbuBuq3y9/PwjMjYdFHHRM/E2i5cNaJXC0CmYOVKEwf5CDhxc5mXK/uzuvxyR243FcbBy94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10711

This series allows a network manager to pin the server certificate of
an 802.1X network on first use (TOFU), for networks whose CA certificate
is not configured.

- Patches 1-3 add an EAP-{TLS,TTLS,PEAP}-ServerCertHash setting that
  pins the authentication server's certificate by its SHA256 hash.

- Patches 4-7 report the certificate chain received from the server
  with a Certification signal on the Station interface, with the same
  name, keys and order as the Certification signal of wpa_supplicant.
  The certificates are reported before the chain is verified, so a
  network manager can show the certificate of a server that is not
  trusted yet, and then pin it with ServerCertHash.

The series depends on new ell functions, sent to the ell list as
"tls: Add server certificate pinning and peer chain reporting" [1].

[1] https://lore.kernel.org/ell/20261124110847.1254540-1-Mathy.Vanhoef@kuleuven.be/T/#t

Mathy Vanhoef (7):
  eap-tls: add ServerCertHash setting
  doc: document EAP ServerCertHash setting
  unit: add EAP-TLS ServerCertHash tests
  eap-tls: report the server certificate chain
  station: add Certification signal
  doc: document Station Certification signal
  unit: check EAP-TLS server certificate events

 doc/station-api.txt  |  29 ++++++++++
 src/eap-tls-common.c | 118 +++++++++++++++++++++++++++++++++++++---
 src/eap-tls-common.h |  18 +++++++
 src/iwd.network.rst  |  12 +++++
 src/station.c        |  94 +++++++++++++++++++++++++-------
 unit/test-eapol.c    | 126 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 371 insertions(+), 26 deletions(-)


base-commit: d003d0e593323b3de427f01284ede81ba61e9dcc
-- 
2.53.0

