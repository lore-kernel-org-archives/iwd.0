Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6954015A5
	for <iwd@lists.linux.dev>; Thu, 20 Apr 2023 16:32:31 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-63b60366047so1074657b3a.1
        for <iwd@lists.linux.dev>; Thu, 20 Apr 2023 09:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682008350; x=1684600350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nnexiBBadDXJK+yK0+TiMGG3VeLkVZbZrtn0ulirqXM=;
        b=PELUcI/L+MAfIQWJVZUktokGoiogf36X4R6U/CwSaEWrylwHN3i+3CzsM7zYeiXdGH
         wbGH2Cpuio1KBclynKYdgSiba7cTykT/FNx7DzKd1f6+iPfOi+hpEem4p3EupjMfwRwx
         HpD/uJ7Kio0ZUviLu08qZ1C0QYusajvit84AcesEpXbA5GalpNL8QnK8Ch9Tw1rUY5Q9
         7FMa24+uLp/Yw6xgwhx8pq1p+hA8mf6sIyu4dd1ToWXpODfAm9AuvVR8bljQFtPrqnLg
         iAFEy21g0CosExxHcBWo71lPvMyN/ruYkIfMLCMiJDmBSZKEZhTRg0cLD8D8JkKConIP
         hggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682008350; x=1684600350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnexiBBadDXJK+yK0+TiMGG3VeLkVZbZrtn0ulirqXM=;
        b=g8t0+xgS/k8rO7K3dDFxZWGo5aFHNMFD2pt7ZEpzfPg6vfeTj8Cr0ljBnea3dtKmUB
         ybu/PaGE2J1RjTXKSZIhnfMkn/GeEk3Ti48yxBX09hF9cI14Pb4MNvc04XMM3X32UOPO
         UCBC/xBiSjDbJZmC9UzTGN0NGlhWKbhdTqh3krPcB//AKCoHtV6msHENwnF3I4Ul59yU
         L84YwrijxCl/sXq0NeK2beXqn73C+QsEI/q6e2hYYQkTRaA+i6N8Hc3ywCkdcd3IBHm5
         1LpmSudv/XpIRx70IYsSiMshB0t5h+EUm7RKjG/9GkucDCuTZkeGVvEI4lzfB/YZL1li
         UZRA==
X-Gm-Message-State: AAQBX9fIkL5aZ100NNmFfd9hXZew1Re7dUiM08JLzIP61k2UAxuTCpm4
	TH31MhDFiyXMAXMfUfS4BgpO4MxCDx2g9w==
X-Google-Smtp-Source: AKy350aT3brZWW6wtbOm1C0GLI2nKfffNoMO+n2Gbicny56FRciZkhXuSEMXQePInlUyh89oKysGug==
X-Received: by 2002:a05:6a00:1409:b0:626:2ce1:263c with SMTP id l9-20020a056a00140900b006262ce1263cmr2692964pfu.5.1682008350627;
        Thu, 20 Apr 2023 09:32:30 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id c139-20020a621c91000000b005d6999eec90sm1445489pfc.120.2023.04.20.09.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:32:30 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] monitor: add --time-format,-t option
Date: Thu, 20 Apr 2023 09:32:22 -0700
Message-Id: <20230420163222.119771-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For syncing iwmon captures with other logging its useful to
timestamp in some absolute format like UTC. This adds an
option which allows the user to specify what time format to
show. For now support:

delta - (default) The time delta between the first packet
        and the current packet.
utc   - The packet time in UTC
---
 monitor/main.c  | 56 ++++++++++++++++++++++++++++++-------------------
 monitor/nlmon.c | 36 +++++++++++++++++++++++++------
 monitor/nlmon.h |  6 ++++++
 3 files changed, 71 insertions(+), 27 deletions(-)

