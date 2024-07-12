Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2074.outbound.protection.outlook.com [40.92.23.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2D184E
	for <iwd@lists.linux.dev>; Fri, 12 Jul 2024 04:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720757335; cv=fail; b=p/06C4tmC7LSbYf8n1zTgnX+8FLpOTY33MaVLRoeCks8UDxoJw/Gia5ctH5bdeqY6a7MagM5g/YOMe1x43wiwPj0fUs4N6iw0Jb5Wp9Qui9LwDrBhGK3IJbgTDIjlogOKm0SNDGBuKMxxh61+A3NMvp7+4rEe0/Kzm+KTuOMP6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720757335; c=relaxed/simple;
	bh=nghXBnpRRg7SfcZrLhuotege83pb+dXSrCMHxz+DPD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hcifC180bgHMqnxnn2iO1YtiZwAtocLkPdgvkjF8C8Uvu/+PDtCs2POZ6p9hnC3fYX6q7FZ+FuC+PIgw6tWofVljTRBt+dB3FrMSK1pWStZS+oBhy+8mL8Jpfcia0Ss6y9jK2dcxPpLtnej9zTZPlu1PvgDT9NfY44R/WiU+YYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LtInAmj5; arc=fail smtp.client-ip=40.92.23.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LtInAmj5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tl4EAHxN049hPmK57BcrGt1nmML0t6MzTgD2VwFR2TML5Pqa26hhLlrfFygzbWqxrhzg0/HtA5t+qf2+2sSfnncJcUCjvXvQ02GFKVcn/P/4ac5ZuVM4DP9Z0qnZ1g7W0cEPOsjkha6Lsw3DQ51v2zClCypMjCtkKgydZc1wyzjTmVav8VrDAnqLAKdErfhBWQk0X5uwhECVybSJc8rKNx02At4fFZocdclTw/5ePa+niqTHYtmH2UBeZlfLcy4ajZpL+qiVvS8Ynr5V1d5XPWXUg8QdMU+lDjFDQToBQZwmg7jJ3yvf/636r7Jpo3j0YcNgX4j2IN1KtIe9xtx+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLAqO2y4tjNkZi50rnaBPOIErZX1IHN8CeKhLILM7h4=;
 b=eLhwCAKx82c+Aw47YNMbBDAyssnLTh8hylCJKHB5fo5Fnyhws5c9S0GWidmOSgvFySQeSC6GvrkWpC2n6vQjr1gMG1SL1DCkGYZ1kPtnvTaXyX7Trb6q6ffng3Bg6sQkaaoZNfqvjQGbw0+1bSikjcdbajRY7OuQ2u1V8oxwMEyM3GJojgO40Z8BYl+fKen24YxWjfEEu1mFf03dy+we5AO9J1BcHliW4gdvKLECrPnb4OOyTd9mOp+KdEsWYAsAnuLu6YSL/8aLzSwnyn+eB702KV2bRY7SxJtYfS5rC1sIK3ngEmh2oZgT1r+RxTWpcMGRHzTPNopPo87HAxU4/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLAqO2y4tjNkZi50rnaBPOIErZX1IHN8CeKhLILM7h4=;
 b=LtInAmj5CkV0cN/Ih/+f9g0rITxem/wiBpUm305FP9/SAbYjA4TuyMjFcjz1SX2+FZFT6Lau8i+hzj/UrTvBrPGxNbICWlxhXoj1HyskiESwu/eJUOBlvEm/HmSaCrElSRPcNes5PAoEZmqlwr7zqT6+FpC87747xF6auss5JoRL6mbpbWUAnY074wq5fP/WVSyBVGKKaGbic1ZDdtLUxrZIXmEtC4HEQtQqeyI56m8Bl5w4/Yv0jFGG7OWQJkjavv0+zzGitgKsUc0teyTuOzlem3aWZOGXixgwNnOaBJ9YHH9MmznVf9U9n2b7UDv/8Ir6ogg4bM8VH5kBWVVQWg==
Received: from DM4PR14MB4880.namprd14.prod.outlook.com (2603:10b6:5:390::9) by
 CH3PR14MB7213.namprd14.prod.outlook.com (2603:10b6:610:159::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Fri, 12 Jul
 2024 04:08:51 +0000
Received: from DM4PR14MB4880.namprd14.prod.outlook.com
 ([fe80::cab3:9377:6fa4:3de0]) by DM4PR14MB4880.namprd14.prod.outlook.com
 ([fe80::cab3:9377:6fa4:3de0%5]) with mapi id 15.20.7784.005; Fri, 12 Jul 2024
 04:08:51 +0000
From: kasper <kasperkantz@outlook.com>
To: kasperkantz@outlook.com
Cc: iwd@lists.linux.dev
Subject: [PATCH] [PATCH] main: remove static from const strlen    
Date: Fri, 12 Jul 2024 04:08:35 +0000
Message-ID:
 <DM4PR14MB4880999FD3EB47469CAA8B02A8A62@DM4PR14MB4880.namprd14.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <DM4PR14MB4880D5598D181E5FE126C54BA7A62@DM4PR14MB4880.namprd14.prod.outlook.com>
References: <DM4PR14MB4880D5598D181E5FE126C54BA7A62@DM4PR14MB4880.namprd14.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [EZKz2QAH76i51n9Rhm/StFonzO4gNYC1]
X-ClientProxiedBy: GV3P280CA0119.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::20) To DM4PR14MB4880.namprd14.prod.outlook.com
 (2603:10b6:5:390::9)
X-Microsoft-Original-Message-ID: <20240712040835.73-1-kasperkantz@outlook.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR14MB4880:EE_|CH3PR14MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3f3d21-e178-4000-fc21-08dca2285639
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	Ase65tgF8zVg65qMk0kUa8JkE6hPLMSeU8xuw0+F/C+DLr/SibYTqYmxVQJzVzF/Q+FUts6dPBs+H/tB1amKUEJpkR6CaNiUA8iPW9EUVOwHx21ThplBNpcV6ieRO9uVmnwCbQb9TqODqTrWxp1aBS93CWncL1Xz5cTCMT6ptchoZ4IlUt4BfDHTtzd7dJkUOz6xM1U399+nVtGH+g3HizHt1hVi7jGw0WDypZK8XJexyT6z3SbAQ0EStKsFdGcTjxJFzX0hHj4vzgllRJSAsyPfB+w+gjWOBIsWPOywSKC1JvD+EB8yNFznLHP3iso291ZcdL2BJ1BgzYEjHURnyHD2emNehyKB5a4i+xqu0mo6hsrcewl2I7D5hRtTpRyZcS+Ws0qlGArO1OtWdx8POM3XTunxw45Sb+/9bDQwbGWwnJKCTTU4pQeiAm/IoRzAig29sequM8pL8vG5mMljxmWV4idY8aB0d0EZ1iV0hbsD2VANP9vfRSV4clJtmhuEhE+zA3uIMY44+1i9a8WNB8VrI9PvsIPP6lK+CnGVGOs68LAgt/ngK8ccP8KNKWvfo2UiEUBQgX5xyLeb7uCmdbRMyJ1nP+qjS3vn7/z8cXnSfQ6DJPU+4H8/0PTPjUCMxtLntBt6v0xStmrk34eNQQE4bKHMdeVgLHG1mPVIm7FRMXFKcx/exmTE68UrMjTW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FkQBfhFGrzgAYaxtpr8J2lgQLH0RpOBBS47ZjsZTqfry0VaGRvJwQmvPNTOx?=
 =?us-ascii?Q?x98vq7fNmkYRCeHg+M2i3nBpyqMOtKzH7qKvar9oeLpA6CZlekNVItvsAAst?=
 =?us-ascii?Q?BPe0OGy5zyuKOZInld4E4ugz26oqfl/nvqDrAk0Efb8qF9YVt5ZOretWWYTl?=
 =?us-ascii?Q?hJf9Q98vMvRZ0JE0Z3FjfTeFlr+Un9gt9lLNtnKWuA1BH2gMgxWyq8yX2hak?=
 =?us-ascii?Q?YGU7YleE2ozxtKuoSwwQjVIG9C9qmJ58YUZbkzv67clSBMKiGSKSaus2292s?=
 =?us-ascii?Q?VFoJgO2ysDU+bD9bfwUP119LXQupQDZPExTQe0XyClHcyUNAfAMs/VrpIbFl?=
 =?us-ascii?Q?2snrbx3UCr2YRPyIVk6Ptu2a/gFXEPWKuI8OoJrLqraDQrUtvzRW3kvce2pC?=
 =?us-ascii?Q?HNEcMc/qyY6jfisUf6DMC05Hyvu1X7KF69Rc7bVy/PLvu9MQzoV4yoDhgjUq?=
 =?us-ascii?Q?5e/HCw0Y/dw9sc0hdUO1lE742qCIs1pec1O1uEouQgw/2XyOJw82D8wVa8AA?=
 =?us-ascii?Q?VwJnRJieIbuD0K3Knhm5hYaAb75X0M1Q0f53BoIsoB4In0FwNEI9Sz2TgVvY?=
 =?us-ascii?Q?vk+HRUpO/Z1kPaNxoLryo/ili5zloFzWl32Boj05YVkeXsXaZqvOSZli0RVZ?=
 =?us-ascii?Q?JRJqm0pmvH2dCb/J27/ZIzuJzUZsLTMvlWksEW1KYOhV/B+L3NkRSvUGjX1i?=
 =?us-ascii?Q?KlcC8vLTN/QqNAzmYXrwGgi5nbO/urcBVTTcubGU+bsY/6aDRe4ULoyNOGol?=
 =?us-ascii?Q?DJVQLiHnA5ISkXnR4hA8JM3rv485ymWtt3vl8hp1Jv5hs1UUEt7MdS1eRxCM?=
 =?us-ascii?Q?+3gCKxNN6Q7S7g3RPfYWdRP4SRwgotEzGjY8QCfPuMI8Jn2q5fdzbJsdNKwp?=
 =?us-ascii?Q?ke415GI4docOjrV4hPP6uQOi3SOHxkkNMimYj3Vfl1ulLmZAYmgdFWLfV3ja?=
 =?us-ascii?Q?nFNyt9Yx52Hp9vhSN7XCnnJctsyxsV6qCauT5hZST9waqQfqo+cnWSmLXC5p?=
 =?us-ascii?Q?prSWKwQlH/Vygn31INnLjZK3cRGsY6/2X1IBzMlesdu+cQkvJ5TPWkIZYFH1?=
 =?us-ascii?Q?swdw3bj0E9S6embEJRZD+6bR4zdQgkYP6R1iy23cIyYIyyP8P59t2Mx2Ivro?=
 =?us-ascii?Q?tAFNkMhLoyDpNy7AxFt98MJ3FAjt8mQvRFcniR73JTQO5dyDb+PWoI2ZN7lF?=
 =?us-ascii?Q?N6dt0pDqb+7PN49XzDL387Wy2jRtasopLprqIbmZrvx6xoH3ZM4fgxS63+Br?=
 =?us-ascii?Q?Lu1XqE+lkD6mKnjfPNWc?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3f3d21-e178-4000-fc21-08dca2285639
X-MS-Exchange-CrossTenant-AuthSource: DM4PR14MB4880.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 04:08:51.2727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR14MB7213

 src/p2putil.c: In function 'p2p_get_random_string':    
 src/p2putil.c:2641:37: error: initializer element is not constant     2641 | 
        static const int set_size = strlen(CHARSET);         |                
                     ^~~~~~

The compiler inlines the const value. This is just to make gcc 14 happy on riscv64.

---
 src/p2putil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/p2putil.c b/src/p2putil.c
index d1f114d0..ef0f988c 100644
--- a/src/p2putil.c
+++ b/src/p2putil.c
@@ -2638,7 +2638,7 @@ void p2p_get_random_string(char *buf, size_t len)
 {
 #define CHARSET "ABCDEFGHIJKLMNOPQRSTUVWXYZ" "abcdefghijklmnopqrstuvwxyz" \
 		"0123456789"
-	static const int set_size = strlen(CHARSET);
+	const int set_size = strlen(CHARSET);
 
 	l_getrandom(buf, len);
 
-- 
2.45.2

