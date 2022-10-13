Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723D4416
	for <iwd@lists.linux.dev>; Thu, 13 Oct 2022 20:02:43 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id d10so2915302pfh.6
        for <iwd@lists.linux.dev>; Thu, 13 Oct 2022 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BY5UkSsOe1iXnDl+FHOKdWPAj+azv7CylKT+fgfmBMM=;
        b=NdSQmecAMGgdG46dxNJmCQmReRs78DaMVxtIEDcYuVcOmG02A7TimXtzUAVeuNRK2i
         6+lZZDj3fuTi9brH8MV34Uo1wAYxWJKp4dQa+ipZv7dnMmRVEa6ay0V5pSLpHvr8rr+f
         68B6MNwXaoYojaQXK0cAKeVuTlSjV/h8WeKGHE+DF+08yKX568EFU1wdtTQrLoHZQWMX
         7cHjTkkcQI5KVehIXhyfZBiHQvI8lsSVLr9uqnnXUK8FLb3gz+X3tYp1aEWEUeraHBzv
         ZQgUAkJZFwYTFbbf8/B4MYLDLoLrwwfJTlBkE9+mqh9bLh0SmzQrbz/VKwFTf5SUfGkQ
         OfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BY5UkSsOe1iXnDl+FHOKdWPAj+azv7CylKT+fgfmBMM=;
        b=YGdIqxbTz56mpLpN7wVS6aP9Pfy3c5JGySIGALDwjZWHY5q6EoxmY/S/INWn9zTEKD
         JhJq+/lxpcOjsqUVx32TGiKfBJra1fXYsZsdOOmear/ow0QqQnSMKs+LmxDsbjDHaByT
         IT2OvctVg3bUDlGja6fON83IOne2QXlEt1Y38+Hvzs2/DfhM0/ID4+hJK7p0TskqrYNZ
         vw0CxoixeDAJAXu+un9sFpuiEjA3k6NghoMmMCKVsJHVJBb+HaMvq2sFL0Onr7x2mm++
         nIABMlEQSvQppILdORM9mkIJI6mKvsDABnQCggT4awJvtu91mCSbBRx5Lwcy6GF3nWJX
         eY6g==
X-Gm-Message-State: ACrzQf3XsUKisLqPucTHbL5jWm/EKiP+hGFOsF6ou9cyZ4e2llQk1uVv
	1O6BIXcMNRsAmhwCmlKdveNFIQNEOwI=
X-Google-Smtp-Source: AMsMyM5IQQRxRdn8ZZ4ZoJVvwrBrIQlJZs5AuxIrC8M5Y6x3GrGefM2cGf2fYJy7J0OKVxztsoZb7Q==
X-Received: by 2002:aa7:9212:0:b0:562:b5f6:f7d7 with SMTP id 18-20020aa79212000000b00562b5f6f7d7mr1417287pfo.70.1665691362488;
        Thu, 13 Oct 2022 13:02:42 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id w62-20020a623041000000b00565c8634e55sm87625pfw.135.2022.10.13.13.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 13:02:42 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] monitor: use int64_t type for NLMSG_NEXT length
Date: Thu, 13 Oct 2022 13:02:40 -0700
Message-Id: <20221013200240.545800-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c7640f8346 was meant to fix a sign compare warning
in clang because NLMSG_NEXT internally compares the length
with nlmsghdr->nlmsg_len which is a u32. The problem is the
NLMSG_NEXT can underflow an unsigned value, hence why it
expects an int type to be passed in.

To work around this we can instead pass a larger sized
int64_t which the compiler allows since it can upgrade the
unsigned nlmsghdr->nlmsg_len. There is no underflow risk
with an int64_t either because the buffer used is much
smaller than what can fit in an int64_t.

Fixes: c7640f8346 ("monitor: fix integer comparison error (clang)")
---
 monitor/main.c  | 2 +-
 monitor/nlmon.c | 6 +++---
 monitor/nlmon.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

v2:
 * Use int64 instead of int

diff --git a/monitor/main.c b/monitor/main.c
index 9117fba3..f0b16bbf 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -451,7 +451,7 @@ static int analyze_pcap(const char *pathname)
 
 	while (pcap_read(pcap, &tv, buf, snaplen, &len, &real_len)) {
 		struct nlmsghdr *nlmsg;
-		uint32_t aligned_len;
+		int64_t aligned_len;
 		uint16_t arphrd_type;
 		uint16_t proto_type;
 
diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 2222db09..69e86ce3 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -8080,7 +8080,7 @@ static void print_rtnl_msg(const struct timeval *tv,
 void nlmon_print_rtnl(struct nlmon *nlmon, const struct timeval *tv,
 					const void *data, uint32_t size)
 {
-	uint32_t aligned_size = NLMSG_ALIGN(size);
+	int64_t aligned_size = NLMSG_ALIGN(size);
 	const struct nlmsghdr *nlmsg;
 
 	update_time_offset(tv);
@@ -8112,7 +8112,7 @@ void nlmon_print_rtnl(struct nlmon *nlmon, const struct timeval *tv,
 }
 
 void nlmon_print_genl(struct nlmon *nlmon, const struct timeval *tv,
-					const void *data, uint32_t size)
+					const void *data, int64_t size)
 {
 	const struct nlmsghdr *nlmsg;
 
@@ -8144,7 +8144,7 @@ static bool nlmon_receive(struct l_io *io, void *user_data)
 	unsigned char buf[8192];
 	unsigned char control[32];
 	ssize_t bytes_read;
-	uint32_t nlmsg_len;
+	int64_t nlmsg_len;
 	int fd;
 
 	fd = l_io_get_fd(io);
diff --git a/monitor/nlmon.h b/monitor/nlmon.h
index f2f2892a..ab038fdf 100644
--- a/monitor/nlmon.h
+++ b/monitor/nlmon.h
@@ -41,7 +41,7 @@ void nlmon_destroy(struct nlmon *nlmon);
 void nlmon_print_rtnl(struct nlmon *nlmon, const struct timeval *tv,
 					const void *data, uint32_t size);
 void nlmon_print_genl(struct nlmon *nlmon, const struct timeval *tv,
-					const void *data, uint32_t size);
+					const void *data, int64_t size);
 void nlmon_print_pae(struct nlmon *nlmon, const struct timeval *tv,
 					uint8_t type, int index,
 					const void *data, uint32_t size);
-- 
2.34.3

