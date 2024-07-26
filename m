Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD18763CB
	for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722033479; cv=none; b=BkEifRw5BC084zidbqO+oTcs9jJeqAiT2KHD+4/aVpgEpmfX5QLGke5h2ZdWTlrg9MD1XURMqxt9RYe6OF+j1QrZlgZzd9mGmNTbL7MJADGCSV64/U1hzoCJTIPq+hxBNRkpt+NTF+ij2XVWnVO2trnIiRdyMhbtZu0dNAuS7sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722033479; c=relaxed/simple;
	bh=klJsN22jHsAkvzgwDk9KmS4RBqYR+l6/Cy4aX/JZuVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uYeXhbfLlbAIziPzHX+jybpE/CBnSuU3sxYvGvY1XzH6Rb/3245zut25j9g6yR8NzDEZfEZme6MdRpJkkkzcezwtIq0UGYL+5C28Vvo5XF6UWCgd3NwNL2C4yGMAA/sN+/DtAlcWwDPAtzhLOcUD6AH817BWMhMrJiyzX2Z9gmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/gLy+yn; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/gLy+yn"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db145c8010so875961b6e.3
        for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 15:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722033477; x=1722638277; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M22Gx1LCi3yrWXnXYGkeHZ8tg/2Eu2sCI+X6K59XQnA=;
        b=J/gLy+yn9ZGM2KYhCsBndp7NJuhD7N3DYiO5DyrJnUPPRwAman7QVxTmcdclY7DQaW
         EgFVI/r8j1qAgov/ovuQVPOxITqyjnPsiWyxETc4dL6XcRJMNo/FiWc1ha5nWr1XpmEc
         nv32n0G9p7Et0SyFtCbnnzu3Z/PQlyJIAMJ2O+TJhjaMCXlxu9aXFSUZwBS1UtN3/oB4
         kZtkNS0Vf4RGBjsC+KGZD5VmBDtziY6GUXWqfGxM3wTuNrLoAUf1MJOatiI6Pmmh6ppc
         5F4EBn1RydEW7Qvm6n4MUl2Urh4AZ+5KI5JdjRdlGMRp2B+saO3B0Z2CTpUGLtIWJ8R/
         7HRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722033477; x=1722638277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M22Gx1LCi3yrWXnXYGkeHZ8tg/2Eu2sCI+X6K59XQnA=;
        b=FWuGHl9sU8tKjbtDQyq81EkMSwpluWJIW7RSoCjykBl80bS7JyF+PvrNt/H2gSLnVt
         yrUDYqnrHGe9dAC8+faB12CkLOu1LGfkVY7ygewMBYNelqk4Zafllv4LCcQ8/Ts/Wfsa
         ta3bkiAUUdTQSwX/u7oZNuY3Ez+ifsxhCva6GiMMS67V0tD8tGv8cnJ/SH/3LNs1NL7F
         dJ4bKkIfUjRd0aKQ0ksyiYnYA0YdDcWcxJB1AP4rVJfr7P2kzugG2ExOFDKhNIWYA20L
         qK2HJp4Q1GYHqc1dtpZGJTmbhp+e1mPkLyUQZUboJIN87F72qmcieVXOwbHujZ6kNkmD
         6Kgg==
X-Gm-Message-State: AOJu0YxMN3AZDMN+i6xuHJaUK+Z/6Bd0RRuN5wW7j9P2bcl+n2LXs0/p
	sfcYmmpBRIU2zfJ+JjMd1jFUrWkyTuL1TuboIvHM4Hd3lvDeMN8ApLK5Qw==
X-Google-Smtp-Source: AGHT+IGEHUIIxaKp7DzlLlWQQ7aPJjF+U+lxcI8TiH0P/CMWtx2QpSQiz9IBbUabvTfiAj8Dki6JLA==
X-Received: by 2002:a05:6808:1701:b0:3d6:2da2:2b4e with SMTP id 5614622812f47-3db2369da3emr1009625b6e.14.1722033476652;
        Fri, 26 Jul 2024 15:37:56 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db13521040sm892574b6e.46.2024.07.26.15.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 15:37:56 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/3] wired: Update to the new l_netlink_send API
Date: Fri, 26 Jul 2024 17:37:43 -0500
Message-ID: <20240726223754.159303-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 wired/ethdev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/wired/ethdev.c b/wired/ethdev.c
index e5353582494e..a933cc18e343 100644
--- a/wired/ethdev.c
+++ b/wired/ethdev.c
@@ -723,7 +723,8 @@ static void setup_adapter_interface(struct l_dbus_interface *interface)
 
 bool ethdev_init(const char *whitelist, const char *blacklist)
 {
-	struct ifinfomsg msg;
+	struct ifinfomsg ifi;
+	struct l_netlink_message *nlm;
 
 	if (rtnl)
 		return false;
@@ -760,10 +761,11 @@ bool ethdev_init(const char *whitelist, const char *blacklist)
 	if (blacklist)
 		blacklist_filter = l_strsplit(blacklist, ',');
 
-	memset(&msg, 0, sizeof(msg));
+	memset(&ifi, 0, sizeof(ifi));
+	nlm = l_netlink_message_new_sized(RTM_GETLINK, NLM_F_DUMP, sizeof(ifi));
+	l_netlink_message_add_header(nlm, &ifi, sizeof(ifi));
 
-	l_netlink_send(rtnl, RTM_GETLINK, NLM_F_DUMP, &msg, sizeof(msg),
-						getlink_callback, NULL, NULL);
+	l_netlink_send(rtnl, nlm, getlink_callback, NULL, NULL);
 
 	return true;
 }
-- 
2.45.2

