Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919CD1A7070
	for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179507; cv=none; b=D1HB2DftCMuA+DiB1dH0rPagHbPKNW8LWJxVr35D9YtXsKn2QexMu51Iaante53NkzDwdxnJMUMJsTGs9eZ+ASL9BTA29SO/+eTji/L+PsXweyN7yeMWN+IXN9KW9004Yl15Y9iMLtwduFUzjiA4Jj2tAeAcEbjjlPH6RhJaAmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179507; c=relaxed/simple;
	bh=iUtGnNKS63XYfg0fZ60XqNv1LJGS5KM6yz1RxGdgZ00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WiFmbinqPUYImHrI35vLVvDV+mWQ66bOpolHBiaZcnJu/3tTnylfJdr1/Mlc9NWy7y4nAn6uADkikDruQ0zFXHz/7cqsrG4sLSCOcSaSNNcsxfxVF5L5mtjvOS6nKBUXo+jCaWhYbT8/OjR+1tR0lYUcjZjCKRgi58MtPCS/qvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNnBf+eu; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNnBf+eu"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c579748bf4so51763046d6.1
        for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 05:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727179504; x=1727784304; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7J33SePf1FjwXDV3HEwxL7tGP9jtud0nYWTRHN10jk=;
        b=fNnBf+euOBUo+q/uPNYU6m2AprYmIU6THOnkhYdoobbwMxFkAjirLbrv3L2xajJ6be
         qRmNS3W3VVef50Wpp32HKbaPI9j5UJarvF1S3jWnB8QCez5mrgL+7G65G/bg+EeeTC9F
         nbEhYemylk7Hx9PhmGSn1tu1XKMdMrAn4alkcz/5/d3rY1n6kXePD3z4dYLMZ1CifxnL
         h1fUA6VcR9UFOYLNmTjKNBfT0wuxmzlqSwZVxJl7JlVi3VSrf1Y9xRK1H/QEDll5SYQg
         vdGIZv48qQS7nmbu+Z+aTtHPvP+FnN2qoa9QvmRozMiZJoym0QpSffzq+CJbmgzI3Rds
         GmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179504; x=1727784304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7J33SePf1FjwXDV3HEwxL7tGP9jtud0nYWTRHN10jk=;
        b=VUe8bkR+4XcxmHW6mv2H4J46sLqJ8x0oT1k85LJJ8vt5x9UWJJfKQqx9nZMyWNfndX
         IzWOfXHk1sQz7vfOY8O0D7RlsP8qPQA3GSz/dRDrMPT5CURot3GgxXNpHO1TOAIBseJo
         DnCPJVunFBE7+oOADWZQPW5W61TsfhQXjJhBU3GbEX/OqcpRq4RxyyFgsP61OOmsM2Hf
         3Nk9vup6Esw88JcoW81ZASKsSyTmWajR6fGppQrnRHAgvmXk6Q83TNSxCMmvmteSXkRd
         HPXU5RUhW2JedFIVFEa8gI2w3JsOSBv2Pdf1bJHgvYxHlbQn/tQGT6joIHEQc44LaWtc
         PYUA==
X-Gm-Message-State: AOJu0Yzu1+z90w2f6vNitQgS8Fy6NelaKoyUSmxR86RJTfmLQQ/KoeaN
	xbDt+czRiq04JG91Ifx1V7uBC+FjcCZKQSJy4Kq4qidaT0rtzQ5xdLFoNg==
X-Google-Smtp-Source: AGHT+IFktp0np/oagE3nZQdmuCm/DwNPDu8EJtKHhouuK+zU/quTAA0wCUU7o0bg3LF3BhObTUMZTg==
X-Received: by 2002:a05:6214:498d:b0:6c5:55bc:2705 with SMTP id 6a1803df08f44-6c7bc67b631mr248413336d6.6.1727179503869;
        Tue, 24 Sep 2024 05:05:03 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4a6178sm5948056d6.7.2024.09.24.05.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:05:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 07/16] dpp: refactor config writing, add checks for PSK
Date: Tue, 24 Sep 2024 05:04:38 -0700
Message-Id: <20240924120447.251761-7-prestwoj@gmail.com>
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

When writing the config object ensure the network security of the
scanned network is PSK, and matches the config object recieved.
---
 src/dpp.c | 60 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 16d0a711..3ad60188 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -832,25 +832,57 @@ static void send_config_result(struct dpp_sm *dpp, const uint8_t *to)
 	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
 }
 
-static void dpp_write_config(struct dpp_configuration *config,
+static void dpp_write_psk_config(struct dpp_configuration *config,
+					struct l_settings *settings)
+{
+	if (config->passphrase)
+		l_settings_set_string(settings, "Security", "Passphrase",
+				config->passphrase);
+	else if (config->psk)
+		l_settings_set_string(settings, "Security", "PreSharedKey",
+				config->psk);
+}
+
+static bool dpp_write_config(struct dpp_configuration *config,
 				struct network *network)
 {
 	_auto_(l_settings_free) struct l_settings *settings = l_settings_new();
-	_auto_(l_free) char *path;
+	_auto_(l_free) char *path = NULL;
+	enum security security;
+
+	if (!network) {
+		l_warn("Network not seen in results, can't validate security");
+
+		if (IE_AKM_IS_PSK(config->akm_suites))
+			security = SECURITY_PSK;
+		else
+			return false;
+
+		goto write_config;
+	} else
+		security = network_get_security(network);
 
-	path = storage_get_network_file_path(SECURITY_PSK, config->ssid);
+	if (security == SECURITY_PSK) {
+		if (!IE_AKM_IS_PSK(config->akm_suites)) {
+			l_warn("Network is PSK but DPP config is not!");
+			return false;
+		}
+	} else {
+		l_warn("Unsupported network security %s",
+				security_to_str(security));
+		return false;
+	}
+
+write_config:
+	path = storage_get_network_file_path(security, config->ssid);
 
 	if (l_settings_load_from_file(settings, path)) {
 		/* Remove any existing Security keys */
 		l_settings_remove_group(settings, "Security");
 	}
 
-	if (config->passphrase)
-		l_settings_set_string(settings, "Security", "Passphrase",
-				config->passphrase);
-	else if (config->psk)
-		l_settings_set_string(settings, "Security", "PreSharedKey",
-				config->psk);
+	if (security == SECURITY_PSK)
+		dpp_write_psk_config(config, settings);
 
 	if (config->send_hostname)
 		l_settings_set_bool(settings, "IPv4", "SendHostname", true);
@@ -859,8 +891,10 @@ static void dpp_write_config(struct dpp_configuration *config,
 		l_settings_set_bool(settings, "Settings", "Hidden", true);
 
 	l_debug("Storing credential for '%s(%s)'", config->ssid,
-						security_to_str(SECURITY_PSK));
-	storage_network_sync(SECURITY_PSK, config->ssid, settings);
+						security_to_str(security));
+	storage_network_sync(security, config->ssid, settings);
+
+	return true;
 }
 
 static void dpp_scan_triggered(int err, void *user_data)
@@ -1141,7 +1175,8 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 			bss = network_bss_select(network, true);
 	}
 
-	dpp_write_config(config, network);
+	if (!dpp_write_config(config, network))
+		goto free_config;
 
 	send_config_result(dpp, dpp->peer_addr);
 
@@ -1169,6 +1204,7 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 		}
 	}
 
+free_config:
 	dpp_configuration_free(config);
 	dpp_reset(dpp);
 }
-- 
2.34.1

