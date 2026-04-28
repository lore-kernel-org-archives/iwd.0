Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C63E5571
	for <iwd@lists.linux.dev>; Tue, 28 Apr 2026 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777376901; cv=none; b=VVugqM9HP0OlhV3+JVHgPDmbD9ZNJI4U8Fq0tj07C4rDnVV/h6DOk0a+m6bkehaCiGUVdA3MHeK8TfPQygsiSpK2ypPMV1WSR2EPodzhvp5CebH1jf82UMN+LLOw4dlSM12foxCj0XmMS7hYecgQrFdrl5ypWgHB7+GxL4dyBQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777376901; c=relaxed/simple;
	bh=0/gcPz7AT1ufMSI73VHDFXbeuxYZyg4IhskY+0EgI5Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dw2itU1Aov13y1wvJuv2xkDV5f7+WLvjFeUOoCDemiJWt28/ZibTQl5Llo19XMBD2SU+W7UWoq9MVKvLrdMsPwj6X2wGcQ0Ip9II2ln3pDJG3NSYbDMSM2o3eArQWGvZb3NZu9SlT6VUtW0jgArCzBNdCb8U5BcTaJXy4PQ33DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=LcoUUxDg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="LcoUUxDg"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso86441865e9.2
        for <iwd@lists.linux.dev>; Tue, 28 Apr 2026 04:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1777376898; x=1777981698; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWmh2Mnjqzs/aPYBaCA5AQ8VzzvAmmliGDuqZr5ZY5Q=;
        b=LcoUUxDgLQ2XPRSTf0jLJSy3Yl1/gOkECY7O2Gh/A9+ZTLo5SAeBDRpIh8+pl6xmhH
         nTbl6oJ2vjBIose6b2u/w5VeqJVrbrYkSyyOuTWUObCPPxrlA+eES93SrAtNiy6/lMgr
         ts3+SAXkWRXcjlfm72mldDtJOfnYNaoiXH39Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777376898; x=1777981698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CWmh2Mnjqzs/aPYBaCA5AQ8VzzvAmmliGDuqZr5ZY5Q=;
        b=Y31RUv3KFcu3Bgix9You9wZgqgmriktA7jN/lvQdRM65AX7if8m13g+xZh2KvJ0SXS
         7E/VSHvtcJgXCGUtLmR3JgvCB3l6jNThu8FZ5jU9XKmlLGs2TAOck8F9hPWSaV/x/rsl
         av+EEho02nfbLdgZwst5qMAcI6Wj3Dothv0Dh/S1CxCosHY+HLwlP/qUHTyCPV6cSXjK
         Eoxvj2aoec2+sYXzeNjNc/JLjcdbSK28KXYCuoeF8hub5HCXPgFfCtX2hJH2bt2HakQ5
         aYCCOV0KMKOkdLuvyfACS64movb96BAl1OihWrxO6ILNlf7SMZZBjAAgsDg/pfvjWto8
         bmNA==
X-Gm-Message-State: AOJu0YxqluAs5ur9KguNWKtl1tiV7VZt3bKG6c3WSDNhxBMyN99gWmcI
	qm6faEjYY9cbzE0qe4+dnkn8L2+T2hZP47kzuHpqm1nFoTgOHKuvRa9TqpQEjftXEUtqhzDtTYR
	Dw5bz
X-Gm-Gg: AeBDieuVsiwjywts1dQxcG8e/MCnINUzhBuRkS+KD4ZHz+j9pO6fEghNipikG7mCVol
	5G/XVrkIr8WaKZih8hI0YoCCI5gnymujZEPh3laaT7iOeIdNMmU8BcCpDApiSA22lL1WTS+jYM1
	BDMIrwHiIt0WGANUw1I7maj0EDZ3pMESIiyoAme5WC6pikV25mclq8UrmZOWkjJXFnpD4v7Mqn6
	+dZiaFzoforw/DRqd2B8gHIwHOpbKYuFA9dTTui3XMs+2dh+sg5wpM/mljDVB4XyykKwtrUDOLW
	oi2vQ9YkvZQZlcf+5Q7Ecj2wXTNifwbSJ2uqe1FMox5uyuwnLZCiwzmiD+el7A+pE2/iwXT6Qpp
	mOc7hGpbUC+sGU+pRQ6GLfITArcJFLRKRjpbr+DnlNDRIshswBpF8QJ+wlHneiQVK8C/4vGbv2Q
	0vvsU29DeFo6bDkws1BdfYuXN98EkodcnDLvKRMWi5VCwBmUAIdUAl5E5pz0U1OglaEFdgHiTpa
	+Sc8Xmbx2N8vuiNarGuLpw8LyyIbBWt9nqNxpBBFhFGQ6UA9gPws6BGMLs23ib951Vp+Skf/M7G
	llCuPypWTAOXnlvEWyUCk+yWcLRsjzaqGArLE+BxVN4M8nOWbe1WwkD7+TyQpQG582StTocovkz
	444N8O7Cnww==
