Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A052717C2
	for <iwd@lists.linux.dev>; Wed,  9 Nov 2022 17:04:53 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so1733127wmi.3
        for <iwd@lists.linux.dev>; Wed, 09 Nov 2022 09:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+9J3H7GVIUyAPHCdrk/KSjJCUieWgqmnIdcHUNwToU=;
        b=26QXeX/ioMWLZGEFamGlMgPHTYUkn9yIlaN/LNFiBiVH09snuvPXDFxdM/5Fyjl+Ff
         1w5t3v03lNRexmonLgaA9PnyITaYlT7lg8jychcB0Hk3sQGrYOMx7Gf6+JI4Ar+Kew9E
         947RJ1eFMPweSN+PZP9F1F4Jmz5VVB1KcZ2xCFPLkuxyy7Bqj/PpGu6sQokCPZbmPanq
         D6WzCD5Z/qQ1WHOKA7YpL1Yq+UUAXPQ2FFie9WVZJWBoWTikQ1zEekwL85bGcvv1cU8S
         hSQDKlghjX3iqvonk4fBGRF3qArd188CkuxpaFI1KweSZU2HMx2F4AHP+nw0WJkUzlp3
         +dzg==
X-Gm-Message-State: ACrzQf3gt4oKQupkFPW9qSHYNbgHIUs0UG6bTFXjT7EVaWh1A3Do6j9T
	eBqBu6WIcWooy4Mj0J7/IWWP8V4HndA=
X-Google-Smtp-Source: AMsMyM5ZmfokkeBuu0U33ZoFPDWLMgNUaKzE137uVXMTtFn5/MioiWoK/6F0516HcicyE1RQy8lZBw==
X-Received: by 2002:a05:600c:1614:b0:3cf:816e:4a69 with SMTP id m20-20020a05600c161400b003cf816e4a69mr30728215wmn.33.1668013491128;
        Wed, 09 Nov 2022 09:04:51 -0800 (PST)
Received: from localhost.localdomain ([82.213.230.158])
        by smtp.gmail.com with ESMTPSA id z19-20020a7bc7d3000000b003c6deb5c1edsm2089909wmk.45.2022.11.09.09.04.50
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:04:50 -0800 (PST)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 1/2] storage: Add TLS session cache file read/write utils
Date: Wed,  9 Nov 2022 18:04:37 +0100
Message-Id: <20221109170438.535300-1-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add storage_tls_session_cache_{load,sync} similar to
storage_known_frequencies_{load,sync}.
---
 src/storage.c | 35 +++++++++++++++++++++++++++++++++++
 src/storage.h |  3 +++
 2 files changed, 38 insertions(+)

diff --git a/src/storage.c b/src/storage.c
index d6e478bd..b2c5ed48 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -53,6 +53,7 @@
 #define STORAGE_FILE_MODE (S_IRUSR | S_IWUSR)
 
 #define KNOWN_FREQ_FILENAME ".known_network.freq"
+#define TLS_CACHE_FILENAME ".tls-session-cache"
 
 static char *storage_path = NULL;
 static char *storage_hotspot_path = NULL;
@@ -701,6 +702,40 @@ void storage_known_frequencies_sync(struct l_settings *known_freqs)
 	l_free(known_freq_file_path);
 }
 
+struct l_settings *storage_tls_session_cache_load(void)
+{
+	_auto_(l_settings_free) struct l_settings *cache = l_settings_new();
+	_auto_(l_free) char *tls_cache_file_path =
+		storage_get_path("%s", TLS_CACHE_FILENAME);
+
+	if (unlikely(!l_settings_load_from_file(cache, tls_cache_file_path)))
+		return NULL;
+
+	return l_steal_ptr(cache);
+}
+
+void storage_tls_session_cache_sync(struct l_settings *cache)
+{
+	_auto_(l_free) char *tls_cache_file_path = NULL;
+	_auto_(l_free) char *data = NULL;
+	size_t len;
+
+	if (!cache)
+		return;
+
+	tls_cache_file_path = storage_get_path("%s", TLS_CACHE_FILENAME);
+	data = l_settings_to_data(cache, &len);
+
+	/*
+	 * Note this data contains cryptographic secrets.  write_file()
+	 * happens to set the right permissions on the file.
+	 *
+	 * TODO: consider encrypting with system_key.
+	 */
+	write_file(data, len, false, "%s", tls_cache_file_path);
+	explicit_bzero(data, len);
+}
+
 bool storage_is_file(const char *filename)
 {
 	char *path;
diff --git a/src/storage.h b/src/storage.h
index 6877fb65..fe6ddbf5 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -51,6 +51,9 @@ int storage_network_remove(enum security type, const char *ssid);
 struct l_settings *storage_known_frequencies_load(void);
 void storage_known_frequencies_sync(struct l_settings *known_freqs);
 
+struct l_settings *storage_tls_session_cache_load(void);
+void storage_tls_session_cache_sync(struct l_settings *cache);
+
 int __storage_decrypt(struct l_settings *settings, const char *ssid,
 				bool *changed);
 char *__storage_encrypt(const struct l_settings *settings, const char *ssid,
-- 
2.34.1

