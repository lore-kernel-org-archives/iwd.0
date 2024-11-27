Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23499201034
	for <iwd@lists.linux.dev>; Wed, 27 Nov 2024 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728815; cv=none; b=goAh9qxq2w1py1BXq2jXXSzkWVEnHmleVvF2Rzc2XpeG25LXrdJeIKqEaBNy6UNMdGmca7cOt2en7CxgDioiybQMg/Af6bnNRFtkIAFAbMFArwcGbHVP++7wIbHvPSsUoIF7CBh2jdUIaPo9sbOKnIqae3xa5mUqTc3g31Op770=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728815; c=relaxed/simple;
	bh=Ovqf2R4e0euw9R94sLlGgPbixZCGDIO2VzhnMmUnFKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mh+5Zd1uMgnfvcr7d0zJE+a9Jmg3VsGbJ734E0UwZlpdeDi8vngR/ZKiCyW42PKCsxbk1yDtg2ImsmqXBS4bGjhkhe0PaDYkEglScX8TgLF5225iBHDmEYPd1zmXTn790aqN8eSTc5KB6J99c5YHFPtrJs7ko4blvHCPpkYW2VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0E8u5aL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0E8u5aL"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724e14b90cfso27992b3a.2
        for <iwd@lists.linux.dev>; Wed, 27 Nov 2024 09:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732728813; x=1733333613; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IoYzFF7rkglPYpZNKrTTPMUnpGVVBVOcK1cmVknWkCg=;
        b=m0E8u5aLkBcEQHnL53BgRSCFGKGh06/INoio0SEtc70Tkd9P3W7pt5TOmuvEMkaFTd
         aA0SwD0+l61Q9+o5br3VQm/CEqf9SGdV39Q2gAJ0Y9ZftqyDz05n8De8v7cHP/osZjt9
         BGpaBrEM5vgTfF3DWuDm29dm9t/ziI2EEjuXw+qoNDh0eqjZmRXMBlKPRp/zemkpP/Ra
         VHbdqVHuKDoXCYUFhwy1/SLBediwLo4wJWbazAy84MNo6QaGf1EExL+lJX/5PrWl8N7U
         UhANCLVuPUb9YWhvcwX+A322EtvwGJE/kFPy4tM4v7Plk5hdx2n0B/LKElxMeK6Q+XJ2
         XUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732728813; x=1733333613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IoYzFF7rkglPYpZNKrTTPMUnpGVVBVOcK1cmVknWkCg=;
        b=E5dTpZ1KDdv9qmpXLOQ0PtHSMLe13SgJRBmqrpQJhp2cOrF6MMZQgqGuNnXm5i1AAp
         xgR2Y6Ug6/lWfplx9IpcE15xwTHk2jvOGhjgxe54j5xsU/pT4/WSgo9qNm9Rdp05PIPq
         elkAiJJHA0YlFali/JQ3T/tiEI8jOcQIVOrIsLXzkC/Fz8H0fAoeI/POFY9nCVmx7QLC
         WkOg0dvnC0vfaQTvHV4eUmmksSDvPah+Ifj9aedq1TzVtm+WrMF+hxTovlYfHfWdVfQ1
         fBlT2l4vfxXC8zr7q70mLXzWacMBEVzh1+74kFRRkEh+4jbJFVcby0oHMc92IXMz/d2e
         tO7Q==
X-Gm-Message-State: AOJu0YxsZlq8znVqHl84id9T27X37Nes3y3KO79ILQkrwF1rUhoZzIsC
	7VQPLsghXvNPpNNlpAJcsNvjuBgrD/FfXWoR+Wi2uof8phm3IoIrszXn6g==
X-Gm-Gg: ASbGncu+QWswQU0jy4gK79Midp4VSJ1k5dcRh7q7aOOx8I8/Ul0SnufbkB/j7cCV7nD
	fVD+ddRSXRe+tblwAqUpLZ08ewxMCYclkI0RjI5G1rVD9PbmfRU1RJ/sIKCcNAOZ3xeyrgSBzSW
	6G0hOG9bcVpOwGdAhsefPP72c7AWjUl1bkz/iD2MG2o+TrvryUwnRyXDiLGykXSJX0cVXfi3fXG
	KsmzTqKHeZlscvooWIGv0RMxPGG4Z+h28D5E1br82xz8FXK/5t0vlhJWSp4
