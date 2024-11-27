Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12891201037
	for <iwd@lists.linux.dev>; Wed, 27 Nov 2024 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728818; cv=none; b=KvED4W+ij3jg55nU/GPhPBuZtmRordMXjt03v12hSUBI3p6XzvcZFAW4Tcr2/Jr3URJIoMFRSjzI5zzYVdgmDeJZ9HDIaZCvTeAlvr1MHtlaCPxtSWETqY/zFMfHgXWasI5n9QKfh4UvPPGlz6PgWZMmZlTmqOSuZYiL/IWA7vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728818; c=relaxed/simple;
	bh=sgHJqk2K0PbFz0AYqC5yqWXOqGHbBqv9Cjrl/te2as8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F+CztsNI0zATeeBBngBpfScwKOwfws11RExwuvuxPCHY28MD90YNbU9zSlZubosoCMCJV78BCtDyPxeNUaQmATrzbulgYWBYZM5wbcsAp7LSKPLnfzLvs8KYjvyQwT2pBkKD2rEflTjIdnEkx3dbmZgyowWArRR6y+/VZmZdL04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGsTZin7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGsTZin7"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-212874cd62cso47912525ad.3
        for <iwd@lists.linux.dev>; Wed, 27 Nov 2024 09:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732728816; x=1733333616; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5krJwb9f6bvgnmf4pJNPCk0tRIJeDHDucoiutJFm1I=;
        b=TGsTZin7M7jdBIxBa8dSqOWErHpCsyPqsa93lSnO7Yly/MalInFpDhPW+FZ7YVXupz
         3XqxX/eTQFNKkTMxGVdnaTM3zxXwyh3DyFEy0Co89nrORjKrwPPQ6ykf+5VNY/gCBumk
         G+p3fTANJZIXHlMVkTwGBtvU0lmRZ3NGqvN6Zx9kzfD29pUtgyEjVz3p71FtXXx2FNiv
         Bw5C+vrJQXIabypS1hcYpjLVtCRoJHHv0cmnFXtNr2kYyrgvivXlZNbr57GqMFdDVQ0P
         gmithMys4+tM/cZsanlGi+d+dqqzPDMQZywMKTDBXwkjDehpgShH4YJirUFB3xMeGDli
         B9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732728816; x=1733333616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5krJwb9f6bvgnmf4pJNPCk0tRIJeDHDucoiutJFm1I=;
        b=wvGAAZlixmNW6HlnN8j/ojvY5jRwjbuTXKx2QD+7FFPg0czEslxXrv3QcaxBotzw4U
         F2HXOGti3joaGh9i7Ov/PEDmwy7OgaAsNoXoKbkNap6pn0KPlXqFjnU8vy9cqWoIdxSD
         WCzcgVU3h3X5FN3L58kOgi8zGRwcf+jMEvlC4LlRx++HM6WxSjF6+DIlfndYYNFxbSkq
         WjayZy9O3C9XNx3SVimdNlCztL6EuW6E/l4gfpLR5iZ57i/mzwHM/dlOEi6HNqOWDqtz
         vCnTI5Fj9d+jV8NO/1iwpN3oizEjEfwtupDEVEpUjP+ikHvXTF/b6oXeGy2HELgwJ63D
         lFlw==
X-Gm-Message-State: AOJu0YzwFz3fll2lmOzHcUlDUfsIpcRg9gchkYCPQNDeQWEIzBTbkhfc
	yikQPctdQjW0yzV5DEewCeyhjvZMNXCIN04fwi+ZhMYUphb/HK34BwFdxg==
X-Gm-Gg: ASbGncuoAzFC08tmhMrqmv4mpg/aLkCViRiZTkV5tODK3H6AUx/JQh2mqtZCEiBzdGu
	BYLz7qj7lGzz/S6Utx9+6UKnHu4Duova+wkpq13GkGacpnIy3kSMnjEAhklMNt6Y9mdOpxDkKMi
	UjoAw9lw+PEkwBLm0jNm09HE4/zwxN5kDOtmjYNJwopI0kwLXWpUgQFRDXFZc+hW/+PIIMo0rij
	Dl+NX8t+FDSX3zaon5xcJ0FzVXaNHkb7WIED9+mWqBSSF9O+NAzzVIDD3Mr
X-Google-Smtp-Source: AGHT+IGQbk+Jw7rdBFq8Tilvc+xWTBhvW9PgkYzdP1GhSMtOZYkmEU6yme/ny2Hn+8NFJ2BCzH9S3A==
X-Received: by 2002:a17:902:d4cb:b0:20f:ab4a:db2e with SMTP id d9443c01a7336-2150175cbe9mr59071485ad.29.1732728816039;
        Wed, 27 Nov 2024 09:33:36 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba3022sm105487305ad.65.2024.11.27.09.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 09:33:35 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] monitor: add support for limiting PCAP size/count
Date: Wed, 27 Nov 2024 09:33:27 -0800
Message-Id: <20241127173328.158354-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127173328.158354-1-prestwoj@gmail.com>
References: <20241127173328.158354-1-prestwoj@gmail.com>
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
index 4ecbc5f0..d5f8634e 100644
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
@@ -7388,6 +7396,64 @@ static bool nlmon_req_match(const void *a, const void *b)
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
@@ -7396,7 +7462,7 @@ static void store_packet(struct nlmon *nlmon, const struct timeval *tv,
 {
 	uint8_t sll_hdr[16], *buf = sll_hdr;
 
-	if (!nlmon->pcap)
+	if (!check_pcap(nlmon, sizeof(sll_hdr) + size))
 		return;
 
 	memset(sll_hdr, 0, sizeof(sll_hdr));
@@ -7522,6 +7588,9 @@ struct nlmon *nlmon_create(uint16_t id, const struct nlmon_config *config)
 	nlmon->noies = config->noies;
 	nlmon->read = config->read_only;
 	nlmon->time_format = config->time_format;
+	nlmon->max_files = config->pcap_file_count;
+	/* Command line expects MB, but use bytes internally */
+	nlmon->max_size = config->pcap_file_size * BYTES_PER_MB;
 
 	return nlmon;
 }
@@ -8549,13 +8618,20 @@ struct nlmon *nlmon_open(uint16_t id, const char *pathname,
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
@@ -8568,6 +8644,7 @@ struct nlmon *nlmon_open(uint16_t id, const char *pathname,
 
 	nlmon->pae_io = pae_io;
 	nlmon->pcap = pcap;
+	nlmon->file_prefix = l_strdup(pathname);
 
 	l_io_set_read_handler(nlmon->pae_io, pae_receive, nlmon, NULL);
 
@@ -8590,5 +8667,7 @@ void nlmon_close(struct nlmon *nlmon)
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

