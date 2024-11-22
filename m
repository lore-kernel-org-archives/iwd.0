Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6171C9DD8
	for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288570; cv=none; b=cTJnllC3Ky87b47wVcVDnXqmsdjf7gNQ8E2l4htHvG6WgLFfJFGaFdjwNkfkLh7k6S2jvndDFtEctWa9OI8xon0uuTBIXLBu/R3kRDxktb/IxI+rMF7Ai89RbgBsuI0WXtg/qB6q76LSXT19GMMMcq5arEAIjaCgHyjQX1X0F7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288570; c=relaxed/simple;
	bh=sset+1TO+8i949hxTEFOSaqIim/tp8WUtormVpZOSLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AxerPiFETuoZEBchQkWn3g2hGe2Fu6/sUsf59DmUQzaXLoHXROwt3znqEDj7Rw8sBGCdR6zjswOM81TYnrPb861Hf6UJjLGaAhEUf3v6ulJQJaZjWEHOslOzNhszO/Fwn5XkHZIza5CanQRu/PxfaNkcMTVeJU8ZZuG95KEsZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNoXx8sJ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNoXx8sJ"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b14554468fso135297685a.1
        for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 07:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732288565; x=1732893365; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIq6dqXW8C1tIT4R4xEZpqWXbljQvRD8NKszaY6Ivpg=;
        b=DNoXx8sJz51t4BguyzNgP/7SHFQ/HKLlZScB8f0zxmxfraV7mdX0X3XMBVKXYx5E/e
         J5aSp1HiOeAVGKgxeR/hofuX6F9mrnyuufvBdnLkPWzP6DgrOz82mDyT85Q+EoPol+63
         8w2cOk60tSKvZmwUfueqccTsYA8IlwM1tGf/QKVZgI1dFklkOHtzwY7r4X/776Hzub3q
         WCCznbfiN55gTDo0BI39M2+FmQIxPaa2/8eBwe5UzDk+P1uhDHk4rDtq4egncvT4j3jK
         y3kFyJdNSMZBt5mbTTeEc27ud9Ry7yDsa1AyUIi5au3oesIme6UMKilca4LswFxpEgLE
         KlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288565; x=1732893365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIq6dqXW8C1tIT4R4xEZpqWXbljQvRD8NKszaY6Ivpg=;
        b=YBpRpSlKwkTzADNLFyjtN1z9zB8RLEvPWSPyhKfBI9BpgM0lvsj1wWFZlEDGc23Kzc
         Qml9iLQAPi9LzwFfOZatJXjyW2P1sPPMD4PWwZFausvOrxW7VjV9ACicd/CpkyvGCmhw
         5yrI0L39l5z7fMMgYF1A0/yLwTB3zg++9bS2R/RdE1yxcC1ijzkP3pNCjwBMkP1306f0
         KUmMLTJMo6lwaaz5U5Yntz5bxP0x2p7ybECHWYUM+uFLuo1rYyoVgjFQjiqkUkRbawPw
         h512HVF3U2rgDuvzyTupikRASZ37+AKf4AG7Rm592jXP61OykQKje9oXPfzI+9wHJvkl
         wmjA==
X-Gm-Message-State: AOJu0YxAz2uTEll+R3+ruUaU8geI/42/h8hhuE1HMRUmKtLFvNqvACCj
	a9QdoExZ3d/ZUq1nW3cYrIBYOqhgNGVyQ1eHRHvRy0sNnVIq4IAH2Pm/NQ==
X-Gm-Gg: ASbGncuNFES1aBWVioLfOJblb3wAFCjH9KGVf65CZ1arqn3vS5PP0PtBLBX9co1TniN
	L4shSnQUuDmpYAGcGciMb3kMEVTmsUjyk9Q0JlfUCIWTsAjLRLgFfxoQOd2rQgs25dfORHsBQm0
	sga0Dk8O/kXzMPc1yCmu4oAXF0q1u5h0vjuYQPqlsyCQuPxF+AuAYokdIaI57DRoL5/QGUMKPS7
	UCNwWdktxkjzE3Ay1Lv5jiC4PQ9w6G/V0OGYLa1mgQpN7jcPv2hkM9tnvE9
