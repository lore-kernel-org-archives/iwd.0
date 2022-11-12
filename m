Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0330C7E
	for <iwd@lists.linux.dev>; Sat, 12 Nov 2022 01:19:41 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso6560460wme.5
        for <iwd@lists.linux.dev>; Fri, 11 Nov 2022 17:19:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLV0MssQfnGqsclJUmpcakfwDi1LC/w3KlrS5GwbnZk=;
        b=0gtYEI+SccP121DqgVQWYMJTJxw1qKeZhXcvbZwOAvPEPuw0+p1P8x9eUXSVNNOTXX
         pMFW8b3YPTxzhzARlzrJpZ7S5UxTEhnvianvJgSHX2QP+bZvhYf5evIbTJS9hZlU1a8D
         iXbBiiWGUedsxfqeHPd1qAkcI5yfubHIELxCD5kgIK+aOsz2xUjVGuQAWylEy3IsYxiB
         IrKDdXi5guzVOw/xAUaqW/FrZ3w8UGylpfonezXSopsu2c0t3X6IiVys2cPKAzhc4bIy
         MMywmVnJG6syfhzLmmTr1RNOrPUR8vVY46b7WRMs7OOXuMyOVh7S+d9+LqUa5pO2cy77
         MVXA==
X-Gm-Message-State: ANoB5pmWUjdzKjWqHpfTMYhbokuteuVpnH60fh8+Ala1J63JaU55w6oJ
	4fTerFQiTw5EQxSVVyi4CXPLgVM5kbA=
X-Google-Smtp-Source: AA0mqf6YsOKQ1zwWIRKSsmV7chXVOLmQXNkpgEmPdIjTcRiTQtpd7U3GK5OT5v8OCJVTs+kpD88buQ==
X-Received: by 2002:a05:600c:4f53:b0:3cf:75db:c417 with SMTP id m19-20020a05600c4f5300b003cf75dbc417mr2630951wmq.109.1668215979391;
        Fri, 11 Nov 2022 17:19:39 -0800 (PST)
Received: from localhost.localdomain ([82.213.230.158])
        by smtp.gmail.com with ESMTPSA id bi14-20020a05600c3d8e00b003b95ed78275sm4437734wmb.20.2022.11.11.17.19.37
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 17:19:38 -0800 (PST)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 1/3] storage: Maintain the tls session cache object
Date: Sat, 12 Nov 2022 02:19:27 +0100
Message-Id: <20221112011929.785388-1-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of only providing methods to load and save the TLS cache from/to
file, keep the memory copy of the cache directly in storage.c since it
doesn't fit anywhere else conceptually.  storage.c now only provides a
getter for the cache object and the _sync method to be called by anyone
who makes a change to the cache object.

While the use case is for eap-tls-common.c to call these, the same cache
object could be used if l_tls is used in another part of IWD.  Any
sessions saved in relation to a specific network (ESS) should use group
names ending in the storage_get_network_file_path encoding of the
network's SSID+security type, so that storage.c can automatically drop
these cache entries if the network is being forgotten.

Since the cache object needs to be freed when exiting, use
storage_exit() for that.  However, since there was already a
storage_init() and storage_exit() pair of functions, with storage_init
called from main.c conditionally on whether systemd encryption was
enabled, rename that storage_init() to storage_key_init() and declare an
IWD_MODULE to hanadle the calling of the new storage_init() and
storage_exit().  There's no warranty that those will be called before
and after any other module's init/exit but they're not necessary for any
functionality that other modules depend on.
---
 src/main.c    |  3 +-
 src/storage.c | 92 ++++++++++++++++++++++++++++++++++++++++-----------
 src/storage.h |  7 ++--
 3 files changed, 77 insertions(+), 25 deletions(-)

diff --git a/src/main.c b/src/main.c
index a3d85535..3da4c7fe 100644
--- a/src/main.c
+++ b/src/main.c
@@ -451,7 +451,7 @@ static bool setup_system_key(void)
 		goto unmap;
 	}
 
-	r = storage_init(key, st.st_size);
+	r = storage_key_init(key, st.st_size);
 	munlock(key, st.st_size);
 
 unmap:
@@ -600,7 +600,6 @@ int main(int argc, char *argv[])
 	exit_status = l_main_run_with_signal(signal_handler, NULL);
 
 	iwd_modules_exit();
-	storage_exit();
 
 failed_storage:
 	dbus_exit();
diff --git a/src/storage.c b/src/storage.c
index b2c5ed48..68814aae 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -46,6 +46,9 @@
 
 #include "src/missing.h"
 #include "src/common.h"
+#include "src/module.h"
+#include "src/scan.h"
+#include "src/knownnetworks.h"
 #include "src/storage.h"
 #include "src/crypto.h"
 
@@ -53,12 +56,13 @@
 #define STORAGE_FILE_MODE (S_IRUSR | S_IWUSR)
 
 #define KNOWN_FREQ_FILENAME ".known_network.freq"
-#define TLS_CACHE_FILENAME ".tls-session-cache"
+#define TLS_SESSION_CACHE_FILENAME ".tls-session-cache"
 
 static char *storage_path = NULL;
 static char *storage_hotspot_path = NULL;
 static uint8_t system_key[32];
 static bool system_key_set = false;
