Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F765A79C
	for <iwd@lists.linux.dev>; Fri, 26 Jan 2024 23:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311279; cv=none; b=HepqyQ6wyqTNtUY3mQOeR3j46q1MFyYbt7cyAQ/25h/TDlkLXWbSFCVrnEJH3bijqPz6+b41IXCiX7qklbwS0k+I69JTzg6y1XTJaka2Hrcl5QeakAjz4w57HheYxpvfUE4V20prTgdybBQtNZ4JxyopVFMIJWqYqYtTDwRDOhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311279; c=relaxed/simple;
	bh=5IuQh8Sb0vrGFuYwB2rWjsFYBSNcsGaGP0aa2Py7Mcc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nk0p31W/Q2IbkQ2hCDWwD6r0QcU2mLx6jf12/cnc8LmI0bVIDgIdkU3H+O4aPGuMEQfukifGhO0L9ZCzyyZ5vs8MKdShOuagcNUSdlr1x+qh6QGBXkHqGBrfuJ4cVd/CMvAAcyhB1v+D1igD7z4EtFAPX3P3a+0gusRNAvBmv3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from fedora.. (p5b3d2756.dip0.t-ipconnect.de [91.61.39.86])
	by mail.holtmann.org (Postfix) with ESMTPSA id 438E8CECCE
	for <iwd@lists.linux.dev>; Sat, 27 Jan 2024 00:13:42 +0100 (CET)
From: Marcel Holtmann <marcel@holtmann.org>
To: iwd@lists.linux.dev
Subject: [RFC] udev: Add module for checking interface renaming actions
Date: Sat, 27 Jan 2024 00:13:39 +0100
Message-ID: <20240126231339.10388-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Makefile.am |   1 +
 src/udev.c  | 285 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 286 insertions(+)
 create mode 100644 src/udev.c

diff --git a/Makefile.am b/Makefile.am
index 5ed6ab37164b..0a875dcef1a7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -265,6 +265,7 @@ src_iwd_SOURCES = src/main.c linux/nl80211.h src/iwd.h src/missing.h \
 					src/dpp-util.h src/dpp-util.c \
 					src/json.h src/json.c \
 					src/dpp.c \
+					src/udev.c \
 					$(eap_sources) \
 					$(builtin_sources)
 