X-Received: by 2002:a05:600c:8283:b0:489:1f08:91b with SMTP id 5b1f17b1804b1-48a77b1da8emr42798535e9.16.1777376897757;
        Tue, 28 Apr 2026 04:48:17 -0700 (PDT)
Received: from mkurz-macbook-pro.fritz.box (2a02-8388-82c0-2a80-411b-7cbe-f9f6-9ad1.cable.dynamic.v6.surfer.at. [2a02:8388:82c0:2a80:411b:7cbe:f9f6:9ad1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a775eb91dsm16862895e9.20.2026.04.28.04.48.16
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:48:17 -0700 (PDT)
From: Matthias Kurz <m.kurz@irregular.at>
To: iwd@lists.linux.dev
Subject: [PATCH 1/2] network: add externally managed profiles
Date: Tue, 28 Apr 2026 13:47:56 +0200
Message-ID: <20260428114809.75413-2-m.kurz@irregular.at>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428114809.75413-1-m.kurz@irregular.at>
References: <20260428114809.75413-1-m.kurz@irregular.at>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add [Settings].ExternallyManaged for network profiles whose contents
are owned by another network manager. IWD still reads these profiles
for connection setup, but avoids updating them as a side effect of
network operation.

Skip connection timestamp/profile writes, security cache writes,
automatic profile encryption rewrites, and KnownNetwork AutoConnect
persistence for externally managed profiles. Explicit Forget remains
available through the existing removal path.

Add storage tests covering the existing encryption rewrite path and
the externally managed no-rewrite case.
---
 src/knownnetworks.c |   8 ++++
 src/knownnetworks.h |   2 +
 src/network.c       |  67 +++++++++++++++++++-------
 src/storage.c       |  17 ++++++-
 unit/test-storage.c | 114 +++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 188 insertions(+), 20 deletions(-)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index 886f8145..471638e0 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -82,6 +82,11 @@ void __network_config_parse(const struct l_settings *settings,
 
 	config->always_random_addr = b;
 
+	if (!l_settings_get_bool(settings, NET_EXTERNALLY_MANAGED, &b))
+		b = false;
+
+	config->externally_managed = b;
+
 	value = l_settings_get_value(settings, NET_ADDRESS_OVERRIDE);
 	if (value) {
 		if (util_string_to_address(value, new_addr) &&
@@ -690,6 +695,9 @@ static struct l_dbus_message *known_network_property_set_autoconnect(
 	if (network->config.is_autoconnectable == autoconnect)
 		return l_dbus_message_new_method_return(message);
 
+	if (network->config.externally_managed)
+		return dbus_error_not_available(message);
+
 	settings = network->ops->open(network);
 	if (!settings)
 		return dbus_error_failed(message);
diff --git a/src/knownnetworks.h b/src/knownnetworks.h
index a117ded5..ddf72413 100644
--- a/src/knownnetworks.h
+++ b/src/knownnetworks.h
@@ -30,6 +30,7 @@
 #define NET_TRANSITION_DISABLE SETTINGS, "TransitionDisable"
 #define NET_TRANSITION_DISABLE_MODES SETTINGS, "DisabledTransitionModes"
 #define NET_USE_DEFAULT_ECC_GROUP SETTINGS, "UseDefaultEccGroup"
+#define NET_EXTERNALLY_MANAGED SETTINGS, "ExternallyManaged"
 
 enum security;
 struct scan_freq_set;
@@ -82,6 +83,7 @@ struct network_config {
 	bool have_transition_disable : 1;
 	uint8_t transition_disable;
 	enum known_network_ecc_group ecc_group;
+	bool externally_managed : 1;
 };
 
 struct network_info {
diff --git a/src/network.c b/src/network.c
index a5a2375a..e1115be2 100644
--- a/src/network.c
+++ b/src/network.c
@@ -109,6 +109,29 @@ static bool network_settings_load(struct network *network)
 	return network->settings != NULL;
 }
 
+static bool network_settings_are_externally_managed(
+					struct l_settings *settings)
+{
+	bool externally_managed;
+
+	if (!settings)
+		return false;
+
+	if (!l_settings_get_bool(settings, NET_EXTERNALLY_MANAGED,
+					&externally_managed))
+		return false;
+
+	return externally_managed;
+}
+
+static bool network_is_externally_managed(struct network *network)
+{
+	if (network->info)
+		return network->info->config.externally_managed;
+
+	return network_settings_are_externally_managed(network->settings);
+}
+
 static void network_reset_psk(struct network *network)
 {
 	if (network->psk)
@@ -180,25 +203,27 @@ void network_connected(struct network *network)
 	const char *ssid = network_get_ssid(network);
 	int err;
 
-	if (!network->info) {
-		/*
-		 * This is an open network seen for the first time:
-		 *
-		 * Write a settings file to keep track of the
-		 * last connected time.  This will also make iwd autoconnect
-		 * to this network in the future.
-		 */
-		if (!network->settings)
-			network->settings = l_settings_new();
+	if (!network_is_externally_managed(network)) {
+		if (!network->info) {
+			/*
+			 * This is an open network seen for the first time:
+			 *
+			 * Write a settings file to keep track of the
+			 * last connected time.  This will also make iwd
+			 * autoconnect to this network in the future.
+			 */
+			if (!network->settings)
+				network->settings = l_settings_new();
 
-		storage_network_sync(security, ssid, network->settings);
-	} else {
-		err = network_info_touch(network->info);
-		if (err < 0)
-			l_error("Error %i touching network config", err);
+			storage_network_sync(security, ssid, network->settings);
+		} else {
+			err = network_info_touch(network->info);
+			if (err < 0)
+				l_error("Error %i touching network config", err);
 
-		/* Syncs frequencies of already known network*/
-		known_network_frequency_sync(network->info);
+			/* Syncs frequencies of already known network*/
+			known_network_frequency_sync(network->info);
+		}
 	}
 
 	l_queue_foreach_remove(network->secrets,
@@ -758,6 +783,9 @@ void network_sync_settings(struct network *network)
 
 	network->sync_settings = false;
 
+	if (network_is_externally_managed(network))
+		return;
+
 	/*
 	 * Re-open the settings from Disk, in case they were updated
 	 * since we last opened them.
@@ -768,6 +796,11 @@ void network_sync_settings(struct network *network)
 		if (L_WARN_ON(!fs_settings))
 			return;
 
+		if (network_settings_are_externally_managed(fs_settings)) {
+			l_settings_free(fs_settings);
+			return;
+		}
+
 		network_settings_save(network, fs_settings);
 		info->ops->sync(info, fs_settings);
 		l_settings_free(fs_settings);
diff --git a/src/storage.c b/src/storage.c
index 2115a879..7158ce72 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -559,10 +559,22 @@ done:
 	return 0;
 }
 
+static bool storage_settings_are_externally_managed(
+					struct l_settings *settings)
+{
+	bool externally_managed;
+
+	if (!l_settings_get_bool(settings, "Settings", "ExternallyManaged",
+					&externally_managed))
+		return false;
+
+	return externally_managed;
+}
+
 /*
  * Decrypts a network profile (if needed). If profile encryption is enabled
  * and the profile is unencrypted it will be encrypted and written back to
- * the file system automatically.
+ * the file system automatically, unless [Settings].ExternallyManaged is true.
  *
  * 'name' is used for decryption and is used as part of the IV.  Callers
  * should provide a unique identifier here if available.  For example, the
@@ -581,6 +593,9 @@ bool storage_decrypt(struct l_settings *settings, const char *path,
 	if (!needs_encryption)
 		return true;
 
+	if (storage_settings_are_externally_managed(settings))
+		return true;
+
 	/* Profile never encrypted before. Encrypt and write to disk */
 	encrypted = __storage_encrypt(settings, name, &elen);
 	if (!encrypted) {
diff --git a/unit/test-storage.c b/unit/test-storage.c
index 9382efa6..92391bc1 100644
--- a/unit/test-storage.c
+++ b/unit/test-storage.c
@@ -25,6 +25,9 @@
 #endif
 
 #include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
 
 #include <ell/ell.h>
 
@@ -35,6 +38,49 @@ static bool aes_ctr_supported(const void *data)
 	return l_cipher_is_supported(L_CIPHER_AES_CTR);
 }
 
+static char *create_profile_file(const char *data)
+{
+	char path[] = "/tmp/iwd-storage-test-XXXXXX";
+	size_t len = strlen(data);
+	int fd;
+
+	fd = mkstemp(path);
+	assert(fd >= 0);
+
+	assert(write(fd, data, len) == (ssize_t) len);
+	assert(close(fd) == 0);
+
+	return l_strdup(path);
+}
+
+static char *read_profile_file(const char *path)
+{
+	char buffer[4096];
+	ssize_t len;
+
+	len = read_file(buffer, sizeof(buffer) - 1, "%s", path);
+	assert(len >= 0);
+
+	buffer[len] = '\0';
+
+	return l_strdup(buffer);
+}
+
+static struct l_settings *create_unencrypted_psk_settings(
+					bool externally_managed)
+{
+	struct l_settings *settings = l_settings_new();
+
+	if (externally_managed)
+		l_settings_set_bool(settings, "Settings",
+					"ExternallyManaged", true);
+
+	l_settings_set_string(settings, "Security", "Passphrase",
+				"test-password");
+
+	return settings;
+}
+
 static void test_short_encrypted_bytes(const void *data)
 {
 	struct l_settings *settings = l_settings_new();
@@ -54,13 +100,77 @@ static void test_short_encrypted_bytes(const void *data)
 	storage_exit();
 }
 
+static void test_decrypt_encrypts_profile(const void *data)
+{
+	static const char profile[] =
+		"[Security]\n"
+		"Passphrase=test-password\n";
+	struct l_settings *settings;
+	char *path;
+	char *contents;
+
+	storage_init((const uint8_t *)"abc123", 6);
+
+	settings = create_unencrypted_psk_settings(false);
+	path = create_profile_file(profile);
+
+	assert(storage_decrypt(settings, path, "mySSID"));
+
+	contents = read_profile_file(path);
+	assert(strstr(contents, "EncryptedSecurity="));
+	assert(!strstr(contents, "Passphrase=test-password"));
+
+	l_free(contents);
+	unlink(path);
+	l_free(path);
+	l_settings_free(settings);
+
+	storage_exit();
+}
+
+static void test_decrypt_externally_managed_profile(const void *data)
+{
+	static const char profile[] =
+		"[Settings]\n"
+		"ExternallyManaged=true\n"
+		"\n"
+		"[Security]\n"
+		"Passphrase=test-password\n";
+	struct l_settings *settings;
+	char *path;
+	char *contents;
+
+	storage_init((const uint8_t *)"abc123", 6);
+
+	settings = create_unencrypted_psk_settings(true);
+	path = create_profile_file(profile);
+
+	assert(storage_decrypt(settings, path, "mySSID"));
+
+	contents = read_profile_file(path);
+	assert(!strcmp(contents, profile));
+
+	l_free(contents);
+	unlink(path);
+	l_free(path);
+	l_settings_free(settings);
+
+	storage_exit();
+}
+
 int main(int argc, char *argv[])
 {
 	l_test_init(&argc, &argv);
 
 	l_test_add_func_precheck("/storage/profile encryption",
-						test_short_encrypted_bytes,
-						aes_ctr_supported, 0);
+							test_short_encrypted_bytes,
+							aes_ctr_supported, 0);
+	l_test_add_func_precheck("/storage/profile encryption write",
+							test_decrypt_encrypts_profile,
+							aes_ctr_supported, 0);
+	l_test_add_func_precheck("/storage/externally managed profile",
+					test_decrypt_externally_managed_profile,
+					aes_ctr_supported, 0);
 
 	return l_test_run();
 }
-- 
2.54.0

