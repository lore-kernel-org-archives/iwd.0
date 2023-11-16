Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E41EACB
	for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhkzZPgh"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-41cbf8e1f77so6851381cf.0
        for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 10:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700160310; x=1700765110; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0RztHXs19y7K8vEwMVjpk4GbmngtwrpQSgC2fAdauU=;
        b=EhkzZPghTRwN1J/+e/+GhdyiyZFod8kYp+u+Ov614Z21ciZFmG6y5lprd0q99NlYAM
         6MlWgfJi4j46W0YYKTAhAJJ3+EmO2VABTug/I5vSZAZpOJ/nVqYmZN6suT7ieLtvcSoJ
         M5A2onnMqTJQvlzK0PeuVLRU1aBiqgCQEJf+bkOXn8qoVqqO87+4xjfJZKrzAC2npQ1p
         in1GHosl+co4KIWy2QqrsCVDJFaWNonXe0WY6y5G7JPKu+4Zg9zJM94lTjQXu+9DzL07
         18W7wBNoErWcdBAEVQrj54zY4KI0PKu74W6bZq/6HWMNjmIL3laVsAJOJ3uResT/RsdR
         hkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700160310; x=1700765110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0RztHXs19y7K8vEwMVjpk4GbmngtwrpQSgC2fAdauU=;
        b=KA2RkvUUQ+pPzi/jj0g9C1ln+XgXN/4WYZncxbGomzXpJvp24/wEw28UoxyiVT2nbO
         CGDlj6kkb8XIlgPDH5z1L7e0Lb2vcw15GzMQ1iysBtS1q1N2c1VoBqNLz8GTNjI9rXG7
         +nh4eigB/MSQQyOMGoLMlJVquuvG5bMr1xUkJTUB7BK0h8wBNehUcshl4KCYa8Jl0XMq
         OIhICMaq9fEbaDyAEM1GGBzhu9CFFE6g+mZMxo2fdlkVjdnx/4AjIHqSHCFsK2ZRrYKs
         e1+jLvgvzKuMamIuMY/3pO50F4xEVp7yOh4KlMGIAUcQ48X//wWPsqHd3s/Qnt94WPwH
         J5yQ==
X-Gm-Message-State: AOJu0YwUdUP1PBlftapawI958cUryE62cjBfvCEm+3I3ML3yAOgadHtR
	Y9dKrQB3uKIK0SejxDw9cnPRJBe47Ok=
X-Google-Smtp-Source: AGHT+IEgQpksh/Zfz8RcUJytmSPh6011rqCwd3WdxPYD44xoKACpnRXNV/WS/LHDdYOTfyzldDxzDw==
X-Received: by 2002:a05:622a:1714:b0:41c:bb79:ad45 with SMTP id h20-20020a05622a171400b0041cbb79ad45mr12100993qtk.12.1700160310310;
        Thu, 16 Nov 2023 10:45:10 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id b7-20020ac84f07000000b004196d75d79csm4533261qte.46.2023.11.16.10.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:45:09 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/3] dpp: use the config's SSID to process scan results
Date: Thu, 16 Nov 2023 10:44:59 -0800
Message-Id: <20231116184459.292601-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116184459.292601-1-prestwoj@gmail.com>
References: <20231116184459.292601-1-prestwoj@gmail.com>
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
index b1f9c5ac..fab114ad 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -861,7 +861,6 @@ static bool dpp_scan_results(int err, struct l_queue *bss_list,
 	struct dpp_sm *dpp = userdata;
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
 	struct scan_bss *bss;
-	char ssid[33];
 	struct network *network;
 
 	if (err < 0)
@@ -877,18 +876,18 @@ static bool dpp_scan_results(int err, struct l_queue *bss_list,
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
 
@@ -1089,7 +1088,7 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
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

