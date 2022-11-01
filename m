Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0B62F29
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:17:59 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id 192so14494399pfx.5
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEfGkuCQYYxcGbbfjR6N6mc6MQeYVXrumfh75c4m1EE=;
        b=fxIU+z0eUWksYM0oUib8xvEoEj1bqX4jOOG/y2iNyYSAZ/RT9ysUQwvDluCro1Bzk/
         YGm5OXrgbDNjjqMTQc0XBOM6pH9rNXqBOwuq7aWxzMXkpiPyilZI01gAA/COmbb7bKK7
         nci1AbxWFbf4Kp+3ZFEU63cnEhs3tiatZFmBmGcUQYK4QbvAjBL6a3azXm/0eEIjsa0o
         46TTeAZAz2T1QBX/xVshKkXRD7DC0tDca+M1K+LVkFD0XpNrnyQQesNFbqsjiw0yp+cP
         X52iNt9IkIDRJ/tCNLoKsfLjVYyI5xt4TQZlSo8ny5879QeF+wqid0J6ZrP2+lKi+Bf4
         odkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEfGkuCQYYxcGbbfjR6N6mc6MQeYVXrumfh75c4m1EE=;
        b=2BSQQlZn8RO8EBsSbAS0czR3Jnctb7aL0B72pKxH/sXzhK9G72QxiCbA+etzRUSYzf
         9Y03qwrJiOHeFscRn/CMgnTydHXfVQjLTb4SV1u1g0FQ/U5zU2WXFi9hsln50XvjzOvU
         ALN0hcyKjsjj+Z1ynsO2eFQdAyxAotqnY0Jr8Ny9YfoghsooLDp9wi1OHWCVLaACN659
         JHLNLF7GyDU1QQb9sFG/dJGl0xfSeSgHOZVuT/LGsz0CxFH1qHyx2Z4TJY7hnEmopW1b
         N5SBMtWNJd4Ye5gdCox56iglqP0NHOcmx9dKHbNQaGTntqJoi9b+eUS/V1uWsTwUQ6dX
         5IFw==
X-Gm-Message-State: ACrzQf0ZSm4ej8iA1zulsiN+rjhFGcktPVKegGNfYlsD+ddg5TKfyNSQ
	HLr3RGELPdX8Z3mgha9Yx8/dDMaUiQ4=
X-Google-Smtp-Source: AMsMyM52PptedxG6oW8/0WnMimK0vWK3vs7Ib6aejKzE0oCyx1IPGRw2VL4LjYt1a6HZNYJfky4vww==
X-Received: by 2002:aa7:814a:0:b0:56c:c538:f100 with SMTP id d10-20020aa7814a000000b0056cc538f100mr191300pfn.58.1667333878682;
        Tue, 01 Nov 2022 13:17:58 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00180a7ff78ccsm6781681plg.126.2022.11.01.13.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:17:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 07/17] client: show frequency with ap show
Date: Tue,  1 Nov 2022 13:17:37 -0700
Message-Id: <20221101201747.143379-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221101201747.143379-1-prestwoj@gmail.com>
References: <20221101201747.143379-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 client/ap.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/client/ap.c b/client/ap.c
index b8849a1b..4ce727de 100644
--- a/client/ap.c
+++ b/client/ap.c
@@ -36,6 +36,7 @@ struct ap {
 	bool started;
 	char *name;
 	bool scanning;
+	uint32_t freq;
 };
 
 static void *ap_create(void)
@@ -126,10 +127,35 @@ static const char *get_scanning_tostr(const void *data)
 	return ap->scanning ? "yes" : "no";
 }
 
+static void update_freq(void *data, struct l_dbus_message_iter *variant)
+{
+	struct ap *ap = data;
+	uint32_t value;
+
+	if (!l_dbus_message_iter_get_variant(variant, "u", &value)) {
+		ap->freq = 0;
+
+		return;
+	}
+
+	ap->freq = value;
+}
+
+static const char *get_freq_tostr(const void *data)
+{
+	const struct ap *ap = data;
+	static char str[5];
+
+	sprintf(str, "%u", ap->freq);
+
+	return str;
+}
+
 static const struct proxy_interface_property ap_properties[] = {
 	{ "Started",  "b", update_started,  get_started_tostr },
 	{ "Name",     "s", update_name, get_name_tostr },
 	{ "Scanning", "b", update_scanning, get_scanning_tostr },
+	{ "Frequency", "u", update_freq, get_freq_tostr },
 	{ }
 };
 
-- 
2.34.3