X-Google-Smtp-Source: AGHT+IF4l6duSph1RAtykPMuW6p8v3JkVgZgriN0ULbmqeSkslqHeo6j2JQCw0iv7Ib3Th1ohZIsHA==
X-Received: by 2002:a17:902:ce89:b0:212:349f:8413 with SMTP id d9443c01a7336-21501095e67mr40886115ad.21.1732728812966;
        Wed, 27 Nov 2024 09:33:32 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba3022sm105487305ad.65.2024.11.27.09.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 09:33:32 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] monitor: add --time-format,-t option
Date: Wed, 27 Nov 2024 09:33:25 -0800
Message-Id: <20241127173328.158354-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
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
 monitor/nlmon.c | 40 +++++++++++++++++++++++++++++------
 monitor/nlmon.h |  6 ++++++
 3 files changed, 75 insertions(+), 27 deletions(-)

diff --git a/monitor/main.c b/monitor/main.c
index fc22c777..fe40e301 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -718,29 +718,32 @@ static void usage(void)
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
 
@@ -754,7 +757,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "r:w:a:i:nvhyse",
+		opt = getopt_long(argc, argv, "r:w:a:i:t:nvhyse",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -784,6 +787,17 @@ int main(int argc, char *argv[])
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
index 60adddc5..4ecbc5f0 100644
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
@@ -113,6 +114,7 @@ struct nlmon {
 	bool noscan;
 	bool noies;
 	bool read;
+	enum time_format time_format;
 };
 
 struct nlmon_req {
@@ -185,11 +187,15 @@ static void nlmon_req_free(void *data)
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
@@ -225,15 +231,33 @@ static void print_packet(const struct timeval *tv, char ident,
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
+
+			n = strftime(ts_str + ts_pos, sizeof(ts_str) - ts_pos,
+					"%b %d %H:%M:%S", tm);
+			break;
+		}
+
 		if (n > 0) {
 			ts_pos += n;
 			ts_len += n;
@@ -7497,6 +7521,7 @@ struct nlmon *nlmon_create(uint16_t id, const struct nlmon_config *config)
 	nlmon->noscan = config->noscan;
 	nlmon->noies = config->noies;
 	nlmon->read = config->read_only;
+	nlmon->time_format = config->time_format;
 
 	return nlmon;
 }
@@ -8333,7 +8358,10 @@ void nlmon_print_rtnl(struct nlmon *nlmon, const struct timeval *tv,
 	int64_t aligned_size = NLMSG_ALIGN(size);
 	const struct nlmsghdr *nlmsg;
 
-	update_time_offset(tv);
+	if (nlmon->nortnl)
+		return;
+
+	update_time_offset(tv, nlmon->time_format);
 
 	for (nlmsg = data; NLMSG_OK(nlmsg, aligned_size);
 				nlmsg = NLMSG_NEXT(nlmsg, aligned_size)) {
@@ -8371,7 +8399,7 @@ void nlmon_print_genl(struct nlmon *nlmon, const struct timeval *tv,
 {
 	const struct nlmsghdr *nlmsg;
 
-	update_time_offset(tv);
+	update_time_offset(tv, nlmon->time_format);
 
 	for (nlmsg = data; NLMSG_OK(nlmsg, size);
 				nlmsg = NLMSG_NEXT(nlmsg, size)) {
@@ -8394,7 +8422,7 @@ void nlmon_print_pae(struct nlmon *nlmon, const struct timeval *tv,
 {
 	char extra_str[16];
 
-	update_time_offset(tv);
+	update_time_offset(tv, nlmon->time_format);
 
 	sprintf(extra_str, "len %u", size);
 
diff --git a/monitor/nlmon.h b/monitor/nlmon.h
index bb1a7c58..bbc5d250 100644
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
 
 struct nlmon *nlmon_open(uint16_t id, const char *pathname,
-- 
2.34.1

