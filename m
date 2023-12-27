Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B1B4C9F
	for <iwd@lists.linux.dev>; Wed, 27 Dec 2023 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYQLRzf5"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-204e1203a22so74918fac.1
        for <iwd@lists.linux.dev>; Tue, 26 Dec 2023 22:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703657443; x=1704262243; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5Se5BGCQUSsT2Yvzo8uqyBZrNXRRIs2rsNO8xOD9no=;
        b=AYQLRzf54S0iBAt0iLfp8s1WSaUcscfOYIfuLZMMD3vvmJ3J+y+BocNUSbw/cg8b5t
         f3UX9mNFA1HkYEL65gZ8rXra3GrA70LtyNn87vmjkTMVMK5hJN2w488AGkY9Cy611y+E
         5sqyDrrmGXQlqAUxyZ/Xu9W4XU4feYyriTKnxD62DZC6LLAnMcyHR8YMuGSCxXcoo1He
         Xx44ad0LceUIpHLgzpXaom3IRbTp2trq2hNR5tkWY94Hu4oKtKYwg9/EiUai9A2iIg99
         ffvA6sZp5Kz5dRJcY2MAMi0Sib2f5iaXk2QWW/FlS1TET4XqPhGbfaWkAF8aH7wPoWzU
         RC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703657443; x=1704262243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5Se5BGCQUSsT2Yvzo8uqyBZrNXRRIs2rsNO8xOD9no=;
        b=JSKEfCbIHEPo6X3CUahRYkEZfymVSxTz/WfOAcFlne7Un5vtS8yvCpk4WildS6fSyN
         Xr1yJngF/lJw1rcR8XgKLKTCzwfHE6+MxS4bzKjIfplsjOO79WqmR0tzhRnKJ/vvxXNX
         8CFa6vqwF0R8ARAl+165fL3ydjdH+no5MtY5qyWki8iiVNrQFgMcSmx8fWDHBKWYGEnj
         5yHYJqCSjSZD+/MGvOegTyZSufzz+6zQRPT0GODHCdpEYzZXmSuGgDwSMli7jMO0nFIf
         az/rET1/i27poLSICXURXDzQ9sOEQqR95wnHYFzHdlEYIgeglj+4eYYbYWO4mUZvl2jv
         LO7A==
X-Gm-Message-State: AOJu0YzBbm3es44XdQ431e02NnX5LyvZG/33QH74drMTrJoEw/wTWRTc
	Cte1VDTfpNt5910AIvCufLj9nDyXt3Q=
X-Google-Smtp-Source: AGHT+IFA1/yTqpSG776Fhs5KJSY1nDRYJsbZhiSKEguZ04sUGt4W5a2NO8qDs44YZ2SwHVCqVXvw7Q==
X-Received: by 2002:a05:6870:2192:b0:203:dfdc:a80a with SMTP id l18-20020a056870219200b00203dfdca80amr7084754oae.112.1703657443337;
        Tue, 26 Dec 2023 22:10:43 -0800 (PST)
Received: from localhost.localdomain (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.gmail.com with ESMTPSA id vs7-20020a056871a10700b002032bb7895fsm3048841oab.55.2023.12.26.22.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 22:10:43 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/5] RFC: Initial iwtrace utility
Date: Wed, 27 Dec 2023 00:09:50 -0600
Message-ID: <20231227060954.103572-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231227060954.103572-1-denkenz@gmail.com>
References: <20231227060954.103572-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eBPF based tracing, similar to iwmon.  This is meant as an alternative
to the nlmon based netlink tracing and can be used on kernels where
nlmon might not be available.
---
 Makefile.am           |  46 ++++++---
 configure.ac          |  11 +++
 monitor/iwtrace.bpf.c | 194 +++++++++++++++++++++++++++++++++++++
 monitor/iwtrace.c     | 218 ++++++++++++++++++++++++++++++++++++++++++
 monitor/iwtrace.h     |  12 +++
 5 files changed, 466 insertions(+), 15 deletions(-)
 create mode 100644 monitor/iwtrace.bpf.c
 create mode 100644 monitor/iwtrace.c
 create mode 100644 monitor/iwtrace.h

diff --git a/Makefile.am b/Makefile.am
index 5ed6ab37164b..601db513d1e3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -327,23 +327,39 @@ endif
 endif
 
 if MONITOR
