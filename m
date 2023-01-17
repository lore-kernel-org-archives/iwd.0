Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E20D51C
	for <iwd@lists.linux.dev>; Tue, 17 Jan 2023 18:03:47 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id x4so20011950pfj.1
        for <iwd@lists.linux.dev>; Tue, 17 Jan 2023 10:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Uybk6lh1CziSiyhw1rrh+WUMcgsznRvs0kmtzNF65M=;
        b=PC7QMyz5U9j8Q+dGZ4jvii84zn6l8lOb6Vw9qJXWnE3uH3AuP75wR5MKDeBfckJyGB
         idsvYIJnOz5rEI0xY64JDY0zJ7cKkr4twbzrJ7n3bSLCutFtzn5q9iuNnxvRBCcH3Lwe
         SBwGW280BvRGAP6/kMX66Bw9zxqiNJIwWrCj80B+a7ctx/+ndCBNihvn5WV6C6cds81j
         hFzxoEcOzVALhTGEe76kD692xpqz2reDGEnxXoX2nVezadTfHKCKJA0pSiQ3rIZNnzAc
         YklRINOBzaQjghRYUJbDC2F1MrOFnAgJgzvSxOT5v4F20OhwqcK+SnBJG1P7j+Tq9+2o
         F/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Uybk6lh1CziSiyhw1rrh+WUMcgsznRvs0kmtzNF65M=;
        b=EDdbXGQSNOHtnkHyBth9EV8nMCNnPx+/7/TdieIhxWEQtM2h21c3BEPRQQCSQjZzRH
         Mmh0vxkiV/1HrzhDo6RlbSMCNGqcy5YvoEXz0P1y2ulRJu7FpQvGNv81KiED7t2c32Tt
         +k/N+HwcWg9DI0x5kLxF2Ocfw8OL7x+djuOB5FcJU7Mef7WXz1ozRnhg6FBoTORq6F+B
         t0pfXDPa32qaOA38WDYj2xzIriJrxprJt6/J02XP+nsI5QWSzxbRZ+vDORzymK0FcwyC
         JZ/kpn6w7zGHRotOz1EJcg0A/ILXoabr4pfY61x4tj1ZkS+8o2giaM2DkC12WUAdUqCT
         ZaRw==
X-Gm-Message-State: AFqh2kocZGv5Vvrl2QywM7A3+rH5Mc+EedTtibJHe3NLxnhJ0Yh+svsQ
	LaCdpXD4BGjRkmVXAFsGDQyIef5yPEw=
X-Google-Smtp-Source: AMrXdXuWRouXbhLWjH7hdbUr1kQXTIVxuD9n1Pz8YuaFj/9hwR8z9jDvFD5u9QeKVX3Y6iKSS/fR0Q==
X-Received: by 2002:aa7:90d7:0:b0:573:487d:e852 with SMTP id k23-20020aa790d7000000b00573487de852mr3335923pfk.4.1673978626617;
        Tue, 17 Jan 2023 10:03:46 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id d206-20020a621dd7000000b00589ed7ae132sm15235782pfd.13.2023.01.17.10.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 10:03:46 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] manager: handle -ENODEV special in interface callback
Date: Tue, 17 Jan 2023 10:03:43 -0800
Message-Id: <20230117180343.1451626-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230117180343.1451626-1-prestwoj@gmail.com>
References: <20230117180343.1451626-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If IWD ends up dumping wiphy's twice (because of NEW_WIPHY event
soon after initial dump) it will also try and dump interfaces
twice leading to multiple DEL_INTERFACE calls. The second attempt
will fail with -ENODEV (since the interface was already deleted).
Just silently fail with this case and let the other DEL_INTERFACE
path handle the re-creation.
---
 src/manager.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/manager.c b/src/manager.c
index fed02777..f1aa59c7 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -320,13 +320,18 @@ static void manager_setup_cmd_done(void *user_data)
 static void manager_del_interface_cb(struct l_genl_msg *msg, void *user_data)
 {
 	struct wiphy_setup_state *state = user_data;
+	int err;
 
 	l_debug("");
 
 	if (state->aborted)
 		return;
 
-	if (l_genl_msg_get_error(msg) < 0) {
+	err = l_genl_msg_get_error(msg);
+
+	if (err == -ENODEV)
+		return;
+	else if (err < 0) {
 		l_error("DEL_INTERFACE failed: %s",
 			strerror(-l_genl_msg_get_error(msg)));
 		state->use_default = true;
-- 
2.34.3

