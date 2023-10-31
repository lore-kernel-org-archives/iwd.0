Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BFB200C8
	for <iwd@lists.linux.dev>; Tue, 31 Oct 2023 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqjs2FqD"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-66cfd874520so34747876d6.2
        for <iwd@lists.linux.dev>; Tue, 31 Oct 2023 11:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698778080; x=1699382880; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nptuvb3rG4jOCkKSF1uD1bV7MqUOnFAipdBaz37VPN4=;
        b=mqjs2FqDOlaAFaT5KQODUJC1sEZcyPwRBc/iahTv1IZlZ29vmPy1Jbis0oaGkafm3p
         kjcC0ccI3uUGar6q+JCjxsNsUw9yRGme9t+8YkvXzymHiYeUnMpS3fM5/rhV7bHc91LL
         9qpx7xUfcHvpRWOEw7awOx51H43jvqUwd2NPz8FgAcjbd1AMl9SXLmSKX+t7+cFKIDdi
         IHZ7/xbJV8vI4JtNj2xn43fBclgMK8IR6D5JMClxd3kzFtrCP+KjShMGV40wBI1yJX08
         70oj7zbAGcq/3zqb7zH407N3bmByGs+nd0csgvCdpo5RUshZsOkaTu9KX1pjkNZ+NLrC
         L74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698778080; x=1699382880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nptuvb3rG4jOCkKSF1uD1bV7MqUOnFAipdBaz37VPN4=;
        b=sx00lL02FA3WncjzqpPPb8GL7xNsC+6L0AdhPbbvXpDmLNIGjYiUjd3TLChKG0RZIm
         0QW68+6lX7ASVwkslvwvKWM6IpQZgbipu6MKkhYJPrXudP8o89ZzEe4wVf3/BtyO6ar1
         +aKM8KcK1UxQnSJxuegendhV8qNVfrhtQ9f8RxF3eKDiJxCXjLmaPk9Ii+z+qOF9v3P4
         9CTEUKAHnK6I3R4v4aSPPDy91lW9HOTj+B8YfWwLeN/yxvyhiqMGIXdKAPCdLGzp1yJ/
         XehwnD4DAg8VRUpXAqvO0Asvl5y9fMD6reJy/gaXs5F7DEz4P7HwkYR7amAI8M1wYNh3
         AM7w==
X-Gm-Message-State: AOJu0Ywl/YT2AB87GP2I0bYSeZxjg26Agu3tWjZoV08rvsHboRbC20Hz
	v1KVgNDB0tMGQJwKncw7ClKcM33sQGg=
X-Google-Smtp-Source: AGHT+IEZZWMkqJRQ+W2InY0LMWF+GW4AOWKNS1XFxsCz5SVJpjudSWnILvaikX5982yC+OKTHyxrXA==
X-Received: by 2002:ad4:5c8c:0:b0:66d:3548:9c1a with SMTP id o12-20020ad45c8c000000b0066d35489c1amr18100835qvh.54.1698778080379;
        Tue, 31 Oct 2023 11:48:00 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id bj30-20020a05620a191e00b00774292e636dsm736351qkb.63.2023.10.31.11.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 11:48:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/9] dpp: fix config request header check
Date: Tue, 31 Oct 2023 11:47:43 -0700
Message-Id: <20231031184750.722404-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031184750.722404-1-prestwoj@gmail.com>
References: <20231031184750.722404-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check for the header was incorrect according to the spec.
Table 58 indicates that the "Query Response Info" should be set
to 0x00 for the configuration request. The frame handler was
expecting 0x7f which is the value for the config response frame.

Unfortunately wpa_supplicant also gets this wrong and uses 0x7f
in all cases which is likely why this value was set incorrectly
in IWD. The issue is that IWD's config request is correct which
means IWD<->IWD configuration is broken. (and wpa_supplicant as
a configurator likely doesn't validate the config request).

Fix this by checking both 0x7f and 0x00 to handle both
supplicants.
---
 src/dpp.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index cfdfaa38..dcf5953f 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -920,6 +920,21 @@ static void dpp_send_config_response(struct dpp_sm *dpp, uint8_t status)
 	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
 }
 
+static bool dpp_check_config_header(const uint8_t *ptr)
+{
+	/*
+	 * Table 58. General Format of DPP Configuration Request frame
+	 *
+	 * Unfortunately wpa_supplicant hard codes 0x7f as the Query Response
+	 * Info so we need to handle both cases.
+	 */
+	return ptr[0] == IE_TYPE_ADVERTISEMENT_PROTOCOL &&
+			ptr[1] == 0x08 &&
+			(ptr[2] == 0x7f || ptr[2] == 0x00) &&
+			ptr[3] == IE_TYPE_VENDOR_SPECIFIC &&
+			ptr[4] == 5;
+}
+
 static void dpp_handle_config_request_frame(const struct mmpdu_header *frame,
 				const void *body, size_t body_len,
 				int rssi, void *user_data)
@@ -937,8 +952,6 @@ static void dpp_handle_config_request_frame(const struct mmpdu_header *frame,
 	const uint8_t *e_nonce = NULL;
 	size_t wrapped_len = 0;
 	_auto_(l_free) uint8_t *unwrapped = NULL;
-	uint8_t hdr_check[] = { IE_TYPE_ADVERTISEMENT_PROTOCOL, 0x08, 0x7f,
-				IE_TYPE_VENDOR_SPECIFIC, 5 };
 	struct json_iter jsiter;
 	_auto_(l_free) char *tech = NULL;
 	_auto_(l_free) char *role = NULL;
@@ -965,10 +978,10 @@ static void dpp_handle_config_request_frame(const struct mmpdu_header *frame,
 
 	dpp->diag_token = *ptr++;
 
-	if (memcmp(ptr, hdr_check, sizeof(hdr_check)))
+	if (!dpp_check_config_header(ptr))
 		return;
 
-	ptr += sizeof(hdr_check);
+	ptr += 5;
 
 	if (memcmp(ptr, wifi_alliance_oui, sizeof(wifi_alliance_oui)))
 		return;
-- 
2.25.1

