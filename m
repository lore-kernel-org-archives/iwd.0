Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9411BF81B
	for <iwd@lists.linux.dev>; Mon, 14 Oct 2024 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920974; cv=none; b=VZVENCHDNtxxTa4Yvq34IU1CeQMS+FLLmrGXXQ2oFKxyHUxeLWdJQwvqBqSO2ws4D57W0SV+m3Dt3Q6qja+NeuMiXKlbiQYFDVZ3A8h/7L7EbOKkcKzyDUIuvM0qzGFpLwbn8FlTAs5lpj/WsKAsOsgBuPeJRXrnA8RdZpxuvEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920974; c=relaxed/simple;
	bh=s/go1Rx6f5RehRpc64e+fg0BKBp2DFRndOWWa1MqYa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8NoKRgzhzoDYx4ECDDYu751cnf6KJW8QmxT5dN/HvedzHi6APy/W3Am5wnfwzK+JAy7SxKervmuYZSkiCH0/OaUA4OX1crwJ1j7vZ4Jl2n2Z2CIezwaF1Hkh49y2oE6VumHjkXqoOBuXCsU3vyl4GX0QzCARyHMq+lTnwAaMRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/ELin5+; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/ELin5+"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-28854674160so1869886fac.2
        for <iwd@lists.linux.dev>; Mon, 14 Oct 2024 08:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728920972; x=1729525772; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t55pb4OTjX0fIA8kqYp/3YJvv2Pf3ZSY+UJf9l7NBnk=;
        b=P/ELin5+R6PxiQC4r1u2dxDfK/PE/6ul7Oc8+WlVLGbXbiFDG+jjRz3twlTn4LnkMc
         h7vTiVpv88mh+oQB2gE94ZSFJW3HniXn7wen28F4GqhoyrGuEeEtV6DGJexWZTsRFnQ+
         RN05PYIOzNznf7s7qJ7VvZKlVXga11x2fcUiPEb5uva5sYWglm7ibfpD9R9oSyWBwZEu
         ivgn9TDKdmi6dtRZdl3UMLY6YKtt2mcFxFCv6q9NCEn31cz/UfW3sWWvOhKkUl6Wz2yc
         oVTjBlFP5pwQc371tFAMcP5vYUTwF/EYTJmplhV4Y5h8jpHKvSgpwZ0w0MZAKHkKJApv
         rKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920972; x=1729525772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t55pb4OTjX0fIA8kqYp/3YJvv2Pf3ZSY+UJf9l7NBnk=;
        b=fCkMeWp1Kc8QJwr4IHfcCmdEBqrmDW0djuujx0grOh7z+vwnU4dTHbfRPe40TablyL
         xNfjVettA1oFIiWgAn7vSInwaIIhLzlkf0uCQGpeLpzKcWOsS023UwAJuNg3vCmPQIch
         JYNr7l8DsD+JjZedeGyYNWaaotkDiMKJxi/SWhB2FMHCrFCEfwVccOocdX0/ZmU+9hAs
         zj+LbmzrOvtyrG1l2hkZLUVhzZMFcuZlQCMqjxrdN8azuR/Ga+oFR44x48+gZGXS3raq
         mwWD3zn+qRj43ThX2+zJZpDVjgO+p8Gdtvj2e6Vz8GzfpmBKLJglUJ4WoXXUgxxjPr8N
         kBEQ==
X-Gm-Message-State: AOJu0YzaqFmFqF8yzRROzKjKw/upGUvRf4surWHuVv8s7O9AST5DU5h9
	kRSkW6qn2oGjUUKeVtGCx4CGDf9NUbvBKZHciiwfWNgnRzufc8haZ+cqNw==
X-Google-Smtp-Source: AGHT+IEuUS9oV8js3ktLX7HnR29c/QVWvsFlaQBr4eSfcIJQEwiwgBI+xNSEBxoX7Non2r1IsCuNEg==
X-Received: by 2002:a05:6870:3912:b0:277:f14c:844b with SMTP id 586e51a60fabf-2886e01cb99mr8266246fac.37.1728920971560;
        Mon, 14 Oct 2024 08:49:31 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2889fa14814sm1309314fac.40.2024.10.14.08.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 08:49:31 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] treewide: Comply with doc/coding-style.txt M13
Date: Mon, 14 Oct 2024 10:49:27 -0500
Message-ID: <20241014154929.1318721-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/backtrace.c  | 4 ++--
 src/eap.c        | 4 ++--
 src/frame-xchg.c | 3 +--
 src/netconfig.c  | 2 +-
 src/storage.c    | 4 ++--
 src/udev.c       | 3 +--
 src/wscutil.c    | 2 +-
 unit/test-dpp.c  | 4 ++--
 unit/test-ie.c   | 4 ++--
 unit/test-json.c | 2 +-
 10 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/src/backtrace.c b/src/backtrace.c
index 607097212ade..9f130523d5bc 100644
--- a/src/backtrace.c
+++ b/src/backtrace.c
@@ -54,7 +54,7 @@ void __iwd_backtrace_print(unsigned int offset)
 	int pathlen;
 	pid_t pid;
 
-	if (program_exec == NULL)
+	if (!program_exec)
 		return;
 
 	pathlen = strlen(program_path);
@@ -186,7 +186,7 @@ void __iwd_backtrace_init(void)
 		}
 	}
 
-	if (program_exec == NULL)
+	if (!program_exec)
 		return;
 
 	program_path = getcwd(cwd, sizeof(cwd));
