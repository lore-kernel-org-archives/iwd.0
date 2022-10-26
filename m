Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E8A1C36
	for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 17:58:41 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 14-20020a05600c228e00b003cf4eaef74eso650053wmf.0
        for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 10:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9aeE3nZEsX1Fgmgg2MYH2DqsBad1LaIIoX4Dr5AZnI=;
        b=QgXdCtG+Xn4v3s8nELvatAmttkbgp6eUKKGIx96Z+yVDS5eceL25JXKI0zmk22q2mz
         AMPGJoPVtCdwuXR5/I9V3ZO9/3dEFLieGJ37tb+3To6jrnsRN0NEVb2Qu+ifeRHYFCIr
         B4VkuR6ki7WryB5wXRrxy3OOV9OHoEJ1haBhOJ/DHceUOrSwYOSCp5CIqm1C8HUHROJN
         LsZ9IjnJw6wFOmasdC9MR1wopXxdDcaE80/0gjhY4B06r7LPd3MOpoJdB455PgWoNHiS
         /y2ePrkvQRJtNKnR7L+asre6HcL5wEbKvdzib9DLmMBCnUwfLiqpNFJ7+98RanGB3zn9
         Yw3A==
X-Gm-Message-State: ACrzQf1rOw4YVjLVTY9re06j8EUkVcmL1tpED3TPlmxz3ZSXVf0MseWl
	IWFK2uCpJS34y5R0VCtjY9+klApBYws=
X-Google-Smtp-Source: AMsMyM4e4r4JoeOXGjHGiQuPsrWCQo+8iJtssng2WqrLXw9dSYb4rYoQLx/wruxYtu2oEA/4nNj8jg==
X-Received: by 2002:a05:600c:1c9c:b0:3c6:f737:42d0 with SMTP id k28-20020a05600c1c9c00b003c6f73742d0mr3458044wms.150.1666807119677;
        Wed, 26 Oct 2022 10:58:39 -0700 (PDT)
Received: from localhost.localdomain ([82.213.230.158])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c304500b003a84375d0d1sm2309679wmh.44.2022.10.26.10.58.38
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 10:58:38 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH] netconfig: Print addresses added and removed to debug log
Date: Wed, 26 Oct 2022 19:58:27 +0200
Message-Id: <20221026175828.2435994-1-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/netconfig-commit.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/src/netconfig-commit.c b/src/netconfig-commit.c
index 96436c1c..0e7c3961 100644
--- a/src/netconfig-commit.c
+++ b/src/netconfig-commit.c
@@ -92,9 +92,32 @@ void netconfig_commit_free(struct netconfig *netconfig, const char *reasonstr)
 		l_queue_destroy(l_steal_ptr(netconfig_list), NULL);
 }
 
+static void netconfig_commit_print_addrs(const char *verb,
+					const struct l_queue_entry *addrs)
+{
+	for (; addrs; addrs = addrs->next) {
+		const struct l_rtnl_address *addr = addrs->data;
+		char str[INET6_ADDRSTRLEN];
+
+		if (l_rtnl_address_get_address(addr, str))
+			l_debug("%s address: %s", verb, str);
+	}
+}
+
 void netconfig_commit(struct netconfig *netconfig, uint8_t family,
 			enum l_netconfig_event event)
 {
+	const struct l_queue_entry *added;
+	const struct l_queue_entry *removed;
+	const struct l_queue_entry *expired;
+
+	l_netconfig_get_addresses(netconfig->nc, &added, NULL, &removed, &expired);
+
+	/* Only print IP additions and removals to avoid cluttering the log */
+	netconfig_commit_print_addrs("installing", added);
+	netconfig_commit_print_addrs("removing", removed);
+	netconfig_commit_print_addrs("expired", expired);
+
 	commit_ops->commit(netconfig, family, event);
 
 	if (event == L_NETCONFIG_EVENT_CONFIGURE) {
-- 
2.34.1