diff --git a/src/udev.c b/src/udev.c
new file mode 100644
index 000000000000..8baf47246be7
--- /dev/null
+++ b/src/udev.c
@@ -0,0 +1,285 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2024  Intel Corporation. All rights reserved.
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
+#include <errno.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <linux/netlink.h>
+#include <linux/filter.h>
+#include <ell/ell.h>
+
+#include "src/module.h"
+
+static void receive_props(const void *buf, uint32_t len)
+{
+	const char *action = NULL;
+	const char *interface = NULL;
+	const char *ifindex = NULL;
+
+	while (len > 0) {
+		const char *s = buf;
+		size_t l = strlen(s);
+		const char *t;
+
+		if (l < 2)
+			break;
+
+		t = strchr(s, '=');
+		if (t) {
+			size_t p = t - s;
+
+			if (!strncmp(s, "ACTION", p))
+				action = t + 1;
+			else if (!strncmp(s, "INTERFACE", p))
+				interface = t + 1;
+			else if (!strncmp(s, "IFINDEX", p))
+				ifindex = t + 1;
+		}
+
+		buf += l + 1;
+		len -= l + 1;
+	}
+
+	if (action && !strcmp(action, "add"))
+		l_info("udev interface=%s ifindex=%s", interface, ifindex);
+}
+
+static struct l_io *udev_io;
+
+static int create_socket(uint32_t *pid)
+{
+	struct sockaddr_nl addr;
+	socklen_t addrlen = sizeof(addr);
+	int fd, pktinfo = 1;
+
+	fd = socket(PF_NETLINK, SOCK_RAW | SOCK_CLOEXEC | SOCK_NONBLOCK,
+						NETLINK_KOBJECT_UEVENT);
+	if (fd < 0)
+		return -1;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.nl_family = AF_NETLINK;
+
+	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	if (getsockname(fd, (struct sockaddr *) &addr, &addrlen) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	if (setsockopt(fd, SOL_NETLINK, NETLINK_PKTINFO,
+					&pktinfo, sizeof(pktinfo)) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	if (pid)
+		*pid = addr.nl_pid;
+
+	return fd;
+}
+
+static struct sock_filter subsys_filter[] = {
+	{ 0x20,  0,  0, 0x00000008 },	/* ldw #magic	*/
+	{ 0x15,  0,  3, 0xfeedcafe },	/* jne #feedcafe, drop	*/
+	{ 0x20,  0,  0, 0x00000018 },	/* ldw #subsys_hash	*/
+	{ 0x15,  0,  1, 0xa74d3cc8 },	/* jne #net, drop	*/
+	{ 0x06,  0,  0, 0xffffffff },	/* keep: ret #-1	*/
+	{ 0x06,  0,  0, 0000000000 },	/* drop: ret #0		*/
+};
+
+static const struct sock_fprog subsys_fprog = { .len = 6,
+						.filter = subsys_filter };
+
+static bool attach_filter(struct l_io *io)
+{
+	int fd;
+
+	fd = l_io_get_fd(io);
+	if (fd < 0)
+		return false;
+
+	if (setsockopt(fd, SOL_SOCKET, SO_ATTACH_FILTER,
+				&subsys_fprog, sizeof(subsys_fprog)) < 0)
+		return false;
+
+	return true;
+}
+
+static bool add_membership(struct l_io *io, uint32_t group)
+{
+	int fd, value = group;
+
+	fd = l_io_get_fd(io);
+	if (fd < 0)
+		return false;
+
+	if (setsockopt(fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP,
+						&value, sizeof(value)) < 0)
+		return false;
+
+	return true;
+}
+
+static bool drop_membership(struct l_io *io, uint32_t group)
+{
+	int fd, value = group;
+
+	fd = l_io_get_fd(io);
+	if (fd < 0)
+		return false;
+
+	if (setsockopt(fd, SOL_NETLINK, NETLINK_DROP_MEMBERSHIP,
+						&value, sizeof(value)) < 0)
+		return false;
+
+	return true;
+}
+
+static const uint8_t LIBUDEV_PREFIX[8] = { "libudev" };
+static uint32_t LIBUDEV_MAGIC = 0xfeedcafe;
+
+struct udev_hdr {
+	char prefix[8];
+	uint32_t magic;
+	uint32_t hdr_size;
+	uint32_t props_off;
+	uint32_t props_len;
+	uint32_t flt_subsys_hash;
+	uint32_t flt_devtype_hash;
+	uint32_t flt_tag_bloom_hi;
+	uint32_t flt_tag_bloom_lo;
+};
+
+static void receive_msg(const void *buf, uint32_t len)
+{
+	const struct udev_hdr *hdr = buf;
+
+	if (len < sizeof(struct udev_hdr))
+		return;
+
+	if (memcmp(hdr->prefix, LIBUDEV_PREFIX, 8))
+		return;
+
+	if (L_BE32_TO_CPU(hdr->magic) != LIBUDEV_MAGIC)
+		return;
+
+	if (hdr->hdr_size > len)
+		return;
+
+	if (hdr->props_off + hdr->props_len != len)
+		return;
+
+	receive_props(buf + hdr->props_off, hdr->props_len);
+}
+
+enum {
+	GROUP_NONE,
+	GROUP_KERNEL,
+	GROUP_UDEV,
+};
+
+static bool can_read_data(struct l_io *io, void *user_data)
+{
+	struct cmsghdr *cmsg;
+	struct msghdr msg;
+	struct iovec iov;
+	unsigned char buffer[4096];
+	unsigned char control[32];
+	uint32_t group = GROUP_NONE;
+	ssize_t len;
+	int fd;
+
+	memset(buffer, 0, sizeof(buffer));
+	memset(control, 0, sizeof(control));
+
+	fd = l_io_get_fd(io);
+
+	iov.iov_base = buffer;
+	iov.iov_len = sizeof(buffer);
+
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = control;
+	msg.msg_controllen = sizeof(control);
+
+	len = recvmsg(fd, &msg, 0);
+	if (len < 0)
+		return false;
+
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL;
+					cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		struct nl_pktinfo *pktinfo;
+
+		if (cmsg->cmsg_level != SOL_NETLINK)
+			continue;
+
+		if (cmsg->cmsg_type != NETLINK_PKTINFO)
+			continue;
+
+		pktinfo = (void *) CMSG_DATA(cmsg);
+		group = pktinfo->group;
+	}
+
+	if (group == GROUP_UDEV)
+		receive_msg(buffer, len);
+
+	return true;
+}
+
+static int udev_init(void)
+{
+	int fd;
+
+	l_debug("");
+
+	fd = create_socket(NULL);
+	if (fd < 0)
+		return -EIO;
+
+	udev_io = l_io_new(fd);
+	l_io_set_close_on_destroy(udev_io, true);
+	l_io_set_read_handler(udev_io, can_read_data, NULL, NULL);
+	attach_filter(udev_io);
+	add_membership(udev_io, GROUP_UDEV);
+
+	return 0;
+}
+
+static void udev_exit(void)
+{
+	l_debug("");
+
+	drop_membership(udev_io, GROUP_UDEV);
+	l_io_destroy(udev_io);
+}
+
+IWD_MODULE(udev, udev_init, udev_exit);
+IWD_MODULE_DEPENDS(udev, netdev);
-- 
2.43.0

