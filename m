Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C155C8C
	for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 17:36:16 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id n17so11112586wrm.4
        for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 10:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=ajapKYbC1wXoK0puSRpzhKGYSAuPgMPOI5PRE+fqPiI=;
        b=FGhYc5TidG9K8jXQa3oG+iqH+ICCRH29w9fOarkgdCgN1/tqiuW34m26J/l4F5ED8b
         XSq/W6S+I2tjlrIOEWMahYYxqBr9RbfBtNAX4OV4DYTAIK67Jm7VVUujY+EC2T+igArv
         2nQos2/sn2ETPxDJFJ5knK0/1XocQpgS4OAQ6NAsapPqn2jAOW9elk4FHGhIM0/N+LtI
         i1b+TFVDqXTt4rCKhK1A9SU35QXHvhdO2Skv7IKUOtSH9JXKBNl9gHuepbmJA8hm/IZ7
         ZrHTahSpzET1CMbUuVC1Ha7F5ZT2Qmhy/KSYwefNXJ4i3HZWPB6vckoJbvpTUhoz5VBm
         FZzQ==
X-Gm-Message-State: ACgBeo2CTn8ln6LWGUUVivVIPNZU6GIsxz4zJ6JAnQdtavsAizP7WjfB
	GRS+3YeVEYOuoV48YF8Hpyu9tqxGkvMypg==
X-Google-Smtp-Source: AA6agR5cxLc6EsXEE11MTisFscrWqcH5Zrwg5Zcln5LOjg/jIoD2jvWo4mrdFOFqQ4T6JItIeft5DQ==
X-Received: by 2002:a05:6000:1ac8:b0:220:6af3:935d with SMTP id i8-20020a0560001ac800b002206af3935dmr6913414wry.549.1661794574274;
        Mon, 29 Aug 2022 10:36:14 -0700 (PDT)
Received: from iss.ger.corp.intel.com ([82.213.228.103])
        by smtp.gmail.com with ESMTPSA id q3-20020a1ce903000000b003a61306d79dsm9830551wmc.41.2022.08.29.10.36.13
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 10:36:13 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 10/10] netconfig: Skip update if resolver data unchanged
Date: Mon, 29 Aug 2022 19:36:01 +0200
Message-Id: <20220829173601.1963953-10-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220829173601.1963953-1-andrew.zaborowski@intel.com>
References: <20220829173601.1963953-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/netconfig-commit.c | 31 ++++++++++++++++++++++++++++---
 src/netconfig.h        |  2 ++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/src/netconfig-commit.c b/src/netconfig-commit.c
index 78670166..9894ace2 100644
--- a/src/netconfig-commit.c
+++ b/src/netconfig-commit.c
@@ -51,10 +51,13 @@ static struct l_netlink *rtnl;
 
 static void netconfig_rtnl_commit(struct netconfig *netconfig, uint8_t family,
 					enum l_netconfig_event event);
+static void netconfig_rtnl_free_data(struct netconfig *netconfig,
+					const char *reasonstr);
 
 /* Default backend */
 static struct netconfig_commit_ops netconfig_rtnl_ops = {
-	.commit = netconfig_rtnl_commit,
+	.commit    = netconfig_rtnl_commit,
+	.free_data = netconfig_rtnl_free_data,
 };
 
 /* Same backend for all netconfig objects */
@@ -262,8 +265,14 @@ static void netconfig_dns_list_update(struct netconfig *netconfig)
 	_auto_(l_strv_free) char **dns_list =
 		l_netconfig_get_dns_list(netconfig->nc);
 
+	if (l_strv_eq(netconfig->dns_list, dns_list))
+		return;
+
 	if (netconfig->resolve && dns_list)
 		resolve_set_dns(netconfig->resolve, dns_list);
+
+	l_strv_free(netconfig->dns_list);
+	netconfig->dns_list = l_steal_ptr(dns_list);
 }
 
 static void netconfig_domains_update(struct netconfig *netconfig)
@@ -271,8 +280,14 @@ static void netconfig_domains_update(struct netconfig *netconfig)
 	_auto_(l_strv_free) char **domains =
 		l_netconfig_get_domain_names(netconfig->nc);
 
+	if (l_strv_eq(netconfig->domains, domains))
+		return;
+
 	if (netconfig->resolve && domains)
 		resolve_set_domains(netconfig->resolve, domains);
+
+	l_strv_free(netconfig->domains);
+	netconfig->dns_list = l_steal_ptr(domains);
 }
 
 static void netconfig_rtnl_commit(struct netconfig *netconfig, uint8_t family,
@@ -280,7 +295,6 @@ static void netconfig_rtnl_commit(struct netconfig *netconfig, uint8_t family,
 {
 	l_netconfig_apply_rtnl(netconfig->nc);
 
-	/* TODO: cache values and skip updates if unchanged */
 	netconfig_dns_list_update(netconfig);
 	netconfig_domains_update(netconfig);
 
@@ -292,12 +306,23 @@ static void netconfig_rtnl_commit(struct netconfig *netconfig, uint8_t family,
 		 */
 		resolve_set_mdns(netconfig->resolve, netconfig->mdns);
 
-	if (event == L_NETCONFIG_EVENT_UNCONFIGURE && family == AF_INET)
+	if (event == L_NETCONFIG_EVENT_UNCONFIGURE && family == AF_INET) {
+		l_strv_free(l_steal_ptr(netconfig->dns_list));
+		l_strv_free(l_steal_ptr(netconfig->domains));
 		resolve_revert(netconfig->resolve);
+	}
 
 	netconfig_commit_done(netconfig, family, event, true);
 }
 
+static void netconfig_rtnl_free_data(struct netconfig *netconfig,
+					const char *reasonstr)
+{
+	l_strv_free(l_steal_ptr(netconfig->dns_list));
+	l_strv_free(l_steal_ptr(netconfig->domains));
+}
+
+
 struct netconfig_agent_data {
 	uint32_t pending_id[2];
 };
diff --git a/src/netconfig.h b/src/netconfig.h
index 289a78e9..f04899ad 100644
--- a/src/netconfig.h
+++ b/src/netconfig.h
@@ -44,6 +44,8 @@ struct netconfig {
 	bool gateway_overridden[2];
 	bool dns_overridden[2];
 	bool connected[2];
+	char **dns_list;
+	char **domains;
 
 	const struct l_settings *active_settings;
 
-- 
2.34.1

