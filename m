Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5C44122F
	for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLseEZWC"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1ef370c2e12so3495466fac.1
        for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 09:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699982143; x=1700586943; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nrDqqaZb9whfCkJyiZe+lLMc4DjlSeaJzAIqtjDAn6k=;
        b=eLseEZWCXxBah59UbEA6m1bVORjUzxAoeZhoVV/Pw0UE8TOOwahXhjFxuaM5qHfDpF
         aj66R0wAPe4QL18MTY6do8Z9lp53al34J0xnlveTlRwmWjFAXC0nbavCy+muMtMNrubd
         RqXU6U/i3e/4ps2sJ1e7TGiEQikmTEQUaPt4H3LYvzjZtPjvqYSpbo2skW9qlGb2wAvC
         JsgtuoDsJPz7wTQ4GcRTolp6Ukt4GDcdBWfbl7lSoS/X1SKDQZq3QxutrGWw7XAuxmRi
         IEL3ctFtCbU8Hkzm4Dkc06WGih1vOHu5zuvjKkPIHg97K4hBR4cbBOmgFr5SqNUbcJ9N
         keLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699982143; x=1700586943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nrDqqaZb9whfCkJyiZe+lLMc4DjlSeaJzAIqtjDAn6k=;
        b=kt52ce3IbsOC4JPGkOipWpfFiE3kwyTDE1BvTGMxlEJLArTH39fsG75rCbOIhgMvs8
         o9xv64bHZNWVgZLaKIVabdT0Fiq2nx6nrwqhz/ZDTBfP+Ivp875ez/eQvEyHkhgQycMb
         OjblgMgfK+IeqKbQFCudpSmuayYJSZsHxUD5gXRUqVlCrD7WSjafg3wMAlBX9M9UsHNL
         3HReqYaN2mn2tbhxiUzMIbS5Slgd8jP1CbsL4/Yc7U+tMJwyS+FJ+yd1KQ7egkPmy6Xq
         tymjhCArR7TAdJBD8la4sMzqEQ6bITvJvBrGXnDZWtm0zhST/u88ZrVc0/cdMHid/P/j
         nK2A==
X-Gm-Message-State: AOJu0YyGBA7o8+uS+2v1H8JstZk2MlOkzxv0NMwrlaDDxLFkSLdYU/GB
	q0UcD8GqF6PeheAlCdOClZO4Gpyyzmg=
X-Google-Smtp-Source: AGHT+IFNIyVr7bnDJ3X8rkDi0xinniowztiPPuOcPWzmiO2ushIFkNJo4MjwdSjT3X7S+dyF1LK33A==
X-Received: by 2002:a05:6870:a54d:b0:1ea:b1c:b859 with SMTP id p13-20020a056870a54d00b001ea0b1cb859mr12901777oal.35.1699982143618;
        Tue, 14 Nov 2023 09:15:43 -0800 (PST)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id o4-20020a05687072c400b001e9a253afa3sm1429647oak.49.2023.11.14.09.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 09:15:43 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 01/11] netdev: Fix obtaining reason code from deauth frames
Date: Tue, 14 Nov 2023 11:14:24 -0600
Message-ID: <20231114171455.1108856-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reason code from deauthentication frame was being obtained as a
uint8_t instead of a uint16_t.  The value was only ever used in an
informational statement.  Since the value was in little endian, only the
first 8 bits of the reason code were obtained.  Fix that.

Fixes: 2bebb4bdc7ee ("netdev: Handle deauth frames prior to association")
---
 src/netdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 867126583215..49854b16d846 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1264,6 +1264,7 @@ static void netdev_deauthenticate_event(struct l_genl_msg *msg,
 	uint16_t type, len;
 	const void *data;
 	const struct mmpdu_header *hdr = NULL;
+	const struct mmpdu_deauthentication *deauth;
 	uint16_t reason_code;
 
 	l_debug("");
@@ -1298,7 +1299,8 @@ static void netdev_deauthenticate_event(struct l_genl_msg *msg,
 	if (!memcmp(hdr->address_2, netdev->addr, sizeof(netdev->addr)))
 		return;
 
-	reason_code = l_get_u8(mmpdu_body(hdr));
+	deauth = mmpdu_body(hdr);
+	reason_code = L_LE16_TO_CPU(deauth->reason_code);
 
 	l_info("deauth event, src="MAC" dest="MAC" bssid="MAC" reason=%u",
 			MAC_STR(hdr->address_2), MAC_STR(hdr->address_1),
-- 
2.42.0

