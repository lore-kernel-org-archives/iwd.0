Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E012818B48B
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429933; cv=none; b=jKWwIE0u3FiCsEI+ruNy/xATM0ahuPWQbbabWZWLmZQToy0PlB7lly9w8GEAdF8cRzsL4WnNy+olSyunEFuiysPNdohl343ef6hMqT+p6xIo7dVEgxtmmuaIa+r4CE8IRH5PZpI9N6BW6o3B5XAbx3SaxWx5FvvkmnBAndki4+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429933; c=relaxed/simple;
	bh=XxZkihA7tSt++eOfspFzxqcv1ptoT0fnC9vtH54dsxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CqyuEaaP5G2jdm5PWqgASdVNXQImjXWPT9JbTP6M24K53uJs74tkolGRJC7K9UNubY8ArynjQ0C0EXdU55GiR0ax7BEG53XG9/BD0oCONsbw8nBjKXUUti6BnzDP8eV6f2WZ/CT0gWj8gUyAAJ/900hPgPiE7xb//4R+2FHhr48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kn/Tm65l; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kn/Tm65l"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70943713472so1566056a34.2
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724429931; x=1725034731; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mcM1bahmD4Y3M0YD3wXaAkp7HwsFE+2TZgZYp2qx/mQ=;
        b=Kn/Tm65lcj+mzkge6ap6a1vXzto4MSgnddMCh+m74Al9LGdcWsfRmtZcmzSBlf6d/g
         reqAreuL26Z3ZBsAg9GG6qygpuXICtqnwLNcReGFYzRZv+DI5Mh4/t4vgCi6SSEhw55f
         XR0sFv9yS3tGm2Afc+iqav/M8X7uro9tNTwYkOFcwOyazZ4hszdF3PbuKAfa7qoxFS9k
         ls4zowbhsSUl/qgJjRdB1DEJ8iIIfAeSqEAREnC7pU1EJfayeGBO5P9GGg/lRU+pgieM
         +dinqBdDt0QG0uUmEzFoRoTgaS44LPKFYVHYo+R9kdRu4DVOjs0Jf3nAMhliuZN3bUUA
         ExYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429931; x=1725034731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcM1bahmD4Y3M0YD3wXaAkp7HwsFE+2TZgZYp2qx/mQ=;
        b=uJ+gn0BoGhBJPMKjTeRyBPtBmWen/IIHi2Lcaa986GuJF3q7um8LDFhYRPjFfukOcb
         bF6FkYb0wc30KqYwifsppgXHNSnQGiTXNccxqp/xWhpfZp/94Z0hG+3JtQBlIBipVUq6
         xlV/VlGrn9+lGZHEnvlipOr/nMS1tFFIWbOK/CkJq7HlXLfGzUQho+0N/IQMAm7rBcMJ
         IygVMAcnjk6ux9vg/GYUD1LRhM8RMnyxgwZzxkgT02wBKpUXqDLbCAjxP4GHz3CKTMRw
         8MyYCwY4FqSyMlSFTsIEYmtSDPdifBC3BbhCtj3gUncGm1GEy/BklMr8mFHZA2xtX32A
         Bn3w==
X-Gm-Message-State: AOJu0YzMBkhZta2UQf2GtY+Evh1ij4u5Dd5XedT96fVxoXaHamy0ngzD
	eDAkt1JjOqJawH9bCLbVQiIWkVL8Himkv/vF7JfWCAotPT4XM24RPUZ2pQ==
X-Google-Smtp-Source: AGHT+IED8RqxX0inj/L4pWPMVAqoHsPfW04/OpXb6l7ZsDwS0oEY1qdD3Ke1cYgrsx/x0NQmp5v+Rg==
X-Received: by 2002:a05:6808:6493:b0:3db:25f6:a59c with SMTP id 5614622812f47-3de2a8348e3mr4072680b6e.6.1724429930689;
        Fri, 23 Aug 2024 09:18:50 -0700 (PDT)