X-Google-Smtp-Source: AGHT+IEtgJ6v6EOmSMnU4BCUmHSCQUzULv6OrqwZYrsMpbkV8yaoMRVYm26WiXh19LFmoTika57fwg==
X-Received: by 2002:a05:6214:e87:b0:6d3:556c:1002 with SMTP id 6a1803df08f44-6d45135864emr51842876d6.43.1732288565321;
        Fri, 22 Nov 2024 07:16:05 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a9a720sm10722706d6.50.2024.11.22.07.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:16:04 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 06/15] pmksa: Add skeleton
Date: Fri, 22 Nov 2024 07:15:42 -0800
Message-Id: <20241122151551.286355-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122151551.286355-1-prestwoj@gmail.com>
References: <20241122151551.286355-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Kenzior <denkenz@gmail.com>

---
 Makefile.am |   7 +-
 src/pmksa.c | 224 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/pmksa.h |  46 +++++++++++
 3 files changed, 275 insertions(+), 2 deletions(-)
 create mode 100644 src/pmksa.c
 create mode 100644 src/pmksa.h

diff --git a/Makefile.am b/Makefile.am
index 61d46d7d..7805ed26 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -65,7 +65,8 @@ ell_headers = ell/util.h \
 			ell/cleanup.h \
 			ell/netconfig.h \
 			ell/sysctl.h \
-			ell/notifylist.h
+			ell/notifylist.h \
+			ell/minheap.h
 
 ell_sources = ell/private.h \
 			ell/missing.h \
@@ -147,7 +148,8 @@ ell_sources = ell/private.h \
 			ell/acd.c \
 			ell/netconfig.c \
 			ell/sysctl.c \
-			ell/notifylist.c
+			ell/notifylist.c \
+			ell/minheap.c
 
 ell_shared = ell/useful.h ell/asn1-private.h
 
@@ -269,6 +271,7 @@ src_iwd_SOURCES = src/main.c linux/nl80211.h src/iwd.h \
 					src/json.h src/json.c \
 					src/dpp.c \
 					src/udev.c \
+					src/pmksa.h src/pmksa.c \
 					$(eap_sources) \
 					$(builtin_sources)
 
