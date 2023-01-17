Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92928BFC
	for <iwd@lists.linux.dev>; Tue, 17 Jan 2023 18:03:46 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id d9so34337725pll.9
        for <iwd@lists.linux.dev>; Tue, 17 Jan 2023 10:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JYbtwdpwYMLJNnwWvoUzbEgALROo47zePjKU7qN6Rgc=;
        b=Vw24pjt22RclJdXaAlUfMzSXxehQEgxcFihtDYvmJYx/z4VByrWwhnzzYeQOYFF3zE
         Vgoc00cxWea/SgtI7XXdZxolKJGSb3XjZumcLv4IE0Kf9dGUicrXrY1NhyJw0MTdl4qX
         UijsOpQfIPBdAfd/ZK9Dvs8YKVbEmqdF7jPdqqGjJPh31/JaCTvOZ/Z2m1OYdj4Xfk8w
         yEb4XMl0njCmqwfmlB7IPZ1aQqNaJQO5IGpxbO8zkJ4mlz4Y9Y4G1ucWMh5+KTItMrQZ
         QNREEWH87V8yb+6ayCPhUtaY2DzFvL7l0XZXibr1wvtWItQprwwfPI2xnKqkDcZnMR4b
         VfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYbtwdpwYMLJNnwWvoUzbEgALROo47zePjKU7qN6Rgc=;
        b=sob7xkJ21X9CdDn0Z6BFk8Optj4VUEEUH9yiP47FTVF3NmgB7V3e7jbNXpMH6uXK6L
         p7WYCGa5YW5mBJYFN3CZpZwdPoEnc38XiuXlKkE+STyLjVLY2OWOyS0ZTE4CQdrfWDM8
         nW5svS73bQF2M2RjK9nPyhSSm7xsVUnM8Z8ra9D5SgdaWFHxmdA19RclXU66kQI+MV96
         7U2ovk7PKmDNCKdT86vGsgxQS3gn73alYz5LPCIn6BLsi6aBeUwbqY7CPKbV0Hqtxkr9
         3U3RiGl9ATuUJNTBfpcPdgu7Xkp8X2xs7OJZEq1J0tasQPDMTQjf8xapzIWOTyvUBXaz
         //+A==
X-Gm-Message-State: AFqh2kpUgnouxZs4bTY6XOFfLb+hPJsv6pbhqZVO8nJCUZV02coAvkgO
	xPEn6qBBGhc5fFbp7bjWLIvyzcH45Dk=
X-Google-Smtp-Source: AMrXdXvUR0U+imYABJNQZ55Lwil+ThEjaJxCrnnUWa/ZbmQYp2HVxAKmJ5Dqhu6/jh99CO3kxD4xiQ==
X-Received: by 2002:a05:6a20:c18f:b0:a3:ca9a:ff82 with SMTP id bg15-20020a056a20c18f00b000a3ca9aff82mr4447658pzb.61.1673978625732;
        Tue, 17 Jan 2023 10:03:45 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id d206-20020a621dd7000000b00589ed7ae132sm15235782pfd.13.2023.01.17.10.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 10:03:45 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] wiphy: prevent multiple wiphy registrations
Date: Tue, 17 Jan 2023 10:03:42 -0800
Message-Id: <20230117180343.1451626-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With really badly timed events a wiphy can be registered twice. This
happens when IWD starts and requests a wiphy dump. Immediately after
a NEW_WIPHY event comes in (presumably when the driver loads) which
starts another dump. The NEW_WIPHY event can't simply be ignored
since it could be a hotplug (e.g. USB card) so to fix this we can
instead just prevent it from being registered.

This does mean both dumps will happen but the information will just
be added to the same wiphy object.
---
 src/wiphy.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 9ca651f4..fcdc3ab8 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -2324,6 +2324,15 @@ static void wiphy_get_reg_domain(struct wiphy *wiphy)
 
 void wiphy_create_complete(struct wiphy *wiphy)
 {
+	/*
+	 * With really bad timing two wiphy dumps can occur (initial and a
+	 * NEW_WIPHY event) and actually register twice. Ignoring/preventing the
+	 * second dump is problematic since it _could_ be a legitimate event so
+	 * instead just prevent it from registering twice.
+	 */
+	if (wiphy->registered)
+		return;
+
 	wiphy_register(wiphy);
 
 	if (l_memeqzero(wiphy->permanent_addr, 6)) {
-- 
2.34.3

