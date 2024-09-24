Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5133F1A4F36
	for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179502; cv=none; b=jyQxsYqWHXgpbNgvMGCq9NxT9Re4CWsg9tVmFSo6rUFcNnXbFbQ4xJjA4oEsq+7LJkrVY93Mu7FggjGts4EXvZzPM9u7wLaPKD4QjhTnNJX8eIA57ekCzOZbfnd92pz3rhm4IO0jt426CzUOIQNbyJn8f6U0ZA65YnLwQgb8rnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179502; c=relaxed/simple;
	bh=LDd79XMLHxHMjjAgWLgMmmTGJdXUeRwnMuA1y91yiCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g7IOb/jkNfTcBmQf/I2GIXQIS+RV4pdH0g5ODVwUCsX57x96Y7Wa3AdCeDSKbLGu7AaRSOr76U5Gg4oh+R93UUSA3GN0RviFw1L65W+D40ctD7POB3wcOfJIlmNna82fCiFv9nLP0ddXHSytEuhFbQEUUB7Bvd1oCABnxiTJxBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdCHU7I7; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdCHU7I7"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c7b57e2b17so40234896d6.3
        for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 05:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727179500; x=1727784300; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1E3YxwmgXCvRIyIfTR9wGMSLDzPBeoSS+JUO6w1cIuE=;
        b=gdCHU7I70tgArZhhTdjIE1FZG7FYWoQkrgb5OdBaOtfsVWjdHjXDYawlr6VM+iH13H
         7xn3ZGc0m1wlvAaE5D3gLJ7V1whWwj5iiukTX8QV/jxAd42hD6q/7ZcyadUZgGgDi6wE
         +4S8gA5fQ+LoiehHSkewhnDlQvFlDbLG/Fy78dMr32QqYT2QRjyJ0VQ7CjH2NBiNW86o
         2N5AyS83PCWL1D/5ON2wq1koD14wGxXxbJ2+AGjb27VlGrCYBeJmCNK+mgESch+RUUED
         KvTXuwNj41EKLCsmCChQl2t3uMrYnyj+j1NlGx5MEkohT5ZasD72HD2UCG3Una+rY5n/
         nBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179500; x=1727784300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1E3YxwmgXCvRIyIfTR9wGMSLDzPBeoSS+JUO6w1cIuE=;
        b=Fuj1x4mSyuCdKeGbX3txdT2xRll/q4kcKhpaF5EhXjtT6ydOXMPqaOBHDQSqXzBBSz
         Jw/FowVmH++fVoLUydSAwBGj1yjyMHcempFcyw7o53YLMkiqkrdqkgzQcM9daQNglSdA
         RJVo7kAL5i1n4Qgi0EwJofReV1ZPbdf3LPSH9PdxMsJscWgptb9z68UW016zjjCPqNI3
         mlWvVtfM7f6L786xh/TFQgnOh8KsPLvSOwD8PnG7xeYYgfNLBHDefRBNypgBeW7O1+hp
         xnwpfy8/g7jYq+vE7EpkzTbt+/PKYQ1VZ1Ildj/5JqEvXfzqEPTlHOCczBdUSmOr8eOF
         oaEQ==
X-Gm-Message-State: AOJu0Yykvcjq5SHYsoy4cyGGnLgnMPyFE8nJM4sXbk2pyyWK/sANPVEu
	9U2iqf2JJo2m4TvHIEaVrRYaN7nd9XWt32tpkWwmEwV2hSqAfmxKv6TYgQ==
X-Google-Smtp-Source: AGHT+IFwdt4K+Ge2/H4QgA8jliZ0Lk0V4KFez1Ldc6fWxZE3GoOSBKTToAuqqx2+1L/VEsr3VfsUaQ==
X-Received: by 2002:ad4:52c4:0:b0:6c7:c5bf:5b0d with SMTP id 6a1803df08f44-6c7c5bf5b4dmr160607536d6.38.1727179499839;
        Tue, 24 Sep 2024 05:04:59 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4a6178sm5948056d6.7.2024.09.24.05.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:04:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 04/16] dpp-util: refactor dpp_configuration_to_json for only PSK networks
