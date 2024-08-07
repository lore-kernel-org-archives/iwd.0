Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8450913F42D
	for <iwd@lists.linux.dev>; Wed,  7 Aug 2024 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054491; cv=none; b=hWbhyK07bi5Wr+pwb4rYYDRuYHbGObnNe4C+DxTQ8sxOREITRHt3FpJdOrSTsaCNiLZaXOJy40wtHpnbBqSbZEvLaqnRR7qyNbty9wTVYFxUW8gwgMoHaC8vVPWOvUinYC5g3sXS3vLcjj8M7/Ah+icaFGeQ1eBUbsiE+1E57/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054491; c=relaxed/simple;
	bh=gCdwM5boUrxXJykMfnN7bEjV0cAfhvzuqH+rcGbJXMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e92N4RCX95GpvAF60B94zWQO8kYxxpR/Nj4qB3F8TNhgFharLFx1zZll2KW69pP2i9iJyoB9Nssun7cuIhz9VV0eMmN2Ne3bdbX0XopUgUA3mRX4smLv/YIxjuEfS+ItqdMWj5hriQSToPS2faEUP/f8Q1u+hb0mXii2dKTLUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0EyIZHD; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0EyIZHD"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f521a22d74so41482e0c.2
        for <iwd@lists.linux.dev>; Wed, 07 Aug 2024 11:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723054488; x=1723659288; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PuzQJECGUFs6HRFSL9Henz0/P8ilvHbUqfcGwqXeJg=;
        b=h0EyIZHDu/9vDoh8bz6LPvpH1SgizibuwPMSg+xhjztdRVMYtxflAcy850ZuKUDcaS
         9EeUmxmV0JSihbiO4HDuRFygLt8uQzzdyoPYBraZwHSuTfXQouI5THtdPhW9KQOoOVP7
         bp/A7nTNGGyDNAOSx90z3gvFVr7IGX0BerfOTeaqWnYakzWqAymsX87WQkEzzDm6bDr8
         rNlZTngNbgzkzUWcqrKfHhTJWJ0CyfoSATPlOOq/jsuyBG5uvNaN6mGxV75mMrYbjq2/
         Vyg6fWXHraL9BlIxhI4yvtEurRDrPlkLcsvPptQLtStRc77cS8XvSVLYvGmoUyHpfgBd
         RNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054488; x=1723659288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PuzQJECGUFs6HRFSL9Henz0/P8ilvHbUqfcGwqXeJg=;
        b=Oh1cxcg7+UN4MnkNwUI3bBPawbYqeMX7r9eK+wSlcMeqL/tn9NuYUR1h4K7pyP4+Jh
         OPJUeCZlEPByTSSy27oIzRvc3udUNjqM1DriZktCmNkK3LaTQ4sUVlo+PQRpv28ls/wZ
         sso/9T+juaIhekiBlFvmph0FFX/hd/iKzu7Osoc3Yj5WCNG0UG8nDPNS1UYdQ7rbBq8E
         cCyztl5zxTQSf+4tGrdQK5V9qDGUu5H0xfBMgsKolCMimr6feBABitX66VOhqWSPELZG
         aMaDgpcHTvTFm2HN4Hpxljfepm/XhByAo4rmgTg1W0PvYy6kbQw7KXoLdfroWJoCB+hq
         LQbw==
X-Gm-Message-State: AOJu0YwmBfGx2o55OAyWiD+/BXoHwjYx6CREqpf3vY3BMumuWs8QY1Rl
	HIiY11vMAN7oI+JDdBGyzS5U39KyFqOWou1eUKjxv+7QA+nLUj3oAmpltg==
X-Google-Smtp-Source: AGHT+IGaPrnrGdkrVeXA9pBi062MdG4fxYJtS7ANpCTtm1KJRN4V7fqDcdBrnWBnz0RfAH1iOdohrg==
X-Received: by 2002:a05:6122:2513:b0:4f6:b160:3806 with SMTP id 71dfb90a1353d-4f8a0013735mr23399415e0c.11.1723054488103;
        Wed, 07 Aug 2024 11:14:48 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d0db4sm82194685a.7.2024.08.07.11.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:14:47 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 13/14] client: refactor cmd_connect() and add find_network()
Date: Wed,  7 Aug 2024 11:14:26 -0700
Message-Id: <20240807181427.170515-13-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807181427.170515-1-prestwoj@gmail.com>
References: <20240807181427.170515-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will do all the lookup/searching needed to find a network
proxy object.
---
 client/station.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/client/station.c b/client/station.c
index affb7f15..58aac29e 100644
--- a/client/station.c
+++ b/client/station.c
@@ -283,28 +283,26 @@ static char *connect_cmd_arg_completion(const char *text, int state,
 	return network_name_completion(device, text, state);
 }
 
-static enum cmd_status cmd_connect(const char *device_name,
-						char **argv, int argc)
+static const struct proxy_interface *find_network(const char *device_name,
+						const char *name,
+						const char *type)
 {
 	struct network_args network_args;
 	struct l_queue *match;
 	const struct proxy_interface *network_proxy;
 	const struct proxy_interface *device_proxy;
 
-	if (argc < 1)
-		return CMD_STATUS_INVALID_ARGS;
-
 	device_proxy = device_proxy_find_by_name(device_name);
 	if (!device_proxy)
-		return CMD_STATUS_INVALID_VALUE;
+		return NULL;
 
-	network_args.name = argv[0];
-	network_args.type = argc >= 2 ? argv[1] : NULL;
+	network_args.name = name;
+	network_args.type = type;
 
 	match = network_match_by_device_and_args(device_proxy, &network_args);
 	if (!match) {
 		display("Invalid network name '%s'\n", network_args.name);
-		return CMD_STATUS_INVALID_VALUE;
+		return NULL;
 	}
 
 	if (l_queue_length(match) > 1) {
@@ -315,11 +313,28 @@ static enum cmd_status cmd_connect(const char *device_name,
 
 		l_queue_destroy(match, NULL);
 
-		return CMD_STATUS_INVALID_VALUE;
+		return NULL;
 	}
 
 	network_proxy = l_queue_pop_head(match);
 	l_queue_destroy(match, NULL);
+
+	return network_proxy;
+}
+
+static enum cmd_status cmd_connect(const char *device_name,
+						char **argv, int argc)
+{
+	const struct proxy_interface *network_proxy;
+
+	if (argc < 1)
+		return CMD_STATUS_INVALID_ARGS;
+
+	network_proxy = find_network(device_name, argv[0],
+					argc >= 2 ? argv[1] : NULL);
+	if (!network_proxy)
+		return CMD_STATUS_INVALID_VALUE;
+
 	network_connect(network_proxy);
 
 	return CMD_STATUS_TRIGGERED;
-- 
2.34.1

