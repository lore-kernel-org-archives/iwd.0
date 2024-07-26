Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB0A149E1D
	for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722033480; cv=none; b=P9YoiiRsnoE+L1VMCmcKUhwCcBHbGGod+gfTzeVeAK6Mw1o1n2RW1+wiOy0QfyNYqy6Mlo3u4Dn2BHuqjWyRUwsLQlNNXvlrMOXKhC/YFnpRdxBtii4UTObxCs6YbAfLl7a3NySQi5gPabXuP1EypmzXXQ1U9vBqTd8H1h7SVl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722033480; c=relaxed/simple;
	bh=yMdtlX3sjcnkj9bZoG6+Hcx6Q8ZkAtaWiuOoHPgcRCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+zmjlvQj7vop8ANqy10TuTQvfje8dKywy0dCVhr8i9YBI/YzS/4tdcbr47OjnbHjfQA8cMf5mNmqbaTCAu9WFjgzoeJ5Bhr/J4SEwD8yjPmLME7DkiGL8RX2RZfaFoY7924j1LKkqrNrsxnCjxv1GpjHQQ4NykkGS/x37fWELE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmgyPprv; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmgyPprv"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db1646da25so687205b6e.1
        for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 15:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722033478; x=1722638278; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5aAKMYPoJ5T2PE2UIZ8SxR5MEJeKgUYFDtgCXOQHmQ=;
        b=fmgyPprvlPgG4FqjkAphq/LyEr7PDLaYbLdFE2J3KvtheYxOEMGdHl7ezn8BE2mAc+
         zpzmo9lii9YsiTuHqEeZqUdZ/QAD4j9M0dDXvcAWWmeidkfrp7eHtOav7GfupEryjC4s
         2EWBjEzN6eXtU9Y1QT9fnoKZtQ9KIg6MuI+PoU3nqeJJPvaxwLz7TZ0KbnI4zoTkSpyN
         +FxKUe0+viTRo26HXd3m07ylQ49EIGPvFjmkSp7R+S1JVXSCTHmSmjGxts8titjA5mMw
         sThaNmWrarYMpXCENFpybKzaG4pGXcNQSjsP+BcdsFOlkSSemP78SLlnnlLZJOoZK07N
         y9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722033478; x=1722638278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5aAKMYPoJ5T2PE2UIZ8SxR5MEJeKgUYFDtgCXOQHmQ=;
        b=Qmh/IRE9Hx93fNBV0Nt9qBUFiIDsnvNaIjjym/w+7/u0IhglPcI+VMgyt4OcTT1ywR
         37YE2k5h1wNKNwhikqkvZKPyB3hTOC4DQURJc4bVC+ojDIyu5F7Uw1RkqlYl/dLb6021
         qlkbP8Hk8rYnzQXp2go6c56fIoz7+LZ+p1KMcaLE0WIP0c/mAYKPXk35btXmJOFWJTra
         0flQ8gr+ch4qP2wl4FdCA2enPTsr0Mv4BEggd5R1H+MZA6HdoAW1LQCsw71z3NMjn03L
         y5IBpY9bt7xaCrsc9eEJ4N+vYMWif4eAf0Zplrtep42shgqRrurQi2FK0/icKapEsX23
         ia3A==
X-Gm-Message-State: AOJu0YwzCC7iSqWfMEsOBQKMy7ItvcndDBFJFXUUSdkOkMjwXfaJiIAt
	Z9beWc+cJUc0fDRfLOgbRc+wJ21mskKYigXXz+eYJllmajux/QRxeEYD2w==
X-Google-Smtp-Source: AGHT+IEhm2SxPYq7EnFZH03PyNITloCEvGg3/fwvkgqIA570wPBuWJOY+81bjRqJHXp+m8fEn3vU8A==
X-Received: by 2002:a05:6808:17a7:b0:3d5:1bc8:e979 with SMTP id 5614622812f47-3db23e7ab53mr505479b6e.1.1722033478019;
        Fri, 26 Jul 2024 15:37:58 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db13521040sm892574b6e.46.2024.07.26.15.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 15:37:57 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/3] monitor: Update to the new ell l_netlink_send API
Date: Fri, 26 Jul 2024 17:37:45 -0500
Message-ID: <20240726223754.159303-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726223754.159303-1-denkenz@gmail.com>
References: <20240726223754.159303-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 monitor/main.c | 88 ++++++++++++++------------------------------------
 1 file changed, 24 insertions(+), 64 deletions(-)

diff --git a/monitor/main.c b/monitor/main.c
index 32f5ec4fc7f3..c560db775caa 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -260,22 +260,6 @@ static struct l_genl *genl_lookup(const char *ifname)
 	return genl;
 }
 
