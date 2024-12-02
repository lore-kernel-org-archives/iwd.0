Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4202220B217
	for <iwd@lists.linux.dev>; Mon,  2 Dec 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151289; cv=none; b=Sv2hncQbHWEbqNRoVhg0EhJalCKavIsaEjjftcbAKpsnq9wm1iytL7ISXFu3Yj8DANw1/w11xb+aQ20VfnchyL4X1GD2WA2MxcUnY2HEdKy2gtmf+KAkr+ieVX0nMoEwJiTcuoQJiRRpi7aTblBvj5ZKVpAlHD1rYpu4J88aQrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151289; c=relaxed/simple;
	bh=VTrCOc1WSZfqyBtSpeXTozqMuQ2tDAiKFWDQR2WKKNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QK794sxRW+IKih9962tXvCE0DNUKoznecWh98Xbe+UftqqHlGm91Qn1dFg/O2fzC4V7rTPBdXrGUjSXpzklHXTzPunyBgN4hrHKhDuPcyMxU1fKTywN6IAnQh2mgpE99HGAWzDtP7uE0MCO8Uq5dbUWY7/gC7cQIDtGugavMi+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5V/XiUi; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5V/XiUi"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-724e6c53fe2so3194212b3a.3
        for <iwd@lists.linux.dev>; Mon, 02 Dec 2024 06:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733151287; x=1733756087; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX188QrblHZasHUg7g7D9sJnCDY8rhoQ1PHYBCHf8eY=;
        b=g5V/XiUiKjY6QZZLKCukFf0MI6ooCjw4S3iWBfdOdRK3OKtMDQFHyoN9K8eEV/hWXp
         DCzq5XSdwrJT7YzZMcblRO9xMO5JhTdPz/KkghhRz4gW//0QWjve6FvCyF4CkwYIrYEU
         rDgjSATnYREmm653TBSZdyuwVZ/M0vC0r8P49pOEK5fE6VOwIPAXqxSa/WTA1wSrKw+X
         kj2XV5j+i9ODVyk3AM37AZcxX8FWWzrUqMoLsC2mDHgZ42FukG9Es0Ms2H0GZgfDkIbY
         vrkSG519sgtQNzVqllppQUaJdt0A9Fyj9s7LQ6FDcgQfMj4h4/AsxwSVVEnQS+FSR/4J
         gzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733151287; x=1733756087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fX188QrblHZasHUg7g7D9sJnCDY8rhoQ1PHYBCHf8eY=;
        b=fsJqUhL5GD8hDlo8Ob7byEY5EY2zW1FBJCzcmTerXiOXbFhvmgnvWrUw6BKMP8pcwV
         FAZoL+hk2KGe94+XZ4gEKyeP5qt+Jt+oI4oKTC+86E1Rq5o16eHKrZaHSVoC4HcpWUVG
         1Fs1aC4nt6NjSBQQiTPXCQXPze4EiNhRmgi7G8lxjr65SJjP5aMUtg/n6Crv6XbYwLIy
         SfXPigZupogKLvuNfw+vBflcLbB/vFH7GoIysNDkQ8P1OeF5d3XPUUh8+rVfj9AY39D3
         dycYRzGYS5sfZ7F0HjdIsEvmUqK8hczwyW5FGDkniAwjj9IV6DQgI/7JESKiaMN1UT3y
         mUOA==
X-Gm-Message-State: AOJu0YzFVPL0iaF2BMMITcolUYhM2GUmkeI+WueIUf2N+U0iS7bk4CWZ
	Hw0bX/MG56bzW8HxOIZWHKaSjj3M2hs7PvYqDpRQ+YG+oqU9Se+EedLfrw==
