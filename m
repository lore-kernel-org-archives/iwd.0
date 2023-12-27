Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFDE5220
	for <iwd@lists.linux.dev>; Wed, 27 Dec 2023 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGrYOWW5"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bbb78d0eb3so1019991b6e.0
        for <iwd@lists.linux.dev>; Tue, 26 Dec 2023 22:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703657442; x=1704262242; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/d10K26YbqkH9HzKw87u2qkJMRbAsTQg4ozYxl/5lE=;
        b=dGrYOWW5jTEl5104jc5bRiOSzoThsuzIOf5zeGOEzCz4EgLQ7ikJpOVce++jeuzLGA
         uXghGmT4KzvrRymg69QKYsMKuXfeCjnKDgDR59aF5qHfcSTdZrQ2aeD4F2OsF1hKO6J/
         AXKNLtSBJvy5qa15o6Umiz2ZDMcC9jZZcnYsCEytRP58F2hRdZBtJJEL4UbS6/lakcaQ
         tC1USM1aHMRDZcfkEz4lFVGR6dR/uzF5VJF8FLi+aXFpGeNVLlKWfQqBpQ/DDwJ40+ai
         RKZqqVF28qHojy82L0C6yxjsFAYBdyfo39TXusX8GErxYi8wKvo+yU9J2xMiGDyL8daS
         wfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703657442; x=1704262242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/d10K26YbqkH9HzKw87u2qkJMRbAsTQg4ozYxl/5lE=;
        b=uo0n1I1n2I4LQkvXvBboyP/LrUqkGXZMXNrVU0M9vY6IGcjJjPBBpaJhl2p/WHu5e0
         iEZDOpeYeZi8+HXQJbUmFTrLhZ14wRM2GgVMZFTTlG0EmshnQ0MmCVpk9RWSDWtw7nij
         0jlL3CkelMfOmHbENy09gtIvgjJi4cEt/IU1eD9/Lqj1YdTYrOTrSbXCMLZGQWLiOhrm
         m1bbfnqGEhL0pqmL0Xl1fUxc+NJW3KFNTWLfMbsu3EV51BM4acf3IM240deuWIjzIkWP
         vzAfxY/OBVgPTkVcOoLNlb0ojoedxCBIYOX9uZkfBds+ZSUvRCCbSYCyw+7aaNj3FGZR
         SgBA==
X-Gm-Message-State: AOJu0YzaQEKmyUt2nfVlHnO3Q0u6wRqHWoFbix8yVdDVuHCbcRlBYVY4
	5N1c5GcpAf+uy8rV5wSNfYhH56T/S6A=
X-Google-Smtp-Source: AGHT+IGy53GstL+3Jv3MryC3qR99IQ2vmrUylGhYdAeXKTgKbQYRZ2XDHLPDrnCvTqIszrq9eNfe3w==
X-Received: by 2002:a05:6870:1610:b0:203:bb03:15d0 with SMTP id b16-20020a056870161000b00203bb0315d0mr9085202oae.9.1703657442115;
        Tue, 26 Dec 2023 22:10:42 -0800 (PST)
Received: from localhost.localdomain (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.gmail.com with ESMTPSA id vs7-20020a056871a10700b002032bb7895fsm3048841oab.55.2023.12.26.22.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 22:10:41 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/5] monitor: Use nlmon_print_* inside nlmon_receive
Date: Wed, 27 Dec 2023 00:09:48 -0600
Message-ID: <20231227060954.103572-3-denkenz@gmail.com>
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

The current implementation inside nlmon_receive is asymmetrical.  RTNL
packets are printed using nlmon_print_rtnl while GENL packets are
printed using nlmon_message.

nlmon_print_genl and nlmon_print_rtnl already handle iterating over data
containing multiple messages, and are used by nlmon started in reader
mode.  Use these for better symmetry inside nlmon_receive.

While here, move store_netlink() call into nlmon_print_rtnl.  This makes
handling of PCAP output symmetrical for both RTNL and GENL packets.
This also fixes a possibility where only the first message of a
multi-RTNL packet would be stored.
---
 monitor/nlmon.c | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index b4d1f54c7579..72cd8ca7a05c 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -7280,12 +7280,6 @@ static void nlmon_message(struct nlmon *nlmon, const struct timeval *tv,
 		return;
 	}
 
