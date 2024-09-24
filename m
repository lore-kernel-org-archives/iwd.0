Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E046917BED2
	for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179501; cv=none; b=MN3uUDyZYR15i2h75cwyYP4O/vnV+Xoib9nhW0GAx60AlnRMxk9lFTNkFWD9EI9MnZnpSeoXeN9rfIWiU09OoXvyPR+d9gbAQBkvsWe2neIhovWtgPVA1Brq3iVuDB7jt2ENs2kPqGG75ONM/gD28cy7u3aibUG2MA3t462rAzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179501; c=relaxed/simple;
	bh=fEAgoRFuEY11L4SO9is/6401fCUwEpY0bkfZj+I2gac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IoQ68yCMDRNwYf36a7g1khhatIIFscpr4ZazeOJ53kR9cvEOpWHGfcqLeq8a5NMd7Rguy82j09RWBz4h3ffk0ML+Gdo7zkVuFgWkuuLGQIgcd+ecujrvD2RC/zl8RvLAuFIUqMVy7kcizhzs/0EfhaDV+LjAClsjPC4ozA3ycHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmvU2uCI; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmvU2uCI"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c351809a80so39390706d6.1
        for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 05:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727179498; x=1727784298; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IC+H7P/jFNZABBiVNGUwQyX/JPQjFJ1pXzjY++KXT74=;
        b=fmvU2uCIJVXZmOiP2vyeQIOBBn5ExW5IDyKApnYXywgbQpvQEDDDczoIem7FvOpA+b
         gQoyo/KVqo9/8IkRDfxOA2hVhcJC+lvthiBVzBqw/HFFSgJGTJUpXvjvikwldUWpGso4
         kJXD/Uev6o2o05DcdrIfmXTKblqSOJlb5u7vdxlY9xjb71xFB7fKtQfpg/GSfK7dhp1k
         GICYLY8y6GiTAh46bnlASMsevfd6DOfG8BbjiwXonoe62geeZdaS2HxYAY4Mr2YZDvaA
         lltYmb3Mvigv8alxZf7NeyAFqWjYrmjwaW3s1v0+jbKPDZBbHZT8xwGMcWAwUvwmacae
         1a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179498; x=1727784298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IC+H7P/jFNZABBiVNGUwQyX/JPQjFJ1pXzjY++KXT74=;
        b=dDFfHYIKqeCRIXxoShFPJA7BkkwQbWAs1t4htci+r68Zr0H6waOTFNCH8RWgsZpzcd
         GMKjFj57RAcy62su94/tDfKbyP4fEt+ivmI04B9dWhGwQDxej31CUoq9ZbIVfjoQcAFH
         Wf3vFJrYW2G1tUCTQh5cHBHU8zQdaFVqOWorhYg4RzvDc3vOuN+Tc0GqhBSkvRX0Z9S5
         V6jCFyzN570eV/A7t2iI2LfmcoKXsodcb2VZ7IL6mMNoMPT0ROaIaSi23fpA2JjBbZQh
         krg2RoyTQV1Euw5djBVU1Y7QUSEQiYxMxsA9bOVWjvQYHQsP88G8R8wVSOtSyG4azZSW
         ErbQ==
X-Gm-Message-State: AOJu0Yz++S7/2yw07YSmWOoaMO6wTPjIUjuUYhgMRgVv+kdezDe1QWdy
	1fZgvYDu96BGQwgnW8QEOHkMVau+HS9EIBv9GBTZqSsggL/H7KufYdLqgg==
X-Google-Smtp-Source: AGHT+IEqsEa0EkbmOPQqgkuzMWVayhPVbnAnjBW72gevOu08dKKXZ5Y3cEcfhYEk36jy/Zp1GDw6nQ==
X-Received: by 2002:a05:6214:5982:b0:6c5:ab33:6300 with SMTP id 6a1803df08f44-6c7bd4cf296mr218743166d6.6.1727179498561;
        Tue, 24 Sep 2024 05:04:58 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4a6178sm5948056d6.7.2024.09.24.05.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:04:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/16] dpp: fix some return/cleanup issues for error cases
Date: Tue, 24 Sep 2024 05:04:34 -0700
Message-Id: <20240924120447.251761-3-prestwoj@gmail.com>
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

There were several error paths which did not reset the dpp_sm and
would then result in the state showing incorrectly as some values
would have remained initialized.
---
 src/dpp.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 03e2a7a6..32160d96 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -4169,11 +4169,15 @@ static struct l_dbus_message *dpp_start_configurator_common(
 	dpp->state = DPP_STATE_PRESENCE;
 
 	if (!responder) {
-		if (!l_dbus_message_get_arguments(message, "s", &uri))
-			return dbus_error_invalid_args(message);
+		if (!l_dbus_message_get_arguments(message, "s", &uri)) {
+			reply = dbus_error_invalid_args(message);
+			goto error;
+		}
 
-		if (!dpp_configurator_start_presence(dpp, uri))
-			return dbus_error_invalid_args(message);
+		if (!dpp_configurator_start_presence(dpp, uri)) {
+			reply = dbus_error_invalid_args(message);
+			goto error;
+		}
 
 		/* Since we have the peer's URI generate the keys now */
 		l_getrandom(dpp->i_nonce, dpp->nonce_len);
@@ -4196,6 +4200,10 @@ static struct l_dbus_message *dpp_start_configurator_common(
 	dpp->config = dpp_configuration_new(settings,
 						network_get_ssid(network),
 						hs->akm_suite);
+	if (!dpp->config) {
+		reply = dbus_error_not_supported(message);
+		goto error;
+	}
 
 	dpp_property_changed_notify(dpp);
 
@@ -4209,6 +4217,10 @@ static struct l_dbus_message *dpp_start_configurator_common(
 	l_dbus_message_set_arguments(reply, "s", dpp->uri);
 
 	return reply;
+
+error:
+	dpp_reset(dpp);
+	return reply;
 }
 
 static struct l_dbus_message *dpp_dbus_start_configurator(struct l_dbus *dbus,
@@ -4613,6 +4625,10 @@ static struct l_dbus_message *dpp_start_pkex_configurator(struct dpp_sm *dpp,
 	dpp->config = dpp_configuration_new(network_get_settings(network),
 						network_get_ssid(network),
 						hs->akm_suite);
+	if (!dpp->config) {
+		dpp_reset(dpp);
+		return dbus_error_not_supported(message);
+	}
 
 	dpp_reset_protocol_timer(dpp, DPP_PKEX_PROTO_TIMEOUT);
 	dpp_property_changed_notify(dpp);
-- 
2.34.1

