Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0817E46BF
	for <iwd@lists.linux.dev>; Wed, 27 Dec 2023 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJalIaFp"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-20389f2780fso4210934fac.2
        for <iwd@lists.linux.dev>; Tue, 26 Dec 2023 22:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703657443; x=1704262243; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG9LkBoL9ME55EULuhkRZC+KHE7gMJYNaTaCrK3SS+g=;
        b=EJalIaFpEgZp/qFM7jWzhTSGiPKovQXTIUm1H5o5wWpSPu2D8ld/zV48EurcRwM9Fp
         ry4QURFePfjWIW75bQJ5uci63xKu8fDgLU2qIKMm8DHl+pVzUZKO5zx1N2jE5/EMfSnn
         xtFF/ywDWc6rHWviCUvzWbWH1XpszoUhSNQTKewTHdUrotDPZbNjGoW+RDpaJHka9gsY
         JIs30g98+KruP5+QKDn3k3eBiPdNA/8nnCwhIpDe+MQQX3LvEJepAp9tMw0B+/VcWRiE
         Wvlw1/bN9LZYn7MEhK8t/WzVjRHIu/witxPP1baM/fPR2aiLmeZyAwGW3hbm1GWOHwRd
         q4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703657443; x=1704262243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG9LkBoL9ME55EULuhkRZC+KHE7gMJYNaTaCrK3SS+g=;
        b=L/jVon7hdqY/bj7Zbsl3OzKqqW6plRLFsDq16jfTxtpOAzvhG4enUHe3uBXfF7vMCw
         VrkAO2kFaaPsmhlmwQSnAkEcRkjTKlNdAWngdLDmq457q6KXRPNbgqKmmbA5SuA1foTI
         CXiXlqtych1fon++8heamiOYj5ptR+bA49v6x0QVvS4iGD3U6xuryyWVTod9LnOd9r2b
         txb/X8b5ps0UDWFhGOU80CPF3wUVGu9Fqi0L1gQr3E4jElLOWS0o/mBoEEknPwXDjoyE
         Qg40k7+BWUsE6QAm/NLZCQ07bfyXj+OteVP9Ll2UegzfTbPs93ezc9UqduQxCMbJudLo
         +l+w==
X-Gm-Message-State: AOJu0Ywc5xCJ1y8EuG5Iu/bnn7v/f+mrsgnktMPSwW7qzbFonTHYBOng
	N0yH1bGQG5mMRWMnbk7yNuj5HP+hilI=
X-Google-Smtp-Source: AGHT+IEdUGH53XpSTpwp4NVy/A6jTPzybcwoBYzi+gLXcUWSwEy80v3gmMX+C8CwylDv9d/IOMyZrQ==
X-Received: by 2002:a05:6870:910c:b0:203:adc9:ca3d with SMTP id o12-20020a056870910c00b00203adc9ca3dmr10986404oae.98.1703657442759;
        Tue, 26 Dec 2023 22:10:42 -0800 (PST)
Received: from localhost.localdomain (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.gmail.com with ESMTPSA id vs7-20020a056871a10700b002032bb7895fsm3048841oab.55.2023.12.26.22.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 22:10:42 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/5] monitor: Move iwmon reading logic into main.c
Date: Wed, 27 Dec 2023 00:09:49 -0600
Message-ID: <20231227060954.103572-4-denkenz@gmail.com>
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

To support multiple nlmon sources, move the logic that reads from iwmon
device into main.c instead of nlmon.  nlmon.c now becomes agnostic of
how the packets are actually obtained.  Packets are fed in via
high-level APIs such as nlmon_print_rtnl, nlmon_print_genl,
nlmon_print_pae.
---
 monitor/main.c  | 175 ++++++++++++++++++++++++++++++++++++++++++++++--
 monitor/nlmon.c | 165 +--------------------------------------------
 monitor/nlmon.h |   2 +-
 3 files changed, 174 insertions(+), 168 deletions(-)