+MONITOR_SOURCES = linux/nl80211.h \
+				monitor/nlmon.h monitor/nlmon.c \
+				monitor/pcap.h monitor/pcap.c \
+				monitor/display.h monitor/display.c \
+				src/ie.h src/ie.c \
+				src/wscutil.h src/wscutil.c \
+				src/mpdu.h src/mpdu.c \
+				src/util.h src/util.c \
+				src/crypto.h src/crypto.c \
+				src/watchlist.h src/watchlist.c \
+				src/eapolutil.h src/eapolutil.c \
+				src/nl80211cmd.h src/nl80211cmd.c \
+				src/p2putil.c src/p2putil.h \
+				src/anqputil.h src/anqputil.c \
+				src/band.h src/band.c
 bin_PROGRAMS += monitor/iwmon
 
-monitor_iwmon_SOURCES = monitor/main.c linux/nl80211.h \
-					monitor/nlmon.h monitor/nlmon.c \
-					monitor/pcap.h monitor/pcap.c \
-					monitor/display.h monitor/display.c \
-					src/ie.h src/ie.c \
-					src/wscutil.h src/wscutil.c \
-					src/mpdu.h src/mpdu.c \
-					src/util.h src/util.c \
-					src/crypto.h src/crypto.c \
-					src/watchlist.h src/watchlist.c \
-					src/eapolutil.h src/eapolutil.c \
-					src/nl80211cmd.h src/nl80211cmd.c \
-					src/p2putil.c src/p2putil.h \
-					src/anqputil.h src/anqputil.c \
-					src/band.h src/band.c
+if BPF
+bin_PROGRAMS += monitor/iwtrace
+
+monitor/iwtrace.bpf.o: monitor/iwtrace.bpf.c
+	clang -g -O2 -target bpf -c monitor/iwtrace.bpf.c -o monitor/iwtrace.tmp.bpf.o
+	bpftool gen object monitor/iwtrace.bpf.o monitor/iwtrace.tmp.bpf.o
+
+monitor/iwtrace.skel.h: monitor/iwtrace.bpf.o
+	bpftool gen skeleton monitor/iwtrace.bpf.o > monitor/iwtrace.skel.h
+
+monitor_iwtrace_SOURCES = monitor/iwtrace.c monitor/iwtrace.h \
+				monitor/iwtrace.skel.h $(MONITOR_SOURCES)
+monitor_iwtrace_LDADD = $(ell_ldadd) $(LIBBPF_LIBS)
+endif
+
+monitor_iwmon_SOURCES = monitor/main.c $(MONITOR_SOURCES)
 monitor_iwmon_LDADD = $(ell_ldadd)
 
 if MANUAL_PAGES
