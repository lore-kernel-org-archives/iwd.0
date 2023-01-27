Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590D933D5
	for <iwd@lists.linux.dev>; Fri, 27 Jan 2023 17:29:34 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id k18so5711393pll.5
        for <iwd@lists.linux.dev>; Fri, 27 Jan 2023 09:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QStyLIzvGJpCFst1sFL54vL2iCkgGWw8Eq0jLWty/bM=;
        b=mi3TK/IOOTjqDr3UVKSiMnVJyCYbacHK5fxRDMuEsNJFpuZF9Q4wukGAiNKjtfawoa
         u82ZyxAaciH9OtjInj8KPeD79Elpv7QBbnSd1s3iu5Dpmowd8J6I8rZyJPxeovuNYeB1
         1eM38koygP2H+tSNVaLvJIOzZxAUmi4eNNk+3jfIaaQodJUctqZmVIt0CexE/4iOq7pN
         G+T+t4VPG+GUeaYMHHIFd1wgBCgfML0b8XmjfCD+5QwvpRPBbBQZCaVg+2RflLjW11vv
         XP3/Arq74JPYZHNEb9fwOUGEC/QIf+dzSb4RBldtHgLfQYGBYlTievn7h2C/8QfZShPA
         KdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QStyLIzvGJpCFst1sFL54vL2iCkgGWw8Eq0jLWty/bM=;
        b=I0OI4Vp0v04mvsEXQ2dB18GDp6McmpPuWC1pjUNGipIhNgToIRHsM5LapZZ92rPK+X
         zFGS4QXfnIdcDPviYzjz7YlTs/HJ+O59QJdRgf/758WcDdtvvcXs3qQ51N9tk1vt2et1
         c/bulf6C1Wh4/Tgh3wLt+ECCiSE3znYeJ2imfW8kf5jE6wHK9hIyU2UJI9xoiiJpTsc7
         cQQTYcLnB5JyRjwxaWzr2a5P7FDRJeLduTlE8I7NHljk/LQn8JrkFGNMJgN6qTATDHnV
         b0Svkx9shxY3uKYL0Fu/0LnqtR9kFx+pzr4H8Y4NX1G+AEBCDtweplzQajzlYg6ws9Vy
         jzQg==
X-Gm-Message-State: AFqh2kpHMHgqybVJlPs/ovkY4dNN3wtkD599HwH9PeYjfVgHniExgkT6
	bw77D04nR5jVdlIMTEuTHw47CizsP6Y=
X-Google-Smtp-Source: AMrXdXuopbwnM/76onTy8AySW4uSDInbfv78GGc7tAaKK8MGi3asMd02RZN7quUXNsZZ/rCqKyTO5Q==
X-Received: by 2002:a05:6a20:b71b:b0:af:6f28:7c42 with SMTP id fg27-20020a056a20b71b00b000af6f287c42mr38083796pzb.62.1674840573461;
        Fri, 27 Jan 2023 09:29:33 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id q19-20020a656853000000b004d09bbd023csm2583890pgt.88.2023.01.27.09.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 09:29:32 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] ap: correct extra IEs length calculation for WMM IE
Date: Fri, 27 Jan 2023 09:29:30 -0800
Message-Id: <20230127172930.2686333-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extra IE length for the WMM IE was being set to 26 which is
the HT IE length, not WMM. Fix this and use the proper size for
the WMM IE of 50 bytes.

This shouldn't have caused any problems prior as the tail length
is always allocated with 256 or 512 extra bytes of headroom.
---
 src/ap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index 10cc0f00..b51befe4 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -939,8 +939,9 @@ static size_t ap_get_extra_ies_len(struct ap_state *ap,
 
 	len += ap_get_wsc_ie_len(ap, type, client_frame, client_frame_len);
 
+	/* WMM IE length */
 	if (ap->supports_ht)
-		len += 26;
+		len += 50;
 
 	if (ap->ops->get_extra_ies_len)
 		len += ap->ops->get_extra_ies_len(type, client_frame,
-- 
2.34.3

