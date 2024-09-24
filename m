Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A018126C02
	for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179515; cv=none; b=VUVFZiTjKqcYXuYPr7EeB6wRVgj+bmOgJWK3O1j+3MqzVT0+rU1Bks+30+IcIlQVz75WcDNy6WPirBLvY86W1pZJDNccu/UeNteywSNNTRpPQy5qa02Gfzcx2+KdHsWiR7YkujiNP10nKXoTqq+Bw6zUgLHhJpZK4OYrrLDXb1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179515; c=relaxed/simple;
	bh=bzJ0RwYjoFvTb2rnJWhb0BvefmJupwcZEBMzITTcGwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dmF8IYbEjmx1iOODQDpELIj08OvsvAFGCA0wbdVy/9xKVRKUPyHxZ/d+anxU4LXkzNSfLrZ3kUq5bdlXUffgkv0Eb5gX8cT2SI2OeKzPcmEngWan8ELWvjut+oljo2RQlEechnuHofdm0x0InTe87TctdmupyztrvzdS5UtGZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jt7fkEoG; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jt7fkEoG"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c34dd6c21aso37399836d6.2
        for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 05:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727179512; x=1727784312; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzpW3PZRVaqKzgq/WFqn1FsGo2R2+ica6UrYBOq8LhY=;
        b=jt7fkEoGW8+VYJSZvvQXBS47tFWrzLIZPAgu8oixKqHQBeAAOf5Ec/kiOFoyOLIPWM
         EyS4WZiucdWhiyfQp3N3xlExN/0Hq2yN9BeonzB9usAI+NF7HYY/G6VIDBdMX2XfOcDR
         STXeems+7bvXnjbB9KiHjk7UILgj9qBpYPwIVF664O65jXUIi6QDyDCupXoWVfFcYHST
         5wJxG4Rzwt0rREZ2ASunTVNOhmUjpbjeD3VPovAd7wv8GG+dgQ/YcEQgHzw6SANdrOl/
         xuclDDGjAdl/C6bZH/ihvzAdXaWUV9WXzGy1eGz/UHy4ZwaGC4iGYxkTGDZYkW4/nyu1
         RV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179512; x=1727784312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GzpW3PZRVaqKzgq/WFqn1FsGo2R2+ica6UrYBOq8LhY=;
        b=cvMXdPfx7j0kgnjZHCIunlDHCb3N2jYoGuMcn2/eAWS46ShYGoYqb6ZavvttZBGnTF
         NNcW8BWj61FH/nNPveh/6bUVi0gfNOxoaoBvpuDSp+FZWcK8njc/RzKDhCkZtHfgmlue
         1gDwIMMGc26FJsbKrNunGGqVpM8JkEPETPtw1Hp17AvDxAlOG9t7ujEWSu7oTUrRcyZ3
         RS92FUEXJ5IWrvsQ/QRWjquGdJHdvzKqxPFKybVY+t5SHPFOHxnMrPpJIy6jeFhuHvWD
         kz7r8QiMn84WIiDYBj8C/HtsOFM1QW/jSVhmRSMTbpf8PAdQeFVr/7pugOIh2dKpKHex
         Zkmg==
X-Gm-Message-State: AOJu0YymThptGUiF9NBC+5tTbmUZBivGDuSAsM2WabqHedSEMS71Kfng
	/X27V3GBGzjlHVOp27sLlBnFP6SHq/n+wyhJ/u9Dp28BZYECueHv90G4Ww==
X-Google-Smtp-Source: AGHT+IG5/H7Sv/3U+uUFTEG0gScS1yhkwtagPnW6xOrWPxQtyyhzDF8pdnxFbVA+/sdDBkgJCK27zg==
X-Received: by 2002:a05:6214:4408:b0:6c5:688a:63b4 with SMTP id 6a1803df08f44-6c7bc83203fmr209670956d6.50.1727179511920;
        Tue, 24 Sep 2024 05:05:11 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4a6178sm5948056d6.7.2024.09.24.05.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:05:11 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 13/16] dpp: remove agent path from StartConfigurator
Date: Tue, 24 Sep 2024 05:04:44 -0700
Message-Id: <20240924120447.251761-13-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924120447.251761-1-prestwoj@gmail.com>
References: <20240924120447.251761-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The agent must now be registered via the AgentManager interface, so
remove the path argument as it is not used anymore.
---
 src/dpp.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index d1912eaf..7a744ed3 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -4642,7 +4642,6 @@ invalid_args:
 
 static struct l_dbus_message *dpp_start_pkex_configurator(struct dpp_sm *dpp,
 					const char *key, const char *identifier,
-					const char *agent_path,
 					struct l_dbus_message *message)
 {
 	struct handshake_state *hs = netdev_get_handshake(dpp->netdev);
@@ -4715,7 +4714,7 @@ static struct l_dbus_message *dpp_dbus_pkex_configure_enrollee(
 	if (!dpp_parse_pkex_args(message, &key, &id, NULL, NULL))
 		return dbus_error_invalid_args(message);
 
-	return dpp_start_pkex_configurator(dpp, key, id, NULL, message);
+	return dpp_start_pkex_configurator(dpp, key, id, message);
 }
 
 static struct l_dbus_message *dpp_dbus_pkex_start_configurator(
@@ -4724,12 +4723,8 @@ static struct l_dbus_message *dpp_dbus_pkex_start_configurator(
 						void *user_data)
 {
 	struct dpp_sm *dpp = user_data;
-	const char *path;
 
-	if (!l_dbus_message_get_arguments(message, "o", &path))
-		return dbus_error_invalid_args(message);
-
-	return dpp_start_pkex_configurator(dpp, NULL, NULL, path, message);
+	return dpp_start_pkex_configurator(dpp, NULL, NULL, message);
 }
 
 static void dpp_setup_interface(struct l_dbus_interface *interface)
@@ -4774,7 +4769,7 @@ static void dpp_setup_pkex_interface(struct l_dbus_interface *interface)
 	l_dbus_interface_method(interface, "ConfigureEnrollee", 0,
 			dpp_dbus_pkex_configure_enrollee, "", "a{sv}", "args");
 	l_dbus_interface_method(interface, "StartConfigurator", 0,
-			dpp_dbus_pkex_start_configurator, "", "o", "path");
+			dpp_dbus_pkex_start_configurator, "", "");
 
 	l_dbus_interface_property(interface, "Started", 0, "b",
 			dpp_pkex_get_started, NULL);
-- 
2.34.1