diff --git a/src/pmksa.c b/src/pmksa.c
new file mode 100644
index 00000000..b2e65d17
--- /dev/null
+++ b/src/pmksa.c
@@ -0,0 +1,224 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2023  Cruise LLC. All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdint.h>
+#include <errno.h>
+
+#include <ell/ell.h>
+#include "ell/useful.h"
+
+#include "src/module.h"
+#include "src/pmksa.h"
+
+static uint64_t dot11RSNAConfigPMKLifetime = 43200ULL * L_USEC_PER_SEC;
+static uint32_t pmksa_cache_capacity = 255;
+
+struct min_heap {
+	struct pmksa **data;
+	uint32_t capacity;
+	uint32_t used;
+};
+
+static struct min_heap cache;
+
+static __always_inline void swap_ptr(void *l, void *r)
+{
+	struct pmksa **lp = l;
+	struct pmksa **rp = r;
+
+	SWAP(*lp, *rp);
+}
+
+static __always_inline
+bool pmksa_compare_expiration(const void *l, const void *r)
+{
+	const struct pmksa * const *lp = l;
+	const struct pmksa * const *rp = r;
+
+	return (*lp)->expiration < (*rp)->expiration;
+}
+
+static struct l_minheap_ops ops = {
+	.elem_size = sizeof(struct pmksa *),
+	.swap = swap_ptr,
+	.less = pmksa_compare_expiration,
+};
+
+static int pmksa_cache_find(const uint8_t spa[static 6],
+					const uint8_t aa[static 6],
+					const uint8_t *ssid, size_t ssid_len,
+					uint32_t akm)
+{
+	unsigned int i;
+
+	for (i = 0; i < cache.used; i++) {
+		struct pmksa *pmksa = cache.data[i];
+
+		if (memcmp(pmksa->spa, spa, sizeof(pmksa->spa)))
+			continue;
+
+		if (memcmp(pmksa->aa, aa, sizeof(pmksa->aa)))
+			continue;
+
+		if (ssid_len != pmksa->ssid_len)
+			continue;
+
+		if (memcmp(pmksa->ssid, ssid, ssid_len))
+			continue;
+
+		if (akm & pmksa->akm)
+			return i;
+	}
+
+	return -ENOENT;
+}
+
+/*
+ * Try to obtain a PMKSA entry from the cache.  If the the entry matching
+ * the parameters is found, it is removed from the cache and returned to the
+ * caller.  The caller is responsible for managing the returned pmksa
+ * structure
+ */
+struct pmksa *pmksa_cache_get(const uint8_t spa[static 6],
+				const uint8_t aa[static 6],
+				const uint8_t *ssid, size_t ssid_len,
+				uint32_t akm)
+{
+	int r = pmksa_cache_find(spa, aa, ssid, ssid_len, akm);
+
+	if (r < 0)
+		return NULL;
+
+	cache.used -= 1;
+	if ((uint32_t) r == cache.used)
+		goto done;
+
+	SWAP(cache.data[r], cache.data[cache.used]);
+	__minheap_sift_down(cache.data, cache.used, r, &ops);
+
+done:
+	return cache.data[cache.used];
+}
+
+/*
+ * Put a PMKSA into the cache.  It will be sorted in soonest-to-expire order.
+ * If the cache is full, then soonest-to-expire entry is removed first.
+ */
+int pmksa_cache_put(struct pmksa *pmksa)
+{
+	if (cache.used == cache.capacity) {
+		l_free(cache.data[0]);
+		cache.data[0] = pmksa;
+		__minheap_sift_down(cache.data, cache.used, 0, &ops);
+		return 0;
+	}
+
+	cache.data[cache.used] = pmksa;
+	__minheap_sift_up(cache.data, cache.used, &ops);
+	cache.used += 1;
+
+	return 0;
+}
+
+/*
+ * Expire all PMKSA entries with expiration time smaller or equal to the cutoff
+ * time.
+ */
+int pmksa_cache_expire(uint64_t cutoff)
+{
+	int i;
+	int used = cache.used;
+	int remaining = 0;
+
+	for (i = 0; i < used; i++) {
+		if (cache.data[i]->expiration <= cutoff) {
+			l_free(cache.data[i]);
+			continue;
+		}
+
+		cache.data[remaining] = cache.data[i];
+		remaining += 1;
+	}
+
+	cache.used = remaining;
+
+	for (i = cache.used >> 1; i >= 0; i--)
+		__minheap_sift_down(cache.data, cache.used, i, &ops);
+
+	return used - remaining;
+}
+
+/*
+ * Flush all PMKSA entries from the cache, regardless of expiration time.
+ */
+int pmksa_cache_flush(void)
+{
+	uint32_t i;
+
+	for (i = 0; i < cache.used; i++)
+		l_free(cache.data[i]);
+
+	memset(cache.data, 0, cache.capacity * sizeof(struct pmksa *));
+	cache.used = 0;
+	return 0;
+}
+
+struct pmksa **__pmksa_cache_get_all(uint32_t *out_n_entries)
+{
+	if (out_n_entries)
+		*out_n_entries = cache.used;
+
+	return cache.data;
+}
+
+uint64_t pmksa_lifetime(void)
+{
+	return dot11RSNAConfigPMKLifetime;
+}
+
+void __pmksa_set_config(const struct l_settings *config)
+{
+	l_settings_get_uint(config, "PMKSA", "Capacity",
+					&pmksa_cache_capacity);
+}
+
+static int pmksa_init(void)
+{
+	cache.capacity = pmksa_cache_capacity;
+	cache.used = 0;
+	cache.data = l_new(struct pmksa *, cache.capacity);
+
+	return 0;
+}
+
+static void pmksa_exit(void)
+{
+	pmksa_cache_flush();
+	l_free(cache.data);
+}
+
+IWD_MODULE(pmksa, pmksa_init, pmksa_exit);
diff --git a/src/pmksa.h b/src/pmksa.h
new file mode 100644
index 00000000..67879309
--- /dev/null
+++ b/src/pmksa.h
@@ -0,0 +1,46 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2023  Cruise, LLC. All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+struct pmksa {
+	uint64_t expiration;
+	uint8_t spa[6];
+	uint8_t aa[6];
+	uint8_t ssid[32];
+	size_t ssid_len;
+	uint32_t akm;
+	uint8_t pmkid[16];
+	uint8_t pmk[64];
+	size_t pmk_len;
+};
+
+struct pmksa **__pmksa_cache_get_all(uint32_t *out_n_entries);
+
+struct pmksa *pmksa_cache_get(const uint8_t spa[static 6],
+				const uint8_t aa[static 6],
+				const uint8_t *ssid, size_t ssid_len,
+				uint32_t akm);
+int pmksa_cache_put(struct pmksa *pmksa);
+int pmksa_cache_expire(uint64_t cutoff);
+int pmksa_cache_flush(void);
+
+uint64_t pmksa_lifetime(void);
+void __pmksa_set_config(const struct l_settings *config);
-- 
2.34.1

