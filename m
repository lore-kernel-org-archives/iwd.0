Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE2346AC
	for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 18:33:54 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so3474635pjs.1
        for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vIeM3K2stq4Nej7GMRQI5jMzOrjyFy3qG+Hqrpowlxc=;
        b=TcAmE8maDFNLkRNO/R/9c3KJpDnv12+OLbogN76psk+p8k0kxmaO9FYUV1OBBLGBNN
         g663g2SX9ufAAZ7deGYWGqR4llNRAp3EpxVNLncXziR5gD9Rr60b8K+ovKYerTHv5nOk
         KNJSQCiz7gW6hVjLmY8XZZHKdeQ4/AJspooUY2p8wA0pmxD0X4YhQabf+81eTJBbgjs7
         7cXwMj9re1nI+SYeSQUWY8CBfIynhR+9psxXvaudAaVBYSZ4FDOHnn/kPHt+TqY6pWyF
         xqqDPjej6516ID3ApT6ppQJgn4YJFrUAwEgeDXlKpnYCWAuuz4e0E0CgqXISL5q77qX8
         WaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vIeM3K2stq4Nej7GMRQI5jMzOrjyFy3qG+Hqrpowlxc=;
        b=gtjyhJWJ6uQwWNiJGgdpbwQ4jFMrepZRRQGT0X9g2zmsxKgf62fyEZctJseHttInXS
         Sp74LSNM+7Uf58mc3S6m4FcVA2FSHQ4+bmNCV0d+LJTJTyH9JDHERGZ4HKrRpDpkiDTN
         c2QEgwR23a2jBLeNMM2uPssVX6iivE2x7ySEr88pZSFnKgMVGRbJNkgKwRcIib1F5N+C
         4ijmO98JhkUjLN68BCWTO7pp/1vn75NydyOMN700FmEZEPmbJnniIjVD0ILdBvZxGxZ2
         Wtpg08AGUIudVoSNSYJtupKjG45TNQY+TT8n5ZTnHA4MRnjl3QG/Ea1AGpNXfAXKyu0I
         dh9w==
X-Gm-Message-State: ACrzQf2X2e5nV8ZzAUnU6ZIpXvqn4u+dIhOJgVSRRi2ms2PKeBldCqV3
	vgcYqTx/p08oUI1Ty2WnC3+pJY/oA44=
X-Google-Smtp-Source: AMsMyM6RlvVZ0+eVUCr+NmJS/SO+KzFWsZPlp/zySyD3VKicXy+G2C48rwXBhjlNk8Jx+EQ0+63mZw==
X-Received: by 2002:a17:90a:67c1:b0:202:e10a:4f14 with SMTP id g1-20020a17090a67c100b00202e10a4f14mr12095461pjm.238.1664390033465;
        Wed, 28 Sep 2022 11:33:53 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902db0900b0016d6c939332sm4148704plx.279.2022.09.28.11.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 11:33:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] ft: optimize clearing authentications
Date: Wed, 28 Sep 2022 11:33:51 -0700
Message-Id: <20220928183351.363600-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220928183351.363600-1-prestwoj@gmail.com>
References: <20220928183351.363600-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clearing all authentications during ft_authenticate was a very large
hammer and may remove cached authentications that could be used if
the current auth attempt fails.

For example the best BSS may have a problem and fail to authenticate
early with FT-over-DS, then fail with FT-over-Air. But another BSS
may have succeeded early with FT-over-DS. If ft_authenticate clears
all ft_infos that successful authentication will be lost.
---
 src/ft.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index cc13d2bf..c2607a1b 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -1033,7 +1033,6 @@ int ft_authenticate(uint32_t ifindex, const struct scan_bss *target)
 						target->frequency,
 						200, ft_send_authenticate, info,
 						ft_authenticate_destroy);
-	ft_clear_authentications(ifindex);
 
 	l_queue_push_tail(info_list, info);
 
@@ -1055,9 +1054,20 @@ int ft_associate(uint32_t ifindex, const uint8_t *addr)
 	 *       a different BSS.
 	 */
 	info = ft_info_find(ifindex, addr);
-	if (!info || !info->parsed)
+	if (!info)
 		return -ENOENT;
 
+	/*
+	 * Either failed or no response. This may have been an FT-over-DS
+	 * attempt so clear out the entry so FT-over-Air can try again.
+	 */
+	if (!info->parsed) {
+		l_queue_remove(info_list, info);
+		ft_info_destroy(info);
+
+		return -ENOENT;
+	}
+
 	ft_prepare_handshake(info, hs);
 
 	ret = ft_tx_reassociate(ifindex, info->frequency, info->prev_bssid);
-- 
2.34.3