X-Gm-Gg: ASbGnctnIov3rkL8Np2+B8LiY4mUU24SgCs34xgYzyQX/tJ/Tav3YeNoNkxR/I5sb6l
	tQxOsvx2OSNoyLzmGiygoEyxdcdOVsRuIOK8XDwOIDuFrhvgZYmNt+7wzJ2F2TO30yNm+Zr58J3
	ycDRaQRyulkyZXqthLAdvIC9kI+PvPv/iyGFrZkuidTmKTpu//1AvF9YEyE7lJmV5UUowCkFdfc
	PL/9mPNPkAnwgqL4/IXOXXYlKRiZRjgrXrd78wNfPREBCBO8wvkhGLMY/ccBHnPamOZ3kK5ZC8E
	QYXghBMg
X-Google-Smtp-Source: AGHT+IEqFnYlvVkaYiBGD99DSLcTbf1hgV4f3lmDhQNt4fWE41nSGJGy9Nn707+Kt0D7OZ7OGHStoA==
X-Received: by 2002:a17:90b:2f08:b0:2ee:dd79:e046 with SMTP id 98e67ed59e1d1-2eedd79eb01mr3414237a91.13.1733151287159;
        Mon, 02 Dec 2024 06:54:47 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee6cec695csm5592474a91.2.2024.12.02.06.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:54:46 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/4] monitor: add support for limiting PCAP size/count
Date: Mon,  2 Dec 2024 06:54:37 -0800
Message-Id: <20241202145438.282998-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202145438.282998-1-prestwoj@gmail.com>
References: <20241202145438.282998-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements support for "rolling captures" by allowing iwmon to
limit the PCAP file size and number of PCAP's that are created.
This is a useful feature when long term monitoring is needed. If
there is some rare behavior requiring iwmon to run for days, months,
or longer the resulting PCAP file would become quite large and fill
up disk space.

When enabled (command line arguments in subsequent patch) the PCAP
file size is checked on each write. If it exceeds the limit a new
PCAP file will be created. Once the number of old PCAP files reaches
the set limit the oldest PCAP will be removed from disk.
---
 monitor/nlmon.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++--
 monitor/nlmon.h |  4 +++
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index b30b1add..76eb2db6 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -43,6 +43,7 @@
 #include <linux/genetlink.h>
 #include <linux/rtnetlink.h>
 #include <linux/filter.h>
+#include <linux/limits.h>
 #include <ell/ell.h>
 
 #ifndef ARPHRD_NETLINK
@@ -94,6 +95,8 @@
 #define BSS_CAPABILITY_APSD		(1<<11)
 #define BSS_CAPABILITY_DSSS_OFDM	(1<<13)
 
