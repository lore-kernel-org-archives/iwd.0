Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D2720B1FD
	for <iwd@lists.linux.dev>; Mon,  2 Dec 2024 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151286; cv=none; b=OLFItuWZ+c4Hi2AivEmwfqeLpz+LZ35l4xkdcomyOyExrHJH1f3F5pzZs0y+gR51vi/QypZpUU4TxSi50FzK4uOJwo0RScQVwkbysDFE+cFW/RKFELVATYYkQoYFSrUStg4S4V13a7irc9n7eNacgDWfWIUJeSxedDLVkqDwhVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151286; c=relaxed/simple;
	bh=BOOAaps/puV+PtSYg6BqLwyBzXyvgbr9zhUwlGQPdvE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FYQxj/p68PHt995hU8b9Pic7e3NQK7NWY+GIbo+gcMALCpJACMNFuU/O/UJHIjVnu7TWkVktXAEop4qRIFIPejrYmrCaw+NoOz5ImV1Qnh8ALJpaiXH6qHFkEUz70dbmt5RmLxv1efWjRNOd1NOj2W9riHgptfIcoG9tqActIeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKQTiWhp; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKQTiWhp"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fc22a88bcbso2997779a12.2
        for <iwd@lists.linux.dev>; Mon, 02 Dec 2024 06:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733151284; x=1733756084; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Is8hRQW7URqqlM0PBgArwZvRqVe4FOkBlMh6zAFt5a0=;
        b=GKQTiWhpspg4tQ4HaOaM6qXIBntCLgZ1tdU5XN8Do4DoV2ZP6yjzd1CE84tY+GCZ6Q
         +GyeLew6qbO5CXiLfmhjydF8YPTsrzMf5srnxLnKQ7mdyyjzmkR8DbXtfEv56vHBSPHj
         T29iGXDfSKvFZeFnP9R0TzPcvOIxLLSQRMvIhtBZcbli6Jh8VPdf3DYM/M4UWOPq60T9
         cVr4mjfAADZmmeMG7PhZ1V7ibkt9+MpkEIWY4GOrGhfHy+Js3QCM1FqJEVuswj3aEGmi
         gq2U8FWSdCxfNjHRjpBOqMhjaF0Z4iCMgjvSYQh4nlrc82dXwglD406gv7Mq77AHGWMs
         u2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733151284; x=1733756084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Is8hRQW7URqqlM0PBgArwZvRqVe4FOkBlMh6zAFt5a0=;
        b=tFXEzliZqUGwp0RAP/83ICevFmbUDxPIXFy/LAqjZDsBJm64mib9v2ux4QOVE8Pu/P
         pwM3NYI8mGVIWBO7xg8nJnsLT/X3gXaEdJg2S0nyWOCGjYfUtlt0UirZx0F6ZECPN14s
         WYxrtZzdgAuVXjBF2/nNDaChbdYjBjy1vDwNNpSufAvf42wMFf8vOL7Q+T43lanZBU+Y
         howlNfk9Uqn5UliTAf0epPnvDcaujUZdy3IPlBr8R2MEcRCjB62ppeB7ewBA/rUoTRry
         XDJRxvisqzBJcNYvnk2omiEo2sRIOrFWz3rRdX6z/QEZpnUnWhYEFqjr7w/fcvBTyYKb
         XLDA==
X-Gm-Message-State: AOJu0YweDltRYRxeolOThd9W19EVOqZtyA/t+urcC/h9/iscqmed/Dyl
	MNdImGTnyWImZTFFeaGxqstcXU/AxDzra/iA98f7k0uLPgOfb7ofkixTeg==
X-Gm-Gg: ASbGncvSG9kVPLZEqF40HHCYW6IIAbQuEo34iKhnZXyywgYst/IrIictQRcOIaHcprx
	aczNFrZ9DxmSnXLjrYoNtH7j1laM33a9HZ78vR5+8YU0hrB/pRfHm3odIEATLzD4+DxZ4EJ64cp
	+2Lpg9MpmW012ajzNwB9fQS/VVyd6l8z4NAaaO0Xxtm2k1ZKOXkS0nN9r4DlxIzOh4JJJUDRyNq
	REMOM0NOUXqwj1/9bX5yUNLCk/8+mvhAAi4Lb/oLuI9lWry4UQjko9gN2KFDoQ8NlGn6YSK4e20
	99kTN04H
X-Google-Smtp-Source: AGHT+IGfBdAl4jAZZkeAUShIeRCVxW79XgvJI+hr+/Op75OAnJO1ewBlGhxte+aUx63pVuKsK2cJFw==
X-Received: by 2002:a17:90b:28cd:b0:2ee:db8a:29f0 with SMTP id 98e67ed59e1d1-2eedb8a322amr3137464a91.27.1733151283996;
        Mon, 02 Dec 2024 06:54:43 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee6cec695csm5592474a91.2.2024.12.02.06.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:54:43 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] monitor: add --time-format,-t option
Date: Mon,  2 Dec 2024 06:54:35 -0800
Message-Id: <20241202145438.282998-1-prestwoj@gmail.com>
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
 monitor/nlmon.c | 45 +++++++++++++++++++++++++++++++++------
 monitor/nlmon.h |  6 ++++++
 3 files changed, 80 insertions(+), 27 deletions(-)

v2:
 * Fix compiler warning on musl. The switch statement checking the
   time format had no default case which would cause 'n' to be
   uninitialized. Its an impossible condition least with the
   current code base, but it doesn't hurt to add a default to
   future proof.

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
index 60adddc5..b30b1add 100644
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
@@ -225,15 +231,38 @@ static void print_packet(const struct timeval *tv, char ident,
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
+		default:
+			/* Should never happen */
+			printf("Unknown time format");
+			l_main_quit();
+			return;
+		}
+
 		if (n > 0) {
 			ts_pos += n;
 			ts_len += n;
@@ -7497,6 +7526,7 @@ struct nlmon *nlmon_create(uint16_t id, const struct nlmon_config *config)
 	nlmon->noscan = config->noscan;
 	nlmon->noies = config->noies;
 	nlmon->read = config->read_only;
+	nlmon->time_format = config->time_format;
 
 	return nlmon;
 }
@@ -8333,7 +8363,10 @@ void nlmon_print_rtnl(struct nlmon *nlmon, const struct timeval *tv,
 	int64_t aligned_size = NLMSG_ALIGN(size);
 	const struct nlmsghdr *nlmsg;
 
-	update_time_offset(tv);
+	if (nlmon->nortnl)
+		return;
+
+	update_time_offset(tv, nlmon->time_format);
 
 	for (nlmsg = data; NLMSG_OK(nlmsg, aligned_size);
 				nlmsg = NLMSG_NEXT(nlmsg, aligned_size)) {
@@ -8371,7 +8404,7 @@ void nlmon_print_genl(struct nlmon *nlmon, const struct timeval *tv,
 {
 	const struct nlmsghdr *nlmsg;
 
-	update_time_offset(tv);
+	update_time_offset(tv, nlmon->time_format);
 
 	for (nlmsg = data; NLMSG_OK(nlmsg, size);
 				nlmsg = NLMSG_NEXT(nlmsg, size)) {
@@ -8394,7 +8427,7 @@ void nlmon_print_pae(struct nlmon *nlmon, const struct timeval *tv,
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