diff --git a/configure.ac b/configure.ac
index d84e035c2f5f..bb7bfedcf80f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -200,6 +200,17 @@ AC_ARG_ENABLE([monitor], AS_HELP_STRING([--disable-monitor],
 					[enable_monitor=${enableval}])
 AM_CONDITIONAL(MONITOR, test "${enable_monitor}" != "no")
 
+AC_ARG_ENABLE([bpf], AS_HELP_STRING([--disable-bpf],
+				[don't enable bpf based tracing]),
+					[enable_bpf=${enableval}])
+if (test "${enable_bpf}" != "no"); then
+	PKG_CHECK_MODULES(LIBBPF, libbpf, dummy=yes,
+			AC_MSG_ERROR(libbpf is required))
+	AC_SUBST(LIBBPF_CFLAGS)
+	AC_SUBST(LIBBPF_LIBS)
+fi
+AM_CONDITIONAL(BPF, test "${enable_bpf}" != "no")
+
 AC_ARG_ENABLE([dbus-policy], AS_HELP_STRING([--disable-dbus-policy],
 				[don't install D-Bus system policy files]),
 					[enable_dbus_policy=${enableval}])
diff --git a/monitor/iwtrace.bpf.c b/monitor/iwtrace.bpf.c
new file mode 100644
index 000000000000..251b54fc2a41
--- /dev/null
+++ b/monitor/iwtrace.bpf.c
@@ -0,0 +1,194 @@
+/*
+ * Embedded Linux library
+ * Copyright (C) 2023  Cruise, LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+#include <stdint.h>
+#include <string.h>
+#include <linux/types.h>
+#include <linux/bpf.h>
+#include <linux/netlink.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "iwtrace.h"
+
+char LICENSE[] SEC("license") = "GPL";
+
+struct sock;
+struct netlink_ext_ack;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 256 * 1024);
+} rb SEC(".maps");
+
+struct sock {
+	uint16_t sk_protocol;
+};
+
+struct sk_buff {
+	unsigned int len, data_len;
+	unsigned char *data;
+	struct net_device *dev;
+	union {
+		struct sock		*sk;
+		int			ip_defrag_offset;
+	};
+};
+
+struct capture_256 {
+	struct metadata meta;
+	uint8_t packet[256 - sizeof(struct metadata)];
+} __attribute__ ((packed));
+
+struct capture_1k {
+	struct metadata meta;
+	uint8_t packet[1024 - sizeof(struct metadata)];
+} __attribute__ ((packed));
+
+struct capture_4k {
+	struct metadata meta;
+	uint8_t packet[4096 - sizeof(struct metadata)];
+} __attribute__ ((packed));
+
+struct capture_8k {
+	struct metadata meta;
+	uint8_t packet[8192 - sizeof(struct metadata)];
+} __attribute__ ((packed));
+
+struct capture_16k {
+	struct metadata meta;
+	uint8_t packet[16384];
+} __attribute__ ((packed));
+
+static void metadata_fill(struct metadata *meta, const struct sk_buff *skb)
+{
+	struct sock *sk = __builtin_preserve_access_index(skb->sk);
+
+	meta->timestamp = bpf_ktime_get_boot_ns();
+	meta->len = __builtin_preserve_access_index(skb->len);
+	meta->protocol = __builtin_preserve_access_index(sk->sk_protocol);
+}
+
+static int capture_common(const struct sk_buff *skb)
+{
+	uint16_t len = __builtin_preserve_access_index(skb->len);
+	const void *data = __builtin_preserve_access_index(skb->data);
+
+	/*
+	 * bpf_ringbuf_reserve is currently limited to a known constant
+	 * value, and cannot handle values that are not constant (even if
+	 * bounded).  bpf_ringbuf_output might be suitable, but no metadata
+	 * could be prepended if that is used.  Another alternative is to use
+	 * a perf buffer, but it is per-CPU and might result in packets being
+	 * processed out of order.  We trick the validator by using several
+	 * well known structure sizes (256/1k/4k/8k/16k) in order to save on
+	 * memory space, but the resultant program is larger than it would be
+	 * if dynamic sizing was supported.
+	 */
+	if (len <= 256 - sizeof(struct metadata)) {
+		struct capture_256 *c256 = bpf_ringbuf_reserve(&rb,
+					sizeof(struct capture_256), 0);
+
+		if (!c256)
+			return 0;
+
+		metadata_fill(&c256->meta, skb);
+
+		if (bpf_probe_read_kernel(c256->packet, len, data) < 0)
+			bpf_ringbuf_discard(c256, BPF_RB_NO_WAKEUP);
+		else
+			bpf_ringbuf_submit(c256, 0);
+
+		return 0;
+	}
+
+	if (len <= sizeof(struct capture_1k) - sizeof(struct metadata)) {
+		struct capture_1k *c1k = bpf_ringbuf_reserve(&rb,
+						sizeof(struct capture_1k), 0);
+
+		if (!c1k)
+			return 0;
+
+		metadata_fill(&c1k->meta, skb);
+
+		if (bpf_probe_read_kernel(c1k->packet, len, data) < 0)
+			bpf_ringbuf_discard(c1k, BPF_RB_NO_WAKEUP);
+		else
+			bpf_ringbuf_submit(c1k, 0);
+
+		return 0;
+	}
+
+	if (len <= sizeof(struct capture_4k) - sizeof(struct metadata)) {
+		struct capture_4k *c4k = bpf_ringbuf_reserve(&rb,
+						sizeof(struct capture_4k), 0);
+
+		if (!c4k)
+			return 0;
+
+		metadata_fill(&c4k->meta, skb);
+
+		if (bpf_probe_read_kernel(c4k->packet, len, data) < 0)
+			bpf_ringbuf_discard(c4k, BPF_RB_NO_WAKEUP);
+		else
+			bpf_ringbuf_submit(c4k, 0);
+
+		return 0;
+	}
+
+	if (len <= sizeof(struct capture_8k) - sizeof(struct metadata)) {
+		struct capture_8k *c8k = bpf_ringbuf_reserve(&rb,
+						sizeof(struct capture_8k), 0);
+
+		if (!c8k)
+			return 0;
+
+		metadata_fill(&c8k->meta, skb);
+
+		if (bpf_probe_read_kernel(c8k->packet, len, data) < 0)
+			bpf_ringbuf_discard(c8k, BPF_RB_NO_WAKEUP);
+		else
+			bpf_ringbuf_submit(c8k, 0);
+
+		return 0;
+	}
+
+	/* 16384 is the largest packet size for genl currently */
+	if (len <= 16384) {
+		struct capture_16k *c16k = bpf_ringbuf_reserve(&rb,
+						sizeof(struct capture_16k), 0);
+
+		if (!c16k)
+			return 0;
+
+		metadata_fill(&c16k->meta, skb);
+
+		if (bpf_probe_read_kernel(c16k->packet, len, data) < 0)
+			bpf_ringbuf_discard(c16k, BPF_RB_NO_WAKEUP);
+		else
+			bpf_ringbuf_submit(c16k, 0);
+
+		return 0;
+	}
+
+	return 0;
+}
+
+SEC("fentry/__netlink_sendskb")
+int BPF_PROG(trace___netlink_sendskb, struct sock *sk, struct sk_buff *skb)
+{
+	return capture_common(skb);
+}
+
+SEC("fentry/netlink_rcv_skb")
+int BPF_PROG(trace_netlink_rcv_skb, struct sk_buff *skb,
+					int (*cb)(struct sk_buff *,
+                                                   struct nlmsghdr *,
+                                                   struct netlink_ext_ack *))
+{
+	return capture_common(skb);
+}
diff --git a/monitor/iwtrace.c b/monitor/iwtrace.c
new file mode 100644
index 000000000000..ceff71753463
--- /dev/null
+++ b/monitor/iwtrace.c
@@ -0,0 +1,218 @@
+/*
+ * Copyright (C) 2023  Cruise, LLC
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <argp.h>
+#include <signal.h>
+#include <stdio.h>
+#include <time.h>
+#include <inttypes.h>
+#include <arpa/inet.h>
+#include <sys/resource.h>
+#include <bpf/libbpf.h>
+#include <linux/rtnetlink.h>
+#include "iwtrace.h"
+#include "iwtrace.skel.h"
+#include "monitor/nlmon.h"
+#include "monitor/pcap.h"
+#include "monitor/display.h"
+
+#include <ell/ell.h>
+
+static struct iwtrace_bpf *skel;
+static struct ring_buffer *rb;
+static struct l_io *io;
+static struct l_genl *genl;
+static struct nlmon_config config;
+static const char *writer_path;
+static struct nlmon *nlmon;
+
+#ifndef ARPHRD_NETLINK
+#define ARPHRD_NETLINK	824
+#endif
+
+static int libbpf_print_fn(enum libbpf_print_level level,
+				const char *format, va_list args)
+{
+	return vfprintf(stderr, format, args);
+}
+
+static int handle_packet(void *ctx, void *data, size_t size)
+{
+	struct metadata *meta = data;
+	struct timeval tv;
+
+	data += sizeof(struct metadata);
+
+	tv.tv_sec = meta->timestamp / L_NSEC_PER_SEC;
+	tv.tv_usec = (meta->timestamp % L_NSEC_PER_SEC) / L_NSEC_PER_USEC;
+
+	switch (meta->protocol) {
+	case NETLINK_ROUTE:
+		nlmon_print_rtnl(nlmon, &tv, data, meta->len);
+		break;
+	case NETLINK_GENERIC:
+		nlmon_print_genl(nlmon, &tv, data, meta->len);
+		break;
+	}
+
+	return 0;
+}
+
+static bool ringbuf_receive(struct l_io *io, void *user_data)
+{
+	ring_buffer__poll(rb, 0);
+
+	return true;
+}
+
+static void nl80211_appeared(const struct l_genl_family_info *info,
+					void *user_data)
+{
+	int err;
+
+	err = iwtrace_bpf__attach(skel);
+	if (err) {
+		fprintf(stderr, "Unable to attach eBPF program\n");
+		goto failed;
+	}
+
+	rb = ring_buffer__new(bpf_map__fd(skel->maps.rb),
+					handle_packet, NULL, NULL);
+	if (!rb) {
+		fprintf(stderr, "Failed to create ringbuffer\n");
+		goto failed;
+	}
+
+	nlmon = nlmon_open(l_genl_family_info_get_id(info),
+						writer_path, &config);
+	if (!nlmon)
+		goto failed;
+
+	io = l_io_new(bpf_map__fd(skel->maps.rb));
+	l_io_set_close_on_destroy(io, false);
+	l_io_set_read_handler(io, ringbuf_receive, NULL, NULL);
+
+	return;
+failed:
+	l_main_quit();
+}
+
+static void signal_handler(uint32_t signo, void *user_data)
+{
+	switch (signo) {
+	case SIGINT:
+	case SIGTERM:
+		l_main_quit();
+		break;
+	}
+}
+
+static void usage(void)
+{
+	printf("iwtrace - Wireless monitor using eBPF\n"
+		"Usage:\n");
+	printf("\tiwtrace [options]\n");
+	printf("Options:\n"
+		"\t-w, --write <file>     Write netlink PCAP trace file\n"
+		"\t-n, --nortnl           Don't show RTNL output\n"
+		"\t-y, --nowiphy          Don't show 'New Wiphy' output\n"
+		"\t-s, --noscan           Don't show scan result output\n"
+		"\t-e, --noies            Don't show IEs except SSID\n"
+		"\t-h, --help             Show help options\n");
+}
+
+static const struct option main_options[] = {
+	{ "write",     required_argument, NULL, 'w' },
+	{ "nortnl",    no_argument,       NULL, 'n' },
+	{ "nowiphy",   no_argument,       NULL, 'y' },
+	{ "noscan",    no_argument,       NULL, 's' },
+	{ "noies",     no_argument,       NULL, 'e' },
+	{ "version",   no_argument,       NULL, 'v' },
+	{ "help",      no_argument,       NULL, 'h' },
+	{ }
+};
+
+int main(int argc, char *argv[])
+{
+	int exit_status = EXIT_FAILURE;
+
+	for (;;) {
+		int opt;
+
+		opt = getopt_long(argc, argv, "w:nvhyse",
+						main_options, NULL);
+		if (opt < 0)
+			break;
+
+		switch (opt) {
+		case 'w':
+			writer_path = optarg;
+			break;
+		case 'n':
+			config.nortnl = true;
+			break;
+		case 'y':
+			config.nowiphy = true;
+			break;
+		case 's':
+			config.noscan = true;
+			break;
+		case 'e':
+			config.noies = true;
+			break;
+		case 'v':
+			printf("%s\n", VERSION);
+			return EXIT_SUCCESS;
+		case 'h':
+			usage();
+			return EXIT_SUCCESS;
+		default:
+			return EXIT_FAILURE;
+		}
+	}
+
+	if (argc - optind > 0) {
+		fprintf(stderr, "Invalid command line parameters\n");
+		return EXIT_FAILURE;
+	}
+
+	libbpf_set_print(libbpf_print_fn);
+
+	skel = iwtrace_bpf__open_and_load();
+	if (!skel)
+		return EXIT_FAILURE;
+
+	fprintf(stdout, "Wireless monitor (eBPF) ver %s\n", VERSION);
+
+	if (!l_main_init())
+		goto init_failed;
+
+	genl = l_genl_new();
+	if (!genl) {
+		fprintf(stderr, "Failed to open generic netlink socket\n");
+		goto genl_failed;
+	}
+
+	l_genl_request_family(genl, "nl80211", nl80211_appeared, NULL, NULL);
+	exit_status = l_main_run_with_signal(signal_handler, NULL);
+
+	l_genl_unref(genl);
+	nlmon_close(nlmon);
+	l_io_destroy(io);
+	ring_buffer__free(rb);
+
+genl_failed:
+	l_main_exit();
+init_failed:
+	iwtrace_bpf__destroy(skel);
+
+	return exit_status;
+}
diff --git a/monitor/iwtrace.h b/monitor/iwtrace.h
new file mode 100644
index 000000000000..0df95f2ea989
--- /dev/null
+++ b/monitor/iwtrace.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+/* Copyright (c) 2020 Facebook */
+#ifndef __BOOTSTRAP_H
+#define __BOOTSTRAP_H
+
+struct metadata {
+	uint64_t timestamp;
+	uint16_t len;
+	uint16_t protocol;
+} __attribute__ ((packed));
+
+#endif /* __BOOTSTRAP_H */
-- 
2.43.0