-static size_t rta_add(void *rta_buf, unsigned short type, uint16_t len,
-			const void *data)
-{
-	unsigned short rta_len = RTA_LENGTH(len);
-	struct rtattr *rta = rta_buf;
-
-	memset(RTA_DATA(rta), 0, RTA_SPACE(len));
-
-	rta->rta_len = rta_len;
-	rta->rta_type = type;
-	if (len)
-		memcpy(RTA_DATA(rta), data, len);
-
-	return RTA_SPACE(len);
-}
-
 static bool rta_linkinfo_kind(struct rtattr *rta, unsigned short len,
 			const char* kind)
 {
@@ -304,10 +288,9 @@ static struct l_netlink *rtm_interface_send_message(struct l_netlink *rtnl,
 {
 	size_t nlmon_type_len = strlen(NLMON_TYPE);
 	unsigned short ifname_len = 0;
-	size_t bufsize;
-	struct ifinfomsg *rtmmsg;
-	void *rta_buf;
-	struct rtattr *linkinfo_rta;
+	struct l_netlink_message *nlm;
+	struct ifinfomsg ifi;
+	uint16_t flags = 0;
 
 	if (ifname) {
 		ifname_len = strlen(ifname) + 1;
@@ -316,64 +299,41 @@ static struct l_netlink *rtm_interface_send_message(struct l_netlink *rtnl,
 			return NULL;
 	}
 
+	if (!L_IN_SET(rtm_msg_type, RTM_NEWLINK, RTM_DELLINK, RTM_GETLINK))
+		return NULL;
+
 	if (!rtnl)
 		rtnl = l_netlink_new(NETLINK_ROUTE);
 
 	if (!rtnl)
 		return NULL;
 
-	bufsize = NLMSG_LENGTH(sizeof(struct ifinfomsg)) +
-		RTA_SPACE(ifname_len) + RTA_SPACE(0) +
-		RTA_SPACE(nlmon_type_len);
-
-	rtmmsg = l_malloc(bufsize);
-	memset(rtmmsg, 0, bufsize);
-
-	rtmmsg->ifi_family = AF_UNSPEC;
-	rtmmsg->ifi_change = ~0;
-
-	rta_buf = rtmmsg + 1;
-
-	if (ifname)
-		rta_buf += rta_add(rta_buf, IFLA_IFNAME, ifname_len, ifname);
-
-	linkinfo_rta = rta_buf;
-
-	rta_buf += rta_add(rta_buf, IFLA_LINKINFO, 0, NULL);
-	rta_buf += rta_add(rta_buf, IFLA_INFO_KIND, nlmon_type_len, NLMON_TYPE);
-
-	linkinfo_rta->rta_len = rta_buf - (void *) linkinfo_rta;
+	memset(&ifi, 0, sizeof(ifi));
+	ifi.ifi_family = AF_UNSPEC;
+	ifi.ifi_change = ~0;
 
 	switch (rtm_msg_type) {
 	case RTM_NEWLINK:
-		rtmmsg->ifi_flags = IFF_UP | IFF_ALLMULTI | IFF_NOARP;
-
-		l_netlink_send(rtnl, RTM_NEWLINK, NLM_F_CREATE|NLM_F_EXCL,
-				rtmmsg, rta_buf - (void *) rtmmsg, callback,
-				user_data, destroy);
+		ifi.ifi_flags = IFF_UP | IFF_ALLMULTI | IFF_NOARP;
+		flags = NLM_F_CREATE | NLM_F_EXCL;
 		break;
-
-	case RTM_DELLINK:
-		rta_buf += rta_add(rta_buf, IFLA_IFNAME, ifname_len, ifname);
-
-		l_netlink_send(rtnl, RTM_DELLINK, 0, rtmmsg,
-				rta_buf - (void *)rtmmsg, callback, user_data,
-				destroy);
-		break;
-
 	case RTM_GETLINK:
-		l_netlink_send(rtnl, RTM_GETLINK, NLM_F_DUMP, rtmmsg,
-				rta_buf - (void *)rtmmsg, callback, user_data,
-				destroy);
-		break;
-
-	default:
-		l_netlink_destroy(rtnl);
-		rtnl = NULL;
+		flags = NLM_F_DUMP;
 		break;
 	}
 
-	l_free(rtmmsg);
+	nlm = l_netlink_message_new(rtm_msg_type, flags);;
+	l_netlink_message_add_header(nlm, &ifi, sizeof(ifi));
+
+	if (ifname)
+		l_netlink_message_append(nlm, IFLA_IFNAME, ifname, ifname_len);
+
+	l_netlink_message_enter_nested(nlm, IFLA_LINKINFO);
+	l_netlink_message_append(nlm, IFLA_INFO_KIND,
+						NLMON_TYPE, nlmon_type_len);
+	l_netlink_message_leave_nested(nlm);
+
+	l_netlink_send(rtnl, nlm, callback, user_data, destroy);
 
 	return rtnl;
 }
-- 
2.45.2

