Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73AF81C
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 04:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUxxprYd"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1fa289a35e7so604635fac.1
        for <iwd@lists.linux.dev>; Sun, 26 Nov 2023 20:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701060016; x=1701664816; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKDgGHMrWORPgBvpnyVLaY7eQykmoBEiF76/XPWnxp8=;
        b=XUxxprYd1Y4JkPm0+JhAQTFBCWVlEcqabcMNilaNG16lQfwdWv8Kmt14deF8ddeMhS
         n4ZjOsyJO5emhnzo3BrJ0U9UEFx3VKJeYCH3bt5Zo1ZX8XEX2rfyPWI/ZF3gXMX0lied
         dtvHisAa9HrCzHKiN2PwF171eRGezNz3k47eiSQE1Fl7qyQbvTH88Cb0dn8Z2c1e/NIb
         60a7Qkl90N8GnYSday4FI8zZ/buJgYCtd0pRZNClbQo9bz5j7E++fNdP3zCetzBQrtaz
         8f30YRTybj0qfbzPf6IyDG0iPsPdV6YORK4ifV3GYMNlZ8m4Tyroe7V+Up/xvd8kJb3p
         5/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701060016; x=1701664816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKDgGHMrWORPgBvpnyVLaY7eQykmoBEiF76/XPWnxp8=;
        b=bOK9IHn2FDwyS8n9jk72PfpEW90qPwU7gJaer2huAm2TEv6Cub+25eJifHpzFONb31
         eUGMWVDwidKgpwCliGgF01HVCYtNSDi2/GxfCXzWu6fHfXqDRTCefJyq//khnwEDCVhY
         hDJq0owBdNTCHi0A/l4gGMn8WSRpWJYtb3NFMNP8nseo5aKSmRrxU+DL2/nJk7FlOv5U
         oDMzKAzpW2AUm8bkLXWr0Oe+pluirLD6w8uaL3T1FxyWfiGWs8yLfC444abeBRY1njkt
         OT0UusGSUYSuKvWrep5NaciZh8JXcZ4qkZBXCZYP0DnKBRSSMOZ5dMsG4fdZk1SLsjTE
         Qp2w==
X-Gm-Message-State: AOJu0YxjFBRwqg0blpjxHHbVF557qn/jU4uRZ18Y3VzWqXTdSMCGq7V7
	e8Lgvu43YavQJat/5excFXvJg9MY5Yc=
X-Google-Smtp-Source: AGHT+IG8XvIfle9lG0KQdRrYEY9fhs+rlVvvFIcv140aOGFYlhSYDjtIM/eHoRhXQVPLHW2eQfc8yQ==
X-Received: by 2002:a05:6870:be8b:b0:1ea:2447:5181 with SMTP id nx11-20020a056870be8b00b001ea24475181mr12895990oab.9.1701060015746;
        Sun, 26 Nov 2023 20:40:15 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id nq6-20020a056871378600b001f5d5930e85sm2110558oac.33.2023.11.26.20.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 20:40:15 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 6/6] erp: Fix buffer overflow for 32 byte SSIDs
Date: Sun, 26 Nov 2023 22:38:46 -0600
Message-ID: <20231127043924.1328538-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127043924.1328538-1-denkenz@gmail.com>
References: <20231127043924.1328538-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ssid is declared as a 32 byte field in handshake_state, hence using it
as a string which is assumed to be nul-terminated will fail for SSIDs
that are 32 bytes long.

Fixes: d938d362b212 ("erp: ERP implementation and key cache move")
Fixes: 433373fe28a4 ("eapol: cache ERP keys on EAP success")
---
 src/eapol.c |  2 +-
 src/erp.c   | 10 ++++++++--
 src/erp.h   |  2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 6fb2f3068f0b..3d7b3d38fbcd 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -2531,7 +2531,7 @@ static void eapol_eap_results_cb(const uint8_t *msk_data, size_t msk_len,
 	if (sm->handshake->support_fils && emsk_data && session_id)
 		erp_cache_add(eap_get_identity(sm->eap), session_id,
 				session_len, emsk_data, emsk_len,
-				(const char *)sm->handshake->ssid);
+				sm->handshake->ssid, sm->handshake->ssid_len);
 
 	return;
 
diff --git a/src/erp.c b/src/erp.c
index 2729cfc874b4..859233465e8b 100644
--- a/src/erp.c
+++ b/src/erp.c
@@ -160,13 +160,19 @@ static void erp_cache_entry_destroy(void *data)
 
 void erp_cache_add(const char *id, const void *session_id,
 			size_t session_len, const void *emsk, size_t emsk_len,
-			const char *ssid)
+			const uint8_t *ssid, size_t ssid_len)
 {
 	struct erp_cache_entry *entry;
 
 	if (!unlikely(id || session_id || emsk))
 		return;
 
+	if (!util_ssid_is_utf8(ssid_len, ssid))
+		return;
+
+	if (util_ssid_is_hidden(ssid_len, ssid))
+		return;
+
 	entry = l_new(struct erp_cache_entry, 1);
 
 	entry->id = l_strdup(id);
@@ -174,7 +180,7 @@ void erp_cache_add(const char *id, const void *session_id,
 	entry->emsk_len = emsk_len;
 	entry->session_id = l_memdup(session_id, session_len);
 	entry->session_len = session_len;
-	entry->ssid = l_strdup(ssid);
+	entry->ssid = l_strndup((char *) ssid, ssid_len);
 	entry->expire_time = l_time_offset(l_time_now(),
 					ERP_DEFAULT_KEY_LIFETIME_US);
 
diff --git a/src/erp.h b/src/erp.h
index d2c9da9624a8..e844aa8ebf90 100644
--- a/src/erp.h
+++ b/src/erp.h
@@ -43,7 +43,7 @@ const void *erp_get_rmsk(struct erp_state *erp, size_t *rmsk_len);
 
 void erp_cache_add(const char *id, const void *session_id, size_t session_len,
 			const void *emsk, size_t emsk_len,
-			const char *ssid);
+			const uint8_t *ssid, size_t ssid_len);
 
 void erp_cache_remove(const char *id);
 
-- 
2.42.0