Date: Tue, 24 Sep 2024 05:04:35 -0700
Message-Id: <20240924120447.251761-4-prestwoj@gmail.com>
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

This renames dpp_configuration_to_json to dpp_psk_config_to_json to
prepare for adding 802.1x provisioning. The 802.1x variant will need
to take additional arguments, so we'll need to isolate the PSK
logic into its own API.
---
 src/dpp-util.c | 27 +++++++++++++++++----------
 src/dpp-util.h |  2 +-
 src/dpp.c      |  2 +-
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index 2eacc587..62db2081 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -282,22 +282,15 @@ static const char *dpp_akm_to_string(enum ie_rsn_akm_suite akm_suite)
 	}
 }
 
-char *dpp_configuration_to_json(struct dpp_configuration *config)
+static char *dpp_configuration_to_json(struct dpp_configuration *config,
+					const char *creds)
 {
-	_auto_(l_free) char *pass_or_psk;
 	_auto_(l_free) char *ssid;
 
 	ssid = l_malloc(config->ssid_len + 1);
 	memcpy(ssid, config->ssid, config->ssid_len);
 	ssid[config->ssid_len] = '\0';
 
-	if (config->passphrase)
-		pass_or_psk = l_strdup_printf("\"pass\":\"%s\"",
-						config->passphrase);
-	else
-		pass_or_psk = l_strdup_printf("\"psk\":\"%s\"",
-						config->psk);
-
 	return l_strdup_printf("{\"wi-fi_tech\":\"infra\","
 				"\"discovery\":{"
 					"\"ssid\":\"%s\""
@@ -310,11 +303,25 @@ char *dpp_configuration_to_json(struct dpp_configuration *config)
 					"\"hidden\":%s}"
 				"}",
 				ssid, dpp_akm_to_string(config->akm_suites),
-				pass_or_psk,
+				creds,
 				config->send_hostname ? "true" : "false",
 				config->hidden ? "true" : "false");
 }
 
+char *dpp_psk_config_to_json(struct dpp_configuration *config)
+{
+	_auto_(l_free) char *pass_or_psk;
+
+	if (config->passphrase)
+		pass_or_psk = l_strdup_printf("\"pass\":\"%s\"",
+						config->passphrase);
+	else
+		pass_or_psk = l_strdup_printf("\"psk\":\"%s\"",
+						config->psk);
+
+	return dpp_configuration_to_json(config, pass_or_psk);
+}
+
 static struct dpp_configuration *dpp_configuration_new_psk(
 					const struct l_settings *settings)
 {
diff --git a/src/dpp-util.h b/src/dpp-util.h
index 86ef36f9..f7d7122c 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -132,7 +132,7 @@ struct dpp_configuration *dpp_configuration_new(
 					const struct l_settings *settings,
 					const char *ssid,
 					enum ie_rsn_akm_suite akm_suite);
-char *dpp_configuration_to_json(struct dpp_configuration *config);
+char *dpp_psk_config_to_json(struct dpp_configuration *config);
 void dpp_configuration_free(struct dpp_configuration *conf);
 
 struct dpp_attr_iter {
diff --git a/src/dpp.c b/src/dpp.c
index 32160d96..41e56197 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1212,7 +1212,7 @@ static void dpp_send_config_response(struct dpp_sm *dpp, uint8_t status)
 	 * STATUS_CONFIGURE_FAILURE which only includes the E-Nonce.
 	 */
 	if (status == DPP_STATUS_OK) {
-		json = dpp_configuration_to_json(dpp->config);
+		json = dpp_psk_config_to_json(dpp->config);
 		json_len = strlen(json);
 
 		ptr += dpp_append_wrapped_data(attrs + 2, ptr - attrs - 2,
-- 
2.34.1

