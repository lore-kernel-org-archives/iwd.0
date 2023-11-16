Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC7C3A8E8
	for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yiu5BIfI"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-421bcd0b532so6966101cf.2
        for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 11:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700162137; x=1700766937; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEhNSsPteBp0+f9lTaP9Yww42aaSUth8c3O/YHkdmnQ=;
        b=Yiu5BIfIgc22VlB5U3jFr7QafB/WPwdGaD8naL98uWpXN8vEizFB0aILFN+8O+/0AV
         SeBjApRUBfEp3BCPYPgJ7as7HSRtdyd4UGBU6as3LQ8zz3bYsZVniwB2TuXxIScR43tt
         zTBIueblDdp7n+Hg7TstldXAvPh/a6oH1B9ZUMJAeFN2hzUZo1M6l3CVCJC5cbEiFhQb
         1Ct8s6EVAukcKtvzi0OqXpbApog9yZKpzypLw9LX6A5+EspWmKDXh7rKJX0WngkjKHkf
         4uWSArQRHjwrqgQeu1VxGaKSjpuOQpRm8eU9YgDUnBZjmluQNx5GvG3HZxfjaItn/O5k
         PaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700162137; x=1700766937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEhNSsPteBp0+f9lTaP9Yww42aaSUth8c3O/YHkdmnQ=;
        b=Zi7korOvG1b2XByNJit01pnxlP8QfZI8EbrV0a50xvEEETHS5NzDItmtbxOf9uWjl8
         EFq7YG/ngaRPx0j/QzYEw4A9UeQhxFxer3XW1+AwgeRn/6l1JhQi8OhIRmznJX58Pi1U
         P9Nv5Z3Rq+haBwZmXO13P1aYcGK9h9pS84zOokNUjHVIRpKToRQaBDsaaKXC9ABwUIUk
         CMhnyWHxfx41DlyYy0MFkFOm66fkYPoprQwKL9oBkH/Wf7Y/uou5J3pHRoIBwcYeUVO7
         WAXjrVLuXRE6CPWmPyfY9P4ZxCt4qLSCN+dYD+QQlpGqF9lnVUpKe6xtM5lSRMeL4KwI
         Q6HA==
X-Gm-Message-State: AOJu0Yyys8Ct3O/v1XfRHgkUlGfYgWhQxCLnjZjTL2G/196cwK74VBxm
	WGuJcF/l5g/iOCq9Pa6ucnPVMB1RS+s=
X-Google-Smtp-Source: AGHT+IEQEsXlxefx4eTVWTEeqPegYzqxTDRXJAEGrCKRpwnKARt5bskCwM6fF8FLo3edEZXFRYPuEA==
X-Received: by 2002:ac8:5d05:0:b0:417:bd2c:2683 with SMTP id f5-20020ac85d05000000b00417bd2c2683mr12880373qtx.19.1700162136960;
        Thu, 16 Nov 2023 11:15:36 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c14-20020ac8660e000000b004198d026be6sm4376qtp.35.2023.11.16.11.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:15:36 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/3] dpp: use the config's SSID to process scan results
Date: Thu, 16 Nov 2023 11:15:28 -0800
Message-Id: <20231116191528.364340-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116191528.364340-1-prestwoj@gmail.com>
References: <20231116191528.364340-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scan result handling was fragile because it assumed the kernel
would only give results matching the requested SSID. This isn't
something we should assume so instead keep the configuration object
around until after the scan and use the target SSID to lookup the
network.
---
 src/dpp.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 907f3bf5..f8d76805 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -856,7 +856,6 @@ static bool dpp_scan_results(int err, struct l_queue *bss_list,
 	struct dpp_sm *dpp = userdata;
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
 	struct scan_bss *bss;
-	char ssid[33];
 	struct network *network;
 
 	if (err < 0)
@@ -872,18 +871,18 @@ static bool dpp_scan_results(int err, struct l_queue *bss_list,
 	if (L_WARN_ON(station_get_connected_network(station)))
 		goto reset;
 
-	/* Purely for grabbing the SSID */
-	bss = l_queue_peek_head(bss_list);
-
-	memcpy(ssid, bss->ssid, bss->ssid_len);
-	ssid[bss->ssid_len] = '\0';
-
 	station_set_scan_results(station, bss_list, freqs, false);
 
-	network = station_network_find(station, ssid, SECURITY_PSK);
+	network = station_network_find(station, dpp->config->ssid,
+					SECURITY_PSK);
 
 	dpp_reset(dpp);
 
+	if (!network) {
+		l_debug("Network was not found after scanning");
+		return true;
+	}
+
 	bss = network_bss_select(network, true);
 	network_autoconnect(network, bss);
 
@@ -1084,7 +1083,7 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 						dpp_scan_results, dpp,
 						dpp_scan_destroy);
 		if (dpp->connect_scan_id) {
-			dpp_configuration_free(config);
+			dpp->config = config;
 			return;
 		}
 	}
-- 
2.34.1

