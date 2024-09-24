Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5817C222
	for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179500; cv=none; b=EytG9Am46i159SRnX+LHdzd666+yNJYjQXZmGY5SfjlUZ/oue/2wZiKSla7vzyxmikWobr3OLxe4/CGQ6OMycFizgut9jIBwovTSWpujfcbWpKDSw/IvQqpr/x/lzH8LdFVaFl2buRr8gYmlkEeDvcFbu7ZrPCXpxxuLreI85fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179500; c=relaxed/simple;
	bh=xYVwNCGu2F8pJB3SCCjGcoZDkc/4z21P39Zn+tA65pA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dBfyYo6XnxSl92dt9eBUoEDTmcuWxBnWNaAGugEehXKVTei0Ut6FC0KNeqJ4nH52AMfehJeYbrdnu0U+hmR/2WArlQfwH0z7qjJhMo3hR6HN2d1zem3qLTUO28nPdVRg6LgdWNMefmLikWGzWMvPM/eJcnbX1OljEjahWdmIA+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqdIWM+y; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqdIWM+y"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c524b4a3aeso42031046d6.3
        for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 05:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727179497; x=1727784297; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyJ582zmnCoyqJDD5W8Z3S/udtnUYPlBYJ2opG1tsnM=;
        b=UqdIWM+yxlGyMPEo27UkbPzxINqsFvwMoCoqd6MnorDyJ9RNMkRYOvUK54XBcjYdo7
         F4A4QWXKptRz+W87c+RSiTRKQtfmuZ+tyllf+L00c64q9m/L6W5f7Akuzqv6cGymO6kK
         TcIcQpR6FyJ/W8QGVKmHNIy7GEEkbYzcjx3W5X4cpbJu4DaSA+Wb//G85WJqLj3Be5q4
         MeX3h5ebDXbKDcCQ3OvzOcjuSOs5GuohzAEShQ944FNnICakViapxX9L66cGMnue6RdI
         OdfyG6nB+Crc5pr7sDcFQePWjc//NTLFMxq44SSVHdu9HawMOgm2XjxGA7Qiyu8F9tFH
         7xiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179497; x=1727784297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyJ582zmnCoyqJDD5W8Z3S/udtnUYPlBYJ2opG1tsnM=;
        b=sOnI9veaHLtIKNlujzoAeupP3eE9YoWKpIVQtSOMkb/dbShpbAEcS8YErk3f3PwYsc
         Q5Tpoqok43EuJaX5A46J4LC1IOW4hVv5eSczAkX3ZU/npFdG30FOPqL0wu34JwfcDMh8
         8u/8XjfXLGLbjob2o5wPwyiJqnz6DcQdiqxx4Yd1iwfdYb3Cgrr1IT5NTAzZ2PL6EccH
         MjYvlZ0lkUvQttEQAtEUHgNb3iiy9uDAoYY9A077YabacXNuJpkHa+9rwewSz9JP42vk
         J+lgbaXU0B7kUpO7pKdqz0vf7WU5eAjlWOXrLnPdeWGuacVmX4fEaXERmzRDaIO0akPZ
         1asw==
X-Gm-Message-State: AOJu0YzLUP4PPLktBpxY6E5rlLIs80lC3KG8C+H0HJeX/p2yN24LrXkn
	V/gA0vq4v9893yLuRFqVDXep0noPxQdO1g0IZqZ8TBYm/kgmLbpThV0g+Q==
X-Google-Smtp-Source: AGHT+IEtgz0B2H1ExzQaztSd1xJ5wCwufM46sxv55X2d3H6xLry/RGvdddCj31Pqvi+1C5xsjSDROg==
X-Received: by 2002:a05:6214:5b86:b0:6c5:7138:d515 with SMTP id 6a1803df08f44-6c7bd5b92ebmr227037476d6.46.1727179497320;
        Tue, 24 Sep 2024 05:04:57 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4a6178sm5948056d6.7.2024.09.24.05.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:04:56 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 02/16] dpp-util: refactor dpp_configuration_new into a _psk helper
Date: Tue, 24 Sep 2024 05:04:33 -0700
Message-Id: <20240924120447.251761-2-prestwoj@gmail.com>
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

Prior to adding 802.1x configuration with DPP we need to isolate the
configuration object creation into a PSK variant, as 802.1x options
don't require the passphrase/psk fields.
---
 src/dpp-util.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index cfdedbdd..2eacc587 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -315,17 +315,12 @@ char *dpp_configuration_to_json(struct dpp_configuration *config)
 				config->hidden ? "true" : "false");
 }
 
-struct dpp_configuration *dpp_configuration_new(
-					const struct l_settings *settings,
-					const char *ssid,
-					enum ie_rsn_akm_suite akm_suite)
+static struct dpp_configuration *dpp_configuration_new_psk(
+					const struct l_settings *settings)
 {
 	struct dpp_configuration *config;
 	_auto_(l_free) char *passphrase = NULL;
 	_auto_(l_free) char *psk = NULL;
-	size_t ssid_len = strlen(ssid);
-	bool send_hostname;
-	bool hidden;
 
 	if (!l_settings_has_group(settings, "Security"))
 		return NULL;
@@ -340,15 +335,39 @@ struct dpp_configuration *dpp_configuration_new(
 
 	config = l_new(struct dpp_configuration, 1);
 
-	memcpy(config->ssid, ssid, ssid_len);
-	config->ssid[ssid_len] = '\0';
-	config->ssid_len = ssid_len;
-
 	if (passphrase)
 		config->passphrase = l_steal_ptr(passphrase);
 	else
 		config->psk = l_steal_ptr(psk);
 
+	return config;
+}
+
+struct dpp_configuration *dpp_configuration_new(
+					const struct l_settings *settings,
+					const char *ssid,
+					enum ie_rsn_akm_suite akm_suite)
+{
+	struct dpp_configuration *config;
+	size_t ssid_len = strlen(ssid);
+	bool send_hostname;
+	bool hidden;
+
+	if (IE_AKM_IS_PSK(akm_suite))
+		config = dpp_configuration_new_psk(settings);
+	else {
+		l_warn("DPP not supported using AKM suite %x", akm_suite);
+		return NULL;
+	}
+
+	if (!config) {
+		l_warn("Failed to parse profile settings for DPP");
+		return NULL;
+	}
+
+	memcpy(config->ssid, ssid, ssid_len);
+	config->ssid[ssid_len] = '\0';
+	config->ssid_len = ssid_len;
 
 	config->akm_suites = akm_suite;
 
-- 
2.34.1

