Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874DD33C5
	for <iwd@lists.linux.dev>; Thu, 13 Oct 2022 16:14:27 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id z20so2216052plb.10
        for <iwd@lists.linux.dev>; Thu, 13 Oct 2022 09:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=omAxKsaiuhTu43Q9IBksvFlEh2avylYpO1p7e8w5D6A=;
        b=VcAqLDUWnGEfm89VobOzwiOrZOCkEOjXYvqQSQJ6nPXhPoIzh2EJzCjUH6UWVBsZHx
         3LCpJJxaAVPOxQH2CgkSsd2KF4fDp+5XDFkliq/3GqKMfWdyqKPzSOMfRMq56XtjPyp1
         GybIXXzWpm+XdafkVsVNRcyxBqiFG7PqD9a23Z3bZBmI0LmIBZD63r8AB/FlfgWMu+cJ
         KQx5ws6/0YAUeUsNJfn0Gcvc7hkfpyNeCRDnIwIY0ZJ7TUgIfw+yzBf3vRtTBjuLaIWW
         3lKc57xINivGFvNZURHNcKxnGNIMx2Kwci0ifbMFJxSW+dtHiN39n0/ewV5Dk+Is4EJD
         7YfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omAxKsaiuhTu43Q9IBksvFlEh2avylYpO1p7e8w5D6A=;
        b=BmXQub5fBOd7r+UYpQbKH+jRP4PvSz2gyi6rFmwORM1wOyULvqEc8umR2uGsKpJa17
         YQzDrkjyX9K2wewLvXc086AJoHvYu7vbltAeoTWL2Cq3r9w+MjMRJEmDksYpJymM3Zlw
         Ihyv4rUgN+797BtU/+fq9SdmNrhssxBWfdq0bfAs6FXnXLvrYLtOw52vXpagVbpcqbeT
         GIhOqLkhjORNllgp5pB+oWpxvCqDbgy7UlwUhZgU0tytVQ8Q+7v7jv/5O7KwbfXcFDsj
         S/RzxtjMVT3aaeQedIt1YIkaVvAWcdHaDwjWY0Jgu7j43+kKaTW7n+IYLANdv4tquMka
         sedg==
X-Gm-Message-State: ACrzQf3fDxc77JBeQ+iIKvfL6a3ByKK898e4PO/5GO5EfmP8XoK2VswF
	o67LGnxiSprJnPtTKsktn8EUpuBX9kM=
X-Google-Smtp-Source: AMsMyM7H1ac7d+934zF39zkh3J1ZzkmnGiNUUkKyzeCwTl/q+ysdhYTm7rISqlOUEIpj8bnTQoTBlg==
X-Received: by 2002:a17:902:d714:b0:17f:5813:1df4 with SMTP id w20-20020a170902d71400b0017f58131df4mr502443ply.148.1665677666681;
        Thu, 13 Oct 2022 09:14:26 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902ce8800b001750792f20asm34043plg.238.2022.10.13.09.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 09:14:26 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] monitor: use int length for NLMSG_NEXT
Date: Thu, 13 Oct 2022 09:14:23 -0700
Message-Id: <20221013161424.505633-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In all uses of NLMSG_{NEXT,OK,ALIGN} the length was unsigned
which is not what these macros expect. According to the docs
the length should be int type, so this was changed for all
uses in monitor.

The was causing random, somewhat rare, crashes in nlmon_receive.
---
 monitor/main.c  | 2 +-
 monitor/nlmon.c | 6 +++---
 monitor/nlmon.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/monitor/main.c b/monitor/main.c
index 9117fba3..78ee0d38 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -451,7 +451,7 @@ static int analyze_pcap(const char *pathname)
 
 	while (pcap_read(pcap, &tv, buf, snaplen, &len, &real_len)) {
 		struct nlmsghdr *nlmsg;
-		uint32_t aligned_len;
+		int aligned_len;
 		uint16_t arphrd_type;
 		uint16_t proto_type;
 
diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 2222db09..573d16df 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -8080,7 +8080,7 @@ static void print_rtnl_msg(const struct timeval *tv,
 void nlmon_print_rtnl(struct nlmon *nlmon, const struct timeval *tv,
 					const void *data, uint32_t size)
 {
-	uint32_t aligned_size = NLMSG_ALIGN(size);
+	int aligned_size = NLMSG_ALIGN(size);
 	const struct nlmsghdr *nlmsg;
 
 	update_time_offset(tv);
@@ -8112,7 +8112,7 @@ void nlmon_print_rtnl(struct nlmon *nlmon, const struct timeval *tv,
 }
 
 void nlmon_print_genl(struct nlmon *nlmon, const struct timeval *tv,
-					const void *data, uint32_t size)
+					const void *data, int size)
 {
 	const struct nlmsghdr *nlmsg;
 
@@ -8144,7 +8144,7 @@ static bool nlmon_receive(struct l_io *io, void *user_data)
 	unsigned char buf[8192];
 	unsigned char control[32];
 	ssize_t bytes_read;
-	uint32_t nlmsg_len;
+	int nlmsg_len;
 	int fd;
 
 	fd = l_io_get_fd(io);
diff --git a/monitor/nlmon.h b/monitor/nlmon.h
index f2f2892a..b8cb81db 100644
--- a/monitor/nlmon.h
+++ b/monitor/nlmon.h
@@ -41,7 +41,7 @@ void nlmon_destroy(struct nlmon *nlmon);
 void nlmon_print_rtnl(struct nlmon *nlmon, const struct timeval *tv,
 					const void *data, uint32_t size);
 void nlmon_print_genl(struct nlmon *nlmon, const struct timeval *tv,
-					const void *data, uint32_t size);
+					const void *data, int size);
 void nlmon_print_pae(struct nlmon *nlmon, const struct timeval *tv,
 					uint8_t type, int index,
 					const void *data, uint32_t size);
-- 
2.34.3

