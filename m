Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882ED4C91
	for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 22:07:58 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id t70so18573199pgc.5
        for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 15:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=d0qoZc7uTbFM5pvfx7P1VKANZtyQYiTi9coTWeogmEE=;
        b=djeLibUzMdsa00xEarffUc+gNI/4/LQC87G84cIo8zDgWhe+x7bZ+0JD4E2m/N4xEH
         W4G4Z4BU4aXG6xHAyBvSBGSUCFzkuxt5ukWxGLPhQz2357emIl3LAG94VYG9rQuYXyPF
         vZ+N0kE64+G+UsraYOiaYLuqtRp//HuFvoQVAy762I4FYZyIht4meabot024TAsQXeB0
         tyG0C0N1jSl7uHN/6/fUVjbEjmZbwNZgdC0Kx3VG8COkLdVKRexh9Fxooz/lSWLefdA0
         wKHONmUyTKOJ3v4ohA0W0N1sY+/MLpZogNiWt8zSzq8lB5IGfalYUKRDlG8WLqwdWEb3
         Vy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=d0qoZc7uTbFM5pvfx7P1VKANZtyQYiTi9coTWeogmEE=;
        b=vU8u6lwZcl9CFuJW415u/VehgNSH+pK0M7nFqz10GKvRkz4yGj6ZEW//eRJ2tUxSmP
         8vpRhxQGGNBdLhrIADt47zJlnIFscp9baRq6bO/ISl054e0Hr7ndoPlHDTJkqxfZsbXU
         NHBE5lBJjTVhBJv8EWZfSRmwyHSo6Vh1AOh1w2y6XUeyImxYRmwDq+mDNkA9QMME5cs9
         qaV4fzwsnEIFtvpOJOSmBtDgE96o8HFroYW/08KEqsmA7EZScbZKZ+Sj4gPUfJen/K8y
         zlkEVBG+gCysO39rzt6cusla9SPMhNASXjtjBYkEj6oZQ+I+/WjtMkLE4+oRZJDRpFfT
         3FGg==
X-Gm-Message-State: ACrzQf2oD5iLrTC/+Gc61kOj/aZIVPBCwXtQIfs3OQmB9CpSkGeZ4rqh
	GMI1VSXNSnG1ri3Z8+yU9Y5yn74b6fM=
X-Google-Smtp-Source: AMsMyM5vhUcJfpaRNXzfO8B3wWHVXCQ1L9VZhG/V7B97cmxjiZgZ8q6Z7ucYY7on/s+qk9MNP/ZJ+A==
X-Received: by 2002:a05:6a00:1ac6:b0:548:962b:4c50 with SMTP id f6-20020a056a001ac600b00548962b4c50mr1939111pfv.76.1663279677874;
        Thu, 15 Sep 2022 15:07:57 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id k2-20020a6555c2000000b0041c0c9c0072sm12147165pgs.64.2022.09.15.15.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 15:07:57 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 10/14] ft: add ft_sm_can_associate
Date: Thu, 15 Sep 2022 15:07:37 -0700
Message-Id: <20220915220741.1128728-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220915220741.1128728-1-prestwoj@gmail.com>
References: <20220915220741.1128728-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checks whether or not there is a cached authenication for the target.
---
 src/ft.c | 13 +++++++++++++
 src/ft.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/src/ft.c b/src/ft.c
index 2dfa7a11..3b3ca83b 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -1119,6 +1119,19 @@ int ft_associate(struct ft_sm *sm, const uint8_t *addr)
 	return ft_tx_reassociate(sm);
 }
 
+bool ft_sm_can_associate(struct ft_sm *sm, const struct scan_bss *target)
+{
+	struct ft_info *info;
+	struct ft_info_finder finder;
+
+	finder.spa = sm->hs->spa;
+	finder.aa = target->addr;
+
+	info = l_queue_find(sm->ft_auths, match_ft_info, &finder);
+
+	return (info && info->parsed);
+}
+
 static int ft_init(void)
 {
 	sm_list = l_queue_new();
diff --git a/src/ft.h b/src/ft.h
index 1a18cd0e..56702369 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -41,6 +41,8 @@ int __ft_rx_associate(uint32_t ifindex, const uint8_t *frame,
 struct ft_sm *ft_sm_new(struct handshake_state *hs);
 void ft_sm_free(struct ft_sm *sm);
 
+bool ft_sm_can_associate(struct ft_sm *sm, const struct scan_bss *target);
+
 int ft_action(struct ft_sm *sm, const struct scan_bss *target);
 int ft_associate(struct ft_sm *sm, const uint8_t *addr);
 int ft_authenticate(struct ft_sm *sm, const struct scan_bss *target,
-- 
2.34.3