+#define BYTES_PER_MB			1000000
+
 struct nlmon *cur_nlmon;
 
 enum msg_type {
@@ -115,6 +118,11 @@ struct nlmon {
 	bool noies;
 	bool read;
 	enum time_format time_format;
+
+	char *file_prefix;
+	unsigned int file_idx;
+	unsigned int max_files;
+	unsigned int max_size;
 };
 
 struct nlmon_req {
@@ -7393,6 +7401,64 @@ static bool nlmon_req_match(const void *a, const void *b)
 	return (req->seq == match->seq && req->pid == match->pid);
 }
 
+/*
+ * Ensures that PCAP names are zero padded when needed. This makes the files
+ * sort correctly.
+ */
+static void next_pcap_name(char *buf, size_t size, const char *prefix,
+				unsigned int idx, unsigned int max)
+{
+	unsigned int ndigits = 1;
+
+	while (max > 9) {
+		max /= 10;
+		ndigits++;
+	}
+
+	snprintf(buf, size, "%s%.*u", prefix, ndigits, idx);
+}
+
+static bool check_pcap(struct nlmon *nlmon, size_t next_size)
+{
+	char path[PATH_MAX];
+
+	if (!nlmon->pcap)
+		return false;
+
+	if (!nlmon->max_size)
+		return true;
+
+	if (pcap_get_size(nlmon->pcap) + next_size <= nlmon->max_size)
+		return true;
+
+	pcap_close(nlmon->pcap);
+
+	/* Exausted the single PCAP file */
+	if (nlmon->max_files < 2) {
+		printf("Reached maximum size of PCAP, exiting\n");
+		nlmon->pcap = NULL;
+		l_main_quit();
+		return false;
+	}
+
+	next_pcap_name(path, sizeof(path), nlmon->file_prefix,
+			++nlmon->file_idx, nlmon->max_files);
+
+	nlmon->pcap = pcap_create(path);
+
+	if (nlmon->max_files > nlmon->file_idx)
+		return true;
+
+	/* Remove oldest PCAP file */
+	next_pcap_name(path, sizeof(path), nlmon->file_prefix,
+		nlmon->file_idx - nlmon->max_files, nlmon->max_files);
+
+	if (remove(path) < 0)
+		printf("Failed to remove old PCAP file %s\n", path);
+
+	return true;
+}
+
 static void store_packet(struct nlmon *nlmon, const struct timeval *tv,
 					uint16_t pkt_type,
 					uint16_t arphrd_type,
@@ -7401,7 +7467,7 @@ static void store_packet(struct nlmon *nlmon, const struct timeval *tv,
 {
 	uint8_t sll_hdr[16], *buf = sll_hdr;
 
-	if (!nlmon->pcap)
+	if (!check_pcap(nlmon, sizeof(sll_hdr) + size))
 		return;
 
 	memset(sll_hdr, 0, sizeof(sll_hdr));
@@ -7527,6 +7593,9 @@ struct nlmon *nlmon_create(uint16_t id, const struct nlmon_config *config)
 	nlmon->noies = config->noies;
 	nlmon->read = config->read_only;
 	nlmon->time_format = config->time_format;
+	nlmon->max_files = config->pcap_file_count;
+	/* Command line expects MB, but use bytes internally */
+	nlmon->max_size = config->pcap_file_size * BYTES_PER_MB;
 
 	return nlmon;
 }
@@ -8554,13 +8623,20 @@ struct nlmon *nlmon_open(uint16_t id, const char *pathname,
 	struct nlmon *nlmon;
 	struct l_io *pae_io;
 	struct pcap *pcap;
+	char path[PATH_MAX];
 
 	pae_io = open_pae();
 	if (!pae_io)
 		return NULL;
 
 	if (pathname) {
-		pcap = pcap_create(pathname);
+		if (config->pcap_file_count > 1)
+			next_pcap_name(path, sizeof(path), pathname,
+					0, config->pcap_file_count);
+		else
+			snprintf(path, sizeof(path), "%s", pathname);
+
+		pcap = pcap_create(path);
 		if (!pcap) {
 			l_io_destroy(pae_io);
 			return NULL;
@@ -8573,6 +8649,7 @@ struct nlmon *nlmon_open(uint16_t id, const char *pathname,
 
 	nlmon->pae_io = pae_io;
 	nlmon->pcap = pcap;
+	nlmon->file_prefix = l_strdup(pathname);
 
 	l_io_set_read_handler(nlmon->pae_io, pae_receive, nlmon, NULL);
 
@@ -8595,5 +8672,7 @@ void nlmon_close(struct nlmon *nlmon)
 	if (nlmon->pcap)
 		pcap_close(nlmon->pcap);
 
+	l_free(nlmon->file_prefix);
+
 	l_free(nlmon);
 }
diff --git a/monitor/nlmon.h b/monitor/nlmon.h
index bbc5d250..fa027021 100644
--- a/monitor/nlmon.h
+++ b/monitor/nlmon.h
@@ -37,6 +37,10 @@ struct nlmon_config {
 	bool noies;
 	bool read_only;
 	enum time_format time_format;
+
+	/* File size in MB */
+	uint32_t pcap_file_size;
+	uint32_t pcap_file_count;
 };
 
 struct nlmon *nlmon_open(uint16_t id, const char *pathname,
-- 
2.34.1

