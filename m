Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4BDBD02
	for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 20:15:53 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id g68so10235656pgc.11
        for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 12:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOpUwcyrz0ATzGlmpL7zkrzuMoHEmFqhkbqFm+yf8fM=;
        b=lpZ83E8xxbWqvIyfBM/Aabi8wMueIK4x/WHzkGZD3wUILrA054HBDqzpjL128iR0yB
         AFCM/Q8YIxxzIx0N5rKqN74O2a0t6by+vUJeaNypkcvF8rYdWgC1oBsEuWamrqLm2QHH
         RKGX9P5xPuz4T8qaJuuK2UPo//Dhp1+lXajLS+rXb0pIGLvGt0umePvcJMc30CSSbh2O
         K8ZC7JyAdp6/5DLKGeFg0obS+tsxsMFAvrVchvZQgBKDolYd4WyuRwupenoN4B8GkMZi
         zMTFj3o5Y+R1O08ndd3d886a1qqg14693t69NQrA5b7cBSufvsr7B8pUesTqdOu2i4p4
         qqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOpUwcyrz0ATzGlmpL7zkrzuMoHEmFqhkbqFm+yf8fM=;
        b=ZJKutiiwq6DYe2r9QlIjh+rXigB5EOMGVcEW3w7wjum9xuT0Q9evCvIXvaW8CRWCYV
         RraUfQEbZhMYoEy0TVcgdMT8oPrY5bVxlaDS1Vne8Q+Hq82JUdhAzK4wIay6IPKWypVu
         vquaKUoNniNb1DiTzopxpRgCg7k3eoz7dlFjZyw6T7ASRFvXKZcFdOa4Mqyiwj+S0vL+
         Nvt3xnmXaNj2RYPsDdHCD3oYOaSsF58i0o7gL1w0gYvwFm8CneIAVee8zQZwVSEeAs76
         VcpJh3kNqJ8icyOw8EG0x9fOWSrP2/JX58Y5zkVf3Km+3RsmJZngqeXcTozwp6i1tX+s
         gr/A==
X-Gm-Message-State: AFqh2kovPcxhNQoBSKbza4t0UTMDlRxVLjESRn9VlHTG4GlUz1oyTQN0
	UcpvwGx+PGdJ6B9NEPHG14UPaee5p70=
X-Google-Smtp-Source: AMrXdXul5AvVZxE9T+zQL1E4lSUPZFe9GQRbvVaPwyFcG1s/7dve55Rs9VHmzABezkF1cdibXih3Zw==
X-Received: by 2002:aa7:93ad:0:b0:58a:9619:9b30 with SMTP id x13-20020aa793ad000000b0058a96199b30mr3676955pff.10.1673468152969;
        Wed, 11 Jan 2023 12:15:52 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id i6-20020aa796e6000000b005884d68d54fsm6733904pfq.1.2023.01.11.12.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 12:15:52 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/9] netdev: unset ptk_installed flag for TK
Date: Wed, 11 Jan 2023 12:15:39 -0800
Message-Id: <20230111201543.397692-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230111201543.397692-1-prestwoj@gmail.com>
References: <20230111201543.397692-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the TK is installed the 'ptk_installed' flag was never set to
zero. For initial associations this was fine (already zero) but for
rekeys the flag needs to be unset so try_handshake_complete knows
if the key was installed. This is consistent with how gtk/igtk keys
work as well.
---
 src/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index cda8d183..fc8a2afa 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2024,6 +2024,8 @@ static void netdev_set_tk(struct handshake_state *hs, uint8_t key_index,
 	const uint8_t *addr = netdev_choose_key_address(nhs);
 	int err;
 
+	nhs->ptk_installed = false;
+
 	/*
 	 * WPA1 does the group handshake after the 4-way finishes so we can't
 	 * rely on the gtk/igtk being set immediately after the ptk. Since
-- 
2.34.3