diff --git a/monitor/main.c b/monitor/main.c
index 0c5f0670..51246681 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -664,29 +664,32 @@ static void usage(void)
 		"Usage:\n");
 	printf("\tiwmon [options]\n");
 	printf("Options:\n"
-		"\t-r, --read <file>      Read netlink PCAP trace file\n"
-		"\t-w, --write <file>     Write netlink PCAP trace file\n"
-		"\t-a, --analyze <file>   Analyze netlink PCAP trace file\n"
-		"\t-i, --interface <dev>  Use specified netlink monitor\n"
-		"\t-n, --nortnl           Don't show RTNL output\n"
-		"\t-y, --nowiphy          Don't show 'New Wiphy' output\n"
-		"\t-s, --noscan           Don't show scan result output\n"
-		"\t-e, --noies            Don't show IEs except SSID\n"
-		"\t-h, --help             Show help options\n");
+		"\t-r, --read <file>          Read netlink PCAP trace file\n"
+		"\t-w, --write <file>         Write netlink PCAP trace file\n"
+		"\t-a, --analyze <file>       Analyze netlink PCAP trace file\n"
+		"\t-i, --interface <dev>      Use specified netlink monitor\n"
+		"\t-n, --nortnl               Don't show RTNL output\n"
+		"\t-y, --nowiphy              Don't show 'New Wiphy' output\n"
+		"\t-s, --noscan               Don't show scan result output\n"
+		"\t-e, --noies                Don't show IEs except SSID\n"
+		"\t-t, --time-format <format> Time format to display. Either\n"
+						"\t\t\t\t   'delta' or 'utc'.\n"
+		"\t-h, --help                 Show help options\n");
 }
 
 static const struct option main_options[] = {
-	{ "read",      required_argument, NULL, 'r' },
-	{ "write",     required_argument, NULL, 'w' },
-	{ "analyze",   required_argument, NULL, 'a' },
-	{ "nl80211",   required_argument, NULL, 'F' },
-	{ "interface", required_argument, NULL, 'i' },
-	{ "nortnl",    no_argument,       NULL, 'n' },
-	{ "nowiphy",   no_argument,       NULL, 'y' },
-	{ "noscan",    no_argument,       NULL, 's' },
-	{ "noies",     no_argument,       NULL, 'e' },
-	{ "version",   no_argument,       NULL, 'v' },
-	{ "help",      no_argument,       NULL, 'h' },
+	{ "read",        required_argument, NULL, 'r' },
+	{ "write",       required_argument, NULL, 'w' },
+	{ "analyze",     required_argument, NULL, 'a' },
+	{ "nl80211",     required_argument, NULL, 'F' },
+	{ "interface",   required_argument, NULL, 'i' },
+	{ "nortnl",      no_argument,       NULL, 'n' },
+	{ "nowiphy",     no_argument,       NULL, 'y' },
+	{ "noscan",      no_argument,       NULL, 's' },
+	{ "noies",       no_argument,       NULL, 'e' },
+	{ "time-format", required_argument, NULL, 't' },
+	{ "version",     no_argument,       NULL, 'v' },
+	{ "help",        no_argument,       NULL, 'h' },
 	{ }
 };
 
