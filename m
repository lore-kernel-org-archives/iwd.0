Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAB3BA41
	for <iwd@lists.linux.dev>; Fri, 13 Jan 2023 21:24:40 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id e10so15819471pgc.9
        for <iwd@lists.linux.dev>; Fri, 13 Jan 2023 13:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dw5B+8kuOkg3sIlnsl/1jWmXrytAfrKNEUyUIU+JY/c=;
        b=l8lD6PyWrD/FyhJwV3KAPIvc6J9aZHDcDyewuC6BRWGHrEfLgscPehzmulsbzM2Q2+
         52pGXSbXFKjeYM7ggRuc9zUT2UVaWJH7y4wO64OKf5l48OlNuyC8HWZ4qu7+6hLplwEW
         1HAXgt6VuopWRU70ZkbBa+/XGx19a7/6RiTf/yi98HKzA9aL5deputuiHI+u0zo8zPJe
         UVnSTjp6tNmtM+CLAeZAcBFstEL4rplFAv6cBPPFuhZ7AHgEAR9EUkjeKCw5shB9CG+P
         1fx4byV6p7VUMWsutd6xJbNj/qX0XBvI6sdKO2QqZemG7n5n7jxXM9ySBfSXI8AjFDH/
         k6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dw5B+8kuOkg3sIlnsl/1jWmXrytAfrKNEUyUIU+JY/c=;
        b=AUGYV91w/AbfV6qe/S09q0F29hElp1wEvYs1aiaZgCqhqIQV/us2GNpWCwnZrev1XN
         RXfnF9jPf7FT3L1Ioysq6V4GNjU2Q9vQpwv4PrFoaxMmXmyWePVXAgbq+GsBCnDX4eYB
         lpQjhE+ExdnBo6iAcmCPVy/oGMqoNpXtJRf29KEgj8TPbE4XIEo1I1s2LgX1jtSMIJ9x
         qhs3lbyedP6eRSXMHhYDq3u4Xw3UStRPclf1Hb7C0SVZYimFrHxwd+aKK1vkt7+mjFVJ
         jOu3AURaFlfoEf41Td0v6U9ZdW5Su6qZvUvB5PMyrjcf5DUsmB664NVaozDi23CBRn1m
         zKiQ==
X-Gm-Message-State: AFqh2koII4V6H9jXo7lWn/0mRQfyf73CSaAyhtQfohtDwyMiQLh+MdDx
	7GoFn6t81Eoovg7GEOOq8rpOLc0nZp8=
X-Google-Smtp-Source: AMrXdXv7qKwbZqqdvZghuUvECQgpfhkQy6sMOdE3zpxGS4/4Iq4+xPBIpoNLMmFueIx0S53cy1f0Hg==
X-Received: by 2002:aa7:8599:0:b0:588:eac0:b05b with SMTP id w25-20020aa78599000000b00588eac0b05bmr17805892pfn.27.1673645079721;
        Fri, 13 Jan 2023 13:24:39 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id 66-20020a620645000000b0056d98e31439sm14562829pfg.140.2023.01.13.13.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 13:24:39 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/3] station: cancel roam timer when FT starts
Date: Fri, 13 Jan 2023 13:24:36 -0800
Message-Id: <20230113212436.794519-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230113212436.794519-1-prestwoj@gmail.com>
References: <20230113212436.794519-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Past commits should address any potential problems of the timer
firing during FT, but its still good practice to cancel the timer
once it is no longer needed, i.e. once FT has started.
---
 src/station.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/station.c b/src/station.c
index ed98a8d8..381065a2 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2299,6 +2299,11 @@ static bool station_fast_transition(struct station *station,
 	vendor_ies = network_info_get_extra_ies(info, bss, &iov_elems);
 	handshake_state_set_vendor_ies(hs, vendor_ies, iov_elems);
 
+	if (station->roam_trigger_timeout) {
+		l_timeout_remove(station->roam_trigger_timeout);
+		station->roam_trigger_timeout = NULL;
+	}
+
 	/* Both ft_action/ft_authenticate will gate the associate work item */
 	if ((hs->mde[4] & 1))
 		ft_action(netdev_get_ifindex(station->netdev),
-- 
2.34.3