Received: from archdev.attlocal.net (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de2256f44asm764507b6e.31.2024.08.23.09.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:18:50 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/5] defs: Add defs.h to hold certain global definitions
Date: Fri, 23 Aug 2024 11:18:29 -0500
Message-ID: <20240823161848.485685-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will help to get rid of magic number use throughout the project.
The definitions should be limited to global magic numbers that are used
throughout the project, for example SSID length, MAC address length,
etc.
---
 Makefile.am         |  3 ++-
 src/ap.c            |  8 ++++----
 src/crypto.c        |  3 ++-
 src/defs.h          | 13 +++++++++++++
 src/dpp-util.h      |  5 ++++-
 src/eap-wsc.c       |  4 ++--
 src/handshake.h     |  2 +-
 src/ie.c            |  2 +-
 src/ie.h            |  3 ++-
 src/knownnetworks.h |  4 +++-
 src/network.c       |  2 +-
 src/p2putil.h       |  3 ++-
 src/rrm.c           |  4 ++--
 src/scan.c          |  2 +-
 src/scan.h          |  4 +++-
 src/station.c       |  4 ++--
 src/storage.c       |  3 ++-
 src/util.c          |  5 +++--
 src/wsc.h           |  2 +-
 src/wscutil.c       |  2 +-
 src/wscutil.h       |  4 +++-
 unit/test-util.c    |  3 ++-
 22 files changed, 57 insertions(+), 28 deletions(-)
 create mode 100644 src/defs.h

diff --git a/Makefile.am b/Makefile.am
index d438a5bad7e4..61d46d7dc1a5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -214,7 +214,8 @@ eap_sources = src/eap.c src/eap.h src/eap-private.h \
 if DAEMON
 libexec_PROGRAMS += src/iwd
 
-src_iwd_SOURCES = src/main.c linux/nl80211.h src/iwd.h src/missing.h \
+src_iwd_SOURCES = src/main.c linux/nl80211.h src/iwd.h \
+					src/missing.h src/defs.h \
 					src/netdev.h src/netdev.c \
 					src/wiphy.h src/wiphy.c \
 					src/device.c \
