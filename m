Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C4D501
	for <iwd@lists.linux.dev>; Thu, 27 Oct 2022 18:18:44 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id v28so2237720pfi.12
        for <iwd@lists.linux.dev>; Thu, 27 Oct 2022 11:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j9vyij384y8mI1Zkkqi7JBGTGnMAxKNRZblhXnSuYAo=;
        b=Yonh1PETEhKKH6j3r9K3yiN28FvdMj5h0BSiaJf13Hu8E+8qLCUdyjA1HST2z5d3c4
         9Z3DhJAPZCcgVOSf936dnk3wGMlU+9hhWZj7WPB+JFhx7NtfX6B/O+tKT4D8uL+x/fat
         j/O7NtoZ/EKx93AjEU6EnsaJgymsu2moZe8fagNV6nLHUBEgGJdL49m9RkFATxAOxj6/
         W9nu/BA/K7GE4OsCJm/uU3k5F0Eeow+AguJRelvtxZMYZvMPE2DDISGIj/CjnVR1G9Wr
         v312fhwhNSmFCaLMs41eeuBHakOZ0B5ukawiWv/2D6HZMp7MuISnQrOf0NJo8gNZtrmj
         EUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9vyij384y8mI1Zkkqi7JBGTGnMAxKNRZblhXnSuYAo=;
        b=x0dGr438UCuvg6kQn8WRJMJvvqZob0GUmfFnOawEsA0ChyGXXprJmsghAHrtVtKZz5
         JBKOkpNbu2CtZ8jT8SOyyq0Op5rQKUu/InwIJsRLL6tmdAEDBh1hqVlJ2HYqdJrgrQim
         CEKvy/A6HV2B0wKDWh0mzMm6dB4W0jYqIflouD9OEQy6LzEPQUnonWkVfeEFmg0qLhST
         Yhyl/TOS0DzlpY9JSdJZyHH/3Dy52bJJ4ddvgDwQRQdt9wtaT/ZVH8KwSMnuurPDYdhu
         5e2wFzMM5uGotc/db5RFA9SfVxQ1MMvKaRw4RgxieqpRGBHDtMnrcb5dJ+EndxmlF6cj
         zTIw==
X-Gm-Message-State: ACrzQf2PJkn0KQ462b6rwvqzsqMW+G3Q+0ZV9HvHqJnVOWGIoGuKlqhl
	v9fzmxC+z7mzqRssvyftOB9z1xc80ZE=
X-Google-Smtp-Source: AMsMyM614RBNhpoUHoqDEz/YyKyYudiLXX3pGfzz2hlGD/iHN/egnLjD5AS5jMPSxo0QhZ5KhosMeQ==
X-Received: by 2002:a63:6b88:0:b0:46a:ff3c:b64a with SMTP id g130-20020a636b88000000b0046aff3cb64amr42857427pgc.196.1666894724171;
        Thu, 27 Oct 2022 11:18:44 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id x190-20020a6231c7000000b00563ce1905f4sm1490048pfx.5.2022.10.27.11.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:18:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] monitor: put nortnl check into nlmon_print_rtnl
Date: Thu, 27 Oct 2022 11:18:42 -0700
Message-Id: <20221027181842.593176-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Doing this allows --nortnl to work when reading pcaps.
---
 monitor/nlmon.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index d786cc33..9694cfd1 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -8089,6 +8089,9 @@ void nlmon_print_rtnl(struct nlmon *nlmon, const struct timeval *tv,
 	int64_t aligned_size = NLMSG_ALIGN(size);
 	const struct nlmsghdr *nlmsg;
 
+	if (nlmon->nortnl)
+		return;
+
 	update_time_offset(tv);
 
 	for (nlmsg = data; NLMSG_OK(nlmsg, aligned_size);
@@ -8207,9 +8210,7 @@ static bool nlmon_receive(struct l_io *io, void *user_data)
 		case NETLINK_ROUTE:
 			store_netlink(nlmon, tv, proto_type, nlmsg);
 
-			if (!nlmon->nortnl)
-				nlmon_print_rtnl(nlmon, tv, nlmsg,
-							nlmsg->nlmsg_len);
+			nlmon_print_rtnl(nlmon, tv, nlmsg, nlmsg->nlmsg_len);
 			break;
 		case NETLINK_GENERIC:
 			nlmon_message(nlmon, tv, tp, nlmsg);
-- 
2.34.3

