Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609C55C85
	for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 17:36:12 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id az27so11097639wrb.6
        for <iwd@lists.linux.dev>; Mon, 29 Aug 2022 10:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=erzAfbwNpaswzKoJ9WFNP4c5bfvxXP/GZw9ba4+4iz4=;
        b=AX2F2mpnkbIcBJQEnHOwUgITD5TECsjWbQb6Mgco7SkjuLqx26PPBkndLtyBWTyFc4
         m8JYoPab+bwjcWRVGk0s4jhNI50yCi/MuwVL2/uqcZhTM60gyzETE+ZH6/crO1o0cuHh
         Fw1iiiT8OkgRJRUb2P3T0Rbk4zEMBRXVXz+SvObhXahVPHloOLrSTXdVjLIoYmHnBuh/
         G9mfefoVIQnfw+uyfJ2IL5D07pWuoB/+ReSvsa86bfX1pnJOS3HRbU3eOUnK0HKFy6nk
         afHmRohOGZ+icFSavXv1YI34Emmy/Uli9CE5CBcJ2oyQCvqkFC5S1rHTK2fsBIm1cehK
         hGOA==
X-Gm-Message-State: ACgBeo1dwUZsLu4sVpdjrhWdkUGJVHTfUAwjvEs6v8/giAZWBGifPAxc
	r20wV8DumTOfGWfizTdgLyRQY9Rta3xrng==
X-Google-Smtp-Source: AA6agR5IcgtB7iBqYMd7C5cRxuh9qy74EU/vhjSmhQxzSrEl2y3+hE+yDWQEcnsrfowsbzhZGP0qRg==
X-Received: by 2002:a05:6000:137b:b0:226:d465:c8a9 with SMTP id q27-20020a056000137b00b00226d465c8a9mr5463692wrz.267.1661794570484;
        Mon, 29 Aug 2022 10:36:10 -0700 (PDT)
Received: from iss.ger.corp.intel.com ([82.213.228.103])
        by smtp.gmail.com with ESMTPSA id q3-20020a1ce903000000b003a61306d79dsm9830551wmc.41.2022.08.29.10.36.09
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 10:36:10 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 05/10] netconfig: Store pointer to netdev instead of ifindex
Date: Mon, 29 Aug 2022 19:35:56 +0200
Message-Id: <20220829173601.1963953-5-andrew.zaborowski@intel.com>
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

To avoid repeated lookups by ifindex, replace the ifindex member in
struct netconfig with a struct netdev pointer.  A struct netconfig
always lives shorter than the struct netdev.
---
 src/netconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 13960c53..74eaca16 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -54,7 +54,7 @@
 
 struct netconfig {
 	struct l_netconfig *nc;
-	uint32_t ifindex;
+	struct netdev *netdev;
 
 	char *mdns;
 	struct ie_fils_ip_addr_response_info *fils_override;
@@ -581,7 +581,7 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 
 	netconfig = l_new(struct netconfig, 1);
 	netconfig->nc = l_netconfig_new(ifindex);
-	netconfig->ifindex = ifindex;
+	netconfig->netdev = netdev;
 	netconfig->resolve = resolve_new(ifindex);
 
 	debug_level = getenv("IWD_DHCP_DEBUG");
-- 
2.34.1

