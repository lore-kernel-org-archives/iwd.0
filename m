Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252C74692
	for <iwd@lists.linux.dev>; Tue,  9 Aug 2022 18:48:11 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id t22-20020a17090a449600b001f617f2bf3eso1968686pjg.0
        for <iwd@lists.linux.dev>; Tue, 09 Aug 2022 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=S83bHbQkbEyob9gsd/CcdExvFxSxfKJvdCDiIWCzmPE=;
        b=enPf3C3QFRMAJpIodTHmYhBX5lalksFeEBpBbay9ORRiP3Meq52uku+GuFvRGVvQyI
         BeNwcdH/PqxzISHdBYeO5Hp9+FwxGKEi1u9jEetZ23BVyY3FwVn+fUs7s+xS6OsPQc6v
         VaSeIN0V7AyWyzfsNIVTYogbIJthbzpsmvinwTxjhmGONs6aZuw+kNou2YWlLGgZpv7S
         zqQT7pGlBwD9zM2RGDiGBLoqtMsJMrabMPmKtVDi5n1qSsL/VZPXtQfwB936M0CHZxmm
         frs3tc1HX4tftYSh1IJBuikiKEnUOzv5BmjAu5RezvsrZHnl0IO3M+i7eKlSafmjmR5t
         H6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=S83bHbQkbEyob9gsd/CcdExvFxSxfKJvdCDiIWCzmPE=;
        b=8GrNA3Qvw/zrfL/wfw1JMzTgFtie4DvO82AFholu8dorx+KWzZeXDXE/YbrBMbChTn
         9JqOewoctr8qDxIJ0VwxTr6zEz2VjmvUAW29evcK4lyXhT4B3PFzxwUA8tP9Ev6bBPGd
         kcl86eoKSWswnguGosg96dOOa23apkFJWBoreonwH+hqwnZlp0i0JDlF3SPXjgc4P2Cf
         mvbAbanYtHXHx2QpKHYmii++cfDPBTi77erbxcHygbiE6wcTsOiA/4NT7NfEndeMGrv8
         rOkEHZSxcEdWgtZOlE8YD52eztLI9x0RshD0gSLtkeQF7AuBqHTQH32jrTu2rcc4soz7
         azNA==
X-Gm-Message-State: ACgBeo290Oy8IQu7AggeN1SO5i176R96wE/CUX/08aTHfci2e8MdbGDZ
	DC+Jdy5fKvgNzhdZl867aVh9oq2aHDc=
X-Google-Smtp-Source: AA6agR46OZC5nQl2aDBSIIeHZ5YYsrDh9gt8Q5zRj1a7O+vKziewsuV4kDdh0qmtv+lI+1Oyw2oN2w==
X-Received: by 2002:a17:903:1c5:b0:16e:e892:fa14 with SMTP id e5-20020a17090301c500b0016ee892fa14mr23897680plh.158.1660070890340;
        Tue, 09 Aug 2022 11:48:10 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b0016a0bf0ce32sm11403157plg.70.2022.08.09.11.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:48:10 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] monitor: print out type of unknown element
Date: Tue,  9 Aug 2022 11:48:06 -0700
Message-Id: <20220809184807.147780-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220809184807.147780-1-prestwoj@gmail.com>
References: <20220809184807.147780-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This changes the string from "Reserved" to "Unknown" which feels
more fitting, and also prints out the NL type of the unknown
element.
---
 monitor/nlmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index cb1097fa..d7327abb 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -6741,7 +6741,7 @@ static void print_attributes(int indent, const struct attr_entry *table,
 		int64_t val_s64;
 		uint8_t *ptr;
 
-		str = "Reserved";
+		str = "Unknown";
 		type = ATTR_UNSPEC;
 		array_type = ATTR_UNSPEC;
 		nested = NULL;
@@ -6761,7 +6761,7 @@ static void print_attributes(int indent, const struct attr_entry *table,
 
 		switch (type) {
 		case ATTR_UNSPEC:
-			print_attr(indent, "%s: len %u", str,
+			print_attr(indent, "%s: %u len %u", str, nla_type,
 						NLA_PAYLOAD(nla));
 			print_hexdump(indent + 1,
 					NLA_DATA(nla), NLA_PAYLOAD(nla));
-- 
2.34.3