+static struct l_settings *tls_session_cache;
 
 static int create_dirs(const char *filename)
 {
@@ -653,14 +657,40 @@ void storage_network_sync(enum security type, const char *ssid,
 	write_file(data, length, true, "%s", path);
 }
 
+static void storage_network_remove_tls_sessions(const char *path)
+{
+	_auto_(l_strv_free) char **groups = NULL;
+	char **group;
+	size_t group_len;
+	size_t path_len;
+	bool changed = false;
+
+	if (!tls_session_cache)
+		return;
+
+	groups = l_settings_get_groups(tls_session_cache);
+	path_len = strlen(path);
+
+	for (group = groups; *group; group++)
+		if ((group_len = strlen(*group)) > path_len &&
+				!memcmp(*group + group_len - path_len, path,
+					path_len)) {
+			l_settings_remove_group(tls_session_cache, *group);
+			changed = true;
+		}
+
+	if (changed)
+		storage_tls_session_cache_sync();
+}
+
 int storage_network_remove(enum security type, const char *ssid)
 {
-	char *path;
+	_auto_(l_free) char *path = storage_get_network_file_path(type, ssid);
 	int ret;
 
-	path = storage_get_network_file_path(type, ssid);
 	ret = unlink(path);
-	l_free(path);
+
+	storage_network_remove_tls_sessions(path);
 
 	return ret < 0 ? -errno : 0;
 }
@@ -702,29 +732,42 @@ void storage_known_frequencies_sync(struct l_settings *known_freqs)
 	l_free(known_freq_file_path);
 }
 
-struct l_settings *storage_tls_session_cache_load(void)
+struct l_settings *storage_tls_session_cache_get(void)
 {
-	_auto_(l_settings_free) struct l_settings *cache = l_settings_new();
-	_auto_(l_free) char *tls_cache_file_path =
-		storage_get_path("%s", TLS_CACHE_FILENAME);
+	_auto_(l_free) char *cache_file_path = NULL;
 
-	if (unlikely(!l_settings_load_from_file(cache, tls_cache_file_path)))
-		return NULL;
+	if (tls_session_cache)
+		return tls_session_cache;
 
-	return l_steal_ptr(cache);
+	cache_file_path = storage_get_path("%s", TLS_SESSION_CACHE_FILENAME);
+	tls_session_cache = l_settings_new();
+
+	if (!l_settings_load_from_file(tls_session_cache, cache_file_path))
+		l_debug("No session cache loaded from %s, starting with an "
+			"empty cache", cache_file_path);
+
+	return tls_session_cache;
 }
 
-void storage_tls_session_cache_sync(struct l_settings *cache)
+void storage_tls_session_cache_sync(void)
 {
-	_auto_(l_free) char *tls_cache_file_path = NULL;
+	_auto_(l_free) char *cache_file_path = NULL;
+	_auto_(l_free) char *settings_data = NULL;
 	_auto_(l_free) char *data = NULL;
 	size_t len;
+	static const char comment[] =
+		"# External changes to this file are not tracked by IWD "
+		"and will be overwritten.\n\n";
+	static const size_t comment_len = L_ARRAY_SIZE(comment) - 1;
 
-	if (!cache)
+	if (L_WARN_ON(!tls_session_cache))
 		return;
 
-	tls_cache_file_path = storage_get_path("%s", TLS_CACHE_FILENAME);
-	data = l_settings_to_data(cache, &len);
+	cache_file_path = storage_get_path("%s", TLS_SESSION_CACHE_FILENAME);
+	settings_data = l_settings_to_data(tls_session_cache, &len);
+	data = l_malloc(comment_len + len);
+	memcpy(data, comment, comment_len);
+	memcpy(data + comment_len, settings_data, len);
 
 	/*
 	 * Note this data contains cryptographic secrets.  write_file()
@@ -732,7 +775,8 @@ void storage_tls_session_cache_sync(struct l_settings *cache)
 	 *
 	 * TODO: consider encrypting with system_key.
 	 */
-	write_file(data, len, false, "%s", tls_cache_file_path);
+	write_file(data, comment_len + len, false, "%s", cache_file_path);
+	explicit_bzero(settings_data, len);
 	explicit_bzero(data, len);
 }
 
@@ -768,7 +812,7 @@ bool storage_is_file(const char *filename)
  *	TK = HKDF-Extract(<zero>, IKM)
  *	OKM = HKDF-Expand(TK, "System Key", 32)
  */
-bool storage_init(const uint8_t *key, size_t key_len)
+bool storage_key_init(const uint8_t *key, size_t key_len)
 {
 	uint8_t tmp[32];
 
@@ -786,10 +830,20 @@ bool storage_init(const uint8_t *key, size_t key_len)
 	return system_key_set;
 }
 
-void storage_exit(void)
+static int storage_init(void)
+{
+	return 0;
+}
+
+static void storage_exit(void)
 {
 	if (system_key_set) {
 		explicit_bzero(system_key, sizeof(system_key));
 		munlock(system_key, sizeof(system_key));
 	}
+
+	l_settings_free(tls_session_cache);
+	tls_session_cache = NULL;
 }
+
+IWD_MODULE(storage, storage_init, storage_exit)
diff --git a/src/storage.h b/src/storage.h
index fe6ddbf5..de41541e 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -51,8 +51,8 @@ int storage_network_remove(enum security type, const char *ssid);
 struct l_settings *storage_known_frequencies_load(void);
 void storage_known_frequencies_sync(struct l_settings *known_freqs);
 
-struct l_settings *storage_tls_session_cache_load(void);
-void storage_tls_session_cache_sync(struct l_settings *cache);
+struct l_settings *storage_tls_session_cache_get(void);
+void storage_tls_session_cache_sync(void);
 
 int __storage_decrypt(struct l_settings *settings, const char *ssid,
 				bool *changed);
@@ -61,5 +61,4 @@ char *__storage_encrypt(const struct l_settings *settings, const char *ssid,
 bool storage_decrypt(struct l_settings *settings, const char *path,
 			const char *name);
 
-bool storage_init(const uint8_t *key, size_t key_len);
-void storage_exit(void);
+bool storage_key_init(const uint8_t *key, size_t key_len);
-- 
2.34.1

