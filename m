Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356452554B
	for <iwd@lists.linux.dev>; Wed, 20 Dec 2023 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XScBBOT9"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ba2dc0f6b7so4494217b6e.2
        for <iwd@lists.linux.dev>; Wed, 20 Dec 2023 05:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703077932; x=1703682732; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQsffKd75SXUXTs1iJokSm7cplWNDRyOZ77HR3l3p8A=;
        b=XScBBOT9fbVn3f5PemgaQwwcXwFnvORbF/KBkjmP5VEo/q8CDNJqD+VGsr8v2Ahlv8
         NGrVCKvWJpVFC9tIChvt2WaIBCAvqnPftNtCcq3pV5mSBNbeySkTjtK+Vki1f4lhl5Nn
         DyQUS7ieMgXe8JNdSNz5IBRmjC2VzKsJFltQRKZw4v9Ri8+ayk8RxC3b49qg4BNS6B4A
         DPo0Tkw9t1Pa303b0rWQEta8hKXNPltZopqMvCPyiFtgfE6AbMkmLpvaP0I1Dd6t3QxQ
         TUIVtae26uWA0zNlM35nMLbOWzZbUm98RWdGb+DHTCYNzcQBV+1tTkeXm+WjkyK6FTKi
         ys4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703077932; x=1703682732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQsffKd75SXUXTs1iJokSm7cplWNDRyOZ77HR3l3p8A=;
        b=p2FQV1nTmJdNcEDwAuYuGkFcuKn3l5P5M64kH8BMaWpLfkxabJf/5IKQ1Jutx54NM1
         hdmw+AlpPh0rgJl8UzF8GFG1ji2+s2sKj0wnUvcEp0+wzIMFA0re3s4XhfStithLhp9F
         broEj7Gel8wCXu0hdGEJsFPrHfd4EB6us3MDcABB3/00ULQTrx4boutFqVADH4+/5lm4
         uEGNW6KBjn6noTZpY7daBorJ/8UU5K2VOisWLk5SLe8OM+pgF+zlcFZNLHxjdPy2hToA
         1CFUj8SDVUsufnK+Usa/UbV/n5RxxQiC78PBQsXRzKUYAgt3WeBxKLh/ktjryGMladCe
         Ck9w==
X-Gm-Message-State: AOJu0Yzinw5v6iOlewYu3/3zeMr9Yy5CaP7vAuLEEAlfq14OGdvpkmcz
	SeoJiBeE9/UV0HXeJM8r6uscsqPrruY=
X-Google-Smtp-Source: AGHT+IFHaT1eyV7HVi0mjBmt9z9GrgqVH+EJerhGILtTLGdLYSXRLOxknvBoY10vtiXISyaxgRYn0g==
X-Received: by 2002:a05:6808:1248:b0:3b9:e828:819 with SMTP id o8-20020a056808124800b003b9e8280819mr25369822oiv.44.1703077932137;
        Wed, 20 Dec 2023 05:12:12 -0800 (PST)
Received: from LOCLAP699.barrett-olive-branch.locus ([50.222.209.222])
        by smtp.gmail.com with ESMTPSA id j15-20020aca170f000000b003ba3a9c553esm2109591oii.30.2023.12.20.05.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:12:11 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/7] network: call network_connected with BSS
Date: Wed, 20 Dec 2023 05:11:56 -0800
Message-Id: <20231220131200.267489-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220131200.267489-1-prestwoj@gmail.com>
References: <20231220131200.267489-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will allow the BSS frequency to be inserted at the head of the
known frequency list, allowing future scans to prefer that frequency.
---
 src/network.c | 4 +++-
 src/network.h | 2 +-
 src/station.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/network.c b/src/network.c
index 3e8770bc..f4496c25 100644
--- a/src/network.c
+++ b/src/network.c
@@ -167,7 +167,7 @@ static bool network_secret_check_cacheable(void *data, void *user_data)
 	return false;
 }
 
-void network_connected(struct network *network)
+void network_connected(struct network *network, struct scan_bss *bss)
 {
 	enum security security = network_get_security(network);
 	const char *ssid = network_get_ssid(network);
@@ -190,6 +190,8 @@ void network_connected(struct network *network)
 		if (err < 0)
 			l_error("Error %i touching network config", err);
 
+		known_network_add_connected_frequency(network->info,
+							bss->frequency);
 		/* Syncs frequencies of already known network*/
 		known_network_frequency_sync(network->info);
 	}
diff --git a/src/network.h b/src/network.h
index f29649f7..e7638899 100644
--- a/src/network.h
+++ b/src/network.h
@@ -31,7 +31,7 @@ struct scan_bss;
 struct handshake_state;
 struct erp_cache_entry;
 
-void network_connected(struct network *network);
+void network_connected(struct network *network, struct scan_bss *bss);
 void network_disconnected(struct network *network);
 bool network_rankmod(const struct network *network, double *rankmod);
 
diff --git a/src/station.c b/src/station.c
index 73de26bb..4facc0bc 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3213,7 +3213,7 @@ static void station_connect_ok(struct station *station)
 			l_warn("Could not request neighbor report");
 	}
 
-	network_connected(station->connected_network);
+	network_connected(station->connected_network, station->connected_bss);
 
 	if (station->netconfig) {
 		if (hs->fils_ip_req_ie && hs->fils_ip_resp_ie) {
-- 
2.34.1

