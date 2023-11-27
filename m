Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A31D2101
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 02:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUDClRXL"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1fa235f8026so981570fac.3
        for <iwd@lists.linux.dev>; Sun, 26 Nov 2023 18:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701053652; x=1701658452; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKDgGHMrWORPgBvpnyVLaY7eQykmoBEiF76/XPWnxp8=;
        b=AUDClRXLix6vhdbTk049vlqvyqsI3jouv7ROgFKGAm2Pnv0TB6+tYEwOk/LyfFdKFU
         6EaYTkTnDF1lZL98MXNj57qmqxIZgKhI+JqS5TBaZhVsSNdHSYzq9OGcUCkZ/RB7lBEx
         OBNZtQZui9cj3jKmRJhmrr/1oona52w2iy7aXOWWzV770p2twTXO7iIA5ed7sav+CTRI
         TRIO9eY7QTJmZ4DW2u2huH190tji7junBdqgdEcB2RB59OKbA2M6/1tPjqDxFJ/l8AM/
         HtOIK+m1p/g+sUXKzybELy1QbV/C0xaX/QjVnIKY4+y7TlbpH41wO+XdYM7yUmkEBJXp
         4uhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701053652; x=1701658452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKDgGHMrWORPgBvpnyVLaY7eQykmoBEiF76/XPWnxp8=;
        b=plIuZtuqVuZZ+j3X2A3JerpAF+DShW4KzUIIJaqupwxyCR73EysruwDeNor3gnjQfo
         tq/0J1Tf+5SVsXAgqZkI3pAGdTFPCB38f8B4/qsk+twRhc37j3NpXMSmvczbygMvMjRk
         aMqgdMsNWthhjl/eOUM5Ft6o1AlujRq5M4MjkjRfjAaOdVDn7WHJZdJGhbXVcCmI5rNH
         hR0XREOv95tgcvDlqX1H+/sHqvFe5WerexhYb3sM5NDhaIvgBGPH/n8k+c2RW43SOTCO
         TmaloClTqywu17yGFGa1KIliaAY7XdrB8nY6GddFOG8bFizwGn78Gzcrp1MBhDH+QUyi
         6gIA==
X-Gm-Message-State: AOJu0YzWnBUFbfz0s8gQOyD2ek8CIwMK9/MikLFXRkpcnCfQ32SHEHDa
	+rzsznvjOFaLpfvLEypeUXAIER0KQlM=
X-Google-Smtp-Source: AGHT+IF2S72t3jkGTz6WB+Uys68KN/mZt+LEo306zvCxxscmNAJXp1fNSQVpZRKcIMohTLyzyA3lYA==
X-Received: by 2002:a05:6870:15c5:b0:1fa:3486:258a with SMTP id k5-20020a05687015c500b001fa3486258amr6385807oad.18.1701053652388;
        Sun, 26 Nov 2023 18:54:12 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id ti3-20020a056871890300b001f9e3731545sm1818846oab.11.2023.11.26.18.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 18:54:12 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 6/6] erp: Fix buffer overflow for 32 byte SSIDs
Date: Sun, 26 Nov 2023 20:53:03 -0600
Message-ID: <20231127025320.1310543-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127025320.1310543-1-denkenz@gmail.com>
References: <20231127025320.1310543-1-denkenz@gmail.com>
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