diff --git a/monitor/main.c b/monitor/main.c
index 0c5f0670c706..e9384e1b884f 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -32,10 +32,13 @@
 #include <string.h>
 #include <getopt.h>
 #include <signal.h>
+#include <arpa/inet.h>
 #include <sys/socket.h>
 #include <linux/genetlink.h>
 #include <linux/rtnetlink.h>
 #include <linux/if_arp.h>
+#include <linux/filter.h>
+#include <sys/ioctl.h>
 #include <ell/ell.h>
 
 #ifndef ARPHRD_NETLINK
@@ -68,11 +71,160 @@ static struct nlmon_config config;
 #define NLMON_TYPE "nlmon"
 #define NLMON_LEN  5
 
+static bool nlmon_receive(struct l_io *io, void *user_data)
+{
+	struct nlmon *nlmon = user_data;
+	struct msghdr msg;
+	struct sockaddr_ll sll;
+	struct iovec iov;
+	struct cmsghdr *cmsg;
+	struct timeval copy_tv;
+	const struct timeval *tv = NULL;
+	uint16_t proto_type;
+	unsigned char buf[8192];
+	unsigned char control[32];
+	ssize_t bytes_read;
+	int fd;
+
+	fd = l_io_get_fd(io);
+	if (fd < 0)
+		return false;
+
+	memset(&sll, 0, sizeof(sll));
+
+	memset(&iov, 0, sizeof(iov));
+	iov.iov_base = buf;
+	iov.iov_len = sizeof(buf);
+
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_name = &sll;
+	msg.msg_namelen = sizeof(sll);
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = control;
+	msg.msg_controllen = sizeof(control);
+
+	bytes_read = recvmsg(fd, &msg, 0);
+	if (bytes_read < 0) {
+		if (errno != EAGAIN && errno != EINTR)
+			return false;
+
+		return true;
+	}
+
+	if (sll.sll_hatype != ARPHRD_NETLINK)
+		return true;
+
+	proto_type = ntohs(sll.sll_protocol);
+
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg;
+				cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		if (cmsg->cmsg_level == SOL_SOCKET &&
+					cmsg->cmsg_type == SCM_TIMESTAMP) {
+			memcpy(&copy_tv, CMSG_DATA(cmsg), sizeof(copy_tv));
+			tv = &copy_tv;
+		}
+	}
+
+	switch (proto_type) {
+	case NETLINK_ROUTE:
+		nlmon_print_rtnl(nlmon, tv, iov.iov_base, bytes_read);
+		break;
+	case NETLINK_GENERIC:
+		nlmon_print_genl(nlmon, tv, iov.iov_base, bytes_read);
+		break;
+	}
+
+	return true;
+}
+
+/*
+ * BPF filter to match skb->dev->type == 824 (ARPHRD_NETLINK) and
+ * either match skb->protocol == 0x0000 (NETLINK_ROUTE) or match
+ * skb->protocol == 0x0010 (NETLINK_GENERIC).
+ */
+static struct sock_filter mon_filter[] = {
+	{ 0x28,  0,  0, 0xfffff01c },	/* ldh #hatype		*/
+	{ 0x15,  0,  3, 0x00000338 },	/* jne #824, drop	*/
+	{ 0x28,  0,  0, 0xfffff000 },	/* ldh #proto		*/
+	{ 0x15,  2,  0, 0000000000 },	/* jeq #0x0000, pass	*/
+	{ 0x15,  1,  0, 0x00000010 },	/* jeq #0x0010, pass	*/
+	{ 0x06,  0,  0, 0000000000 },	/* drop: ret #0		*/
+	{ 0x06,  0,  0, 0xffffffff },	/* pass: ret #-1	*/
+};
+
+static const struct sock_fprog mon_fprog = { .len = 7, .filter = mon_filter };
+
+static struct l_io *open_packet(const char *name)
+{
+	struct l_io *io;
+	struct sockaddr_ll sll;
+	struct packet_mreq mr;
+	struct ifreq ifr;
+	int fd, opt = 1;
+
+	fd = socket(PF_PACKET, SOCK_RAW | SOCK_CLOEXEC | SOCK_NONBLOCK, 0);
+	if (fd < 0) {
+		perror("Failed to create packet socket");
+		return NULL;
+	}
+
+	strncpy(ifr.ifr_name, name, IFNAMSIZ - 1);
+
+	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0) {
+		perror("Failed to get monitor index");
+		close(fd);
+		return NULL;
+	}
+
+	memset(&sll, 0, sizeof(sll));
+	sll.sll_family = AF_PACKET;
+	sll.sll_protocol = htons(ETH_P_ALL);
+	sll.sll_ifindex = ifr.ifr_ifindex;
+
+	if (bind(fd, (struct sockaddr *) &sll, sizeof(sll)) < 0) {
+		perror("Failed to bind packet socket");
+		close(fd);
+		return NULL;
+	}
+
+	memset(&mr, 0, sizeof(mr));
+	mr.mr_ifindex = ifr.ifr_ifindex;
+	mr.mr_type = PACKET_MR_ALLMULTI;
+
+	if (setsockopt(fd, SOL_PACKET, PACKET_ADD_MEMBERSHIP,
+						&mr, sizeof(mr)) < 0) {
+		perror("Failed to enable all multicast");
+		close(fd);
+		return NULL;
+	}
+
+	if (setsockopt(fd, SOL_SOCKET, SO_ATTACH_FILTER,
+					&mon_fprog, sizeof(mon_fprog)) < 0) {
+		perror("Failed to enable monitor filter");
+		close(fd);
+		return NULL;
+	}
+
+	if (setsockopt(fd, SOL_SOCKET, SO_TIMESTAMP, &opt, sizeof(opt)) < 0) {
+		perror("Failed to enable monitor timestamps");
+		close(fd);
+		return NULL;
+	}
+
+	io = l_io_new(fd);
+
+	l_io_set_close_on_destroy(io, true);
+
+	return io;
+}
+
 struct iwmon_interface {
 	char *ifname;
 	bool exists;
 	struct l_netlink *rtnl;
 	struct l_netlink *genl;
+	struct l_io *io;
 };
 
 static struct iwmon_interface monitor_interface = { };