-	if (!nlmon->read && nlmsg->nlmsg_type != nlmon->id) {
-		if (nlmsg->nlmsg_type == GENL_ID_CTRL)
-			store_message(nlmon, tv, nlmsg);
-		return;
-	}
-
 	if (nlmsg->nlmsg_flags & NLM_F_REQUEST) {
 		const struct genlmsghdr *genlmsg = NLMSG_DATA(nlmsg);
 		uint32_t flags = nlmsg->nlmsg_flags & ~NLM_F_REQUEST;
@@ -8137,13 +8131,15 @@ void nlmon_print_rtnl(struct nlmon *nlmon, const struct timeval *tv,
 	int64_t aligned_size = NLMSG_ALIGN(size);
 	const struct nlmsghdr *nlmsg;
 
-	if (nlmon->nortnl)
-		return;
-
 	update_time_offset(tv);
 
 	for (nlmsg = data; NLMSG_OK(nlmsg, aligned_size);
 				nlmsg = NLMSG_NEXT(nlmsg, aligned_size)) {
+		store_netlink(nlmon, tv, NETLINK_ROUTE, nlmsg);
+
+		if (nlmon->nortnl)
+			continue;
+
 		switch (nlmsg->nlmsg_type) {
 		case NLMSG_NOOP:
 		case NLMSG_OVERRUN:
@@ -8177,7 +8173,12 @@ void nlmon_print_genl(struct nlmon *nlmon, const struct timeval *tv,
 
 	for (nlmsg = data; NLMSG_OK(nlmsg, size);
 				nlmsg = NLMSG_NEXT(nlmsg, size)) {
-		if (nlmsg->nlmsg_type == GENL_ID_CTRL)
+		if (nlmsg->nlmsg_type == GENL_ID_CTRL) {
+			store_message(nlmon, tv, nlmsg);
+			continue;
+		}
+
+		if (!nlmon->read && nlmsg->nlmsg_type != nlmon->id)
 			continue;
 
 		nlmon_message(nlmon, tv, nlmsg);
@@ -8187,7 +8188,6 @@ void nlmon_print_genl(struct nlmon *nlmon, const struct timeval *tv,
 static bool nlmon_receive(struct l_io *io, void *user_data)
 {
 	struct nlmon *nlmon = user_data;
-	struct nlmsghdr *nlmsg;
 	struct msghdr msg;
 	struct sockaddr_ll sll;
 	struct iovec iov;
@@ -8198,7 +8198,6 @@ static bool nlmon_receive(struct l_io *io, void *user_data)
 	unsigned char buf[8192];
 	unsigned char control[32];
 	ssize_t bytes_read;
-	int64_t nlmsg_len;
 	int fd;
 
 	fd = l_io_get_fd(io);
@@ -8241,20 +8240,13 @@ static bool nlmon_receive(struct l_io *io, void *user_data)
 		}
 	}
 
-	nlmsg_len = bytes_read;
-
-	for (nlmsg = iov.iov_base; NLMSG_OK(nlmsg, nlmsg_len);
-				nlmsg = NLMSG_NEXT(nlmsg, nlmsg_len)) {
-		switch (proto_type) {
-		case NETLINK_ROUTE:
-			store_netlink(nlmon, tv, proto_type, nlmsg);
-
-			nlmon_print_rtnl(nlmon, tv, nlmsg, nlmsg->nlmsg_len);
-			break;
-		case NETLINK_GENERIC:
-			nlmon_message(nlmon, tv, nlmsg);
-			break;
-		}
+	switch (proto_type) {
+	case NETLINK_ROUTE:
+		nlmon_print_rtnl(nlmon, tv, iov.iov_base, bytes_read);
+		break;
+	case NETLINK_GENERIC:
+		nlmon_print_genl(nlmon, tv, iov.iov_base, bytes_read);
+		break;
 	}
 
 	return true;
-- 
2.43.0