diff --git a/src/ap.c b/src/ap.c
index b4e7593e5eef..6650f0af6e89 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -67,7 +67,7 @@ struct ap_state {
 	ap_stopped_func_t stopped_func;
 	void *user_data;
 
-	char ssid[33];
+	char ssid[SSID_MAX_SIZE + 1];
 	char passphrase[64];
 	uint8_t psk[32];
 	enum band_freq band;
@@ -153,7 +153,7 @@ struct ap_wsc_pbc_probe_record {
 };
 
 struct ap_network {
-	char ssid[33];
+	char ssid[SSID_MAX_SIZE + 1];
 	int16_t signal;
 	enum security security;
 };
@@ -181,7 +181,7 @@ static int network_signal_compare(const void *a, const void *b, void *user)
 static struct ap_network *ap_network_find(struct ap_state *ap,
 						struct scan_bss *bss)
 {
-	char ssid[33];
+	char ssid[SSID_MAX_SIZE + 1];
 
 	memcpy(ssid, bss->ssid, bss->ssid_len);
 	ssid[bss->ssid_len] = '\0';
@@ -3629,7 +3629,7 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 		return -ENOMSG;
 
 	len = strlen(strval);
-	if (len < 1 || len > 32) {
+	if (len < 1 || len > SSID_MAX_SIZE) {
 		l_error("AP SSID length outside the [1, 32] range");
 		return -EINVAL;
 	}
diff --git a/src/crypto.c b/src/crypto.c
index 15a7cde784f0..35941a2e3c3c 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -35,6 +35,7 @@
 
 #include "ell/useful.h"
 #include "src/missing.h"
+#include "src/defs.h"
 #include "src/crypto.h"
 
 #define ARC4_MIN_KEY_SIZE	1
@@ -567,7 +568,7 @@ int crypto_psk_from_passphrase(const char *passphrase,
 	if (!crypto_passphrase_is_valid(passphrase))
 		return -ERANGE;
 
-	if (ssid_len == 0 || ssid_len > 32)
+	if (ssid_len == 0 || ssid_len > SSID_MAX_SIZE)
 		return -ERANGE;
 
 	result = l_cert_pkcs5_pbkdf2(L_CHECKSUM_SHA1, passphrase,
diff --git a/src/defs.h b/src/defs.h
new file mode 100644
index 000000000000..b83763b85a10
--- /dev/null
+++ b/src/defs.h
@@ -0,0 +1,13 @@
+/*
+ *  Wireless daemon for Linux
+ *  Copyright (C) 2024  Cruise, LLC
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef __DEFS_H__
+#define __DEFS_H__
+
+#define SSID_MAX_SIZE 32
+
+#endif
diff --git a/src/dpp-util.h b/src/dpp-util.h
index dc8a894b2bb4..86ef36f9bb46 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -19,6 +19,9 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
  */
+
+#include "src/defs.h"
+
 struct l_ecc_point;
 struct l_ecc_scalar;
 enum ie_rsn_akm_suite;
@@ -112,7 +115,7 @@ enum dpp_attribute_type {
 };
 
 struct dpp_configuration {
-	char ssid[33];
+	char ssid[SSID_MAX_SIZE + 1];
 	size_t ssid_len;
 	uint32_t akm_suites;
 	char *passphrase;
diff --git a/src/eap-wsc.c b/src/eap-wsc.c
index 789a20f032b9..4e940bf8b668 100644
--- a/src/eap-wsc.c
+++ b/src/eap-wsc.c
@@ -2067,7 +2067,7 @@ static bool eap_wsc_r_load_settings(struct eap_state *eap,
 
 	str = l_settings_get_string(settings, "WSC", "WPA2-SSID");
 	if (str) {
-		if (strlen(str) > 32)
+		if (strlen(str) > SSID_MAX_SIZE)
 			goto bad_string;
 
 		wsc->m2->auth_type_flags |=
@@ -2113,7 +2113,7 @@ static bool eap_wsc_r_load_settings(struct eap_state *eap,
 
 	str = l_settings_get_string(settings, "WSC", "Open-SSID");
 	if (str) {
-		if (strlen(str) > 32)
+		if (strlen(str) > SSID_MAX_SIZE)
 			goto bad_string;
 
 		wsc->m2->auth_type_flags |= WSC_AUTHENTICATION_TYPE_OPEN;
diff --git a/src/handshake.h b/src/handshake.h
index 8a356e6b71f2..d1116472b177 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -141,7 +141,7 @@ struct handshake_state {
 	bool supplicant_ocvc : 1;
 	bool ext_key_id_capable : 1;
 	bool force_default_ecc_group : 1;
-	uint8_t ssid[32];
+	uint8_t ssid[SSID_MAX_SIZE];
 	size_t ssid_len;
 	char *passphrase;
 	char *password_identifier;
diff --git a/src/ie.c b/src/ie.c
index b180291a686f..c8bb70b96ade 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -2642,7 +2642,7 @@ int ie_parse_owe_transition(const void *data, size_t len,
 		return -ENOMSG;
 
 	slen = l_get_u8(ie + 12);
-	if (slen > 32)
+	if (slen > SSID_MAX_SIZE)
 		return -ENOMSG;
 
 	/*
diff --git a/src/ie.h b/src/ie.h
index 82945de676a9..4498785a8b6c 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -23,6 +23,7 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <unistd.h>
+#include "src/defs.h"
 
 /*
  * Information elements, IEEE Std 802.11-2012 ch. 8.4.2 and
@@ -565,7 +566,7 @@ struct ie_fils_ip_addr_response_info {
 
 struct ie_owe_transition_info {
 	uint8_t bssid[6];
-	uint8_t ssid[32];
+	uint8_t ssid[SSID_MAX_SIZE];
 	size_t ssid_len;
 	uint8_t oper_class;
 	uint8_t channel;
diff --git a/src/knownnetworks.h b/src/knownnetworks.h
index c81bd9aaaf77..a117ded55d86 100644
--- a/src/knownnetworks.h
+++ b/src/knownnetworks.h
@@ -20,6 +20,8 @@
  *
  */
 
+#include "src/defs.h"
+
 #define SETTINGS "Settings"
 #define NET_HIDDEN SETTINGS, "Hidden"
 #define NET_AUTOCONNECT SETTINGS, "AutoConnect"
@@ -84,7 +86,7 @@ struct network_config {
 
 struct network_info {
 	const struct network_info_ops *ops;
-	char ssid[33];
+	char ssid[SSID_MAX_SIZE + 1];
 	enum security type;
 	struct l_queue *known_frequencies;
 	int seen_count;			/* Ref count for network.info */
diff --git a/src/network.c b/src/network.c
index 300e8090df29..20d9a3ddb84f 100644
--- a/src/network.c
+++ b/src/network.c
@@ -63,7 +63,7 @@ static uint32_t known_networks_watch;
 static uint32_t event_watch;
 
 struct network {
-	char ssid[33];
+	char ssid[SSID_MAX_SIZE + 1];
 	enum security security;
 	char *object_path;
 	struct station *station;
diff --git a/src/p2putil.h b/src/p2putil.h
index 3a76414b04d4..7ca9fb2ec281 100644
--- a/src/p2putil.h
+++ b/src/p2putil.h
@@ -22,6 +22,7 @@
 
 #include <stdint.h>
 
+#include "src/defs.h"
 #include "src/wscutil.h"
 
 struct l_queue;
@@ -285,7 +286,7 @@ struct p2p_client_info_descriptor {
 
 struct p2p_group_id_attr {
 	uint8_t device_addr[6];
-	char ssid[33];
+	char ssid[SSID_MAX_SIZE + 1];
 };
 
 struct p2p_interface_attr {
diff --git a/src/rrm.c b/src/rrm.c
index 7054db36aed1..a11a653287d7 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -108,8 +108,8 @@ struct rrm_beacon_req_info {
 	uint8_t oper_class;
 	uint8_t channel;	/* The single channel provided in request */
 	uint16_t duration;
-	uint8_t bssid[6];	/* Request filtered by BSSID */
-	char ssid[33];		/* Request filtered by SSID */
+	uint8_t bssid[6];		/* Request filtered by BSSID */
+	char ssid[SSID_MAX_SIZE + 1];	/* Request filtered by SSID */
 	bool has_ssid;
 	uint32_t scan_id;
 	uint64_t scan_start_time;
diff --git a/src/scan.c b/src/scan.c
index c46ef8a00c2d..9de235a82f0f 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1325,7 +1325,7 @@ static bool scan_parse_bss_information_elements(struct scan_bss *bss,
 
 		switch (tag) {
 		case IE_TYPE_SSID:
-			if (iter.len > 32)
+			if (iter.len > SSID_MAX_SIZE)
 				return false;
 
 			memcpy(bss->ssid, iter.data, iter.len);
diff --git a/src/scan.h b/src/scan.h
index 06753b8268c4..50adca7cdc73 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -20,6 +20,8 @@
  *
  */
 
+#include "src/defs.h"
+
 struct scan_freq_set;
 struct ie_rsn_info;
 struct ie_owe_transition_info;
@@ -62,7 +64,7 @@ struct scan_bss {
 	};
 	struct ie_owe_transition_info *owe_trans;
 	uint8_t mde[3];
-	uint8_t ssid[32];
+	uint8_t ssid[SSID_MAX_SIZE];
 	uint8_t ssid_len;
 	uint8_t utilization;
 	uint8_t cc[3];
diff --git a/src/station.c b/src/station.c
index 333b0fa12691..30a1232ab570 100644
--- a/src/station.c
+++ b/src/station.c
@@ -498,7 +498,7 @@ static struct network *station_add_seen_bss(struct station *station,
 	struct network *network;
 	enum security security;
 	const char *path;
-	char ssid[33];
+	char ssid[SSID_MAX_SIZE + 1];
 
 	station_print_scan_bss(bss);
 
@@ -3916,7 +3916,7 @@ static struct l_dbus_message *station_dbus_connect_hidden_network(
 	if (!l_dbus_message_get_arguments(message, "s", &ssid))
 		return dbus_error_invalid_args(message);
 
-	if (strlen(ssid) > 32)
+	if (strlen(ssid) > SSID_MAX_SIZE)
 		return dbus_error_invalid_args(message);
 
 	if (known_networks_find(ssid, SECURITY_PSK) ||
diff --git a/src/storage.c b/src/storage.c
index 4200030ca4f9..b756b1726618 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -45,6 +45,7 @@
 #include "ell/useful.h"
 
 #include "src/missing.h"
+#include "src/defs.h"
 #include "src/common.h"
 #include "src/storage.h"
 #include "src/crypto.h"
@@ -315,7 +316,7 @@ const char *storage_network_ssid_from_path(const char *path,
 		return NULL;
 
 	if (filename[0] != '=') {
-		if (end == filename || end - filename > 32)
+		if (end == filename || end - filename > SSID_MAX_SIZE)
 			return NULL;
 
 		for (c = filename; c < end; c++)
diff --git a/src/util.c b/src/util.c
index 69019dc8f712..5ce764ae6402 100644
--- a/src/util.c
+++ b/src/util.c
@@ -34,6 +34,7 @@
 #include <ell/ell.h>
 
 #include "ell/useful.h"
+#include "src/defs.h"
 #include "src/util.h"
 #include "src/band.h"
 
@@ -45,7 +46,7 @@ const char *util_ssid_to_utf8(size_t len, const uint8_t *ssid)
 
 	memset(buf, 0, sizeof(buf));
 
-	if (len > 32)
+	if (len > SSID_MAX_SIZE)
 		goto no_ssid;
 
 	while (i < len && !ssid[i])
@@ -84,7 +85,7 @@ no_ssid:
 
 bool util_ssid_is_utf8(size_t len, const uint8_t *ssid)
 {
-	if (len > 32)
+	if (len > SSID_MAX_SIZE)
 		return false;
 
 	return l_utf8_validate((const char *)ssid, len, NULL);
diff --git a/src/wsc.h b/src/wsc.h
index 35ce91998665..bb6ff648522a 100644
--- a/src/wsc.h
+++ b/src/wsc.h
@@ -21,7 +21,7 @@
  */
 
 struct wsc_credentials_info {
-	char ssid[33];
+	char ssid[SSID_MAX_SIZE + 1];
 	enum security security;
 	union {
 		uint8_t psk[32];
diff --git a/src/wscutil.c b/src/wscutil.c
index 12e2125a73b9..934deeda49b6 100644
--- a/src/wscutil.c
+++ b/src/wscutil.c
@@ -500,7 +500,7 @@ static bool extract_ssid(struct wsc_attr_iter *iter, void *data)
 	unsigned int len;
 
 	len = wsc_attr_iter_get_length(iter);
-	if (len > 32)
+	if (len > SSID_MAX_SIZE)
 		return false;
 
 	ssid->iov_len = len;
diff --git a/src/wscutil.h b/src/wscutil.h
index 1d603d8ff644..91e74a5a2d2c 100644
--- a/src/wscutil.h
+++ b/src/wscutil.h
@@ -20,6 +20,8 @@
  *
  */
 
+#include "src/defs.h"
+
 struct iovec;
 
 /* Wi-Fi Simple Configuration Technical Specification v2.0.5, Section 12 */
@@ -330,7 +332,7 @@ static inline unsigned int wsc_attr_iter_get_pos(struct wsc_attr_iter *iter)
 }
 
 struct wsc_credential {
-	uint8_t ssid[32];
+	uint8_t ssid[SSID_MAX_SIZE];
 	uint8_t ssid_len;
 	uint16_t auth_type;
 	uint16_t encryption_type;
diff --git a/unit/test-util.c b/unit/test-util.c
index 3c143cd7958a..0bfd1587c008 100644
--- a/unit/test-util.c
+++ b/unit/test-util.c
@@ -31,11 +31,12 @@
 #include <arpa/inet.h>
 #include <ell/ell.h>
 
+#include "src/defs.h"
 #include "src/util.h"
 
 struct ssid_test_data {
 	size_t len;
-	uint8_t ssid[32];
+	uint8_t ssid[SSID_MAX_SIZE];
 	const char *string;
 	bool result;
 };
-- 
2.45.2