@@ -109,11 +261,23 @@ static void genl_parse(uint16_t type, const void *data, uint32_t len,
 	if (id == 0)
 		return;
 
-	if (!strcmp(name, NL80211_GENL_NAME)) {
-		nlmon = nlmon_open(ifname, id, writer_path, &config);
-		if (!nlmon)
-			l_main_quit();
-	}
+	if (strcmp(name, NL80211_GENL_NAME))
+		return;
+
+	monitor_interface.io = open_packet(ifname);
+	if (!monitor_interface.io)
+		goto failed;
+
+	nlmon = nlmon_open(id, writer_path, &config);
+	if (!nlmon)
+		goto failed;
+
+	l_io_set_read_handler(monitor_interface.io, nlmon_receive, nlmon, NULL);
+
+	return;
+
+failed:
+	l_main_quit();
 }
 
 static void genl_notify(uint16_t type, const void *data,
@@ -790,6 +954,7 @@ int main(int argc, char *argv[])
 
 	exit_status = l_main_run_with_signal(signal_handler, NULL);
 
+	l_io_destroy(monitor_interface.io);
 	l_netlink_destroy(monitor_interface.rtnl);
 	l_netlink_destroy(monitor_interface.genl);
 	l_free(monitor_interface.ifname);
diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 72cd8ca7a05c..5e88cdf1355e 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -96,7 +96,6 @@ enum msg_type {
 
 struct nlmon {
 	uint16_t id;
-	struct l_io *io;
 	struct l_io *pae_io;
 	struct l_queue *req_list;
 	struct pcap *pcap;
@@ -8185,154 +8184,6 @@ void nlmon_print_genl(struct nlmon *nlmon, const struct timeval *tv,
 	}
 }
 
-static bool nlmon_receive(struct l_io *io, void *user_data)
-{
-	struct nlmon *nlmon = user_data;
-	struct msghdr msg;
-	struct sockaddr_ll sll;
-	struct iovec iov;
-	struct cmsghdr *cmsg;
-	struct timeval copy_tv;
-	const struct timeval *tv = NULL;
-	uint16_t proto_type;
-	unsigned char buf[8192];
-	unsigned char control[32];
-	ssize_t bytes_read;
-	int fd;
-
-	fd = l_io_get_fd(io);
-	if (fd < 0)
-		return false;
-
-	memset(&sll, 0, sizeof(sll));
-
-	memset(&iov, 0, sizeof(iov));
-	iov.iov_base = buf;
-	iov.iov_len = sizeof(buf);
-
-	memset(&msg, 0, sizeof(msg));
-	msg.msg_name = &sll;
-	msg.msg_namelen = sizeof(sll);
-	msg.msg_iov = &iov;
-	msg.msg_iovlen = 1;
-	msg.msg_control = control;
-	msg.msg_controllen = sizeof(control);
-
-	bytes_read = recvmsg(fd, &msg, 0);
-	if (bytes_read < 0) {
-		if (errno != EAGAIN && errno != EINTR)
-			return false;
-
-		return true;
-	}
-
-	if (sll.sll_hatype != ARPHRD_NETLINK)
-		return true;
-
-	proto_type = ntohs(sll.sll_protocol);
-
-	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg;
-				cmsg = CMSG_NXTHDR(&msg, cmsg)) {
-		if (cmsg->cmsg_level == SOL_SOCKET &&
-					cmsg->cmsg_type == SCM_TIMESTAMP) {
-			memcpy(&copy_tv, CMSG_DATA(cmsg), sizeof(copy_tv));
-			tv = &copy_tv;
-		}
-	}
-
-	switch (proto_type) {
-	case NETLINK_ROUTE:
-		nlmon_print_rtnl(nlmon, tv, iov.iov_base, bytes_read);
-		break;
-	case NETLINK_GENERIC:
-		nlmon_print_genl(nlmon, tv, iov.iov_base, bytes_read);
-		break;
-	}
-
-	return true;
-}
-
-/*
- * BPF filter to match skb->dev->type == 824 (ARPHRD_NETLINK) and
- * either match skb->protocol == 0x0000 (NETLINK_ROUTE) or match
- * skb->protocol == 0x0010 (NETLINK_GENERIC).
- */
-static struct sock_filter mon_filter[] = {
-	{ 0x28,  0,  0, 0xfffff01c },	/* ldh #hatype		*/
-	{ 0x15,  0,  3, 0x00000338 },	/* jne #824, drop	*/
-	{ 0x28,  0,  0, 0xfffff000 },	/* ldh #proto		*/
-	{ 0x15,  2,  0, 0000000000 },	/* jeq #0x0000, pass	*/
-	{ 0x15,  1,  0, 0x00000010 },	/* jeq #0x0010, pass	*/
-	{ 0x06,  0,  0, 0000000000 },	/* drop: ret #0		*/
-	{ 0x06,  0,  0, 0xffffffff },	/* pass: ret #-1	*/
-};
-
-static const struct sock_fprog mon_fprog = { .len = 7, .filter = mon_filter };
-
-static struct l_io *open_packet(const char *name)
-{
-	struct l_io *io;
-	struct sockaddr_ll sll;
-	struct packet_mreq mr;
-	struct ifreq ifr;
-	int fd, opt = 1;
-
-	fd = socket(PF_PACKET, SOCK_RAW | SOCK_CLOEXEC | SOCK_NONBLOCK, 0);
-	if (fd < 0) {
-		perror("Failed to create packet socket");
-		return NULL;
-	}
-
-	strncpy(ifr.ifr_name, name, IFNAMSIZ - 1);
-
-	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0) {
-		perror("Failed to get monitor index");
-		close(fd);
-		return NULL;
-	}
-
-	memset(&sll, 0, sizeof(sll));
-	sll.sll_family = AF_PACKET;
-	sll.sll_protocol = htons(ETH_P_ALL);
-	sll.sll_ifindex = ifr.ifr_ifindex;
-
-	if (bind(fd, (struct sockaddr *) &sll, sizeof(sll)) < 0) {
-		perror("Failed to bind packet socket");
-		close(fd);
-		return NULL;
-	}
-
-	memset(&mr, 0, sizeof(mr));
-	mr.mr_ifindex = ifr.ifr_ifindex;
-	mr.mr_type = PACKET_MR_ALLMULTI;
-
-	if (setsockopt(fd, SOL_PACKET, PACKET_ADD_MEMBERSHIP,
-						&mr, sizeof(mr)) < 0) {
-		perror("Failed to enable all multicast");
-		close(fd);
-		return NULL;
-	}
-
-	if (setsockopt(fd, SOL_SOCKET, SO_ATTACH_FILTER,
-					&mon_fprog, sizeof(mon_fprog)) < 0) {
-		perror("Failed to enable monitor filter");
-		close(fd);
-		return NULL;
-	}
-
-	if (setsockopt(fd, SOL_SOCKET, SO_TIMESTAMP, &opt, sizeof(opt)) < 0) {
-		perror("Failed to enable monitor timestamps");
-		close(fd);
-		return NULL;
-	}
-
-	io = l_io_new(fd);
-
-	l_io_set_close_on_destroy(io, true);
-
-	return io;
-}
-
 void nlmon_print_pae(struct nlmon *nlmon, const struct timeval *tv,
 					uint8_t type, int index,
 					const void *data, uint32_t size)