diff --git a/src/eap.c b/src/eap.c
index 4d08f072c32d..9e924577637d 100644
--- a/src/eap.c
+++ b/src/eap.c
@@ -974,7 +974,7 @@ static void __eap_method_enable(struct eap_method_desc *start,
 
 	l_debug("");
 
-	if (start == NULL || stop == NULL)
+	if (!start || !stop)
 		return;
 
 	for (desc = start; desc < stop; desc++) {
@@ -992,7 +992,7 @@ static void __eap_method_disable(struct eap_method_desc *start,
 
 	l_debug("");
 
-	if (start == NULL || stop == NULL)
+	if (!start || !stop)
 		return;
 
 	for (desc = start; desc < stop; desc++) {
diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 158befd0ba83..e9729927d6ab 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -342,8 +342,7 @@ static bool frame_watch_group_io_read(struct l_io *io, void *user_data)
 
 	nlmsg_len = bytes_read;
 
-	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL;
-					cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
 		struct nl_pktinfo pktinfo;
 
 		if (cmsg->cmsg_level != SOL_NETLINK)
diff --git a/src/netconfig.c b/src/netconfig.c
index b31209cf820b..4e8fa0d8cf9f 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -710,7 +710,7 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 	netconfig_commit_init(netconfig);
 
 	debug_level = getenv("IWD_DHCP_DEBUG");
-	if (debug_level != NULL) {
+	if (debug_level) {
 		if (!strcmp("debug", debug_level))
 			dhcp_priority = L_LOG_DEBUG;
 		else if (!strcmp("info", debug_level))
diff --git a/src/storage.c b/src/storage.c
index b756b1726618..c70554df53f2 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -596,7 +596,7 @@ struct l_settings *storage_network_open(enum security type, const char *ssid)
 	struct l_settings *settings;
 	_auto_(l_free) char *path = NULL;
 
-	if (ssid == NULL)
+	if (!ssid)
 		return NULL;
 
 	path = storage_get_network_file_path(type, ssid);
@@ -623,7 +623,7 @@ int storage_network_touch(enum security type, const char *ssid)
 	char *path;
 	int ret;
 
-	if (ssid == NULL)
+	if (!ssid)
 		return -EINVAL;
 
 	path = storage_get_network_file_path(type, ssid);
diff --git a/src/udev.c b/src/udev.c
index 8baf47246be7..859f00bdcdbb 100644
--- a/src/udev.c
+++ b/src/udev.c
@@ -234,8 +234,7 @@ static bool can_read_data(struct l_io *io, void *user_data)
 	if (len < 0)
 		return false;
 
-	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL;
-					cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
 		struct nl_pktinfo *pktinfo;
 
 		if (cmsg->cmsg_level != SOL_NETLINK)
diff --git a/src/wscutil.c b/src/wscutil.c
index 934deeda49b6..570c4d66ea2e 100644
--- a/src/wscutil.c
+++ b/src/wscutil.c
@@ -722,7 +722,7 @@ int wsc_parse_attrs(const unsigned char *pdu, unsigned int len,
 			}
 		}
 
-		if (e2 == NULL) {
+		if (!e2) {
 			if (!ext_iter)
 				break;
 
diff --git a/unit/test-dpp.c b/unit/test-dpp.c
index 0a4fd01f8e42..70e79814c111 100644
--- a/unit/test-dpp.c
+++ b/unit/test-dpp.c
@@ -124,7 +124,7 @@ static bool verify_info(const struct dpp_uri_info *parsed,
 
 	assert(!memcmp(parsed->mac, expected->mac, 6));
 	assert(parsed->version == expected->version);
-	assert(parsed->boot_public != NULL);
+	assert(parsed->boot_public);
 
 	for (i = 0; result->expected_freqs[i]; i++)
 		assert(scan_freq_set_contains(parsed->freqs,
@@ -140,7 +140,7 @@ static void test_uri_parse(const void *data)
 
 	info = dpp_parse_uri(test_info->uri);
 	if (test_info->expect_fail) {
-		assert(info == NULL);
+		assert(!info);
 		return;
 	}
 
diff --git a/unit/test-ie.c b/unit/test-ie.c
index 7ea84c387121..a28cef85de25 100644
--- a/unit/test-ie.c
+++ b/unit/test-ie.c
@@ -660,7 +660,7 @@ static void ie_test_concat_wsc(const void *data)
 	if (len > 0)
 		assert(!memcmp(res, test->expected_data, len));
 	else
-		assert(res == NULL);
+		assert(!res);
 
 	l_free(res);
 }
@@ -681,7 +681,7 @@ static void ie_test_encapsulate_wsc(const void *data)
 	if (extracted_len > 0)
 		assert(!memcmp(extracted, test->expected_data, extracted_len));
 	else
-		assert(extracted == NULL);
+		assert(!extracted);
 
 	packed = ie_tlv_encapsulate_wsc_payload(extracted, extracted_len,
 								&packed_len);
diff --git a/unit/test-json.c b/unit/test-json.c
index 0d48b3d16d64..73e6f8c1b834 100644
--- a/unit/test-json.c
+++ b/unit/test-json.c
@@ -106,7 +106,7 @@ static void test_json(const void *data)
 			JSON_OPTIONAL("objnotfound", JSON_OBJECT, &objnotfound),
 			JSON_UNDEFINED));
 
-	assert(opt_not_found == NULL);
+	assert(!opt_not_found);
 	assert(!json_iter_is_valid(&objnotfound));
 
 	assert(!strcmp(tech, "infra"));
-- 
2.45.2

