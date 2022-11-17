Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65662FAF
	for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 13:56:23 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id r126-20020a1c4484000000b003cffd336e24so475027wma.4
        for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 05:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxIXBsPersiO9Fq+Cd6pMlap2olBxokqNvxZf6efH3M=;
        b=4Niby60JyYz1EPiajGEFikZAkjPkhCgRrE1cjKA5oBvyDdMm47pk9s+sKZBKarLVHN
         UbKotEiNIr5H6Sp5SIh/Zv0JSQtVSURQppO/6MtLcllSk7cs6rFTVxcg18g6JstL0HAb
         sZZTMJrz43IlrH/PCdEg0iTW6dZ7F+Y5jRfL/f6daqzblPEdrr2F/mvzfIwxFUnetIqJ
         XRfs8OES4L31v62jMvVvT64KPFV3IP0cno6gLJ4abMCUE3P6B6OP3mcNx/ERquGE1hW9
         7+DGwMVFD9j4xw+zX0ABGz3jT/+8Y8bbl5bJwTSLFyLdRLkZsJ9gKLmkAPYfZvTRJ2Bl
         6FWQ==
X-Gm-Message-State: ANoB5pkuWohzRhUvZh1AlcQI62VFr3GRCpry4JlWZDK4FnZYXqRsg4ht
	QVDx7E36RKacgA5IUxhahOH//G2+jns=
X-Google-Smtp-Source: AA0mqf7KmI4JXd5R3Jcz4jjxzR9tQfN4FYUF4laoGMuYoo2qZ/taXKwu0QXnrE8EOrRR7HoTwG1Hcw==
X-Received: by 2002:a1c:e917:0:b0:3cf:681a:43e1 with SMTP id q23-20020a1ce917000000b003cf681a43e1mr1685877wmc.126.1668693381443;
        Thu, 17 Nov 2022 05:56:21 -0800 (PST)
Received: from localhost.localdomain ([82.213.230.158])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d6885000000b002366b17ca8bsm1142632wru.108.2022.11.17.05.56.20
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 05:56:20 -0800 (PST)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 1/3] storage: Refactor storage_tls_session_{load,sync}
Date: Thu, 17 Nov 2022 14:56:08 +0100
Message-Id: <20221117135610.1162965-1-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Minor changes to these two methods resulting from two rewrites of them.
Actual changes are:
 * storage_tls_session_sync parameter is const,
 * more specific naming,
 * storage_tls_session_load will return an empty l_settings instead of
   NULL so eap-tls-common.c doesn't have to handle this.

storage.c makes no assumptions about the group names in the l_settings
object and keeps no reference to that object, eap-tls-common.c is going
to maintain the memory copy of the cache since this cache and the disk
copy of it are reserved for EAP methods only.
---
 src/storage.c | 39 +++++++++++++++++++++++----------------
 src/storage.h |  4 ++--
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index b2c5ed48..4200030c 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -53,7 +53,7 @@
 #define STORAGE_FILE_MODE (S_IRUSR | S_IWUSR)
 
 #define KNOWN_FREQ_FILENAME ".known_network.freq"
-#define TLS_CACHE_FILENAME ".tls-session-cache"
+#define EAP_TLS_CACHE_FILENAME ".eap-tls-session-cache"
 
 static char *storage_path = NULL;
 static char *storage_hotspot_path = NULL;
@@ -702,29 +702,35 @@ void storage_known_frequencies_sync(struct l_settings *known_freqs)
 	l_free(known_freq_file_path);
 }
 
-struct l_settings *storage_tls_session_cache_load(void)
+struct l_settings *storage_eap_tls_cache_load(void)
 {
-	_auto_(l_settings_free) struct l_settings *cache = l_settings_new();
-	_auto_(l_free) char *tls_cache_file_path =
-		storage_get_path("%s", TLS_CACHE_FILENAME);
+	_auto_(l_free) char *path =
+		storage_get_path("%s", EAP_TLS_CACHE_FILENAME);
+	struct l_settings *cache = l_settings_new();
 
-	if (unlikely(!l_settings_load_from_file(cache, tls_cache_file_path)))
-		return NULL;
+	if (!l_settings_load_from_file(cache, path))
+		l_debug("No session cache loaded from %s, starting with an "
+			"empty cache", path);
 
-	return l_steal_ptr(cache);
+	return cache;
 }
 
-void storage_tls_session_cache_sync(struct l_settings *cache)
+void storage_eap_tls_cache_sync(const struct l_settings *cache)
 {
-	_auto_(l_free) char *tls_cache_file_path = NULL;
+	_auto_(l_free) char *path =
+		storage_get_path("%s", EAP_TLS_CACHE_FILENAME);
+	_auto_(l_free) char *settings_data = NULL;
 	_auto_(l_free) char *data = NULL;
 	size_t len;
+	static const char comment[] =
+		"# External changes to this file are not tracked by IWD "
+		"and will be overwritten.\n\n";
+	static const size_t comment_len = L_ARRAY_SIZE(comment) - 1;
 
-	if (!cache)
-		return;
-
-	tls_cache_file_path = storage_get_path("%s", TLS_CACHE_FILENAME);
-	data = l_settings_to_data(cache, &len);
+	settings_data = l_settings_to_data(cache, &len);
+	data = l_malloc(comment_len + len);
+	memcpy(data, comment, comment_len);
+	memcpy(data + comment_len, settings_data, len);
 
 	/*
 	 * Note this data contains cryptographic secrets.  write_file()
@@ -732,7 +738,8 @@ void storage_tls_session_cache_sync(struct l_settings *cache)
 	 *
 	 * TODO: consider encrypting with system_key.
 	 */
-	write_file(data, len, false, "%s", tls_cache_file_path);
+	write_file(data, comment_len + len, false, "%s", path);
+	explicit_bzero(settings_data, len);
 	explicit_bzero(data, len);
 }
 
diff --git a/src/storage.h b/src/storage.h
index fe6ddbf5..04b50882 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -51,8 +51,8 @@ int storage_network_remove(enum security type, const char *ssid);
 struct l_settings *storage_known_frequencies_load(void);
 void storage_known_frequencies_sync(struct l_settings *known_freqs);
 
-struct l_settings *storage_tls_session_cache_load(void);
-void storage_tls_session_cache_sync(struct l_settings *cache);
+struct l_settings *storage_eap_tls_cache_load(void);
+void storage_eap_tls_cache_sync(const struct l_settings *cache);
 
 int __storage_decrypt(struct l_settings *settings, const char *ssid,
 				bool *changed);
-- 
2.34.1