@@ -700,7 +703,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "r:w:a:i:nvhyse",
+		opt = getopt_long(argc, argv, "r:w:a:i:t:nvhyse",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -730,6 +733,17 @@ int main(int argc, char *argv[])
 			break;
 		case 'e':
 			config.noies = true;
+			break;
+		case 't':
+			if (!strcmp(optarg, "delta"))
+				config.time_format = TIME_FORMAT_DELTA;
+			else if (!strcmp(optarg, "utc"))
+				config.time_format = TIME_FORMAT_UTC;
+			else {
+				printf("Invalid time format '%s'", optarg);
+				return EXIT_FAILURE;
+			}
+
 			break;
 		case 'v':
 			printf("%s\n", VERSION);
diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index a7ce2412..e20fc0d6 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -29,6 +29,7 @@
 #include <errno.h>
 #include <ctype.h>
 #include <unistd.h>
+#include <time.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <arpa/inet.h>
@@ -105,6 +106,7 @@ struct nlmon {
 	bool noscan;
 	bool noies;
 	bool read;
+	enum time_format time_format;
 };
 
 struct nlmon_req {
@@ -177,11 +179,15 @@ static void nlmon_req_free(void *data)
 }
 
 static time_t time_offset = ((time_t) -1);
+static enum time_format time_format;
 
-static inline void update_time_offset(const struct timeval *tv)
+static inline void update_time_offset(const struct timeval *tv,
+					enum time_format tf)
 {
-	if (tv && time_offset == ((time_t) -1))
+	if (tv && time_offset == ((time_t) -1)) {
 		time_offset = tv->tv_sec;
+		time_format = tf;
+	}
 }
 
 #define print_indent(indent, color1, prefix, title, color2, fmt, args...) \
@@ -217,15 +223,32 @@ static void print_packet(const struct timeval *tv, char ident,
 	int n, ts_len = 0, ts_pos = 0, len = 0, pos = 0;
 
 	if (tv) {
+		struct tm *tm;
+
 		if (use_color()) {
 			n = sprintf(ts_str + ts_pos, "%s", COLOR_TIMESTAMP);
 			if (n > 0)
 				ts_pos += n;
 		}
 
-		n = sprintf(ts_str + ts_pos, " %" PRId64 ".%06" PRId64,
+		switch (time_format) {
+		case TIME_FORMAT_DELTA:
+			n = sprintf(ts_str + ts_pos, " %" PRId64 ".%06" PRId64,
 					(int64_t)tv->tv_sec - time_offset,
 					(int64_t)tv->tv_usec);
+			break;
+		case TIME_FORMAT_UTC:
+			tm = gmtime(&tv->tv_sec);
+			if (!tm) {
+				n = sprintf(ts_str + ts_pos, "%s",
+						"Time error");
+				break;
+			}
+			n = strftime(ts_str + ts_pos, sizeof(ts_str) - ts_pos,
+					"%b %d %H:%M:%S", tm);
+			break;
+		}
+
 		if (n > 0) {
 			ts_pos += n;
 			ts_len += n;
@@ -7285,6 +7308,7 @@ struct nlmon *nlmon_create(uint16_t id, const struct nlmon_config *config)
 	nlmon->noscan = config->noscan;
 	nlmon->noies = config->noies;
 	nlmon->read = config->read_only;
+	nlmon->time_format = config->time_format;
 
 	return nlmon;
 }
@@ -8110,7 +8134,7 @@ void nlmon_print_rtnl(struct nlmon *nlmon, const struct timeval *tv,
 	if (nlmon->nortnl)
 		return;
 
-	update_time_offset(tv);
+	update_time_offset(tv, nlmon->time_format);
 
 	for (nlmsg = data; NLMSG_OK(nlmsg, aligned_size);
 				nlmsg = NLMSG_NEXT(nlmsg, aligned_size)) {
@@ -8143,7 +8167,7 @@ void nlmon_print_genl(struct nlmon *nlmon, const struct timeval *tv,
 {
 	const struct nlmsghdr *nlmsg;
 
-	update_time_offset(tv);
+	update_time_offset(tv, nlmon->time_format);
 
 	for (nlmsg = data; NLMSG_OK(nlmsg, size);
 				nlmsg = NLMSG_NEXT(nlmsg, size)) {
@@ -8326,7 +8350,7 @@ void nlmon_print_pae(struct nlmon *nlmon, const struct timeval *tv,
 {
 	char extra_str[16];
 
-	update_time_offset(tv);
+	update_time_offset(tv, nlmon->time_format);
 
 	sprintf(extra_str, "len %u", size);
 
diff --git a/monitor/nlmon.h b/monitor/nlmon.h
index 96958c25..2197e00f 100644
--- a/monitor/nlmon.h
+++ b/monitor/nlmon.h
@@ -25,12 +25,18 @@
 
 struct nlmon;
 
+enum time_format {
+	TIME_FORMAT_DELTA,
+	TIME_FORMAT_UTC,
+};
+
 struct nlmon_config {
 	bool nortnl;
 	bool nowiphy;
 	bool noscan;
 	bool noies;
 	bool read_only;
+	enum time_format time_format;
 };
 
 struct nlmon *nlmon_open(const char *ifname, uint16_t id, const char *pathname,
-- 
2.25.1