@@ -8460,28 +8311,21 @@ static struct l_io *open_pae(void)
 	return io;
 }
 
-struct nlmon *nlmon_open(const char *ifname, uint16_t id, const char *pathname,
+struct nlmon *nlmon_open(uint16_t id, const char *pathname,
 				const struct nlmon_config *config)
 {
 	struct nlmon *nlmon;
-	struct l_io *io, *pae_io;
+	struct l_io *pae_io;
 	struct pcap *pcap;
 
-	io = open_packet(ifname);
-	if (!io)
-		return NULL;
-
 	pae_io = open_pae();
-	if (!pae_io) {
-		l_io_destroy(io);
+	if (!pae_io)
 		return NULL;
-	}
 
 	if (pathname) {
 		pcap = pcap_create(pathname);
 		if (!pcap) {
 			l_io_destroy(pae_io);
-			l_io_destroy(io);
 			return NULL;
 		}
 	} else
@@ -8490,11 +8334,9 @@ struct nlmon *nlmon_open(const char *ifname, uint16_t id, const char *pathname,
 
 	nlmon = nlmon_create(id, config);
 
-	nlmon->io = io;
 	nlmon->pae_io = pae_io;
 	nlmon->pcap = pcap;
 
-	l_io_set_read_handler(nlmon->io, nlmon_receive, nlmon, NULL);
 	l_io_set_read_handler(nlmon->pae_io, pae_receive, nlmon, NULL);
 
 	wlan_iface_list = l_hashmap_new();
@@ -8507,7 +8349,6 @@ void nlmon_close(struct nlmon *nlmon)
 	if (!nlmon)
 		return;
 
-	l_io_destroy(nlmon->io);
 	l_io_destroy(nlmon->pae_io);
 	l_queue_destroy(nlmon->req_list, nlmon_req_free);
 
diff --git a/monitor/nlmon.h b/monitor/nlmon.h
index 96958c25b2ba..bb1a7c58bd45 100644
--- a/monitor/nlmon.h
+++ b/monitor/nlmon.h
@@ -33,7 +33,7 @@ struct nlmon_config {
 	bool read_only;
 };
 
-struct nlmon *nlmon_open(const char *ifname, uint16_t id, const char *pathname,
+struct nlmon *nlmon_open(uint16_t id, const char *pathname,
 				const struct nlmon_config *config);
 void nlmon_close(struct nlmon *nlmon);
 
-- 
2.43.0

