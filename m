Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA3019F461
	for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179505; cv=none; b=RH/4YT7PJwb1XZgbgkiSNn5aye/HXx7Q134BCoNMAxZz3kHkhUwSSCXoJu2tJC2cL+pyxssfuaDrKPlhLzFHDgy2zvhPvMgyrvApg/KIBWZlhjMhM2yL0FsJcPxgI0dj0Mj3PIPWFaP/DBJcUJRECX0plIh4gwxVNQieQgTCMjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179505; c=relaxed/simple;
	bh=h97Z8ReCU+xd+KNDmeZpqXLVq0EMJ7zDMWEMSX7xcCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rOQUoqLibUIL1B9V9CMynNDEDMnzFOmU0m6+UI9JZ36feAeIGkDBzx1Te9xmHL8GuPpPVACQ4NWiWy8Liiv1b3t5sAjV7wdiDynnQetImPHIaao/7WiO7gZ+NRw+hTJ3mr8rfTe+zxqWhWHpsRZykLDYmqQkyPSoJt7BrY7OSwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8W8AewK; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8W8AewK"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6c524b4a3aeso42031676d6.3
        for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 05:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727179502; x=1727784302; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDdOGuVfdua5B6mt395zYJs4zH5s9MfP1lE9KgT4DwE=;
        b=E8W8AewKVoVFJZSW0pd6hWoR2W8UtRGm7u34bBBB27nwLiA1rsxS+OXhh/1+lYLdwV
         iWLhuacay+mhiiETj9KkyOcW6zRqNaxwRfHFINopUakj2P25KDzqRoywmuv2a0W7aRXr
         qucdtiA/ghTYKSb66x1sM256bOuZDJxd+MFqkjDAMi0AaxRimx047mXtLMG1s/Dnl0td
         UvMI79wHOrCC45JZIDz3iPLDOWSq9sOmbsFpWKcWoYCF9OGAG2VUV9vb7e9bV+F35oKK
         zYGZEhSVesrXB4zpw6xsJXn27Qrb0OROK21zyZYavMSGUg7fs9wxAUtHtU6mukXcRDMt
         eSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179502; x=1727784302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDdOGuVfdua5B6mt395zYJs4zH5s9MfP1lE9KgT4DwE=;
        b=eewMfQKh2F6EZw3x35NGjAB24HLc4mYruZinoMFLNEYt0XWqEu2UJRlHaafIyrZJmZ
         89hBbSVAy4L1HgPXzHFKX8fAfEJoxopLde9dcb/z6IE+qt1f/Zv80nH/DiZQUDKErIw9
         noy8JF4YV3B3reZ+9as9DVc3jKC6sEdNlNx0hlQkSc73Ysz7R4WAPNzYAU98yl7YMFF/
         jM6NidMYUtXjUgsmvww90o+gki8KM/VglCDjxiVOjp9Tx4vF4FFEbeJIJcXTJk1/+1vR
         5GD6Rd1sACQdf8Bh+BnSF26v5lVyKVUFAH7Md8ufmMoah/AOwNZIUN5baStDB4145PYS
         Jz/A==
X-Gm-Message-State: AOJu0YycPKuW0jcGHt5xGlcaRIVJWx8Mwte3p2gvMwjhknkGjLIBt1+h
	1Rq2wHtPR5zFjwdyBPdTJmu5GoCdR1Iwf8InUdEw+c+xXe0UPpo8jxzQLQ==
X-Google-Smtp-Source: AGHT+IHjE8QSig3lCZHN4L/LddEHuGVWGJ4p6o9OHDJmEksByRaCiB2WqK7tzCRuD/4V58KOVQKn+g==
X-Received: by 2002:a05:6214:4598:b0:6c5:64b2:71c3 with SMTP id 6a1803df08f44-6c7bd51b60dmr191784566d6.25.1727179502431;
        Tue, 24 Sep 2024 05:05:02 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4a6178sm5948056d6.7.2024.09.24.05.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:05:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 06/16] dpp: refactor dpp_configuration_start to take the JSON as a parameter
Date: Tue, 24 Sep 2024 05:04:37 -0700
Message-Id: <20240924120447.251761-6-prestwoj@gmail.com>
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

The configuration request for PSK networks is simple and static. This
is now defined as a static string and passed to
dpp_configuration_start.

For future 802.1x networks the configuration request object is more
complex (contains a CSR).
---
 src/dpp.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 19d10daa..16d0a711 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -60,6 +60,17 @@
 #define DPP_AUTH_PROTO_TIMEOUT 10
 #define DPP_PKEX_PROTO_TIMEOUT 120
 #define DPP_PKEX_PROTO_PER_FREQ_TIMEOUT 10
+/*
+ * The default JSON configuration object sent initially. For PSK networks this
+ * is sufficient, but for 802.1x the enrollee will be asked to send another
+ * request containing a CSR
+ */
+#define DPP_CONFIG_REQUEST_DEFAULT_VALUES \
+	"\"name\":\"IWD\"," \
+	"\"wi-fi_tech\":\"infra\"," \
+	"\"netRole\":\"sta\""
+#define DPP_CONFIG_REQUEST_DEFAULT_OBJECT \
+	"{" DPP_CONFIG_REQUEST_DEFAULT_VALUES "}"
 
 static uint32_t netdev_watch;
 static struct l_genl_family *nl80211;
@@ -753,14 +764,13 @@ static void dpp_reset_protocol_timer(struct dpp_sm *dpp, uint32_t time)
  *    does effect the resulting encryption/decryption so this is also what IWD
  *    will do to remain compliant with it.
  */
-static void dpp_configuration_start(struct dpp_sm *dpp, const uint8_t *addr)
+static void dpp_configuration_start(struct dpp_sm *dpp, const uint8_t *addr,
+					const char *json)
 {
-	const char *json = "{\"name\":\"IWD\",\"wi-fi_tech\":\"infra\","
-				"\"netRole\":\"sta\"}";
 	struct iovec iov[3];
 	uint8_t hdr[37];
-	uint8_t attrs[512];
 	size_t json_len = strlen(json);
+	uint8_t attrs[256 + json_len];
 	uint8_t *ptr = attrs;
 
 	l_getrandom(&dpp->diag_token, 1);
@@ -1689,7 +1699,8 @@ static void authenticate_confirm(struct dpp_sm *dpp, const uint8_t *from,
 	dpp_reset_protocol_timer(dpp, DPP_AUTH_PROTO_TIMEOUT);
 
 	if (dpp->role == DPP_CAPABILITY_ENROLLEE)
-		dpp_configuration_start(dpp, from);
+		dpp_configuration_start(dpp, from,
+					DPP_CONFIG_REQUEST_DEFAULT_OBJECT);
 
 	return;
 
@@ -2490,7 +2501,8 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 	dpp_send_authenticate_confirm(dpp);
 
 	if (dpp->role == DPP_CAPABILITY_ENROLLEE)
-		dpp_configuration_start(dpp, from);
+		dpp_configuration_start(dpp, from,
+					DPP_CONFIG_REQUEST_DEFAULT_OBJECT);
 
 }
 
-- 
2.34.1

