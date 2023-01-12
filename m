Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB56F847C
	for <iwd@lists.linux.dev>; Thu, 12 Jan 2023 19:32:20 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id d9so21212451pll.9
        for <iwd@lists.linux.dev>; Thu, 12 Jan 2023 11:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2dMBLdp/cSDQSwvGWM5UwCjg5T9c7KTOFWtchu/kaQ=;
        b=nx0sM8Jzv2hN4xvKyOfeDYioQSzb4P6PHCXeN6pnCZq45QxcYeJn2EAVIypAFWQCMx
         EbJfbvSipL4ZyznMYLddX1KTA+tbiqYQ6hiSWyc6paHlGnW+MkaNgAQjzX02KPOrltYi
         dzaIRoisH2X6KmptjZr8PWnok6yL1FnbX4DwluuBoMu+46bPQS2PgYAQJi/n5+I8YmY1
         Bd2ydfvVW0CWVDcpGo5a0aQM9YP5h3I4W4pIzeD8zdZ5AN7a0+ulyvBKwqp20dqh7cYi
         0oyJhZ+Ot2aTKGdOum96gMGZhBU3uZVfkCtsOm+X9O5hNIee188XGyM+zVfG4mdTzRDo
         uhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2dMBLdp/cSDQSwvGWM5UwCjg5T9c7KTOFWtchu/kaQ=;
        b=CX10oTeEbkKWd+CBadiwniB25BRiqdHj4cEuOrwaHqC7TMUz8IL2xu2C/JEybB6vP8
         zff7aP2jee7Xgrl8Um0nGB1tWPoZOjvCzThvdaHtcuApsDZ9Uh9Qe0qHWjBCYPJYgB6R
         bPywmVJROhgakbH0dUuYRRlmF+UlmjFuzf1GzAWUu8AIrelvPBv+mI3h9ySEVVBlW5Sh
         ru+DJ7Pv3UhyuFR9iV6k5zDl5BduyO0M7O4/4ufK/w4ih8dFlwKh58bS4zDq1Z/2pMk8
         d8L0SMpYKTdewy1nCLQGlzdMSRlo6vF0+INIg3nomBcKIlyceCIWwj2bMK90CuNfomAQ
         eOkA==
X-Gm-Message-State: AFqh2kqZPuyiQBTwF6rY2xzGg9BzZXI8crX6f7j1N6XCoE5diJp0zLu8
	5CYqEpgVmZExJZBgh0iVbNkwmXpCfug=
X-Google-Smtp-Source: AMrXdXvcYLN6tOrSwcjA/LLcIf8ZjSvd5zNdTFd3mp8TKCFKW9iG5cQU5HlwTuyYsQpa6yjZht+g9w==
X-Received: by 2002:a17:90a:bb03:b0:225:a226:9fbb with SMTP id u3-20020a17090abb0300b00225a2269fbbmr76559765pjr.39.1673551939904;
        Thu, 12 Jan 2023 11:32:19 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id qe12-20020a17090b4f8c00b00218fba260e2sm12732147pjb.43.2023.01.12.11.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 11:32:18 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/4] eapol: detect message 2/4 retransmits
Date: Thu, 12 Jan 2023 11:32:10 -0800
Message-Id: <20230112193212.568476-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230112193212.568476-1-prestwoj@gmail.com>
References: <20230112193212.568476-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the authenticator has already set an snonce then the packet must
be a retransmit. Handle this by sending 3/4 again but making sure
to not reset the frame counter.
---
 src/eapol.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 2048a87d..c1ef8f90 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1645,12 +1645,18 @@ static void eapol_handle_ptk_2_of_4(struct eapol_sm *sm,
 		sm->handshake->support_ip_allocation = ip_req_kde != NULL;
 	}
 
+	/*
+	 * If the snonce is already set don't reset the retry counter as this
+	 * is a rekey. To be safe take the most recent snonce (in this frame)
+	 * in case the station created a new one.
+	 */
+	if (!sm->handshake->have_snonce)
+		sm->frame_retry = 0;
+
 	memcpy(sm->handshake->snonce, ek->key_nonce,
 			sizeof(sm->handshake->snonce));
 	sm->handshake->have_snonce = true;
 
-	sm->frame_retry = 0;
-
 	eapol_ptk_3_of_4_retry(NULL, sm);
 }
 
-- 
2.34.3

